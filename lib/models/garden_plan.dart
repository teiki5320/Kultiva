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

/// Type d'installation hydroponique. `null` côté GardenPlan = pleine terre.
enum HydroSystemType {
  dwc,
  kratky,
  nft,
  tower;

  String get label {
    switch (this) {
      case HydroSystemType.dwc:
        return 'DWC';
      case HydroSystemType.kratky:
        return 'Kratky';
      case HydroSystemType.nft:
        return 'NFT';
      case HydroSystemType.tower:
        return 'Tour';
    }
  }

  String get fullLabel {
    switch (this) {
      case HydroSystemType.dwc:
        return 'DWC — Deep Water Culture';
      case HydroSystemType.kratky:
        return 'Kratky — bocal passif';
      case HydroSystemType.nft:
        return 'NFT — Nutrient Film';
      case HydroSystemType.tower:
        return 'Tour verticale';
    }
  }

  String get description {
    switch (this) {
      case HydroSystemType.dwc:
        return 'Bac avec couvercle troué, racines plongées dans une solution nutritive oxygénée par bulleur. Idéal pour salades et aromates.';
      case HydroSystemType.kratky:
        return 'Bocal ou container fermé avec une plante au-dessus. Sans pompe ni électricité — méthode passive simple.';
      case HydroSystemType.nft:
        return 'Tube incliné avec un mince film d\'eau circulant en continu. Excellent rendement pour feuilles et fraises.';
      case HydroSystemType.tower:
        return 'Tour verticale modulaire avec slots étagés. Maximise la surface en pied carré au sol.';
    }
  }

  /// Disposition par défaut des slots (cols × rows).
  ({int cols, int rows}) get defaultLayout {
    switch (this) {
      case HydroSystemType.dwc:
        return (cols: 3, rows: 2); // 6 slots
      case HydroSystemType.kratky:
        return (cols: 1, rows: 1); // 1 slot
      case HydroSystemType.nft:
        return (cols: 4, rows: 2); // 8 slots
      case HydroSystemType.tower:
        return (cols: 2, rows: 6); // 12 slots
    }
  }
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

  /// Si renseigné, ce plan représente un système hydroponique. Sinon
  /// c'est un potager carré classique (pleine terre).
  final HydroSystemType? hydroSystem;

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
    this.hydroSystem,
    Map<String, PlannedCell>? cells,
    required this.createdAt,
    required this.updatedAt,
  }) : cells = cells ?? <String, PlannedCell>{};

  bool get isHydroponic => hydroSystem != null;

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
      hydroSystem: hydroSystem,
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
    HydroSystemType? hydroSystem,
  }) =>
      GardenPlan(
        id: id,
        name: name ?? this.name,
        location: location ?? this.location,
        cols: cols ?? this.cols,
        rows: rows ?? this.rows,
        unit: unit ?? this.unit,
        hydroSystem: hydroSystem ?? this.hydroSystem,
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
        'hydroSystem': hydroSystem?.name,
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
    final hydroRaw = j['hydroSystem'] as String?;
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
      hydroSystem: hydroRaw == null
          ? null
          : HydroSystemType.values.firstWhere(
              (h) => h.name == hydroRaw,
              orElse: () => HydroSystemType.dwc,
            ),
      cells: cells,
      createdAt: DateTime.parse(j['createdAt'] as String),
      updatedAt: DateTime.parse(j['updatedAt'] as String),
    );
  }

  factory GardenPlan.fromJsonString(String s) =>
      GardenPlan.fromJson(jsonDecode(s) as Map<String, dynamic>);
}
