import 'dart:convert';

import 'culture_entry.dart';
import 'garden_plan.dart';

/// Une installation hydroponique = un objet physique : un système (DWC,
/// NFT, Kratky…) avec son réservoir, sa lampe, et N emplacements pour
/// des plants. C'est l'unité de gestion principale de l'onglet
/// Hydroponie depuis la refonte coherence (avril 2026).
///
/// Les mesures pH/EC/T° eau/humidité sont stockées au niveau install
/// (le réservoir et la pièce sont partagés). La phase de croissance et
/// les observations sont stockées au niveau du plant (CultureEntry).
class HydroInstall {
  final String id;
  final String name;
  final HydroSystemType systemType;

  /// Nombre total d'emplacements physiques (slots) dans l'install.
  final int slotCount;

  /// Volume du réservoir en litres. Sert au calculateur de nutriments
  /// pour ne pas redemander à chaque fois.
  final double reservoirL;

  /// Configuration lumière commune à toute l'install (1 lampe = 1 install).
  final HydroLightConfig? light;

  /// Chemin local de la photo de l'install (ex.
  /// `app documents/hydro_installs/{id}.jpg`). Optionnel.
  final String? photoPath;

  /// Date du dernier rinçage du réservoir. null = jamais rincé.
  final DateTime? lastFlushAt;

  /// Liste ordonnée de la taille [slotCount]. Chaque entrée pointe vers
  /// l'id d'une [CultureEntry] active si le slot est rempli, ou null
  /// pour un slot vide.
  final List<String?> slotCultureIds;

  final DateTime createdAt;

  const HydroInstall({
    required this.id,
    required this.name,
    required this.systemType,
    required this.slotCount,
    required this.reservoirL,
    required this.slotCultureIds,
    required this.createdAt,
    this.light,
    this.photoPath,
    this.lastFlushAt,
  });

  /// Nombre de slots remplis (plants en cours).
  int get filledSlots => slotCultureIds.where((id) => id != null).length;

  /// Nombre de jours depuis le dernier rinçage. null si jamais rincé.
  int? get daysSinceFlush {
    if (lastFlushAt == null) return null;
    return DateTime.now().difference(lastFlushAt!).inDays;
  }

  /// Vrai si le réservoir devrait être rincé (>= 14 jours).
  bool get flushDue {
    final d = daysSinceFlush;
    return d != null && d >= 14;
  }

  HydroInstall copyWith({
    String? name,
    HydroSystemType? systemType,
    int? slotCount,
    double? reservoirL,
    HydroLightConfig? light,
    String? photoPath,
    DateTime? lastFlushAt,
    List<String?>? slotCultureIds,
    bool clearLight = false,
    bool clearPhoto = false,
    bool clearFlush = false,
  }) {
    return HydroInstall(
      id: id,
      name: name ?? this.name,
      systemType: systemType ?? this.systemType,
      slotCount: slotCount ?? this.slotCount,
      reservoirL: reservoirL ?? this.reservoirL,
      light: clearLight ? null : (light ?? this.light),
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      lastFlushAt: clearFlush ? null : (lastFlushAt ?? this.lastFlushAt),
      slotCultureIds: slotCultureIds ?? this.slotCultureIds,
      createdAt: createdAt,
    );
  }

  /// Place une [cultureId] dans le premier slot vide. Renvoie une
  /// nouvelle install ; renvoie `this` si aucun slot vide n'est dispo.
  HydroInstall placeCultureInFreeSlot(String cultureId) {
    final i = slotCultureIds.indexWhere((id) => id == null);
    if (i == -1) return this;
    final updated = List<String?>.from(slotCultureIds);
    updated[i] = cultureId;
    return copyWith(slotCultureIds: updated);
  }

  /// Place une cultureId à l'index donné (remplace ce qui était là).
  HydroInstall placeCultureAt(int slotIndex, String cultureId) {
    if (slotIndex < 0 || slotIndex >= slotCount) return this;
    final updated = List<String?>.from(slotCultureIds);
    updated[slotIndex] = cultureId;
    return copyWith(slotCultureIds: updated);
  }

  /// Vide un slot (par index ou par cultureId).
  HydroInstall removeCulture(String cultureId) {
    final updated = List<String?>.from(slotCultureIds);
    for (var i = 0; i < updated.length; i++) {
      if (updated[i] == cultureId) updated[i] = null;
    }
    return copyWith(slotCultureIds: updated);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'systemType': systemType.name,
        'slotCount': slotCount,
        'reservoirL': reservoirL,
        'light': light?.toJson(),
        'photoPath': photoPath,
        'lastFlushAt': lastFlushAt?.toIso8601String(),
        'slotCultureIds': slotCultureIds,
        'createdAt': createdAt.toIso8601String(),
      };

  factory HydroInstall.fromJson(Map<String, dynamic> json) {
    final rawSlots = (json['slotCultureIds'] as List?) ?? const <dynamic>[];
    final slots = rawSlots.map<String?>((e) => e as String?).toList();
    final slotCount = (json['slotCount'] as num?)?.toInt() ?? slots.length;
    // Remplir/tronquer si la liste ne correspond pas (cas de migration).
    while (slots.length < slotCount) {
      slots.add(null);
    }
    if (slots.length > slotCount) {
      slots.removeRange(slotCount, slots.length);
    }
    return HydroInstall(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? 'Mon install',
      systemType: HydroSystemType.values.firstWhere(
        (t) => t.name == json['systemType'],
        orElse: () => HydroSystemType.dwc,
      ),
      slotCount: slotCount,
      reservoirL: (json['reservoirL'] as num?)?.toDouble() ?? 20.0,
      light: json['light'] == null
          ? null
          : HydroLightConfig.fromJson(json['light'] as Map<String, dynamic>),
      photoPath: json['photoPath'] as String?,
      lastFlushAt: json['lastFlushAt'] == null
          ? null
          : DateTime.parse(json['lastFlushAt'] as String),
      slotCultureIds: slots,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  static String encodeAll(List<HydroInstall> list) =>
      jsonEncode(list.map((i) => i.toJson()).toList());

  static List<HydroInstall> decodeAll(String? raw) {
    if (raw == null || raw.isEmpty) return <HydroInstall>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => HydroInstall.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <HydroInstall>[];
    }
  }
}
