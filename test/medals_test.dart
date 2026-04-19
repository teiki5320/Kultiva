import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';

Plantation _plant({
  required String vegId,
  DateTime? plantedAt,
  int harvests = 0,
  bool active = true,
}) {
  return Plantation(
    id: '${vegId}_${DateTime.now().microsecondsSinceEpoch}',
    vegetableId: vegId,
    plantedAt: plantedAt ?? DateTime.now(),
    harvestedAt: active ? null : DateTime.now(),
    harvestCount: harvests,
  );
}

void main() {
  group('computeMedalTier', () {
    test('no plantation returns none', () {
      expect(computeMedalTier('tomate', []), MedalTier.none);
    });

    test('1 plantation, 0 harvest → bronze', () {
      expect(
        computeMedalTier('tomate', [_plant(vegId: 'tomate')]),
        MedalTier.bronze,
      );
    });

    test('1 plantation, 1 harvest → silver', () {
      expect(
        computeMedalTier('tomate', [_plant(vegId: 'tomate', harvests: 1)]),
        MedalTier.silver,
      );
    });

    test('3 cumulative harvests → gold', () {
      expect(
        computeMedalTier('tomate', [_plant(vegId: 'tomate', harvests: 3)]),
        MedalTier.gold,
      );
    });

    test('2 plantations in different seasons → gold (no harvest needed)', () {
      // Plantations terminées (active: false) pour neutraliser la règle
      // shiny-par-survie (180j). 30 jours et 120 jours dans le passé
      // couvrent au moins 2 mois différents → 2 saisons potentielles.
      // On force les mois (février = hiver, mai = printemps) via DateTime
      // fixes avec une année certainement passée.
      expect(
        computeMedalTier('tomate', [
          _plant(
            vegId: 'tomate',
            plantedAt: DateTime(2024, 2, 15), // hiver 2024
            active: false,
          ),
          _plant(
            vegId: 'tomate',
            plantedAt: DateTime(2024, 5, 15), // printemps 2024
            active: false,
          ),
        ]),
        MedalTier.gold,
      );
    });

    test('5 cumulative harvests → shiny', () {
      expect(
        computeMedalTier('tomate', [_plant(vegId: 'tomate', harvests: 5)]),
        MedalTier.shiny,
      );
    });

    test('active plant >= 180 days → shiny', () {
      expect(
        computeMedalTier('tomate', [
          _plant(
            vegId: 'tomate',
            plantedAt: DateTime.now().subtract(const Duration(days: 200)),
          ),
        ]),
        MedalTier.shiny,
      );
    });

    test('terminated plant, even old, does NOT count for shiny via survival', () {
      final tier = computeMedalTier('tomate', [
        _plant(
          vegId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 200)),
          active: false,
        ),
      ]);
      // Terminated plant is not "isActive", so survival rule doesn't apply.
      // With 0 harvests and only 1 season, we stay at bronze.
      expect(tier, MedalTier.bronze);
    });

    test('other vegetable plantations do not affect tier of target', () {
      expect(
        computeMedalTier('tomate', [
          _plant(vegId: 'courgette', harvests: 10),
        ]),
        MedalTier.none,
      );
    });

    test('harvests from multiple plantations of same species accumulate', () {
      expect(
        computeMedalTier('tomate', [
          _plant(vegId: 'tomate', harvests: 2),
          _plant(vegId: 'tomate', harvests: 3),
        ]),
        MedalTier.shiny, // 2+3 = 5
      );
    });
  });

  group('MedalTier ordering', () {
    test('rank order is none < bronze < silver < gold < shiny', () {
      expect(MedalTier.none.rank, lessThan(MedalTier.bronze.rank));
      expect(MedalTier.bronze.rank, lessThan(MedalTier.silver.rank));
      expect(MedalTier.silver.rank, lessThan(MedalTier.gold.rank));
      expect(MedalTier.gold.rank, lessThan(MedalTier.shiny.rank));
    });

    test('each tier has a distinct emoji and label', () {
      final tiers = [
        MedalTier.bronze,
        MedalTier.silver,
        MedalTier.gold,
        MedalTier.shiny,
      ];
      expect(tiers.map((t) => t.emoji).toSet().length, 4);
      expect(tiers.map((t) => t.label).toSet().length, 4);
    });
  });

  group('computeAllMedals', () {
    test('returns map keyed by vegetableId', () {
      final medals = computeAllMedals([
        _plant(vegId: 'tomate', harvests: 3),
        _plant(vegId: 'courgette'),
      ]);
      expect(medals['tomate'], MedalTier.gold);
      expect(medals['courgette'], MedalTier.bronze);
    });

    test('species with 0 plantations is absent from map', () {
      final medals = computeAllMedals([
        _plant(vegId: 'tomate'),
      ]);
      expect(medals.containsKey('courgette'), false);
    });
  });
}
