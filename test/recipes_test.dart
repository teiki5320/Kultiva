import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Le catalogue de recettes est écrit à la main : ces tests attrapent
/// les fautes de frappe qu'aucun compilateur ne voit — une clé qui ne
/// correspond à aucun légume, une recette vide, un accessoire à qui on
/// prêterait une recette.
void main() {
  test('chaque clé correspond à un id du catalogue', () {
    final ids = vegetablesBase.map((v) => v.id).toSet();
    final inconnues =
        recipesByVegetable.keys.where((k) => !ids.contains(k)).toList();
    expect(inconnues, isEmpty,
        reason: 'ces clés ne désignent aucun légume : $inconnues');
  });

  test('aucun accessoire n\'a de recette', () {
    final accessoires = vegetablesBase
        .where((v) => v.category == VegetableCategory.accessories)
        .map((v) => v.id)
        .toSet();
    final fautifs =
        recipesByVegetable.keys.where(accessoires.contains).toList();
    expect(fautifs, isEmpty);
  });

  test('chaque légume a au moins deux recettes', () {
    final maigres = recipesByVegetable.entries
        .where((e) => e.value.length < 2)
        .map((e) => e.key)
        .toList();
    expect(maigres, isEmpty);
  });

  test('aucun nom ni aucune description n\'est vide', () {
    for (final entry in recipesByVegetable.entries) {
      for (final r in entry.value) {
        expect(r.name.trim(), isNotEmpty, reason: entry.key);
        expect(r.description.trim(), isNotEmpty,
            reason: '${entry.key}/${r.name}');
        expect(r.emoji.trim(), isNotEmpty, reason: '${entry.key}/${r.name}');
      }
    }
  });

  test('deux recettes du même légume ne portent pas le même nom', () {
    for (final entry in recipesByVegetable.entries) {
      final noms = entry.value.map((r) => r.name).toList();
      expect(noms.toSet(), hasLength(noms.length), reason: entry.key);
    }
  });

  group('recettes animées', () {
    final animees = recipesByVegetable.values
        .expand((l) => l)
        .where((r) => r.isAnimated)
        .toList();

    test('il y en a, sinon le lecteur ne sert à rien', () {
      expect(animees, isNotEmpty);
    });

    test('une recette animée liste aussi ses ingrédients', () {
      // Dérouler des étapes sans dire quoi sortir du placard laisse
      // l'utilisateur à court au milieu de la recette.
      for (final r in animees) {
        expect(r.ingredients, isNotEmpty, reason: r.name);
      }
    });

    test('une recette animée dit son temps et pour combien', () {
      for (final r in animees) {
        expect(r.minutes, isNotNull, reason: r.name);
        expect(r.serves, isNotNull, reason: r.name);
        expect(r.subtitle, isNotNull, reason: r.name);
      }
    });

    test('aucune étape vide', () {
      for (final r in animees) {
        for (final s in r.steps) {
          expect(s.text.trim(), isNotEmpty, reason: r.name);
          expect(s.emoji.trim(), isNotEmpty, reason: r.name);
        }
      }
    });
  });
}
