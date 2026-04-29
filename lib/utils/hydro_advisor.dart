import '../models/culture_entry.dart';
import '../models/culture_reading.dart';
import '../models/vegetable.dart';
import 'reading_targets.dart';

/// Niveau d'un conseil affiché dans le sheet « Mes mesures du jour ».
enum AdviceLevel { ok, warn, bad }

/// Un conseil ponctuel à afficher dans le panneau de résultats. Pensé
/// pour un producteur amateur : pas de jargon, une action concrète à
/// faire dans la journée.
class HydroAdvice {
  final String emoji;
  final String title;
  final String body;
  final String? action;
  final AdviceLevel level;

  const HydroAdvice({
    required this.emoji,
    required this.title,
    required this.body,
    this.action,
    required this.level,
  });
}

/// Multiplicateurs d'EC à appliquer à la fourchette végétative pour
/// dériver la fourchette d'une autre phase. Valeurs validées sur la
/// majorité des cultures hydro amateurs.
double _ecMultiplier(GrowthPhase phase) {
  switch (phase) {
    case GrowthPhase.seedling:
      return 0.55;
    case GrowthPhase.vegetative:
      return 1.0;
    case GrowthPhase.flowering:
      return 1.15;
    case GrowthPhase.fruiting:
      return 1.30;
  }
}

/// Décale la fourchette d'humidité ambiante selon la phase. Les
/// plantules veulent +10% d'humidité ; la fructification −5%.
double _humidityShift(GrowthPhase phase) {
  switch (phase) {
    case GrowthPhase.seedling:
      return 10;
    case GrowthPhase.vegetative:
      return 0;
    case GrowthPhase.flowering:
      return -5;
    case GrowthPhase.fruiting:
      return -5;
  }
}

({double min, double max}) _ecRange(HydroProfile profile, GrowthPhase phase) {
  final m = _ecMultiplier(phase);
  return (min: profile.ecVegMin * m, max: profile.ecVegMax * m);
}

({double min, double max}) _humidityRange(
  HydroProfile profile,
  GrowthPhase phase,
) {
  final shift = _humidityShift(phase);
  return (
    min: (profile.airHumidityMin + shift).clamp(30.0, 90.0),
    max: (profile.airHumidityMax + shift).clamp(30.0, 95.0),
  );
}

