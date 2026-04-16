import 'dart:convert';
import 'dart:math';

import '../models/plantation.dart';

/// Convertit l'ancienne représentation grille 2D (cells + watered) en
/// une liste de [Plantation]. Fonction pure, extraite pour pouvoir être
/// testée indépendamment du widget d'accueil.
///
/// Format d'entrée attendu (JSON dans [legacy]) :
///   {
///     "rows": int,
///     "cols": int,
///     "cells": [String? ...],      // rows*cols entrées ; null = vide
///     "watered": { "r_c": iso8601 } // optionnel
///   }
///
/// Retourne une liste vide si [legacy] est null/empty ou si le parsing
/// échoue. Ne throw jamais.
List<Plantation> migrateGridToPlantations(String? legacy, {int? seed}) {
  if (legacy == null || legacy.isEmpty) return <Plantation>[];
  try {
    final data = jsonDecode(legacy) as Map<String, dynamic>;
    final rows = data['rows'] as int;
    final cols = data['cols'] as int;
    final cells = (data['cells'] as List).cast<String?>();
    final watered = (data['watered'] as Map?) ?? const <String, dynamic>{};
    final migrated = <Plantation>[];
    final now = DateTime.now();
    final rng = Random(seed ?? 42);
    int idx = 0;
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final vegId = cells[r * cols + c];
        if (vegId == null) continue;
        final wIso = watered['${r}_$c'] as String?;
        final wDates = <DateTime>[];
        if (wIso != null) {
          final w = DateTime.tryParse(wIso);
          if (w != null) wDates.add(w);
        }
        migrated.add(Plantation(
          id: '${now.millisecondsSinceEpoch}_${idx++}_${rng.nextInt(99999)}',
          vegetableId: vegId,
          plantedAt: now, // date de plantation perdue par l'ancien format
          wateredAt: wDates,
        ));
      }
    }
    return migrated;
  } catch (_) {
    return <Plantation>[];
  }
}
