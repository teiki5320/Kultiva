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
    SharedPreferences.setMockInitialValues(<String, Object>{
        // ⚠️ `load()` relit les préférences et écraserait une
        // langue posée dans `setUpAll`. Elle se sème donc ici.
        'flutter.kultiva.language': 'fr',
      });
    await prefs.load();
  });

  group('clearUserScopedData', () {
    test('efface le jardin, dans tous ses sous-systèmes', () async {
      // ⚠️ Les clés de Tamassi et de l'ancienne grille ont été
      // retirées de la purge le 02/11/2026 : l'app n'a jamais été
      // publiée, donc aucun téléphone ne les porte. Les lister était
      // du ménage pour une poussière qui n'existe pas.
      await prefs.setPlantationsJson('[{"id":"x"}]');
      await prefs.setUnlockedBadges({'first_plant', 'streak_3'});
      await prefs.setCulturesJson('[{"id":"c"}]');
      await prefs.toggleFavorite('tomate');
      await prefs.setString('kultiva.challenges.v1', '{"a":"b"}');
      await prefs.setString('garden_plans_v1', '[{"id":"g"}]');

      await prefs.clearUserScopedData();

      expect(prefs.plantationsJson, anyOf(isNull, '[]'));
      expect(prefs.unlockedBadges, isEmpty);
      expect(prefs.culturesJson, isNull);
      expect(prefs.favorites.value, isEmpty);
      expect(prefs.getString('kultiva.challenges.v1'), isNull);
      expect(prefs.getString('garden_plans_v1'), isNull);
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
