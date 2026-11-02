import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/utils/recipe_portions.dart';
import 'package:kultiva/services/prefs_service.dart';

void main() {
  // ⚠️ L'environnement de test tourne en `en-US`, donc `trUi()` rend
  // de l'anglais. Ce fichier compare du **français** — le texte source
  // de l'app — donc il force la langue. Sans ça, il validerait des
  // libellés anglais en croyant lire du français, ce qui est
  // exactement le piège qu'`onglets_test` s'est pris en 2026.
  setUpAll(() => PrefsService.instance.language.value = 'fr');

  group('scaleIngredients', () {
    test('doubler double les nombres de tête', () {
      expect(
        scaleIngredients(<String>['4 tomates mûres', '200 g de farine'], 4, 8),
        <String>['8 tomates mûres', '400 g de farine'],
      );
    });

    test('diviser par deux garde des nombres écrivables', () {
      expect(
        scaleIngredients(<String>['4 tomates', '1 oignon'], 4, 2),
        <String>['2 tomates', '1/2 oignon'],
      );
    });

    test('une ligne sans nombre n\'est jamais touchée', () {
      // On ne multiplie pas une pincée par trois.
      expect(
        scaleIngredients(<String>['sel, poivre', 'un filet d\'huile'], 2, 6),
        <String>['sel, poivre', 'un filet d\'huile'],
      );
    });

    test('les fractions sont comprises', () {
      expect(scaleIngredients(<String>['1/2 botte de persil'], 2, 4),
          <String>['1 botte de persil']);
    });

    test('les décimales à la française aussi', () {
      expect(scaleIngredients(<String>['1,5 kg de courge'], 4, 8),
          <String>['3 kg de courge']);
    });

    test('un demi apparaît quand le compte ne tombe pas juste', () {
      expect(scaleIngredients(<String>['1 oeuf'], 2, 3),
          <String>['1 1/2 oeuf']);
    });

    test('même nombre de personnes : la liste est rendue telle quelle', () {
      final l = <String>['3 carottes'];
      expect(scaleIngredients(l, 4, 4), same(l));
    });

    test('des valeurs absurdes ne cassent rien', () {
      final l = <String>['3 carottes'];
      expect(scaleIngredients(l, 0, 4), same(l));
      expect(scaleIngredients(l, 4, 0), same(l));
      expect(scaleIngredients(<String>['1/0 chose'], 2, 4),
          <String>['1/0 chose']);
    });

    test('jamais de 2.0 ni de 1.3333 affiché', () {
      for (final to in <int>[1, 2, 3, 5, 7, 12]) {
        for (final ligne
            in scaleIngredients(<String>['3 courgettes'], 4, to)) {
          expect(ligne, isNot(contains('.')));
          expect(ligne.split(' ').first, isNot('0'));
        }
      }
    });
  });

  group('dateCourte', () {
    test('aujourd\'hui et hier se disent en mots', () {
      expect(dateCourte(DateTime.now()), 'aujourd\'hui');
      expect(
        dateCourte(DateTime.now().subtract(const Duration(days: 1))),
        'hier',
      );
    });

    test('au-delà, le jour et le mois en toutes lettres', () {
      expect(dateCourte(DateTime(2026, 11, 3)), 'le 3 novembre');
      expect(dateCourte(DateTime(2026, 1, 21)), 'le 21 janvier');
    });
  });
}
