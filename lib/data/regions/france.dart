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
];
