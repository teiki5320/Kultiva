import '../models/vegetable_medal.dart';
import '../services/tamassi_stats.dart';

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

/// Les 50 badges du Poussidex Tamassi : 15 bronze + 15 silver + 12 gold
/// + 8 shiny.
const List<PoussidexBadge> allBadges = <PoussidexBadge>[
  // ─── BRONZE (15) — premiers pas ──────────────────────────────────────
  PoussidexBadge(id: 'first_step', emoji: '🌱', name: 'Premier pas',
      description: 'Choisir un starter.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'named', emoji: '🎭', name: 'Baptisé',
      description: 'Donner un nom à ton Tamassi.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'first_water', emoji: '💧', name: 'Baptême d\'eau',
      description: 'Premier arrosage.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'first_fertilize', emoji: '🌿', name: 'Premier engrais',
      description: 'Première fertilisation.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'first_pet', emoji: '👋', name: 'Ami',
      description: 'Premier bonjour à ton Tamassi.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'first_challenge', emoji: '📸', name: '1er cliché',
      description: 'Compléter ton tout premier défi.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'streak_3', emoji: '🔥', name: 'Régulier',
      description: '3 jours de connexion d\'affilée.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'morning', emoji: '☀️', name: 'Matinal',
      description: 'Une connexion entre 6h et 9h.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'night', emoji: '🌙', name: 'Nocturne',
      description: 'Une connexion entre 22h et 2h.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'explorer', emoji: '📱', name: 'Explorateur',
      description: 'Visiter les 3 onglets Tamassi / Défis / Badges.',
      tier: MedalTier.bronze),
  PoussidexBadge(id: 'level_15', emoji: '🌿', name: 'Germe',
      description: 'Atteindre le niveau 15.', tier: MedalTier.bronze),
  PoussidexBadge(id: 'see_bee', emoji: '🐝', name: 'Butineur',
      description: 'Voir une abeille traverser l\'écran.',
      tier: MedalTier.bronze),
  PoussidexBadge(id: 'see_butterfly', emoji: '🦋', name: 'Léger',
      description: 'Voir un papillon traverser l\'écran.',
      tier: MedalTier.bronze),
  PoussidexBadge(id: 'first_visit', emoji: '🤝', name: 'Invité',
      description: 'Recevoir la visite d\'un autre Tamassi.',
      tier: MedalTier.bronze),
  PoussidexBadge(id: 'water_5', emoji: '💪', name: 'Arroseur',
      description: '5 arrosages au total.', tier: MedalTier.bronze),

  // ─── SILVER (15) — progression ───────────────────────────────────────
  PoussidexBadge(id: 'level_20', emoji: '🌱', name: 'Pousse',
      description: 'Atteindre le niveau 20.', tier: MedalTier.silver),
  PoussidexBadge(id: 'level_30', emoji: '🌺', name: 'Bourgeon',
      description: 'Atteindre le niveau 30.', tier: MedalTier.silver),
  PoussidexBadge(id: 'water_20', emoji: '💦', name: 'Arrosoir d\'argent',
      description: '20 arrosages cumulés.', tier: MedalTier.silver),
  PoussidexBadge(id: 'fertilize_20', emoji: '🌾', name: 'Engrais argent',
      description: '20 fertilisations cumulées.', tier: MedalTier.silver),
  PoussidexBadge(id: 'pet_20', emoji: '💕', name: 'BFF',
      description: '20 bonjours cumulés.', tier: MedalTier.silver),
  PoussidexBadge(id: 'challenges_5', emoji: '📸', name: 'Photographe',
      description: '5 défis complétés.', tier: MedalTier.silver),
  PoussidexBadge(id: 'streak_7', emoji: '🔥', name: 'Streak 7',
      description: '7 jours de connexion d\'affilée.',
      tier: MedalTier.silver),
  PoussidexBadge(id: 'mix_tiers', emoji: '🎨', name: 'Polyvalent',
      description: 'Défis de 3 tiers différents complétés.',
      tier: MedalTier.silver),
  PoussidexBadge(id: 'night_5', emoji: '🦉', name: 'Noctambule',
      description: '5 connexions entre 22h et 2h.', tier: MedalTier.silver),
  PoussidexBadge(id: 'morning_5', emoji: '☕', name: 'Lève-tôt',
      description: '5 connexions entre 6h et 9h.', tier: MedalTier.silver),
  PoussidexBadge(id: 'rain_login', emoji: '🌧️', name: 'Pluie',
      description: 'Se connecter sous la pluie (météo).',
      tier: MedalTier.silver),
  PoussidexBadge(id: 'snow_login', emoji: '❄️', name: 'Neige',
      description: 'Se connecter sous la neige (météo).',
      tier: MedalTier.silver),
  PoussidexBadge(id: 'sunny_login', emoji: '☀️', name: 'Grand soleil',
      description: 'Se connecter sous un grand soleil (météo).',
      tier: MedalTier.silver),
  PoussidexBadge(id: 'visits_5', emoji: '🦔', name: 'Collectionneur d\'amis',
      description: 'Recevoir 5 visites d\'amis.', tier: MedalTier.silver),
  PoussidexBadge(id: 'trio_15', emoji: '🌟', name: 'Trio',
      description: '15 arrosages + 15 engrais + 15 bonjours.',
      tier: MedalTier.silver),

  // ─── GOLD (12) — maîtrise ────────────────────────────────────────────
  PoussidexBadge(id: 'level_40', emoji: '🌸', name: 'Fleur',
      description: 'Atteindre le niveau 40.', tier: MedalTier.gold),
  PoussidexBadge(id: 'level_50', emoji: '🪴', name: 'Plante',
      description: 'Atteindre le niveau 50.', tier: MedalTier.gold),
  PoussidexBadge(id: 'level_60', emoji: '🌲', name: 'Arbrisseau',
      description: 'Atteindre le niveau 60.', tier: MedalTier.gold),
  PoussidexBadge(id: 'level_75', emoji: '🌳', name: 'Arbre',
      description: 'Atteindre le niveau 75.', tier: MedalTier.gold),
  PoussidexBadge(id: 'water_100', emoji: '💧', name: 'Océan',
      description: '100 arrosages cumulés.', tier: MedalTier.gold),
  PoussidexBadge(id: 'fertilize_100', emoji: '🌿', name: 'Engrais or',
      description: '100 fertilisations cumulées.', tier: MedalTier.gold),
  PoussidexBadge(id: 'challenges_15', emoji: '📸', name: 'Artiste',
      description: '15 défis complétés.', tier: MedalTier.gold),
  PoussidexBadge(id: 'streak_30', emoji: '🔥', name: 'Streak 30',
      description: '30 jours de connexion d\'affilée.', tier: MedalTier.gold),
  PoussidexBadge(id: 'visits_10', emoji: '🦋', name: 'Sociable',
      description: 'Recevoir 10 visites d\'amis.', tier: MedalTier.gold),
  PoussidexBadge(id: 'all_bronze_challenges', emoji: '🏆',
      name: 'Bronze complet',
      description: 'Tous les défis bronze (15).', tier: MedalTier.gold),
  PoussidexBadge(id: 'all_silver_challenges', emoji: '🥈',
      name: 'Argent complet',
      description: 'Tous les défis argent (15).', tier: MedalTier.gold),
  PoussidexBadge(id: 'four_seasons', emoji: '🌍', name: 'Globe-trotter',
      description: 'Se connecter pendant chacune des 4 saisons.',
      tier: MedalTier.gold),

  // ─── SHINY (8) — légendaire ──────────────────────────────────────────
  PoussidexBadge(id: 'level_100', emoji: '✨', name: 'Arbre légendaire',
      description: 'Atteindre le niveau 100.', tier: MedalTier.shiny),
  PoussidexBadge(id: 'all_challenges', emoji: '🌟', name: 'Complétionniste',
      description: 'Tous les 50 défis complétés.', tier: MedalTier.shiny),
  PoussidexBadge(id: 'streak_100', emoji: '🔥', name: 'Streak 100',
      description: '100 jours de connexion d\'affilée.',
      tier: MedalTier.shiny),
  PoussidexBadge(id: 'all_gold_challenges', emoji: '👑', name: 'Or complet',
      description: 'Tous les défis or (13).', tier: MedalTier.shiny),
  PoussidexBadge(id: 'all_shiny_challenges', emoji: '💎',
      name: 'Shiny complet',
      description: 'Tous les défis shiny (7).', tier: MedalTier.shiny),
  PoussidexBadge(id: 'veteran_50', emoji: '🎖️', name: 'Vétéran',
      description: '50 arrosages + 50 engrais + 50 bonjours.',
      tier: MedalTier.shiny),
  PoussidexBadge(id: 'rare_40', emoji: '🦄', name: 'Rare',
      description: 'Débloquer 40 badges.', tier: MedalTier.shiny),
  PoussidexBadge(id: 'ultimate', emoji: '🏅', name: 'Ultime',
      description: 'Débloquer tous les 49 autres badges.',
      tier: MedalTier.shiny),
];

