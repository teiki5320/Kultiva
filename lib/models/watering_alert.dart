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

  /// Jours écoulés depuis que l'utilisateur a arrosé ce plant.
  /// `null` = aucun arrosage enregistré.
  final int? daysSinceWatering;

  const WateringAlert({
    required this.vegetable,
    required this.dryDays,
    required this.threshold,
    required this.rainForecast,
    this.daysSinceWatering,
  });

  /// Jours écoulés depuis le dernier **apport d'eau**, qu'il vienne de
  /// la pluie ou de l'arrosoir.
  ///
  /// L'alerte ne regardait que la pluie : « 5 jours sans pluie, ta
  /// tomate a besoin d'eau » partait même si l'utilisateur l'avait
  /// arrosée le matin même. Le sol n'est sec que si **ni** la pluie
  /// **ni** l'utilisateur n'ont apporté d'eau, d'où le minimum des deux.
  int get daysSinceWater {
    final watered = daysSinceWatering;
    if (watered == null) return dryDays;
    return watered < dryDays ? watered : dryDays;
  }

  /// True si le légume a besoin d'être arrosé.
  bool get needsWatering => daysSinceWater >= threshold;

  /// True si de la pluie significative (> 2 mm) est prévue bientôt.
  bool get rainExpected => rainForecast > 2.0;

  /// Niveau d'urgence : 0 = OK, 1 = attention, 2 = urgent.
  int get urgency {
    if (!needsWatering) return 0;
    if (rainExpected) return 1; // Il va pleuvoir, pas critique.
    if (daysSinceWater >= threshold + 2) return 2; // Très en retard.
    return 1;
  }

  /// Message lisible.
  String get message {
    if (!needsWatering) return 'Arrosage OK';
    if (rainExpected) {
      return '$daysSinceWater jours sans eau — pluie prévue (${rainForecast.toStringAsFixed(0)} mm)';
    }
    return '$daysSinceWater jours sans eau — arrosage nécessaire !';
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
