import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/ui_i18n.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

/// Ce qui garde la traduction de l'interface honnête.
///
/// 541 chaînes réparties dans 53 fichiers de code, clés par la phrase
/// française elle-même. Quatre choses peuvent mal tourner, et les
/// trois premières sont silencieuses :
///
/// 1. **une clé orpheline** — une phrase qu'aucun appel `trUi()` ne
///    demande plus, parce que le français a été corrigé ou l'écran
///    réécrit. La traduction ne s'afficherait jamais ;
/// 2. **un trou perdu** — `'{0} légumes'` traduit en `'vegetables'`
///    fait disparaître le nombre. L'écran affiche « vegetables » sans
///    rien devant, et rien n'échoue ;
/// 3. **un nombre qui bouge** — les seuils de canicule, les jours
///    d'arrosage, les années de rotation sont des conseils ;
/// 4. **une chaîne non branchée** — elle reste en français sous une
///    interface anglaise. Celle-là se voit, au moins.
///
/// ⚠️ Ces tests n'appellent jamais `trUi()` sans langue : en test
/// l'environnement tourne en `en-US`, donc `trUi()` lirait de l'anglais
/// en croyant lire du français. Ils passent par `trUiIn`.
void main() {
  /// Toutes les clés réellement demandées par le code, lues dans les
  /// appels `trUi(` / `trUiArgs(` — la même source que l'exportateur.
  ///
  /// On relit le code plutôt que de tenir une liste à la main : une
  /// liste se périme au premier écran réécrit, et c'est exactement le
  /// genre d'écart que ce test existe pour attraper.
  final demandees = <String>{};
  final nonLitterales = <String>[];

  void scanne(Directory d) {
    for (final e in d.listSync()) {
      if (e is Directory) {
        if (e.path.endsWith('/l10n') || e.path.endsWith('/data')) continue;
        scanne(e);
      } else if (e is File && e.path.endsWith('.dart')) {
        final src = e.readAsStringSync();
        for (final appel in <String>['trUiArgs(', 'trUi(']) {
          var i = 0;
          while (true) {
            final k = src.indexOf(appel, i);
            if (k < 0) break;
            i = k + appel.length;
            final avant = k > 0 ? src[k - 1] : ' ';
            if (RegExp(r'[A-Za-z0-9_]').hasMatch(avant)) continue;
            // Un commentaire qui cite `trUi()` n'est pas un appel.
            final debutLigne = src.lastIndexOf('\n', k) + 1;
            final commentaire = src.indexOf('//', debutLigne);
            if (commentaire >= 0 && commentaire < k) continue;
            final cle = _litChaineCollee(src, i);
            if (cle == null) {
              nonLitterales.add('${e.path}:$k');
            } else {
              demandees.add(cle);
            }
          }
        }
      }
    }
  }

  scanne(Directory('lib'));

  /// Les libellés qui vivent dans un champ d'enum `const`.
  ///
  /// `Country.label`, `Country.capitalName` et `Region.label` sont des
  /// `final String` remplis par un constructeur `const` : ils ne
  /// peuvent pas appeler de fonction. Ils sont donc traduits par un
  /// getter, `trUi(label)`, ce que le scan de littérales ne voit pas.
  /// On les lit **dans l'enum**, ce qui est exact par construction.
  demandees.addAll(<String>[
    for (final r in Region.values) r.label,
    for (final c in Country.values) ...<String>[c.label, c.capitalName],
  ]);

  List<String> nombres(String texte) => RegExp(r'\d+(?:[.,]\d+)?')
      .allMatches(texte)
      .map((m) => m.group(0)!.replaceAll(',', '.'))
      .toList(growable: false);

  Set<String> trous(String texte) => RegExp(r'\{(\d+)\}')
      .allMatches(texte)
      .map((m) => m.group(0)!)
      .toSet();

  test('le code demande bien des chaînes à traduire', () {
    // Si ce nombre s'effondre, c'est qu'un lot de branchement a été
    // perdu dans un merge.
    expect(demandees.length, greaterThan(300),
        reason: '${demandees.length} clés demandées par le code.');
  });

  test('seuls les getters d\'enum passent autre chose qu\'une littérale',
      () {
    // `trUi(variable)` ne peut pas être traduit depuis le code source :
    // la clé n'existe qu'à l'exécution. Trois le font exprès, et ce
    // sont les seuls tolérés — les getters des enums `const`, dont les
    // clés sont lues dans l'enum juste au-dessus.
    const tolere = <String>[
      'lib/models/country.dart',
      'lib/models/region_data.dart',
    ];
    final inattendus = nonLitterales
        .where((s) => !tolere.any(s.startsWith))
        .toList();
    expect(inattendus, isEmpty,
        reason: 'Ces appels passent autre chose qu\'une chaîne '
            'littérale, donc leur clé est inconnue à la lecture du '
            'code :\n  ${inattendus.join('\n  ')}');
  });

  test('aucune clé traduite n\'est orpheline', () {
    uiTextsByLanguage.forEach((langue, dico) {
      final orphelines =
          dico.keys.where((c) => !demandees.contains(c)).toList();
      expect(orphelines, isEmpty,
          reason: '« $langue » traduit ${orphelines.length} phrases '
              'qu\'aucun appel trUi() ne demande :\n'
              '  ${orphelines.take(10).join('\n  ')}\n'
              'Français corrigé depuis, ou écran réécrit ? Telle '
              'quelle, cette traduction ne servira jamais.');
    });
  });

  test('les trous de la traduction sont ceux du français', () {
    uiTextsByLanguage.forEach((langue, dico) {
      dico.forEach((fr, tr) {
        if (tr.isEmpty) return;
        expect(trous(tr), trous(fr),
            reason: '$langue · les trous ne correspondent plus.\n'
                '  FR : $fr\n'
                '  $langue : $tr\n'
                'Un trou oublié fait disparaître la valeur calculée : '
                'l\'écran affiche la phrase sans son nombre, et rien '
                'n\'échoue.');
      });
    });
  });

  test('les nombres d\'une traduction sont ceux du français', () {
    uiTextsByLanguage.forEach((langue, dico) {
      dico.forEach((fr, tr) {
        if (tr.isEmpty) return;
        // Les trous portent un chiffre qui n'est pas une valeur :
        // {0} n'est pas « zéro ».
        String sansTrous(String s) => s.replaceAll(RegExp(r'\{\d+\}'), '');
        expect(nombres(sansTrous(tr)), nombres(sansTrous(fr)),
            reason: '$langue · les nombres ont bougé.\n'
                '  FR : $fr\n'
                '  $langue : $tr\n'
                'Seuils de canicule, jours d\'arrosage et années de '
                'rotation se recopient : ce sont des conseils.');
      });
    });
  });

  test('aucune traduction n\'est vide', () {
    uiTextsByLanguage.forEach((langue, dico) {
      for (final e in dico.entries) {
        expect(e.value, isNotEmpty, reason: '$langue · vide : ${e.key}');
      }
    });
  });

  test('le français et une langue inconnue ressortent inchangés', () {
    const phrase = 'Semer';
    expect(trUiIn(phrase, 'fr'), phrase);
    expect(trUiIn(phrase, 'de'), phrase);
  });

  test('une phrase non traduite retombe sur le français', () {
    const inventee = 'Cette phrase n\'est dans aucun dictionnaire.';
    expect(trUiIn(inventee, 'en'), inventee);
  });

  test('les trous reçoivent leur valeur', () {
    expect(trUiArgsIn('{0} sur {1}', <Object?>[2, 5], 'fr'), '2 sur 5');
    // Et dans l'ordre de la langue d'arrivée, pas celui du français :
    // c'est tout l'intérêt d'un trou plutôt que d'une concaténation.
    expect(trUiArgsIn('{0} sur {1}', <Object?>[2, 5], 'xx'), '2 sur 5');
  });

  test('chaque langue couvre tout ce que le code demande', () {
    // Verrou de couverture. Une langue enregistrée est une langue
    // finie : à moitié traduite, l'app panache le français et
    // l'anglais dans la même phrase.
    uiTextsByLanguage.forEach((langue, dico) {
      final manquantes =
          demandees.where((c) => !dico.containsKey(c)).toList();
      expect(manquantes, isEmpty,
          reason: '${manquantes.length} chaînes d\'interface sans '
              'traduction « $langue ». Régénère le squelette : '
              'python3 tool/exporter_interface.py --squelette '
              '--langue=$langue\n  ${manquantes.take(10).join('\n  ')}');
    });
  });
}

/// Lit une suite de littérales Dart adjacentes, comme le compilateur
/// les colle. Rend null si `i` n'ouvre pas une chaîne simple.
String? _litChaineCollee(String src, int i) {
  final morceaux = <String>[];
  var j = i;
  while (true) {
    while (j < src.length && ' \t\n\r'.contains(src[j])) {
      j++;
    }
    if (j >= src.length || (src[j] != '\'' && src[j] != '"')) break;
    final q = src[j];
    if (j + 3 <= src.length && src.substring(j, j + 3) == q * 3) break;
    final out = StringBuffer();
    var k = j + 1;
    var ferme = false;
    while (k < src.length) {
      final c = src[k];
      if (c == '\\') {
        final n = k + 1 < src.length ? src[k + 1] : '';
        out.write(const <String, String>{
              'n': '\n',
              't': '\t',
              'r': '\r',
            }[n] ??
            n);
        k += 2;
        continue;
      }
      if (c == q) {
        ferme = true;
        k++;
        break;
      }
      if (c == '\n') break;
      out.write(c);
      k++;
    }
    if (!ferme) break;
    morceaux.add(out.toString());
    j = k;
  }
  return morceaux.isEmpty ? null : morceaux.join();
}
