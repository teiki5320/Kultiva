import '../models/vegetable.dart';

/// Catalogue de base des légumes Kultiva (v2 : 20 légumes).
///
/// Les données de semis et récolte par région sont définies à part dans
/// `data/regions/`. Tous les champs "description" et techniques sont
/// optionnels : les sections vides sont masquées dans la fiche détail.
const List<Vegetable> vegetablesBase = <Vegetable>[
  // ──────────────────────────────────────────────────────────────────────
  // 1. Tomate
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'tomate',
    name: 'Tomate',
    emoji: '🍅',
    category: VegetableCategory.fruits,
    description:
        "Star du potager, la tomate aime le soleil et la chaleur. Se prête à toutes les utilisations en cuisine.",
    note: "Légume-soleil, à semer sous abri en fin d'hiver.",
    sowingTechnique: "Semis sous abri chauffé ou en godets",
    sowingDepth: "0,5 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "6 à 10 jours",
    exposure: "Plein soleil",
    spacing: "60 × 80 cm",
    watering: "Régulier, au pied, sans mouiller le feuillage",
    soil: "Riche, bien drainé, légèrement acide",
    yieldEstimate: "3 à 5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+tomate",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 2. Carotte
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'carotte',
    name: 'Carotte',
    emoji: '🥕',
    category: VegetableCategory.roots,
    description:
        "Racine sucrée et croquante, facile à cultiver en sol meuble et sableux.",
    note: "Semer clair pour éviter d'éclaircir plus tard.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Soleil",
    spacing: "5 × 25 cm",
    watering: "Régulier, éviter le dessèchement en surface",
    soil: "Meuble, sableux, sans cailloux",
    yieldEstimate: "3 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+carotte",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 3. Courgette
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'courgette',
    name: 'Courgette',
    emoji: '🥒',
    category: VegetableCategory.fruits,
    description:
        "Généreuse et rapide, la courgette est parfaite pour débuter au potager.",
    note: "Chaque pied produit beaucoup — prévoir 1 m² par plant.",
    sowingTechnique: "Semis en godet puis repiquage",
    sowingDepth: "2 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "5 à 8 jours",
    exposure: "Plein soleil",
    spacing: "1 m en tous sens",
    watering: "Abondant, au pied",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "3 à 6 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+courgette",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 4. Laitue
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'laitue',
    name: 'Laitue',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Feuilles tendres, croissance rapide et récolte étalée tout au long de la saison.",
    note: "Semer tous les 15 jours pour en récolter en continu.",
    sowingTechnique: "Semis en pépinière ou en place",
    sowingDepth: "0,5 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Mi-ombre en été, soleil au printemps",
    spacing: "25 × 30 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Meuble, humifère",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+laitue",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 5. Haricot vert
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'haricot',
    name: 'Haricot vert',
    emoji: '🫘',
    category: VegetableCategory.seeds,
    description:
        "Légumineuse fixatrice d'azote, nain ou à rames, idéale en culture d'été.",
    note: "Attendre que le sol atteigne 12 °C avant de semer.",
    sowingTechnique: "Semis direct en poquets",
    sowingDepth: "3 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "6 à 10 jours",
    exposure: "Soleil",
    spacing: "40 × 10 cm",
    watering: "Modéré, sans mouiller le feuillage",
    soil: "Léger, meuble, peu azoté",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+haricot+vert",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 6. Aubergine
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'aubergine',
    name: 'Aubergine',
    emoji: '🍆',
    category: VegetableCategory.fruits,
    description:
        "Amoureuse du chaud, à démarrer très tôt en intérieur pour avoir des plants prêts au repiquage.",
    note: "Semer très tôt — germination lente et long cycle.",
    sowingTechnique: "Semis sous abri chauffé",
    sowingDepth: "0,5 cm",
    germinationTemp: "22 à 28 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Plein soleil, à l'abri du vent",
    spacing: "60 × 60 cm",
    watering: "Régulier, généreux",
    soil: "Riche, profond, bien drainé",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+aubergine",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 7. Poivron
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'poivron',
    name: 'Poivron',
    emoji: '🫑',
    category: VegetableCategory.fruits,
    description:
        "Fruit coloré et sucré, cousin doux du piment, à démarrer en intérieur.",
    note: "Température clé pour la levée : viser 25 °C.",
    sowingTechnique: "Semis sous abri chauffé",
    sowingDepth: "0,5 cm",
    germinationTemp: "22 à 28 °C",
    germinationDays: "10 à 15 jours",
    exposure: "Plein soleil",
    spacing: "50 × 50 cm",
    watering: "Régulier, au pied",
    soil: "Riche, bien drainé",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+poivron",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 8. Épinard
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'epinard',
    name: 'Épinard',
    emoji: '🌿',
    category: VegetableCategory.leaves,
    description:
        "Feuilles riches en fer, préfère la fraîcheur — à semer au printemps ou en automne.",
    note: "Évite la chaleur, préfère les saisons fraîches.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1 à 2 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Mi-ombre en été",
    spacing: "10 × 30 cm",
    watering: "Régulier",
    soil: "Frais, riche en humus",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+epinard",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 9. Oignon
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'oignon',
    name: 'Oignon',
    emoji: '🧅',
    category: VegetableCategory.bulbs,
    description:
        "Bulbe incontournable de la cuisine, se conserve longtemps après récolte.",
    note: "Se sème ou se plante en bulbilles (plus simple).",
    sowingTechnique: "Semis direct ou plantation de bulbilles",
    sowingDepth: "1 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "10 à 15 jours",
    exposure: "Soleil",
    spacing: "10 × 25 cm",
    watering: "Modéré, arrêter avant la récolte",
    soil: "Léger, bien drainé, non fraîchement fumé",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+oignon",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 10. Basilic
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'basilic',
    name: 'Basilic',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "L'aromatique de l'été par excellence, compagnon idéal de la tomate.",
    note: "Craint le froid et le vent — à cultiver en pot si besoin.",
    sowingTechnique: "Semis en godets ou en place après les saints de glace",
    sowingDepth: "0,5 cm",
    germinationTemp: "20 à 25 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil, à l'abri",
    spacing: "20 × 30 cm",
    watering: "Régulier, sans excès",
    soil: "Riche, drainé",
    yieldEstimate: "200 à 400 g/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+basilic",
  ),

  // ════════════════════════════════════════════════════════════════════════
  // NOUVEAUX LÉGUMES (11–20)
  // ════════════════════════════════════════════════════════════════════════

  // ──────────────────────────────────────────────────────────────────────
  // 11. Concombre
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'concombre',
    name: 'Concombre',
    emoji: '🥒',
    category: VegetableCategory.fruits,
    description:
        "Rafraîchissant et productif, le concombre aime la chaleur et l'eau. Idéal en salade.",
    note: "Palisser sur un grillage pour gagner de la place.",
    sowingTechnique: "Semis en godet sous abri puis repiquage",
    sowingDepth: "2 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "60 × 100 cm",
    watering: "Abondant et régulier",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "3 à 5 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+concombre",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 12. Piment
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'piment',
    name: 'Piment',
    emoji: '🌶️',
    category: VegetableCategory.fruits,
    description:
        "Du doux au brûlant, le piment apporte saveur et couleur au potager comme en cuisine.",
    note: "Même culture que le poivron, mais plus résistant à la chaleur.",
    sowingTechnique: "Semis sous abri chauffé dès février",
    sowingDepth: "0,5 cm",
    germinationTemp: "22 à 30 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Plein soleil",
    spacing: "50 × 50 cm",
    watering: "Régulier, sans excès",
    soil: "Riche, bien drainé, chaud",
    yieldEstimate: "1 à 3 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+piment",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 13. Ail
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'ail',
    name: 'Ail',
    emoji: '🧄',
    category: VegetableCategory.bulbs,
    description:
        "Condiment universel, l'ail se conserve des mois et demande très peu d'entretien.",
    note: "Planter les caïeux pointe en haut, à fleur de sol.",
    sowingTechnique: "Plantation de caïeux directement en terre",
    sowingDepth: "2 à 3 cm",
    germinationTemp: "10 à 15 °C",
    germinationDays: "15 à 20 jours",
    exposure: "Soleil",
    spacing: "10 × 25 cm",
    watering: "Très modéré, stopper 1 mois avant récolte",
    soil: "Léger, bien drainé, pas de fumure fraîche",
    yieldEstimate: "0,5 à 1 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=ail+a+planter",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 14. Pomme de terre
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pomme_de_terre',
    name: 'Pomme de terre',
    emoji: '🥔',
    category: VegetableCategory.tubers,
    description:
        "Tubercule de base de l'alimentation mondiale, facile à cultiver et très productif.",
    note: "Butter les plants quand ils atteignent 20 cm de haut.",
    sowingTechnique: "Plantation de tubercules germés",
    sowingDepth: "10 à 15 cm",
    germinationTemp: "10 à 15 °C",
    germinationDays: "15 à 30 jours",
    exposure: "Soleil",
    spacing: "35 × 60 cm",
    watering: "Modéré, augmenter à la floraison",
    soil: "Meuble, profond, légèrement acide",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=pomme+de+terre+a+planter",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 15. Radis
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'radis',
    name: 'Radis',
    emoji: '🔴',
    category: VegetableCategory.roots,
    description:
        "Le plus rapide du potager : récolte en 3 à 4 semaines. Parfait pour les débutants.",
    note: "Semer peu à la fois, mais souvent (tous les 10 jours).",
    sowingTechnique: "Semis direct en ligne, éclaircir à 3 cm",
    sowingDepth: "1 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "3 à 6 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "3 × 15 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Léger, meuble, frais",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+radis",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 16. Chou pommé
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'chou_pomme',
    name: 'Chou pommé',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Légume d'hiver par excellence, le chou pommé résiste au froid et nourrit copieusement.",
    note: "Prévoir beaucoup de place — chaque pied est imposant.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "50 × 60 cm",
    watering: "Régulier, aime l'humidité",
    soil: "Riche, argileux, frais",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+pomme",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 17. Petit pois
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'petit_pois',
    name: 'Petit pois',
    emoji: '🟢',
    category: VegetableCategory.seeds,
    description:
        "Légumineuse printanière sucrée, à récolter jeune pour un maximum de tendreté.",
    note: "Semer tôt — le petit pois craint la chaleur estivale.",
    sowingTechnique: "Semis direct en ligne ou en poquets",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "8 à 15 °C",
    germinationDays: "7 à 15 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "5 × 40 cm",
    watering: "Régulier à la floraison",
    soil: "Frais, humifère, pas trop riche en azote",
    yieldEstimate: "0,5 à 1 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+petit+pois",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 18. Poireau
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'poireau',
    name: 'Poireau',
    emoji: '🥬',
    category: VegetableCategory.bulbs,
    description:
        "Légume rustique et polyvalent, disponible presque toute l'année au potager.",
    note: "Repiquer profond et butter pour allonger le fût blanc.",
    sowingTechnique: "Semis en pépinière puis repiquage profond",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "15 × 30 cm",
    watering: "Régulier",
    soil: "Riche, profond, frais",
    yieldEstimate: "3 à 5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+poireau",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 19. Patate douce
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'patate_douce',
    name: 'Patate douce',
    emoji: '🍠',
    category: VegetableCategory.tubers,
    description:
        "Tubercule sucré et nutritif, pilier de la cuisine africaine et tropicale.",
    note: "Se multiplie par boutures de tiges, pas par graines.",
    sowingTechnique: "Bouturage de lianes ou plantation de slips",
    sowingDepth: "5 à 10 cm",
    germinationTemp: "22 à 28 °C",
    germinationDays: "10 à 15 jours (enracinement)",
    exposure: "Plein soleil",
    spacing: "30 × 90 cm",
    watering: "Modéré, réduire avant récolte",
    soil: "Léger, sableux, bien drainé",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=patate+douce+a+planter",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 20. Gombo (Okra)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'gombo',
    name: 'Gombo',
    emoji: '🟢',
    category: VegetableCategory.fruits,
    description:
        "Fruit tropical mucilagineux, incontournable dans les sauces ouest-africaines.",
    note: "A besoin de chaleur : minimum 20 °C pour bien pousser.",
    sowingTechnique: "Semis direct ou en godet, tremper les graines 24 h avant",
    sowingDepth: "2 cm",
    germinationTemp: "25 à 30 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil",
    spacing: "40 × 60 cm",
    watering: "Régulier, abondant en période chaude",
    soil: "Riche, bien drainé, chaud",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+gombo",
  ),
];
