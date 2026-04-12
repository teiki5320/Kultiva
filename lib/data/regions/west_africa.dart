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
];
