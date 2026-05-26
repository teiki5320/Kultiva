import 'vegetable.dart';

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
