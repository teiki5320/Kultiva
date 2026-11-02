import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/tutos_i18n.dart';

/// Ce qui garde la traduction des tutos honnête.
///
/// Les 34 tutos ne sont **jamais modifiés** : leur traduction est un
/// dictionnaire injecté au chargement, et la clé est la phrase
/// française elle-même. Deux choses peuvent donc mal tourner :
///
/// 1. **une clé qui ne correspond à aucun tuto** — faute de frappe, ou
///    phrase française corrigée depuis. La traduction ne s'afficherait
///    jamais, sans que rien n'échoue : du travail perdu en silence ;
/// 2. **un nombre qui bouge** — « 100 °C » devenu « 212 °F », « 3 % »
///    devenu « 2 % ». Les tutos de conservation portent les mêmes
///    règles sanitaires que les recettes.
void main() {
  /// Le texte de chaque tuto, espaces normalisés, pour y chercher une
  /// clé. On lit le fichier brut : il suffit de savoir si la phrase
  /// française s'y trouve encore.
  /// Les entités HTML que l'extracteur décode à la lecture : il faut
  /// les décoder ici aussi, sinon « Défis & badges » est introuvable
  /// dans un fichier qui écrit « Défis &amp; badges ».
  String lisible(String html) => html
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', '\'')
      .replaceAll('&rsquo;', '\u2019')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>');

  final tutos = <String, String>{
    for (final f in Directory('assets/tutos').listSync().whereType<File>())
      if (f.path.endsWith('.html'))
        f.uri.pathSegments.last: lisible(f.readAsStringSync()),
  };

  List<String> nombres(String texte) => RegExp(r'\d+(?:[.,]\d+)?')
      .allMatches(texte)
      .map((m) => m.group(0)!.replaceAll(',', '.'))
      .toList(growable: false);

  test('les 33 tutos sont bien là', () {
    // 34 fichiers, dont la politique de confidentialité.
    expect(tutos.length, 34);
  });

  test('chaque clé traduite existe encore dans un tuto', () {
    tutoTextsByLanguage.forEach((langue, dico) {
      for (final cle in dico.keys) {
        final trouve = tutos.values.any((h) => h.contains(cle));
        expect(trouve, isTrue,
            reason: '« $langue » traduit une phrase qu\'aucun tuto ne '
                'contient :\n  $cle\n'
                'Faute de frappe, ou phrase française corrigée depuis ? '
                'Telle quelle, cette traduction ne s\'affichera jamais.');
      }
    });
  });

  test('les nombres d\'une traduction sont ceux du français', () {
    tutoTextsByLanguage.forEach((langue, dico) {
      dico.forEach((fr, tr) {
        if (tr.isEmpty) return;
        expect(nombres(tr), nombres(fr),
            reason: '$langue · les nombres ont bougé.\n'
                '  FR : $fr\n'
                '  $langue : $tr\n'
                'Températures, pourcentages de sel et distances se '
                'recopient : pas de Fahrenheit, pas de pouces.');
      });
    });
  });

  test('le français ressort inchangé', () {
    const html = '<html><body><p>Paillage</p></body></html>';
    expect(tutoTraduit(html, 'fr'), html);
    expect(tutoTraduit(html, 'de'), html);
  });

  group('l\'injection', () {
    final html =
        File('assets/tutos/conserver_legumes.html').readAsStringSync();
    final en = tutoTraduit(html, 'en');

    test('ajoute le dictionnaire et le script, une seule fois', () {
      expect(en.length, greaterThan(html.length));
      expect('__KULTIVA_TUTO_T__'.allMatches(en).length, 2,
          reason: 'Une fois posé, une fois lu.');
      expect(en.indexOf('__KULTIVA_TUTO_T__'),
          greaterThan(en.indexOf('<body')),
          reason: 'Le script doit venir après le corps de la page.');
    });

    test('n\'embarque que ce qui est réellement traduit', () {
      // Une clé vide veut dire « pas encore fait ». La laisser passer
      // ferait disparaître la phrase française au lieu de la garder.
      final debut = en.indexOf('__KULTIVA_TUTO_T__=') +
          '__KULTIVA_TUTO_T__='.length;
      final fin = en.indexOf(';(function', debut);
      final dico =
          jsonDecode(en.substring(debut, fin)) as Map<String, dynamic>;
      expect(dico, isNotEmpty);
      for (final v in dico.values) {
        expect(v, isA<String>());
        expect(v as String, isNotEmpty);
      }
    });

    test('ne fait aucun appel réseau', () {
      // Même contrat que les tutos eux-mêmes et le lecteur de
      // recettes : un avion sans wifi est le moment où on les lit.
      for (final interdit in <String>[
        'http://',
        'https://',
        'cdnjs',
        'googleapis',
        'fonts.gstatic',
      ]) {
        expect(tutoTraduit('<html><body></body></html>', 'en')
            .contains(interdit), isFalse,
            reason: 'Le bloc injecté contient « $interdit ».');
      }
    });

    test('ne touche pas au corps du tuto', () {
      expect(en.startsWith(html.substring(0, html.indexOf('</body>'))),
          isTrue,
          reason: 'Tout ce qui précède </body> doit être intact : les '
              'fichiers des tutos ne sont jamais modifiés.');
    });
  });

  test('aucune traduction n\'est vide', () {
    // Une valeur vide passerait le filtre d'injection, mais c'est du
    // travail à moitié fait qu'il vaut mieux voir tout de suite.
    tutoTextsByLanguage.forEach((langue, dico) {
      for (final e in dico.entries) {
        expect(e.value, isNotEmpty,
            reason: '$langue · clé non traduite : ${e.key}');
      }
    });
  });

  test('la traduction dit autre chose que le français, presque partout',
      () {
    // Quelques phrases sont identiques dans les deux langues — un
    // emoji suivi d'un nom propre (« 🥒 Courgette »), une unité. Mais
    // si la moitié du dictionnaire était identique, c'est qu'on
    // aurait recopié le français.
    final en = tutoTextsByLanguage['en']!;
    final identiques =
        en.entries.where((e) => e.value == e.key).length;
    expect(identiques / en.length, lessThan(0.1),
        reason: '\$identiques phrases sur \${en.length} sont identiques '
            'au français.');
  });
}
