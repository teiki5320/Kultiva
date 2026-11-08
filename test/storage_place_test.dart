import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/utils/storage_place.dart';
import 'package:kultiva/widgets/storage_doors.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Le meuble d'une conservation se lit dans sa durée de garde
/// (`Recipe.keeps`). Ces tests vérifient que la lecture tombe juste sur
/// le catalogue réel, et qu'elle respecte les règles de sécurité de
/// CLAUDE.md : ce qui est dans l'huile ou au vinaigre ne va pas au
/// placard.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  _etagere();

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

/// L'étagère du meuble ouvert, et la carte qui dit par quelle
/// conservation commencer (maquette « F · Les portes qui s'ouvrent »).
void _etagere() {
  testWidgets('la carte de saison annonce sa raison et ouvre la recette',
      (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'flutter.kultiva.language': 'fr',
    });
    await PrefsService.instance.load();
    PrefsService.instance.language.value = 'fr';

    final coulis = recipesByVegetable['tomate']!
        .firstWhere((r) => storagePlaceOf(r) == StoragePlace.cupboard);
    String? ouverte;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: StorageShelf(
            place: StoragePlace.cupboard,
            items: <(String, Recipe)>[('tomate', coulis)],
            pick: ShelfPick(
              vegetableId: 'tomate',
              recipe: coulis,
              reason: 'DE SAISON · AU JARDIN',
            ),
            onOpen: (vegId, r) => ouverte = r.name,
          ),
        ),
      ),
    ));
    await tester.pump();

    expect(find.text('Dans le placard'), findsOneWidget);
    expect(find.text('DE SAISON · AU JARDIN'), findsOneWidget);
    expect(find.text('C\'est parti'), findsOneWidget);

    await tester.tap(find.text('C\'est parti'));
    await tester.pump();
    expect(ouverte, coulis.name,
        reason: '« C\'est parti » ouvre la conservation mise en avant');
  });

  testWidgets('sans mise en avant, pas de bouton', (tester) async {
    final coulis = recipesByVegetable['tomate']!
        .firstWhere((r) => storagePlaceOf(r) == StoragePlace.cupboard);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: StorageShelf(
            place: StoragePlace.cupboard,
            items: <(String, Recipe)>[('tomate', coulis)],
            onOpen: (_, __) {},
          ),
        ),
      ),
    ));
    await tester.pump();
    expect(find.text('C\'est parti'), findsNothing);
  });
}
