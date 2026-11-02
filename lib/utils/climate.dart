import '../models/country.dart';
import '../services/prefs_service.dart';

/// Seuil de température (°C) au-delà duquel on parle de « canicule ».
///
/// 30 °C est déjà exceptionnel en France mais banal sous les tropiques :
/// on n'y alerte qu'à partir de 40 °C, sinon l'alerte sonnerait
/// quasiment tous les jours de saison sèche et perdrait tout son sens.
///
/// La question est climatique, pas culturelle, et depuis le 02/11/2026
/// elle se pose à la **zone** et non à la région.
///
/// ⚠️ Elle prenait une `Region`, qui ne dit plus le climat depuis
/// l'ouverture mondiale : un jardinier de Darwin (Australie, donc
/// région tempérée) recevait une alerte canicule dès 30 °C, c'est-à-dire
/// presque tous les jours, et un Brésilien de São Paulo n'en recevait
/// qu'à 40 °C, qu'il n'atteint jamais. Une alerte qui sonne tous les
/// jours ne s'entend plus.
double heatwaveThresholdForZone(ClimateZone? zone) =>
    (zone?.isTropical ?? false) ? 40.0 : 30.0;

/// Le seuil de l'endroit où l'utilisateur jardine.
double currentHeatwaveThreshold() =>
    heatwaveThresholdForZone(PrefsService.instance.effectiveZone);
