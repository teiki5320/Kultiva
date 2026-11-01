import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Couvre les mécanismes de fiabilité de la synchro qui vivent dans
/// PrefsService : purge complète des données au sign-out / suppression de
/// compte, et horodatage local pour le last-write-wins des préférences.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = PrefsService.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await prefs.load();
  });

  group('clearUserScopedData', () {
    test('purge toutes les données rattachées au compte', () async {
      // Données user-scoped réparties sur plusieurs sous-systèmes.
      await prefs.setPlantationsJson('[{"id":"x"}]');
      await prefs.setUnlockedBadges({'first_plant', 'streak_3'});
      await prefs.setCulturesJson('[{"id":"c"}]');
      await prefs.toggleFavorite('tomate');
      await prefs.setString('kultiva.creature.xp', '80');
      await prefs.setString('kultiva.creature.starter', 'soleia');
      await prefs.setString('kultiva.creature.name', 'Choupi');
      await prefs.setString('kultiva.creature.streak', '12');
      await prefs.setString('kultiva.challenges.v1', '{"a":"b"}');
      await prefs.setString('garden_plans_v1', '[{"id":"g"}]');
      await prefs.setString('tamassi.stats.visits', '5');
      await prefs.setString('tamassi.stats.water', '30');

      await prefs.clearUserScopedData();

      expect(prefs.plantationsJson, anyOf(isNull, '[]'));
      expect(prefs.unlockedBadges, isEmpty);
      expect(prefs.culturesJson, isNull);
      expect(prefs.favorites.value, isEmpty);
      expect(prefs.getString('kultiva.creature.xp'), isNull);
      expect(prefs.getString('kultiva.creature.starter'), isNull);
      expect(prefs.getString('kultiva.creature.name'), isNull);
      expect(prefs.getString('kultiva.creature.streak'), isNull);
      expect(prefs.getString('kultiva.challenges.v1'), isNull);
      expect(prefs.getString('garden_plans_v1'), isNull);
      expect(prefs.getString('tamassi.stats.visits'), isNull);
      expect(prefs.getString('tamassi.stats.water'), isNull);
    });

    test('conserve les préférences de l\'appareil (région, thème, son)',
        () async {
      await prefs.setRegion(Region.france);
      await prefs.setDarkMode(true);
      await prefs.setSoundEnabled(false);

      await prefs.clearUserScopedData();

      expect(prefs.region.value, Region.france);
      expect(prefs.darkMode.value, true);
      expect(prefs.soundEnabled.value, false);
    });
  });

  group('prefsUpdatedAt (last-write-wins)', () {
    test('un changement local bump le timestamp', () async {
      expect(prefs.prefsUpdatedAt, isNull);
      await prefs.setDarkMode(true);
      expect(prefs.prefsUpdatedAt, isNotNull);
    });

    test('appliquer des prefs cloud ne bump PAS le timestamp local', () async {
      expect(prefs.prefsUpdatedAt, isNull);
      await prefs.applyRemotePreferences(() async {
        await prefs.setDarkMode(true);
        await prefs.setSoundEnabled(false);
      });
      // La valeur est bien appliquée…
      expect(prefs.darkMode.value, true);
      expect(prefs.soundEnabled.value, false);
      // …mais le local n'est pas considéré comme « modifié après le cloud ».
      expect(prefs.prefsUpdatedAt, isNull);
    });
  });
}
