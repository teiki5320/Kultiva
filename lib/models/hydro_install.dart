import 'dart:convert';

import 'culture_entry.dart';
import 'garden_plan.dart';

/// Type de matériel de mesure que l'utilisateur peut posséder. Sert à
/// conditionner l'affichage des champs dans le sheet « Mes mesures du
/// jour » : pas de demande de pH si l'utilisateur n'a pas de pH-mètre.
enum HydroEquipment {
  phMeter('phMeter'),
  ecMeter('ecMeter'),
  waterThermometer('waterThermometer'),
  hygrometer('hygrometer');

  final String id;
  const HydroEquipment(this.id);

  static HydroEquipment? fromId(String? id) {
    if (id == null) return null;
    for (final e in HydroEquipment.values) {
      if (e.id == id) return e;
    }
    return null;
  }

  String get label {
    switch (this) {
      case HydroEquipment.phMeter:
        return 'pH-mètre';
      case HydroEquipment.ecMeter:
        return 'EC-mètre';
      case HydroEquipment.waterThermometer:
        return 'Thermomètre étanche';
      case HydroEquipment.hygrometer:
        return 'Hygromètre';
    }
  }

  String get emoji {
    switch (this) {
      case HydroEquipment.phMeter:
        return '🧪';
      case HydroEquipment.ecMeter:
        return '⚡';
      case HydroEquipment.waterThermometer:
        return '🌡️';
      case HydroEquipment.hygrometer:
        return '💨';
    }
  }

  /// Description courte affichée dans la section équipement —
  /// orientée « pourquoi en avoir besoin », sans jargon.
  String get whyItMatters {
    switch (this) {
      case HydroEquipment.phMeter:
        return 'Sans pH correct, tes plants n\'absorbent pas les '
            'nutriments. C\'est la mesure n°1 en hydro.';
      case HydroEquipment.ecMeter:
        return 'Mesure si tes engrais sont bien dosés. Trop = brûle '
            'les racines. Pas assez = plants qui ralentissent.';
      case HydroEquipment.waterThermometer:
        return 'Eau trop chaude (>25°C) = racines qui pourrissent. '
            'Trop froide (<16°C) = absorption ralentie.';
      case HydroEquipment.hygrometer:
        return 'Air trop sec ou trop humide impacte directement la '
            'pousse. Important en intérieur.';
    }
  }

  /// Prix indicatif (€) pour afficher dans le bouton d'achat.
  String get priceHint {
    switch (this) {
      case HydroEquipment.phMeter:
        return '~25€';
      case HydroEquipment.ecMeter:
        return '~25€';
      case HydroEquipment.waterThermometer:
        return '~12€';
      case HydroEquipment.hygrometer:
        return '~15€';
    }
  }

  /// URL Amazon avec tag affilié Kultiva. Recherche pré-remplie.
  String get amazonUrl {
    final query = Uri.encodeComponent(_searchQuery);
    return 'https://www.amazon.fr/s?k=$query&tag=kultiva-21';
  }

  String get _searchQuery {
    switch (this) {
      case HydroEquipment.phMeter:
        return 'ph metre numerique hydroponie';
      case HydroEquipment.ecMeter:
        return 'ec metre tds metre hydroponie';
      case HydroEquipment.waterThermometer:
        return 'thermometre etanche aquarium digital';
      case HydroEquipment.hygrometer:
        return 'hygrometre thermometre digital interieur';
    }
  }

