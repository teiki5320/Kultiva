// Sort les phrases du reste du contenu, pour les faire traduire.
//
// Maladies, badges, défis, lexique, familles botaniques, conseils
// canicule et conseils d'achat au marché : environ 8 600 mots, le
// dernier tiers après les recettes et les tutos.
//
// Comme `exporter_recettes.dart`, cet outil **importe** les données au
// lieu de lire le Dart : pas d'expression régulière, donc pas de casse
// sur une apostrophe.
//
// ⚠️ Il tourne sous `flutter test` et non `dart run` : les badges et
// les défis passent par `vegetable_medal.dart`, qui importe Flutter.
//
// Usage :
//   echo es > build/traduction/LANGUE   # facultatif, défaut: en
//   flutter test tool/exporter_contenu.dart
//
// Il affiche le compte par bloc et écrit le squelette dans
// `build/traduction/contenu_<langue>.dart`, la langue venant du
// fichier `build/traduction/LANGUE` (anglais par défaut).

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../lib/data/badges.dart';
import '../lib/data/challenges.dart';
import '../lib/data/diseases.dart';
import '../lib/data/lexicon.dart';
import '../lib/data/market_buying_tips.dart';
import '../lib/data/rotation.dart';
import '../lib/models/vegetable.dart';
import '../lib/utils/heatwave_tips.dart';

/// Les phrases à traduire, par bloc, dans l'ordre d'apparition et sans
/// doublon.
Map<String, List<String>> _blocs() {
  final out = <String, List<String>>{};

  void ajoute(String bloc, Iterable<String?> phrases) {
    final liste = out.putIfAbsent(bloc, () => <String>[]);
    for (final p in phrases) {
      if (p == null) continue;
      final t = p.trim();
      if (t.isNotEmpty && !liste.contains(t)) liste.add(t);
    }
  }

  ajoute('maladies', <String>[
    for (final liste in diseaseMap.values)
      for (final d in liste) ...<String>[d.name, d.remedy],
  ]);

  ajoute('badges', <String>[
    for (final b in allBadges) ...<String>[b.name, b.description],
  ]);

  ajoute('defis', <String?>[
    for (final c in allChallenges) ...<String?>[
      c.name,
      c.description,
      c.waName,
      c.waDescription,
    ],
  ]);

  ajoute('lexique', <String>[
    for (final e in lexicon) ...<String>[e.term, e.definition],
  ]);

  ajoute('familles', <String>[
    for (final r in rotationMap.values) r.family,
  ]);

  ajoute('canicule', <String>[
    for (final c in VegetableCategory.values) heatwaveTipFor(c),
  ]);

  ajoute('achat_marche', <String>[
    for (final liste in marketBuyingTips.values)
      for (final t in liste) ...<String>[t.what, t.advice],
  ]);

  return out;
}

String _esc(String s) =>
    s.replaceAll('\\', '\\\\').replaceAll('\'', '\\\'').replaceAll('\$', '\\\$');

void main() {
  test('exporte le contenu à traduire', _exporte);
}

void _exporte() {
  // Ni l'environnement du shell ni --dart-define n'atteignent
  // l'isolat de test de façon fiable. La langue se lit donc dans un
  // fichier, que l'appelant écrit juste avant :
  //
  //   mkdir -p build/traduction && echo es > build/traduction/LANGUE
  //   echo es > build/traduction/LANGUE   # facultatif, défaut: en
//   flutter test tool/exporter_contenu.dart
  //
  // Sans ce fichier, c'est l'anglais, comme avant.
  final marqueur = File('build/traduction/LANGUE');
  final langue =
      marqueur.existsSync() ? marqueur.readAsStringSync().trim() : 'en';
  const String? filtre = null;
  final sortie = 'build/traduction/contenu_$langue.dart';
  final blocs = _blocs();

  {
    var cles = 0;
    var mots = 0;
    blocs.forEach((nom, liste) {
      final m = liste.fold<int>(0, (n, p) => n + p.split(' ').length);
      cles += liste.length;
      mots += m;
      stdout.writeln('  ${nom.padRight(16)} ${liste.length.toString().padLeft(4)} '
          'phrases  ${m.toString().padLeft(5)} mots');
    });
    stdout.writeln('\n  total : $cles phrases, $mots mots');
  }

  final out = StringBuffer();
  out.writeln('// Contenu de Kultiva à traduire en « $langue ».');
  out.writeln('//');
  out.writeln('// Remplace chaque \'\' par la traduction. Le français est la');
  out.writeln('// clé, à gauche du `:` — ne le touche pas : si tu le modifies,');
  out.writeln('// la traduction ne sera jamais trouvée et la phrase restera en');
  out.writeln('// français, sans que rien n\'échoue.');
  out.writeln('//');
  out.writeln('// ⚠️ Les nombres ne se traduisent pas : « 3-4 ans » reste');
  out.writeln('//    « 3-4 years », « 10% de lait » reste « 10% ». Ce sont des');
  out.writeln('//    conseils de jardinage, pas du style. Un test le vérifie.');
  out.writeln('//');
  out.writeln('// Une clé laissée vide reste en français.');
  out.writeln();

  blocs.forEach((nom, liste) {
    if (filtre != null && nom != filtre) return;
    final mots = liste.fold<int>(0, (n, p) => n + p.split(' ').length);
    out.writeln('  // ─── $nom (${liste.length} phrases, $mots mots) ───');
    for (final p in liste) {
      out.writeln('  \'${_esc(p)}\':');
      out.writeln('      \'\',');
    }
    out.writeln();
  });
  File(sortie).parent.createSync(recursive: true);
  File(sortie).writeAsStringSync(out.toString());
  stdout.writeln('\n  Squelette écrit dans $sortie');
}
