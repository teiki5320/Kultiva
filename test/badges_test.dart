import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/services/garden_stats.dart';

/// Les badges ont été réécrits le 31/10/2026, quand Tamassi a été
/// supprimé : ils comptaient des caresses et des niveaux d'XP, ils
/// comptent maintenant des plants, des arrosages et des récoltes.
GardenStats _stats({
  int plantCount = 0,
  int speciesCount = 0,
  int wateringCount = 0,
  int harvestCount = 0,
  int photoCount = 0,
  int noteCount = 0,
  int favoriteCount = 0,
  int maxWateringStreak = 0,
  int morningWaterings = 0,
  int nightWaterings = 0,
  int gardenCount = 0,
  int filledCells = 0,
  bool hasFullGarden = false,
  int longestPlantDays = 0,
  Set<VegetableCategory> categoriesPlanted = const <VegetableCategory>{},
  Set<String> seasonsPlanted = const <String>{},
  Set<String> completedChallengeIds = const <String>{},
}) {
  return GardenStats(
    plantCount: plantCount,
    speciesCount: speciesCount,
    wateringCount: wateringCount,
    harvestCount: harvestCount,
    photoCount: photoCount,
    noteCount: noteCount,
    favoriteCount: favoriteCount,
    maxWateringStreak: maxWateringStreak,
    morningWaterings: morningWaterings,
    nightWaterings: nightWaterings,
    gardenCount: gardenCount,
    filledCells: filledCells,
    hasFullGarden: hasFullGarden,
    longestPlantDays: longestPlantDays,
    categoriesPlanted: categoriesPlanted,
    seasonsPlanted: seasonsPlanted,
    completedChallengeIds: completedChallengeIds,
  );
}

void main() {
  group('computeUnlockedBadges', () {
    test('un jardin vide ne débloque rien', () {
      // Avant, `first_step` était offert d'office : il récompensait le
      // choix d'un starter, c'est-à-dire l'ouverture de l'app.
      // Maintenant il faut avoir planté.
      expect(computeUnlockedBadges(stats: _stats()), isEmpty);
    });

    test('le premier plant suffit pour le premier badge', () {
      final set = computeUnlockedBadges(stats: _stats(plantCount: 1));
      expect(set, <String>{'first_step'});
    });

    test('les premiers gestes débloquent le bronze', () {
      final set = computeUnlockedBadges(
        stats: _stats(
          plantCount: 5,
          wateringCount: 5,
          noteCount: 1,
          favoriteCount: 1,
          filledCells: 1,
          gardenCount: 1,
          maxWateringStreak: 3,
          morningWaterings: 1,
          nightWaterings: 1,
          categoriesPlanted: <VegetableCategory>{
            VegetableCategory.fruits,
            VegetableCategory.flowers,
            VegetableCategory.aromatics,
          },
          completedChallengeIds: <String>{'first_sprout'},
        ),
      );
      expect(
        set,
        containsAll(<String>[
          'first_step',
          'named',
          'first_water',
          'first_fertilize',
          'first_pet',
          'first_challenge',
          'streak_3',
          'morning',
          'night',
          'explorer',
          'level_15',
          'see_bee',
          'see_butterfly',
          'first_visit',
          'water_5',
        ]),
      );
    });

    test('un jardin entièrement rempli vaut un badge or', () {
      final set = computeUnlockedBadges(stats: _stats(hasFullGarden: true));
      expect(set, contains('fertilize_100'));
    });

    test('planter aux quatre saisons', () {
      final set = computeUnlockedBadges(
        stats: _stats(
          seasonsPlanted: <String>{'hiver', 'printemps', 'ete', 'automne'},
        ),
      );
      expect(set,
          containsAll(<String>['four_seasons', 'snow_login', 'sunny_login']));
    });

    test('ultimate exige tous les autres', () {
      final set = computeUnlockedBadges(
        stats: _stats(plantCount: 100, wateringCount: 100),
      );
      expect(set, isNot(contains('ultimate')));
    });

    test('aucun badge ne dépend plus de la créature', () {
      // Garde-fou : si un critère Tamassi revenait, il serait
      // impossible à satisfaire et le badge deviendrait décoratif.
      final texte = allBadges
          .map((b) => '${b.name} ${b.description}')
          .join(' ')
          .toLowerCase();
      for (final mot in <String>['tamassi', 'starter', 'créature', 'niveau']) {
        expect(texte, isNot(contains(mot)), reason: 'mot interdit : $mot');
      }
    });

    test('les 50 badges ont un identifiant unique', () {
      final ids = allBadges.map((b) => b.id).toSet();
      expect(allBadges.length, 50);
      expect(ids.length, 50);
    });
  });

  group('GardenStats.longestStreak', () {
    test('trois jours de suite', () {
      expect(
        GardenStats.longestStreak(<DateTime>[
          DateTime(2026, 5, 1),
          DateTime(2026, 5, 2),
          DateTime(2026, 5, 3),
        ]),
        3,
      );
    });

    test('deux arrosages le même jour ne font pas deux jours', () {
      expect(
        GardenStats.longestStreak(<DateTime>[
          DateTime(2026, 5, 1, 8),
          DateTime(2026, 5, 1, 20),
        ]),
        1,
      );
    });

    test('un trou casse la série', () {
      expect(
        GardenStats.longestStreak(<DateTime>[
          DateTime(2026, 5, 1),
          DateTime(2026, 5, 2),
          DateTime(2026, 5, 9),
          DateTime(2026, 5, 10),
        ]),
        2,
      );
    });

    test('aucune date, aucune série', () {
      expect(GardenStats.longestStreak(<DateTime>[]), 0);
    });
  });
}
