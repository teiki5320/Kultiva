import 'dart:convert';

/// Un plant dans le Poussidex : une carte de collection.
///
/// Contrairement à l'ancien modèle grille 2D, une plantation n'a plus de
/// position spatiale — c'est une entrée chronologique dans la collection.
class Plantation {
  final String id; // uuid local (timestamp + random)
  final String vegetableId;
  final DateTime plantedAt;
  final DateTime? harvestedAt;
  final int harvestCount;
  final List<DateTime> wateredAt;
  final String? note;
  final List<String> photoPaths;

  const Plantation({
    required this.id,
    required this.vegetableId,
    required this.plantedAt,
    this.harvestedAt,
    this.harvestCount = 0,
    this.wateredAt = const <DateTime>[],
    this.note,
    this.photoPaths = const <String>[],
  });

  /// Est encore en cours (non-récoltée définitivement).
  bool get isActive => harvestedAt == null;

  /// Jours écoulés depuis la mise en terre.
  int get daysSincePlanted => DateTime.now().difference(plantedAt).inDays;

  /// Dernier arrosage manuel ; null si jamais arrosé.
  DateTime? get lastWatered => wateredAt.isEmpty ? null : wateredAt.last;

  /// Jours depuis dernier arrosage (ou plantation si jamais arrosé).
  int get daysSinceWatered {
    final last = lastWatered ?? plantedAt;
    return DateTime.now().difference(last).inDays;
  }

  Plantation copyWith({
    DateTime? harvestedAt,
    int? harvestCount,
    List<DateTime>? wateredAt,
    String? note,
    List<String>? photoPaths,
    bool clearHarvestedAt = false,
  }) {
    return Plantation(
      id: id,
      vegetableId: vegetableId,
      plantedAt: plantedAt,
      harvestedAt: clearHarvestedAt ? null : (harvestedAt ?? this.harvestedAt),
      harvestCount: harvestCount ?? this.harvestCount,
      wateredAt: wateredAt ?? this.wateredAt,
      note: note ?? this.note,
      photoPaths: photoPaths ?? this.photoPaths,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'vegetableId': vegetableId,
        'plantedAt': plantedAt.toIso8601String(),
        'harvestedAt': harvestedAt?.toIso8601String(),
        'harvestCount': harvestCount,
        'wateredAt': wateredAt.map((d) => d.toIso8601String()).toList(),
        'note': note,
        'photoPaths': photoPaths,
      };

  factory Plantation.fromJson(Map<String, dynamic> json) {
    return Plantation(
      id: json['id'] as String,
      vegetableId: json['vegetableId'] as String,
      plantedAt: DateTime.parse(json['plantedAt'] as String),
      harvestedAt: json['harvestedAt'] == null
          ? null
          : DateTime.parse(json['harvestedAt'] as String),
      harvestCount: (json['harvestCount'] as int?) ?? 0,
      wateredAt: ((json['wateredAt'] as List?) ?? const <dynamic>[])
          .map((e) => DateTime.parse(e as String))
          .toList(),
      note: json['note'] as String?,
      photoPaths: ((json['photoPaths'] as List?) ?? const <dynamic>[])
          .map((e) => e as String)
          .toList(),
    );
  }

  /// Fusion champ par champ de deux versions d'une même plantation (même
  /// [id]) — typiquement une locale et une cloud au merge multi-appareils.
  /// On ne jette JAMAIS de données : les arrosages et photos sont
  /// unionnés, les compteurs pris au maximum, la note la plus riche
  /// conservée. Remplace l'ancienne heuristique « l'objet entier avec le
  /// meilleur score gagne » qui perdait notes et photos du perdant.
  static Plantation merge(Plantation a, Plantation b) {
    assert(a.id == b.id, 'merge exige le même id');
    // Arrosages : union dédupliquée (par milliseconde) puis triée.
    final wateredByMs = <int, DateTime>{};
    for (final d in <DateTime>[...a.wateredAt, ...b.wateredAt]) {
      wateredByMs[d.millisecondsSinceEpoch] = d;
    }
    final watered = wateredByMs.values.toList()..sort((x, y) => x.compareTo(y));
    // Photos : union en préservant l'ordre (a puis les nouvelles de b).
    final photos = <String>[
      ...a.photoPaths,
      ...b.photoPaths.where((p) => !a.photoPaths.contains(p)),
    ];
    // harvestedAt : la plus tardive des deux, ou l'unique non-nulle.
    DateTime? harvested;
    if (a.harvestedAt == null) {
      harvested = b.harvestedAt;
    } else if (b.harvestedAt == null) {
      harvested = a.harvestedAt;
    } else {
      harvested = a.harvestedAt!.isAfter(b.harvestedAt!)
          ? a.harvestedAt
          : b.harvestedAt;
    }
    // Note : on garde la plus informative (non-vide, puis la plus longue).
    final noteA = a.note?.trim() ?? '';
    final noteB = b.note?.trim() ?? '';
    String? note;
    if (noteA.isEmpty) {
      note = noteB.isEmpty ? null : b.note;
    } else if (noteB.isEmpty) {
      note = a.note;
    } else {
      note = noteA.length >= noteB.length ? a.note : b.note;
    }
    return Plantation(
      id: a.id,
      vegetableId: a.vegetableId,
      plantedAt: a.plantedAt.isBefore(b.plantedAt) ? a.plantedAt : b.plantedAt,
      harvestedAt: harvested,
      harvestCount:
          a.harvestCount > b.harvestCount ? a.harvestCount : b.harvestCount,
      wateredAt: watered,
      note: note,
      photoPaths: photos,
    );
  }

  static String encodeAll(List<Plantation> list) =>
      jsonEncode(list.map((p) => p.toJson()).toList());

  static List<Plantation> decodeAll(String? raw) {
    if (raw == null || raw.isEmpty) return <Plantation>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => Plantation.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <Plantation>[];
    }
  }
}
