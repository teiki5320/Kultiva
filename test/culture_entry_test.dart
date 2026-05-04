import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';

void main() {
  group('CultureEntry — JSON', () {
    test('round trip toJson / fromJson conserve les champs', () {
      final entry = CultureEntry(
        id: 'cul_123',
        vegetableId: 'tomate',
        startedAt: DateTime(2026, 4, 1, 10),
        note: 'variété cœur de bœuf',
        phase: GrowthPhase.vegetative,
        wateredAt: <DateTime>[
          DateTime(2026, 4, 5),
          DateTime(2026, 4, 8),
        ],
      );

      final encoded = jsonEncode(entry.toJson());
      final decoded = CultureEntry.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );

      expect(decoded.id, entry.id);
      expect(decoded.vegetableId, entry.vegetableId);
      expect(decoded.startedAt, entry.startedAt);
      expect(decoded.note, entry.note);
      expect(decoded.phase, entry.phase);
      expect(decoded.wateredAt.length, 2);
    });

    test('decodeAll filtre les anciennes entrées hydroponiques', () {
      final raw = jsonEncode(<Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'cul_old_hydro',
          'method': 'hydroponic',
          'vegetableId': 'salade',
          'startedAt': DateTime(2026, 1, 1).toIso8601String(),
          'phase': 'vegetative',
          'wateredAt': <String>[],
        },
        <String, dynamic>{
          'id': 'cul_soil',
          'method': 'soil',
          'vegetableId': 'tomate',
          'startedAt': DateTime(2026, 3, 1).toIso8601String(),
          'phase': 'seedling',
          'wateredAt': <String>[],
        },
      ]);

      final list = CultureEntry.decodeAll(raw);

      expect(list.length, 1);
      expect(list.first.id, 'cul_soil');
    });

    test('decodeAll renvoie une liste vide pour null ou string vide', () {
      expect(CultureEntry.decodeAll(null), isEmpty);
      expect(CultureEntry.decodeAll(''), isEmpty);
    });

    test('decodeAll renvoie vide si le JSON est corrompu plutôt que crasher',
        () {
      expect(CultureEntry.decodeAll('not-json'), isEmpty);
      expect(CultureEntry.decodeAll('{"foo":42}'), isEmpty);
    });
  });

  group('CultureEntry — helpers', () {
    test('lastWatering = null si jamais arrosé', () {
      final entry = CultureEntry(
        id: 'cul_a',
        vegetableId: 'carotte',
        startedAt: DateTime(2026, 4, 1),
      );
      expect(entry.lastWatering, isNull);
    });

    test('lastWatering = dernier élément de wateredAt', () {
      final last = DateTime(2026, 4, 20);
      final entry = CultureEntry(
        id: 'cul_a',
        vegetableId: 'carotte',
        startedAt: DateTime(2026, 4, 1),
        wateredAt: <DateTime>[
          DateTime(2026, 4, 5),
          DateTime(2026, 4, 12),
          last,
        ],
      );
      expect(entry.lastWatering, last);
    });

    test('isActive vrai si endedAt null', () {
      final active = CultureEntry(
        id: 'cul_a',
        vegetableId: 'carotte',
        startedAt: DateTime(2026, 4, 1),
      );
      expect(active.isActive, isTrue);

      final ended = active.copyWith(endedAt: DateTime(2026, 6, 1));
      expect(ended.isActive, isFalse);
    });

    test('wateringHistory marque les jours arrosés sur 14 jours', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final entry = CultureEntry(
        id: 'cul_a',
        vegetableId: 'carotte',
        startedAt: today.subtract(const Duration(days: 30)),
        wateredAt: <DateTime>[yesterday],
      );

      final history = entry.wateringHistory(days: 14);
      expect(history.length, 14);
      // Index 12 = hier (le plus récent est en dernier).
      expect(history[12], isTrue);
      // Aujourd'hui : pas marqué.
      expect(history[13], isFalse);
    });
  });

  group('GrowthPhase', () {
    test('toutes les phases ont un label et un emoji non vides', () {
      for (final p in GrowthPhase.values) {
        expect(p.label, isNotEmpty);
        expect(p.emoji, isNotEmpty);
      }
    });

    test('fromId tombe sur seedling pour un id inconnu', () {
      expect(GrowthPhase.fromId('chimere'), GrowthPhase.seedling);
      expect(GrowthPhase.fromId(null), GrowthPhase.seedling);
    });
  });
}
