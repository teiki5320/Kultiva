import '../data/vegetables_base.dart';
import '../models/plantation.dart';
import '../models/vegetable.dart';
import '../widgets/petal_animation.dart' show Season;

/// Un badge débloquable dans le Poussidex.
class PoussidexBadge {
  final String id;
  final String emoji;
  final String name;
  final String description;
  const PoussidexBadge({
    required this.id,
    required this.emoji,
    required this.name,
    required this.description,
  });
}

const List<PoussidexBadge> allBadges = <PoussidexBadge>[
  PoussidexBadge(
    id: 'first_step',
    emoji: '🌱',
    name: 'Premier pas',
    description: 'Planter ton tout premier légume.',
  ),
  PoussidexBadge(
    id: 'small_watering_can',
    emoji: '💧',
    name: 'Petit arrosoir',
    description: '10 arrosages cumulés dans ton Poussidex.',
  ),
  PoussidexBadge(
    id: 'first_harvest',
    emoji: '🧺',
    name: 'Première récolte',
    description: 'Récolter ton tout premier légume.',
  ),
  PoussidexBadge(
    id: 'diverse',
    emoji: '🎨',
    name: 'Diversifié',
    description: '5 familles de légumes différentes dans ton album.',
  ),
  PoussidexBadge(
    id: 'collector',
    emoji: '⭐',
    name: 'Collectionneur',
    description: '10 plants dans ton Poussidex.',
  ),
  PoussidexBadge(
    id: 'master_collector',
    emoji: '🏅',
    name: 'Maître collectionneur',
    description: '30 plants dans ton Poussidex.',
  ),
  PoussidexBadge(
    id: 'sun_tour',
    emoji: '☀️',
    name: 'Tour du soleil',
    description: 'Planter au moins un légume dans chacune des 4 saisons.',
  ),
  PoussidexBadge(
    id: 'big_harvester',
    emoji: '🏆',
    name: 'Gros récolteur',
    description: '50 récoltes cumulées.',
  ),
  PoussidexBadge(
    id: 'green_thumb',
    emoji: '🌿',
    name: 'Main verte',
    description: 'Un de tes plants survit 6 mois.',
  ),
  PoussidexBadge(
    id: 'herbalist',
    emoji: '🌿',
    name: 'Herboriste',
    description: 'Planter 3 aromatiques différentes.',
  ),
];

/// Retourne l'ensemble des IDs de badges débloqués par cette collection.
Set<String> computeUnlockedBadges(List<Plantation> plantations) {
  final unlocked = <String>{};
  if (plantations.isEmpty) return unlocked;

  // first_step
  unlocked.add('first_step');

  // small_watering_can
  final totalWaterings =
      plantations.fold<int>(0, (sum, p) => sum + p.wateredAt.length);
  if (totalWaterings >= 10) unlocked.add('small_watering_can');

  // Harvests.
  final totalHarvests =
      plantations.fold<int>(0, (sum, p) => sum + p.harvestCount);
  if (totalHarvests >= 1) unlocked.add('first_harvest');
  if (totalHarvests >= 50) unlocked.add('big_harvester');

  // Familles différentes.
  final families = <VegetableCategory>{};
  int aromatiquesCount = 0;
  final aromatiqueIds = <String>{};
  for (final p in plantations) {
    final veg = vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
    if (veg == null) continue;
    if (veg.category != VegetableCategory.accessories) {
      families.add(veg.category);
    }
    if (veg.category == VegetableCategory.aromatics) {
      aromatiqueIds.add(veg.id);
    }
  }
  if (families.length >= 5) unlocked.add('diverse');
  aromatiquesCount = aromatiqueIds.length;
  if (aromatiquesCount >= 3) unlocked.add('herbalist');

  // Collectionneur.
  if (plantations.length >= 10) unlocked.add('collector');
  if (plantations.length >= 30) unlocked.add('master_collector');

  // Tour du soleil : 4 saisons distinctes.
  final seasons = <Season>{};
  for (final p in plantations) {
    seasons.add(Season.fromMonth(p.plantedAt.month));
  }
  if (seasons.length >= 4) unlocked.add('sun_tour');

  // Main verte : un plant encore en vie >= 180 jours.
  final now = DateTime.now();
  if (plantations
      .any((p) => p.isActive && now.difference(p.plantedAt).inDays >= 180)) {
    unlocked.add('green_thumb');
  }

  return unlocked;
}
