
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';

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
}
