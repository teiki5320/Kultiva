/// Sous-catégorie d'un accessoire dans le catalogue Kultiva.
enum AccessorySubCategory {
  tools,
  pots,
  soil,
  seeds,
  watering,
  protection,
  structures;

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
      case AccessorySubCategory.watering:
        return 'Arrosage';
      case AccessorySubCategory.protection:
        return 'Protection';
      case AccessorySubCategory.structures:
        return 'Structures';
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
      case AccessorySubCategory.watering:
        return '💧';
      case AccessorySubCategory.protection:
        return '🛡️';
      case AccessorySubCategory.structures:
        return '🏡';
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

  // --- Accessoires : sous-catégorie (uniquement si category == accessories) ---
  final AccessorySubCategory? accessorySub;

  /// Chemin de l'image kawaii (fallback emoji si null).
  /// Ex: 'assets/images/accessories/secateur.png'.
  final String? imageAsset;

  // --- Temps avant récolte par saison (si renseigné) ---
  /// Ex. {Season.spring: '60-80 jours', Season.summer: '50-70 jours'}.
  final Map<String, String>? harvestTimeBySeason;

  /// Densité du Square Foot Gardening (potager carré) :
  /// nombre de plants qui tiennent dans une case de 30×30 cm (1 pied²).
  ///
  /// Valeurs typiques : 1 (tomate, courgette), 4 (laitue, pak choi),
  /// 9 (carotte, betterave), 16 (radis, oignon), 36 (poireau, ciboulette).
  /// `null` pour les vivaces ou plantes de rang (arbres fruitiers, baies)
  /// qui ne s'inscrivent pas dans cette logique.
  final int? densityPerSqFt;

  /// Compatible avec une culture hydroponique grand public (DWC, Kratky, NFT).
  /// Par défaut `false` pour les arbres, tubercules et plantes complexes.
  final bool hydroFriendly;

  /// Profil hydroponique du légume — fourchettes idéales pH / EC /
  /// T° eau / humidité ambiante. Si `null`, l'app retombe sur les
  /// fourchettes génériques par phase de [reading_targets.dart].
  final HydroProfile? hydroProfile;

  /// Espacement recommandé entre plants en hydroponie (cm). Triple
  /// (min, typique, max) sourcé sur University of Arizona CEAC,
  /// Cornell CEA et Resh "Hydroponic Food Production". Affiché dans
  /// la grille pour vert/jaune/rouge selon la distance aux voisins.
  /// Si `null`, l'espacement n'est pas vérifié.
  final HydroSpacing? hydroSpacing;

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
    this.accessorySub,
    this.imageAsset,
    this.harvestTimeBySeason,
    this.densityPerSqFt,
    this.hydroFriendly = false,
    this.hydroProfile,
    this.hydroSpacing,
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

/// Fourchettes idéales pour une culture hydroponique d'un légume donné.
///
/// Les valeurs `*Veg` sont la base (phase végétative). L'advisor applique
/// des coefficients par phase : semis ≈ ×0.5 sur l'EC, fructification
/// ≈ ×1.3 sur l'EC, etc.
class HydroProfile {
  final double phMin;
  final double phMax;
  final double ecVegMin; // mS/cm en phase végétative
  final double ecVegMax;
  final double waterTempMin; // °C
  final double waterTempMax;
  final double airHumidityMin; // %
  final double airHumidityMax;

  const HydroProfile({
    required this.phMin,
    required this.phMax,
    required this.ecVegMin,
    required this.ecVegMax,
    required this.waterTempMin,
    required this.waterTempMax,
    required this.airHumidityMin,
    required this.airHumidityMax,
  });
}

/// Espacement entre plants en hydroponie (cm). Triplet
/// `(min, typique, max)` sourcé pour la majorité des cultures sur
/// University of Arizona CEAC, Cornell CEA, Resh « Hydroponic Food
/// Production ». Utilisé par la grille pour vert (≥typical),
/// jaune (entre min et typical), rouge (< min).
class HydroSpacing {
  final int minCm;
  final int typicalCm;
  final int maxCm;

  const HydroSpacing({
    required this.minCm,
    required this.typicalCm,
    required this.maxCm,
  });

  /// Densité plants/m² approchée à l'espacement typique.
  double get plantsPerSquareMeter {
    if (typicalCm <= 0) return 0;
    final m = typicalCm / 100;
    return 1 / (m * m);
  }
}
