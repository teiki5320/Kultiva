import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/garden_plan.dart';

/// Service local-first pour les plans de jardin (planificateur potager carré).
///
/// Stocke tous les plans dans une seule clé SharedPreferences
/// `garden_plans_v1` (Map<String, GardenPlan> sérialisée en JSON).
/// Cohérent avec les autres services Kultiva (PrefsService,
/// CultureReadingService) : pas de framework state-management externe,
/// juste un `ValueNotifier<List<GardenPlan>>`.
class GardenPlanService {
  GardenPlanService._();
  static final GardenPlanService instance = GardenPlanService._();

  static const String _prefsKey = 'garden_plans_v1';

  /// Liste réactive des plans, triée par `updatedAt` décroissant.
  final ValueNotifier<List<GardenPlan>> plans =
      ValueNotifier<List<GardenPlan>>(<GardenPlan>[]);

  bool _loaded = false;

  /// Charge les plans depuis SharedPreferences. Idempotent.
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        plans.value = list
            .map((e) => GardenPlan.fromJson(e as Map<String, dynamic>))
            .toList()
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      } catch (_) {
        // Données corrompues → on repart à zéro plutôt que crasher.
        plans.value = <GardenPlan>[];
      }
    }
    _loaded = true;
  }

  /// Crée un nouveau plan vide. Renvoie l'objet créé.
  Future<GardenPlan> create({
    required String name,
    String? location,
    int cols = 4,
    int rows = 4,
    GardenUnit unit = GardenUnit.cm,
  }) async {
    await load();
    final now = DateTime.now();
    final plan = GardenPlan(
      id: 'plan_${now.microsecondsSinceEpoch}',
      name: name,
      location: location,
      cols: cols,
      rows: rows,
      unit: unit,
      createdAt: now,
      updatedAt: now,
    );
    plans.value = <GardenPlan>[plan, ...plans.value];
    await _persist();
    return plan;
  }

  /// Met à jour ou ajoute un plan (par id).
  Future<void> save(GardenPlan plan) async {
    await load();
    final list = List<GardenPlan>.from(plans.value);
    final idx = list.indexWhere((p) => p.id == plan.id);
    if (idx >= 0) {
      list[idx] = plan;
    } else {
      list.insert(0, plan);
    }
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    plans.value = list;
    await _persist();
  }

  /// Supprime un plan par id.
  Future<void> delete(String id) async {
    await load();
    plans.value = plans.value.where((p) => p.id != id).toList();
    await _persist();
  }

  /// Récupère un plan par id (ou null si introuvable).
  GardenPlan? byId(String id) {
    for (final p in plans.value) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(plans.value.map((p) => p.toJson()).toList());
    await prefs.setString(_prefsKey, raw);
  }

  /// Pour les tests : reset complet.
  @visibleForTesting
  Future<void> resetForTesting() async {
    plans.value = <GardenPlan>[];
    _loaded = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}
