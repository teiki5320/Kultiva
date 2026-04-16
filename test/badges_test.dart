import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';

Plantation _plant({
  required String vegId,
  DateTime? plantedAt,
  DateTime? harvestedAt,
  int harvests = 0,
  List<DateTime> waterings = const [],
  String? note,
  List<String> photos = const [],
}) {
  return Plantation(
    id: '${vegId}_${DateTime.now().microsecondsSinceEpoch}',
    vegetableId: vegId,
    plantedAt: plantedAt ?? DateTime.now(),
    harvestedAt: harvestedAt,
    harvestCount: harvests,
    wateredAt: waterings,
    note: note,
    photoPaths: photos,
  );
}

void main() {
  group('computeUnlockedBadges', () {
    test('empty list returns empty set', () {
      expect(computeUnlockedBadges(<Plantation>[]), isEmpty);
    });

    test('single plantation unlocks first_step', () {
      final set = computeUnlockedBadges([_plant(vegId: 'tomate')]);
      expect(set, contains('first_step'));
    });

    test('at least one harvest unlocks first_harvest', () {
      final set = computeUnlockedBadges([
        _plant(vegId: 'tomate', harvests: 1),
      ]);
      expect(set, contains('first_harvest'));
    });

    test('10 cumulative waterings unlocks small_watering_can', () {
      final now = DateTime.now();
      final set = computeUnlockedBadges([
        _plant(
          vegId: 'tomate',
          waterings: List.generate(10, (i) => now.subtract(Duration(days: i))),
        ),
      ]);
      expect(set, contains('small_watering_can'));
    });

    test('under 10 waterings does NOT unlock small_watering_can', () {
      final set = computeUnlockedBadges([
        _plant(
          vegId: 'tomate',
          waterings: List.generate(9, (i) => DateTime.now()),
        ),
      ]);
      expect(set, isNot(contains('small_watering_can')));
    });

    test('10+ plantations unlocks collector', () {
      final set = computeUnlockedBadges(
        List.generate(10, (_) => _plant(vegId: 'tomate')),
      );
      expect(set, contains('collector'));
    });

    test('30+ plantations unlocks master_collector', () {
      final set = computeUnlockedBadges(
        List.generate(30, (_) => _plant(vegId: 'tomate')),
      );
      expect(set, contains('master_collector'));
    });

    test('plant in all 4 seasons unlocks sun_tour', () {
      // Spring (may), Summer (july), Autumn (october), Winter (january).
      final plants = [
        _plant(vegId: 'tomate', plantedAt: DateTime(2025, 5, 1)),
        _plant(vegId: 'tomate', plantedAt: DateTime(2025, 7, 1)),
        _plant(vegId: 'tomate', plantedAt: DateTime(2025, 10, 1)),
        _plant(vegId: 'tomate', plantedAt: DateTime(2026, 1, 1)),
      ];
      final set = computeUnlockedBadges(plants);
      expect(set, contains('sun_tour'));
    });

    test('active plantation ≥ 180 days unlocks green_thumb', () {
      final set = computeUnlockedBadges([
        _plant(
          vegId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 200)),
        ),
      ]);
      expect(set, contains('green_thumb'));
    });

    test('first photo unlocks first_photo', () {
      final set = computeUnlockedBadges([
        _plant(vegId: 'tomate', photos: ['/tmp/p1.jpg']),
      ]);
      expect(set, contains('first_photo'));
    });

    test('5 plantations same day unlocks lightning', () {
      final today = DateTime(2025, 6, 15, 10);
      final set = computeUnlockedBadges(
        List.generate(
          5,
          (_) => _plant(vegId: 'tomate', plantedAt: today),
        ),
      );
      expect(set, contains('lightning'));
    });

    test('100 cumulative harvests unlocks gourmand AND big_harvester', () {
      final set = computeUnlockedBadges([
        _plant(vegId: 'tomate', harvests: 100),
      ]);
      expect(set, containsAll(['gourmand', 'big_harvester', 'first_harvest']));
    });

    test('5 plantations with notes unlocks writer', () {
      final set = computeUnlockedBadges(
        List.generate(
          5,
          (i) => _plant(vegId: 'tomate', note: 'note $i'),
        ),
      );
      expect(set, contains('writer'));
    });

    test('notes with empty strings do NOT count for writer', () {
      final set = computeUnlockedBadges(
        List.generate(
          5,
          (_) => _plant(vegId: 'tomate', note: '   '),
        ),
      );
      expect(set, isNot(contains('writer')));
    });
  });

  group('badges catalog integrity', () {
    test('all badge IDs are unique', () {
      final ids = allBadges.map((b) => b.id).toList();
      expect(ids.toSet().length, ids.length,
          reason: 'Duplicate badge IDs found');
    });

    test('all badges have non-empty name and description', () {
      for (final b in allBadges) {
        expect(b.name.trim(), isNotEmpty, reason: '${b.id} has empty name');
        expect(b.description.trim(), isNotEmpty,
            reason: '${b.id} has empty description');
        expect(b.emoji.trim(), isNotEmpty,
            reason: '${b.id} has empty emoji');
      }
    });

    test('all badges have a tier (not MedalTier.none)', () {
      for (final b in allBadges) {
        expect(b.tier, isNot(MedalTier.none),
            reason: '${b.id} has no tier assigned');
      }
    });
  });
}
