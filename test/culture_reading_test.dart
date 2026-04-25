import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_reading.dart';

void main() {
  group('CultureReading JSON roundtrip', () {
    test('minimal reading survives encode → decode', () {
      final r = CultureReading(
        id: 'rd_1',
        cultureId: 'cul_42',
        recordedAt: DateTime(2026, 4, 25, 10, 0),
        type: ReadingType.ph,
        unit: 'pH',
        value: 6.2,
      );
      final back = CultureReading.decodeAll(CultureReading.encodeAll([r]));

      expect(back.length, 1);
      expect(back.first.id, 'rd_1');
      expect(back.first.cultureId, 'cul_42');
      expect(back.first.type, ReadingType.ph);
      expect(back.first.value, 6.2);
      expect(back.first.unit, 'pH');
      expect(back.first.note, isNull);
    });

    test('observation without value survives encode → decode', () {
      final r = CultureReading(
        id: 'rd_2',
        cultureId: 'cul_42',
        recordedAt: DateTime(2026, 4, 25),
        type: ReadingType.observation,
        unit: '',
        note: 'Première vraie feuille apparue',
      );
      final back = CultureReading.decodeAll(CultureReading.encodeAll([r]));

      expect(back.first.type, ReadingType.observation);
      expect(back.first.value, isNull);
      expect(back.first.note, 'Première vraie feuille apparue');
    });

    test('decodeAll on empty / null input returns empty list', () {
      expect(CultureReading.decodeAll(null), isEmpty);
      expect(CultureReading.decodeAll(''), isEmpty);
    });

    test('decodeAll on garbage input returns empty list', () {
      expect(CultureReading.decodeAll('not json'), isEmpty);
    });

    test('unknown type id falls back to observation', () {
      final json =
          '[{"id":"x","cultureId":"y","recordedAt":"2026-04-25T10:00:00.000",'
          '"type":"unknown_xyz","unit":""}]';
      final list = CultureReading.decodeAll(json);
      expect(list.first.type, ReadingType.observation);
    });
  });

  group('CultureReading copyWith', () {
    final base = CultureReading(
      id: 'rd_1',
      cultureId: 'cul_1',
      recordedAt: DateTime(2026, 4, 25),
      type: ReadingType.ec,
      unit: 'mS/cm',
      value: 1.4,
      note: 'matin',
    );

    test('copies a single field', () {
      final updated = base.copyWith(value: 1.6);
      expect(updated.id, base.id);
      expect(updated.value, 1.6);
      expect(updated.unit, 'mS/cm');
      expect(updated.note, 'matin');
    });

    test('clearValue makes value null', () {
      final cleared = base.copyWith(clearValue: true);
      expect(cleared.value, isNull);
    });

    test('clearNote makes note null', () {
      final cleared = base.copyWith(clearNote: true);
      expect(cleared.note, isNull);
    });
  });

  group('ReadingType', () {
    test('fromId returns matching enum', () {
      expect(ReadingType.fromId('ph'), ReadingType.ph);
      expect(ReadingType.fromId('ec'), ReadingType.ec);
      expect(ReadingType.fromId('reservoirLevel'),
          ReadingType.reservoirLevel);
    });

    test('fromId on unknown id falls back to observation', () {
      expect(ReadingType.fromId('???'), ReadingType.observation);
      expect(ReadingType.fromId(null), ReadingType.observation);
    });

    test('every type has a non-empty label', () {
      for (final t in ReadingType.values) {
        expect(t.label, isNotEmpty, reason: t.id);
      }
    });
  });
}
