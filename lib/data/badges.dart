import '../data/vegetables_base.dart';
import '../models/plantation.dart';
import '../models/vegetable.dart';
import '../models/vegetable_medal.dart';
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
  PoussidexBadge(
    id: 'first_photo',
    emoji: '📸',
    name: 'Premier cliché',
    description: 'Ajouter ta première photo à un plant du Poussidex.',
  ),
  PoussidexBadge(
    id: 'documentary',
    emoji: '📷',
    name: 'Documentaire',
    description: '10 photos cumulées dans ton Poussidex.',
  ),
  PoussidexBadge(
    id: 'fruit_lover',
    emoji: '🍅',
    name: 'Amateur de fruits',
    description: '5 légumes-fruits plantés.',
  ),
  PoussidexBadge(
    id: 'florist',
    emoji: '🌷',
    name: 'Fleuriste',
    description: '3 fleurs différentes dans ton album.',
  ),
  PoussidexBadge(
    id: 'generous_waterer',
    emoji: '💦',
    name: 'Généreux',
    description: '50 arrosages cumulés.',
  ),
  PoussidexBadge(
    id: 'rain_bringer',
    emoji: '🌊',
    name: 'Pluie bienfaisante',
    description: '100 arrosages cumulés.',
  ),
  PoussidexBadge(
    id: 'anniversary',
    emoji: '🎂',
    name: 'Anniversaire',
    description: 'Un de tes plants fête son premier an.',
  ),
  PoussidexBadge(
    id: 'writer',
    emoji: '📝',
    name: 'Écrivain',
    description: 'Ajouter une note à 5 plants différents.',
  ),
  PoussidexBadge(
    id: 'lightning',
    emoji: '⚡',
    name: 'Éclair',
    description: '5 plantations dans la même journée.',
  ),
  PoussidexBadge(
    id: 'all_families',
    emoji: '🎭',
    name: 'Toutes familles',
    description: "Un plant dans chacune des 9 familles de légumes.",
  ),
  PoussidexBadge(
    id: 'gourmand',
    emoji: '🍽️',
    name: 'Gourmand',
    description: '100 récoltes cumulées.',
  ),
  // ─── Médailles d'espèce ────────────────────────────────────────────────
  PoussidexBadge(
    id: 'first_gold',
    emoji: '🥇',
    name: 'Premier Or',
    description: 'Décrocher ta première médaille Or sur une espèce.',
  ),
  PoussidexBadge(
    id: 'first_shiny',
    emoji: '✨',
    name: 'Premier Shiny',
    description: 'Obtenir ta première version Shiny d\'un légume.',
  ),
  PoussidexBadge(
    id: 'shiny_master',
    emoji: '🌟',
    name: 'Maître Shiny',
    description: 'Obtenir 5 espèces en version Shiny.',
  ),
  PoussidexBadge(
    id: 'rainbow_gold',
    emoji: '🌈',
    name: 'Arc-en-ciel doré',
    description: "Une médaille Or ou plus dans chacune des 9 familles.",
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

  // Photos : premier cliché + documentaire (10 photos cumulées).
  final totalPhotos =
      plantations.fold<int>(0, (sum, p) => sum + p.photoPaths.length);
  if (totalPhotos >= 1) unlocked.add('first_photo');
  if (totalPhotos >= 10) unlocked.add('documentary');

  // Amateur de fruits : 5 légumes-fruits plantés.
  final fruitCount = plantations.where((p) {
    final v = vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
    return v?.category == VegetableCategory.fruits;
  }).length;
  if (fruitCount >= 5) unlocked.add('fruit_lover');

  // Fleuriste : 3 fleurs différentes.
  final flowerIds = <String>{};
  for (final p in plantations) {
    final v = vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
    if (v?.category == VegetableCategory.flowers) flowerIds.add(v!.id);
  }
  if (flowerIds.length >= 3) unlocked.add('florist');

  // Paliers d'arrosage.
  if (totalWaterings >= 50) unlocked.add('generous_waterer');
  if (totalWaterings >= 100) unlocked.add('rain_bringer');

  // Anniversaire : un plant (même terminé) a au moins 365 jours d'existence.
  if (plantations.any((p) => now.difference(p.plantedAt).inDays >= 365)) {
    unlocked.add('anniversary');
  }

  // Écrivain : 5 plants ont une note non-vide.
  final withNotes = plantations
      .where((p) => p.note != null && p.note!.trim().isNotEmpty)
      .length;
  if (withNotes >= 5) unlocked.add('writer');

  // Éclair : 5 plantations la même journée (quel que soit le jour).
  final plantedByDay = <String, int>{};
  for (final p in plantations) {
    final key =
        '${p.plantedAt.year}-${p.plantedAt.month}-${p.plantedAt.day}';
    plantedByDay[key] = (plantedByDay[key] ?? 0) + 1;
  }
  if (plantedByDay.values.any((n) => n >= 5)) unlocked.add('lightning');

  // Toutes familles : un plant dans chacune des 9 familles (hors accessoires).
  final targetFamilies = VegetableCategory.values
      .where((c) => c != VegetableCategory.accessories)
      .toSet();
  if (targetFamilies.every(families.contains)) unlocked.add('all_families');

  // Gourmand : 100 récoltes cumulées.
  if (totalHarvests >= 100) unlocked.add('gourmand');

  // ─── Badges dérivés du système de médailles ────────────────────────────
  final medals = computeAllMedals(plantations);
  int goldCount = 0;
  int shinyCount = 0;
  final goldFamilies = <VegetableCategory>{};
  for (final entry in medals.entries) {
    if (entry.value.rank >= MedalTier.gold.rank) {
      goldCount++;
      final v = vegetablesBase.where((x) => x.id == entry.key).firstOrNull;
      if (v != null && v.category != VegetableCategory.accessories) {
        goldFamilies.add(v.category);
      }
    }
    if (entry.value == MedalTier.shiny) shinyCount++;
  }
  if (goldCount >= 1) unlocked.add('first_gold');
  if (shinyCount >= 1) unlocked.add('first_shiny');
  if (shinyCount >= 5) unlocked.add('shiny_master');
  final rainbowTargets = VegetableCategory.values
      .where((c) => c != VegetableCategory.accessories)
      .toSet();
  if (rainbowTargets.every(goldFamilies.contains)) {
    unlocked.add('rainbow_gold');
  }

  return unlocked;
}
