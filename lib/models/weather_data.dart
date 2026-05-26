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

  /// True si la géolocalisation n'a pas été accordée / disponible et qu'on
  /// est retombé sur Paris (48.8566, 2.3522). Permet d'afficher un badge
  /// "Paris (localisation désactivée)" dans l'écran météo.
  final bool isFallbackLocation;

  /// Nom de la ville (reverse-geocodé). Null tant que le geocoding n'a
  /// pas répondu ; `'Paris'` quand on est en fallback.
  final String? locationName;

  const WeatherData({
    required this.latitude,
    required this.longitude,
    required this.currentTemp,
    required this.currentWeatherCode,
    required this.dailyPrecipitation,
    required this.dailyDates,
    required this.dailyTempMax,
    required this.dailyTempMin,
    this.isFallbackLocation = false,
    this.locationName,
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
