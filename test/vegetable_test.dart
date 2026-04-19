import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/companions.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/models/vegetable.dart';

void main() {
  group('VegetableCategory', () {
    test('all categories have a label', () {
      for (final cat in VegetableCategory.values) {
        expect(cat.label, isNotEmpty);
      }
    });

    test('all categories have an emoji', () {
      for (final cat in VegetableCategory.values) {
        expect(cat.emoji, isNotEmpty);
      }
    });
  });

  group('vegetablesBase', () {
    test('contains at least 60 vegetables', () {
      expect(vegetablesBase.length, greaterThanOrEqualTo(60));
    });

    test('all IDs are unique', () {
      final ids = vegetablesBase.map((v) => v.id).toSet();
      expect(ids.length, equals(vegetablesBase.length));
    });

    test('all vegetables have required fields', () {
      for (final v in vegetablesBase) {
        expect(v.id, isNotEmpty, reason: '${v.name} has empty id');
        expect(v.name, isNotEmpty, reason: '${v.id} has empty name');
        expect(v.emoji, isNotEmpty, reason: '${v.id} has empty emoji');
      }
    });

    test('no duplicate names', () {
      final names = vegetablesBase.map((v) => v.name).toSet();
      expect(names.length, equals(vegetablesBase.length));
    });
  });

  group('Region data — France', () {
    test('all entries reference valid vegetable IDs', () {
      final validIds = vegetablesBase.map((v) => v.id).toSet();
      for (final rd in franceData) {
        expect(validIds.contains(rd.vegetableId), isTrue,
            reason: 'France data references unknown vegetableId: ${rd.vegetableId}');
      }
    });

    test('all months are between 1 and 12', () {
      for (final rd in franceData) {
        for (final m in rd.sowingMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} sowing month out of range: $m');
        }
        for (final m in rd.harvestMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} harvest month out of range: $m');
        }
      }
    });

    test('no duplicate vegetable entries', () {
      final ids = franceData.map((rd) => rd.vegetableId).toList();
      expect(ids.toSet().length, equals(ids.length),
          reason: 'Duplicate vegetableId in France data');
    });
  });

  group('Region data — West Africa', () {
    test('all entries reference valid vegetable IDs', () {
      final validIds = vegetablesBase.map((v) => v.id).toSet();
      for (final rd in westAfricaData) {
        expect(validIds.contains(rd.vegetableId), isTrue,
            reason: 'West Africa data references unknown vegetableId: ${rd.vegetableId}');
      }
    });

    test('all months are between 1 and 12', () {
      for (final rd in westAfricaData) {
        for (final m in rd.sowingMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} sowing month out of range: $m');
        }
        for (final m in rd.harvestMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} harvest month out of range: $m');
        }
      }
    });

    test('no duplicate vegetable entries', () {
      final ids = westAfricaData.map((rd) => rd.vegetableId).toList();
      expect(ids.toSet().length, equals(ids.length),
          reason: 'Duplicate vegetableId in West Africa data');
    });
  });

  group('Companion data', () {
    test('all companion IDs reference valid vegetables', () {
      final validIds = vegetablesBase.map((v) => v.id).toSet();
      for (final entry in companionMap.entries) {
        expect(validIds.contains(entry.key), isTrue,
            reason: 'companionMap key "${entry.key}" is not a valid vegetable ID');
        for (final id in entry.value) {
          expect(validIds.contains(id), isTrue,
              reason: 'Companion "${id}" of "${entry.key}" is not a valid vegetable ID');
        }
      }
    });

    test('all incompatible IDs reference valid vegetables', () {
      final validIds = vegetablesBase.map((v) => v.id).toSet();
      for (final entry in incompatibleMap.entries) {
        expect(validIds.contains(entry.key), isTrue,
            reason: 'incompatibleMap key "${entry.key}" is not a valid vegetable ID');
        for (final id in entry.value) {
          expect(validIds.contains(id), isTrue,
              reason: 'Incompatible "${id}" of "${entry.key}" is not a valid vegetable ID');
        }
      }
    });

    test('no vegetable is both companion and incompatible', () {
      for (final vegId in companionMap.keys) {
        if (incompatibleMap.containsKey(vegId)) {
          final companions = companionMap[vegId]!.toSet();
          final incompatibles = incompatibleMap[vegId]!.toSet();
          final overlap = companions.intersection(incompatibles);
          expect(overlap, isEmpty,
              reason: '"$vegId" has overlapping companion/incompatible: $overlap');
        }
      }
    });
  });

  group('Region', () {
    test('fromId returns correct region', () {
      expect(Region.fromId('france'), equals(Region.france));
      expect(Region.fromId('west_africa'), equals(Region.westAfrica));
    });

    test('fromId defaults to france for null or unknown', () {
      expect(Region.fromId(null), equals(Region.france));
      expect(Region.fromId('unknown'), equals(Region.france));
    });
  });
}
