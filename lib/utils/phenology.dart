import '../models/culture_entry.dart';
import '../models/vegetable.dart';

/// Étape phénologique attendue d'un plant à un moment donné.
class PhenologyHint {
  final String emoji;
  final String label;
  final String detail;

  const PhenologyHint({
    required this.emoji,
    required this.label,
    required this.detail,
  });
}

/// Parse une chaîne "X à Y jours" / "X-Y j" et renvoie le maximum.
/// Renvoie null si rien n'est extractible.
int? _parseUpperDays(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final regex = RegExp(r'(\d+)\s*(?:à|-|–)\s*(\d+)|(\d+)');
  final match = regex.firstMatch(raw);
  if (match == null) return null;
  final upper = match.group(2) ?? match.group(3);
  return int.tryParse(upper ?? '');
}

/// Renvoie l'étape attendue d'une culture pleine terre à `daysSinceStart`
/// jours après le démarrage. Retourne null pour les accessoires.
PhenologyHint? expectedStage(Vegetable veg, int daysSinceStart) {
  if (veg.category == VegetableCategory.accessories) return null;

  final germMax = _parseUpperDays(veg.germinationDays) ?? 14;

  // Dates approximatives "récolte début" et "récolte fin" en jours,
  // selon la catégorie (heuristique simple).
  final harvestStart = _harvestStartDays(veg.category);
  final harvestEnd = _harvestEndDays(veg.category);

  if (daysSinceStart < germMax) {
    return PhenologyHint(
      emoji: '🌰',
      label: 'Germination attendue',
      detail: 'Levée prévue d\'ici ${germMax - daysSinceStart} j '
          '(germe en moyenne en ${veg.germinationDays ?? "$germMax j"}).',
    );
  }
  if (daysSinceStart < germMax + 10) {
    return const PhenologyHint(
      emoji: '🌱',
      label: 'Plantule',
      detail: 'Premières vraies feuilles. Pince les plus faibles, '
          'surveille les limaces.',
    );
  }
  if (daysSinceStart < harvestStart - 14) {
    return const PhenologyHint(
      emoji: '🌿',
      label: 'Croissance végétative',
      detail: 'Le plant prend du volume. Apporte un peu de compost '
          'si le feuillage jaunit.',
    );
  }
  if (daysSinceStart < harvestStart) {
    final stageLabel = _flowerStageLabel(veg.category);
    return PhenologyHint(
      emoji: '🌸',
      label: stageLabel.label,
      detail: stageLabel.detail,
    );
  }
  if (daysSinceStart < harvestEnd) {
    return PhenologyHint(
      emoji: '🧺',
      label: 'Récolte attendue',
      detail: 'Tu peux commencer à récolter. Goûte régulièrement '
          'pour repérer le pic de saveur.',
    );
  }
  return const PhenologyHint(
    emoji: '🍂',
    label: 'Cycle terminé',
    detail: 'Pense à arracher et préparer le sol pour la rotation.',
  );
}

int _harvestStartDays(VegetableCategory c) {
  switch (c) {
    case VegetableCategory.leaves:
      return 35;
    case VegetableCategory.aromatics:
      return 45;
    case VegetableCategory.roots:
      return 65;
    case VegetableCategory.fruits:
      return 65;
    case VegetableCategory.tubers:
      return 90;
    case VegetableCategory.bulbs:
      return 110;
    case VegetableCategory.flowers:
      return 70;
    case VegetableCategory.seeds:
      return 90;
    case VegetableCategory.stems:
      return 60;
    case VegetableCategory.accessories:
      return 999;
  }
}

int _harvestEndDays(VegetableCategory c) => _harvestStartDays(c) + 60;

/// Déduit la phase de croissance hydroponique d'un plant à partir du
/// nombre de jours depuis qu'il a été planté. Sert à pré-remplir la
/// phase quand l'utilisateur ajoute un plant en disant qu'il l'a
/// planté il y a X jours.
///
/// Heuristique :
///   - Avant la fin de la germination + 7 j → semis
///   - Entre fin germination et 14 j avant la récolte → croissance
///   - Pour les fruits : on insère une phase floraison juste avant fruits
///   - Pour les non-fruits : on reste en croissance jusqu'à la récolte
GrowthPhase deducedPhase(Vegetable veg, int daysSinceStarted) {
  if (veg.category == VegetableCategory.accessories) {
    return GrowthPhase.seedling;
  }
  final germMax = _parseUpperDays(veg.germinationDays) ?? 14;
  final harvestStart = _harvestStartDays(veg.category);

  // Phase semis = jusqu'à 7 jours après la germination max.
  if (daysSinceStarted < germMax + 7) {
    return GrowthPhase.seedling;
  }

  // Pour les légumes-fruits : croissance puis floraison (~14j avant
  // récolte) puis fructification (à partir de la récolte).
  if (veg.category == VegetableCategory.fruits ||
      veg.category == VegetableCategory.tubers) {
    if (daysSinceStarted < harvestStart - 14) {
      return GrowthPhase.vegetative;
    }
    if (daysSinceStarted < harvestStart) {
      return GrowthPhase.flowering;
    }
    return GrowthPhase.fruiting;
  }

  // Pour le reste (feuilles, aromatiques, racines, bulbes…) : on
  // reste en croissance jusqu'à la récolte. Pas de phase floraison
  // (au sens hydro) parce qu'on récolte avant qu'elle ne monte en
  // graine.
  return GrowthPhase.vegetative;
}

({String label, String detail}) _flowerStageLabel(VegetableCategory c) {
  switch (c) {
    case VegetableCategory.fruits:
      return (
        label: 'Floraison / nouaison',
        detail: 'Les premières fleurs annoncent la fructification. '
            'Tuteure si besoin et pince les gourmands (tomates).'
      );
    case VegetableCategory.tubers:
      return (
        label: 'Tubérisation',
        detail: 'Les tubercules se forment sous terre. Butte le pied '
            'pour les couvrir et arrose régulièrement.'
      );
    case VegetableCategory.roots:
      return (
        label: 'Grossissement',
        detail: 'Les racines s\'allongent. Éclaircis si tu ne l\'as '
            'pas encore fait pour laisser la place.'
      );
    case VegetableCategory.bulbs:
      return (
        label: 'Bulbaison',
        detail: 'Le bulbe se forme. Réduis l\'arrosage à l\'approche '
            'de la récolte.'
      );
    case VegetableCategory.leaves:
    case VegetableCategory.aromatics:
      return (
        label: 'Plein développement',
        detail: 'Surveille les pucerons, les limaces et la montée '
            'à graines.'
      );
    case VegetableCategory.flowers:
    case VegetableCategory.seeds:
    case VegetableCategory.stems:
      return (
        label: 'Pré-récolte',
        detail: 'Les organes commencent à mûrir. Garde un œil sur '
            'la météo.'
      );
    case VegetableCategory.accessories:
      return (label: '', detail: '');
  }
}
