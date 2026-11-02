import '../data/content_i18n.dart';
import '../data/companions.dart';
import '../data/diseases.dart';
import '../data/names_en.dart';
import '../data/ui_i18n.dart';
import '../data/vegetables_base.dart';
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
    final hint = expectedStage(vegetable, jours);
    final region = PrefsService.instance.region.value;

    final sections = <AdviceSection>[
      AdviceSection(
        emoji: phase.emoji,
        title: trUi('À faire maintenant'),
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
        title: trUi('Eau'),
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
        title: trUiArgs('{0} °C aujourd\'hui', <Object?>[max.round()]),
        body: tr(heatwaveTipFor(vegetable.category)),
        urgent: true,
      ));
    }

    // ─── Maladies ───
    final maladies = diseaseMap[vegetable.id] ?? const <Disease>[];
    if (maladies.isNotEmpty) {
      sections.add(AdviceSection(
        emoji: '🔍',
        title: trUi('À surveiller'),
        // Trois suffisent : une liste de cinq maladies sur une photo
        // de plant en bonne santé décourage plus qu'elle n'aide.
        body: maladies
            .take(3)
            .map((d) => '${d.displayName} — ${d.displayRemedy}')
            .join('\n\n'),
      ));
    }

    // ─── Récolte ───
    if (hint != null) {
      sections.add(AdviceSection(
        emoji: hint.harvestReady ? '🧺' : '📅',
        title: hint.harvestReady ? trUi('C\'est le moment') : trUi('Récolte'),
        body: hint.detail,
        urgent: hint.harvestReady,
      ));
    }

    // ─── Voisinage ───
    final amies = companionMap[vegetable.id] ?? const <String>[];
    if (amies.isNotEmpty) {
      sections.add(AdviceSection(
        emoji: '👍',
        title: trUi('Bons voisins'),
        // ⚠️ `companionMap` ne contient que des **identifiants** :
        // affichés bruts, ils donnaient « pommier, carotte » en
        // français même sous une interface anglaise, et
        // « chou_pomme » pour les ids composés.
        body: amies
            .take(6)
            .map((id) => vegetableById(id).displayName)
            .join(', '),
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
        title: trUi('Attention à la rotation'),
        body: rotation.message,
        urgent: true,
      ));
    }

    return PlantAdvice(
      vegetable: vegetable,
      phase: phase,
      daysSincePlanted: jours,
      harvestReady: hint?.harvestReady ?? false,
      sections: sections,
    );
  }

  /// Le stade retenu pour un plant, déduit de sa date de plantation.
  ///
  /// L'app n'a plus de moyen pour l'utilisateur de corriger ce stade :
  /// l'écran qui le permettait était la fiche conseil de l'onglet
  /// Photo, retiré le 01/11/2026. Le champ `observedPhase` est parti
  /// avec, plutôt que de rester un champ que rien n'écrit.
  static GrowthPhase phaseOf(Plantation p, Vegetable veg) {
    return deducedPhase(veg, p.daysSincePlanted);
  }

  /// Quoi faire d'un plant à ce stade.
  ///
  /// Déplacé depuis `planner_advice.dart`, où il était une méthode
  /// privée d'un widget : la fiche conseil en avait besoin, et le
  /// recopier aurait fait deux textes qui divergent.
  static String phaseAdvice(Vegetable veg, GrowthPhase phase) {
    switch (phase) {
      case GrowthPhase.seedling:
        return trUi('Garde le sol humide, protège des limaces et du froid '
            'avec un voile si besoin.');
      case GrowthPhase.vegetative:
        if (veg.category == VegetableCategory.fruits) {
          return trUi('Tuteure le plant, pince les gourmands (tomates), '
              'apporte du compost si feuilles claires.');
        }
        if (veg.category == VegetableCategory.leaves ||
            veg.category == VegetableCategory.aromatics) {
          return trUi('Récolte au fur et à mesure pour stimuler la repousse, '
              'arrose au pied le matin.');
        }
        return trUi('Le plant prend du volume — arrose régulièrement et '
            'bine le pied pour aérer le sol.');
      case GrowthPhase.flowering:
        return trUi('Floraison en cours : maintenir l\'arrosage régulier, '
            'apporter de la potasse (cendres de bois).');
      case GrowthPhase.fruiting:
        return trUi('Récolte régulière pour stimuler la production. '
            'Surveille les nuisibles et l\'humidité.');
    }
  }
}
