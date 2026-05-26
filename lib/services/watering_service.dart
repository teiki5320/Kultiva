import '../data/vegetables_base.dart';
import '../models/watering_alert.dart';
import 'weather_service.dart';

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
