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
];
