import '../models/culture_entry.dart';
import '../models/culture_reading.dart';

/// Statut d'une mesure par rapport à sa zone cible.
enum ReadingStatus {
  /// Pas de cible définie ou pas de valeur saisie.
  unknown,

  /// Dans la fourchette idéale.
  ok,

  /// Légèrement hors cible.
  warn,

  /// Critique : risque immédiat pour la culture.
  bad,
}

/// Bornes utilisées pour qualifier une mesure : `[bad-, warn-, warn+, bad+]`.
/// Au-dessous de `badLow` ou au-dessus de `badHigh` → bad.
/// Entre `badLow`/`warnLow` ou `warnHigh`/`badHigh` → warn.
/// Entre `warnLow` et `warnHigh` → ok.
class ReadingTarget {
  final double badLow;
  final double warnLow;
  final double warnHigh;
  final double badHigh;
  final String unit;

  /// Texte court affiché dans la card (ex. "5.8 – 6.3").
  String get rangeLabel =>
      '${_fmt(warnLow)} – ${_fmt(warnHigh)}';

  const ReadingTarget({
    required this.badLow,
    required this.warnLow,
    required this.warnHigh,
    required this.badHigh,
    required this.unit,
  });

  ReadingStatus statusFor(double? value) {
    if (value == null) return ReadingStatus.unknown;
    if (value < badLow || value > badHigh) return ReadingStatus.bad;
    if (value < warnLow || value > warnHigh) return ReadingStatus.warn;
    return ReadingStatus.ok;
  }

  static String _fmt(double v) {
    if (v == v.roundToDouble()) return v.toStringAsFixed(0);
    return v.toStringAsFixed(1);
  }
}

/// Cibles pour une mesure hydroponique, adaptées à la phase de
/// croissance. Les fourchettes sont issues des recommandations
/// classiques pour la majorité des légumes feuilles/fruits.
ReadingTarget? hydroTargetFor(ReadingType type, GrowthPhase phase) {
  switch (type) {
    case ReadingType.ph:
      // Fourchette stable d'une phase à l'autre, légèrement plus
      // tolérante en plantule.
      switch (phase) {
        case GrowthPhase.seedling:
          return const ReadingTarget(
            badLow: 5.0, warnLow: 5.5, warnHigh: 6.5, badHigh: 7.5,
            unit: 'pH',
          );
        case GrowthPhase.vegetative:
          return const ReadingTarget(
            badLow: 5.2, warnLow: 5.8, warnHigh: 6.3, badHigh: 7.0,
            unit: 'pH',
          );
        case GrowthPhase.flowering:
        case GrowthPhase.fruiting:
          return const ReadingTarget(
            badLow: 5.3, warnLow: 5.8, warnHigh: 6.2, badHigh: 6.8,
            unit: 'pH',
          );
      }
    case ReadingType.ec:
      // L'EC monte au fur et à mesure que la plante grossit.
      switch (phase) {
        case GrowthPhase.seedling:
          return const ReadingTarget(
            badLow: 0.3, warnLow: 0.6, warnHigh: 1.2, badHigh: 1.8,
            unit: 'mS/cm',
          );
        case GrowthPhase.vegetative:
          return const ReadingTarget(
            badLow: 0.6, warnLow: 1.2, warnHigh: 2.0, badHigh: 2.6,
            unit: 'mS/cm',
          );
        case GrowthPhase.flowering:
          return const ReadingTarget(
            badLow: 0.8, warnLow: 1.4, warnHigh: 2.2, badHigh: 2.8,
            unit: 'mS/cm',
          );
        case GrowthPhase.fruiting:
          return const ReadingTarget(
            badLow: 1.0, warnLow: 1.8, warnHigh: 2.6, badHigh: 3.5,
            unit: 'mS/cm',
          );
      }
    case ReadingType.waterTemp:
      return const ReadingTarget(
        badLow: 14, warnLow: 18, warnHigh: 22, badHigh: 26, unit: '°C',
      );
    case ReadingType.reservoirLevel:
      return const ReadingTarget(
        badLow: 15, warnLow: 30, warnHigh: 100, badHigh: 100, unit: '%',
      );
    case ReadingType.soilTemp:
    case ReadingType.harvestGrams:
    case ReadingType.observation:
      return null;
  }
}

