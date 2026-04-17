import '../models/vegetable_medal.dart';

/// Un défi photo dans le Poussidex.
///
/// Contrairement aux anciens badges auto, un défi nécessite une
/// action volontaire : prendre et soumettre une photo spécifique.
/// La photo est la preuve ET le contenu partageable sur Instagram.
class PhotoChallenge {
  final String id;
  final String emoji;
  final String name;
  final String description;
  final MedalTier tier;

  const PhotoChallenge({
    required this.id,
    required this.emoji,
    required this.name,
    required this.description,
    required this.tier,
  });
}

const List<PhotoChallenge> allChallenges = <PhotoChallenge>[
  // ─── BRONZE (10) — accessibles dès le début ────────────────────────
  PhotoChallenge(
    id: 'first_sprout',
    emoji: '🌱',
    name: 'Germination',
    description: 'Photographie les premiers jours d\'un semis.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'first_bloom',
    emoji: '🌸',
    name: 'Premier bourgeon',
    description: 'Capture la première fleur qui apparaît sur un plant.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'gardener_selfie',
    emoji: '🤳',
    name: 'Selfie du jardinier',
    description: 'Prends-toi en photo en train de jardiner.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'favorite_tool',
    emoji: '🔧',
    name: 'Outil préféré',
    description: 'Montre ton outil de jardinage favori en action.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'my_garden_spot',
    emoji: '🏡',
    name: 'Mon coin secret',
    description: 'Vue d\'ensemble de ton potager — montre ton royaume.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'down_to_earth',
    emoji: '🪱',
    name: 'Terre à terre',
    description: 'Macro de la terre, des vers ou de la vie du sol.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'sunday_harvest',
    emoji: '🧺',
    name: 'Récolte du dimanche',
    description: 'Ton panier de récolte de la semaine.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'urban_jungle',
    emoji: '🏙️',
    name: 'Jungle urbaine',
    description: 'Ton potager en ville : balcon, toit ou rebord de fenêtre.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'surprise_flower',
    emoji: '🌼',
    name: 'Fleur surprise',
    description: 'Une fleur inattendue qui a poussé dans ton potager.',
    tier: MedalTier.bronze,
  ),
  PhotoChallenge(
    id: 'banana_scale',
    emoji: '🍌',
    name: 'Comparaison',
    description: 'Ton légume à côté d\'un objet du quotidien pour montrer sa taille.',
    tier: MedalTier.bronze,
  ),
  // ─── SILVER (10) — demandent plus d'effort ou de timing ───────────
  PhotoChallenge(
    id: 'ugliest',
    emoji: '🤮',
    name: 'Le plus moche',
    description: 'Ton légume le plus raté, bizarre ou moche. Assume !',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'tiny_harvest',
    emoji: '🐜',
    name: 'Mini récolte',
    description: 'Le plus petit truc que tu aies jamais récolté.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'weird_shape',
    emoji: '👽',
    name: 'Forme bizarre',
    description: 'Un légume à la forme complètement WTF.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'roommate',
    emoji: '🐛',
    name: 'Colocataire',
    description: 'Un insecte ou animal surprise sur tes plants.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'slug_invasion',
    emoji: '🐌',
    name: 'Invasion',
    description: 'Limaces, pucerons, chenilles — les visiteurs pas invités.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'garden_to_plate',
    emoji: '🍽️',
    name: 'Du jardin à l\'assiette',
    description: 'Un plat cuisiné avec TES légumes du jardin.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'green_hand',
    emoji: '🖐️',
    name: 'Main verte',
    description: 'Ta main à côté de ta plus belle récolte.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'oops',
    emoji: '💀',
    name: 'Oups',
    description: 'Un plant qui n\'a pas survécu. RIP.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'taste_test',
    emoji: '😋',
    name: 'Le goûteur',
    description: 'Croque dans un légume directement au jardin.',
    tier: MedalTier.silver,
  ),
  PhotoChallenge(
    id: 'family_garden',
    emoji: '👨‍👩‍👧',
    name: 'Jardin en famille',
    description: 'Jardiner avec quelqu\'un — famille, amis, voisins.',
    tier: MedalTier.silver,
  ),
  // ─── GOLD (7) — demandent de la patience ou du courage ────────────
  PhotoChallenge(
    id: 'heavyweight',
    emoji: '🏋️',
    name: 'Poids lourd',
    description: 'Ton plus gros légume — avec un objet pour l\'échelle.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'taller_than_me',
    emoji: '📏',
    name: 'Plus grand que moi',
    description: 'Un plant ou légume qui te dépasse en taille.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'before_after',
    emoji: '📸',
    name: 'Avant / Après',
    description: 'Même angle, 2 mois d\'écart. La magie de la croissance.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'golden_hour',
    emoji: '🌅',
    name: 'Golden hour',
    description: 'Ton potager baigné dans la lumière du coucher de soleil.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'rainbow_harvest',
    emoji: '🌈',
    name: 'Récolte arc-en-ciel',
    description: 'Des légumes de 5 couleurs différentes ensemble.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'rainy_garden',
    emoji: '🌧️',
    name: 'Sous la pluie',
    description: 'Jardiner malgré le mauvais temps. Le vrai dévouement.',
    tier: MedalTier.gold,
  ),
  PhotoChallenge(
    id: 'sharing_is_caring',
    emoji: '🤝',
    name: 'Le partage',
    description: 'Donner des légumes à un voisin, un ami, un inconnu.',
    tier: MedalTier.gold,
  ),
  // ─── SHINY (3) — les ultimes, rares, légendaires ──────────────────
  PhotoChallenge(
    id: 'night_garden',
    emoji: '🌙',
    name: 'Night garden',
    description: 'Ton potager de nuit — lampe, flash, ambiance mystère.',
    tier: MedalTier.shiny,
  ),
  PhotoChallenge(
    id: 'next_generation',
    emoji: '👶',
    name: 'La relève',
    description: 'Un enfant qui jardine. Le futur est entre ses mains.',
    tier: MedalTier.shiny,
  ),
  PhotoChallenge(
    id: 'dead_of_winter',
    emoji: '❄️',
    name: 'Saison morte',
    description: 'Ton jardin en plein hiver. La beauté dans le repos.',
    tier: MedalTier.shiny,
  ),
];
