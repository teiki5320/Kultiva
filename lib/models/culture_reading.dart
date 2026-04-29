import 'dart:convert';

/// Type d'une mesure ponctuelle attachée à une [CultureEntry].
/// Enum extensible : on déclare ici tous les types prévus, même si
/// seuls quelques-uns sont câblés dans l'UI au moment du commit.
enum ReadingType {
  /// pH de la solution nutritive (hydro).
  ph('ph', 'pH'),

  /// Conductivité électrique (hydro), en mS/cm.
  ec('ec', 'mS/cm'),

  /// Température de la solution (hydro), en °C.
  waterTemp('waterTemp', '°C'),

  /// Niveau du réservoir (hydro), en %.
  reservoirLevel('reservoirLevel', '%'),

  /// Humidité ambiante de la pièce (hydro intérieur), en %.
  airHumidity('airHumidity', '%'),

  /// Température du sol (pleine terre), en °C.
  soilTemp('soilTemp', '°C'),

  /// Quantité récoltée (commune), en grammes.
  harvestGrams('harvestGrams', 'g'),

  /// Observation libre sans valeur (note + éventuelle photo).
  observation('observation', '');

  final String id;
  final String defaultUnit;
  const ReadingType(this.id, this.defaultUnit);

  static ReadingType fromId(String? id) {
    return ReadingType.values.firstWhere(
      (t) => t.id == id,
      orElse: () => ReadingType.observation,
    );
  }

  String get label {
    switch (this) {
      case ReadingType.ph:
        return 'pH';
      case ReadingType.ec:
        return 'EC';
      case ReadingType.waterTemp:
        return 'Température eau';
      case ReadingType.reservoirLevel:
        return 'Niveau réservoir';
      case ReadingType.airHumidity:
        return 'Humidité de la pièce';
      case ReadingType.soilTemp:
        return 'Température sol';
      case ReadingType.harvestGrams:
        return 'Récolte';
      case ReadingType.observation:
        return 'Observation';
    }
  }

  String get emoji {
    switch (this) {
      case ReadingType.ph:
        return '🧪';
      case ReadingType.ec:
        return '⚡';
      case ReadingType.waterTemp:
        return '🌡️';
      case ReadingType.reservoirLevel:
        return '💧';
      case ReadingType.airHumidity:
        return '💨';
      case ReadingType.soilTemp:
        return '🌡️';
      case ReadingType.harvestGrams:
        return '🧺';
      case ReadingType.observation:
        return '📝';
    }
  }
}

/// Une mesure datée associée à une [CultureEntry].
///
/// On stocke value + unit pour rester souple : un pH-mètre peut être
/// calibré différemment, certains capteurs renvoient l'EC en µS/cm
/// plutôt qu'en mS/cm, la récolte peut être en g ou en pièces, etc.
class CultureReading {
  final String id;
  final String cultureId;
  final DateTime recordedAt;
  final ReadingType type;
  final double? value;
  final String unit;
  final String? note;

  const CultureReading({
    required this.id,
    required this.cultureId,
    required this.recordedAt,
    required this.type,
    required this.unit,
    this.value,
    this.note,
  });

  CultureReading copyWith({
    DateTime? recordedAt,
    double? value,
    String? unit,
    String? note,
    bool clearValue = false,
    bool clearNote = false,
  }) {
    return CultureReading(
      id: id,
      cultureId: cultureId,
      recordedAt: recordedAt ?? this.recordedAt,
      type: type,
      value: clearValue ? null : (value ?? this.value),
      unit: unit ?? this.unit,
      note: clearNote ? null : (note ?? this.note),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'cultureId': cultureId,
        'recordedAt': recordedAt.toIso8601String(),
        'type': type.id,
        'value': value,
        'unit': unit,
        'note': note,
      };

  factory CultureReading.fromJson(Map<String, dynamic> json) {
    return CultureReading(
      id: json['id'] as String,
      cultureId: json['cultureId'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      type: ReadingType.fromId(json['type'] as String?),
      value: (json['value'] as num?)?.toDouble(),
      unit: (json['unit'] as String?) ?? '',
      note: json['note'] as String?,
    );
  }

  static String encodeAll(List<CultureReading> list) =>
      jsonEncode(list.map((r) => r.toJson()).toList());

  static List<CultureReading> decodeAll(String? raw) {
    if (raw == null || raw.isEmpty) return <CultureReading>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => CultureReading.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <CultureReading>[];
    }
  }
}