/// Calcule la liste des badges débloqués à partir des stats Tamassi.
/// Appelle [TamassiStats.load()] si [stats] n'est pas fourni.
Set<String> computeUnlockedBadges({
  required int level,
  TamassiStats? stats,
}) {
  stats ??= TamassiStats.load();
  final unlocked = <String>{};

  // ─── Bronze ────────────────────────────────────────────────────────
  // first_step : choisir un starter (on considère qu'on est débloqué si
  // on a un level ≥ 1, ce qui est automatique après sélection).
  unlocked.add('first_step');
  if (stats.named) unlocked.add('named');
  if (stats.waterCount >= 1) unlocked.add('first_water');
  if (stats.fertilizeCount >= 1) unlocked.add('first_fertilize');
  if (stats.petCount >= 1) unlocked.add('first_pet');
  if (stats.challengesCompletedCount >= 1) unlocked.add('first_challenge');
  if (stats.maxStreak >= 3) unlocked.add('streak_3');
  if (stats.morningLogins >= 1) unlocked.add('morning');
  if (stats.nightLogins >= 1) unlocked.add('night');
  if (stats.tabsVisited.length >= 3) unlocked.add('explorer');
  if (level >= 15) unlocked.add('level_15');
  if (stats.animalsSeen.contains('bee')) unlocked.add('see_bee');
  if (stats.animalsSeen.contains('butterfly')) unlocked.add('see_butterfly');
  if (stats.visitsSeen >= 1) unlocked.add('first_visit');
  if (stats.waterCount >= 5) unlocked.add('water_5');

  // ─── Silver ───────────────────────────────────────────────────────
  if (level >= 20) unlocked.add('level_20');
  if (level >= 30) unlocked.add('level_30');
  if (stats.waterCount >= 20) unlocked.add('water_20');
  if (stats.fertilizeCount >= 20) unlocked.add('fertilize_20');
  if (stats.petCount >= 20) unlocked.add('pet_20');
  if (stats.challengesCompletedCount >= 5) unlocked.add('challenges_5');
  if (stats.maxStreak >= 7) unlocked.add('streak_7');
  if (_tiersInSet(stats.completedChallengeIds).length >= 3) {
    unlocked.add('mix_tiers');
  }
  if (stats.nightLogins >= 5) unlocked.add('night_5');
  if (stats.morningLogins >= 5) unlocked.add('morning_5');
  if (stats.rainLogins >= 1) unlocked.add('rain_login');
  if (stats.snowLogins >= 1) unlocked.add('snow_login');
  if (stats.sunnyLogins >= 1) unlocked.add('sunny_login');
  if (stats.visitsSeen >= 5) unlocked.add('visits_5');
  if (stats.waterCount >= 15 &&
      stats.fertilizeCount >= 15 &&
      stats.petCount >= 15) {
    unlocked.add('trio_15');
  }

  // ─── Gold ─────────────────────────────────────────────────────────
  if (level >= 40) unlocked.add('level_40');
  if (level >= 50) unlocked.add('level_50');
  if (level >= 60) unlocked.add('level_60');
  if (level >= 75) unlocked.add('level_75');
  if (stats.waterCount >= 100) unlocked.add('water_100');
  if (stats.fertilizeCount >= 100) unlocked.add('fertilize_100');
  if (stats.challengesCompletedCount >= 15) unlocked.add('challenges_15');
  if (stats.maxStreak >= 30) unlocked.add('streak_30');
  if (stats.visitsSeen >= 10) unlocked.add('visits_10');
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.bronze)) {
    unlocked.add('all_bronze_challenges');
  }
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.silver)) {
    unlocked.add('all_silver_challenges');
  }
  if (stats.seasonsLoggedIn.length >= 4) unlocked.add('four_seasons');

  // ─── Shiny ────────────────────────────────────────────────────────
  if (level >= 100) unlocked.add('level_100');
  if (stats.challengesCompletedCount >= 50) unlocked.add('all_challenges');
  if (stats.maxStreak >= 100) unlocked.add('streak_100');
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.gold)) {
    unlocked.add('all_gold_challenges');
  }
  if (_allChallengesOfTier(stats.completedChallengeIds, MedalTier.shiny)) {
    unlocked.add('all_shiny_challenges');
  }
  if (stats.waterCount >= 50 &&
      stats.fertilizeCount >= 50 &&
      stats.petCount >= 50) {
    unlocked.add('veteran_50');
  }
  // rare_40 et ultimate sont auto-référentiels, calculés après coup.
  if (unlocked.length >= 40) unlocked.add('rare_40');
  // ultimate : tous les 49 autres.
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
