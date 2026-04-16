/// Sous-catégorie d'un accessoire dans le catalogue Kultiva.
enum AccessorySubCategory {
  tools,
  pots,
  soil,
  seeds;

  String get label {
    switch (this) {
      case AccessorySubCategory.tools:
        return 'Outils';
      case AccessorySubCategory.pots:
        return 'Bacs & Pots';
      case AccessorySubCategory.soil:
        return 'Terreau & Engrais';
      case AccessorySubCategory.seeds:
        return 'Semences';
    }
  }

  String get emoji {
    switch (this) {
      case AccessorySubCategory.tools:
        return '🛠️';
      case AccessorySubCategory.pots:
        return '🪴';
      case AccessorySubCategory.soil:
        return '🌱';
      case AccessorySubCategory.seeds:
        return '🌾';
    }
  }
}

/// Catégorie d'un légume dans le catalogue Kultiva.
enum VegetableCategory {
  flowers,
  leaves,
  fruits,
  bulbs,
  tubers,
  seeds,
  roots,
  stems,
  aromatics,
  accessories;

  String get label {
    switch (this) {
      case VegetableCategory.flowers:
        return 'Fleurs';
      case VegetableCategory.leaves:
        return 'Feuilles';
      case VegetableCategory.fruits:
        return 'Fruits';
      case VegetableCategory.bulbs:
        return 'Bulbes';
      case VegetableCategory.tubers:
        return 'Tubercules';
      case VegetableCategory.seeds:
        return 'Graines';
      case VegetableCategory.roots:
        return 'Racines';
      case VegetableCategory.stems:
        return 'Tiges';
      case VegetableCategory.aromatics:
        return 'Aromatiques';
      case VegetableCategory.accessories:
        return 'Accessoires';
    }
  }

  String get emoji {
    switch (this) {
      case VegetableCategory.flowers:
        return '🌸';
      case VegetableCategory.leaves:
        return '🥬';
      case VegetableCategory.fruits:
        return '🍅';
      case VegetableCategory.bulbs:
        return '🧅';
      case VegetableCategory.tubers:
        return '🥔';
      case VegetableCategory.seeds:
        return '🫘';
      case VegetableCategory.roots:
        return '🥕';
      case VegetableCategory.stems:
        return '🌿';
      case VegetableCategory.aromatics:
        return '🌿';
      case VegetableCategory.accessories:
        return '🧰';
    }
  }
}

/// Représente un légume du catalogue Kultiva.
///
/// Tous les champs sauf [id], [name], [emoji] et [category] sont optionnels —
/// ils s'affichent uniquement si renseignés dans la fiche détail.
class Vegetable {
  final String id;
  final String name;
  final String emoji;
  final VegetableCategory category;

  final String? description;

  /// Phrase courte affichée sur la card (liste "Semer"/"Légumes").
  final String? note;

  // --- Semis ---
  final String? sowingTechnique;
  final String? sowingDepth;
  final String? germinationTemp;
  final String? germinationDays;

  // --- Culture ---
  final String? exposure;
  final String? spacing;
  final String? watering;
  final String? soil;

  /// Nombre max de jours consécutifs sans pluie avant arrosage nécessaire.
  /// Si null, dérivé automatiquement du champ [watering].
  final int? wateringDaysMax;

  // --- Rendement ---
  final String? yieldEstimate;

  // --- Liens ---
  final String? amazonUrl;
  final String? youtubeUrl;

  // --- Accessoires : sous-catégorie (uniquement si category == accessories) ---
  final AccessorySubCategory? accessorySub;

  // --- Temps avant récolte par saison (si renseigné) ---
  /// Ex. {Season.spring: '60-80 jours', Season.summer: '50-70 jours'}.
  final Map<String, String>? harvestTimeBySeason;

  const Vegetable({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    this.description,
    this.note,
    this.sowingTechnique,
    this.sowingDepth,
    this.germinationTemp,
    this.germinationDays,
    this.exposure,
    this.spacing,
    this.watering,
    this.soil,
    this.wateringDaysMax,
    this.yieldEstimate,
    this.amazonUrl,
    this.youtubeUrl,
    this.accessorySub,
    this.harvestTimeBySeason,
  });

  /// Seuil effectif de jours secs max. Si [wateringDaysMax] est renseigné,
  /// il est utilisé. Sinon, dérivé du champ [watering] texte.
  int get effectiveWateringDays {
    if (wateringDaysMax != null) return wateringDaysMax!;
    final w = (watering ?? '').toLowerCase();
    if (w.contains('abondant')) return 2;
    if (w.contains('régulier')) return 3;
    if (w.contains('modéré')) return 5;
    if (w.contains('faible') || w.contains('très')) return 7;
    return 4; // défaut raisonnable
  }
}
