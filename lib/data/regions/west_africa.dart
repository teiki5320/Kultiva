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
    regionId: 'west_africa',
    vegetableId: 'artichaut',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3, 4],
    regionalNote:
        "Peu cultivé en Afrique de l'Ouest. Possible en altitude ou en saison fraîche sèche.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'blette',
      sowingMonths: [10, 11, 12],
      harvestMonths: [1, 2, 3, 4]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'celeri',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Préférer la saison sèche et fraîche. Le céleri supporte mal la chaleur humide.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'mache',
    sowingMonths: [11, 12],
    harvestMonths: [1, 2],
    regionalNote:
        "Non adaptée au climat tropical — possible en altitude uniquement. Préférer la laitue.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'roquette',
      sowingMonths: [10, 11, 12],
      harvestMonths: [12, 1, 2]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'chou_kale',
    sowingMonths: [9, 10, 11],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Cultiver en saison sèche fraîche. Le kale résiste mieux à la chaleur que les autres choux.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'arachide',
      sowingMonths: [5, 6, 7],
      harvestMonths: [9, 10, 11]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'bissap',
      sowingMonths: [5, 6, 7],
      harvestMonths: [10, 11, 12]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'sesame',
      sowingMonths: [6, 7],
      harvestMonths: [10, 11]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'gingembre',
      sowingMonths: [4, 5, 6],
      harvestMonths: [12, 1, 2]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'asperge',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3, 4],
    regionalNote:
        "Rare en Afrique de l'Ouest — culture expérimentale en zone sahélienne irriguée.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'fenouil',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Cultiver en saison fraîche sèche uniquement. Monte vite en graines sous forte chaleur.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'endive',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3],
    regionalNote:
        "Le forçage en cave est difficile en climat chaud. Culture marginale.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'chou_bruxelles',
    sowingMonths: [9, 10],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Très peu adapté aux tropiques — nécessite du froid pour former les pommes. Essayer en altitude.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'potimarron',
      sowingMonths: [6, 7, 8],
      harvestMonths: [10, 11, 12]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'oseille',
      sowingMonths: [6, 7, 8, 9],
      harvestMonths: [8, 9, 10, 11, 12]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'taro',
      sowingMonths: [4, 5, 6],
      harvestMonths: [11, 12, 1]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'amarante',
      sowingMonths: [5, 6, 7, 8],
      harvestMonths: [7, 8, 9, 10, 11]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'sorgho',
      sowingMonths: [5, 6, 7],
      harvestMonths: [9, 10, 11]),
  // ── Légumes 61–120 ─────────────────────────────────────────────────────
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'abricotier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de froid hivernal (vernalisation) pour fleurir — non adapté aux plaines tropicales. Préférer le manguier ou le papayer.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'aneth',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Semer en saison sèche fraîche — l'aneth monte vite en graines sous forte chaleur.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'bleuet',
    sowingMonths: [10, 11, 12],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Fleur de climat frais — semer en saison sèche fraîche et arroser régulièrement.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'bourrache',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Semer en saison sèche fraîche — la bourrache supporte mal la chaleur humide des pluies.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'camomille',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2, 3],
    regionalNote:
        "Cultiver en saison sèche fraîche, à mi-ombre aux heures les plus chaudes.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'capucine',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Fleurit mieux en saison sèche fraîche — la chaleur extrême réduit la floraison.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'cassissier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un froid hivernal marqué — impossible en climat tropical. Pour une boisson acidulée, préférer le bissap.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'cerfeuil',
    sowingMonths: [10, 11, 12],
    harvestMonths: [11, 12, 1, 2],
    regionalNote:
        "Semer à mi-ombre en saison fraîche — monte très vite en graines dès les premières chaleurs.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'cerisier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de froid hivernal pour fleurir — non adapté. Le cerisier de Cayenne, bien acclimaté aux tropiques, est une belle alternative.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'champignon_paris',
    sowingMonths: [11, 12, 1],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Exige un local frais (15-18 °C) — difficile sans pièce climatisée. La pleurote est bien plus facile sous les tropiques.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'chou_chinois',
    sowingMonths: [9, 10, 11],
    harvestMonths: [11, 12, 1, 2],
    regionalNote:
        "Cycle rapide en saison fraîche — choisir des variétés tropicales résistantes à la montaison.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'chou_rave',
      sowingMonths: [9, 10, 11],
      harvestMonths: [12, 1, 2]),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'cornichon',
      sowingMonths: [9, 10, 11],
      harvestMonths: [11, 12, 1, 2]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'cosmos',
    sowingMonths: [5, 6, 7],
    harvestMonths: [8, 9, 10, 11],
    regionalNote:
        "Très tolérant à la chaleur — semer au début des pluies pour une floraison généreuse.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'cresson',
    sowingMonths: [10, 11, 12],
    harvestMonths: [11, 12, 1, 2],
    regionalNote:
        "Exige fraîcheur et eau constante — cultiver à l'ombre en saison sèche fraîche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'estragon',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2, 3, 4],
    regionalNote:
        "Délicat en climat chaud — l'estragon du Mexique (Tagetes lucida) est une excellente alternative tropicale.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'figuier',
    sowingMonths: [6, 7, 8],
    harvestMonths: [3, 4, 5, 6],
    regionalNote:
        "S'adapte bien aux zones sèches sahéliennes une fois établi. Planter en début de saison des pluies.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'framboisier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un froid hivernal — non adapté aux plaines tropicales. Possible uniquement en altitude (ex. Fouta-Djalon).",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'groseillier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de froid hivernal — non adapté au climat tropical de plaine. Le bissap offre une acidité comparable.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'haricot_beurre',
    sowingMonths: [6, 7, 10, 11],
    harvestMonths: [9, 10, 1, 2],
    regionalNote: "Même conduite que le haricot vert classique.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'kiwi',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige plusieurs centaines d'heures de froid hivernal — impossible en zone tropicale. Préférer le fruit de la passion.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'laurier_sauce',
    sowingMonths: [6, 7, 8],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Planter en début de saison des pluies. Croissance lente ; feuilles récoltables toute l'année une fois l'arbre établi.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'lavande',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3, 4],
    regionalNote:
        "Difficile en climat humide — réserver aux zones sahéliennes sèches, en sol très drainé.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'lentille',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2],
    regionalNote:
        "Culture de saison sèche fraîche sur l'humidité résiduelle, surtout en zone sahélienne.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'marjolaine',
      sowingMonths: [10, 11],
      harvestMonths: [12, 1, 2, 3, 4]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'melisse',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Cultiver à mi-ombre en saison fraîche. La citronnelle, très bien adaptée, offre un parfum proche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'moutarde_blanche',
    sowingMonths: [10, 11, 12],
    harvestMonths: [11, 12, 1, 2],
    regionalNote: "Engrais vert à cycle court pour la saison sèche fraîche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'murier',
    sowingMonths: [6, 7, 8],
    harvestMonths: [3, 4, 5],
    regionalNote:
        "Le mûrier pousse très bien en zone tropicale. Planter en début de saison des pluies.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'myrtillier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un froid hivernal et un sol acide frais — non adapté au climat tropical de plaine.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'noisetier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de froid hivernal — non adapté. L'anacardier (noix de cajou) est l'arbre à « noisette » des tropiques.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'oeillet_inde',
    sowingMonths: [5, 6, 7],
    harvestMonths: [7, 8, 9, 10, 11],
    regionalNote:
        "Très bien adapté au climat tropical — excellent compagnon contre les nématodes du sol.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'origan',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2, 3, 4],
    regionalNote: "Semer en saison sèche fraîche, en sol bien drainé.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pak_choi',
    sowingMonths: [9, 10, 11, 12],
    harvestMonths: [10, 11, 12, 1, 2],
    regionalNote:
        "Cycle très court en saison fraîche — choisir des variétés résistantes à la montaison.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'panais',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3],
    regionalNote:
        "Cycle long et germination délicate sous la chaleur — culture d'essai en zone sahélienne ; la carotte est plus sûre.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pecher',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de froid hivernal, même pour les variétés dites « low chill » — non adapté aux plaines d'Afrique de l'Ouest. Préférer le manguier.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pensee',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Fleur de climat frais — floraison possible uniquement en saison sèche fraîche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'phacelie',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Engrais vert de saison fraîche. En saison des pluies, préférer la crotalaire ou le mucuna, engrais verts tropicaux.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pleurote',
    sowingMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Culture sur sacs de paille pasteurisée, à l'ombre — très bien adaptée au climat tropical, toute l'année.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'poirier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un froid hivernal — non adapté au climat tropical. Préférer le manguier, l'avocatier ou le goyavier.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pois_chiche',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2],
    regionalNote:
        "Semer en début de saison sèche sur l'humidité résiduelle — le pois chiche craint l'excès d'eau.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pois_mange_tout',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2],
    regionalNote:
        "Comme le petit pois : réserver à la saison la plus fraîche ou à l'altitude.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pommier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Besoin de centaines d'heures de froid hivernal — non adapté. Préférer le manguier, le papayer ou le goyavier.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'pourpier',
    sowingMonths: [5, 6, 7, 8, 9],
    harvestMonths: [6, 7, 8, 9, 10, 11],
    regionalNote:
        "Très résistant à la chaleur — pousse presque toute l'année avec un peu d'eau.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'prunier',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un froid hivernal — non adapté. Le prunier mombin, espèce locale, offre des fruits acidulés proches.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'radis_noir',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Réserver à la saison sèche fraîche — cycle plus long que le radis rose.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'rhubarbe',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Exige un climat frais et humide — non adaptée. L'oseille de Guinée (bissap) donne une acidité comparable en cuisine.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'romarin',
    sowingMonths: [9, 10, 11],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Bien adapté aux zones sèches sahéliennes. En climat humide, soigner le drainage.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'rutabaga',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2],
    regionalNote:
        "Exigeant en fraîcheur — le navet, à cycle plus court, est plus fiable sous les tropiques.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'salsifis',
    sowingMonths: [10, 11],
    harvestMonths: [2, 3, 4],
    regionalNote:
        "Cycle long en saison sèche fraîche — culture marginale, arroser régulièrement.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'sarrasin',
    sowingMonths: [10, 11],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Cycle court (10-12 semaines) — semer en début de saison sèche fraîche, avec irrigation.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'sarriette',
      sowingMonths: [10, 11],
      harvestMonths: [12, 1, 2, 3]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'sauge',
    sowingMonths: [10, 11],
    harvestMonths: [1, 2, 3, 4, 5],
    regionalNote:
        "Craint l'humidité de la saison des pluies — cultiver en sol très drainé, en saison sèche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'shiitake',
    sowingMonths: [11, 12],
    harvestMonths: [12, 1, 2],
    regionalNote:
        "Fructifie entre 15 et 20 °C — très difficile sans local climatisé. La pleurote est l'option tropicale par excellence.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'souci',
    sowingMonths: [10, 11, 12],
    harvestMonths: [12, 1, 2, 3],
    regionalNote:
        "Fleurit en saison sèche fraîche — la floraison s'arrête sous les fortes chaleurs.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'tagete',
    sowingMonths: [5, 6, 7],
    harvestMonths: [7, 8, 9, 10, 11],
    regionalNote:
        "Comme l'œillet d'Inde : très adaptée au climat tropical et précieuse contre les nématodes.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'topinambour',
    sowingMonths: [5, 6],
    harvestMonths: [11, 12, 1],
    regionalNote:
        "Planter les tubercules en début de saison des pluies ; récolter en saison sèche.",
  ),
  RegionData(
      regionId: 'west_africa',
      vegetableId: 'tournesol',
      sowingMonths: [5, 6, 7],
      harvestMonths: [9, 10, 11]),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'trefle_incarnat',
    sowingMonths: [],
    harvestMonths: [],
    regionalNote:
        "Engrais vert de climat tempéré, il végète sous la chaleur — préférer la crotalaire, le mucuna ou le niébé fourrager.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'verveine',
    sowingMonths: [5, 6, 7],
    harvestMonths: [7, 8, 9, 10, 11, 12],
    regionalNote:
        "La verveine citronnelle apprécie la chaleur — planter en début de pluies, en sol drainé.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'vigne',
    sowingMonths: [10, 11, 12],
    harvestMonths: [4, 5, 6],
    regionalNote:
        "Possible au Sahel sous irrigation (Sénégal, Niger) — la taille remplace le repos hivernal pour induire la fructification.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'zinnia',
    sowingMonths: [5, 6, 7],
    harvestMonths: [7, 8, 9, 10, 11],
    regionalNote:
        "Fleur reine du climat chaud — semer au début des pluies pour une floraison éclatante.",
  ),
  // ── Cultures ouest-africaines (nouvelles) ─────────────────────────────
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'mil',
    sowingMonths: [5, 6, 7],
    harvestMonths: [9, 10, 11],
    regionalNote:
        "Semer en poquets dès les premières pluies utiles, puis démarier à 2-3 plants. Associer au niébé entre les poquets.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'fonio',
    sowingMonths: [5, 6, 7],
    harvestMonths: [8, 9, 10],
    regionalNote:
        "Semis à la volée en début d'hivernage. Récolter dès que les grains durcissent pour devancer les oiseaux.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'moringa',
    sowingMonths: [5, 6, 7],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Semer en début de saison des pluies. Feuilles récoltables toute l'année dès 2-3 mois ; arroser en saison sèche la première année.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'aubergine_africaine',
    sowingMonths: [5, 6, 7, 10, 11],
    harvestMonths: [8, 9, 10, 11, 12, 1, 2],
    regionalNote:
        "Pépinière ombragée puis repiquage. Se cultive aussi en saison sèche près d'un point d'eau, comme le maraîchage classique.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'corete',
    sowingMonths: [5, 6, 7, 8],
    harvestMonths: [6, 7, 8, 9, 10],
    regionalNote:
        "Culture d'hivernage par excellence : semer à chaque pluie pour des récoltes échelonnées de jeunes pousses.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'celosie',
    sowingMonths: [4, 5, 6, 7, 8, 9],
    harvestMonths: [6, 7, 8, 9, 10, 11],
    regionalNote:
        "Croissance éclair (30-50 jours) : resemer toutes les 3 semaines pendant l'hivernage pour des feuilles tendres en continu.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'baselle',
    sowingMonths: [4, 5, 6],
    harvestMonths: [6, 7, 8, 9, 10, 11],
    regionalNote:
        "Adore la chaleur humide de l'hivernage. Prévoir un treillis ou une clôture ; en zone côtière, produit presque toute l'année.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'citronnelle',
    sowingMonths: [5, 6, 7],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Planter les éclats de touffe en début de saison des pluies. Tiges à couper toute l'année ; arroser en saison sèche.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'papayer',
    sowingMonths: [5, 6, 7],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Semer en sachets en début d'hivernage, planter au champ 2 mois plus tard. Premiers fruits 9 à 12 mois après, puis récolte au fil de l'an.",
  ),
  RegionData(
    regionId: 'west_africa',
    vegetableId: 'bananier_plantain',
    sowingMonths: [5, 6, 7],
    harvestMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    regionalNote:
        "Planter les rejets en début de saison des pluies dans un trou enrichi de fumier. Récolte du régime 10 à 14 mois plus tard, puis cycle continu grâce aux rejets.",
  ),
];
