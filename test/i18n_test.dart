import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/names_en.dart';
import 'package:kultiva/data/names_es.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// L'anglais est la première langue ajoutée, le 01/11/2026. Ces tests
/// gardent la traduction alignée sur le catalogue : une culture
/// ajoutée sans son nom anglais s'afficherait en français au milieu
/// d'une interface anglaise, sans que rien n'échoue.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final cultures = vegetablesBase
      .where((v) => v.category != VegetableCategory.accessories)
      .where((v) => v.id != '_inconnu')
      .toList();

  test('chaque culture du catalogue a un nom anglais', () {
    final manquants = cultures
        .where((v) => !vegetableNamesEn.containsKey(v.id))
        .map((v) => v.id)
        .toList();
    expect(manquants, isEmpty,
        reason: 'sans nom anglais, ces cultures resteront en français : '
            '$manquants');
  });

  test('aucune traduction orpheline', () {
    final ids = vegetablesBase.map((v) => v.id).toSet();
    final orphelines =
        vegetableNamesEn.keys.where((k) => !ids.contains(k)).toList();
    expect(orphelines, isEmpty);
  });

  test('aucun nom anglais vide, ni laissé en français', () {
    for (final v in cultures) {
      final en = vegetableNamesEn[v.id]!;
      expect(en.trim(), isNotEmpty, reason: v.id);
      // Quelques noms sont légitimement identiques (Fonio, Moringa,
      // Zinnia…) ; on vérifie seulement qu'aucun n'a gardé ses
      // accents français, signe d'un copier-coller.
      expect(en, isNot(matches(RegExp(r'[àâäéèêëîïôöùûüç]'))),
          reason: '${v.id} : « $en » a l\'air resté en français');
    }
  });

  group('l\'espagnol, ajouté le 02/11/2026', () {
    test('chaque culture du catalogue a un nom espagnol', () {
      final manquants = cultures
          .where((v) => !vegetableNamesEs.containsKey(v.id))
          .map((v) => v.id)
          .toList();
      expect(manquants, isEmpty,
          reason: 'sans nom espagnol, ces cultures resteront en '
              'français : $manquants');
    });

    test('aucune traduction orpheline', () {
      final ids = vegetablesBase.map((v) => v.id).toSet();
      final orphelines =
          vegetableNamesEs.keys.where((k) => !ids.contains(k)).toList();
      expect(orphelines, isEmpty);
    });

    test('aucun nom espagnol vide, ni laissé en français', () {
      for (final v in cultures) {
        final es = vegetableNamesEs[v.id]!;
        expect(es.trim(), isNotEmpty, reason: v.id);
        // L'espagnol partage des accents avec le français (é, á, ñ) :
        // on ne peut pas détecter un copier-coller par les accents.
        // On vérifie donc que le nom n'est pas identique au français,
        // sauf pour les quelques mots qui le sont légitimement.
        const identiquesVoulus = <String>{
          'moringa', 'taro', 'kiwi', 'cosmos', 'zinnia', 'fonio',
          'pak_choi', 'shiitake', 'chou_kale', 'gombo', 'sorgho',
          'tomate', 'melon',
        };
        if (!identiquesVoulus.contains(v.id)) {
          expect(es.toLowerCase(), isNot(v.name.toLowerCase()),
              reason: '${v.id} : « $es » est identique au français. '
                  'Voulu ? Alors ajoute-le à identiquesVoulus.');
        }
      }
    });

    test('l\'espagnol est proposé dans les réglages', () {
      // Règle 10 : une traduction qu'aucun chemin de l'app n'atteint
      // est un bug, pas une avance.
      expect(PrefsService.supportedLanguages, contains('es'));
    });
  });

  group('langue effective', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        // ⚠️ `load()` relit les préférences et écraserait une
        // langue posée dans `setUpAll`. Elle se sème donc ici.
        'flutter.kultiva.language': 'fr',
      });
      await PrefsService.instance.load();
    });

    test('un choix manuel l\'emporte', () async {
      await PrefsService.instance.setLanguage('en');
      expect(PrefsService.instance.effectiveLanguage, 'en');
      await PrefsService.instance.setLanguage('fr');
      expect(PrefsService.instance.effectiveLanguage, 'fr');
    });

    test('une langue inconnue est traitée comme « aucun choix »', () async {
      // Pas atteignable par l'interface, mais une préférence écrite
      // par une version future, ou corrompue, ne doit pas vider l'app
      // de ses textes : on retombe sur la langue du téléphone, et sur
      // le français si on ne la parle pas.
      await PrefsService.instance.setLanguage('xx');
      expect(PrefsService.supportedLanguages,
          contains(PrefsService.instance.effectiveLanguage));
    });

    test('sans choix, on suit le téléphone', () async {
      await PrefsService.instance.setLanguage(null);
      expect(PrefsService.supportedLanguages,
          contains(PrefsService.instance.effectiveLanguage));
    });

    test('le nom affiché suit la langue', () async {
      final tomate = vegetableById('tomate');
      await PrefsService.instance.setLanguage('fr');
      expect(tomate.displayName, 'Tomate');
      await PrefsService.instance.setLanguage('en');
      expect(tomate.displayName, 'Tomato');
    });

    test('le nom français reste la source de vérité', () async {
      // Les clés de données, la recherche sans accent et les tests
      // travaillent sur `name`, qui ne doit jamais bouger.
      await PrefsService.instance.setLanguage('en');
      expect(vegetableById('tomate').name, 'Tomate');
    });
  });
}
