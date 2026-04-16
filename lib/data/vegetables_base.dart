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
    youtubeUrl: "https://www.youtube.com/results?search_query=semer+tomates+potager",
    harvestTimeBySeason: {
      'spring': '90 à 110 jours (semis précoce sous abri)',
      'summer': '70 à 90 jours (plein champ)',
      'autumn': '100 à 120 jours (variétés tardives)',
    },
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
    youtubeUrl: "https://www.youtube.com/results?search_query=semer+carottes+potager",
    harvestTimeBySeason: {
      'spring': '75 à 90 jours',
      'summer': '90 à 110 jours',
      'autumn': '100 à 120 jours (variétés de garde)',
    },
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
    harvestTimeBySeason: {
      'spring': '60 à 75 jours (semis en avril)',
      'summer': '50 à 65 jours',
    },
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
    harvestTimeBySeason: {
      'spring': '45 à 60 jours',
      'summer': '40 à 55 jours',
      'autumn': '55 à 75 jours',
    },
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
    youtubeUrl: "https://www.youtube.com/results?search_query=cultiver+aubergine+potager",
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
    youtubeUrl: "https://www.youtube.com/results?search_query=planter+pomme+de+terre+potager",
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
    harvestTimeBySeason: {
      'spring': '21 à 30 jours',
      'summer': '25 à 35 jours',
      'autumn': '30 à 40 jours',
    },
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
    youtubeUrl: "https://www.youtube.com/results?search_query=cultiver+gombo+okra",
  ),
  // ════════════════════════════════════════════════════════════════════════
  // LÉGUMES 21–40
  // ════════════════════════════════════════════════════════════════════════

  // ──────────────────────────────────────────────────────────────────────
  // 21. Échalote
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'echalote',
    name: 'Échalote',
    emoji: '🧅',
    category: VegetableCategory.bulbs,
    description:
        "Plus fine et parfumée que l'oignon, l'échalote est un classique de la cuisine française.",
    note: "Planter les bulbes à fleur de sol, pointe en haut.",
    sowingTechnique: "Plantation de bulbes en terre",
    sowingDepth: "1 à 2 cm",
    germinationTemp: "10 à 18 °C",
    germinationDays: "15 à 20 jours",
    exposure: "Soleil",
    spacing: "15 × 25 cm",
    watering: "Faible, stopper avant récolte",
    soil: "Léger, bien drainé, pas de fumure fraîche",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=echalote+a+planter",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 22. Chou-fleur
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'chou_fleur',
    name: 'Chou-fleur',
    emoji: '🥦',
    category: VegetableCategory.leaves,
    description:
        "Inflorescence blanche et compacte, le chou-fleur aime les climats doux et humides.",
    note: "Protéger la pomme du soleil en rabattant les feuilles.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "60 × 70 cm",
    watering: "Régulier et abondant",
    soil: "Riche, profond, frais, argileux",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+fleur",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 23. Brocoli
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'brocoli',
    name: 'Brocoli',
    emoji: '🥦',
    category: VegetableCategory.leaves,
    description:
        "Cousin vert du chou-fleur, le brocoli est riche en vitamines et se récolte en jets successifs.",
    note: "Récolter avant que les boutons floraux ne s'ouvrent.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "50 × 60 cm",
    watering: "Régulier",
    soil: "Riche, frais, humifère",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+brocoli",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 24. Courge butternut
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'courge_butternut',
    name: 'Courge butternut',
    emoji: '🎃',
    category: VegetableCategory.fruits,
    description:
        "Chair orangée, douce et fondante. Excellente en soupe, gratin ou rôtie au four.",
    note: "Laisser les fruits mûrir sur pied jusqu'aux premières fraîcheurs.",
    sowingTechnique: "Semis en godet sous abri puis repiquage",
    sowingDepth: "2 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "6 à 10 jours",
    exposure: "Plein soleil",
    spacing: "1,5 m en tous sens",
    watering: "Abondant, au pied",
    soil: "Riche, profond, bien fumé",
    yieldEstimate: "3 à 5 fruits/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+courge+butternut",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 25. Potiron
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'potiron',
    name: 'Potiron',
    emoji: '🎃',
    category: VegetableCategory.fruits,
    description:
        "Gros fruit d'automne, le potiron se conserve des mois et nourrit toute la famille.",
    note: "Très gourmand en espace — prévoir 2 à 3 m² par pied.",
    sowingTechnique: "Semis en godet puis repiquage ou semis direct",
    sowingDepth: "2 à 3 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "6 à 12 jours",
    exposure: "Plein soleil",
    spacing: "2 m en tous sens",
    watering: "Abondant en été, réduire à maturité",
    soil: "Très riche, profond, bien drainé",
    yieldEstimate: "5 à 15 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+potiron",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 26. Melon
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'melon',
    name: 'Melon',
    emoji: '🍈',
    category: VegetableCategory.fruits,
    description:
        "Fruit d'été sucré et parfumé, le melon demande chaleur et patience.",
    note: "Pincer les tiges pour limiter à 3-4 fruits par pied.",
    sowingTechnique: "Semis en godet sous abri puis repiquage",
    sowingDepth: "2 cm",
    germinationTemp: "22 à 28 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil, chaleur indispensable",
    spacing: "1 m × 1,5 m",
    watering: "Régulier, réduire à maturité pour concentrer les sucres",
    soil: "Riche, chaud, bien drainé",
    yieldEstimate: "3 à 5 fruits/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+melon",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 27. Pastèque
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pasteque',
    name: 'Pastèque',
    emoji: '🍉',
    category: VegetableCategory.fruits,
    description:
        "Le fruit le plus rafraîchissant de l'été, gorgé d'eau et de sucre.",
    note: "Très gourmand en chaleur et en eau — le fruit idéal des tropiques.",
    sowingTechnique: "Semis en godet ou semis direct en sol chaud",
    sowingDepth: "2 à 3 cm",
    germinationTemp: "22 à 30 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "1,5 m × 2 m",
    watering: "Abondant et régulier",
    soil: "Sableux, riche, bien drainé, chaud",
    yieldEstimate: "2 à 4 fruits/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pasteque",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 28. Fraise
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'fraise',
    name: 'Fraise',
    emoji: '🍓',
    category: VegetableCategory.fruits,
    description:
        "Petit fruit rouge sucré, la fraise se cultive en pleine terre ou en pot sur un balcon.",
    note: "Pailler le sol pour garder les fruits propres et frais.",
    sowingTechnique: "Plantation de plants ou stolons (le semis est lent)",
    sowingDepth: "Surface, collet au niveau du sol",
    germinationTemp: "15 à 20 °C",
    germinationDays: "15 à 30 jours (si semis)",
    exposure: "Soleil à mi-ombre",
    spacing: "30 × 40 cm",
    watering: "Régulier, surtout à la fructification",
    soil: "Riche, humifère, légèrement acide",
    yieldEstimate: "500 g à 1 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=plants+fraisier",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 29. Navet
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'navet',
    name: 'Navet',
    emoji: '🟣',
    category: VegetableCategory.roots,
    description:
        "Racine douce et rapide à pousser, le navet est un allié des soupes et pot-au-feu.",
    note: "Semer en été pour une récolte d'automne — il préfère le frais.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "4 à 8 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "10 × 25 cm",
    watering: "Régulier, ne pas laisser sécher",
    soil: "Frais, léger, humifère",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+navet",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 30. Betterave
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'betterave',
    name: 'Betterave',
    emoji: '🟤',
    category: VegetableCategory.roots,
    description:
        "Racine sucrée et colorée, la betterave se mange crue ou cuite et colore les plats.",
    note: "Chaque graine donne 2 à 3 plants — éclaircir après la levée.",
    sowingTechnique: "Semis direct en ligne, éclaircir à 10 cm",
    sowingDepth: "2 cm",
    germinationTemp: "12 à 22 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "10 × 30 cm",
    watering: "Régulier, modéré",
    soil: "Meuble, profond, riche",
    yieldEstimate: "3 à 5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+betterave",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 31. Maïs
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'mais',
    name: 'Maïs',
    emoji: '🌽',
    category: VegetableCategory.seeds,
    description:
        "Céréale d'été, le maïs doux se récolte frais pour un goût sucré incomparable.",
    note: "Semer en bloc (pas en ligne) pour favoriser la pollinisation.",
    sowingTechnique: "Semis direct en poquets de 3 graines",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "15 à 25 °C",
    germinationDays: "6 à 10 jours",
    exposure: "Plein soleil",
    spacing: "30 × 70 cm",
    watering: "Régulier, abondant à la floraison",
    soil: "Riche, profond, frais",
    yieldEstimate: "2 à 3 épis/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+mais+doux",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 32. Persil
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'persil',
    name: 'Persil',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromatique indispensable en cuisine, le persil pousse lentement mais dure longtemps.",
    note: "Tremper les graines 24 h avant le semis pour accélérer la levée.",
    sowingTechnique: "Semis direct ou en godet, patient à lever",
    sowingDepth: "0,5 cm",
    germinationTemp: "15 à 22 °C",
    germinationDays: "15 à 30 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "15 × 25 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Riche, frais, humifère",
    yieldEstimate: "200 à 400 g/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+persil",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 33. Coriandre
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'coriandre',
    name: 'Coriandre',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromatique à double usage : feuilles fraîches et graines séchées pour les épices.",
    note: "Monte vite en graines dès qu'il fait chaud — semer en succession.",
    sowingTechnique: "Semis direct en place",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "10 à 15 jours",
    exposure: "Mi-ombre en été, soleil au printemps",
    spacing: "10 × 20 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Léger, drainé, pas trop riche",
    yieldEstimate: "100 à 200 g/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+coriandre",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 34. Ciboulette
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'ciboulette',
    name: 'Ciboulette',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Vivace aromatique facile, la ciboulette revient chaque année et parfume salades et omelettes.",
    note: "Couper régulièrement pour stimuler la repousse.",
    sowingTechnique: "Semis direct ou division de touffe",
    sowingDepth: "0,5 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "10 à 15 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "15 × 20 cm",
    watering: "Régulier, modéré",
    soil: "Ordinaire, frais, drainé",
    yieldEstimate: "Vivace — récolte continue",
    amazonUrl: "https://www.amazon.fr/s?k=graines+ciboulette",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 35. Menthe
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'menthe',
    name: 'Menthe',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromatique vigoureuse et envahissante, la menthe parfume thés, sauces et desserts.",
    note: "Cultiver en pot pour éviter qu'elle n'envahisse tout le jardin.",
    sowingTechnique: "Bouturage ou division de touffe (semis très lent)",
    sowingDepth: "Surface, à peine couverte",
    germinationTemp: "15 à 22 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Mi-ombre à soleil",
    spacing: "30 × 30 cm",
    watering: "Régulier, aime l'humidité",
    soil: "Riche, frais, humifère",
    yieldEstimate: "Vivace — récolte continue",
    amazonUrl: "https://www.amazon.fr/s?k=graines+menthe",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 36. Thym
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'thym',
    name: 'Thym',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromatique méditerranéenne robuste, le thym résiste à la sécheresse et parfume plats et tisanes.",
    note: "Très rustique — demande peu d'eau et de soin une fois installé.",
    sowingTechnique: "Semis en surface ou bouturage",
    sowingDepth: "Surface, ne pas couvrir",
    germinationTemp: "15 à 22 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Plein soleil",
    spacing: "20 × 30 cm",
    watering: "Très faible, supporte la sécheresse",
    soil: "Pauvre, caillouteux, très bien drainé",
    yieldEstimate: "Vivace — récolte continue",
    amazonUrl: "https://www.amazon.fr/s?k=graines+thym",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 37. Fève
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'feve',
    name: 'Fève',
    emoji: '🫛',
    category: VegetableCategory.seeds,
    description:
        "Légumineuse de printemps, la fève est riche en protéines et enrichit le sol en azote.",
    note: "Pincer les tiges dès l'apparition des pucerons noirs en haut.",
    sowingTechnique: "Semis direct en poquets",
    sowingDepth: "4 à 5 cm",
    germinationTemp: "8 à 15 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Soleil",
    spacing: "15 × 40 cm",
    watering: "Modéré, pas en excès",
    soil: "Argileux, profond, frais",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+feve",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 38. Igname
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'igname',
    name: 'Igname',
    emoji: '🟤',
    category: VegetableCategory.tubers,
    description:
        "Grand tubercule tropical, base de l'alimentation en Afrique de l'Ouest. Riche en amidon.",
    note: "Cycle long (8 à 12 mois) — planter en début de saison des pluies.",
    sowingTechnique: "Plantation de fragments de tubercules ou de mini-semenceaux",
    sowingDepth: "10 à 15 cm",
    germinationTemp: "25 à 30 °C",
    germinationDays: "20 à 40 jours",
    exposure: "Plein soleil",
    spacing: "50 × 100 cm",
    watering: "Régulier en croissance, réduire à maturité",
    soil: "Profond, meuble, riche, bien drainé",
    yieldEstimate: "5 à 15 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=igname+a+planter",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 39. Manioc
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'manioc',
    name: 'Manioc',
    emoji: '🟤',
    category: VegetableCategory.tubers,
    description:
        "Tubercule tropical résistant à la sécheresse, base de l'alimentation de millions de personnes.",
    note: "Se multiplie par boutures de tige — pas de graines nécessaires.",
    sowingTechnique: "Bouturage de tiges de 20 à 30 cm, plantées en biais",
    sowingDepth: "5 à 10 cm (biais à 45°)",
    germinationTemp: "25 à 35 °C",
    germinationDays: "10 à 15 jours (bourgeonnement)",
    exposure: "Plein soleil",
    spacing: "80 × 100 cm",
    watering: "Faible, résiste à la sécheresse",
    soil: "Léger, sableux, bien drainé",
    yieldEstimate: "5 à 15 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=manioc+bouture",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // 40. Niébé (haricot à œil noir)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'niebe',
    name: 'Niébé',
    emoji: '🫘',
    category: VegetableCategory.seeds,
    description:
        "Haricot à œil noir, pilier des protéines végétales en Afrique de l'Ouest. Très résistant à la chaleur.",
    note: "Culture facile, enrichit le sol en azote comme toutes les légumineuses.",
    sowingTechnique: "Semis direct en poquets de 2-3 graines",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "20 à 30 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "20 × 50 cm",
    watering: "Modéré, résiste bien à la sécheresse",
    soil: "Pauvre à moyen, sableux, bien drainé",
    yieldEstimate: "0,5 à 1,5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+niebe",
  ),
  // ════════════════════════════════════════════════════════════════════════
  // LÉGUMES 41–60
  // ════════════════════════════════════════════════════════════════════════

  Vegetable(
    id: 'artichaut',
    name: 'Artichaut',
    emoji: '🌿',
    category: VegetableCategory.flowers,
    description:
        "Bouton floral charnu et raffiné, l'artichaut est une vivace spectaculaire au potager.",
    note: "Vivace — un pied produit pendant 3 à 5 ans.",
    sowingTechnique: "Plantation d'œilletons ou semis sous abri",
    sowingDepth: "2 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "10 à 15 jours",
    exposure: "Soleil, à l'abri du vent",
    spacing: "80 × 100 cm",
    watering: "Régulier, généreux",
    soil: "Riche, profond, bien drainé",
    yieldEstimate: "6 à 10 têtes/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+artichaut",
  ),

  Vegetable(
    id: 'blette',
    name: 'Blette',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Aussi appelée bette ou poirée, on consomme ses larges côtes et ses feuilles tendres.",
    note: "Très productive — un seul pied nourrit pendant des mois.",
    sowingTechnique: "Semis direct en ligne ou en godet",
    sowingDepth: "2 cm",
    germinationTemp: "12 à 22 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "30 × 40 cm",
    watering: "Régulier, aime le frais",
    soil: "Riche, frais, profond",
    yieldEstimate: "3 à 5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+blette",
  ),

  Vegetable(
    id: 'celeri',
    name: 'Céleri',
    emoji: '🌿',
    category: VegetableCategory.stems,
    description:
        "Branche ou rave, le céleri parfume soupes et salades avec son goût puissant.",
    note: "Semis très long à lever — patience requise.",
    sowingTechnique: "Semis sous abri en terrine, repiquage",
    sowingDepth: "Surface, à peine couverte",
    germinationTemp: "18 à 22 °C",
    germinationDays: "15 à 25 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "30 × 35 cm",
    watering: "Abondant et constant",
    soil: "Riche, humifère, frais",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+celeri",
  ),

  Vegetable(
    id: 'mache',
    name: 'Mâche',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Petite salade d'hiver au goût doux et noisette, ultra-rustique au froid.",
    note: "La salade d'hiver par excellence — semée en automne, récoltée en hiver.",
    sowingTechnique: "Semis direct à la volée ou en ligne",
    sowingDepth: "0,5 cm",
    germinationTemp: "10 à 15 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Mi-ombre à soleil",
    spacing: "5 × 15 cm",
    watering: "Modéré, sol frais",
    soil: "Ordinaire, tassé, frais",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+mache",
  ),

  Vegetable(
    id: 'roquette',
    name: 'Roquette',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Feuilles piquantes et poivrées, la roquette pousse vite et relève les salades.",
    note: "Monte vite en graines l'été — préférer le printemps ou l'automne.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "0,5 cm",
    germinationTemp: "10 à 20 °C",
    germinationDays: "5 à 8 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "5 × 20 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Ordinaire, frais",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+roquette",
  ),

  Vegetable(
    id: 'chou_kale',
    name: 'Chou kale',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Super-aliment à la mode, le kale est un chou frisé ultra-rustique qui résiste au gel.",
    note: "Le goût s'améliore après les premières gelées.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil à mi-ombre",
    spacing: "40 × 50 cm",
    watering: "Régulier",
    soil: "Riche, frais, humifère",
    yieldEstimate: "2 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+kale",
  ),

  Vegetable(
    id: 'arachide',
    name: 'Arachide',
    emoji: '🥜',
    category: VegetableCategory.seeds,
    description:
        "La cacahuète pousse sous terre — une légumineuse originale et productive en climat chaud.",
    note: "Les fleurs se courbent vers le sol pour enfouir les gousses.",
    sowingTechnique: "Semis direct de graines décortiquées",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "20 à 30 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil",
    spacing: "20 × 40 cm",
    watering: "Modéré, stopper avant récolte",
    soil: "Léger, sableux, bien drainé",
    yieldEstimate: "0,5 à 1 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+arachide",
  ),

  Vegetable(
    id: 'bissap',
    name: 'Bissap (Oseille de Guinée)',
    emoji: '🌺',
    category: VegetableCategory.flowers,
    description:
        "Hibiscus sabdariffa — ses calices rouges servent à préparer la célèbre boisson bissap.",
    note: "Plante décorative au jardin et utile en cuisine — double usage.",
    sowingTechnique: "Semis direct ou en godet",
    sowingDepth: "1 cm",
    germinationTemp: "22 à 30 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil",
    spacing: "50 × 60 cm",
    watering: "Modéré, supporte la sécheresse",
    soil: "Ordinaire, bien drainé",
    yieldEstimate: "0,5 à 1 kg de calices/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+bissap+hibiscus",
  ),

  Vegetable(
    id: 'sesame',
    name: 'Sésame',
    emoji: '🌾',
    category: VegetableCategory.seeds,
    description:
        "Petite graine oléagineuse au goût de noisette, base du tahini et de nombreuses pâtisseries.",
    note: "Récolter avant que les capsules ne s'ouvrent — elles libèrent les graines.",
    sowingTechnique: "Semis direct en sol chaud",
    sowingDepth: "0,5 à 1 cm",
    germinationTemp: "20 à 30 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "10 × 30 cm",
    watering: "Faible, résiste à la sécheresse",
    soil: "Léger, sableux, bien drainé",
    yieldEstimate: "100 à 300 g/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+sesame+a+semer",
  ),

  Vegetable(
    id: 'gingembre',
    name: 'Gingembre',
    emoji: '🫚',
    category: VegetableCategory.aromatics,
    description:
        "Rhizome aromatique piquant et citronné, utilisé frais ou séché en cuisine et en tisane.",
    note: "Se cultive à partir d'un morceau de rhizome frais du commerce.",
    sowingTechnique: "Plantation de rhizomes à bourgeons",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "22 à 30 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Mi-ombre à soleil tamisé",
    spacing: "20 × 30 cm",
    watering: "Régulier, aime l'humidité",
    soil: "Riche, léger, humifère, bien drainé",
    yieldEstimate: "200 à 500 g/pied",
    amazonUrl: "https://www.amazon.fr/s?k=gingembre+a+planter",
  ),

  Vegetable(
    id: 'asperge',
    name: 'Asperge',
    emoji: '🌿',
    category: VegetableCategory.stems,
    description:
        "Vivace de luxe, l'asperge demande de la patience mais produit pendant 15 à 20 ans.",
    note: "Attendre 2 à 3 ans après la plantation avant la première récolte.",
    sowingTechnique: "Plantation de griffes en tranchée",
    sowingDepth: "15 à 20 cm (tranchée)",
    germinationTemp: "15 à 22 °C",
    germinationDays: "20 à 30 jours (si semis)",
    exposure: "Soleil",
    spacing: "40 × 150 cm",
    watering: "Modéré, sol drainé",
    soil: "Léger, sableux, profond, bien drainé",
    yieldEstimate: "500 g à 1 kg/pied/an",
    amazonUrl: "https://www.amazon.fr/s?k=griffes+asperge",
  ),

  Vegetable(
    id: 'fenouil',
    name: 'Fenouil',
    emoji: '🌿',
    category: VegetableCategory.bulbs,
    description:
        "Bulbe blanc au goût anisé, le fenouil est croquant cru et fondant cuit.",
    note: "Sensible à la montée en graines — éviter le stress hydrique.",
    sowingTechnique: "Semis direct ou en godet",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 22 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Plein soleil",
    spacing: "25 × 40 cm",
    watering: "Régulier et constant",
    soil: "Riche, frais, humifère",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+fenouil",
  ),

  Vegetable(
    id: 'endive',
    name: 'Endive (Chicon)',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Feuilles blanches et croquantes obtenues par forçage en cave — une technique originale.",
    note: "Culture en 2 temps : racines au jardin, puis forçage en obscurité.",
    sowingTechnique: "Semis direct, puis arrachage et forçage en cave",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "8 à 12 jours",
    exposure: "Soleil (phase racine), obscurité (phase forçage)",
    spacing: "15 × 30 cm",
    watering: "Régulier (phase racine), faible (phase forçage)",
    soil: "Profond, meuble",
    yieldEstimate: "1 chicon par racine",
    amazonUrl: "https://www.amazon.fr/s?k=graines+endive+chicoree",
  ),

  Vegetable(
    id: 'chou_bruxelles',
    name: 'Chou de Bruxelles',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Petites pommes vertes le long d'une tige, le chou de Bruxelles adore le froid.",
    note: "Le gel améliore la saveur — ne pas récolter trop tôt.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil",
    spacing: "50 × 60 cm",
    watering: "Régulier",
    soil: "Riche, argileux, frais",
    yieldEstimate: "1 à 2 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+bruxelles",
  ),

  Vegetable(
    id: 'potimarron',
    name: 'Potimarron',
    emoji: '🎃',
    category: VegetableCategory.fruits,
    description:
        "Courge au goût de châtaigne, dont la peau se mange — très pratique en soupe.",
    note: "Moins envahissant que le potiron, idéal pour petits jardins.",
    sowingTechnique: "Semis en godet sous abri puis repiquage",
    sowingDepth: "2 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "6 à 10 jours",
    exposure: "Plein soleil",
    spacing: "1 m × 1,5 m",
    watering: "Régulier, au pied",
    soil: "Riche, profond, bien fumé",
    yieldEstimate: "3 à 6 fruits/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+potimarron",
  ),

  Vegetable(
    id: 'oseille',
    name: 'Oseille',
    emoji: '🌿',
    category: VegetableCategory.leaves,
    description:
        "Vivace acidulée, l'oseille donne du pep aux soupes, sauces et salades.",
    note: "Vivace facile — un pied dure des années avec peu de soins.",
    sowingTechnique: "Semis direct ou division de touffe",
    sowingDepth: "0,5 cm",
    germinationTemp: "12 à 20 °C",
    germinationDays: "8 à 15 jours",
    exposure: "Mi-ombre à soleil",
    spacing: "20 × 30 cm",
    watering: "Régulier, aime le frais",
    soil: "Riche, frais, légèrement acide",
    yieldEstimate: "Vivace — récolte continue",
    amazonUrl: "https://www.amazon.fr/s?k=graines+oseille",
  ),

  Vegetable(
    id: 'taro',
    name: 'Taro',
    emoji: '🟤',
    category: VegetableCategory.tubers,
    description:
        "Tubercule tropical riche en amidon, base alimentaire en Afrique, Asie et Caraïbes.",
    note: "Toujours cuire avant consommation — le taro cru est irritant.",
    sowingTechnique: "Plantation de tubercules ou rejets",
    sowingDepth: "10 cm",
    germinationTemp: "22 à 30 °C",
    germinationDays: "15 à 30 jours",
    exposure: "Mi-ombre à soleil",
    spacing: "40 × 60 cm",
    watering: "Abondant, aime les sols humides",
    soil: "Riche, humide, humifère",
    yieldEstimate: "2 à 5 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=taro+bulbe+a+planter",
  ),

  Vegetable(
    id: 'amarante',
    name: 'Amarante',
    emoji: '🌾',
    category: VegetableCategory.leaves,
    description:
        "Double usage : feuilles consommées comme épinard en Afrique, graines comme céréale.",
    note: "Pousse très vite en climat chaud — quasi aucune maladie.",
    sowingTechnique: "Semis direct à la volée ou en ligne",
    sowingDepth: "0,5 cm",
    germinationTemp: "20 à 30 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "15 × 30 cm",
    watering: "Modéré, résiste bien à la sécheresse",
    soil: "Ordinaire, bien drainé",
    yieldEstimate: "2 à 4 kg/m² (feuilles)",
    amazonUrl: "https://www.amazon.fr/s?k=graines+amarante",
  ),

  Vegetable(
    id: 'sorgho',
    name: 'Sorgho',
    emoji: '🌾',
    category: VegetableCategory.seeds,
    description:
        "Céréale tropicale résistante à la sécheresse, base du tô et du couscous de mil en Afrique.",
    note: "5e céréale mondiale — pousse là où le maïs ne résiste pas.",
    sowingTechnique: "Semis direct en poquets",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "18 à 30 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "20 × 50 cm",
    watering: "Faible, très résistant à la sécheresse",
    soil: "Ordinaire, sableux à argileux, drainé",
    yieldEstimate: "300 à 600 g/m² (grains)",
    amazonUrl: "https://www.amazon.fr/s?k=graines+sorgho",
  ),
  // ── Accessoires jardinage ──
  Vegetable(
    id: 'acc_secateur',
    name: 'Sécateur',
    emoji: '✂️',
    category: VegetableCategory.accessories,
    note: 'Indispensable pour tailler et récolter',
    description: 'Outil de base pour couper les branches, récolter les légumes et entretenir vos plants. Choisissez un modèle ergonomique avec lame en acier.',
    amazonUrl: 'https://www.amazon.fr/s?k=sécateur+jardinage',
    accessorySub: AccessorySubCategory.tools,
  ),
  Vegetable(
    id: 'acc_arrosoir',
    name: 'Arrosoir',
    emoji: '🚿',
    category: VegetableCategory.accessories,
    note: 'Pour un arrosage doux et précis',
    description: 'Arrosoir avec pomme fine pour un arrosage en pluie douce, idéal pour les semis et jeunes plants. Capacité recommandée : 5 à 10 litres.',
    amazonUrl: 'https://www.amazon.fr/s?k=arrosoir+jardinage',
    accessorySub: AccessorySubCategory.tools,
  ),
  Vegetable(
    id: 'acc_terreau',
    name: 'Terreau bio',
    emoji: '🪴',
    category: VegetableCategory.accessories,
    note: 'La base pour des plants en bonne santé',
    description: 'Terreau universel biologique enrichi en compost. Idéal pour les semis, le rempotage et le potager en bacs.',
    amazonUrl: 'https://www.amazon.fr/s?k=terreau+bio+potager',
    accessorySub: AccessorySubCategory.soil,
  ),
  Vegetable(
    id: 'acc_engrais',
    name: 'Engrais bio',
    emoji: '🧪',
    category: VegetableCategory.accessories,
    note: 'Nourrir le sol naturellement',
    description: 'Engrais organique pour potager : fumier composté, purin d\'ortie ou granulés bio. Stimule la croissance sans produits chimiques.',
    amazonUrl: 'https://www.amazon.fr/s?k=engrais+bio+potager',
    accessorySub: AccessorySubCategory.soil,
  ),
  Vegetable(
    id: 'acc_bac',
    name: 'Bac potager',
    emoji: '📦',
    category: VegetableCategory.accessories,
    note: 'Potager surélevé pour balcon ou terrasse',
    description: 'Bac en bois ou plastique recyclé pour cultiver sur un balcon, une terrasse ou un petit jardin. Hauteur idéale : 40 à 80 cm.',
    amazonUrl: 'https://www.amazon.fr/s?k=bac+potager+surélevé',
    accessorySub: AccessorySubCategory.pots,
  ),
  Vegetable(
    id: 'acc_tuteur',
    name: 'Tuteurs',
    emoji: '🥢',
    category: VegetableCategory.accessories,
    note: 'Soutenir tomates, haricots, pois...',
    description: 'Tuteurs en bambou, métal ou spirale pour guider la croissance des plants grimpants. Indispensable pour tomates et haricots.',
    amazonUrl: 'https://www.amazon.fr/s?k=tuteur+potager+bambou',
    accessorySub: AccessorySubCategory.tools,
  ),
  Vegetable(
    id: 'acc_graines',
    name: 'Kit semences bio',
    emoji: '🌱',
    category: VegetableCategory.accessories,
    note: 'Coffret de graines variées pour démarrer',
    description: 'Assortiment de semences bio : tomates, carottes, salades, radis, basilic... Parfait pour débuter son potager.',
    amazonUrl: 'https://www.amazon.fr/s?k=kit+graines+potager+bio',
    accessorySub: AccessorySubCategory.seeds,
  ),
  Vegetable(
    id: 'acc_gants',
    name: 'Gants de jardinage',
    emoji: '🧤',
    category: VegetableCategory.accessories,
    note: 'Protéger ses mains au jardin',
    description: 'Gants résistants et confortables pour le jardinage. Choisir un modèle anti-épines avec bonne préhension.',
    amazonUrl: 'https://www.amazon.fr/s?k=gants+jardinage',
    accessorySub: AccessorySubCategory.tools,
  ),
];
