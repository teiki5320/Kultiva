import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/services/tamassi_stats.dart';

TamassiStats _stats({
  int waterCount = 0,
  int fertilizeCount = 0,
  int petCount = 0,
  int visitsSeen = 0,
  int morningLogins = 0,
  int nightLogins = 0,
  int rainLogins = 0,
  int snowLogins = 0,
  int sunnyLogins = 0,
  int maxStreak = 0,
  Set<String> tabsVisited = const <String>{},
  Set<String> seasonsLoggedIn = const <String>{},
  Set<String> animalsSeen = const <String>{},
  Set<String> completedChallengeIds = const <String>{},
  bool named = false,
}) {
  return TamassiStats(
    waterCount: waterCount,
    fertilizeCount: fertilizeCount,
    petCount: petCount,
    challengesCompletedCount: completedChallengeIds.length,
    visitsSeen: visitsSeen,
    morningLogins: morningLogins,
    nightLogins: nightLogins,
    rainLogins: rainLogins,
    snowLogins: snowLogins,
    sunnyLogins: sunnyLogins,
    maxStreak: maxStreak,
    tabsVisited: tabsVisited,
    seasonsLoggedIn: seasonsLoggedIn,
    animalsSeen: animalsSeen,
    completedChallengeIds: completedChallengeIds,
    named: named,
  );
}

void main() {
  group('computeUnlockedBadges', () {
    test('level 1 + no stats → only first_step', () {
      final set = computeUnlockedBadges(level: 1, stats: _stats());
      expect(set, contains('first_step'));
      expect(set.length, 1);
    });

    test('named + first water + level 15 unlocks bronze tier', () {
      final set = computeUnlockedBadges(
        level: 15,
        stats: _stats(
          named: true,
          waterCount: 1,
          fertilizeCount: 1,
          petCount: 1,
          maxStreak: 3,
          morningLogins: 1,
          completedChallengeIds: <String>{'first_sprout'},
        ),
      );
      expect(set, containsAll(<String>[
        'first_step', 'named', 'first_water', 'first_fertilize',
        'first_pet', 'first_challenge', 'streak_3', 'morning', 'level_15',
      ]));
    });

    test('level 100 unlocks arbre légendaire', () {
      final set = computeUnlockedBadges(level: 100, stats: _stats());
      expect(set, contains('level_100'));
    });

    test('40+ badges triggers rare_40', () {
      // Simule un paquet de conditions remplies.
      final set = computeUnlockedBadges(
        level: 100,
        stats: _stats(
          named: true,
          waterCount: 100,
          fertilizeCount: 100,
          petCount: 100,
          maxStreak: 100,
          morningLogins: 5,
          nightLogins: 5,
          rainLogins: 1,
          snowLogins: 1,
          sunnyLogins: 1,
          visitsSeen: 10,
          seasonsLoggedIn: <String>{'spring', 'summer', 'autumn', 'winter'},
          tabsVisited: <String>{'tamassi', 'challenges', 'badges'},
          animalsSeen: <String>{'bee', 'butterfly'},
          completedChallengeIds: const <String>{
            // Tous les 15 bronze
            'first_sprout', 'first_bloom', 'gardener_selfie', 'favorite_tool',
            'my_garden_spot', 'down_to_earth', 'sunday_harvest', 'urban_jungle',
            'surprise_flower', 'banana_scale', 'big_sunflower', 'root_reveal',
            'cute_pot', 'home_tea', 'garden_bird',
          },
        ),
      );
      expect(set, contains('rare_40'));
    });
  });
}
