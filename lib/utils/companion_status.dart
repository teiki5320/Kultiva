import '../data/companions.dart';

/// Statut de compagnonnage d'une case par rapport à ses voisines.
enum CompanionStatus {
  /// Au moins un voisin est explicitement compagnon, aucun n'est combatif.
  good,

  /// Au moins un voisin est explicitement combatif.
  bad,

  /// Aucune relation connue (neutre).
  neutral,
}

/// Détermine le statut de compagnonnage d'une plante par rapport à
/// la liste des voisines directes.
///
/// Renvoie `bad` dès qu'un voisin combatif est détecté.
/// Sinon `good` si au moins un voisin est explicitement compagnon.
/// Sinon `neutral`.
CompanionStatus statusFor({
  required String vegetableId,
  required Iterable<String> neighbors,
}) {
  final companions = companionMap[vegetableId] ?? const <String>[];
  final incompat = incompatibleMap[vegetableId] ?? const <String>[];
  bool hasGood = false;
  for (final n in neighbors) {
    if (incompat.contains(n)) return CompanionStatus.bad;
    if (companions.contains(n)) hasGood = true;
  }
  return hasGood ? CompanionStatus.good : CompanionStatus.neutral;
}
