import 'dart:convert';

/// Phase de croissance d'un plant (pleine terre). Utilisée pour adapter
/// les conseils d'arrosage et les rappels selon le stade.
enum GrowthPhase {
  seedling('seedling'),
  vegetative('vegetative'),
  flowering('flowering'),
  fruiting('fruiting');

  final String id;
  const GrowthPhase(this.id);

  static GrowthPhase fromId(String? id) {
    return GrowthPhase.values.firstWhere(
      (p) => p.id == id,
      orElse: () => GrowthPhase.seedling,
    );
  }

  String get label {
    switch (this) {
      case GrowthPhase.seedling:
        return 'Semis / plantule';
      case GrowthPhase.vegetative:
        return 'Croissance';
      case GrowthPhase.flowering:
        return 'Floraison';
      case GrowthPhase.fruiting:
        return 'Fructification';
    }
  }

  String get emoji {
    switch (this) {
      case GrowthPhase.seedling:
        return '🌱';
      case GrowthPhase.vegetative:
        return '🌿';
      case GrowthPhase.flowering:
        return '🌸';
      case GrowthPhase.fruiting:
        return '🍅';
    }
  }
}

/// Une entrée dans le cahier de culture : suivi sérieux d'un plant en
/// pleine terre, séparé du Poussidex (mini-jeu). Lien optionnel vers
/// une Plantation.
class CultureEntry {
  final String id;
  final String vegetableId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? note;
  final String? linkedPlantationId;
  final GrowthPhase phase;
  final List<DateTime> wateredAt;

  const CultureEntry({
    required this.id,
    required this.vegetableId,
    required this.startedAt,
    this.endedAt,
    this.note,
    this.linkedPlantationId,
    this.phase = GrowthPhase.seedling,
    this.wateredAt = const <DateTime>[],
  });

  DateTime? get lastWatering => wateredAt.isEmpty ? null : wateredAt.last;

  /// Renvoie un tableau de [days] booléens (le plus ancien en
  /// premier) indiquant si la culture a été arrosée ce jour-là.
  List<bool> wateringHistory({int days = 14}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final result = List<bool>.filled(days, false);
    for (final w in wateredAt) {
      final wDay = DateTime(w.year, w.month, w.day);
      final delta = today.difference(wDay).inDays;
      if (delta >= 0 && delta < days) {
        result[days - 1 - delta] = true;
      }
    }
    return result;
  }

  bool get isActive => endedAt == null;

  int get daysSinceStarted => DateTime.now().difference(startedAt).inDays;

  CultureEntry copyWith({
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
    String? linkedPlantationId,
    GrowthPhase? phase,
    List<DateTime>? wateredAt,
    bool clearEndedAt = false,
    bool clearLinkedPlantation = false,
  }) {
    return CultureEntry(
      id: id,
      vegetableId: vegetableId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: clearEndedAt ? null : (endedAt ?? this.endedAt),
      note: note ?? this.note,
      linkedPlantationId: clearLinkedPlantation
          ? null
          : (linkedPlantationId ?? this.linkedPlantationId),
      phase: phase ?? this.phase,
      wateredAt: wateredAt ?? this.wateredAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'vegetableId': vegetableId,
        'startedAt': startedAt.toIso8601String(),
        'endedAt': endedAt?.toIso8601String(),
        'note': note,
        'linkedPlantationId': linkedPlantationId,
        'phase': phase.id,
        'wateredAt': wateredAt.map((d) => d.toIso8601String()).toList(),
      };

  factory CultureEntry.fromJson(Map<String, dynamic> json) {
    return CultureEntry(
      id: json['id'] as String,
      vegetableId: json['vegetableId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      note: json['note'] as String?,
      linkedPlantationId: json['linkedPlantationId'] as String?,
      phase: GrowthPhase.fromId(json['phase'] as String?),
      wateredAt: ((json['wateredAt'] as List?) ?? const <dynamic>[])
          .map<DateTime>((d) => DateTime.parse(d as String))
          .toList(),
    );
  }

  static String encodeAll(List<CultureEntry> list) =>
      jsonEncode(list.map((c) => c.toJson()).toList());

  /// Décode la liste des cultures du cahier. Filtre silencieusement
  /// les entrées dont `method == 'hydroponic'` pour rester compatible
  /// avec les sauvegardes antérieures à la v2 pleine-terre-only.
  static List<CultureEntry> decodeAll(String? raw) {
    if (raw == null || raw.isEmpty) return <CultureEntry>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => e as Map<String, dynamic>)
          .where((m) => m['method'] != 'hydroponic')
          .map<CultureEntry>(CultureEntry.fromJson)
          .toList();
    } catch (_) {
      return <CultureEntry>[];
    }
  }
}
