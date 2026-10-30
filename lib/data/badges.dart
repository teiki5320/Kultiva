import '../models/vegetable_medal.dart';
import '../models/vegetable.dart';
import '../services/garden_stats.dart';

/// Un badge débloquable dans le Poussidex.
class PoussidexBadge {
  final String id;
  final String emoji;
  final String name;
  final String description;
  final MedalTier tier;
  const PoussidexBadge({
    required this.id,
    required this.emoji,
    required this.name,
    required this.description,
    required this.tier,
  });
}

/// Les 50 badges du Poussidex.
///
/// Réécrits le 31/10/2026, quand Tamassi a été supprimé. Ils
/// récompensaient jusque-là des gestes envers la créature — la
/// caresser, la nourrir, se connecter le matin, croiser une abeille à
/// l'écran — et 35 des 50 seraient devenus impossibles à obtenir.
/// Ils comptent désormais des plants, des arrosages, des récoltes et
/// des cases de potager.
///
/// ⚠️ Les identifiants sont inchangés : les 50 médaillons sont des
/// fichiers nommés d'après eux (`assets/images/badges/<id>.webp`). Les
/// renommer, c'est perdre les images.
const List<PoussidexBadge> allBadges = <PoussidexBadge>[
  // ─── BRONZE (15) — premiers pas ───
  PoussidexBadge(
      id: 'first_step',
      emoji: '🌱',
      name: 'Premier pas',
      description: 'Planter ton premier légume.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'named',
      emoji: '📝',
      name: 'Carnet ouvert',
      description: 'Écrire une note sur un de tes plants.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'first_water',
      emoji: '💧',
      name: 'Baptême d\'eau',
      description: 'Arroser un plant pour la première fois.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'first_fertilize',
      emoji: '🟫',
      name: 'Première case',
      description: 'Placer un légume dans un potager carré.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'first_pet',
      emoji: '⭐',
      name: 'Coup de cœur',
      description: 'Mettre un légume en favori.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'first_challenge',
      emoji: '📸',
      name: '1er cliché',
      description: 'Compléter ton tout premier défi photo.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'streak_3',
      emoji: '🔥',
      name: 'Régulier',
      description: 'Arroser 3 jours d\'affilée.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'morning',
      emoji: '☀️',
      name: 'Matinal',
      description: 'Arroser avant 9 h du matin.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'night',
      emoji: '🌙',
      name: 'Nocturne',
      description: 'Arroser après 21 h.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'explorer',
      emoji: '🧺',
      name: 'Panier varié',
      description: 'Planter dans 3 familles différentes.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'level_15',
      emoji: '🌿',
      name: 'Germe',
      description: '5 plants à ton actif.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'see_bee',
      emoji: '🐝',
      name: 'Butineur',
      description: 'Planter une fleur.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'see_butterfly',
      emoji: '🌸',
      name: 'Parfumé',
      description: 'Planter un aromate.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'first_visit',
      emoji: '🏡',
      name: 'Premier jardin',
      description: 'Créer ton premier jardin.',
      tier: MedalTier.bronze),
  PoussidexBadge(
      id: 'water_5',
      emoji: '💪',
      name: 'Arroseur',
      description: '5 arrosages au total.',
      tier: MedalTier.bronze),
  // ─── SILVER (15) — progression ───
  PoussidexBadge(
      id: 'level_20',
      emoji: '🌱',
      name: 'Pousse',
      description: '10 plants à ton actif.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'level_30',
      emoji: '🌾',
      name: 'Bourgeon',
      description: '20 plants à ton actif.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'water_20',
      emoji: '🚿',
      name: 'Arrosoir d\'argent',
      description: '20 arrosages au total.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'fertilize_20',
      emoji: '🧱',
      name: 'Dix cases',
      description: 'Remplir 10 cases de potager carré.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'pet_20',
      emoji: '📷',
      name: 'Album',
      description: '10 photos de plants.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'challenges_5',
      emoji: '🖼',
      name: 'Photographe',
      description: 'Compléter 5 défis photo.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'streak_7',
      emoji: '🔥',
      name: 'Semaine entière',
      description: 'Arroser 7 jours d\'affilée.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'mix_tiers',
      emoji: '🎖',
      name: 'Polyvalent',
      description: 'Des défis de 3 paliers différents.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'night_5',
      emoji: '🌙',
      name: 'Noctambule',
      description: '5 arrosages après 21 h.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'morning_5',
      emoji: '🌅',
      name: 'Lève-tôt',
      description: '5 arrosages avant 9 h.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'rain_login',
      emoji: '⏳',
      name: 'Patience',
      description: 'Suivre un même plant pendant 30 jours.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'snow_login',
      emoji: '❄️',
      name: 'Jardinier d\'hiver',
      description: 'Planter en hiver.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'sunny_login',
      emoji: '🌞',
      name: 'Plein été',
      description: 'Planter en été.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'visits_5',
      emoji: '🌈',
      name: 'Cinq espèces',
      description: 'Planter 5 espèces différentes.',
      tier: MedalTier.silver),
  PoussidexBadge(
      id: 'trio_15',
      emoji: '🤹',
      name: 'Trio',
      description: '15 arrosages, 5 récoltes et 5 photos.',
      tier: MedalTier.silver),
  // ─── GOLD (12) — le jardin tourne ───
  PoussidexBadge(
      id: 'level_40',
      emoji: '🌻',
      name: 'Fleur',
      description: '30 plants à ton actif.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'level_50',
      emoji: '🌳',
      name: 'Plante',
      description: '50 plants à ton actif.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'level_60',
      emoji: '📚',
      name: 'Quinze espèces',
      description: 'Planter 15 espèces différentes.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'level_75',
      emoji: '🧑‍🌾',
      name: 'Vingt-cinq espèces',
      description: 'Planter 25 espèces différentes.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'water_100',
      emoji: '🌊',
      name: 'Océan',
      description: '100 arrosages au total.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'fertilize_100',
      emoji: '🧩',
      name: 'Carré complet',
      description: 'Remplir toutes les cases d\'un jardin.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'challenges_15',
      emoji: '🎨',
      name: 'Artiste',
      description: 'Compléter 15 défis photo.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'streak_30',
      emoji: '🔥',
      name: 'Trente jours',
      description: 'Arroser 30 jours d\'affilée.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'visits_10',
      emoji: '🏘',
      name: 'Trois jardins',
      description: 'Créer 3 jardins.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'all_bronze_challenges',
      emoji: '🥉',
      name: 'Bronze complet',
      description: 'Compléter tous les défis bronze.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'all_silver_challenges',
      emoji: '🥈',
      name: 'Argent complet',
      description: 'Compléter tous les défis argent.',
      tier: MedalTier.gold),
  PoussidexBadge(
      id: 'four_seasons',
      emoji: '🗓',
      name: 'Quatre saisons',
      description: 'Planter aux quatre saisons.',
      tier: MedalTier.gold),
  // ─── SHINY (8) — pour les acharnés ───
  PoussidexBadge(
      id: 'level_100',
      emoji: '🏆',
      name: 'Centenaire',
      description: '100 plants à ton actif.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'all_challenges',
      emoji: '🌟',
      name: 'Complétionniste',
      description: 'Compléter les 50 défis photo.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'streak_100',
      emoji: '🔥',
      name: 'Cent jours',
      description: 'Arroser 100 jours d\'affilée.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'all_gold_challenges',
      emoji: '🥇',
      name: 'Or complet',
      description: 'Compléter tous les défis or.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'all_shiny_challenges',
      emoji: '✨',
      name: 'Shiny complet',
      description: 'Compléter tous les défis shiny.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'veteran_50',
      emoji: '🧺',
      name: 'Vétéran',
      description: '50 récoltes au total.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'rare_40',
      emoji: '💎',
      name: 'Rare',
      description: 'Débloquer 40 badges.',
      tier: MedalTier.shiny),
  PoussidexBadge(
      id: 'ultimate',
      emoji: '🏅',
      name: 'Ultime',
      description: 'Débloquer les 49 autres badges.',
      tier: MedalTier.shiny),
];

