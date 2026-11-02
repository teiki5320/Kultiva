import 'dart:convert';


/// Un plant du cahier de culture : une espèce, une date, un suivi.
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

  /// Le stade de croissance **observé**, quand l'utilisateur l'a
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
    bool clearNote = false,
  }) {
    return Plantation(
      id: id,
      vegetableId: vegetableId,
      plantedAt: plantedAt,
      harvestedAt: clearHarvestedAt ? null : (harvestedAt ?? this.harvestedAt),
      harvestCount: harvestCount ?? this.harvestCount,
      wateredAt: wateredAt ?? this.wateredAt,
      // `clearNote` est nécessaire parce que `note ?? this.note` ne peut
      // pas exprimer « efface la note » : passer null veut dire « ne
      // change rien ». Même logique que `clearHarvestedAt`.
      note: clearNote ? null : (note ?? this.note),
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

  static String encodeAll(List<Plantation> list) =>
      jsonEncode(list.map((p) => p.toJson()).toList());

  /// Décode la collection, ou renvoie une liste vide si la sauvegarde
  /// est illisible.
  ///
  /// ⚠️ Une liste vide est donc ambiguë : « aucun plant » ou
  /// « sauvegarde corrompue ». Pour tout code qui **écrit** ensuite,
  /// utiliser [decodeAllOrNull] : repartir d'une liste vide puis
  /// persister effacerait la collection de l'utilisateur.
  static List<Plantation> decodeAll(String? raw) =>
      decodeAllOrNull(raw) ?? <Plantation>[];

  /// Comme [decodeAll], mais distingue « vide » de « illisible » :
  /// renvoie `null` quand le contenu n'a pas pu être décodé.
  static List<Plantation>? decodeAllOrNull(String? raw) {
    if (raw == null || raw.isEmpty) return <Plantation>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => Plantation.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }
}
