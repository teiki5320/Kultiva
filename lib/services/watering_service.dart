import '../data/vegetables_base.dart';
import '../models/plantation.dart';
import '../models/watering_alert.dart';
import 'weather_service.dart';

/// Service d'analyse des besoins en arrosage du potager.
class WateringService {
  WateringService._();

  /// Analyse les besoins en arrosage des [plantations] en cours, en
  /// croisant la météo et **les arrosages réellement enregistrés**.
  ///
  /// Le service ne recevait qu'une liste d'identifiants d'espèces : il
  /// ne pouvait donc pas savoir qu'un plant venait d'être arrosé, et
  /// l'alerte partait quand même. Un plant arrosé ce matin n'a plus
  /// soif, même après dix jours sans pluie.
  ///
  /// Plusieurs plants d'une même espèce sont regroupés sur le plus
  /// assoiffé : la notification parle de légumes (« tes tomates ont
  /// besoin d'eau »), pas de pieds numérotés.
  static Future<List<WateringAlert>> analyzeGarden(
    List<Plantation> plantations,
  ) async {
    final weather = await WeatherService.getWeather();
    if (weather == null) return [];

    final dryDays = weather.consecutiveDryDays;
    final rain3d = weather.rainNext3Days;
    final now = DateTime.now();

    final bySpecies = <String, WateringAlert>{};

    for (final p in plantations) {
      if (p.vegetableId.isEmpty) continue;
      final veg =
          vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
      if (veg == null) continue;

      final last = p.wateredAt.isEmpty ? null : p.wateredAt.last;
      final alert = WateringAlert(
        vegetable: veg,
        dryDays: dryDays,
        threshold: veg.effectiveWateringDays,
        rainForecast: rain3d,
        daysSinceWatering: last == null ? null : now.difference(last).inDays,
      );

      final kept = bySpecies[veg.id];
      if (kept == null || alert.daysSinceWater > kept.daysSinceWater) {
        bySpecies[veg.id] = alert;
      }
    }

    // Trier : urgents en premier.
    final alerts = bySpecies.values.toList()
      ..sort((a, b) => b.urgency.compareTo(a.urgency));
    return alerts;
  }
}