  /// Type de mesure (ReadingType) que cet équipement débloque dans
  /// le sheet « Mes mesures du jour ». Utilisé pour conditionner
  /// l'affichage des champs.
  String get readingTypeId {
    switch (this) {
      case HydroEquipment.phMeter:
        return 'ph';
      case HydroEquipment.ecMeter:
        return 'ec';
      case HydroEquipment.waterThermometer:
        return 'waterTemp';
      case HydroEquipment.hygrometer:
        return 'airHumidity';
    }
  }
}

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

  /// Liste des lampes de l'install. Une vraie installation peut en
  /// avoir plusieurs (ex. NFT 4 m² avec 4 lampes 100W couvrant chacune
  /// ~1 m²). La somme des watts × heures × footprints sert au calcul
  /// PPFD/DLI.
  ///
  /// Vide si aucune lampe n'a été configurée. Pour les installations
  /// créées avant la refonte multi-lampes (avril 2026), on migre depuis
  /// l'ancien champ `light` au moment de [fromJson].
  final List<HydroLightConfig> lamps;

  /// Chemin local de la photo de l'install (ex.
  /// `app documents/hydro_installs/{id}.jpg`). Optionnel.
  final String? photoPath;

  /// Date du dernier rinçage du réservoir. null = jamais rincé.
  final DateTime? lastFlushAt;

  /// Liste ordonnée de la taille [slotCount]. Chaque entrée pointe vers
  /// l'id d'une [CultureEntry] active si le slot est rempli, ou null
  /// pour un slot vide.
  final List<String?> slotCultureIds;

  /// Matériel de mesure que l'utilisateur a déclaré posséder. Sert à
  /// conditionner l'affichage des champs dans « Mes mesures du jour ».
  final Set<HydroEquipment> equipment;

  final DateTime createdAt;

  const HydroInstall({
    required this.id,
    required this.name,
    required this.systemType,
    required this.slotCount,
    required this.reservoirL,
    required this.slotCultureIds,
    required this.createdAt,
    this.lamps = const <HydroLightConfig>[],
    this.photoPath,
    this.lastFlushAt,
    this.equipment = const <HydroEquipment>{},
  });

  /// Première lampe configurée, pratique pour le code legacy qui
  /// affichait une « lampe principale ». null si aucune.
  HydroLightConfig? get primaryLamp => lamps.isEmpty ? null : lamps.first;

  /// Compatibilité descendante : ancien getter `light` qui est utilisé
  /// dans plusieurs widgets pour afficher une fiche lampe rapide.
  /// Renvoie la première lampe.
  HydroLightConfig? get light => primaryLamp;

  /// Puissance totale (W) cumulée des lampes. Sert au calcul PPFD
  /// global de l'install.
  int get totalLampWatts {
    var total = 0;
    for (final l in lamps) {
      if (l.ledWatts != null) total += l.ledWatts!;
    }
    return total;
  }

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
    List<HydroLightConfig>? lamps,
    String? photoPath,
    DateTime? lastFlushAt,
    List<String?>? slotCultureIds,
    Set<HydroEquipment>? equipment,
    bool clearLamps = false,
    bool clearPhoto = false,
    bool clearFlush = false,
  }) {
    return HydroInstall(
      id: id,
      name: name ?? this.name,
      systemType: systemType ?? this.systemType,
      slotCount: slotCount ?? this.slotCount,
      reservoirL: reservoirL ?? this.reservoirL,
      lamps: clearLamps
          ? const <HydroLightConfig>[]
          : (lamps ?? this.lamps),
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      lastFlushAt: clearFlush ? null : (lastFlushAt ?? this.lastFlushAt),
      slotCultureIds: slotCultureIds ?? this.slotCultureIds,
      equipment: equipment ?? this.equipment,
      createdAt: createdAt,
    );
  }

  /// Bascule la possession d'un équipement. Renvoie une nouvelle
  /// install avec le set mis à jour.
  HydroInstall toggleEquipment(HydroEquipment e) {
    final next = <HydroEquipment>{...equipment};
    if (next.contains(e)) {
      next.remove(e);
    } else {
      next.add(e);
    }
    return copyWith(equipment: next);
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
        'lamps': lamps.map((l) => l.toJson()).toList(),
        'photoPath': photoPath,
        'lastFlushAt': lastFlushAt?.toIso8601String(),
        'slotCultureIds': slotCultureIds,
        'equipment': equipment.map((e) => e.id).toList(),
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
    final rawEquipment = (json['equipment'] as List?) ?? const <dynamic>[];
    final equipment = <HydroEquipment>{
      for (final e in rawEquipment)
        if (HydroEquipment.fromId(e as String?) != null)
          HydroEquipment.fromId(e as String)!,
    };
    // Migration depuis l'ancien champ `light` (pré-refonte multi-lampes
    // avril 2026) : si `lamps` n'existe pas mais `light` est présent,
    // on convertit en liste à 1 élément.
    final List<HydroLightConfig> lamps;
    final rawLamps = json['lamps'];
    if (rawLamps is List) {
      lamps = <HydroLightConfig>[
        for (final l in rawLamps)
          HydroLightConfig.fromJson(l as Map<String, dynamic>),
      ];
    } else if (json['light'] != null) {
      lamps = <HydroLightConfig>[
        HydroLightConfig.fromJson(json['light'] as Map<String, dynamic>),
      ];
    } else {
      lamps = const <HydroLightConfig>[];
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
      lamps: lamps,
      photoPath: json['photoPath'] as String?,
      lastFlushAt: json['lastFlushAt'] == null
          ? null
          : DateTime.parse(json['lastFlushAt'] as String),
      slotCultureIds: slots,
      equipment: equipment,
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
