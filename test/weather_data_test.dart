import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/weather_data.dart';

/// Couvre les deux calculs qui déclenchent les alertes d'arrosage et de
/// canicule : `consecutiveDryDays` et `rainNext3Days`.
///
/// Ils étaient entièrement découverts alors qu'ils portent une
/// fonctionnalité annoncée sur la fiche (« Ton jardin te prévient avant
/// d'avoir soif »), et qu'ils reposent sur une convention d'index
/// fragile : la série fait 15 jours, l'index 7 est aujourd'hui.
void main() {
  /// Construit une série de 15 jours à partir des précipitations fournies
  /// (index 0 = il y a 7 jours, 7 = aujourd'hui, 14 = dans 7 jours).
  WeatherData withRain(List<double> precipitation) => WeatherData(
        latitude: 48.8566,
        longitude: 2.3522,
        currentTemp: 20,
        currentWeatherCode: 0,
        dailyPrecipitation: precipitation,
        dailyDates: List<String>.generate(
          precipitation.length,
          (i) => '2026-06-${(i + 1).toString().padLeft(2, '0')}',
        ),
        dailyTempMax: List<double>.filled(precipitation.length, 25),
        dailyTempMin: List<double>.filled(precipitation.length, 14),
      );

  WeatherData avecTemperatures(List<double> tmax) => WeatherData(
        latitude: 48.8566,
        longitude: 2.3522,
        currentTemp: 20,
        currentWeatherCode: 0,
        dailyPrecipitation: List<double>.filled(tmax.length, 0),
        dailyDates: List<String>.generate(
          tmax.length,
          (i) => '2026-06-${(i + 1).toString().padLeft(2, '0')}',
        ),
        dailyTempMax: tmax,
        dailyTempMin: List<double>.filled(tmax.length, 14),
      );

  group('todayIndex', () {
    test('aujourd\'hui est le huitième jour de la série', () {
      // 7 jours passés, aujourd'hui, 7 à venir.
      expect(avecTemperatures(List<double>.filled(15, 20)).todayIndex, 7);
    });

    test('une série courte retombe sur son dernier jour', () {
      expect(avecTemperatures(List<double>.filled(3, 20)).todayIndex, 2);
    });

    test('tempMaxToday lit aujourd\'hui, pas la semaine dernière', () {
      // La carte « à faire aujourd'hui » lisait `dailyTempMax.first`,
      // c'est-à-dire la température d'il y a sept jours : l'alerte
      // canicule se déclenchait sur la météo de la semaine passée.
      final tmax = List<double>.filled(15, 18.0);
      tmax[0] = 41.0; // il y a une semaine
      tmax[7] = 24.0; // aujourd'hui
      expect(avecTemperatures(tmax).tempMaxToday, 24.0);
    });

    test('tempMaxToday vaut null sur une série vide', () {
      expect(avecTemperatures(<double>[]).tempMaxToday, isNull);
    });
  });

  group('consecutiveDryDays', () {
    test('série entièrement sèche : compte aujourd\'hui et les 7 passés', () {
      // 8 jours secs jusqu'à aujourd'hui inclus (index 0 à 7).
      final w = withRain(List<double>.filled(15, 0));
      expect(w.consecutiveDryDays, 8);
    });

    test('une pluie significative interrompt la série', () {
      final rain = List<double>.filled(15, 0.0);
      rain[5] = 4.2; // il y a 2 jours
      final w = withRain(rain);
      // On compte depuis aujourd'hui (7) vers le passé : 7, 6 → 2 jours.
      expect(w.consecutiveDryDays, 2);
    });

    test('il a plu aujourd\'hui : aucun jour sec', () {
      final rain = List<double>.filled(15, 0.0);
      rain[7] = 12.0;
      expect(withRain(rain).consecutiveDryDays, 0);
    });

    test('une pluie inférieure à 1 mm ne compte pas comme pluie', () {
      // Seuil documenté : « pluie significative » = 1 mm.
      final rain = List<double>.filled(15, 0.0);
      rain[7] = 0.9;
      expect(withRain(rain).consecutiveDryDays, 8);
      rain[7] = 1.0;
      expect(withRain(rain).consecutiveDryDays, 0);
    });

    test('la pluie à venir ne casse pas la série passée', () {
      final rain = List<double>.filled(15, 0.0);
      rain[10] = 30.0; // dans 3 jours
      expect(withRain(rain).consecutiveDryDays, 8);
    });

    test('série tronquée (moins de 8 jours) : part du dernier jour connu',
        () {
      // L'API peut renvoyer moins de jours que demandé ; le calcul
      // retombe alors sur le dernier index disponible.
      expect(withRain(<double>[0, 0, 0]).consecutiveDryDays, 3);
      expect(withRain(<double>[0, 5.0, 0]).consecutiveDryDays, 1);
    });

    test('série vide : zéro, sans lever d\'exception', () {
      expect(withRain(<double>[]).consecutiveDryDays, 0);
    });
  });

  group('rainNext3Days', () {
    test('cumule les trois jours qui suivent aujourd\'hui', () {
      final rain = List<double>.filled(15, 0.0);
      rain[8] = 1.5;
      rain[9] = 2.0;
      rain[10] = 0.5;
      rain[11] = 100.0; // 4e jour : hors fenêtre
      expect(withRain(rain).rainNext3Days, closeTo(4.0, 1e-9));
    });

    test('ignore la pluie passée et celle d\'aujourd\'hui', () {
      final rain = List<double>.filled(15, 0.0);
      rain[0] = 10.0;
      rain[7] = 10.0;
      expect(withRain(rain).rainNext3Days, 0);
    });

    test('série tronquée : ne lit pas au-delà de la fin', () {
      expect(withRain(<double>[0, 0, 3.0]).rainNext3Days, 0);
      expect(withRain(<double>[]).rainNext3Days, 0);
    });
  });

  group('libellés WMO', () {
    test('les codes courants ont un libellé et un emoji non vides', () {
      for (final code in <int>[0, 1, 2, 3, 45, 51, 61, 63, 71, 80, 95]) {
        final w = WeatherData(
          latitude: 0,
          longitude: 0,
          currentTemp: 20,
          currentWeatherCode: code,
          dailyPrecipitation: const <double>[],
          dailyDates: const <String>[],
          dailyTempMax: const <double>[],
          dailyTempMin: const <double>[],
        );
        expect(w.weatherLabel, isNotEmpty, reason: 'code $code');
        expect(w.weatherEmoji, isNotEmpty, reason: 'code $code');
      }
    });
  });
}