/// Calcule les badges débloqués à partir de ce qui a été fait au jardin.
Set<String> computeUnlockedBadges({GardenStats? stats}) {
  stats ??= GardenStats.load();
  final unlocked = <String>{};
  final defis = stats.completedChallengeIds.length;

  // ─── Bronze ────────────────────────────────────────────────────────
  if (stats.plantCount >= 1) unlocked.add('first_step');
  if (stats.noteCount >= 1) unlocked.add('named');
  if (stats.wateringCount >= 1) unlocked.add('first_water');
  if (stats.filledCells >= 1) unlocked.add('first_fertilize');
  if (stats.favoriteCount >= 1) unlocked.add('first_pet');
  if (defis >= 1) unlocked.add('first_challenge');
  if (stats.maxWateringStreak >= 3) unlocked.add('streak_3');
  if (stats.morningWaterings >= 1) unlocked.add('morning');
  if (stats.nightWaterings >= 1) unlocked.add('night');
  if (stats.categoriesPlanted.length >= 3) unlocked.add('explorer');
  if (stats.plantCount >= 5) unlocked.add('level_15');
  if (stats.categoriesPlanted.contains(VegetableCategory.flowers)) {
    unlocked.add('see_bee');
  }
  if (stats.categoriesPlanted.contains(VegetableCategory.aromatics)) {
    unlocked.add('see_butterfly');
  }
  if (stats.gardenCount >= 1) unlocked.add('first_visit');
  if (stats.wateringCount >= 5) unlocked.add('water_5');

  // ─── Silver ───────────────────────────────────────────────────────
  if (stats.plantCount >= 10) unlocked.add('level_20');
  if (stats.plantCount >= 20) unlocked.add('level_30');
  if (stats.wateringCount >= 20) unlocked.add('water_20');
  if (stats.filledCells >= 10) unlocked.add('fertilize_20');
  if (stats.photoCount >= 10) unlocked.add('pet_20');
  if (defis >= 5) unlocked.add('challenges_5');
  if (stats.maxWateringStreak >= 7) unlocked.add('streak_7');
  if (_tiersInSet(stats.completedChallengeIds).length >= 3) {
    unlocked.add('mix_tiers');
  }
  if (stats.nightWaterings >= 5) unlocked.add('night_5');
  if (stats.morningWaterings >= 5) unlocked.add('morning_5');
  if (stats.longestPlantDays >= 30) unlocked.add('rain_login');
  if (stats.seasonsPlanted.contains('hiver')) unlocked.add('snow_login');
  if (stats.seasonsPlanted.contains('ete')) unlocked.add('sunny_login');
  if (stats.speciesCount >= 5) unlocked.add('visits_5');
  if (stats.wateringCount >= 15 &&
      stats.harvestCount >= 5 &&
      stats.photoCount >= 5) {
    unlocked.add('trio_15');
  }

  // ─── Gold ─────────────────────────────────────────────────────────
  if (stats.plantCount >= 30) unlocked.add('level_40');
  if (stats.plantCount >= 50) unlocked.add('level_50');
  if (stats.speciesCount >= 15) unlocked.add('level_60');
  if (stats.speciesCount >= 25) unlocked.add('level_75');
  if (stats.wateringCount >= 100) unlocked.add('water_100');
  if (stats.hasFullGarden) unlocked.add('fertilize_100');
  if (defis >= 15) unlocked.add('challenges_15');
  if (stats.maxWateringStreak >= 30) unlocked.add('streak_30');
  if (stats.gardenCount >= 3) unlocked.add('visits_10');
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.bronze)) {
    unlocked.add('all_bronze_challenges');
  }
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.silver)) {
    unlocked.add('all_silver_challenges');
  }
  if (stats.seasonsPlanted.length >= 4) unlocked.add('four_seasons');

  // ─── Shiny ────────────────────────────────────────────────────────
  if (stats.plantCount >= 100) unlocked.add('level_100');
  if (defis >= 50) unlocked.add('all_challenges');
  if (stats.maxWateringStreak >= 100) unlocked.add('streak_100');
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.gold)) {
    unlocked.add('all_gold_challenges');
  }
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.shiny)) {
    unlocked.add('all_shiny_challenges');
  }
  if (stats.harvestCount >= 50) unlocked.add('veteran_50');

  // rare_40 et ultimate se calculent sur les autres, après coup.
  if (unlocked.length >= 40) unlocked.add('rare_40');
  final others = allBadges.where((b) => b.id != 'ultimate').map((b) => b.id);
  if (others.every(unlocked.contains)) unlocked.add('ultimate');

  return unlocked;
}

