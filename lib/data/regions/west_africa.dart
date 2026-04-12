import '../../models/region_data.dart';

/// Données de semis et récolte pour l'Afrique de l'Ouest.
///
/// Saisons de référence :
///   - saison sèche : novembre → mai
///   - saison des pluies : juin → octobre
const List<RegionData> westAfricaData = <RegionData>[
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'tomate',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'carotte',
    sowingMonths: [10, 11, 12, 1],
    harvestMonths: [1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'courgette',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'laitue',
    sowingMonths: [10, 11, 12, 1, 2],
    harvestMonths: [12, 1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'haricot',
    sowingMonths: [6, 7, 8, 10, 11],
    harvestMonths: [9, 10, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'aubergine',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'poivron',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'epinard',
    sowingMonths: [10, 11, 12, 1],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Préférer les variétés tropicales (amarante, célosie) qui résistent mieux à la chaleur.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'oignon',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'basilic',
    sowingMonths: [6, 7, 8, 9, 10],
    harvestMonths: [8, 9, 10, 11, 12],
  ),
  // ── Nouveaux (11–20) ──────────────────────────────────────────────────
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'concombre',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'piment',
    sowingMonths: [8, 9, 10, 11],
    harvestMonths: [12, 1, 2, 3, 4, 5],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'ail',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3, 4],
    regionalNote:
        "Cultiver en saison sèche fraîche. L'ail supporte mal l'humidité excessive de la saison des pluies.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pomme_de_terre',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Culture de saison sèche en altitude ou en zone sahélienne. Difficile en zone tropicale humide de basse altitude.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'radis',
    sowingMonths: [10, 11, 12, 1],
    harvestMonths: [11, 12, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'chou_pomme',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2, 3],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'petit_pois',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2],
    regionalNote:
        "Culture délicate en zone tropicale — préférer les altitudes ou la saison la plus fraîche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'poireau',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4],
    regionalNote:
        "Peu courant en Afrique de l'Ouest. Cultiver en saison fraîche et sèche uniquement.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'patate_douce',
    sowingMonths: [5, 6, 7],
    harvestMonths: [10, 11, 12],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'gombo',
    sowingMonths: [5, 6, 7, 8],
    harvestMonths: [8, 9, 10, 11, 12],
  ),
  // ── Légumes 21–40 ──────────────────────────────────────────────────────
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'echalote',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Cultivée principalement au Sahel (Niger, Mali). Préférer la saison sèche fraîche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'chou_fleur',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Cultiver en saison fraîche et sèche. Le chou-fleur supporte mal la forte chaleur humide.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'brocoli',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Même exigences que le chou-fleur — saison fraîche uniquement.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'courge_butternut',
    sowingMonths: [6, 7, 8],
    harvestMonths: [10, 11, 12],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'potiron',
    sowingMonths: [6, 7, 8],
    harvestMonths: [10, 11, 12],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'melon',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pasteque',
    sowingMonths: [10, 11, 12, 1],
    harvestMonths: [2, 3, 4, 5],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'fraise',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Culture rare en zone tropicale — possible en altitude ou en saison fraîche sèche avec variétés adaptées.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'navet',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'betterave',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'mais',
    sowingMonths: [5, 6, 7],
    harvestMonths: [8, 9, 10],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'persil',
    sowingMonths: [9, 10, 11, 12],
    harvestMonths: [11, 12, 1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'coriandre',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2, 3],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'ciboulette',
    sowingMonths: [9, 10, 11],
    harvestMonths: [11, 12, 1, 2, 3, 4],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'menthe',
    sowingMonths: [6, 7, 8, 9],
    harvestMonths: [8, 9, 10, 11, 12, 1, 2],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'thym',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Pousse bien en zone sahélienne. En climat très humide, veiller au drainage pour éviter la pourriture.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'feve',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Peu courante en Afrique de l'Ouest. Tester en saison fraîche et sèche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'igname',
    sowingMonths: [3, 4, 5],
    harvestMonths: [11, 12, 1],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'manioc',
    sowingMonths: [4, 5, 6],
    harvestMonths: [12, 1, 2, 3, 4, 5],
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'niebe',
    sowingMonths: [6, 7, 8],
    harvestMonths: [9, 10, 11],
  ),
];
