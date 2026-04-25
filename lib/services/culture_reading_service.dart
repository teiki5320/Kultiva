import 'dart:math';

import '../models/culture_reading.dart';
import 'prefs_service.dart';

/// Service des mesures attachées aux cultures du cahier (pH, EC,
/// température, niveau réservoir, observations...).
///
/// Stockage local via SharedPreferences ; notifie via
/// [PrefsService.cultureReadingsVersion]. Pas (encore) de sync cloud :
/// la sync Supabase sera branchée dans un batch ultérieur.
class CultureReadingService {
  CultureReadingService._();
  static final CultureReadingService instance = CultureReadingService._();

  final Random _random = Random();

  List<CultureReading> loadAll() {
    return CultureReading.decodeAll(
      PrefsService.instance.cultureReadingsJson,
    );
  }

  /// Toutes les mesures d'une culture, les plus récentes en premier.
  List<CultureReading> forCulture(String cultureId) {
    final list = loadAll().where((r) => r.cultureId == cultureId).toList();
    list.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return list;
  }

  /// Mesures d'un type donné pour une culture, les plus récentes en premier.
  List<CultureReading> forCultureAndType(
    String cultureId,
    ReadingType type,
  ) {
    final list = loadAll()
        .where((r) => r.cultureId == cultureId && r.type == type)
        .toList();
    list.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return list;
  }

  /// Dernière mesure d'un type pour une culture (ou null).
  CultureReading? latest(String cultureId, ReadingType type) {
    final list = forCultureAndType(cultureId, type);
    return list.isEmpty ? null : list.first;
  }

  /// Mesures d'un type sur les [days] derniers jours, ordre chronologique
  /// croissant (utile pour tracer une sparkline).
  List<CultureReading> recent(
    String cultureId,
    ReadingType type, {
    int days = 14,
  }) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final list = forCultureAndType(cultureId, type)
        .where((r) => r.recordedAt.isAfter(cutoff))
        .toList();
    list.sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    return list;
  }

  Future<CultureReading> add({
    required String cultureId,
    required ReadingType type,
    required String unit,
    DateTime? recordedAt,
    double? value,
    String? note,
  }) async {
    final reading = CultureReading(
      id: _generateId(),
      cultureId: cultureId,
      recordedAt: recordedAt ?? DateTime.now(),
      type: type,
      unit: unit,
      value: value,
      note: note,
    );
    final list = loadAll()..add(reading);
    await _persist(list);
    return reading;
  }

  Future<void> update(CultureReading updated) async {
    final list = loadAll();
    final i = list.indexWhere((r) => r.id == updated.id);
    if (i == -1) return;
    list[i] = updated;
    await _persist(list);
  }

  Future<void> remove(String id) async {
    final list = loadAll()..removeWhere((r) => r.id == id);
    await _persist(list);
  }

  /// Supprime toutes les mesures d'une culture (à appeler quand on
  /// supprime la culture elle-même).
  Future<void> removeForCulture(String cultureId) async {
    final list = loadAll()..removeWhere((r) => r.cultureId == cultureId);
    await _persist(list);
  }

  Future<void> _persist(List<CultureReading> list) async {
    await PrefsService.instance.setCultureReadingsJson(
      CultureReading.encodeAll(list),
    );
  }

  String _generateId() {
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36);
    return 'rd_${ts}_$rand';
  }
}
