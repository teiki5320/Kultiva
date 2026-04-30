import 'dart:math';

import '../models/hydro_install.dart';
import '../models/vegetable.dart';

/// Statut visuel d'un slot rempli selon son espacement aux voisins.
///
/// Vert  = distance ≥ typique du légume (idéal)
/// Jaune = distance entre min et typique (acceptable mais étroit)
/// Rouge = distance < min (trop serré, va impacter la pousse)
/// Off   = pas de profil d'espacement défini pour ce légume
enum SlotSpacingStatus { ok, warn, bad, off }

/// Calcule la position (col, row) d'un slot à partir de son index, du
/// nombre de colonnes affichées dans la grille (cf. _computeCols dans
/// hydro_install_detail_screen.dart) et de l'espacement physique entre
/// 2 trous adjacents.
({int col, int row}) _gridPosition(int index, int cols) {
  return (col: index % cols, row: index ~/ cols);
}

/// Distance physique entre 2 slots dans une grille rectangulaire,
/// exprimée en cm. Approche classique : on prend la distance
/// euclidienne en unités de slot, multipliée par l'espacement
/// physique entre 2 trous adjacents.
double distanceBetweenSlotsCm({
  required int slotA,
  required int slotB,
  required int cols,
  required double holeSpacingCm,
}) {
  final a = _gridPosition(slotA, cols);
  final b = _gridPosition(slotB, cols);
  final dCol = (a.col - b.col).abs();
  final dRow = (a.row - b.row).abs();
  final units = sqrt((dCol * dCol) + (dRow * dRow).toDouble());
  return units * holeSpacingCm;
}

/// Statut d'un slot rempli en fonction de la distance min aux autres
/// slots remplis et du profil d'espacement du légume.
///
/// [filledByVeg] est une map slotIndex → vegetableId pour tous les
/// slots actuellement remplis (y compris le slot évalué).
SlotSpacingStatus computeSlotSpacingStatus({
  required HydroInstall install,
  required int slotIndex,
  required int gridCols,
  required Vegetable vegetable,
  required Map<int, Vegetable> filledByVeg,
}) {
  final spacing = vegetable.hydroSpacing;
  if (spacing == null) return SlotSpacingStatus.off;
  if (filledByVeg.length <= 1) return SlotSpacingStatus.ok;

  double? minDistance;
  for (final entry in filledByVeg.entries) {
    if (entry.key == slotIndex) continue;
    final d = distanceBetweenSlotsCm(
      slotA: slotIndex,
      slotB: entry.key,
      cols: gridCols,
      holeSpacingCm: install.holeSpacingCm,
    );
    if (minDistance == null || d < minDistance) {
      minDistance = d;
    }
  }
  if (minDistance == null) return SlotSpacingStatus.ok;

  if (minDistance < spacing.minCm) return SlotSpacingStatus.bad;
  if (minDistance < spacing.typicalCm) return SlotSpacingStatus.warn;
  return SlotSpacingStatus.ok;
}
