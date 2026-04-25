import 'dart:math';

import '../models/culture_entry.dart';
import 'prefs_service.dart';

/// Service du cahier de culture (séparé du Poussidex).
/// Stockage local via SharedPreferences, notifie via
/// PrefsService.culturesVersion (pattern identique aux plantations).
class CultureService {
  CultureService._();
  static final CultureService instance = CultureService._();

  final Random _random = Random();

  /// Liste complète des cultures (actives + terminées).
  List<CultureEntry> loadAll() {
    return CultureEntry.decodeAll(PrefsService.instance.culturesJson);
  }

  /// Filtrées par méthode (pleine terre ou hydroponie).
  List<CultureEntry> loadByMethod(CultivationMethod method) {
    return loadAll().where((c) => c.method == method).toList();
  }

  /// Actives uniquement (endedAt == null) pour une méthode donnée,
  /// les plus récentes en premier.
  List<CultureEntry> activeByMethod(CultivationMethod method) {
    final list = loadByMethod(method).where((c) => c.isActive).toList();
    list.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return list;
  }

  /// Terminées pour une méthode, les plus récemment finies en premier.
  List<CultureEntry> endedByMethod(CultivationMethod method) {
    final list = loadByMethod(method).where((c) => !c.isActive).toList();
    list.sort((a, b) => (b.endedAt ?? b.startedAt)
        .compareTo(a.endedAt ?? a.startedAt));
    return list;
  }

  Future<CultureEntry> add({
    required CultivationMethod method,
    required String vegetableId,
    required DateTime startedAt,
    String? note,
    HydroLightConfig? light,
    String? linkedPlantationId,
  }) async {
    final id = _generateId();
    final entry = CultureEntry(
      id: id,
      method: method,
      vegetableId: vegetableId,
      startedAt: startedAt,
      note: note,
      light: method == CultivationMethod.hydroponic ? light : null,
      linkedPlantationId: linkedPlantationId,
    );
    final list = loadAll()..add(entry);
    await _persist(list);
    return entry;
  }

  Future<void> update(CultureEntry updated) async {
    final list = loadAll();
    final i = list.indexWhere((c) => c.id == updated.id);
    if (i == -1) return;
    list[i] = updated;
    await _persist(list);
  }

  Future<void> endCulture(String id, {DateTime? at}) async {
    final list = loadAll();
    final i = list.indexWhere((c) => c.id == id);
    if (i == -1) return;
    list[i] = list[i].copyWith(endedAt: at ?? DateTime.now());
    await _persist(list);
  }

  Future<void> reopen(String id) async {
    final list = loadAll();
    final i = list.indexWhere((c) => c.id == id);
    if (i == -1) return;
    list[i] = list[i].copyWith(clearEndedAt: true);
    await _persist(list);
  }

  Future<void> remove(String id) async {
    final list = loadAll()..removeWhere((c) => c.id == id);
    await _persist(list);
  }

  /// Enregistre un arrosage à [at] (ou maintenant) pour une culture
  /// pleine terre. No-op si la culture n'existe pas ou est en hydro.
  Future<void> markWatered(String id, {DateTime? at}) async {
    final list = loadAll();
    final i = list.indexWhere((c) => c.id == id);
    if (i == -1) return;
    final updated = list[i].copyWith(
      wateredAt: <DateTime>[...list[i].wateredAt, at ?? DateTime.now()],
    );
    list[i] = updated;
    await _persist(list);
  }

  Future<void> _persist(List<CultureEntry> list) async {
    await PrefsService.instance.setCulturesJson(CultureEntry.encodeAll(list));
  }

  String _generateId() {
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36);
    return 'cul_${ts}_$rand';
  }
}
