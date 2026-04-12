import '../data/vegetables_base.dart';
import '../models/vegetable.dart';
import 'weather_service.dart';

/// Résultat d'analyse d'arrosage pour un légume dans le potager.
class WateringAlert {
  final Vegetable vegetable;

  /// Nombre de jours secs consécutifs.
  final int dryDays;

  /// Seuil max toléré pour ce légume.
  final int threshold;

  /// Pluie prévue dans les 3 prochains jours (mm).
  final double rainForecast;

  const WateringAlert({
    required this.vegetable,
    required this.dryDays,
    required this.threshold,
    required this.rainForecast,
  });

  /// True si le légume a besoin d'être arrosé.
  bool get needsWatering => dryDays >= threshold;

  /// True si de la pluie significative (> 2 mm) est prévue bientôt.
  bool get rainExpected => rainForecast > 2.0;

  /// Niveau d'urgence : 0 = OK, 1 = attention, 2 = urgent.
  int get urgency {
    if (!needsWatering) return 0;
    if (rainExpected) return 1; // Il va pleuvoir, pas critique.
    if (dryDays >= threshold + 2) return 2; // Très en retard.
    return 1;
  }

  /// Message lisible.
  String get message {
    if (!needsWatering) return 'Arrosage OK';
    if (rainExpected) {
      return '$dryDays jours sans pluie — pluie prévue (${rainForecast.toStringAsFixed(0)} mm)';
    }
    return '$dryDays jours sans pluie — arrosage nécessaire !';
  }

  /// Emoji d'état.
  String get emoji {
    switch (urgency) {
      case 0:
        return '💧';
      case 1:
        return '💦';
      default:
        return '🚨';
    }
  }
}

/// Service d'analyse des besoins en arrosage du potager.
class WateringService {
  WateringService._();

  /// Analyse les besoins en arrosage pour une liste d'IDs de légumes
  /// présents dans le potager, en fonction de la météo actuelle.
  static Future<List<WateringAlert>> analyzeGarden(
      List<String> vegetableIds) async {
    final weather = await WeatherService.getWeather();
    if (weather == null) return [];

    final dryDays = weather.consecutiveDryDays;
    final rain3d = weather.rainNext3Days;

    final alerts = <WateringAlert>[];
    final seen = <String>{};

    for (final id in vegetableIds) {
      if (id.isEmpty || seen.contains(id)) continue;
      seen.add(id);
      final veg = vegetablesBase.where((v) => v.id == id).firstOrNull;
      if (veg == null) continue;

      alerts.add(WateringAlert(
        vegetable: veg,
        dryDays: dryDays,
        threshold: veg.effectiveWateringDays,
        rainForecast: rain3d,
      ));
    }

    // Trier : urgents en premier.
    alerts.sort((a, b) => b.urgency.compareTo(a.urgency));
    return alerts;
  }
}
