import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/services/recipe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const tarte = Recipe(
    name: 'Tarte à la tomate et moutarde',
    emoji: '🥧',
    description: 'test',
  );
  const soupe = Recipe(name: 'Soupe', emoji: '🍲', description: 'test');

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{
        // ⚠️ `load()` relit les préférences et écraserait une
        // langue posée dans `setUpAll`. Elle se sème donc ici.
        'flutter.kultiva.language': 'fr',
      });
    await PrefsService.instance.load();
  });

  group('clé d\'une recette', () {
    test('elle porte le légume, parce que deux légumes peuvent nommer '
        'pareil', () {
      final a = RecipeService.keyFor('tomate', soupe);
      final b = RecipeService.keyFor('potiron', soupe);
      expect(a, isNot(b));
      expect(a, contains('tomate'));
    });
  });

  group('favoris', () {
    test('rien au départ', () {
      expect(RecipeService.instance.favorites, isEmpty);
      expect(RecipeService.instance.isFavorite('tomate/Soupe'), isFalse);
    });

    test('le bouton bascule dans les deux sens', () async {
      final svc = RecipeService.instance;
      final cle = RecipeService.keyFor('tomate', tarte);
      await svc.toggleFavorite(cle);
      expect(svc.isFavorite(cle), isTrue);
      await svc.toggleFavorite(cle);
      expect(svc.isFavorite(cle), isFalse);
    });

    test('la version change à chaque écriture, pour que les listes se '
        'rafraîchissent', () async {
      final svc = RecipeService.instance;
      final avant = svc.version.value;
      await svc.toggleFavorite('tomate/Soupe');
      expect(svc.version.value, greaterThan(avant));
    });

    test('les favoris survivent à un rechargement', () async {
      await RecipeService.instance.toggleFavorite('tomate/Soupe');
      await PrefsService.instance.load();
      expect(RecipeService.instance.isFavorite('tomate/Soupe'), isTrue);
    });
  });

  group('déjà cuisiné', () {
    test('on retient la date', () async {
      final svc = RecipeService.instance;
      final quand = DateTime(2026, 11, 1, 19, 30);
      await svc.markCooked('tomate/Soupe', when: quand);
      expect(svc.cookedOn('tomate/Soupe'), quand);
      expect(svc.hasCooked('tomate/Soupe'), isTrue);
    });

    test('recuisiner écrase par la date la plus récente', () async {
      final svc = RecipeService.instance;
      await svc.markCooked('tomate/Soupe', when: DateTime(2026, 5, 1));
      await svc.markCooked('tomate/Soupe', when: DateTime(2026, 11, 1));
      expect(svc.cookedOn('tomate/Soupe'), DateTime(2026, 11, 1));
      expect(svc.cookedCount, 1);
    });

    test('on peut se dédire', () async {
      final svc = RecipeService.instance;
      await svc.markCooked('tomate/Soupe');
      await svc.unmarkCooked('tomate/Soupe');
      expect(svc.hasCooked('tomate/Soupe'), isFalse);
    });

    test('le compteur compte des recettes distinctes', () async {
      final svc = RecipeService.instance;
      await svc.markCooked('tomate/Soupe');
      await svc.markCooked('potiron/Soupe');
      expect(svc.cookedCount, 2);
    });

    test('une ligne corrompue ne fait pas perdre les autres', () async {
      // Leçon du décodage de `garden_plan` : on ignore la ligne, pas
      // tout l'historique.
      await PrefsService.instance.setRecipeCookedRaw(<String>[
        'tomate/Soupe|2026-11-01T10:00:00.000',
        'nawak-sans-separateur',
        'potiron/Gratin|pas-une-date',
        '|2026-11-01T10:00:00.000',
      ]);
      final tout = RecipeService.instance.cookedAt;
      expect(tout.length, 1);
      expect(tout.keys.single, 'tomate/Soupe');
    });

    test('une clé contenant une barre verticale reste lisible', () async {
      // On coupe au **dernier** séparateur, pas au premier.
      final svc = RecipeService.instance;
      await svc.markCooked('tomate/Sauce | maison',
          when: DateTime(2026, 11, 1));
      expect(svc.cookedOn('tomate/Sauce | maison'), DateTime(2026, 11, 1));
    });
  });
}
