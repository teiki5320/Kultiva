import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/challenges.dart';
import 'package:kultiva/data/content_i18n.dart';
import 'package:kultiva/data/accessory_guide.dart';
import 'package:kultiva/data/diseases.dart';
import 'package:kultiva/data/lexicon.dart';
import 'package:kultiva/data/market_buying_tips.dart';
import 'package:kultiva/data/rotation.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/utils/heatwave_tips.dart';

/// Ce qui garde la traduction du contenu honnête.
///
/// Maladies, badges, défis, lexique, familles botaniques, conseils
/// canicule et achat au marché : 784 phrases, clés par le texte
/// français lui-même. Trois risques, les mêmes que pour les recettes
/// et les tutos :
///
/// 1. **une clé orpheline** — une phrase qu'aucune donnée ne contient
///    plus. La traduction ne s'afficherait jamais, en silence ;
/// 2. **un nombre qui bouge** — « 3-4 ans » de rotation, « 10% » de
///    lait contre l'oïdium, « tous les 2 jours » d'arrosage. Ce sont
///    des conseils de jardinage, pas du style ;
/// 3. **un doublon de sens** — deux phrases françaises identiques dans
///    deux contextes différents partagent forcément leur traduction.
///    C'est accepté, et vérifié ici pour qu'on sache lesquelles.
///
/// ⚠️ Ces tests n'appellent jamais `PrefsService` : en test
/// l'environnement tourne en `en-US`, donc `tr()` lirait de l'anglais
/// en croyant lire du français. Ils passent par `trIn`, qui prend la
/// langue en paramètre.
void main() {
  /// Toutes les phrases françaises que l'app peut afficher.
  final sources = <String>{
    for (final liste in diseaseMap.values)
      for (final d in liste) ...<String>[d.name, d.remedy],
    for (final b in allBadges) ...<String>[b.name, b.description],
    for (final c in allChallenges) ...<String>[
      c.name,
      c.description,
      if (c.waName != null) c.waName!,
      if (c.waDescription != null) c.waDescription!,
    ],
    for (final e in lexicon) ...<String>[e.term, e.definition],
    for (final r in rotationMap.values) r.family,
    for (final c in VegetableCategory.values) heatwaveTipFor(c),
    for (final liste in marketBuyingTips.values)
      for (final t in liste) ...<String>[t.what, t.advice],
    // Les 177 phrases des modes d'emploi d'accessoires, ajoutées le
    // 02/11/2026. Sans cette ligne, leurs traductions seraient toutes
    // déclarées orphelines.
    for (final g in accessoryGuides.values) ...<String>[
      g.when,
      g.how,
      g.howMuch,
      g.care,
      if (g.diy != null) g.diy!,
    ],
  };

  List<String> nombres(String texte) => RegExp(r'\d+(?:[.,]\d+)?')
      .allMatches(texte)
      .map((m) => m.group(0)!.replaceAll(',', '.'))
      .toList(growable: false);

  test('l\'app a bien le contenu qu\'on croit', () {
    // Si ce nombre bouge, des phrases ont été ajoutées ou retirées :
    // relancer `flutter test tool/exporter_contenu.dart` pour voir où.
    // 780 phrases jusqu'au 02/11/2026, puis 957 avec les modes d'emploi
    // des 39 accessoires.
    expect(sources.length, greaterThan(940));
  });

  test('aucune clé traduite n\'est orpheline', () {
    contentTextsByLanguage.forEach((langue, dico) {
      for (final cle in dico.keys) {
        expect(sources.contains(cle), isTrue,
            reason: '« $langue » traduit une phrase que l\'app '
                'n\'affiche nulle part :\n  $cle\n'
                'Faute de frappe, ou texte français corrigé depuis ? '
                'Telle quelle, cette traduction ne servira jamais.');
      }
    });
  });

  test('les nombres d\'une traduction sont ceux du français', () {
    contentTextsByLanguage.forEach((langue, dico) {
      dico.forEach((fr, tr) {
        if (tr.isEmpty) return;
        expect(nombres(tr), nombres(fr),
            reason: '$langue · les nombres ont bougé.\n'
                '  FR : $fr\n'
                '  $langue : $tr\n'
                'Années de rotation, dosages et fréquences d\'arrosage '
                'se recopient : ce sont des conseils, pas du style.');
      });
    });
  });

  test('le français et une langue inconnue ressortent inchangés', () {
    const phrase = 'Mildiou';
    expect(trIn(phrase, 'fr'), phrase);
    expect(trIn(phrase, 'de'), phrase);
  });

  test('une phrase non traduite retombe sur le français', () {
    const inventee = 'Cette phrase n\'existe dans aucun dictionnaire.';
    expect(trIn(inventee, 'en'), inventee);
  });

  test('les extensions suivent le dictionnaire', () {
    // On vérifie le mécanisme, pas le contenu : le dictionnaire se
    // remplit lot par lot, et le test doit passer à tous les stades.
    final d = diseaseMap['tomate']!.first;
    expect(trIn(d.name, 'fr'), d.name);
    expect(trIn(d.remedy, 'fr'), d.remedy);
    final b = allBadges.first;
    expect(trIn(b.name, 'fr'), b.name);
    final c = allChallenges.first;
    expect(trIn(c.name, 'fr'), c.name);
    final e = lexicon.first;
    expect(trIn(e.definition, 'fr'), e.definition);
  });

  test('les doublons de phrase sont connus', () {
    // Deux phrases françaises identiques dans deux contextes
    // partagent leur traduction : c'est voulu (« Pucerons » est la
    // même maladie partout), mais il faut que ça reste vrai.
    final toutes = <String>[
      for (final liste in diseaseMap.values)
        for (final d in liste) ...<String>[d.name, d.remedy],
    ];
    final uniques = toutes.toSet();
    expect(uniques.length, lessThan(toutes.length),
        reason: 'Les maladies se répètent d\'un légume à l\'autre : '
            'c\'est ce qui fait que 323 phrases couvrent 130 cultures.');
  });
}
