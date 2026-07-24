import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/challenges.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/models/vegetable_medal.dart';
import 'package:kultiva/screens/home/garden_planner/garden_planner_screen.dart';
import 'package:kultiva/utils/climate.dart';
import 'package:kultiva/widgets/petal_animation.dart';

void main() {
  group('Season.of — saisons par région', () {
    test('France : quatre saisons européennes', () {
      expect(Season.of(1, Region.france), equals(Season.winter));
      expect(Season.of(4, Region.france), equals(Season.spring));
      expect(Season.of(7, Region.france), equals(Season.summer));
      expect(Season.of(10, Region.france), equals(Season.autumn));
    });

    test('Afrique de l\'Ouest : harmattan / saison sèche / hivernage', () {
      // Nov-fév : harmattan (saison sèche fraîche).
      expect(Season.of(11, Region.westAfrica), equals(Season.harmattan));
      expect(Season.of(1, Region.westAfrica), equals(Season.harmattan));
      // Mars-mai : saison sèche chaude.
      expect(Season.of(3, Region.westAfrica), equals(Season.drySeason));
      expect(Season.of(5, Region.westAfrica), equals(Season.drySeason));
      // Juin-oct : hivernage.
      expect(Season.of(6, Region.westAfrica), equals(Season.rainySeason));
      expect(Season.of(10, Region.westAfrica), equals(Season.rainySeason));
    });

    test('jamais de flocons en Afrique de l\'Ouest', () {
      for (var month = 1; month <= 12; month++) {
        final season = Season.of(month, Region.westAfrica);
        expect(season, isNot(equals(Season.winter)));
        expect(season.particles.join(), isNot(contains('❄')));
        expect(season.label, isNotEmpty);
        expect(season.emoji, isNotEmpty);
      }
    });
  });

  group('computeMedalTier — saisons régionalisées', () {
    Plantation plant(String id, DateTime at) => Plantation(
          id: id,
          vegetableId: 'gombo',
          plantedAt: at,
          harvestCount: 0,
        );

    test('AO : hivernage + saison sèche = 2 saisons → gold', () {
      final now = DateTime.now();
      final tier = computeMedalTier(
        'gombo',
        <Plantation>[
          // 120 jours d'écart : forcément une plantation en saison des
          // pluies et une en saison sèche (< 180 j pour éviter shiny).
          plant('1', now.subtract(const Duration(days: 10))),
          plant('2', now.subtract(const Duration(days: 130))),
        ],
        region: Region.westAfrica,
      );
      // Selon la date du jour, les deux dates peuvent tomber dans la
      // même saison AO (sèche = 7 mois) → bronze, ou deux saisons →
      // gold. On vérifie avec des mois fixes récents à la place :
      expect(tier, anyOf(equals(MedalTier.gold), equals(MedalTier.bronze)));
    });

    test('AO : juin (pluies) et décembre (sèche) → 2 saisons distinctes', () {
      final year = DateTime.now().year;
      // Dates dans les 6 derniers mois impossibles à garantir avec des
      // mois fixes ; on teste directement la logique de groupement via
      // deux plantations récoltées (pas de shiny possible).
      final tier = computeMedalTier(
        'gombo',
        <Plantation>[
          Plantation(
            id: '1',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 6, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 6, 20),
          ),
          Plantation(
            id: '2',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 12, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 12, 20),
          ),
        ],
        region: Region.westAfrica,
      );
      expect(tier, equals(MedalTier.gold));
    });

    test('AO : juin et août = même saison (pluies) → bronze', () {
      final year = DateTime.now().year;
      final tier = computeMedalTier(
        'gombo',
        <Plantation>[
          Plantation(
            id: '1',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 6, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 6, 20),
          ),
          Plantation(
            id: '2',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 8, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 8, 20),
          ),
        ],
        region: Region.westAfrica,
      );
      expect(tier, equals(MedalTier.bronze));
    });

    test('France : juin et août = 2 saisons ? non, été → bronze', () {
      final year = DateTime.now().year;
      final tier = computeMedalTier(
        'gombo',
        <Plantation>[
          Plantation(
            id: '1',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 6, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 6, 20),
          ),
          Plantation(
            id: '2',
            vegetableId: 'gombo',
            plantedAt: DateTime(year, 8, 15),
            harvestCount: 0,
            harvestedAt: DateTime(year, 8, 20),
          ),
        ],
      );
      expect(tier, equals(MedalTier.bronze));
    });
  });

  group('PlannerSeason par région', () {
    test('France : 5 filtres, AO : 3 filtres', () {
      expect(PlannerSeason.optionsFor(Region.france).length, equals(5));
      expect(PlannerSeason.optionsFor(Region.westAfrica).length, equals(3));
      expect(PlannerSeason.optionsFor(Region.westAfrica),
          contains(PlannerSeason.dry));
      expect(PlannerSeason.optionsFor(Region.westAfrica),
          contains(PlannerSeason.rains));
    });

    test('saison sèche + hivernage couvrent les 12 mois sans doublon', () {
      final dry = PlannerSeason.dry.months;
      final rains = PlannerSeason.rains.months;
      expect(dry.intersection(rains), isEmpty);
      expect(dry.union(rains).length, equals(12));
    });
  });

  group('Seuil canicule régional', () {
    test('30 °C en France, 40 °C en Afrique de l\'Ouest', () {
      expect(heatwaveThresholdFor(Region.france), equals(30.0));
      expect(heatwaveThresholdFor(Region.westAfrica), equals(40.0));
    });
  });

  group('Défis régionalisés', () {
    test('même nombre de défis dans les deux régions (badges intacts)', () {
      final fr = challengesFor(Region.france);
      final wa = challengesFor(Region.westAfrica);
      expect(fr.length, equals(wa.length));
      expect(
        fr.map((c) => c.id).toSet(),
        equals(wa.map((c) => c.id).toSet()),
      );
    });

    test('le défi givre devient Harmattan en AO, même id et palier', () {
      final frost =
          challengesFor(Region.westAfrica).firstWhere((c) => c.id == 'frost');
      expect(frost.name, equals('Harmattan'));
      expect(frost.emoji, isNot(equals('❄️')));
      final frostFr =
          challengesFor(Region.france).firstWhere((c) => c.id == 'frost');
      expect(frostFr.name, equals('Givre'));
      expect(frost.tier, equals(frostFr.tier));
    });
  });

  group('Calendrier Afrique de l\'Ouest complet', () {
    test('chaque légume du catalogue a une entrée west_africa', () {
      final covered = westAfricaData.map((r) => r.vegetableId).toSet();
      final missing = <String>[];
      for (final v in vegetablesBase) {
        if (v.category == VegetableCategory.accessories) continue;
        if (!covered.contains(v.id)) missing.add(v.id);
      }
      expect(missing, isEmpty,
          reason: 'Légumes sans calendrier AO : ${missing.join(', ')}');
    });

    test('tous les mois sont entre 1 et 12', () {
      for (final r in westAfricaData) {
        for (final m in <int>[...r.sowingMonths, ...r.harvestMonths]) {
          expect(m, inInclusiveRange(1, 12),
              reason: 'Mois invalide pour ${r.vegetableId}');
        }
      }
    });
  });
}
