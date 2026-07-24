import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/models/watering_advice.dart';
import 'package:kultiva/models/weather_data.dart';
import 'package:kultiva/services/watering_advisor.dart';

/// Construit une entrée de culture avec les champs essentiels pour les tests.
CultureEntry _culture({
  List<DateTime>? wateredAt,
}) {
  return CultureEntry(
    id: 'test-001',
    vegetableId: 'tomate',
    startedAt: DateTime(2025, 4, 1),
    wateredAt: wateredAt ?? const <DateTime>[],
  );
}

/// Construit un WeatherData de test avec 15 jours de données (index 7 = aujourd'hui).
///
/// [precipitations] peut être fourni explicitement (15 valeurs) ou construit
/// depuis les helpers [pastPrecip] (8 valeurs, indices 0-7) et [futurePrecip]
/// (7 valeurs, indices 8-14).
///
/// [tempMax] : températures max quotidiennes (15 valeurs). Par défaut 20 °C.
WeatherData _weather({
  List<double>? precipitations,
  List<double>? pastPrecip,
  List<double>? futurePrecip,
  List<double>? tempMax,
}) {
  final precip = precipitations ??
      <double>[
        ...(pastPrecip ?? List<double>.filled(8, 0)),
        ...(futurePrecip ?? List<double>.filled(7, 0)),
      ];
  return WeatherData(
    latitude: 48.8566,
    longitude: 2.3522,
    currentTemp: 18.0,
    currentWeatherCode: 0,
    dailyPrecipitation: precip,
    dailyDates: List<String>.generate(
      precip.length,
      (i) => DateTime(2025, 5, 1 + i).toIso8601String().substring(0, 10),
    ),
    dailyTempMax: tempMax ?? List<double>.filled(precip.length, 20.0),
    dailyTempMin: List<double>.filled(precip.length, 10.0),
  );
}

void main() {
  group('suggestWatering — météo nulle', () {
    test('retourne null quand weather est null', () {
      final result = suggestWatering(_culture(), null);
      expect(result, isNull);
    });
  });

  group('suggestWatering — pluie à venir (skip)', () {
    test('>= 5 mm de pluie dans les 48 h prochaines → skip', () {
      // Index 8 et 9 = demain et après-demain
      final weather = _weather(
        futurePrecip: [3.0, 3.0, 0, 0, 0, 0, 0],
      );
      final result = suggestWatering(_culture(), weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.skip));
    });

    test('exactement 5 mm dans les 48 h prochaines → skip', () {
      final weather = _weather(
        futurePrecip: [2.5, 2.5, 0, 0, 0, 0, 0],
      );
      final result = suggestWatering(_culture(), weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.skip));
    });

    test('4.9 mm dans les 48 h prochaines → pas de skip pluie future', () {
      final weather = _weather(
        futurePrecip: [2.5, 2.4, 0, 0, 0, 0, 0],
      );
      final result = suggestWatering(_culture(), weather);
      expect(result, isNotNull);
      expect(result!.urgency, isNot(equals(WateringUrgency.skip)));
    });
  });

  group('suggestWatering — pluie récente (skip)', () {
    test('>= 5 mm de pluie dans les 48 h passées → skip', () {
      // Index 6 = hier, Index 7 = aujourd'hui
      final weather = _weather(
        pastPrecip: [0, 0, 0, 0, 0, 0, 3.0, 3.0],
      );
      // Arrosage récent pour ne pas déclencher overdue/dueSoon
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(hours: 6))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.skip));
    });
  });

  group('suggestWatering — canicule (heatwave)', () {
    test('Tmax >= 30 °C et pas d\'arrosage aujourd\'hui → heatwave', () {
      final tempMax = List<double>.filled(15, 20.0);
      tempMax[7] = 35.0; // Index 7 = aujourd'hui
      final weather = _weather(tempMax: tempMax);
      // Dernier arrosage hier (>= 1 jour)
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(days: 2))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.heatwave));
    });

    test('Tmax = 29 °C → pas de heatwave', () {
      final tempMax = List<double>.filled(15, 20.0);
      tempMax[7] = 29.0;
      final weather = _weather(tempMax: tempMax);
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(days: 2))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, isNot(equals(WateringUrgency.heatwave)));
    });
  });

  group('suggestWatering — sécheresse (overdue)', () {
    test('>= 5 jours sans arrosage + 3 jours secs consécutifs → overdue', () {
      // Pas de pluie sur les 8 derniers jours (tout à 0 → consecutiveDryDays >= 3)
      final weather = _weather();
      // Dernier arrosage il y a 6 jours
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(days: 6))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.overdue));
    });

    test('jamais arrosé + temps sec → overdue', () {
      final weather = _weather();
      final culture = _culture(); // wateredAt vide → daysSinceWater = 999
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.overdue));
    });
  });

  group('suggestWatering — arrosage bientôt (dueSoon)', () {
    test('>= 3 jours sans arrosage mais < 5 jours, temps sec → dueSoon', () {
      final weather = _weather();
      // Dernier arrosage il y a 3 jours
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(days: 3))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.dueSoon));
    });
  });

  group('suggestWatering — tout va bien (ok)', () {
    test('arrosage récent (< 3 jours) et temps calme → ok', () {
      final weather = _weather();
      // Dernier arrosage il y a quelques heures
      final culture = _culture(
        wateredAt: [DateTime.now().subtract(const Duration(hours: 12))],
      );
      final result = suggestWatering(culture, weather);
      expect(result, isNotNull);
      expect(result!.urgency, equals(WateringUrgency.ok));
    });
  });

  group('WateringUrgency enum', () {
    test('contient 5 valeurs', () {
      expect(WateringUrgency.values.length, equals(5));
    });

    test('les valeurs sont dans l\'ordre attendu', () {
      expect(
          WateringUrgency.values,
          equals(<WateringUrgency>[
            WateringUrgency.skip,
            WateringUrgency.ok,
            WateringUrgency.dueSoon,
            WateringUrgency.overdue,
            WateringUrgency.heatwave,
          ]));
    });
  });

  group('WateringAdvice construction', () {
    test('les champs sont correctement assignés', () {
      const advice = WateringAdvice(
        urgency: WateringUrgency.ok,
        emoji: '✅',
        message: 'Tout va bien.',
      );
      expect(advice.urgency, equals(WateringUrgency.ok));
      expect(advice.emoji, equals('✅'));
      expect(advice.message, equals('Tout va bien.'));
    });
  });
}
