import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/local_names.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/regional_calendar.dart';
import 'package:kultiva/data/regions/temperate_zones.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/regions/west_africa_zones.dart';
import 'package:kultiva/data/regions/zone_shift.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

void main() {
  final catalogIds = vegetablesBase.map((v) => v.id).toSet();

  group('regionalCalendar', () {
    test('zone tempérée → la base française, intacte', () {
      final cal = regionalCalendar(Region.france, zone: ClimateZone.temperate);
      expect(cal.length, franceData.length);
      for (var i = 0; i < cal.length; i++) {
        expect(cal[i].sowingMonths, franceData[i].sowingMonths);
        expect(cal[i].harvestMonths, franceData[i].harvestMonths);
      }
    });

    test('une culture sans calendrier écrit reste dérivée par décalage',
        () {
      // ⚠️ Mis à jour le 02/11/2026. Ce test portait sur la tomate,
      // qui a depuis un calendrier **écrit** pour les deux zones
      // (`temperate_zones.dart`) : le décalage uniforme ne la décrit
      // plus. On vérifie donc la dérivation sur une culture qui n'a
      // pas de surcharge, et les calendriers écrits sont testés dans
      // `temperate_zones_test.dart`.
      const sansSurcharge = 'sarrasin';
      RegionData cal(ClimateZone z) =>
          regionalCalendar(Region.france, zone: z)
              .firstWhere((r) => r.vegetableId == sansSurcharge);

      final base =
          franceData.firstWhere((r) => r.vegetableId == sansSurcharge);
      final med = cal(ClimateZone.mediterranean);
      final cont = cal(ClimateZone.continental);

      expect(med.sowingMonths, shiftMonths(base.sowingMonths, -1));
      expect(cont.harvestMonths, shiftMonths(base.harvestMonths, 1));
      // Un calendrier dérivé doit le dire : c'est une approximation.
      expect(med.regionalNote, contains('adapté'));
      expect(cont.regionalNote, contains('adapté'));
    });

    test('le continental ne sème pas dehors en plein hiver', () {
      final cal =
          regionalCalendar(Region.france, zone: ClimateZone.continental);
      for (final r in cal) {
        // Les cultures à calendrier écrit ont leurs propres règles,
        // vérifiées dans `temperate_zones_test.dart` : l'ail se plante
        // bien en octobre, et un poivron se sème en février **à
        // l'abri**. Ici on teste la dérivation automatique.
        if (continentalCalendar.containsKey(r.vegetableId)) continue;
        // Sauf quand il ne resterait plus rien : mieux vaut une date
        // discutable qu'un légume disparu du calendrier.
        if (r.sowingMonths.length > 1) {
          expect(
            r.sowingMonths.where((m) => m >= 11 || m <= 2),
            isEmpty,
            reason: r.vegetableId,
          );
        }
      }
    });

    test('hémisphère sud : tout décalé de six mois', () {
      // Le levier de l'ouverture mondiale. Une erreur ici fait semer
      // les tomates australiennes en plein hiver.
      final nord = regionalCalendar(Region.france, zone: ClimateZone.temperate)
          .firstWhere((r) => r.vegetableId == 'tomate');
      final sud = regionalCalendar(Region.france,
              zone: ClimateZone.temperate, hemisphere: Hemisphere.south)
          .firstWhere((r) => r.vegetableId == 'tomate');
      expect(sud.sowingMonths, shiftMonths(nord.sowingMonths, 6));
      expect(sud.harvestMonths, shiftMonths(nord.harvestMonths, 6));
      expect(sud.regionalNote, contains('hémisphère sud'));
    });

    test('la base tropicale se décale aussi sous l\'équateur', () {
      final nord = regionalCalendar(Region.tropical, zone: ClimateZone.sudan);
      final sud = regionalCalendar(Region.tropical,
          zone: ClimateZone.sudan, hemisphere: Hemisphere.south);
      final a = nord.firstWhere((r) => r.vegetableId == 'tomate');
      final b = sud.firstWhere((r) => r.vegetableId == 'tomate');
      expect(b.sowingMonths, shiftMonths(a.sowingMonths, 6));
    });

    test('la région tropicale partage le calendrier ouest-africain', () {
      // Le calendrier, oui ; le contenu culturel, non — c'est toute la
      // raison d'être de Region.tropical.
      final ao = regionalCalendar(Region.westAfrica, zone: ClimateZone.sudan);
      final trop = regionalCalendar(Region.tropical, zone: ClimateZone.sudan);
      expect(trop.length, ao.length);
      for (var i = 0; i < trop.length; i++) {
        expect(trop[i].sowingMonths, ao[i].sowingMonths);
      }
    });

    test('tous les mois dérivés restent entre 1 et 12', () {
      for (final zone in ClimateZone.values) {
        for (final h in Hemisphere.values) {
          final region = zone.isTropical ? Region.tropical : Region.france;
          for (final r in regionalCalendar(region, zone: zone, hemisphere: h)) {
            for (final m in <int>[...r.sowingMonths, ...r.harvestMonths]) {
              expect(m, inInclusiveRange(1, 12),
                  reason: '${zone.name}/${h.name}/${r.vegetableId}');
            }
          }
        }
      }
    });

    test('AO zone soudanienne/absente → base ouest-africaine', () {
      expect(regionalCalendar(Region.westAfrica), same(westAfricaData));
      expect(regionalCalendar(Region.westAfrica, zone: ClimateZone.sudan),
          same(westAfricaData));
      // L'altitude tropicale suit les pluies comme le soudanien.
      expect(regionalCalendar(Region.westAfrica, zone: ClimateZone.highland),
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
    test('recettes', () {
      for (final entry in recipesByVegetable.entries) {
        expect(catalogIds, contains(entry.key),
            reason: '${entry.key} (recipes)');
        expect(entry.value, isNotEmpty);
      }
    });
  });
}
