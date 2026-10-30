import 'dart:convert';

import '../data/vegetables_base.dart';
import '../models/vegetable.dart';
import 'garden_plan_service.dart';
import 'plantation_service.dart';
import 'prefs_service.dart';

/// Ce que l'utilisateur a réellement fait au jardin.
///
/// Remplace `TamassiStats`, supprimé avec la créature le 31/10/2026.
/// L'ancienne version comptait les caresses, les niveaux d'XP, les
/// connexions du matin et les visites d'autres Tamassi : des badges
/// qui récompensaient le fait de tapoter l'écran. Ceux-ci comptent des
/// plants, des arrosages et des récoltes.
///
/// Rien n'est stocké ici : tout est recalculé à la demande depuis les
/// services qui possèdent déjà la donnée. Un compteur de plus à tenir
/// à jour, c'est un compteur de plus à désynchroniser.
class GardenStats {
  final int plantCount;
  final int speciesCount;
  final int wateringCount;
  final int harvestCount;
  final int photoCount;
  final int noteCount;
  final int favoriteCount;

  /// Jours consécutifs où au moins un plant a été arrosé.
  final int maxWateringStreak;
  final int morningWaterings;
  final int nightWaterings;

  final int gardenCount;
  final int filledCells;

  /// Vrai dès qu'un jardin n'a plus une seule case libre.
  final bool hasFullGarden;

  /// Âge du plant le plus longtemps suivi, en jours.
  final int longestPlantDays;

  final Set<VegetableCategory> categoriesPlanted;

  /// Saisons civiles où l'utilisateur a planté : 'hiver', 'printemps',
  /// 'ete', 'automne'.
  final Set<String> seasonsPlanted;

  final Set<String> completedChallengeIds;

  const GardenStats({
    required this.plantCount,
    required this.speciesCount,
    required this.wateringCount,
    required this.harvestCount,
    required this.photoCount,
    required this.noteCount,
    required this.favoriteCount,
    required this.maxWateringStreak,
    required this.morningWaterings,
    required this.nightWaterings,
    required this.gardenCount,
    required this.filledCells,
    required this.hasFullGarden,
    required this.longestPlantDays,
    required this.categoriesPlanted,
    required this.seasonsPlanted,
    required this.completedChallengeIds,
  });

  static const GardenStats empty = GardenStats(
    plantCount: 0,
    speciesCount: 0,
    wateringCount: 0,
    harvestCount: 0,
    photoCount: 0,
    noteCount: 0,
    favoriteCount: 0,
    maxWateringStreak: 0,
    morningWaterings: 0,
    nightWaterings: 0,
    gardenCount: 0,
    filledCells: 0,
    hasFullGarden: false,
    longestPlantDays: 0,
    categoriesPlanted: <VegetableCategory>{},
    seasonsPlanted: <String>{},
    completedChallengeIds: <String>{},
  );

  static String seasonOf(DateTime date) {
    switch (date.month) {
      case 12:
      case 1:
      case 2:
        return 'hiver';
      case 3:
      case 4:
      case 5:
        return 'printemps';
      case 6:
      case 7:
      case 8:
        return 'ete';
      default:
        return 'automne';
    }
  }

  /// La plus longue série de jours consécutifs contenant un arrosage.
  ///
  /// Un plant arrosé deux fois le même jour ne compte qu'une fois : la
  /// série récompense la régularité, pas l'acharnement.
  static int longestStreak(Iterable<DateTime> dates) {
    final jours = dates
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet()
        .toList()
      ..sort();
    if (jours.isEmpty) return 0;
    var best = 1;
    var courant = 1;
    for (var i = 1; i < jours.length; i++) {
      if (jours[i].difference(jours[i - 1]).inDays == 1) {
        courant++;
        if (courant > best) best = courant;
      } else {
        courant = 1;
      }
    }
    return best;
  }

  /// Les défis photo déjà réalisés.
  ///
  /// Lus directement dans la clé de l'écran des défis : c'est la seule
  /// source de vérité. L'ancienne version en tenait une copie dans les
  /// stats de la créature, qui pouvait diverger.
  static Set<String> loadCompletedChallenges() {
    final raw = PrefsService.instance.getString('kultiva.challenges.v1');
    if (raw == null || raw.isEmpty) return <String>{};
    try {
      final map = (jsonDecode(raw) as Map).cast<String, dynamic>();
      return map.keys.toSet();
    } catch (_) {
      return <String>{};
    }
  }

  static GardenStats load() {
    final plants = PlantationService.instance.all;
    final plans = GardenPlanService.instance.plans.value;

    final arrosages = <DateTime>[];
    final especes = <String>{};
    final categories = <VegetableCategory>{};
    final saisons = <String>{};
    var recoltes = 0;
    var photos = 0;
    var notes = 0;
    var plusVieux = 0;

    for (final p in plants) {
      arrosages.addAll(p.wateredAt);
      especes.add(p.vegetableId);
      saisons.add(seasonOf(p.plantedAt));
      recoltes += p.harvestCount;
      photos += p.photoPaths.length;
      if ((p.note ?? '').trim().isNotEmpty) notes++;
      final fin = p.harvestedAt ?? DateTime.now();
      final jours = fin.difference(p.plantedAt).inDays;
      if (jours > plusVieux) plusVieux = jours;
      final veg = vegetableById(p.vegetableId);
      if (veg.category != VegetableCategory.accessories) {
        categories.add(veg.category);
      }
    }

    var cases = 0;
    var jardinPlein = false;
    for (final plan in plans) {
      cases += plan.cells.length;
      if (plan.cols * plan.rows > 0 &&
          plan.cells.length >= plan.cols * plan.rows) {
        jardinPlein = true;
      }
    }

    return GardenStats(
      plantCount: plants.length,
      speciesCount: especes.length,
      wateringCount: arrosages.length,
      harvestCount: recoltes,
      photoCount: photos,
      noteCount: notes,
      favoriteCount: PrefsService.instance.favorites.value.length,
      maxWateringStreak: longestStreak(arrosages),
      morningWaterings: arrosages.where((d) => d.hour < 9).length,
      nightWaterings: arrosages.where((d) => d.hour >= 21).length,
      gardenCount: plans.length,
      filledCells: cases,
      hasFullGarden: jardinPlein,
      longestPlantDays: plusVieux,
      categoriesPlanted: categories,
      seasonsPlanted: saisons,
      completedChallengeIds: loadCompletedChallenges(),
    );
  }
}
