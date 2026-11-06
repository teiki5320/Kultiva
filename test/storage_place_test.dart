import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/utils/storage_place.dart';

/// Le meuble d'une conservation se lit dans sa durée de garde
/// (`Recipe.keeps`). Ces tests vérifient que la lecture tombe juste sur
/// le catalogue réel, et qu'elle respecte les règles de sécurité de
/// CLAUDE.md : ce qui est dans l'huile ou au vinaigre ne va pas au
/// placard.
void main() {
  Iterable<Recipe> toutes() => recipesByVegetable.values.expand((l) => l);

  Recipe recette(String legume, String nom) =>
      recipesByVegetable[legume]!.firstWhere((r) => r.name == nom);

  test('chaque conservation a un meuble, chaque plat du jour n\'en a pas', () {
    for (final r in toutes()) {
      if (r.method == null) {
        expect(storagePlaceOf(r), isNull, reason: r.name);
      } else {
        expect(storagePlaceOf(r), isNotNull, reason: r.name);
      }
    }
  });

  test('les trois meubles sont tous remplis', () {
    final comptes = <StoragePlace, int>{};
    for (final r in toutes()) {
      final p = storagePlaceOf(r);
      if (p != null) comptes[p] = (comptes[p] ?? 0) + 1;
    }
    for (final p in StoragePlace.values) {
      expect(comptes[p] ?? 0, greaterThan(20), reason: p.name);
    }
  });

  test('une phrase qui cite le congélateur va au congélateur', () {
    for (final r in toutes()) {
      final keeps = r.keeps?.toLowerCase() ?? '';
      if (keeps.contains('congél')) {
        expect(storagePlaceOf(r), StoragePlace.freezer, reason: r.name);
      }
    }
  });

  test('ce qui est dans l\'huile ne va jamais au placard', () {
    // Tout ce qui est dans l'huile se garde au réfrigérateur (règle de
    // CLAUDE.md) : un bocal d'huile au placard, c'est le botulisme.
    // ⚠️ Pas le vinaigre : les dix vinaigres aromatisés (« Vinaigre de
    // basilic »…) se gardent un an au placard, et c'est juste — c'est
    // le légume au vinaigre, le pickle, qui va au frais.
    for (final r in toutes()) {
      if (r.method == PreservationMethod.dansHuile) {
        expect(storagePlaceOf(r), isNot(StoragePlace.cupboard),
            reason: '${r.name} — ${r.keeps}');
      }
    }
  });

  test('quelques cas connus', () {
    expect(storagePlaceOf(recette('potiron', 'Cubes de potiron crus congelés')),
        StoragePlace.freezer);
    expect(storagePlaceOf(recette('radis', 'Pickles de radis roses')),
        StoragePlace.fridge);
    expect(storagePlaceOf(recette('poireau', 'Rondelles de poireaux séchées')),
        StoragePlace.cupboard);
  });

  test('l\'étiquette d\'un bocal garde la durée et rien d\'autre', () {
    expect(shortKeeps('8 mois au congélateur'), '8 mois');
    expect(shortKeeps('1 an au sec, à l\'abri de la lumière'), '1 an');
    expect(shortKeeps('3 semaines'), '3 semaines');
  });
}
