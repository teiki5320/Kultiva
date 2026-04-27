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
    amazonUrl: "https://www.amazon.fr/s?k=graines+tomate&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+carotte&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+courgette&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+laitue&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+haricot+vert&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+aubergine&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+poivron&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+epinard&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+oignon&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+basilic&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+concombre&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+piment&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=ail+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=pomme+de+terre+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+radis&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+pomme&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+petit+pois&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+poireau&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=patate+douce+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+gombo&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=echalote+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+fleur&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+brocoli&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+courge+butternut&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+potiron&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+melon&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+pasteque&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=plants+fraisier&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+navet&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+betterave&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+mais+doux&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+persil&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+coriandre&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+ciboulette&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+menthe&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+thym&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+feve&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=igname+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=manioc+bouture&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+niebe&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+artichaut&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+blette&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+celeri&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+mache&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+roquette&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+kale&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+arachide&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+bissap+hibiscus&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+sesame+a+semer&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=gingembre+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=griffes+asperge&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+fenouil&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+endive+chicoree&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+bruxelles&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+potimarron&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+oseille&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=taro+bulbe+a+planter&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+amarante&tag=kultiva-21",
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
    amazonUrl: "https://www.amazon.fr/s?k=graines+sorgho&tag=kultiva-21",
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Cornichon
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'cornichon',
    name: 'Cornichon',
    emoji: '🥒',
    category: VegetableCategory.fruits,
    description:
        "Petit concombre récolté jeune, parfait pour les conserves au vinaigre. Plante prolifique, croissance rapide en plein soleil.",
    note: "Récolte tous les 2 jours pour des cornichons fermes.",
    sowingTechnique: "Semis en godet sous abri ou semis direct après les gelées",
    sowingDepth: "1 à 2 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "7 à 10 jours",
    exposure: "Plein soleil",
    spacing: "60 × 100 cm",
    watering: "Régulier, au pied, sans mouiller le feuillage",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "2 à 4 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=graines+cornichon&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': '60 à 75 jours',
      'summer': '50 à 65 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Panais
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'panais',
    name: 'Panais',
    emoji: '🥕',
    category: VegetableCategory.roots,
    description:
        "Racine blanche au goût sucré et anisé, proche de la carotte. Très rustique, supporte les gelées qui adoucissent sa chair.",
    note: "Semer dès mars en sol meuble — germination lente (3 à 4 semaines).",
    sowingTechnique: "Semis direct en ligne, graines fraîches",
    sowingDepth: "1 cm",
    germinationTemp: "10 à 15 °C",
    germinationDays: "20 à 30 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "10 × 30 cm",
    watering: "Régulier, sans excès",
    soil: "Profond, meuble, sans cailloux",
    yieldEstimate: "3 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+panais&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': '150 à 180 jours',
      'autumn': '120 à 150 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Rutabaga
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'rutabaga',
    name: 'Rutabaga',
    emoji: '🥔',
    category: VegetableCategory.roots,
    description:
        "Racine généreuse à chair jaune, croisement entre chou et navet. Goût doux, parfait pour potages et purées d'hiver.",
    note: "Légume rustique, idéal pour la conservation en cave.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 18 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "20 × 40 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Frais, profond, riche en humus",
    yieldEstimate: "3 à 5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+rutabaga&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': '100 à 130 jours',
      'autumn': '90 à 110 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Topinambour
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'topinambour',
    name: 'Topinambour',
    emoji: '🥔',
    category: VegetableCategory.tubers,
    description:
        "Tubercule rustique à saveur d'artichaut. Plante vivace géante de 2 à 3 m, productive et increvable, mais peut devenir envahissante.",
    note: "Une fois planté, revient chaque année — choisir l'emplacement avec soin.",
    sowingTechnique: "Plantation de tubercules au printemps",
    sowingDepth: "8 à 10 cm",
    germinationTemp: "10 à 15 °C",
    germinationDays: "20 à 30 jours (levée)",
    exposure: "Soleil",
    spacing: "40 × 80 cm",
    watering: "Faible, plante très rustique",
    soil: "Tout type, même pauvre",
    yieldEstimate: "3 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=tubercules+topinambour&tag=kultiva-21",
    harvestTimeBySeason: {
      'autumn': '180 à 210 jours',
      'winter': '200 à 240 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Salsifis
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'salsifis',
    name: 'Salsifis',
    emoji: '🌱',
    category: VegetableCategory.roots,
    description:
        "Racine longue et fine au goût d'huître ou d'asperge. Légume oublié à redécouvrir, riche en inuline et fibres.",
    note: "Semer en place dès avril — repiquage difficile.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1,5 cm",
    germinationTemp: "12 à 18 °C",
    germinationDays: "10 à 20 jours",
    exposure: "Soleil",
    spacing: "10 × 30 cm",
    watering: "Régulier, sans excès",
    soil: "Meuble, profond, sans cailloux",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+salsifis&tag=kultiva-21",
    harvestTimeBySeason: {
      'autumn': '120 à 150 jours',
      'winter': '150 à 180 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Radis noir
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'radis_noir',
    name: 'Radis noir',
    emoji: '🌑',
    category: VegetableCategory.roots,
    description:
        "Radis d'hiver à peau noire et chair blanche, piquant et croquant. Très bonne conservation, riche en vitamine C.",
    note: "Semer en été pour récolter à l'automne et conserver tout l'hiver.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "1 cm",
    germinationTemp: "12 à 18 °C",
    germinationDays: "5 à 8 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "10 × 30 cm",
    watering: "Régulier, sol toujours frais",
    soil: "Meuble, profond, riche",
    yieldEstimate: "3 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+radis+noir&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': '70 à 90 jours',
      'autumn': '80 à 100 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Chou-rave
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'chou_rave',
    name: 'Chou-rave',
    emoji: '🥬',
    category: VegetableCategory.stems,
    description:
        "Chou à tige renflée en boule, à la chair tendre et sucrée. Se mange cru ou cuit, très digeste.",
    note: "Récolter jeune (5-7 cm) pour une chair fondante.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "25 × 30 cm",
    watering: "Régulier, ne pas laisser sécher",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "3 à 4 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+rave&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': '60 à 80 jours',
      'summer': '60 à 75 jours',
      'autumn': '70 à 90 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Cresson de fontaine
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'cresson',
    name: 'Cresson de fontaine',
    emoji: '🌿',
    category: VegetableCategory.leaves,
    description:
        "Plante aquatique au goût piquant et iodé, très riche en vitamines. Pousse au bord d'un ruisseau ou en jardinière constamment humide.",
    note: "Aime l'eau courante ou un substrat très humide.",
    sowingTechnique: "Semis en pleine eau ou bouturage",
    sowingDepth: "Surface",
    germinationTemp: "12 à 18 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Mi-ombre",
    spacing: "15 × 20 cm",
    watering: "Permanent, sol détrempé",
    soil: "Argileux, riche en humus, très humide",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+cresson+fontaine&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': '50 à 70 jours',
      'autumn': '60 à 80 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pak choï
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pak_choi',
    name: 'Pak choï',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Chou chinois à côtes blanches et feuilles vertes, croissance ultra-rapide. Délicieux sauté au wok ou en soupe.",
    note: "Récolte 30 à 45 jours après semis — parfait pour débuter.",
    sowingTechnique: "Semis direct ou en godet",
    sowingDepth: "0,5 cm",
    germinationTemp: "15 à 22 °C",
    germinationDays: "5 à 8 jours",
    exposure: "Mi-ombre en été, soleil au printemps",
    spacing: "20 × 30 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "2 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pak+choi&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': '30 à 45 jours',
      'autumn': '40 à 55 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pourpier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pourpier',
    name: 'Pourpier',
    emoji: '🌿',
    category: VegetableCategory.leaves,
    description:
        "Plante grasse aux feuilles charnues et acidulées, très riche en oméga-3. Résiste à la sécheresse, idéale en plein été.",
    note: "Se ressème spontanément, presque indestructible.",
    sowingTechnique: "Semis direct à la volée",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil",
    spacing: "15 × 20 cm",
    watering: "Faible, plante très résistante",
    soil: "Léger, sableux, drainé",
    yieldEstimate: "1 à 2 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pourpier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': '40 à 55 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Chou chinois (Napa)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'chou_chinois',
    name: 'Chou chinois (Napa)',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    description:
        "Chou pommé allongé à feuilles tendres et nervures blanches. Base du kimchi coréen, parfait en salade ou sauté.",
    note: "Préfère les températures fraîches — semer en fin d'été.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "0,5 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "30 × 40 cm",
    watering: "Régulier, garder le sol frais",
    soil: "Riche, frais, bien drainé",
    yieldEstimate: "4 à 6 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+chou+chinois+napa&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': '60 à 80 jours',
      'autumn': '70 à 90 jours',
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Romarin
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'romarin',
    name: 'Romarin',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Arbrisseau aromatique méditerranéen aux feuilles persistantes. Très résistant à la sécheresse, présent toute l'année au jardin.",
    note: "Plante vivace — un seul plant suffit pour des années.",
    sowingTechnique: "Semis difficile — préférer le bouturage ou l'achat de plant",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 25 °C",
    germinationDays: "21 à 30 jours",
    exposure: "Plein soleil",
    spacing: "60 × 80 cm",
    watering: "Faible, très résistant à la sécheresse",
    soil: "Pauvre, sec, calcaire, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=plant+romarin&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
      'winter': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Sauge officinale
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'sauge',
    name: 'Sauge officinale',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate méditerranéen aux feuilles veloutées gris-vert. Saveur puissante pour viandes et farces, vertus médicinales reconnues.",
    note: "Plante vivace — tailler après floraison pour la garder compacte.",
    sowingTechnique: "Semis en godet ou bouturage",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Plein soleil",
    spacing: "40 × 50 cm",
    watering: "Faible",
    soil: "Sec, calcaire, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=plant+sauge+officinale&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Origan
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'origan',
    name: 'Origan',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate vivace au parfum chaud, indispensable en cuisine italienne. Floraison rose mellifère qui attire les pollinisateurs.",
    note: "Récolter au moment de la floraison pour un arôme maximal.",
    sowingTechnique: "Semis en godet ou division de touffe",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "10 à 21 jours",
    exposure: "Plein soleil",
    spacing: "30 × 40 cm",
    watering: "Faible",
    soil: "Sec, calcaire, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=graines+origan&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Estragon
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'estragon',
    name: 'Estragon',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate fin au goût anisé, indispensable à la cuisine française (béarnaise, vinaigre d'estragon). Préférer la variété française à la russe (moins parfumée).",
    note: "Multiplication par division — les graines donnent souvent l'estragon russe sans saveur.",
    sowingTechnique: "Plantation de plant — éviter les graines",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil",
    spacing: "40 × 50 cm",
    watering: "Modéré",
    soil: "Léger, drainé, neutre",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=plant+estragon+francais&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Sarriette
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'sarriette',
    name: 'Sarriette',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate poivré qui parfume haricots, fromages frais et grillades. La sarriette des montagnes (vivace) est plus rustique que celle des jardins (annuelle).",
    note: "Plantée près des haricots, elle éloigne les pucerons.",
    sowingTechnique: "Semis en place ou en godet",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "10 à 21 jours",
    exposure: "Plein soleil",
    spacing: "25 × 30 cm",
    watering: "Faible",
    soil: "Sec, calcaire, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=graines+sarriette&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "70 à 90 jours",
      'autumn': "Récolte continue jusqu'aux gelées",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Aneth
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'aneth',
    name: 'Aneth',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate annuel aux feuilles plumeuses au goût frais et anisé. Indispensable avec le saumon, les concombres et les marinades.",
    note: "Semer toutes les 3 semaines pour une récolte continue.",
    sowingTechnique: "Semis direct en place — supporte mal le repiquage",
    sowingDepth: "0,5 cm",
    germinationTemp: "10 à 18 °C",
    germinationDays: "10 à 14 jours",
    exposure: "Soleil",
    spacing: "20 × 30 cm",
    watering: "Régulier",
    soil: "Léger, drainé, neutre",
    yieldEstimate: "Récolte sur 2 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+aneth&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "40 à 60 jours",
      'summer': "30 à 50 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Cerfeuil
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'cerfeuil',
    name: 'Cerfeuil',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate fin et délicat au goût anisé subtil, base des fines herbes. Préfère la mi-ombre et la fraîcheur.",
    note: "Semer en mars-avril ou en septembre — n'aime pas la chaleur.",
    sowingTechnique: "Semis direct en place",
    sowingDepth: "0,5 cm",
    germinationTemp: "12 à 18 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Mi-ombre",
    spacing: "15 × 25 cm",
    watering: "Régulier, sol toujours frais",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "Récolte sur 2 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+cerfeuil&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "45 à 60 jours",
      'autumn': "50 à 70 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Mélisse citronnelle
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'melisse',
    name: 'Mélisse citronnelle',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Aromate vivace au parfum citronné, parfaite en tisane apaisante avant le coucher. Très mellifère, attire les abeilles.",
    note: "Plante vivace — peut devenir envahissante par semis spontané.",
    sowingTechnique: "Semis ou division de touffe",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Soleil ou mi-ombre",
    spacing: "40 × 50 cm",
    watering: "Modéré",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=plant+melisse+citronnelle&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Verveine citronnée
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'verveine',
    name: 'Verveine citronnée',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Arbuste à feuilles vert vif au parfum citronné intense. La star des tisanes du soir, à protéger du gel en hiver.",
    note: "Frileuse — rentrer en pot ou pailler en hiver dans le nord.",
    sowingTechnique: "Bouturage ou achat de plant",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "60 × 80 cm",
    watering: "Modéré",
    soil: "Léger, drainé, neutre",
    yieldEstimate: "Récolte sur la belle saison",
    amazonUrl: "https://www.amazon.fr/s?k=plant+verveine+citronnee&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Laurier-sauce
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'laurier_sauce',
    name: 'Laurier-sauce',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Arbuste persistant aux feuilles vert sombre, indispensable au bouquet garni. Pousse aussi bien en pot qu'en pleine terre, peut atteindre 3 m.",
    note: "Ne pas confondre avec le laurier-rose ou laurier-cerise (toxiques).",
    sowingTechnique: "Bouturage ou achat de plant",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "1 × 1,5 m",
    watering: "Faible une fois installé",
    soil: "Tout type, drainé",
    yieldEstimate: "Récolte permanente",
    amazonUrl: "https://www.amazon.fr/s?k=plant+laurier+sauce&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte permanente",
      'summer': "Récolte permanente",
      'autumn': "Récolte permanente",
      'winter': "Récolte permanente",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Camomille romaine
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'camomille',
    name: 'Camomille romaine',
    emoji: '🌼',
    category: VegetableCategory.aromatics,
    description:
        "Plante vivace tapissante aux petites fleurs blanches très parfumées. Tisane apaisante et digestive, classique du jardin de grand-mère.",
    note: "Récolter les fleurs en plein soleil pour préserver les arômes.",
    sowingTechnique: "Semis en surface ou division de touffe",
    sowingDepth: "0,1 cm (en surface)",
    germinationTemp: "15 à 20 °C",
    germinationDays: "10 à 14 jours",
    exposure: "Plein soleil",
    spacing: "20 × 25 cm",
    watering: "Modéré",
    soil: "Léger, drainé, neutre",
    yieldEstimate: "Récolte des fleurs sur 2 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+camomille+romaine&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "70 à 90 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Marjolaine
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'marjolaine',
    name: 'Marjolaine',
    emoji: '🌿',
    category: VegetableCategory.aromatics,
    description:
        "Cousine plus douce de l'origan, parfaite pour les viandes blanches et les sauces tomate. Plante annuelle ou vivace selon le climat.",
    note: "À ne pas confondre avec l'origan — la marjolaine est plus subtile.",
    sowingTechnique: "Semis en godet ou en place",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "10 à 14 jours",
    exposure: "Plein soleil",
    spacing: "25 × 30 cm",
    watering: "Faible",
    soil: "Léger, calcaire, drainé",
    yieldEstimate: "Récolte sur la belle saison",
    amazonUrl: "https://www.amazon.fr/s?k=graines+marjolaine&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "60 à 80 jours",
      'autumn': "Récolte continue",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Lentille verte
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'lentille',
    name: 'Lentille verte',
    emoji: '🫘',
    category: VegetableCategory.seeds,
    description:
        "Légumineuse à grains plats riche en protéines, base des soupes et plats traditionnels. La lentille verte du Puy bénéficie d'une AOP française.",
    note: "Plante peu exigeante — fixe l'azote et enrichit le sol.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "2 à 3 cm",
    germinationTemp: "10 à 18 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "5 × 30 cm",
    watering: "Faible",
    soil: "Pauvre, calcaire, drainé",
    yieldEstimate: "150 à 250 g/m² (grains secs)",
    amazonUrl: "https://www.amazon.fr/s?k=graines+lentille+verte+puy&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "100 à 110 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pois chiche
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pois_chiche',
    name: 'Pois chiche',
    emoji: '🫘',
    category: VegetableCategory.seeds,
    description:
        "Légumineuse star de la cuisine méditerranéenne (houmous, falafels). Résistante à la sécheresse, parfaite pour les sols pauvres.",
    note: "Aime la chaleur — réservée au sud ou semis tardif.",
    sowingTechnique: "Semis direct après les gelées",
    sowingDepth: "3 à 5 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Plein soleil",
    spacing: "10 × 40 cm",
    watering: "Faible, très résistant à la sécheresse",
    soil: "Léger, calcaire, drainé",
    yieldEstimate: "200 à 350 g/m² (grains secs)",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pois+chiche&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "100 à 120 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pois mange-tout
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pois_mange_tout',
    name: 'Pois mange-tout',
    emoji: '🫛',
    category: VegetableCategory.seeds,
    description:
        "Pois à cosse tendre qu'on mange en entier, sans écosser. Croquant et sucré, parfait au wok ou cru à la croque.",
    note: "Récolter jeune avant que les graines ne grossissent dans la cosse.",
    sowingTechnique: "Semis direct en ligne",
    sowingDepth: "3 cm",
    germinationTemp: "10 à 18 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Soleil",
    spacing: "5 × 40 cm",
    watering: "Régulier en floraison",
    soil: "Frais, drainé, peu fumé",
    yieldEstimate: "1,5 à 2,5 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pois+mange+tout&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "60 à 75 jours",
      'summer': "55 à 70 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Haricot beurre
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'haricot_beurre',
    name: 'Haricot beurre',
    emoji: '🫛',
    category: VegetableCategory.seeds,
    description:
        "Haricot à gousses jaune doré, à la chair fondante et au goût doux. Productif et facile, idéal pour débuter.",
    note: "Récolter régulièrement pour stimuler la production.",
    sowingTechnique: "Semis direct après les gelées, en poquets",
    sowingDepth: "3 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "7 à 10 jours",
    exposure: "Plein soleil",
    spacing: "10 × 40 cm",
    watering: "Régulier, surtout en floraison",
    soil: "Frais, drainé, peu fumé",
    yieldEstimate: "1,5 à 3 kg/m²",
    amazonUrl: "https://www.amazon.fr/s?k=graines+haricot+beurre&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "60 à 75 jours",
      'summer': "50 à 65 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Framboisier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'framboisier',
    name: 'Framboisier',
    emoji: '🫐',
    category: VegetableCategory.fruits,
    description:
        "Petit fruit rouge parfumé sur arbuste vivace. Variétés remontantes (deux récoltes) ou non remontantes (une grosse récolte en juin).",
    note: "Pailler généreusement et tailler chaque hiver pour rester productif.",
    sowingTechnique: "Plantation de plants ou drageons",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "50 × 200 cm (en haie)",
    watering: "Régulier en fructification",
    soil: "Frais, humifère, légèrement acide",
    yieldEstimate: "1 à 2 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=plant+framboisier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte en juin-juillet",
      'autumn': "Récolte des remontants en septembre-octobre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Cassissier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'cassissier',
    name: 'Cassissier',
    emoji: '🫐',
    category: VegetableCategory.fruits,
    description:
        "Arbuste fruitier à baies noires acidulées, riches en vitamine C. Idéal pour confitures, gelées et liqueurs (la fameuse crème de cassis).",
    note: "Tailler en hiver pour renouveler les rameaux productifs.",
    sowingTechnique: "Plantation de plant ou bouturage en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "150 × 200 cm",
    watering: "Régulier en fructification",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "2 à 4 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=plant+cassissier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte en juillet",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Groseillier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'groseillier',
    name: 'Groseillier',
    emoji: '🫐',
    category: VegetableCategory.fruits,
    description:
        "Arbuste à grappes de baies rouges ou blanches, acidulées et juteuses. Parfait en gelée ou pour les desserts d'été.",
    note: "Très rustique, supporte les climats froids et la mi-ombre.",
    sowingTechnique: "Plantation de plant ou bouturage en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "120 × 150 cm",
    watering: "Régulier en fructification",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "2 à 4 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=plant+groseillier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte en juin-juillet",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Mûrier sans épines
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'murier',
    name: 'Mûrier sans épines',
    emoji: '🫐',
    category: VegetableCategory.fruits,
    description:
        "Ronce cultivée aux longs rameaux sans épines, productive et gourmande. Donne de grosses mûres juteuses, bien meilleures que les mûres sauvages.",
    note: "Palisser sur un fil de fer pour faciliter la récolte.",
    sowingTechnique: "Plantation de plant en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil",
    spacing: "200 × 250 cm",
    watering: "Régulier en fructification",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "5 à 10 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=murier+sans+epines+plant&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte de juillet à septembre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Myrtillier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'myrtillier',
    name: 'Myrtillier',
    emoji: '🫐',
    category: VegetableCategory.fruits,
    description:
        "Petit arbuste à baies bleues sucrées, riches en antioxydants. Exige un sol acide (terre de bruyère) — culture en pot recommandée en sol calcaire.",
    note: "Sol acide indispensable (pH 4,5 à 5,5).",
    sowingTechnique: "Plantation de plant à l'automne ou au printemps",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "100 × 150 cm",
    watering: "Régulier à l'eau de pluie (eau calcaire à éviter)",
    soil: "Acide (terre de bruyère), drainé",
    yieldEstimate: "1 à 3 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=plant+myrtillier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte de juillet à septembre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Rhubarbe
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'rhubarbe',
    name: 'Rhubarbe',
    emoji: '🌿',
    category: VegetableCategory.stems,
    description:
        "Plante vivace à grosses tiges acidulées, base des tartes et compotes printanières. Les feuilles sont toxiques, ne consommer que les pétioles.",
    note: "Vivace pour 10 ans — choisir un coin définitif riche en compost.",
    sowingTechnique: "Plantation de griffe ou division de touffe",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "100 × 120 cm",
    watering: "Abondant en croissance",
    soil: "Riche, frais, profond",
    yieldEstimate: "3 à 5 kg/pied",
    amazonUrl: "https://www.amazon.fr/s?k=griffe+rhubarbe&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte d'avril à juin",
      'summer': "Récolte de juillet (plant établi)",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pleurote (kit)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pleurote',
    name: 'Pleurote (kit)',
    emoji: '🍄',
    category: VegetableCategory.flowers,
    description:
        "Champignon en éventail à chapeau gris ou jaune, facile à cultiver sur kit (paille ou bûche inoculée). Rendement rapide en quelques semaines.",
    note: "Maintenir l'humidité — vaporiser deux fois par jour.",
    sowingTechnique: "Kit de mycélium sur paille ou bûche inoculée",
    sowingDepth: "—",
    germinationTemp: "15 à 22 °C",
    germinationDays: "14 à 21 jours (apparition des primordia)",
    exposure: "Lumière indirecte, lieu humide",
    spacing: "—",
    watering: "Vaporisation 2× par jour",
    soil: "Substrat fourni dans le kit",
    yieldEstimate: "1 à 2 kg sur 2 mois",
    amazonUrl: "https://www.amazon.fr/s?k=kit+culture+pleurote&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "21 à 35 jours",
      'autumn': "21 à 35 jours",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Shiitaké (kit)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'shiitake',
    name: 'Shiitaké (kit)',
    emoji: '🍄',
    category: VegetableCategory.flowers,
    description:
        "Champignon japonais à chapeau brun et chair ferme, classique de la cuisine asiatique. Cultivable sur bûche de chêne inoculée, productif sur 5 à 6 ans.",
    note: "Bûche placée à l'ombre dehors, à arroser en été sec.",
    sowingTechnique: "Bûche de chêne inoculée au mycélium",
    sowingDepth: "—",
    germinationTemp: "15 à 25 °C",
    germinationDays: "180 à 360 jours (1ère récolte)",
    exposure: "Ombre, à l'extérieur",
    spacing: "—",
    watering: "Tremper la bûche par périodes sèches",
    soil: "Bûche fournie",
    yieldEstimate: "1 à 2 kg/an sur 5 ans",
    amazonUrl: "https://www.amazon.fr/s?k=kit+shiitake+buche&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Récolte d'avril à juin",
      'autumn': "Récolte de septembre à novembre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Champignon de Paris (kit)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'champignon_paris',
    name: 'Champignon de Paris (kit)',
    emoji: '🍄',
    category: VegetableCategory.flowers,
    description:
        "Champignon classique blanc ou brun (rosé), cultivable en cave ou cellier sur kit prêt à l'emploi. Plusieurs vagues de récolte sur 1 à 2 mois.",
    note: "Idéal en cave fraîche (12-18 °C), à l'abri de la lumière directe.",
    sowingTechnique: "Kit de mycélium sur compost",
    sowingDepth: "—",
    germinationTemp: "12 à 18 °C",
    germinationDays: "14 à 21 jours",
    exposure: "Pénombre, lieu frais",
    spacing: "—",
    watering: "Vaporisation légère",
    soil: "Compost fourni dans le kit",
    yieldEstimate: "1 à 2 kg sur 2 mois",
    amazonUrl: "https://www.amazon.fr/s?k=kit+culture+champignon+paris&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "21 à 35 jours",
      'autumn': "21 à 35 jours",
      'winter': "Culture toute l'année en cave",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pommier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pommier',
    name: 'Pommier',
    emoji: '🍎',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier roi du verger français, des centaines de variétés (Reinette, Golden, Gala, Chanteclerc...). Vit 50 ans et plus.",
    note: "La plupart des variétés ont besoin d'un pollinisateur — planter à plusieurs.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "300 × 400 cm (haute tige)",
    watering: "Régulier les 2 premières années",
    soil: "Profond, frais, drainé",
    yieldEstimate: "20 à 100 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+pommier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Variétés précoces de juillet à août",
      'autumn': "Variétés de saison de septembre à novembre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Poirier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'poirier',
    name: 'Poirier',
    emoji: '🍐',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier élégant aux poires juteuses et parfumées (Williams, Conférence, Comice...). Plus exigeant que le pommier en chaleur.",
    note: "Préférer les variétés autofertiles ou planter à plusieurs.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil, abrité du vent",
    spacing: "300 × 400 cm",
    watering: "Régulier les 2 premières années",
    soil: "Profond, frais, drainé, légèrement acide",
    yieldEstimate: "30 à 80 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+poirier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Variétés précoces en août",
      'autumn': "Variétés de saison de septembre à octobre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Prunier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'prunier',
    name: 'Prunier',
    emoji: '🍑',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier généreux à l'origine de nombreuses variétés (Reine-Claude, Mirabelle, Quetsche). Productif et facile, peu exigeant.",
    note: "Récolter à pleine maturité — les prunes ne mûrissent pas après cueillette.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "300 × 400 cm",
    watering: "Régulier les 2 premières années",
    soil: "Frais, profond, drainé",
    yieldEstimate: "20 à 60 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+prunier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte de juillet à septembre selon la variété",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Cerisier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'cerisier',
    name: 'Cerisier',
    emoji: '🍒',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier emblématique du printemps, sublime en floraison rose. Production rapide (3-4 ans) et abondante de cerises sucrées (bigarreau) ou acidulées (griotte).",
    note: "Filets anti-oiseaux indispensables à la maturité — ils adorent les cerises.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "400 × 500 cm",
    watering: "Régulier les 2 premières années",
    soil: "Profond, drainé, calcaire toléré",
    yieldEstimate: "20 à 40 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+cerisier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte en juin-juillet",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Abricotier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'abricotier',
    name: 'Abricotier',
    emoji: '🍑',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier méridional aux fruits jaune-orangé sucrés. Floraison précoce sensible aux gelées tardives — préférer un emplacement abrité.",
    note: "Floraison fragile en mars — protéger des gelées tardives.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil, abrité du vent",
    spacing: "400 × 500 cm",
    watering: "Régulier les 2 premières années",
    soil: "Profond, drainé, calcaire toléré",
    yieldEstimate: "30 à 80 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+abricotier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte en juillet",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pêcher
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pecher',
    name: 'Pêcher',
    emoji: '🍑',
    category: VegetableCategory.fruits,
    description:
        "Arbre fruitier aux fruits parfumés (pêche, nectarine, brugnon). Sensible à la cloque du pêcher — traiter à la bouillie bordelaise en hiver.",
    note: "Production rapide (2-3 ans) — durée de vie limitée à 15-20 ans.",
    sowingTechnique: "Plantation de scion ou jeune arbre en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil, abrité du vent",
    spacing: "300 × 400 cm",
    watering: "Régulier les 2 premières années",
    soil: "Frais, profond, drainé",
    yieldEstimate: "20 à 50 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+pecher+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte de juillet à août",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Figuier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'figuier',
    name: 'Figuier',
    emoji: '🍇',
    category: VegetableCategory.fruits,
    description:
        "Arbre méditerranéen au feuillage caractéristique et aux fruits sucrés. Variétés bifères (deux récoltes par an) très productives.",
    note: "Très peu exigeant — supporte la sécheresse et les sols pauvres.",
    sowingTechnique: "Plantation de plant ou bouturage en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "400 × 500 cm",
    watering: "Faible une fois installé",
    soil: "Tout type, drainé",
    yieldEstimate: "20 à 50 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+figuier+arbre+fruitier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Figues fleurs en juin-juillet",
      'autumn': "Récolte principale en août-octobre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Noisetier
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'noisetier',
    name: 'Noisetier',
    emoji: '🌰',
    category: VegetableCategory.fruits,
    description:
        "Arbuste rustique aux noisettes croquantes, très facile à cultiver. Pollinisation croisée — planter au moins deux variétés différentes.",
    note: "Récolter dès que les noisettes tombent au sol naturellement.",
    sowingTechnique: "Plantation de plant en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Soleil ou mi-ombre",
    spacing: "400 × 500 cm",
    watering: "Régulier les 2 premières années",
    soil: "Tout type, drainé, neutre à calcaire",
    yieldEstimate: "5 à 15 kg/arbre adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+noisetier&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Récolte de fin août à septembre",
      'autumn': "Récolte de septembre à octobre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Vigne (raisin de table)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'vigne',
    name: 'Vigne (raisin de table)',
    emoji: '🍇',
    category: VegetableCategory.fruits,
    description:
        "Liane fruitière classique, raisins blancs ou noirs sucrés. Magnifique en pergola, productive et longue durée de vie (50 ans et plus).",
    note: "Tailler tous les hivers pour limiter la pousse et concentrer la sève.",
    sowingTechnique: "Plantation de plant en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil",
    spacing: "150 × 200 cm",
    watering: "Faible une fois installée",
    soil: "Drainé, calcaire toléré",
    yieldEstimate: "5 à 15 kg/pied adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+vigne+raisin+table&tag=kultiva-21",
    harvestTimeBySeason: {
      'summer': "Variétés précoces en août",
      'autumn': "Récolte principale de septembre à octobre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Kiwi (actinidia)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'kiwi',
    name: 'Kiwi (actinidia)',
    emoji: '🥝',
    category: VegetableCategory.fruits,
    description:
        "Liane vigoureuse aux fruits velus à chair verte ou jaune. La plupart des variétés ont besoin d'un pied mâle pour 5-6 pieds femelles.",
    note: "Réserver une grande pergola — pieds très vigoureux (jusqu'à 8 m).",
    sowingTechnique: "Plantation de plant en hiver",
    sowingDepth: "—",
    germinationTemp: "—",
    germinationDays: "—",
    exposure: "Plein soleil, abrité du vent",
    spacing: "400 × 500 cm",
    watering: "Régulier les 2 premières années",
    soil: "Frais, profond, légèrement acide",
    yieldEstimate: "30 à 80 kg/pied femelle adulte",
    amazonUrl: "https://www.amazon.fr/s?k=plant+kiwi+actinidia&tag=kultiva-21",
    harvestTimeBySeason: {
      'autumn': "Récolte d'octobre à novembre",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Capucine
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'capucine',
    name: 'Capucine',
    emoji: '🌸',
    category: VegetableCategory.flowers,
    description:
        "Fleur comestible orange ou jaune au goût piquant, proche du cresson. Attire les pucerons loin des autres légumes — idéale en bordure de potager.",
    note: "Fleurs et feuilles comestibles, à parsemer en salade.",
    sowingTechnique: "Semis direct en place après les gelées",
    sowingDepth: "1 à 2 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Soleil",
    spacing: "30 × 40 cm",
    watering: "Modéré",
    soil: "Pauvre, sec, drainé",
    yieldEstimate: "Floraison continue sur 4 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+capucine&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Floraison de juin à octobre",
      'summer': "Floraison continue",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Souci (calendula)
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'souci',
    name: 'Souci (calendula)',
    emoji: '🌼',
    category: VegetableCategory.flowers,
    description:
        "Fleur jaune-orangé comestible aux pétales ensoleillés. Vertus médicinales reconnues (calendula), excellente compagne du potager qui repousse les nématodes.",
    note: "Se ressème spontanément — un classique du jardin de grand-mère.",
    sowingTechnique: "Semis direct en place",
    sowingDepth: "0,5 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Soleil",
    spacing: "25 × 30 cm",
    watering: "Modéré",
    soil: "Tout type, drainé",
    yieldEstimate: "Floraison continue sur 5 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+souci+calendula&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Floraison de mai à novembre",
      'summer': "Floraison continue",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Bourrache
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'bourrache',
    name: 'Bourrache',
    emoji: '💙',
    category: VegetableCategory.flowers,
    description:
        "Fleur étoilée bleu vif au goût d'huître, très mellifère. Indispensable au verger — attire massivement les abeilles pour la pollinisation.",
    note: "Fleurs et jeunes feuilles comestibles. Se ressème toute seule.",
    sowingTechnique: "Semis direct en place",
    sowingDepth: "1 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "7 à 14 jours",
    exposure: "Soleil",
    spacing: "40 × 50 cm",
    watering: "Modéré",
    soil: "Tout type, drainé",
    yieldEstimate: "Floraison continue sur 4 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+bourrache&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Floraison de mai à octobre",
      'summer': "Floraison continue",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Pensée
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'pensee',
    name: 'Pensée',
    emoji: '🌸',
    category: VegetableCategory.flowers,
    description:
        "Petite fleur multicolore (violet, jaune, blanc) à l'aspect kawaii. Comestible en décoration de salades et desserts, fleurit même en hiver.",
    note: "Bisannuelle — semer en été pour fleurir au printemps suivant.",
    sowingTechnique: "Semis en pépinière puis repiquage",
    sowingDepth: "0,3 cm",
    germinationTemp: "15 à 20 °C",
    germinationDays: "10 à 21 jours",
    exposure: "Mi-ombre en été, soleil en hiver",
    spacing: "20 × 25 cm",
    watering: "Régulier",
    soil: "Frais, humifère, drainé",
    yieldEstimate: "Floraison continue sur 6 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+pensee+fleur&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Floraison de mars à juin",
      'autumn': "Floraison de septembre à novembre",
      'winter': "Floraison hivernale au sud",
    },
  ),

  // ──────────────────────────────────────────────────────────────────────
  // Œillet d'Inde
  // ──────────────────────────────────────────────────────────────────────
  Vegetable(
    id: 'oeillet_inde',
    name: "Œillet d'Inde",
    emoji: '🌼',
    category: VegetableCategory.flowers,
    description:
        "Fleur jaune ou orange au feuillage très parfumé. Repousse les nématodes du sol et les insectes nuisibles — alliée précieuse au potager, surtout des tomates.",
    note: "À planter au pied des tomates et aubergines.",
    sowingTechnique: "Semis en godet ou en place",
    sowingDepth: "0,3 cm",
    germinationTemp: "18 à 22 °C",
    germinationDays: "5 à 10 jours",
    exposure: "Plein soleil",
    spacing: "20 × 25 cm",
    watering: "Modéré",
    soil: "Tout type, drainé",
    yieldEstimate: "Floraison continue sur 4 mois",
    amazonUrl: "https://www.amazon.fr/s?k=graines+oeillet+inde+tagete&tag=kultiva-21",
    harvestTimeBySeason: {
      'spring': "Floraison de juin à octobre",
      'summer': "Floraison continue",
    },
  ),

  // ── Accessoires jardinage ──
  Vegetable(
    id: 'acc_secateur',
    name: 'Sécateur',
    emoji: '✂️',
    category: VegetableCategory.accessories,
    note: 'Indispensable pour tailler et récolter',
    description: 'Outil de base pour couper les branches, récolter les légumes et entretenir vos plants. Choisissez un modèle ergonomique avec lame en acier.',
    amazonUrl: 'https://www.amazon.fr/s?k=sécateur+jardinage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/secateur.png',
  ),
  Vegetable(
    id: 'acc_arrosoir',
    name: 'Arrosoir',
    emoji: '🚿',
    category: VegetableCategory.accessories,
    note: 'Pour un arrosage doux et précis',
    description: 'Arrosoir avec pomme fine pour un arrosage en pluie douce, idéal pour les semis et jeunes plants. Capacité recommandée : 5 à 10 litres.',
    amazonUrl: 'https://www.amazon.fr/s?k=arrosoir+jardinage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/arrosoir.png',
  ),
  Vegetable(
    id: 'acc_terreau',
    name: 'Terreau bio',
    emoji: '🪴',
    category: VegetableCategory.accessories,
    note: 'La base pour des plants en bonne santé',
    description: 'Terreau universel biologique enrichi en compost. Idéal pour les semis, le rempotage et le potager en bacs.',
    amazonUrl: 'https://www.amazon.fr/s?k=terreau+bio+potager&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/terreau.png',
  ),
  Vegetable(
    id: 'acc_engrais',
    name: 'Engrais bio',
    emoji: '🧪',
    category: VegetableCategory.accessories,
    note: 'Nourrir le sol naturellement',
    description: 'Engrais organique pour potager : fumier composté, purin d\'ortie ou granulés bio. Stimule la croissance sans produits chimiques.',
    amazonUrl: 'https://www.amazon.fr/s?k=engrais+bio+potager&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/engrais.png',
  ),
  Vegetable(
    id: 'acc_bac',
    name: 'Bac potager',
    emoji: '📦',
    category: VegetableCategory.accessories,
    note: 'Potager surélevé pour balcon ou terrasse',
    description: 'Bac en bois ou plastique recyclé pour cultiver sur un balcon, une terrasse ou un petit jardin. Hauteur idéale : 40 à 80 cm.',
    amazonUrl: 'https://www.amazon.fr/s?k=bac+potager+surélevé&tag=kultiva-21',
    accessorySub: AccessorySubCategory.pots,
    imageAsset: 'assets/images/accessories/bac.png',
  ),
  Vegetable(
    id: 'acc_tuteur',
    name: 'Tuteurs',
    emoji: '🥢',
    category: VegetableCategory.accessories,
    note: 'Soutenir tomates, haricots, pois...',
    description: 'Tuteurs en bambou, métal ou spirale pour guider la croissance des plants grimpants. Indispensable pour tomates et haricots.',
    amazonUrl: 'https://www.amazon.fr/s?k=tuteur+potager+bambou&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/tuteur.png',
  ),
  Vegetable(
    id: 'acc_graines',
    name: 'Kit semences bio',
    emoji: '🌱',
    category: VegetableCategory.accessories,
    note: 'Coffret de graines variées pour démarrer',
    description: 'Assortiment de semences bio : tomates, carottes, salades, radis, basilic... Parfait pour débuter son potager.',
    amazonUrl: 'https://www.amazon.fr/s?k=kit+graines+potager+bio&tag=kultiva-21',
    accessorySub: AccessorySubCategory.seeds,
    imageAsset: 'assets/images/accessories/graines.png',
  ),
  Vegetable(
    id: 'acc_gants',
    name: 'Gants de jardinage',
    emoji: '🧤',
    category: VegetableCategory.accessories,
    note: 'Protéger ses mains au jardin',
    description: 'Gants résistants et confortables pour le jardinage. Choisir un modèle anti-épines avec bonne préhension.',
    amazonUrl: 'https://www.amazon.fr/s?k=gants+jardinage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/gants.png',
  ),
  // ── Structures & Aménagement ──
  Vegetable(
    id: 'acc_serre_tunnel',
    name: 'Mini-serre tunnel',
    emoji: '⛺',
    category: VegetableCategory.accessories,
    note: 'Prolonger la saison de culture',
    description: "Petit tunnel en plastique avec armature métallique : protège les jeunes plants du froid au printemps et permet de cultiver tomates, poivrons même dans le nord.",
    amazonUrl: 'https://www.amazon.fr/s?k=serre+jardin+tunnel&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/serre_tunnel.png',
  ),
  Vegetable(
    id: 'acc_chassis',
    name: 'Châssis de culture',
    emoji: '🪟',
    category: VegetableCategory.accessories,
    note: "Mini-serre pour semis d'hiver",
    description: "Couche froide vitrée, idéale pour les semis précoces de février à avril. Permet de gagner 4-6 semaines sur le calendrier.",
    amazonUrl: 'https://www.amazon.fr/s?k=chassis+culture+jardinage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/chassis.png',
  ),
  Vegetable(
    id: 'acc_carre_potager',
    name: 'Carré potager bois',
    emoji: '🟫',
    category: VegetableCategory.accessories,
    note: "L'incontournable pour débuter",
    description: "Cadre en bois posé au sol, divisé en cases de 30×30 cm. Méthode simple, esthétique et productive — parfait pour un petit jardin.",
    amazonUrl: 'https://www.amazon.fr/s?k=carre+potager+bois&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/carre_potager.png',
  ),
  Vegetable(
    id: 'acc_table_culture',
    name: 'Table de culture',
    emoji: '🪑',
    category: VegetableCategory.accessories,
    note: 'Jardiner debout, sans mal au dos',
    description: "Bac surélevé sur pieds (60-90 cm de haut). Idéal balcon, terrasse ou personnes à mobilité réduite. Profondeur min 30 cm pour les légumes.",
    amazonUrl: 'https://www.amazon.fr/s?k=table+culture+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/table_culture.png',
  ),
  Vegetable(
    id: 'acc_cloche',
    name: 'Cloche horticole',
    emoji: '🔔',
    category: VegetableCategory.accessories,
    note: 'Protéger un plant individuellement',
    description: "Cloche transparente à poser sur un plant fragile : forçage de printemps, protection contre le gel ou les limaces. Réutilisable saison après saison.",
    amazonUrl: 'https://www.amazon.fr/s?k=cloche+horticole+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/cloche.png',
  ),
  // ── Arrosage ──
  Vegetable(
    id: 'acc_goutte_a_goutte',
    name: 'Kit goutte à goutte',
    emoji: '💧',
    category: VegetableCategory.accessories,
    note: "Économise jusqu'à 50% d'eau",
    description: "Système d'arrosage automatique avec tuyaux et goutteurs. Délivre l'eau directement au pied des plants, idéal en été et pour partir en vacances.",
    amazonUrl: 'https://www.amazon.fr/s?k=kit+goutte+a+goutte+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.watering,
    imageAsset: 'assets/images/accessories/goutte_a_goutte.png',
  ),
  Vegetable(
    id: 'acc_programmateur',
    name: "Programmateur d'arrosage",
    emoji: '⏱️',
    category: VegetableCategory.accessories,
    note: 'Arroser même en ton absence',
    description: "Se branche sur le robinet et programme l'arrosage automatiquement (durée + créneau). À combiner avec un kit goutte à goutte ou un tuyau perforé.",
    amazonUrl: 'https://www.amazon.fr/s?k=programmateur+arrosage+robinet&tag=kultiva-21',
    accessorySub: AccessorySubCategory.watering,
    imageAsset: 'assets/images/accessories/programmateur.png',
  ),
  Vegetable(
    id: 'acc_recuperateur',
    name: "Récupérateur d'eau",
    emoji: '🛢️',
    category: VegetableCategory.accessories,
    note: "L'eau de pluie, gratuite et idéale",
    description: "Cuve 200-500 L à raccorder sur une descente de gouttière. L'eau de pluie est sans calcaire, à température ambiante : parfaite pour le potager.",
    amazonUrl: 'https://www.amazon.fr/s?k=recuperateur+eau+pluie+300L&tag=kultiva-21',
    accessorySub: AccessorySubCategory.watering,
    imageAsset: 'assets/images/accessories/recuperateur.png',
  ),
  Vegetable(
    id: 'acc_oyas',
    name: 'Oyas en terre cuite',
    emoji: '🏺',
    category: VegetableCategory.accessories,
    note: 'Arrosage ancestral et économe',
    description: "Pot en terre cuite poreuse à enterrer entre les plants : se remplit d'eau et la diffuse lentement. Réduit l'arrosage à 1 fois par semaine.",
    amazonUrl: 'https://www.amazon.fr/s?k=oyas+terre+cuite+arrosage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.watering,
    imageAsset: 'assets/images/accessories/oyas.png',
  ),
  Vegetable(
    id: 'acc_tuyau_microporeux',
    name: 'Tuyau micro-poreux',
    emoji: '〰️',
    category: VegetableCategory.accessories,
    note: 'Alternative simple au goutte à goutte',
    description: "Tuyau qui suinte sur toute sa longueur et arrose les plants en ligne. Facile à installer, idéal pour les rangs de salades, carottes, fraisiers.",
    amazonUrl: 'https://www.amazon.fr/s?k=tuyau+microporeux+arrosage&tag=kultiva-21',
    accessorySub: AccessorySubCategory.watering,
    imageAsset: 'assets/images/accessories/tuyau_microporeux.png',
  ),
  // ── Protection des cultures ──
  Vegetable(
    id: 'acc_filet_insectes',
    name: 'Filet anti-insectes',
    emoji: '🪤',
    category: VegetableCategory.accessories,
    note: 'Stop pucerons, mouches, papillons',
    description: "Voile à fines mailles à poser sur les cultures. Empêche piéride du chou, mouche de la carotte, altises et pucerons sans aucun traitement.",
    amazonUrl: 'https://www.amazon.fr/s?k=filet+anti+insectes+potager&tag=kultiva-21',
    accessorySub: AccessorySubCategory.protection,
    imageAsset: 'assets/images/accessories/filet_insectes.png',
  ),
  Vegetable(
    id: 'acc_voile_hivernage',
    name: "Voile d'hivernage",
    emoji: '❄️',
    category: VegetableCategory.accessories,
    note: 'Protège du gel jusqu\'à -5°C',
    description: "Voile blanc épais (P30) à poser sur les plants sensibles en hiver. Protège artichauts, poireaux, choux, oliviers, agrumes en pots.",
    amazonUrl: 'https://www.amazon.fr/s?k=voile+hivernage+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.protection,
    imageAsset: 'assets/images/accessories/voile_hivernage.png',
  ),
  Vegetable(
    id: 'acc_voile_forcage',
    name: 'Voile de forçage',
    emoji: '🌬️',
    category: VegetableCategory.accessories,
    note: 'Gagner 2-3 semaines au printemps',
    description: "Voile léger (P17) à poser au printemps pour réchauffer le sol et démarrer plus tôt salades, radis, carottes. Laisse passer pluie et lumière.",
    amazonUrl: 'https://www.amazon.fr/s?k=voile+forcage+printemps&tag=kultiva-21',
    accessorySub: AccessorySubCategory.protection,
    imageAsset: 'assets/images/accessories/voile_forcage.png',
  ),
  Vegetable(
    id: 'acc_filet_oiseaux',
    name: 'Filet anti-oiseaux',
    emoji: '🐦',
    category: VegetableCategory.accessories,
    note: 'Sauve tes fraises et tes cerises',
    description: "Filet à mailles larges à tendre au-dessus des fraisiers, des arbres fruitiers ou des semis. Empêche merles et étourneaux de tout picorer.",
    amazonUrl: 'https://www.amazon.fr/s?k=filet+anti+oiseaux+potager&tag=kultiva-21',
    accessorySub: AccessorySubCategory.protection,
    imageAsset: 'assets/images/accessories/filet_oiseaux.png',
  ),
  Vegetable(
    id: 'acc_anti_limaces',
    name: 'Anti-limaces bio (Ferramol)',
    emoji: '🐌',
    category: VegetableCategory.accessories,
    note: "Le seul anti-limace bio efficace",
    description: "Granulés à base de phosphate de fer, autorisés en agriculture biologique. Non toxiques pour hérissons, oiseaux et animaux domestiques.",
    amazonUrl: 'https://www.amazon.fr/s?k=ferramol+anti+limaces+bio&tag=kultiva-21',
    accessorySub: AccessorySubCategory.protection,
    imageAsset: 'assets/images/accessories/anti_limaces.png',
  ),
  // ── Tuteurage & support (sous catégorie structures) ──
  Vegetable(
    id: 'acc_treillis_tomate',
    name: 'Treillis tomates',
    emoji: '▦',
    category: VegetableCategory.accessories,
    note: 'Pour conduire les tomates indéterminées',
    description: "Grille rigide à planter derrière les tomates. Permet de palisser les branches au fur et à mesure, plus solide que les tuteurs simples.",
    amazonUrl: 'https://www.amazon.fr/s?k=treillis+tomates+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/treillis_tomate.png',
  ),
  Vegetable(
    id: 'acc_arche',
    name: 'Arche de jardin',
    emoji: '🌉',
    category: VegetableCategory.accessories,
    note: 'Pour courges et plantes grimpantes',
    description: "Arche métallique 2 m de haut : parfaite pour faire grimper haricots à rames, courges, concombres, kiwis. Décoratif et productif.",
    amazonUrl: 'https://www.amazon.fr/s?k=arche+jardin+plantes+grimpantes&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/arche.png',
  ),
  Vegetable(
    id: 'acc_tuteurs_spirales',
    name: 'Tuteurs spirales',
    emoji: '🌀',
    category: VegetableCategory.accessories,
    note: 'Spécial tomates, pas besoin de lier',
    description: "Tuteur en métal en forme de spirale : la tige de tomate s'enroule naturellement dedans. Pas besoin de ficelle ni d'attaches, gain de temps énorme.",
    amazonUrl: 'https://www.amazon.fr/s?k=tuteurs+spirale+tomate&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/tuteurs_spirales.png',
  ),
  Vegetable(
    id: 'acc_rames_bambou',
    name: 'Rames bambou',
    emoji: '🎋',
    category: VegetableCategory.accessories,
    note: 'Pour haricots et pois grimpants',
    description: "Bambous longs (1,80 à 2,40 m) à planter en tipi ou en ligne. Naturels, robustes et réutilisables plusieurs années.",
    amazonUrl: 'https://www.amazon.fr/s?k=rames+bambou+haricot&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/rames_bambou.png',
  ),
  // ── Sol & compost ──
  Vegetable(
    id: 'acc_composteur',
    name: 'Composteur de jardin',
    emoji: '♻️',
    category: VegetableCategory.accessories,
    note: 'Recycle tes déchets en or noir',
    description: "Bac de 300-600 L pour transformer épluchures et déchets verts en compost. Volume conseillé : 1 m³ pour un jardin moyen.",
    amazonUrl: 'https://www.amazon.fr/s?k=composteur+jardin+400L&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/composteur.png',
  ),
  Vegetable(
    id: 'acc_lombricomposteur',
    name: 'Lombricomposteur',
    emoji: '🪱',
    category: VegetableCategory.accessories,
    note: 'Compostage en appartement',
    description: "Bac compact pour appartement : les vers décomposent les déchets de cuisine et produisent un engrais liquide ultra-puissant. Sans odeur.",
    amazonUrl: 'https://www.amazon.fr/s?k=lombricomposteur+appartement&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/lombricomposteur.png',
  ),
  Vegetable(
    id: 'acc_activateur_compost',
    name: 'Activateur de compost',
    emoji: '⚡',
    category: VegetableCategory.accessories,
    note: 'Accélère la décomposition',
    description: "Mélange de micro-organismes à saupoudrer sur le compost. Réduit le temps de maturation de 12 à 6 mois et limite les odeurs.",
    amazonUrl: 'https://www.amazon.fr/s?k=activateur+compost+bio&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/activateur_compost.png',
  ),
  Vegetable(
    id: 'acc_paillis_chanvre',
    name: 'Paillis de chanvre',
    emoji: '🌾',
    category: VegetableCategory.accessories,
    note: 'Garde l\'humidité, nourrit le sol',
    description: "Paillis 100% végétal à étaler en couche de 5-7 cm autour des plants. Garde le sol humide, freine les mauvaises herbes, se décompose en humus.",
    amazonUrl: 'https://www.amazon.fr/s?k=paillis+chanvre+potager&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/paillis_chanvre.png',
  ),
  Vegetable(
    id: 'acc_mulch_ecorces',
    name: 'Écorces de pin',
    emoji: '🪵',
    category: VegetableCategory.accessories,
    note: 'Paillis longue durée pour massifs',
    description: "Écorces de pin maritime, idéales pour les massifs et arbres fruitiers. Décoratif, dure 2-3 ans, acidifie légèrement le sol (parfait pour fraisiers).",
    amazonUrl: 'https://www.amazon.fr/s?k=mulch+ecorces+pin+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.soil,
    imageAsset: 'assets/images/accessories/mulch_ecorces.png',
  ),
  Vegetable(
    id: 'acc_grelinette',
    name: 'Grelinette',
    emoji: '🍴',
    category: VegetableCategory.accessories,
    note: 'Aérer le sol sans le retourner',
    description: "Fourche à 4-5 dents : ameublit la terre en profondeur sans détruire la vie du sol. Indispensable pour qui pratique le \"sol vivant\".",
    amazonUrl: 'https://www.amazon.fr/s?k=grelinette+fourche+beche&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/grelinette.png',
  ),
  // ── Petits outils ──
  Vegetable(
    id: 'acc_binette',
    name: 'Binette / serfouette',
    emoji: '🪓',
    category: VegetableCategory.accessories,
    note: '"Un binage vaut deux arrosages"',
    description: "Petit outil à main pour gratter la surface du sol et casser la croûte. Permet d'aérer la terre et d'arracher les jeunes herbes.",
    amazonUrl: 'https://www.amazon.fr/s?k=binette+serfouette+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/binette.png',
  ),
  Vegetable(
    id: 'acc_plantoir',
    name: 'Plantoir à bulbes',
    emoji: '🥄',
    category: VegetableCategory.accessories,
    note: 'Pour planter ail, oignons, tulipes',
    description: "Outil cylindrique qui creuse un trou parfait à la bonne profondeur. Idéal pour planter ail, échalotes, tulipes, jacinthes en quantité.",
    amazonUrl: 'https://www.amazon.fr/s?k=plantoir+bulbes+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/plantoir.png',
  ),
  Vegetable(
    id: 'acc_transplantoir',
    name: 'Transplantoir',
    emoji: '🥄',
    category: VegetableCategory.accessories,
    note: 'Pour repiquer les jeunes plants',
    description: "Petite pelle étroite pour repiquer les semis sans abîmer les racines. Indispensable au printemps pour la mise en place du potager.",
    amazonUrl: 'https://www.amazon.fr/s?k=transplantoir+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/transplantoir.png',
  ),
  Vegetable(
    id: 'acc_etiquettes',
    name: 'Étiquettes plantes',
    emoji: '🏷️',
    category: VegetableCategory.accessories,
    note: 'Garder la trace de tes variétés',
    description: "Lot d'étiquettes en ardoise ou plastique avec marqueur. Indispensable pour ne pas oublier ce que tu as semé et où.",
    amazonUrl: 'https://www.amazon.fr/s?k=etiquettes+plantes+ardoise&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/etiquettes.png',
  ),
  Vegetable(
    id: 'acc_panier_recolte',
    name: 'Panier de récolte',
    emoji: '🧺',
    category: VegetableCategory.accessories,
    note: 'Pour transporter les légumes',
    description: "Panier en osier ou plastique aéré pour récolter et transporter tes légumes du jardin à la cuisine sans les abîmer.",
    amazonUrl: 'https://www.amazon.fr/s?k=panier+recolte+osier+jardin&tag=kultiva-21',
    accessorySub: AccessorySubCategory.tools,
    imageAsset: 'assets/images/accessories/panier_recolte.png',
  ),
  Vegetable(
    id: 'acc_hydroponie',
    name: 'Système hydroponie',
    emoji: '💧',
    category: VegetableCategory.accessories,
    note: 'Cultiver sans terre, en eau nutritive',
    description: "Kit hydroponie pour faire pousser légumes et aromates sans terre, directement dans une solution nutritive. Idéal pour balcon ou intérieur. Économie d'eau jusqu'à 90 %, croissance rapide et zéro maladies du sol.",
    amazonUrl: 'https://www.amazon.fr/s?k=hydroponie+kit&tag=kultiva-21',
    accessorySub: AccessorySubCategory.structures,
    imageAsset: 'assets/images/accessories/hydroponie.png',
  ),
];
