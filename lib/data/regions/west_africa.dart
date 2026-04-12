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
  // ── Légumes 41–60 ──────────────────────────────────────────────────────
  RegionData(
    regionId: 'west_africa', vegetableId: 'artichaut', sowingMonths: [10, 11], harvestMonths: [2, 3, 4],
    regionalNote: "Peu cultivé en Afrique de l'Ouest. Possible en altitude ou en saison fraîche sèche.",
  ),
  RegionData(regionId: 'west_africa', vegetableId: 'blette', sowingMonths: [10, 11, 12], harvestMonths: [1, 2, 3, 4]),
  RegionData(
    regionId: 'west_africa', vegetableId: 'celeri', sowingMonths: [10, 11], harvestMonths: [1, 2, 3],
    regionalNote: "Préférer la saison sèche et fraîche. Le céleri supporte mal la chaleur humide.",
  ),
  RegionData(
    regionId: 'west_africa', vegetableId: 'mache', sowingMonths: [11, 12], harvestMonths: [1, 2],
    regionalNote: "Non adaptée au climat tropical — possible en altitude uniquement. Préférer la laitue.",
  ),
  RegionData(regionId: 'west_africa', vegetableId: 'roquette', sowingMonths: [10, 11, 12], harvestMonths: [12, 1, 2]),
  RegionData(
    regionId: 'west_africa', vegetableId: 'chou_kale', sowingMonths: [9, 10, 11], harvestMonths: [12, 1, 2, 3],
    regionalNote: "Cultiver en saison sèche fraîche. Le kale résiste mieux à la chaleur que les autres choux.",
  ),
  RegionData(regionId: 'west_africa', vegetableId: 'arachide', sowingMonths: [5, 6, 7], harvestMonths: [9, 10, 11]),
  RegionData(regionId: 'west_africa', vegetableId: 'bissap', sowingMonths: [5, 6, 7], harvestMonths: [10, 11, 12]),
  RegionData(regionId: 'west_africa', vegetableId: 'sesame', sowingMonths: [6, 7], harvestMonths: [10, 11]),
  RegionData(regionId: 'west_africa', vegetableId: 'gingembre', sowingMonths: [4, 5, 6], harvestMonths: [12, 1, 2]),
  RegionData(
    regionId: 'west_africa', vegetableId: 'asperge', sowingMonths: [10, 11], harvestMonths: [2, 3, 4],
    regionalNote: "Rare en Afrique de l'Ouest — culture expérimentale en zone sahélienne irriguée.",
  ),
  RegionData(
    regionId: 'west_africa', vegetableId: 'fenouil', sowingMonths: [10, 11, 12], harvestMonths: [1, 2, 3],
    regionalNote: "Cultiver en saison fraîche sèche uniquement. Monte vite en graines sous forte chaleur.",
  ),
  RegionData(
    regionId: 'west_africa', vegetableId: 'endive', sowingMonths: [10, 11], harvestMonths: [2, 3],
    regionalNote: "Le forçage en cave est difficile en climat chaud. Culture marginale.",
  ),
  RegionData(
    regionId: 'west_africa', vegetableId: 'chou_bruxelles', sowingMonths: [9, 10], harvestMonths: [1, 2, 3],
    regionalNote: "Très peu adapté aux tropiques — nécessite du froid pour former les pommes. Essayer en altitude.",
  ),
  RegionData(regionId: 'west_africa', vegetableId: 'potimarron', sowingMonths: [6, 7, 8], harvestMonths: [10, 11, 12]),
  RegionData(regionId: 'west_africa', vegetableId: 'oseille', sowingMonths: [6, 7, 8, 9], harvestMonths: [8, 9, 10, 11, 12]),
  RegionData(regionId: 'west_africa', vegetableId: 'taro', sowingMonths: [4, 5, 6], harvestMonths: [11, 12, 1]),
  RegionData(regionId: 'west_africa', vegetableId: 'amarante', sowingMonths: [5, 6, 7, 8], harvestMonths: [7, 8, 9, 10, 11]),
  RegionData(regionId: 'west_africa', vegetableId: 'sorgho', sowingMonths: [5, 6, 7], harvestMonths: [9, 10, 11]),
];
