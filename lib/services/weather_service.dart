import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

/// Données météo récupérées depuis Open-Meteo.
class WeatherData {
  final double latitude;
  final double longitude;

  /// Température actuelle (°C).
  final double currentTemp;

  /// Code météo WMO actuel (0=ciel clair, 1-3=nuageux, 51-67=pluie, etc.).
  final int currentWeatherCode;

  /// Précipitations journalières (mm) pour les 7 derniers jours + 7 prochains.
  /// Index 0 = il y a 7 jours, index 7 = aujourd'hui, index 14 = dans 7 jours.
  final List<double> dailyPrecipitation;

  /// Dates correspondantes (ISO 8601).
  final List<String> dailyDates;

  /// Températures max journalières.
  final List<double> dailyTempMax;

  /// Températures min journalières.
  final List<double> dailyTempMin;

  const WeatherData({
    required this.latitude,
    required this.longitude,
    required this.currentTemp,
    required this.currentWeatherCode,
    required this.dailyPrecipitation,
    required this.dailyDates,
    required this.dailyTempMax,
    required this.dailyTempMin,
  });

  /// Nombre de jours consécutifs sans pluie significative (< 1 mm)
  /// en comptant depuis aujourd'hui vers le passé.
  int get consecutiveDryDays {
    // Index 7 = aujourd'hui dans la liste de 15 jours (7 passés + aujourd'hui + 7 futurs)
    final todayIndex = dailyPrecipitation.length > 7 ? 7 : dailyPrecipitation.length - 1;
    int count = 0;
    for (int i = todayIndex; i >= 0; i--) {
      if (dailyPrecipitation[i] < 1.0) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  /// Pluie prévue dans les 3 prochains jours (mm cumulés).
  double get rainNext3Days {
    final todayIndex = dailyPrecipitation.length > 7 ? 7 : dailyPrecipitation.length - 1;
    double sum = 0;
    for (int i = todayIndex + 1; i <= todayIndex + 3 && i < dailyPrecipitation.length; i++) {
      sum += dailyPrecipitation[i];
    }
    return sum;
  }

  /// Label humain pour le code météo WMO.
  String get weatherLabel {
    switch (currentWeatherCode) {
      case 0:
        return 'Ciel dégagé';
      case 1:
        return 'Peu nuageux';
      case 2:
        return 'Partiellement nuageux';
      case 3:
        return 'Couvert';
      case >= 51 && <= 57:
        return 'Bruine';
      case >= 61 && <= 67:
        return 'Pluie';
      case >= 71 && <= 77:
        return 'Neige';
      case >= 80 && <= 82:
        return 'Averses';
      case >= 95 && <= 99:
        return 'Orage';
      default:
        return 'Variable';
    }
  }

  /// Emoji pour le code météo.
  String get weatherEmoji {
    switch (currentWeatherCode) {
      case 0:
        return '☀️';
      case 1 || 2:
        return '⛅';
      case 3:
        return '☁️';
      case >= 51 && <= 57:
        return '🌦️';
      case >= 61 && <= 67:
        return '🌧️';
      case >= 71 && <= 77:
        return '❄️';
      case >= 80 && <= 82:
        return '🌧️';
      case >= 95 && <= 99:
        return '⛈️';
      default:
        return '🌤️';
    }
  }
}

/// Service météo utilisant l'API Open-Meteo (gratuit, sans clé API).
class WeatherService {
  WeatherService._();

  static WeatherData? _cached;
  static DateTime? _lastFetch;

  /// Récupère les données météo. Met en cache pendant 30 minutes.
  static Future<WeatherData?> getWeather() async {
    // Cache de 30 min.
    if (_cached != null &&
        _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < const Duration(minutes: 30)) {
      return _cached;
    }

    try {
      // Récupérer la position.
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return _cached;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return _cached;
        }
      }
      if (permission == LocationPermission.deniedForever) return _cached;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      // Appel Open-Meteo.
      final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
        '?latitude=${position.latitude}'
        '&longitude=${position.longitude}'
        '&current=temperature_2m,weather_code'
        '&daily=precipitation_sum,temperature_2m_max,temperature_2m_min'
        '&timezone=auto'
        '&past_days=7'
        '&forecast_days=7',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return _cached;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final current = data['current'] as Map<String, dynamic>;
      final daily = data['daily'] as Map<String, dynamic>;

      _cached = WeatherData(
        latitude: position.latitude,
        longitude: position.longitude,
        currentTemp: (current['temperature_2m'] as num).toDouble(),
        currentWeatherCode: current['weather_code'] as int,
        dailyPrecipitation: (daily['precipitation_sum'] as List)
            .map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        dailyDates: (daily['time'] as List).cast<String>(),
        dailyTempMax: (daily['temperature_2m_max'] as List)
            .map((e) => (e as num).toDouble())
            .toList(),
        dailyTempMin: (daily['temperature_2m_min'] as List)
            .map((e) => (e as num).toDouble())
            .toList(),
      );
      _lastFetch = DateTime.now();
      return _cached;
    } catch (_) {
      return _cached;
    }
  }

  /// Force un rafraîchissement au prochain appel.
  static void invalidateCache() {
    _lastFetch = null;
  }
}
