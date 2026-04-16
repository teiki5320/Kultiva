import 'package:flutter/material.dart';

import 'plantation.dart';

/// Palier de médaille d'une espèce dans le Poussidex.
///
/// Chaque espèce de légume collectionnée peut atteindre 4 paliers en
/// fonction des actions de l'utilisateur (planter, récolter, cultiver
/// longtemps). Les paliers sont cumulatifs : pour être "shiny", il faut
/// d'abord être passé par bronze / silver / gold.
enum MedalTier {
  /// Aucune plantation de cette espèce enregistrée.
  none,

  /// 🥉 Au moins une plantation réalisée.
  bronze,

  /// 🥈 Au moins une récolte réalisée sur cette espèce.
  silver,

  /// 🥇 3 récoltes cumulées ou 2 saisons différentes avec cette espèce.
  gold,

  /// ✨ 5 récoltes cumulées ou un plant qui a survécu >= 180 jours.
  shiny,
}

extension MedalTierX on MedalTier {
  String get emoji {
    switch (this) {
      case MedalTier.none:
        return '';
      case MedalTier.bronze:
        return '🥉';
      case MedalTier.silver:
        return '🥈';
      case MedalTier.gold:
        return '🥇';
      case MedalTier.shiny:
        return '✨';
    }
  }

  String get label {
    switch (this) {
      case MedalTier.none:
        return '';
      case MedalTier.bronze:
        return 'Bronze';
      case MedalTier.silver:
        return 'Argent';
      case MedalTier.gold:
        return 'Or';
      case MedalTier.shiny:
        return 'Shiny';
    }
  }

  /// Couleur principale de l'anneau / badge. Le shiny utilise un
  /// gradient arc-en-ciel côté widget, mais on expose une teinte par
  /// défaut pour les cas où un gradient n'est pas applicable.
  Color get color {
    switch (this) {
      case MedalTier.none:
        return const Color(0xFFBDBDBD);
      case MedalTier.bronze:
        return const Color(0xFFCD7F32);
      case MedalTier.silver:
        return const Color(0xFF9AA4B0);
      case MedalTier.gold:
        return const Color(0xFFE8B923);
      case MedalTier.shiny:
        return const Color(0xFFFF5CA8);
    }
  }

  /// Ordre numérique pour comparaisons (plus c'est haut, mieux c'est).
  int get rank {
    switch (this) {
      case MedalTier.none:
        return 0;
      case MedalTier.bronze:
        return 1;
      case MedalTier.silver:
        return 2;
      case MedalTier.gold:
        return 3;
      case MedalTier.shiny:
        return 4;
    }
  }
}

/// Calcule le palier atteint pour une espèce donnée à partir de la
/// liste complète de plantations de l'utilisateur.
///
/// Règles (cumulatives) :
///  - bronze : au moins 1 plantation
///  - silver : au moins 1 récolte (harvestCount >= 1 sur au moins 1 plantation)
///  - gold   : 3 récoltes cumulées OU plantations dans >= 2 saisons
///  - shiny  : 5 récoltes cumulées OU un plant actif >= 180 jours
MedalTier computeMedalTier(
  String vegetableId,
  List<Plantation> plantations,
) {
  final mine = plantations.where((p) => p.vegetableId == vegetableId).toList();
  if (mine.isEmpty) return MedalTier.none;

  final totalHarvests =
      mine.fold<int>(0, (sum, p) => sum + p.harvestCount);

  // Saisons distinctes où cette espèce a été plantée (printemps=3-5,
  // été=6-8, automne=9-11, hiver=12,1,2).
  int seasonOf(int month) {
    if (month >= 3 && month <= 5) return 0;
    if (month >= 6 && month <= 8) return 1;
    if (month >= 9 && month <= 11) return 2;
    return 3;
  }
  final seasons = <int>{for (final p in mine) seasonOf(p.plantedAt.month)};

  final now = DateTime.now();
  final longSurvivor = mine.any(
    (p) => p.isActive && now.difference(p.plantedAt).inDays >= 180,
  );

  if (totalHarvests >= 5 || longSurvivor) return MedalTier.shiny;
  if (totalHarvests >= 3 || seasons.length >= 2) return MedalTier.gold;
  if (totalHarvests >= 1) return MedalTier.silver;
  return MedalTier.bronze;
}

/// Retourne la map {vegetableId → MedalTier} pour toutes les espèces
/// apparaissant au moins une fois dans [plantations].
Map<String, MedalTier> computeAllMedals(List<Plantation> plantations) {
  final result = <String, MedalTier>{};
  final ids = <String>{for (final p in plantations) p.vegetableId};
  for (final id in ids) {
    result[id] = computeMedalTier(id, plantations);
  }
  return result;
}
