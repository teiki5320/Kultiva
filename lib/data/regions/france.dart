import '../../models/region_data.dart';

/// Données de semis et récolte pour la France métropolitaine.
///
/// Les mois sont indexés de 1 (janvier) à 12 (décembre).
const List<RegionData> franceData = <RegionData>[
  RegionData(
    regionId: 'france',
    vegetableId: 'tomate',
    sowingMonths: [2, 3, 4],
    harvestMonths: [7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'carotte',
    sowingMonths: [3, 4, 5, 6, 7],
    harvestMonths: [6, 7, 8, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'courgette',
    sowingMonths: [4, 5, 6],
    harvestMonths: [7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'laitue',
    sowingMonths: [3, 4, 5, 6, 7, 8, 9],
    harvestMonths: [5, 6, 7, 8, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'haricot',
    sowingMonths: [5, 6, 7],
    harvestMonths: [7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'aubergine',
    sowingMonths: [2, 3, 4],
    harvestMonths: [7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'poivron',
    sowingMonths: [2, 3, 4],
    harvestMonths: [7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'epinard',
    sowingMonths: [3, 4, 8, 9],
    harvestMonths: [5, 6, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'oignon',
    sowingMonths: [2, 3, 9, 10],
    harvestMonths: [6, 7, 8],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'basilic',
    sowingMonths: [3, 4, 5, 6],
    harvestMonths: [6, 7, 8, 9],
  ),
  // ── Nouveaux (11–20) ──────────────────────────────────────────────────
  RegionData(
    regionId: 'france',
    vegetableId: 'concombre',
    sowingMonths: [4, 5, 6],
    harvestMonths: [7, 8, 9],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'piment',
    sowingMonths: [2, 3, 4],
    harvestMonths: [7, 8, 9, 10],
    regionalNote:
        "Privilégier la culture sous serre ou tunnel en dehors du sud de la France.",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'ail',
    sowingMonths: [10, 11, 2, 3],
    harvestMonths: [6, 7, 8],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'pomme_de_terre',
    sowingMonths: [3, 4, 5],
    harvestMonths: [6, 7, 8, 9],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'radis',
    sowingMonths: [3, 4, 5, 6, 7, 8, 9],
    harvestMonths: [4, 5, 6, 7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'chou_pomme',
    sowingMonths: [3, 4, 5, 6],
    harvestMonths: [9, 10, 11, 12, 1, 2],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'petit_pois',
    sowingMonths: [2, 3, 4, 10],
    harvestMonths: [5, 6, 7],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'poireau',
    sowingMonths: [2, 3, 4, 5],
    harvestMonths: [9, 10, 11, 12, 1, 2, 3],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'patate_douce',
    sowingMonths: [4, 5],
    harvestMonths: [9, 10],
    regionalNote:
        "Culture possible dans le sud de la France ou sous serre chauffée. Demande au moins 4 mois de chaleur continue.",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'gombo',
    sowingMonths: [4, 5],
    harvestMonths: [8, 9],
    regionalNote:
        "Très exigeant en chaleur — réservé au sud méditerranéen ou à la culture sous serre chauffée (min. 20 °C).",
  ),
  // ── Légumes 21–40 ──────────────────────────────────────────────────────
  RegionData(
    regionId: 'france',
    vegetableId: 'echalote',
    sowingMonths: [10, 11, 2, 3],
    harvestMonths: [6, 7, 8],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'chou_fleur',
    sowingMonths: [3, 4, 5, 6],
    harvestMonths: [9, 10, 11, 12],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'brocoli',
    sowingMonths: [3, 4, 5, 6],
    harvestMonths: [8, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'courge_butternut',
    sowingMonths: [4, 5],
    harvestMonths: [9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'potiron',
    sowingMonths: [4, 5],
    harvestMonths: [9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'melon',
    sowingMonths: [3, 4, 5],
    harvestMonths: [7, 8, 9],
    regionalNote:
        "Meilleure réussite dans le sud de la France. En climat plus frais, cultiver sous tunnel ou serre.",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'pasteque',
    sowingMonths: [4, 5],
    harvestMonths: [8, 9],
    regionalNote:
        "Culture réservée au sud méditerranéen ou sous serre chauffée dans le reste de la France.",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'fraise',
    sowingMonths: [3, 4, 8, 9],
    harvestMonths: [5, 6, 7, 8, 9],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'navet',
    sowingMonths: [3, 4, 7, 8, 9],
    harvestMonths: [5, 6, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'betterave',
    sowingMonths: [4, 5, 6],
    harvestMonths: [7, 8, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'mais',
    sowingMonths: [5, 6],
    harvestMonths: [8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'persil',
    sowingMonths: [3, 4, 5, 6, 7],
    harvestMonths: [5, 6, 7, 8, 9, 10, 11],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'coriandre',
    sowingMonths: [4, 5, 8, 9],
    harvestMonths: [5, 6, 7, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'ciboulette',
    sowingMonths: [3, 4, 5],
    harvestMonths: [4, 5, 6, 7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'menthe',
    sowingMonths: [3, 4, 5],
    harvestMonths: [5, 6, 7, 8, 9, 10],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'thym',
    sowingMonths: [3, 4, 5],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'feve',
    sowingMonths: [2, 3, 10, 11],
    harvestMonths: [5, 6, 7],
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'igname',
    sowingMonths: [4, 5],
    harvestMonths: [10, 11],
    regionalNote:
        "Culture expérimentale en France — possible dans le sud ou sous serre chauffée. Cycle très long (8 mois minimum).",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'manioc',
    sowingMonths: [5],
    harvestMonths: [10, 11],
    regionalNote:
        "Non adapté au climat français hors DOM-TOM. Possible en serre chauffée à titre expérimental uniquement.",
  ),
  RegionData(
    regionId: 'france',
    vegetableId: 'niebe',
    sowingMonths: [5, 6],
    harvestMonths: [8, 9, 10],
    regionalNote:
        "Peu cultivé en France métropolitaine. Possible dans le sud — même culture que le haricot, mais plus tolérant à la chaleur.",
  ),
  // ── Légumes 41–60 ──────────────────────────────────────────────────────
  RegionData(regionId: 'france', vegetableId: 'artichaut', sowingMonths: [3, 4, 5], harvestMonths: [6, 7, 8, 9]),
  RegionData(regionId: 'france', vegetableId: 'blette', sowingMonths: [4, 5, 6, 7], harvestMonths: [7, 8, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'celeri', sowingMonths: [2, 3, 4], harvestMonths: [8, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'mache', sowingMonths: [8, 9, 10], harvestMonths: [10, 11, 12, 1, 2, 3]),
  RegionData(regionId: 'france', vegetableId: 'roquette', sowingMonths: [3, 4, 5, 8, 9], harvestMonths: [5, 6, 7, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'chou_kale', sowingMonths: [4, 5, 6, 7], harvestMonths: [9, 10, 11, 12, 1, 2]),
  RegionData(
    regionId: 'france', vegetableId: 'arachide', sowingMonths: [5, 6], harvestMonths: [9, 10],
    regionalNote: "Culture expérimentale en France — possible dans le sud-ouest (Landes) en sol sableux chaud.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'bissap', sowingMonths: [4, 5], harvestMonths: [9, 10],
    regionalNote: "Annuelle tropicale — possible sous serre chauffée ou en pot rentré en hiver. Résultats aléatoires en plein air.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'sesame', sowingMonths: [5, 6], harvestMonths: [9, 10],
    regionalNote: "Culture rare en France — réservée au sud méditerranéen, sol chaud et sec.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'gingembre', sowingMonths: [3, 4], harvestMonths: [10, 11],
    regionalNote: "Possible en pot sous serre ou en intérieur lumineux. Cycle de 8 mois minimum.",
  ),
  RegionData(regionId: 'france', vegetableId: 'asperge', sowingMonths: [2, 3, 4], harvestMonths: [4, 5, 6]),
  RegionData(regionId: 'france', vegetableId: 'fenouil', sowingMonths: [5, 6, 7], harvestMonths: [8, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'endive', sowingMonths: [5, 6], harvestMonths: [11, 12, 1, 2, 3]),
  RegionData(regionId: 'france', vegetableId: 'chou_bruxelles', sowingMonths: [3, 4, 5], harvestMonths: [10, 11, 12, 1, 2]),
  RegionData(regionId: 'france', vegetableId: 'potimarron', sowingMonths: [4, 5], harvestMonths: [9, 10]),
  RegionData(regionId: 'france', vegetableId: 'oseille', sowingMonths: [3, 4, 5], harvestMonths: [4, 5, 6, 7, 8, 9, 10]),
  RegionData(
    regionId: 'france', vegetableId: 'taro', sowingMonths: [4, 5], harvestMonths: [10, 11],
    regionalNote: "Non adapté au climat français sauf DOM-TOM. Possible en pot sous serre chauffée.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'amarante', sowingMonths: [5, 6], harvestMonths: [8, 9, 10],
    regionalNote: "Pousse bien dans le sud de la France. Ailleurs, semer après les dernières gelées.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'sorgho', sowingMonths: [5, 6], harvestMonths: [9, 10],
    regionalNote: "Culture rare en France métropolitaine — possible dans le sud en sol chaud et sec.",
  ),

  // ── Nouveautés vague 1 ──
  RegionData(regionId: 'france', vegetableId: 'cornichon', sowingMonths: [4, 5, 6], harvestMonths: [7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'panais', sowingMonths: [3, 4, 5, 6], harvestMonths: [9, 10, 11, 12, 1, 2]),
  RegionData(regionId: 'france', vegetableId: 'rutabaga', sowingMonths: [5, 6, 7], harvestMonths: [10, 11, 12]),
  RegionData(regionId: 'france', vegetableId: 'topinambour', sowingMonths: [2, 3, 4], harvestMonths: [10, 11, 12, 1, 2]),
  RegionData(regionId: 'france', vegetableId: 'salsifis', sowingMonths: [4, 5, 6], harvestMonths: [10, 11, 12, 1, 2]),

  // ── Nouveautés vague 1 batch 2 ──
  RegionData(regionId: 'france', vegetableId: 'radis_noir', sowingMonths: [7, 8], harvestMonths: [10, 11, 12, 1]),
  RegionData(regionId: 'france', vegetableId: 'chou_rave', sowingMonths: [3, 4, 5, 6, 7, 8], harvestMonths: [5, 6, 7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'cresson', sowingMonths: [3, 4, 5, 8, 9], harvestMonths: [5, 6, 7, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'pak_choi', sowingMonths: [3, 4, 5, 7, 8, 9], harvestMonths: [5, 6, 7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'pourpier', sowingMonths: [5, 6, 7], harvestMonths: [6, 7, 8, 9]),

  // ── Nouveautés vague 1 batch 3 ──
  RegionData(regionId: 'france', vegetableId: 'chou_chinois', sowingMonths: [6, 7, 8], harvestMonths: [9, 10, 11]),
  RegionData(
    regionId: 'france', vegetableId: 'romarin', sowingMonths: [3, 4, 5], harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote: "Vivace persistante — récolte toute l'année après la première saison.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'sauge', sowingMonths: [3, 4, 5], harvestMonths: [4, 5, 6, 7, 8, 9, 10],
    regionalNote: "Vivace — récolte de la 2e année, toute la belle saison.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'origan', sowingMonths: [3, 4, 5], harvestMonths: [6, 7, 8, 9],
    regionalNote: "Vivace mellifère — récolter au moment de la floraison.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'estragon', sowingMonths: [3, 4, 5], harvestMonths: [5, 6, 7, 8, 9],
    regionalNote: "Plantation au printemps — récolte permanente l'année suivante.",
  ),

  // ── Nouveautés vague 1 batch 4 ──
  RegionData(regionId: 'france', vegetableId: 'sarriette', sowingMonths: [4, 5, 6], harvestMonths: [7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'aneth', sowingMonths: [4, 5, 6, 7, 8], harvestMonths: [6, 7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'cerfeuil', sowingMonths: [3, 4, 8, 9], harvestMonths: [5, 6, 10, 11]),
  RegionData(
    regionId: 'france', vegetableId: 'melisse', sowingMonths: [3, 4, 5], harvestMonths: [5, 6, 7, 8, 9, 10],
    regionalNote: "Vivace — récolte permanente la belle saison à partir de la 2e année.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'verveine', sowingMonths: [4, 5, 6], harvestMonths: [6, 7, 8, 9, 10],
    regionalNote: "Frileuse — rentrer en pot ou pailler en hiver dans le nord.",
  ),

  // ── Nouveautés vague 1 batch 5 ──
  RegionData(
    regionId: 'france', vegetableId: 'laurier_sauce', sowingMonths: [3, 4, 5, 9, 10], harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote: "Persistant — récolte toute l'année. Plantation au printemps ou à l'automne.",
  ),
  RegionData(regionId: 'france', vegetableId: 'camomille', sowingMonths: [3, 4, 5], harvestMonths: [6, 7, 8]),
  RegionData(regionId: 'france', vegetableId: 'marjolaine', sowingMonths: [4, 5, 6], harvestMonths: [7, 8, 9, 10]),
  RegionData(
    regionId: 'france', vegetableId: 'lentille', sowingMonths: [3, 4], harvestMonths: [7, 8],
    regionalNote: "AOP du Puy en Auvergne — culture aussi possible en sol calcaire.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'pois_chiche', sowingMonths: [4, 5], harvestMonths: [8, 9],
    regionalNote: "Aime la chaleur — meilleurs résultats au sud de la Loire.",
  ),

  // ── Nouveautés vague 1 batch 6 ──
  RegionData(regionId: 'france', vegetableId: 'pois_mange_tout', sowingMonths: [2, 3, 4, 8, 9], harvestMonths: [5, 6, 7, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'haricot_beurre', sowingMonths: [5, 6, 7], harvestMonths: [7, 8, 9, 10]),
  RegionData(
    regionId: 'france', vegetableId: 'framboisier', sowingMonths: [10, 11, 2, 3], harvestMonths: [6, 7, 9, 10],
    regionalNote: "Plantation à l'automne ou en fin d'hiver. Récolte d'été pour les variétés non-remontantes, été + automne pour les remontantes.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'cassissier', sowingMonths: [10, 11, 2, 3], harvestMonths: [7],
    regionalNote: "Plantation à l'automne ou en fin d'hiver. Production à partir de la 2e année.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'groseillier', sowingMonths: [10, 11, 2, 3], harvestMonths: [6, 7],
    regionalNote: "Plantation à l'automne ou en fin d'hiver. Très rustique.",
  ),

  // ── Nouveautés vague 1 batch 7 ──
  RegionData(
    regionId: 'france', vegetableId: 'murier', sowingMonths: [10, 11, 2, 3], harvestMonths: [7, 8, 9],
    regionalNote: "Plantation à l'automne ou en fin d'hiver. Production à partir de la 2e année.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'myrtillier', sowingMonths: [10, 11, 2, 3], harvestMonths: [7, 8, 9],
    regionalNote: "Sol acide indispensable — préférer la culture en pot avec terre de bruyère en sol calcaire.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'rhubarbe', sowingMonths: [10, 11, 2, 3], harvestMonths: [4, 5, 6, 7],
    regionalNote: "Plantation à l'automne ou en fin d'hiver. Vivace pour une dizaine d'années.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'pleurote', sowingMonths: [3, 4, 5, 9, 10, 11], harvestMonths: [4, 5, 6, 10, 11, 12],
    regionalNote: "Culture sur kit toute l'année à l'abri. Préférer printemps et automne en extérieur.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'shiitake', sowingMonths: [3, 4, 10, 11], harvestMonths: [4, 5, 6, 9, 10, 11],
    regionalNote: "Bûche placée à l'ombre — première récolte à 6-12 mois, puis 5 ans de production.",
  ),

  // ── Nouveautés vague 1 batch 8 ──
  RegionData(
    regionId: 'france', vegetableId: 'champignon_paris', sowingMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote: "Culture en cave fraîche toute l'année (12-18 °C).",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'pommier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [7, 8, 9, 10, 11],
    regionalNote: "Plantation à racines nues en hiver. Production à partir de la 3e année.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'poirier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [8, 9, 10],
    regionalNote: "Plantation à racines nues en hiver. Préfère les régions à étés chauds.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'prunier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [7, 8, 9],
    regionalNote: "Plantation à racines nues en hiver. Reines-Claude et Mirabelles emblématiques.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'cerisier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [6, 7],
    regionalNote: "Plantation à racines nues en hiver. Filets anti-oiseaux indispensables à la maturité.",
  ),

  // ── Nouveautés vague 1 batch 9 ──
  RegionData(
    regionId: 'france', vegetableId: 'abricotier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [7],
    regionalNote: "Floraison précoce sensible aux gelées tardives — préférer le sud ou un emplacement abrité.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'pecher', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [7, 8],
    regionalNote: "Plantation à racines nues en hiver. Traiter contre la cloque à la chute des feuilles.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'figuier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [7, 8, 9, 10],
    regionalNote: "Plantation à racines nues en hiver. Très peu exigeant.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'noisetier', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [8, 9, 10],
    regionalNote: "Plantation à racines nues en hiver. Planter au moins 2 variétés pour la pollinisation.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'vigne', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [8, 9, 10],
    regionalNote: "Plantation à racines nues en hiver. Tailler chaque hiver pour rester productive.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'kiwi', sowingMonths: [11, 12, 1, 2, 3], harvestMonths: [10, 11],
    regionalNote: "Plantation à racines nues en hiver. Prévoir un pied mâle pour 5-6 pieds femelles.",
  ),

  // ── Vague 2 batch 10 — Fleurs comestibles ──
  RegionData(regionId: 'france', vegetableId: 'capucine', sowingMonths: [4, 5, 6], harvestMonths: [6, 7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'souci', sowingMonths: [3, 4, 5, 6, 9], harvestMonths: [5, 6, 7, 8, 9, 10, 11]),
  RegionData(regionId: 'france', vegetableId: 'bourrache', sowingMonths: [3, 4, 5, 6], harvestMonths: [5, 6, 7, 8, 9, 10]),
  RegionData(
    regionId: 'france', vegetableId: 'pensee', sowingMonths: [6, 7, 8], harvestMonths: [3, 4, 5, 6, 9, 10, 11],
    regionalNote: "Bisannuelle — semis en été pour floraison au printemps suivant.",
  ),
  RegionData(regionId: 'france', vegetableId: 'oeillet_inde', sowingMonths: [3, 4, 5], harvestMonths: [6, 7, 8, 9, 10]),

  // ── Vague 2 batch 11 — Fleurs utiles au potager ──
  RegionData(regionId: 'france', vegetableId: 'tournesol', sowingMonths: [4, 5, 6], harvestMonths: [7, 8, 9]),
  RegionData(regionId: 'france', vegetableId: 'tagete', sowingMonths: [3, 4, 5], harvestMonths: [6, 7, 8, 9, 10]),
  RegionData(
    regionId: 'france', vegetableId: 'lavande', sowingMonths: [3, 4, 5, 9, 10], harvestMonths: [6, 7, 8],
    regionalNote: "Vivace — plantation au printemps ou à l'automne. Floraison à partir de la 2e année.",
  ),
  RegionData(regionId: 'france', vegetableId: 'cosmos', sowingMonths: [4, 5, 6], harvestMonths: [6, 7, 8, 9, 10]),
  RegionData(regionId: 'france', vegetableId: 'zinnia', sowingMonths: [4, 5, 6], harvestMonths: [7, 8, 9, 10]),

  // ── Vague 2 batch 12 — Bleuet + engrais verts ──
  RegionData(regionId: 'france', vegetableId: 'bleuet', sowingMonths: [3, 4, 9, 10], harvestMonths: [5, 6, 7, 8]),
  RegionData(
    regionId: 'france', vegetableId: 'phacelie', sowingMonths: [3, 4, 5, 6, 7, 8, 9], harvestMonths: [5, 6, 7, 8, 9, 10],
    regionalNote: "Engrais vert — enfouir avant montée en graines (8-10 semaines après semis).",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'moutarde_blanche', sowingMonths: [3, 4, 5, 6, 7, 8, 9], harvestMonths: [5, 6, 7, 8, 9, 10, 11],
    regionalNote: "Engrais vert — enfouir 6 à 8 semaines après semis ou laisser geler.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'trefle_incarnat', sowingMonths: [8, 9], harvestMonths: [4, 5],
    regionalNote: "Engrais vert légumineuse — semis fin été, enfouissement au printemps.",
  ),
  RegionData(
    regionId: 'france', vegetableId: 'sarrasin', sowingMonths: [5, 6, 7], harvestMonths: [7, 8, 9],
    regionalNote: "Engrais vert d'été — détruit par les gelées, ne pas laisser grainer.",
  ),
];
