import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/local_names.dart';
import 'package:kultiva/data/market_data.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/regional_calendar.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/regions/west_africa_zones.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

void main() {
  final catalogIds = vegetablesBase.map((v) => v.id).toSet();

  group('regionalCalendar', () {
    test('France → calendrier France quelle que soit la zone', () {
      expect(regionalCalendar(Region.france), same(franceData));
      expect(regionalCalendar(Region.france, zone: ClimateZone.sahel),
          same(franceData));
    });

    test('AO zone soudanienne/absente → base ouest-africaine', () {
      expect(regionalCalendar(Region.westAfrica), same(westAfricaData));
      expect(regionalCalendar(Region.westAfrica, zone: ClimateZone.sudan),
          same(westAfricaData));
    });

    test('AO sahel/guinéenne → applique les surcharges de zone', () {
      final sahel =
          regionalCalendar(Region.westAfrica, zone: ClimateZone.sahel);
      // Même nombre d'entrées que la base (surcharge, pas ajout).
      expect(sahel.length, equals(westAfricaData.length));
      // Le mil sahélien est resserré sur juin-juillet.
      final mil = sahel.firstWhere((r) => r.vegetableId == 'mil');
      expect(mil.sowingMonths, equals(sahelCalendar['mil']!.sowingMonths));

      final guinean =
          regionalCalendar(Region.westAfrica, zone: ClimateZone.guinean);
      final override = zoneOverride(ClimateZone.guinean, 'mais');
      if (override != null) {
        final mais = guinean.firstWhere((r) => r.vegetableId == 'mais');
        expect(mais.sowingMonths, equals(override.sowingMonths));
      }
    });

    test('les surcharges de zone ont des mois valides et ciblent le catalogue',
        () {
      for (final cal in <Map<String, ZoneMonths>>[
        sahelCalendar,
        guineanCalendar
      ]) {
        for (final entry in cal.entries) {
          expect(catalogIds, contains(entry.key),
              reason: '${entry.key} absent du catalogue');
          for (final m in <int>[
            ...entry.value.sowingMonths,
            ...entry.value.harvestMonths
          ]) {
            expect(m, inInclusiveRange(1, 12));
          }
        }
      }
    });
  });

  group('Données locales ciblent le catalogue', () {
    test('noms locaux', () {
      for (final id in localNames.keys) {
        expect(catalogIds, contains(id), reason: '$id (localNames)');
      }
    });
    test('données marché', () {
      for (final id in marketData.keys) {
        expect(catalogIds, contains(id), reason: '$id (marketData)');
        expect(marketData[id]!.priceFcfaPerKg, greaterThan(0));
        expect(marketData[id]!.yieldPerPlantKg, greaterThan(0));
      }
    });
    test('recettes', () {
      for (final entry in recipesByVegetable.entries) {
        expect(catalogIds, contains(entry.key), reason: '${entry.key} (recipes)');
        expect(entry.value, isNotEmpty);
      }
    });
  });
}