/// Génère la liste des conseils pour les 4 mesures du jour.
///
/// [veg] détermine les fourchettes idéales si un [HydroProfile] est
/// défini ; sinon on retombe sur les ranges génériques de
/// [reading_targets.dart].
List<HydroAdvice> generateHydroAdvice({
  required Vegetable veg,
  required GrowthPhase phase,
  double? ph,
  double? ec,
  double? waterTempC,
  double? airHumidityPct,
}) {
  final profile = veg.hydroProfile;
  final advices = <HydroAdvice>[];
  final vegName = veg.name.toLowerCase();

  // ─── pH ────────────────────────────────────────────────────────────
  if (ph != null) {
    final phMin = profile?.phMin ?? 5.8;
    final phMax = profile?.phMax ?? 6.3;
    if (ph >= phMin && ph <= phMax) {
      advices.add(HydroAdvice(
        emoji: '✅',
        title: 'pH parfait',
        body: 'Tu es à ${ph.toStringAsFixed(1)} — idéal pour ta $vegName.',
        level: AdviceLevel.ok,
      ));
    } else if (ph < phMin) {
      final delta = (phMin - ph).abs();
      final severe = delta > 0.5;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '🟧',
        title: severe ? 'pH beaucoup trop bas' : 'pH un peu bas',
        body:
            'Tu es à ${ph.toStringAsFixed(1)}, l\'idéal pour ta $vegName c\'est '
            '${phMin.toStringAsFixed(1)}-${phMax.toStringAsFixed(1)}. Un pH trop '
            'acide bloque l\'absorption du calcium et du magnésium.',
        action: 'Ajoute quelques gouttes de pH Up et remesure dans 30 min.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    } else {
      final delta = (ph - phMax).abs();
      final severe = delta > 0.5;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '🟧',
        title: severe ? 'pH beaucoup trop haut' : 'pH un peu haut',
        body:
            'Tu es à ${ph.toStringAsFixed(1)}, l\'idéal pour ta $vegName c\'est '
            '${phMin.toStringAsFixed(1)}-${phMax.toStringAsFixed(1)}. Un pH trop '
            'basique bloque le fer et le manganèse — feuilles qui jaunissent.',
        action: 'Ajoute quelques gouttes de pH Down et remesure dans 30 min.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    }
  }

  // ─── EC (engrais) ──────────────────────────────────────────────────
  if (ec != null) {
    final range = profile != null
        ? _ecRange(profile, phase)
        : _genericEc(phase);
    if (ec >= range.min && ec <= range.max) {
      advices.add(HydroAdvice(
        emoji: '✅',
        title: 'Engrais bien dosés',
        body: 'Concentration ${ec.toStringAsFixed(1)} mS/cm — '
            'parfait pour ta $vegName en ${phase.label.toLowerCase()}.',
        level: AdviceLevel.ok,
      ));
    } else if (ec < range.min) {
      final delta = range.min - ec;
      final severe = delta > 0.4;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '🟧',
        title: 'Engrais trop dilués',
        body:
            'Tu es à ${ec.toStringAsFixed(1)}, l\'idéal pour ta $vegName en '
            '${phase.label.toLowerCase()} c\'est '
            '${range.min.toStringAsFixed(1)}-${range.max.toStringAsFixed(1)}. '
            'Tes plantes ont faim et vont ralentir.',
        action:
            'Ajoute 5 mL de partie A (croissance) dans ton réservoir, '
            'mélange et remesure demain.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    } else {
      final delta = ec - range.max;
      final severe = delta > 0.5;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '🟧',
        title: 'Engrais trop concentrés',
        body:
            'Tu es à ${ec.toStringAsFixed(1)}, l\'idéal pour ta $vegName en '
            '${phase.label.toLowerCase()} c\'est '
            '${range.min.toStringAsFixed(1)}-${range.max.toStringAsFixed(1)}. '
            'Risque de brûler les racines.',
        action:
            severe
                ? 'Vide à moitié le réservoir et remplis avec de l\'eau pure.'
                : 'Ajoute 1L d\'eau pure dans ton réservoir et remesure.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    }
  }

  // ─── Température de l'eau ─────────────────────────────────────────
  if (waterTempC != null) {
    final tMin = profile?.waterTempMin ?? 18;
    final tMax = profile?.waterTempMax ?? 22;
    if (waterTempC >= tMin && waterTempC <= tMax) {
      advices.add(HydroAdvice(
        emoji: '✅',
        title: 'Eau à bonne température',
        body: '${waterTempC.toStringAsFixed(0)}°C — parfait. À cette '
            'température l\'eau garde bien son oxygène.',
        level: AdviceLevel.ok,
      ));
    } else if (waterTempC < tMin) {
      advices.add(HydroAdvice(
        emoji: '🟦',
        title: 'Eau un peu froide',
        body:
            'Tu es à ${waterTempC.toStringAsFixed(0)}°C, l\'idéal c\'est '
            '${tMin.toStringAsFixed(0)}-${tMax.toStringAsFixed(0)}°C. '
            'Les racines absorbent moins bien les nutriments.',
        action:
            'Si possible, place le réservoir dans une pièce plus chaude '
            'ou utilise un chauffage d\'aquarium 25W.',
        level: AdviceLevel.warn,
      ));
    } else {
      final delta = waterTempC - tMax;
      final severe = delta > 4;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '🟧',
        title: severe ? 'Eau trop chaude — danger' : 'Eau un peu chaude',
        body:
            'Tu es à ${waterTempC.toStringAsFixed(0)}°C, l\'idéal c\'est '
            '${tMin.toStringAsFixed(0)}-${tMax.toStringAsFixed(0)}°C. '
            'L\'eau chaude perd son oxygène et favorise la pourriture des '
            'racines (couleur brune, odeur).',
        action: severe
            ? 'Ajoute des bouteilles d\'eau congelées et baisse la T° dans '
                'l\'heure. Vérifie que le réservoir est à l\'ombre.'
            : 'Couvre le réservoir pour bloquer le soleil. Ajoute une bouteille '
                'd\'eau fraîche.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    }
  }

  // ─── Humidité ambiante ────────────────────────────────────────────
  if (airHumidityPct != null) {
    final range = profile != null
        ? _humidityRange(profile, phase)
        : _genericHumidity(phase);
    if (airHumidityPct >= range.min && airHumidityPct <= range.max) {
      advices.add(HydroAdvice(
        emoji: '✅',
        title: 'Air parfait',
        body: '${airHumidityPct.toStringAsFixed(0)}% d\'humidité — idéal pour '
            'ta $vegName en ${phase.label.toLowerCase()}.',
        level: AdviceLevel.ok,
      ));
    } else if (airHumidityPct < range.min) {
      final delta = range.min - airHumidityPct;
      final severe = delta > 15;
      advices.add(HydroAdvice(
        emoji: severe ? '🔥' : '💨',
        title: severe ? 'Air vraiment trop sec' : 'Air un peu sec',
        body:
            'Tu es à ${airHumidityPct.toStringAsFixed(0)}%, l\'idéal pour ta '
            '$vegName en ${phase.label.toLowerCase()} c\'est '
            '${range.min.toStringAsFixed(0)}-${range.max.toStringAsFixed(0)}%. '
            'Tes plantes ferment leurs pores et arrêtent de boire.',
        action: severe
            ? 'Pose un humidificateur près des plants. En attendant, '
                'vaporise les feuilles 2-3 fois dans la journée.'
            : 'Pose un bac d\'eau ou une serviette humide près des plants.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    } else {
      final delta = airHumidityPct - range.max;
      final severe = delta > 15;
      advices.add(HydroAdvice(
        emoji: severe ? '🟥' : '💧',
        title: severe ? 'Air saturé — danger moisissure' : 'Air un peu humide',
        body:
            'Tu es à ${airHumidityPct.toStringAsFixed(0)}%, l\'idéal c\'est '
            '${range.min.toStringAsFixed(0)}-${range.max.toStringAsFixed(0)}%. '
            'Risque de moisissure (oïdium, botrytis) sur les feuilles et fleurs.',
        action: severe
            ? 'Aère la pièce immédiatement et installe un déshumidificateur. '
                'Espace tes plants pour faire circuler l\'air.'
            : 'Aère la pièce 10 min. Espace mieux tes plants.',
        level: severe ? AdviceLevel.bad : AdviceLevel.warn,
      ));
    }
  }

  return advices;
}

({double min, double max}) _genericEc(GrowthPhase phase) {
  final t = hydroTargetFor(ReadingType.ec, phase);
  if (t != null) return (min: t.warnLow, max: t.warnHigh);
  return (min: 1.2, max: 2.0);
}

({double min, double max}) _genericHumidity(GrowthPhase phase) {
  switch (phase) {
    case GrowthPhase.seedling:
      return (min: 65, max: 80);
    case GrowthPhase.vegetative:
      return (min: 55, max: 70);
    case GrowthPhase.flowering:
      return (min: 45, max: 60);
    case GrowthPhase.fruiting:
      return (min: 45, max: 60);
  }
}

/// Recommandation de hauteur de lampe LED selon la phase et la
/// puissance, exprimée en langage simple. Le multiplicateur sur la
/// distance vient de la formule : plus la lampe est puissante, plus
/// elle doit être haute (sinon brûlure des feuilles).
({double min, double max, String advice}) recommendedLampHeight({
  required GrowthPhase phase,
  required int watts,
}) {
  final base = recommendedLedDistance(phase);
  // Coef puissance : 50W = 0.7×, 100W = 1.0×, 200W = 1.3×, 300W = 1.5×.
  final coef = (0.6 + watts / 200).clamp(0.6, 1.6);
  final min = base.min * coef;
  final max = base.max * coef;
  final ideal = base.ideal * coef;
  String advice;
  switch (phase) {
    case GrowthPhase.seedling:
      advice = 'Mets ta lampe à ${ideal.toStringAsFixed(0)} cm au-dessus '
          'des plants. Plus haute = plantules qui filent vers la lumière.';
      break;
    case GrowthPhase.vegetative:
      advice = 'Lampe à ${ideal.toStringAsFixed(0)} cm — c\'est l\'idéal '
          'pour la croissance des feuilles.';
      break;
    case GrowthPhase.flowering:
      advice = 'Descends ta lampe à ${ideal.toStringAsFixed(0)} cm pour '
          'donner plus de lumière aux fleurs.';
      break;
    case GrowthPhase.fruiting:
      advice = 'Lampe à ${ideal.toStringAsFixed(0)} cm — la fructification '
          'demande beaucoup de lumière.';
      break;
  }
  return (min: min, max: max, advice: advice);
}
