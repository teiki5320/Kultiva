import 'dart:convert';

/// Unité de mesure utilisée pour la taille du jardin.
/// `cm` = centimètres (système français), `ft` = pieds (Square Foot Gardening).
enum GardenUnit {
  cm,
  ft;

  String get label => this == GardenUnit.cm ? 'cm' : 'pieds';

  /// 1 pied² = 30,48 × 30,48 cm. Côté d'une case par défaut en cm.
  static const double cellSizeCm = 30.0;
}

/// Une case occupée du planificateur. Contient l'ID du légume planté
/// et le nombre exact d'individus dans la case (peut être inférieur à
/// la densité maximale du légume si l'utilisateur veut peupler partiellement).
class PlannedCell {
  /// Coordonnées de la case (col, row) à partir de (0,0) en haut-gauche.
  final int col;
  final int row;

  /// ID du légume planté (référence `Vegetable.id`).
  final String vegetableId;

  /// Nombre de plants dans la case. Par défaut = densité max du légume.
  final int count;

  /// Date de plantation (pour suivi de croissance).
  final DateTime plantedAt;

  PlannedCell({
    required this.col,
    required this.row,
    required this.vegetableId,
    required this.count,
    required this.plantedAt,
  });

  PlannedCell copyWith({int? count}) => PlannedCell(
        col: col,
        row: row,
        vegetableId: vegetableId,
        count: count ?? this.count,
        plantedAt: plantedAt,
      );

  Map<String, dynamic> toJson() => {
        'col': col,
        'row': row,
        'vegetableId': vegetableId,
        'count': count,
        'plantedAt': plantedAt.toIso8601String(),
      };

  factory PlannedCell.fromJson(Map<String, dynamic> j) => PlannedCell(
        col: j['col'] as int,
        row: j['row'] as int,
        vegetableId: j['vegetableId'] as String,
        count: j['count'] as int,
        plantedAt: DateTime.parse(j['plantedAt'] as String),
      );
}

/// Un plan de jardin (potager carré). Une grille de cases 30×30 cm
/// que l'utilisateur peut peupler de légumes via drag-and-drop.
///
/// Modèle local-first : sérialisé en JSON dans `SharedPreferences`.
class GardenPlan {
  /// Identifiant unique (UUID-like, généré au create).
  final String id;

  /// Nom donné par l'utilisateur. Ex : « Jardin 1 », « Carré nord ».
  final String name;

  /// Localisation textuelle libre (ville ou code postal).
  /// Sert au climat et aux dates de gel.
  final String? location;

  /// Largeur de la grille en cases (cols). Une case = 30×30 cm.
  final int cols;

  /// Hauteur de la grille en cases (rows).
  final int rows;

  /// Unité affichée à l'utilisateur dans la config (cm ou pieds).
  final GardenUnit unit;

  /// Cases peuplées (clé = "col,row").
  final Map<String, PlannedCell> cells;

  /// Timestamps.
  final DateTime createdAt;
  final DateTime updatedAt;

  GardenPlan({
    required this.id,
    required this.name,
    this.location,
    required this.cols,
    required this.rows,
    this.unit = GardenUnit.cm,
    Map<String, PlannedCell>? cells,
    required this.createdAt,
    required this.updatedAt,
  }) : cells = cells ?? <String, PlannedCell>{};

  /// Largeur en cm (cols × 30).
  double get widthCm => cols * GardenUnit.cellSizeCm;

  /// Hauteur en cm.
  double get heightCm => rows * GardenUnit.cellSizeCm;

  /// Surface totale en m².
  double get areaSqMeters => (widthCm * heightCm) / 10000;

  /// Récupère la case à (col, row), ou null si vide.
  PlannedCell? cellAt(int col, int row) => cells['$col,$row'];

  /// Retourne une copie avec une case mise à jour (ou supprimée si null).
  GardenPlan withCell(int col, int row, PlannedCell? cell) {
    final key = '$col,$row';
    final newCells = Map<String, PlannedCell>.from(cells);
    if (cell == null) {
      newCells.remove(key);
    } else {
      newCells[key] = cell;
    }
    return GardenPlan(
      id: id,
      name: name,
      location: location,
      cols: cols,
      rows: rows,
      unit: unit,
      cells: newCells,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  GardenPlan copyWith({
    String? name,
    String? location,
    int? cols,
    int? rows,
    GardenUnit? unit,
  }) =>
      GardenPlan(
        id: id,
        name: name ?? this.name,
        location: location ?? this.location,
        cols: cols ?? this.cols,
        rows: rows ?? this.rows,
        unit: unit ?? this.unit,
        cells: cells,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'cols': cols,
        'rows': rows,
        'unit': unit.name,
        'cells': cells.map((k, v) => MapEntry(k, v.toJson())),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  String toJsonString() => jsonEncode(toJson());

  factory GardenPlan.fromJson(Map<String, dynamic> j) {
    final cellsJson = (j['cells'] as Map<String, dynamic>? ?? <String, dynamic>{});
    final cells = cellsJson.map(
      (k, v) => MapEntry(k, PlannedCell.fromJson(v as Map<String, dynamic>)),
    );
    return GardenPlan(
      id: j['id'] as String,
      name: j['name'] as String,
      location: j['location'] as String?,
      cols: j['cols'] as int,
      rows: j['rows'] as int,
      unit: GardenUnit.values.firstWhere(
        (u) => u.name == (j['unit'] as String? ?? 'cm'),
        orElse: () => GardenUnit.cm,
      ),
      cells: cells,
      createdAt: DateTime.parse(j['createdAt'] as String),
      updatedAt: DateTime.parse(j['updatedAt'] as String),
    );
  }

  factory GardenPlan.fromJsonString(String s) =>
      GardenPlan.fromJson(jsonDecode(s) as Map<String, dynamic>);
}
