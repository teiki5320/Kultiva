import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/services/plantation_migration.dart';

void main() {
  group('Plantation JSON roundtrip', () {
    test('minimal plantation survives encode → decode', () {
      final p = Plantation(
        id: 'abc123',
        vegetableId: 'tomate',
        plantedAt: DateTime(2025, 4, 10, 14, 30),
      );
      final json = Plantation.encodeAll([p]);
      final back = Plantation.decodeAll(json);

      expect(back.length, 1);
      expect(back.first.id, 'abc123');
      expect(back.first.vegetableId, 'tomate');
      expect(back.first.plantedAt, DateTime(2025, 4, 10, 14, 30));
      expect(back.first.harvestedAt, isNull);
      expect(back.first.harvestCount, 0);
      expect(back.first.wateredAt, isEmpty);
      expect(back.first.note, isNull);
      expect(back.first.photoPaths, isEmpty);
    });

    test('fully-populated plantation roundtrips without loss', () {
      final waterings = [
        DateTime(2025, 4, 11, 8),
        DateTime(2025, 4, 14, 8),
        DateTime(2025, 4, 18, 9),
      ];
      final p = Plantation(
        id: 'xyz-789',
        vegetableId: 'courgette',
        plantedAt: DateTime(2025, 4, 10),
        harvestedAt: DateTime(2025, 7, 1),
        harvestCount: 4,
        wateredAt: waterings,
        note: 'Planté en pot sur le balcon sud',
        photoPaths: const ['/tmp/p1.jpg', '/tmp/p2.jpg'],
      );
      final back = Plantation.decodeAll(Plantation.encodeAll([p])).first;

      expect(back.id, p.id);
      expect(back.vegetableId, p.vegetableId);
      expect(back.plantedAt, p.plantedAt);
      expect(back.harvestedAt, p.harvestedAt);
      expect(back.harvestCount, p.harvestCount);
      expect(back.wateredAt, p.wateredAt);
      expect(back.note, p.note);
      expect(back.photoPaths, p.photoPaths);
    });

    test('empty list encodes to a valid JSON array', () {
      expect(Plantation.encodeAll(<Plantation>[]), '[]');
    });

    test('decodeAll of null or empty returns empty list', () {
      expect(Plantation.decodeAll(null), isEmpty);
      expect(Plantation.decodeAll(''), isEmpty);
    });

    test('decodeAll of invalid JSON returns empty list (no throw)', () {
      expect(Plantation.decodeAll('not valid json'), isEmpty);
      expect(Plantation.decodeAll('{"not": "array"}'), isEmpty);
    });

    test('copyWith preserves all non-touched fields', () {
      final p = Plantation(
        id: 'id',
        vegetableId: 'tomate',
        plantedAt: DateTime(2025, 4, 1),
        harvestCount: 2,
        wateredAt: [DateTime(2025, 4, 2)],
        note: 'hi',
        photoPaths: const ['/a.jpg'],
      );
      final updated = p.copyWith(harvestCount: 5);
      expect(updated.id, p.id);
      expect(updated.vegetableId, p.vegetableId);
      expect(updated.harvestCount, 5);
      expect(updated.wateredAt, p.wateredAt);
      expect(updated.note, p.note);
      expect(updated.photoPaths, p.photoPaths);
    });

    test('copyWith clearHarvestedAt drops the harvestedAt field', () {
      final p = Plantation(
        id: 'id',
        vegetableId: 'tomate',
        plantedAt: DateTime(2025, 4, 1),
        harvestedAt: DateTime(2025, 5, 1),
      );
      final reopened = p.copyWith(clearHarvestedAt: true);
      expect(reopened.harvestedAt, isNull);
      expect(reopened.isActive, isTrue);
    });
  });

  group('migrateGridToPlantations', () {
    test('null or empty input returns empty list', () {
      expect(migrateGridToPlantations(null), isEmpty);
      expect(migrateGridToPlantations(''), isEmpty);
    });

    test('malformed JSON returns empty list without throwing', () {
      expect(migrateGridToPlantations('not json'), isEmpty);
      expect(migrateGridToPlantations('{"rows": "nope"}'), isEmpty);
      expect(migrateGridToPlantations('{"rows": 2}'), isEmpty);
    });

    test('empty grid (all nulls) returns empty list', () {
      final legacy = jsonEncode({
        'rows': 2,
        'cols': 3,
        'cells': [null, null, null, null, null, null],
      });
      expect(migrateGridToPlantations(legacy), isEmpty);
    });

    test('single cell produces a single plantation with correct vegetableId',
        () {
      final legacy = jsonEncode({
        'rows': 1,
        'cols': 1,
        'cells': ['tomate'],
      });
      final result = migrateGridToPlantations(legacy);
      expect(result.length, 1);
      expect(result.first.vegetableId, 'tomate');
      expect(result.first.harvestCount, 0);
      expect(result.first.wateredAt, isEmpty);
    });

    test('multiple cells produce one plantation each, in row-major order', () {
      final legacy = jsonEncode({
        'rows': 2,
        'cols': 2,
        'cells': ['tomate', null, 'carotte', 'courgette'],
      });
      final result = migrateGridToPlantations(legacy);
      expect(result.length, 3);
      expect(result.map((p) => p.vegetableId).toList(),
          ['tomate', 'carotte', 'courgette']);
    });

    test('watered info is carried over to wateredAt', () {
      final legacy = jsonEncode({
        'rows': 1,
        'cols': 2,
        'cells': ['tomate', 'carotte'],
        'watered': {
          '0_0': '2025-04-10T08:00:00.000Z',
          '0_1': '2025-04-11T08:00:00.000Z',
        },
      });
      final result = migrateGridToPlantations(legacy);
      expect(result.length, 2);
      expect(result[0].wateredAt.length, 1);
      expect(result[1].wateredAt.length, 1);
    });

    test('missing watered map is tolerated', () {
      final legacy = jsonEncode({
        'rows': 1,
        'cols': 1,
        'cells': ['tomate'],
      });
      final result = migrateGridToPlantations(legacy);
      expect(result.first.wateredAt, isEmpty);
    });

    test('generated IDs are unique (same-millisecond migration)', () {
      final legacy = jsonEncode({
        'rows': 3,
        'cols': 3,
        'cells': List.filled(9, 'tomate'),
      });
      final result = migrateGridToPlantations(legacy);
      final ids = result.map((p) => p.id).toSet();
      expect(ids.length, result.length);
    });

    test('seed parameter makes ID generation deterministic', () {
      final legacy = jsonEncode({
        'rows': 1,
        'cols': 2,
        'cells': ['tomate', 'carotte'],
      });
      final a = migrateGridToPlantations(legacy, seed: 1);
      final b = migrateGridToPlantations(legacy, seed: 1);
      // Same seed → same random suffixes (last 5 digits of the ID).
      final suffixA = a.map((p) => p.id.split('_').last).toList();
      final suffixB = b.map((p) => p.id.split('_').last).toList();
      expect(suffixA, suffixB);
    });
  });
}
