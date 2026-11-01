import '../data/companions.dart';
import '../data/diseases.dart';
import '../models/culture_entry.dart';
import '../models/plant_advice.dart';
import '../models/plantation.dart';
import '../models/vegetable.dart';
import '../models/watering_advice.dart';
import '../models/weather_data.dart';
import '../utils/climate.dart';
import '../utils/heatwave_tips.dart';
import '../utils/phenology.dart';
import '../utils/rotation_advisor.dart';
import 'culture_service.dart';
import 'prefs_service.dart';
import 'watering_advisor.dart';

/// Construit la fiche conseil d'un plant.
///
/// Rien n'est inventé ici : le service assemble ce que l'app sait
/// déjà — la phénologie, le conseiller d'arrosage, le guide des
/// maladies, le seuil de canicule de la région, le compagnonnage, la
/// rotation. Ces données existaient toutes ; elles vivaient sur cinq
/// écrans différents, et le conseil de stade était écrit **dans un
/// widget**, ce que les règles du projet interdisent précisément pour
/// qu'on puisse le réutiliser ailleurs.
class AdviceService {
  AdviceService._();

  /// La fiche d'un plant, aujourd'hui.
  ///
  /// [weather] peut être null (hors ligne, localisation refusée) : la
  /// fiche se construit quand même, sans la section arrosage. Le
  /// stade, les maladies et la récolte ne dépendent pas du réseau.
  static PlantAdvice build({
    required Plantation plantation,
    required Vegetable vegetable,
    WeatherData? weather,
  }) {
    final jours = plantation.daysSincePlanted;
    final phase = phaseOf(plantation, vegetable);
    final observee = _observationValable(plantation);
    final hint = expectedStage(vegetable, jours);
    final region = PrefsService.instance.region.value;

    final sections = <AdviceSection>[
      AdviceSection(
        emoji: phase.emoji,
        title: 'À faire maintenant',
        body: phaseAdvice(vegetable, phase),
      ),
    ];

    // ─── Eau ───
    final eau = suggestWatering(
      plantation.lastWatered,
      weather,
      region: region,
    );
    if (eau != null) {
      sections.add(AdviceSection(
        emoji: eau.emoji,
        title: 'Eau',
        body: eau.message,
        urgent: eau.urgency == WateringUrgency.overdue ||
            eau.urgency == WateringUrgency.heatwave,
      ));
    }

    // ─── Chaleur ───
    final max = weather?.tempMaxToday;
    if (max != null && max >= heatwaveThresholdFor(region)) {
      sections.add(AdviceSection(
        emoji: '🥵',
        title: '${max.round()} °C aujourd\'hui',
        body: heatwaveTipFor(vegetable.category),
        urgent: true,
      ));
    }

    // ─── Maladies ───
    final maladies = diseaseMap[vegetable.id] ?? const <Disease>[];
    if (maladies.isNotEmpty) {
      sections.add(AdviceSection(
        emoji: '🔍',
        title: 'À surveiller',
        // Trois suffisent : une liste de cinq maladies sur une photo
        // de plant en bonne santé décourage plus qu'elle n'aide.
        body: maladies
            .take(3)
            .map((d) => '${d.name} — ${d.remedy}')
            .join('\n\n'),
      ));
    }

    // ─── Récolte ───
    if (hint != null) {
      sections.add(AdviceSection(
        emoji: hint.harvestReady ? '🧺' : '📅',
        title: hint.harvestReady ? 'C\'est le moment' : 'Récolte',
        body: hint.detail,
        urgent: hint.harvestReady,
      ));
    }

    // ─── Voisinage ───
    final amies = companionMap[vegetable.id] ?? const <String>[];
    if (amies.isNotEmpty) {
      sections.add(AdviceSection(
        emoji: '👍',
        title: 'Bons voisins',
        body: amies.take(6).join(', '),
      ));
    }

    // ─── Rotation ───
    final rotation = checkRotation(
      vegetableId: vegetable.id,
      previousCultures: CultureService.instance.ended(),
    );
    if (rotation != null) {
      sections.add(AdviceSection(
        emoji: '🔄',
        title: 'Attention à la rotation',
        body: rotation.message,
        urgent: true,
      ));
    }

    return PlantAdvice(
      vegetable: vegetable,
      phase: phase,
      phaseObserved: observee,
      daysSincePlanted: jours,
      harvestReady: hint?.harvestReady ?? false,
      sections: sections,
    );
  }

  /// Le stade retenu pour un plant : l'observation de l'utilisateur si
  /// elle est encore fraîche, sinon la déduction par la date.
  static GrowthPhase phaseOf(Plantation p, Vegetable veg) {
    if (_observationValable(p)) return p.observedPhase!;
    return deducedPhase(veg, p.daysSincePlanted);
  }

  /// Une observation se périme : un plant pousse. Au-delà de trois
  /// semaines, la déduction du jour en sait plus qu'un « il fleurit »
  /// saisi le mois dernier.
  static const int observationValidDays = 21;

  static bool _observationValable(Plantation p) {
    final phase = p.observedPhase;
    final quand = p.observedPhaseAt;
    if (phase == null || quand == null) return false;
    return DateTime.now().difference(quand).inDays <= observationValidDays;
  }

  /// Quoi faire d'un plant à ce stade.
  ///
  /// Déplacé depuis `planner_advice.dart`, où il était une méthode
  /// privée d'un widget : la fiche conseil en avait besoin, et le
  /// recopier aurait fait deux textes qui divergent.
  static String phaseAdvice(Vegetable veg, GrowthPhase phase) {
    switch (phase) {
      case GrowthPhase.seedling:
        return 'Garde le sol humide, protège des limaces et du froid '
            'avec un voile si besoin.';
      case GrowthPhase.vegetative:
        if (veg.category == VegetableCategory.fruits) {
          return 'Tuteure le plant, pince les gourmands (tomates), '
              'apporte du compost si feuilles claires.';
        }
        if (veg.category == VegetableCategory.leaves ||
            veg.category == VegetableCategory.aromatics) {
          return 'Récolte au fur et à mesure pour stimuler la repousse, '
              'arrose au pied le matin.';
        }
        return 'Le plant prend du volume — arrose régulièrement et '
            'bine le pied pour aérer le sol.';
      case GrowthPhase.flowering:
        return 'Floraison en cours : maintenir l\'arrosage régulier, '
            'apporter de la potasse (cendres de bois).';
      case GrowthPhase.fruiting:
        return 'Récolte régulière pour stimuler la production. '
            'Surveille les nuisibles et l\'humidité.';
    }
  }
}