/// Compatibilité : cibles avec phase végétative par défaut.
@Deprecated('Préférer hydroTargetFor(type, phase).')
ReadingTarget? defaultHydroTarget(ReadingType type) =>
    hydroTargetFor(type, GrowthPhase.vegetative);

/// Distance LED recommandée (cm) selon la phase de croissance.
/// Plage indicative pour des LED horticoles 50-200 W ; les distances
/// exactes dépendent du modèle. Affiché à titre de garde-fou.
({double min, double max, double ideal}) recommendedLedDistance(
  GrowthPhase phase,
) {
  switch (phase) {
    case GrowthPhase.seedling:
      return (min: 50, max: 80, ideal: 60);
    case GrowthPhase.vegetative:
      return (min: 35, max: 55, ideal: 45);
    case GrowthPhase.flowering:
      return (min: 25, max: 45, ideal: 35);
    case GrowthPhase.fruiting:
      return (min: 25, max: 40, ideal: 30);
  }
}

/// Photopériode recommandée (heures/jour) selon la phase.
({double min, double max}) recommendedPhotoperiod(GrowthPhase phase) {
  switch (phase) {
    case GrowthPhase.seedling:
      return (min: 14, max: 16);
    case GrowthPhase.vegetative:
      return (min: 16, max: 18);
    case GrowthPhase.flowering:
      return (min: 12, max: 14);
    case GrowthPhase.fruiting:
      return (min: 12, max: 14);
  }
}

/// Daily Light Integral approximatif en mol·m⁻²·j⁻¹.
///
/// Approximation grossière : on prend un rendement photonique typique
/// d'une LED horticole moderne (~2.3 µmol/J) puis on rapporte la
/// quantité de photons reçue par le plant à la surface estimée par la
/// distance (cône d'éclairage simplifié).
///
/// Suffisant pour donner un indicateur "sous/sur-éclairé" ; ce n'est
/// pas une mesure de qualité scientifique.
double? estimateDli(HydroLightConfig light) {
  final watts = light.ledWatts;
  final distance = light.ledDistanceCm;
  final hours = light.hoursPerDay;
  if (watts == null || distance == null || hours <= 0) return null;

  const photonEfficiency = 2.3; // µmol/J ≈ moyennes LED full-spectrum
  // Surface couverte ≈ disque de rayon ≈ distance ; on borne à 0.04 m²
  // au minimum pour éviter les divisions absurdes à courte distance.
  final radiusM = (distance / 100.0).clamp(0.20, 1.50);
  final areaM2 = (3.14159 * radiusM * radiusM).clamp(0.04, 4.0);

  final ppfdMicromolPerSec = (watts * photonEfficiency) / areaM2;
  // DLI = PPFD * heures * 3600 / 1e6
  return ppfdMicromolPerSec * hours * 3600 / 1e6;
}

/// DLI cible (mol·m⁻²·j⁻¹) pour les légumes courants selon la phase.
({double min, double max}) targetDli(GrowthPhase phase) {
  switch (phase) {
    case GrowthPhase.seedling:
      return (min: 6, max: 12);
    case GrowthPhase.vegetative:
      return (min: 14, max: 20);
    case GrowthPhase.flowering:
      return (min: 18, max: 25);
    case GrowthPhase.fruiting:
      return (min: 20, max: 30);
  }
}

ReadingStatus dliStatus(double dli, GrowthPhase phase) {
  final t = targetDli(phase);
  if (dli < t.min * 0.6 || dli > t.max * 1.5) return ReadingStatus.bad;
  if (dli < t.min || dli > t.max) return ReadingStatus.warn;
  return ReadingStatus.ok;
}
