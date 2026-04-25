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

/// Cibles par défaut pour les mesures hydroponiques. Ces valeurs sont
/// volontairement larges (V5) ; le batch 3 les rendra adaptatives à la
/// phase de croissance et au légume cultivé.
ReadingTarget? defaultHydroTarget(ReadingType type) {
  switch (type) {
    case ReadingType.ph:
      return const ReadingTarget(
        badLow: 5.0,
        warnLow: 5.5,
        warnHigh: 6.5,
        badHigh: 7.5,
        unit: 'pH',
      );
    case ReadingType.ec:
      return const ReadingTarget(
        badLow: 0.4,
        warnLow: 1.2,
        warnHigh: 2.4,
        badHigh: 3.5,
        unit: 'mS/cm',
      );
    case ReadingType.waterTemp:
      return const ReadingTarget(
        badLow: 14,
        warnLow: 18,
        warnHigh: 22,
        badHigh: 26,
        unit: '°C',
      );
    case ReadingType.reservoirLevel:
      return const ReadingTarget(
        badLow: 15,
        warnLow: 30,
        warnHigh: 100,
        badHigh: 100,
        unit: '%',
      );
    case ReadingType.soilTemp:
    case ReadingType.harvestGrams:
    case ReadingType.observation:
      return null;
  }
}
