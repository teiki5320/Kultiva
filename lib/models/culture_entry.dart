import 'dart:convert';

/// Méthode de culture d'un plant dans le cahier.
enum CultivationMethod {
  soil('soil'),
  hydroponic('hydroponic');

  final String id;
  const CultivationMethod(this.id);

  static CultivationMethod fromId(String? id) {
    return CultivationMethod.values.firstWhere(
      (m) => m.id == id,
      orElse: () => CultivationMethod.soil,
    );
  }

  String get label {
    switch (this) {
      case CultivationMethod.soil:
        return 'Pleine terre';
      case CultivationMethod.hydroponic:
        return 'Hydroponie';
    }
  }

  String get emoji {
    switch (this) {
      case CultivationMethod.soil:
        return '🌻';
      case CultivationMethod.hydroponic:
        return '💧';
    }
  }
}

/// Source lumineuse pour une culture hydroponique.
enum LightType {
  natural('natural'),
  led('led'),
  mixed('mixed');

  final String id;
  const LightType(this.id);

  static LightType fromId(String? id) {
    return LightType.values.firstWhere(
      (l) => l.id == id,
      orElse: () => LightType.natural,
    );
  }

  String get label {
    switch (this) {
      case LightType.natural:
        return 'Lumière naturelle';
      case LightType.led:
        return 'LED horticole';
      case LightType.mixed:
        return 'Mixte (naturelle + LED)';
    }
  }

  String get emoji {
    switch (this) {
      case LightType.natural:
        return '☀️';
      case LightType.led:
        return '💡';
      case LightType.mixed:
        return '🌤️';
    }
  }
}

/// Température de couleur des LED.
enum LedColorTemp {
  white('white'),
  warm('warm'),
  cold('cold'),
  red('red'),
  blue('blue'),
  fullSpectrum('fullSpectrum');

  final String id;
  const LedColorTemp(this.id);

  static LedColorTemp fromId(String? id) {
    return LedColorTemp.values.firstWhere(
      (t) => t.id == id,
      orElse: () => LedColorTemp.fullSpectrum,
    );
  }

  String get label {
    switch (this) {
      case LedColorTemp.white:
        return 'Blanc neutre';
      case LedColorTemp.warm:
        return 'Blanc chaud';
      case LedColorTemp.cold:
        return 'Blanc froid';
      case LedColorTemp.red:
        return 'Rouge (floraison)';
      case LedColorTemp.blue:
        return 'Bleu (croissance)';
      case LedColorTemp.fullSpectrum:
        return 'Spectre complet';
    }
  }
}

/// Phase de croissance d'une culture hydroponique. Adapte les cibles
/// pH/EC/distance LED et la durée de photopériode recommandée.
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
        return 'Croissance végétative';
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

/// Configuration lumière d'une culture hydroponique.
class HydroLightConfig {
  final LightType type;
  final double hoursPerDay;
  final double? ledDistanceCm;
  final int? ledWatts;
  final LedColorTemp? ledColorTemp;

  const HydroLightConfig({
    required this.type,
    required this.hoursPerDay,
    this.ledDistanceCm,
    this.ledWatts,
    this.ledColorTemp,
  });

  HydroLightConfig copyWith({
    LightType? type,
    double? hoursPerDay,
    double? ledDistanceCm,
    int? ledWatts,
    LedColorTemp? ledColorTemp,
  }) {
    return HydroLightConfig(
      type: type ?? this.type,
      hoursPerDay: hoursPerDay ?? this.hoursPerDay,
      ledDistanceCm: ledDistanceCm ?? this.ledDistanceCm,
      ledWatts: ledWatts ?? this.ledWatts,
      ledColorTemp: ledColorTemp ?? this.ledColorTemp,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type.id,
        'hoursPerDay': hoursPerDay,
        'ledDistanceCm': ledDistanceCm,
        'ledWatts': ledWatts,
        'ledColorTemp': ledColorTemp?.id,
      };

  factory HydroLightConfig.fromJson(Map<String, dynamic> json) {
    return HydroLightConfig(
      type: LightType.fromId(json['type'] as String?),
      hoursPerDay: (json['hoursPerDay'] as num?)?.toDouble() ?? 12.0,
      ledDistanceCm: (json['ledDistanceCm'] as num?)?.toDouble(),
      ledWatts: json['ledWatts'] as int?,
      ledColorTemp: json['ledColorTemp'] == null
          ? null
          : LedColorTemp.fromId(json['ledColorTemp'] as String?),
    );
  }
}

/// Une entrée dans le cahier de culture : un suivi sérieux d'un plant,
/// séparé du Poussidex (mini-jeu). Lien optionnel vers une Plantation.
class CultureEntry {
  final String id;
  final CultivationMethod method;
  final String vegetableId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? note;
  final HydroLightConfig? light; // uniquement si method == hydroponic
  final String? linkedPlantationId;
  final GrowthPhase phase;

  const CultureEntry({
    required this.id,
    required this.method,
    required this.vegetableId,
    required this.startedAt,
    this.endedAt,
    this.note,
    this.light,
    this.linkedPlantationId,
    this.phase = GrowthPhase.seedling,
  });

  bool get isActive => endedAt == null;

  int get daysSinceStarted =>
      DateTime.now().difference(startedAt).inDays;

  CultureEntry copyWith({
    CultivationMethod? method,
    DateTime? endedAt,
    String? note,
    HydroLightConfig? light,
    String? linkedPlantationId,
    GrowthPhase? phase,
    bool clearEndedAt = false,
    bool clearLight = false,
    bool clearLinkedPlantation = false,
  }) {
    return CultureEntry(
      id: id,
      method: method ?? this.method,
      vegetableId: vegetableId,
      startedAt: startedAt,
      endedAt: clearEndedAt ? null : (endedAt ?? this.endedAt),
      note: note ?? this.note,
      light: clearLight ? null : (light ?? this.light),
      linkedPlantationId: clearLinkedPlantation
          ? null
          : (linkedPlantationId ?? this.linkedPlantationId),
      phase: phase ?? this.phase,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'method': method.id,
        'vegetableId': vegetableId,
        'startedAt': startedAt.toIso8601String(),
        'endedAt': endedAt?.toIso8601String(),
        'note': note,
        'light': light?.toJson(),
        'linkedPlantationId': linkedPlantationId,
        'phase': phase.id,
      };

  factory CultureEntry.fromJson(Map<String, dynamic> json) {
    return CultureEntry(
      id: json['id'] as String,
      method: CultivationMethod.fromId(json['method'] as String?),
      vegetableId: json['vegetableId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      note: json['note'] as String?,
      light: json['light'] == null
          ? null
          : HydroLightConfig.fromJson(
              json['light'] as Map<String, dynamic>),
      linkedPlantationId: json['linkedPlantationId'] as String?,
      phase: GrowthPhase.fromId(json['phase'] as String?),
    );
  }

  static String encodeAll(List<CultureEntry> list) =>
      jsonEncode(list.map((c) => c.toJson()).toList());

  static List<CultureEntry> decodeAll(String? raw) {
    if (raw == null || raw.isEmpty) return <CultureEntry>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => CultureEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <CultureEntry>[];
    }
  }
}
