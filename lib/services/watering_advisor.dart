import '../models/culture_entry.dart';
import '../models/region_data.dart';
import '../models/watering_advice.dart';
import '../models/weather_data.dart';
import '../utils/climate.dart';

/// Retourne une suggestion d'arrosage pour [culture] selon la météo
/// fournie. [weather] peut être null (pas encore chargée) → renvoie
/// null. La logique reste volontairement simple :
///
/// - Si pluie >= 5 mm prévue dans les 48h → skip
/// - Si dernière pluie >= 5 mm il y a < 2 jours → skip
/// - Si sécheresse >= 5 jours sans arrosage utilisateur → overdue
/// - Si Tmax >= seuil canicule régional (30 °C France, 40 °C Afrique
///   de l'Ouest) aujourd'hui → heatwave (arrose tôt le matin)
/// - Sinon, conseil neutre selon le dernier arrosage
WateringAdvice? suggestWatering(
  CultureEntry culture,
  WeatherData? weather, {
  Region region = Region.france,
}) {
  if (weather == null) return null;

  // Index 7 = aujourd'hui dans le tableau (7 jours passés + aujourd'hui
  // + 7 futurs).
  final daily = weather.dailyPrecipitation;
  final today = daily.length > 7 ? 7 : daily.length - 1;

  final rainNext48h = <double>[
    if (today + 1 < daily.length) daily[today + 1],
    if (today + 2 < daily.length) daily[today + 2],
  ].fold<double>(0, (a, b) => a + b);

  final rainLast48h = <double>[
    if (today >= 0) daily[today],
    if (today - 1 >= 0) daily[today - 1],
  ].fold<double>(0, (a, b) => a + b);

  final lastWater = culture.lastWatering;
  final daysSinceWater =
      lastWater == null ? 999 : DateTime.now().difference(lastWater).inDays;

  final tmax =
      today < weather.dailyTempMax.length ? weather.dailyTempMax[today] : 20.0;

  if (rainNext48h >= 5) {
    return WateringAdvice(
      urgency: WateringUrgency.skip,
      emoji: '🌧️',
      message: "Pas besoin d'arroser : ${rainNext48h.toStringAsFixed(0)} mm "
          "de pluie prévus dans 48 h.",
    );
  }
  if (rainLast48h >= 5) {
    return const WateringAdvice(
      urgency: WateringUrgency.skip,
      emoji: '☔',
      message: "Sol déjà bien humide après la pluie récente. Saute "
          "l'arrosage aujourd'hui.",
    );
  }
  if (tmax >= heatwaveThresholdFor(region) && daysSinceWater >= 1) {
    return WateringAdvice(
      urgency: WateringUrgency.heatwave,
      emoji: '🥵',
      message: "Canicule prévue (${tmax.toStringAsFixed(0)}°C). Arrose tôt "
          "le matin ou en soirée, et pense au paillage.",
    );
  }
  if (daysSinceWater >= 5 && weather.consecutiveDryDays >= 3) {
    return WateringAdvice(
      urgency: WateringUrgency.overdue,
      emoji: '🚱',
      message: "Sécheresse depuis ${weather.consecutiveDryDays} jours et "
          "pas d'arrosage depuis $daysSinceWater j. C'est urgent.",
    );
  }
  if (daysSinceWater >= 3) {
    return WateringAdvice(
      urgency: WateringUrgency.dueSoon,
      emoji: '💧',
      message: "Pas d'arrosage depuis $daysSinceWater j et pas de pluie "
          "prévue. Pense à arroser ce soir.",
    );
  }
  return const WateringAdvice(
    urgency: WateringUrgency.ok,
    emoji: '✅',
    message: 'Tout va bien : sol récemment arrosé ou pluie attendue.',
  );
}
