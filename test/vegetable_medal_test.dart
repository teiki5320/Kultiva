import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';

void main() {
  group('MedalTier enum', () {
    test('contient 5 valeurs dans le bon ordre', () {
      expect(MedalTier.values.length, equals(5));
      expect(MedalTier.values[0], equals(MedalTier.none));
      expect(MedalTier.values[1], equals(MedalTier.bronze));
      expect(MedalTier.values[2], equals(MedalTier.silver));
      expect(MedalTier.values[3], equals(MedalTier.gold));
      expect(MedalTier.values[4], equals(MedalTier.shiny));
    });

    test('chaque palier a un emoji cohérent', () {
      expect(MedalTier.none.emoji, isEmpty);
      expect(MedalTier.bronze.emoji, isNotEmpty);
      expect(MedalTier.silver.emoji, isNotEmpty);
      expect(MedalTier.gold.emoji, isNotEmpty);
      expect(MedalTier.shiny.emoji, isNotEmpty);
    });

    test('chaque palier a un label cohérent', () {
      expect(MedalTier.none.label, isEmpty);
      expect(MedalTier.bronze.label, equals('Bronze'));
      expect(MedalTier.silver.label, equals('Argent'));
      expect(MedalTier.gold.label, equals('Or'));
      expect(MedalTier.shiny.label, equals('Shiny'));
    });

    test('les rangs sont strictement croissants', () {
      expect(MedalTier.none.rank, equals(0));
      expect(MedalTier.bronze.rank, equals(1));
      expect(MedalTier.silver.rank, equals(2));
      expect(MedalTier.gold.rank, equals(3));
      expect(MedalTier.shiny.rank, equals(4));
    });

    test('chaque palier a une couleur non nulle', () {
      for (final tier in MedalTier.values) {
        // ignore: unnecessary_null_comparison
        expect(tier.color, isNotNull,
            reason: '${tier.name} devrait avoir une couleur');
      }
    });
  });

  group('computeMedalTier', () {
    test('aucune plantation → none', () {
      final tier = computeMedalTier('tomate', <Plantation>[]);
      expect(tier, equals(MedalTier.none));
    });

    test("0 plantation pour ce légume parmi d'autres → none", () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'carotte',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.none));
    });

    test('1 plantation sans récolte → bronze', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.bronze));
    });

    test('1 récolte → silver', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 1,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.silver));
    });

    test('2 récoltes (< 3) → silver', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 2,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.silver));
    });

    test('3 récoltes cumulées → gold', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 2,
        ),
        Plantation(
          id: '2',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 5)),
          harvestCount: 1,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      // 3 récoltes cumulées OU 2 saisons (printemps + été) → gold
      expect(tier, equals(MedalTier.gold));
    });

    test('plantations dans 2 saisons différentes → gold', () {
      // Dates relatives : 120 jours d'écart garantissent deux saisons
      // distinctes, et rester sous 180 jours évite de déclencher le
      // palier shiny (plant actif >= 180 j).
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 0,
        ),
        Plantation(
          id: '2',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 130)),
          harvestCount: 0,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.gold));
    });

    test('5 récoltes cumulées → shiny', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 5,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.shiny));
    });

    test('4 récoltes cumulées (< 5) dans la même saison → gold', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 4,
        ),
      ];
      final tier = computeMedalTier('tomate', plantations);
      expect(tier, equals(MedalTier.gold));
    });
  });

  group('computeAllMedals', () {
    test('liste vide → map vide', () {
      final medals = computeAllMedals(<Plantation>[]);
      expect(medals, isEmpty);
    });

    test('renvoie une entrée par espèce distincte', () {
      final plantations = <Plantation>[
        Plantation(
          id: '1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Plantation(
          id: '2',
          vegetableId: 'carotte',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          harvestCount: 1,
        ),
        Plantation(
          id: '3',
          vegetableId: 'tomate',
          plantedAt: DateTime(2025, 6, 1),
          harvestCount: 3,
        ),
      ];
      final medals = computeAllMedals(plantations);
      expect(medals.length, equals(2));
      expect(medals.containsKey('tomate'), isTrue);
      expect(medals.containsKey('carotte'), isTrue);
      // Tomate : 3 récoltes + 2 saisons → gold ou mieux
      expect(medals['tomate']!.rank, greaterThanOrEqualTo(MedalTier.gold.rank));
      // Carotte : 1 récolte → silver
      expect(medals['carotte'], equals(MedalTier.silver));
    });
  });
}
