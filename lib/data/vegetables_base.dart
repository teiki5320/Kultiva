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
];
