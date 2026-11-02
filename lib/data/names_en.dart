import '../models/vegetable.dart';
import 'names_es.dart';
import '../services/prefs_service.dart';

/// Les 130 cultures du catalogue, en anglais.
///
/// Première langue ajoutée le 01/11/2026, avec l'ouverture à 73 pays.
/// Le nom d'un légume **est** le produit dans une app de jardinage :
/// une interface anglaise posée sur un catalogue français n'aurait
/// servi à personne.
///
/// Clé = `Vegetable.id`. Un identifiant absent retombe sur le nom
/// français, qui reste la source de vérité — c'est pour ça que ce
/// fichier est une surcouche et non un second catalogue.
///
/// Les accessoires ne sont pas traduits : ils ne s'affichent qu'en
/// France, où les liens partenaires existent.
const Map<String, String> vegetableNamesEn = <String, String>{
  // ─── Légumes-fruits ───
  'tomate': 'Tomato',
  'courgette': 'Zucchini',
  'aubergine': 'Eggplant',
  'poivron': 'Bell pepper',
  'piment': 'Chilli pepper',
  'concombre': 'Cucumber',
  'cornichon': 'Gherkin',
  'potiron': 'Pumpkin',
  'potimarron': 'Red kuri squash',
  'courge_butternut': 'Butternut squash',
  'melon': 'Melon',
  'pasteque': 'Watermelon',
  'mais': 'Sweetcorn',
  'gombo': 'Okra',
  'fraise': 'Strawberry',
  'papayer': 'Papaya',
  'bananier_plantain': 'Plantain',

  // ─── Légumes-feuilles ───
  'laitue': 'Lettuce',
  'epinard': 'Spinach',
  'chou_pomme': 'Cabbage',
  'chou_fleur': 'Cauliflower',
  'brocoli': 'Broccoli',
  'chou_kale': 'Kale',
  'chou_bruxelles': 'Brussels sprouts',
  'chou_chinois': 'Napa cabbage',
  'chou_rave': 'Kohlrabi',
  'pak_choi': 'Pak choi',
  'blette': 'Swiss chard',
  'mache': 'Lamb\'s lettuce',
  'roquette': 'Rocket',
  'endive': 'Chicory',
  'cresson': 'Watercress',
  'oseille': 'Sorrel',
  'pourpier': 'Purslane',
  'amarante': 'Amaranth',
  'corete': 'Jute mallow',
  'celosie': 'Celosia',
  'baselle': 'Malabar spinach',
  'moringa': 'Moringa',

  // ─── Racines, tubercules, bulbes ───
  'carotte': 'Carrot',
  'radis': 'Radish',
  'radis_noir': 'Black radish',
  'navet': 'Turnip',
  'betterave': 'Beetroot',
  'panais': 'Parsnip',
  'rutabaga': 'Swede',
  'salsifis': 'Salsify',
  'topinambour': 'Jerusalem artichoke',
  'pomme_de_terre': 'Potato',
  'patate_douce': 'Sweet potato',
  'igname': 'Yam',
  'manioc': 'Cassava',
  'taro': 'Taro',
  'oignon': 'Onion',
  'echalote': 'Shallot',
  'ail': 'Garlic',
  'poireau': 'Leek',

  // ─── Légumineuses ───
  'haricot': 'Green bean',
  'haricot_beurre': 'Wax bean',
  'petit_pois': 'Garden pea',
  'pois_mange_tout': 'Snow pea',
  'pois_chiche': 'Chickpea',
  'feve': 'Broad bean',
  'lentille': 'Green lentil',
  'niebe': 'Cowpea',
  'arachide': 'Peanut',

  // ─── Tiges et autres ───
  'artichaut': 'Artichoke',
  'asperge': 'Asparagus',
  'celeri': 'Celery',
  'fenouil': 'Fennel',
  'rhubarbe': 'Rhubarb',

  // ─── Aromates ───
  'basilic': 'Basil',
  'persil': 'Parsley',
  'coriandre': 'Coriander',
  'ciboulette': 'Chives',
  'menthe': 'Mint',
  'thym': 'Thyme',
  'romarin': 'Rosemary',
  'sauge': 'Common sage',
  'origan': 'Oregano',
  'marjolaine': 'Marjoram',
  'estragon': 'Tarragon',
  'sarriette': 'Savory',
  'aneth': 'Dill',
  'cerfeuil': 'Chervil',
  'laurier_sauce': 'Bay laurel',
  'melisse': 'Lemon balm',
  'verveine': 'Lemon verbena',
  'camomille': 'Roman chamomile',
  'citronnelle': 'Lemongrass',
  'gingembre': 'Ginger',
  'bissap': 'Roselle',
  'sesame': 'Sesame',

  // ─── Champignons ───
  'champignon_paris': 'Button mushroom (kit)',
  'pleurote': 'Oyster mushroom (kit)',
  'shiitake': 'Shiitake (kit)',

  // ─── Petits fruits et arbres ───
  'framboisier': 'Raspberry',
  'cassissier': 'Blackcurrant',
  'groseillier': 'Redcurrant',
  'murier': 'Thornless blackberry',
  'myrtillier': 'Blueberry',
  'pommier': 'Apple tree',
  'poirier': 'Pear tree',
  'prunier': 'Plum tree',
  'cerisier': 'Cherry tree',
  'abricotier': 'Apricot tree',
  'pecher': 'Peach tree',
  'figuier': 'Fig tree',
  'noisetier': 'Hazel',
  'vigne': 'Grapevine',
  'kiwi': 'Kiwi',

  // ─── Céréales ───
  'mil': 'Pearl millet',
  'sorgho': 'Sorghum',
  'fonio': 'Fonio',
  'sarrasin': 'Buckwheat',

  // ─── Fleurs compagnes et engrais verts ───
  'capucine': 'Nasturtium',
  'souci': 'Pot marigold',
  'oeillet_inde': 'French marigold',
  'tagete': 'Mexican marigold',
  'bourrache': 'Borage',
  'pensee': 'Pansy',
  'tournesol': 'Sunflower',
  'lavande': 'True lavender',
  'cosmos': 'Cosmos',
  'zinnia': 'Zinnia',
  'bleuet': 'Cornflower',
  'phacelie': 'Phacelia',
  'moutarde_blanche': 'White mustard',
  'trefle_incarnat': 'Crimson clover',
  'aubergine_africaine': 'African eggplant',

  // ─── les 39 accessoires, ajoutés le 02/11/2026 ───
  // Ils n'avaient jamais été traduits : le catalogue espagnol
  // affichait « Binette / serfouette » sous un chip
  // « Herramientas ».
  'acc_activateur_compost': 'Compost activator',
  'acc_anti_limaces': 'Organic slug pellets (Ferramol)',
  'acc_arche': 'Garden arch',
  'acc_arrosoir': 'Watering can',
  'acc_bac': 'Planter box',
  'acc_binette': 'Hoe / draw hoe',
  'acc_carre_potager': 'Wooden raised bed',
  'acc_chassis': 'Cold frame',
  'acc_cloche': 'Garden cloche',
  'acc_composteur': 'Garden compost bin',
  'acc_engrais': 'Organic fertiliser',
  'acc_etiquettes': 'Plant labels',
  'acc_filet_insectes': 'Insect netting',
  'acc_filet_oiseaux': 'Bird netting',
  'acc_gants': 'Gardening gloves',
  'acc_goutte_a_goutte': 'Drip irrigation kit',
  'acc_graines': 'Organic seed kit',
  'acc_grelinette': 'Broadfork',
  'acc_lombricomposteur': 'Wormery',
  'acc_mulch_ecorces': 'Pine bark mulch',
  'acc_ombriere': 'Shade netting 30-50 %',
  'acc_oyas': 'Terracotta ollas',
  'acc_paillis_chanvre': 'Hemp mulch',
  'acc_panier_recolte': 'Harvest basket',
  'acc_plantoir': 'Bulb planter',
  'acc_programmateur': 'Watering timer',
  'acc_rames_bambou': 'Bamboo canes',
  'acc_recuperateur': 'Water butt',
  'acc_secateur': 'Secateurs',
  'acc_serre_tunnel': 'Mini polytunnel',
  'acc_table_culture': 'Growing table',
  'acc_terreau': 'Organic potting compost',
  'acc_transplantoir': 'Hand trowel',
  'acc_treillis_tomate': 'Tomato trellis',
  'acc_tuteur': 'Plant stakes',
  'acc_tuteurs_spirales': 'Spiral stakes',
  'acc_tuyau_microporeux': 'Soaker hose',
  'acc_voile_forcage': 'Horticultural fleece',
  'acc_voile_hivernage': 'Winter fleece',
};

/// Le nom d'un légume dans la langue de l'interface.
///
/// Sans contexte : la langue vit dans les préférences, comme la région
/// et la zone climatique. Les call-sites sont des centaines, et leur
/// faire porter un `BuildContext` aurait surtout produit des oublis.
String vegetableNameIn(String id, String frenchName, String languageCode) {
  final table = _tables[languageCode];
  return table?[id] ?? frenchName;
}

/// Les surcouches de noms, par langue. Ajouter une langue, c'est un
/// fichier et une ligne ici.
const Map<String, Map<String, String>> _tables =
    <String, Map<String, String>>{
  'en': vegetableNamesEn,
  'es': vegetableNamesEs,
};

/// Le nom affiché d'un légume, traduit si la langue l'est.
///
/// `v.name` reste le nom français, source de vérité ; `v.displayName`
/// est ce qu'on montre. Les deux coexistent exprès : la recherche sans
/// accent, les clés de données et les tests continuent de travailler
/// sur le français.
extension VegetableDisplayName on Vegetable {
  String get displayName =>
      vegetableNameIn(id, name, PrefsService.instance.effectiveLanguage);
}