/// Retourne les tiers distincts parmi les défis complétés.
Set<MedalTier> _tiersInSet(Set<String> completedIds) {
  // Importer allChallenges depuis challenges.dart créerait un cycle.
  // On récupère par lookup dans le map ci-dessous.
  return completedIds
      .map((id) => _challengeTiers[id])
      .whereType<MedalTier>()
      .toSet();
}

bool _allChallengesOfTier(Set<String> completedIds, MedalTier tier) {
  final ids = _challengeTiers.entries
      .where((e) => e.value == tier)
      .map((e) => e.key)
      .toSet();
  if (ids.isEmpty) return false;
  return ids.every(completedIds.contains);
}

/// Mapping id de défi → tier. Synchronisé manuellement avec
/// `allChallenges` dans data/challenges.dart pour éviter le cycle
/// d'import.
const Map<String, MedalTier> _challengeTiers = <String, MedalTier>{
  // Bronze (15)
  'first_sprout': MedalTier.bronze,
  'first_bloom': MedalTier.bronze,
  'gardener_selfie': MedalTier.bronze,
  'favorite_tool': MedalTier.bronze,
  'my_garden_spot': MedalTier.bronze,
  'down_to_earth': MedalTier.bronze,
  'sunday_harvest': MedalTier.bronze,
  'urban_jungle': MedalTier.bronze,
  'surprise_flower': MedalTier.bronze,
  'banana_scale': MedalTier.bronze,
  'big_sunflower': MedalTier.bronze,
  'root_reveal': MedalTier.bronze,
  'cute_pot': MedalTier.bronze,
  'home_tea': MedalTier.bronze,
  'garden_bird': MedalTier.bronze,
  // Silver (15)
  'ugliest': MedalTier.silver,
  'tiny_harvest': MedalTier.silver,
  'weird_shape': MedalTier.silver,
  'roommate': MedalTier.silver,
  'slug_invasion': MedalTier.silver,
  'garden_to_plate': MedalTier.silver,
  'green_hand': MedalTier.silver,
  'oops': MedalTier.silver,
  'taste_test': MedalTier.silver,
  'family_garden': MedalTier.silver,
  'volunteer_plant': MedalTier.silver,
  'veggie_face': MedalTier.silver,
  'monochrome': MedalTier.silver,
  'composition': MedalTier.silver,
  'compost': MedalTier.silver,
  // Gold (13)
  'heavyweight': MedalTier.gold,
  'taller_than_me': MedalTier.gold,
  'before_after': MedalTier.gold,
  'golden_hour': MedalTier.gold,
  'rainbow_harvest': MedalTier.gold,
  'rainy_garden': MedalTier.gold,
  'sharing_is_caring': MedalTier.gold,
  'bug_safari': MedalTier.gold,
  'frost': MedalTier.gold,
  'halloween': MedalTier.gold,
  'bbq': MedalTier.gold,
  'gifted': MedalTier.gold,
  'bouquet': MedalTier.gold,
  // Shiny (7)
  'night_garden': MedalTier.shiny,
  'dead_of_winter': MedalTier.shiny,
  'starry_sky': MedalTier.shiny,
  'fireworks': MedalTier.shiny,
  'four_leaf_clover': MedalTier.shiny,
  'rare_species': MedalTier.shiny,
  'full_garden_meal': MedalTier.shiny,
};
