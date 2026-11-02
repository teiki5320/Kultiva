import '../../models/country.dart';

/// Surcharges du calendrier ouest-africain par zone climatique.
/// La base (westAfricaData) correspond à la zone soudanienne ; seules
/// les cultures dont le calendrier diffère significativement sont
/// surchargées ici.
typedef ZoneMonths = ({List<int> sowingMonths, List<int> harvestMonths});

/// Zone sahélienne : pluies mi-juin → septembre, harmattan nov-fév.
///
/// Logique : semis d'hivernage resserrés sur juin-juillet (les pluies
/// utiles arrivent rarement avant mi-juin), récoltes sept-nov avant
/// l'assèchement ; maraîchage de contre-saison décalé oct-déc près des
/// points d'eau, récolté jan-avril avant les grosses chaleurs de
/// mars-mai ; cultures exigeant une humidité constante (taro, bananier,
/// baselle, gingembre) réduites à des fenêtres étroites sous irrigation.
const Map<String, ZoneMonths> sahelCalendar = <String, ZoneMonths>{
  // ── Céréales d'hivernage ────────────────────────────────────────────
  'mil': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),
  'sorgho': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),
  'mais': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),
  'fonio': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),

  // ── Légumineuses et oléagineux d'hivernage ──────────────────────────
  'niebe': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),
  'arachide': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),
  // Haricot : hivernage court (juin-juil) + contre-saison irriguée.
  'haricot': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 1, 2]
  ),
  'tournesol': (sowingMonths: <int>[6, 7], harvestMonths: <int>[9, 10]),

  // ── Tubercules ──────────────────────────────────────────────────────
  'patate_douce': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),
  // Igname : cycle long mal servi par les pluies courtes — fenêtre réduite.
  'igname': (sowingMonths: <int>[5, 6], harvestMonths: <int>[11, 12]),
  // Manioc : marginal au Sahel, récolte 9-11 mois après plantation.
  'manioc': (sowingMonths: <int>[6, 7], harvestMonths: <int>[3, 4, 5]),
  // Taro : exige une humidité constante — fenêtre étroite sous irrigation.
  'taro': (sowingMonths: <int>[6, 7], harvestMonths: <int>[12, 1]),
  // Gingembre : 8-9 mois d'humidité — uniquement irrigué, fenêtre unique.
  'gingembre': (sowingMonths: <int>[6], harvestMonths: <int>[2, 3]),
  'topinambour': (sowingMonths: <int>[6], harvestMonths: <int>[11, 12]),

  // ── Maraîchage de contre-saison (oct-déc → jan-avril) ───────────────
  // Récoltes bouclées avant les chaleurs extrêmes de mars-mai.
  'tomate': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  // Oignon (type Violet de Galmi) : pépinière oct-déc, récolte fév-avril.
  'oignon': (sowingMonths: <int>[10, 11, 12], harvestMonths: <int>[2, 3, 4]),
  'carotte': (sowingMonths: <int>[10, 11, 12], harvestMonths: <int>[1, 2, 3]),
  'laitue': (
    sowingMonths: <int>[10, 11, 12, 1],
    harvestMonths: <int>[11, 12, 1, 2, 3]
  ),
  'chou_pomme': (
    sowingMonths: <int>[10, 11, 12],
    harvestMonths: <int>[1, 2, 3]
  ),
  'chou_fleur': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'brocoli': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2]),
  'aubergine': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'poivron': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'piment': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3, 4]),
  'courgette': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1, 2]),
  'concombre': (
    sowingMonths: <int>[10, 11, 12],
    harvestMonths: <int>[12, 1, 2]
  ),
  'epinard': (
    sowingMonths: <int>[10, 11, 12],
    harvestMonths: <int>[11, 12, 1, 2]
  ),
  'poireau': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3, 4]),
  'persil': (
    sowingMonths: <int>[10, 11, 12],
    harvestMonths: <int>[12, 1, 2, 3]
  ),

  // ── Cucurbitacées d'hivernage ───────────────────────────────────────
  'courge_butternut': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),
  'potiron': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),
  'potimarron': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),

  // ── Légumes-feuilles et cultures ouest-africaines ───────────────────
  'gombo': (sowingMonths: <int>[6, 7], harvestMonths: <int>[8, 9, 10, 11]),
  'amarante': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[7, 8, 9, 10]),
  'celosie': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[7, 8, 9, 10]),
  'corete': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[7, 8, 9, 10]),
  // Baselle : chaleur humide indispensable — fenêtre limitée à l'hivernage.
  'baselle': (sowingMonths: <int>[6, 7], harvestMonths: <int>[8, 9, 10]),
  'oseille': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[8, 9, 10, 11]),
  'pourpier': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[7, 8, 9, 10]),
  'basilic': (sowingMonths: <int>[6, 7, 8], harvestMonths: <int>[8, 9, 10, 11]),
  'bissap': (sowingMonths: <int>[6, 7], harvestMonths: <int>[10, 11]),
  'aubergine_africaine': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 11, 1, 2, 3]
  ),

  // ── Arbres et vivaces (plantés en début d'hivernage) ────────────────
  'moringa': (
    sowingMonths: <int>[6, 7],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'citronnelle': (
    sowingMonths: <int>[6, 7],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'papayer': (
    sowingMonths: <int>[6, 7],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  // Bananier plantain : marginal au Sahel — uniquement près d'un point
  // d'eau ; plantation limitée au cœur de l'hivernage.
  'bananier_plantain': (
    sowingMonths: <int>[6, 7],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
};

/// Zone guinéenne côtière : deux saisons des pluies (avril-juillet et
/// septembre-novembre), petite saison sèche en août.
///
/// Logique : deux fenêtres de semis pour les cultures pluviales (grande
/// saison mars-avril → récolte juin-juillet, petite saison août-sept →
/// récolte nov-déc) ; tubercules et vivaces tropicales à l'aise presque
/// toute l'année ; cultures de fraîcheur (choux-fleurs, fraise, petit
/// pois, alliacées à bulbe…) plus difficiles que la base — fenêtres
/// réduites au cœur de la grande saison sèche déc-fév.
const Map<String, ZoneMonths> guineanCalendar = <String, ZoneMonths>{
  // ── Cultures pluviales bimodales ────────────────────────────────────
  'mais': (sowingMonths: <int>[3, 4, 8, 9], harvestMonths: <int>[6, 7, 11, 12]),
  'arachide': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[6, 7, 11, 12]
  ),
  'niebe': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[5, 6, 11, 12]
  ),
  'haricot': (
    sowingMonths: <int>[3, 4, 9, 10],
    harvestMonths: <int>[5, 6, 11, 12]
  ),
  'haricot_beurre': (
    sowingMonths: <int>[3, 4, 9, 10],
    harvestMonths: <int>[5, 6, 11, 12]
  ),
  'gombo': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[5, 6, 7, 8, 11, 12, 1]
  ),
  'patate_douce': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[7, 8, 12, 1]
  ),
  'concombre': (
    sowingMonths: <int>[3, 4, 9, 10],
    harvestMonths: <int>[5, 6, 11, 12]
  ),
  'courge_butternut': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[6, 7, 11, 12]
  ),
  'potiron': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[6, 7, 11, 12]
  ),
  'potimarron': (
    sowingMonths: <int>[3, 4, 8, 9],
    harvestMonths: <int>[6, 7, 11, 12]
  ),

  // ── Légumes-feuilles tropicaux (cycles courts répétés) ──────────────
  'amarante': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[4, 5, 6, 7, 10, 11, 12]
  ),
  'celosie': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[4, 5, 6, 7, 10, 11, 12]
  ),
  'corete': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[5, 6, 7, 10, 11, 12]
  ),
  // Baselle : la chaleur humide côtière lui convient toute l'année.
  'baselle': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'basilic': (
    sowingMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'menthe': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),

  // ── Solanacées ──────────────────────────────────────────────────────
  // Tomate : fructification calée sur la grande saison sèche pour
  // limiter les maladies fongiques.
  'tomate': (sowingMonths: <int>[9, 10, 11], harvestMonths: <int>[12, 1, 2, 3]),
  'piment': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[6, 7, 8, 9, 12, 1, 2, 3]
  ),
  'aubergine': (
    sowingMonths: <int>[3, 4, 9, 10],
    harvestMonths: <int>[6, 7, 8, 12, 1, 2, 3]
  ),
  'aubergine_africaine': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[6, 7, 8, 9, 12, 1, 2]
  ),
  // Poivron : plus sensible que le piment à la chaleur humide.
  'poivron': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2]),
  // Pomme de terre : très difficile en basse altitude humide.
  'pomme_de_terre': (sowingMonths: <int>[11, 12], harvestMonths: <int>[2, 3]),

  // ── Tubercules et vivaces tropicales (zone de prédilection) ─────────
  // Igname : la ceinture de l'igname — plantation étalée dès février.
  'igname': (
    sowingMonths: <int>[2, 3, 4, 5],
    harvestMonths: <int>[11, 12, 1, 2]
  ),
  'manioc': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'taro': (
    sowingMonths: <int>[3, 4, 5, 6, 9],
    harvestMonths: <int>[10, 11, 12, 1, 2, 3]
  ),
  'gingembre': (
    sowingMonths: <int>[3, 4, 5, 6],
    harvestMonths: <int>[11, 12, 1, 2]
  ),
  'bananier_plantain': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'papayer': (
    sowingMonths: <int>[3, 4, 5, 6, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'moringa': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),
  'citronnelle': (
    sowingMonths: <int>[3, 4, 5, 9, 10],
    harvestMonths: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  ),

  // ── Cultures de fraîcheur : fenêtres réduites déc-fév ───────────────
  // Sans harmattan, la « saison fraîche » côtière reste chaude et
  // humide — ces cultures sont plus difficiles que dans la base.
  'chou_fleur': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2]),
  'brocoli': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2]),
  'fraise': (sowingMonths: <int>[11], harvestMonths: <int>[1, 2]),
  'petit_pois': (sowingMonths: <int>[11], harvestMonths: <int>[1, 2]),
  'pois_mange_tout': (sowingMonths: <int>[11], harvestMonths: <int>[1, 2]),
  'carotte': (sowingMonths: <int>[11, 12], harvestMonths: <int>[2, 3]),
  'laitue': (sowingMonths: <int>[11, 12, 1], harvestMonths: <int>[12, 1, 2, 3]),
  // Oignon et ail : la bulbaison exige un air sec absent de la côte.
  'oignon': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3]),
  'ail': (sowingMonths: <int>[11], harvestMonths: <int>[2, 3]),
  'poireau': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'radis': (sowingMonths: <int>[11, 12, 1], harvestMonths: <int>[12, 1, 2]),
  'epinard': (sowingMonths: <int>[11, 12], harvestMonths: <int>[12, 1, 2]),
  'chou_pomme': (
    sowingMonths: <int>[10, 11, 12],
    harvestMonths: <int>[1, 2, 3]
  ),
  'navet': (sowingMonths: <int>[11, 12], harvestMonths: <int>[1, 2]),
  'betterave': (sowingMonths: <int>[11, 12], harvestMonths: <int>[2, 3]),
  'coriandre': (sowingMonths: <int>[11, 12], harvestMonths: <int>[1, 2]),
  'melon': (sowingMonths: <int>[11, 12], harvestMonths: <int>[2, 3]),
  'pasteque': (sowingMonths: <int>[11, 12, 1], harvestMonths: <int>[2, 3, 4]),
};

/// Zone tropicale à hiver frais : mousson de juin à septembre, puis une
/// saison sèche et fraîche de novembre à mars. Plaine du Gange, nord du
/// Viêt Nam, nord de la Birmanie et de la Thaïlande.
///
/// ⚠️ **C'est la seule zone tropicale qui a un hiver**, et c'est tout
/// l'intérêt du fichier. Les huit autres zones n'en avaient pas : le
/// calendrier guinéen comme le soudanien ignoraient la saison où Hanoï
/// cultive son chou et où Delhi fait son *rabi*. Un jardinier de Delhi
/// lisait donc un calendrier qui passait sous silence la moitié de son
/// année agricole.
///
/// La logique est à deux saisons :
///
/// - le **rabi**, semé d'octobre à novembre et récolté de décembre à
///   mars : tous les légumes tempérés — choux, carotte, pois, pomme de
///   terre, oignon, épinard. Entre 8 et 20 °C, ils réussissent mieux
///   qu'en Europe ;
/// - le **kharif**, semé en juin-juillet avec les pluies et récolté de
///   septembre à novembre : gombo, aubergine, piment, maïs, niébé —
///   ce que la base soudanienne décrit déjà ;
/// - et pour quelques cucurbitacées, le **zaid** de février-mars,
///   récolté avant la mousson.
///
/// Les cultures absentes d'ici gardent la base soudanienne, qui leur
/// convient : elles n'ont pas de saison fraîche à exploiter.
const Map<String, ZoneMonths> coolWinterCalendar = <String, ZoneMonths>{
  // ── Rabi : les choux, qui n'existaient dans aucune zone tropicale ──
  'chou_pomme': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2]),
  'chou_fleur': (
    sowingMonths: <int>[8, 9, 10],
    harvestMonths: <int>[11, 12, 1, 2]
  ),
  'brocoli': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2]),
  'chou_kale': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2]),
  'chou_bruxelles': (sowingMonths: <int>[8, 9], harvestMonths: <int>[12, 1]),
  'chou_rave': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1]),
  'chou_chinois': (
    sowingMonths: <int>[9, 10],
    harvestMonths: <int>[11, 12, 1]
  ),
  'pak_choi': (
    sowingMonths: <int>[9, 10, 11],
    harvestMonths: <int>[11, 12, 1, 2]
  ),

  // ── Rabi : racines ──────────────────────────────────────────────────
  'carotte': (
    sowingMonths: <int>[9, 10, 11],
    harvestMonths: <int>[12, 1, 2, 3]
  ),
  'navet': (sowingMonths: <int>[9, 10], harvestMonths: <int>[11, 12, 1]),
  'radis': (
    sowingMonths: <int>[9, 10, 11, 12],
    harvestMonths: <int>[11, 12, 1, 2]
  ),
  'radis_noir': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1]),
  'betterave': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'rutabaga': (sowingMonths: <int>[9, 10], harvestMonths: <int>[1, 2]),
  'salsifis': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3]),
  'topinambour': (sowingMonths: <int>[10, 11], harvestMonths: <int>[3, 4]),

  // ── Rabi : légumineuses ─────────────────────────────────────────────
  'petit_pois': (sowingMonths: <int>[10, 11], harvestMonths: <int>[1, 2, 3]),
  'pois_mange_tout': (
    sowingMonths: <int>[10, 11],
    harvestMonths: <int>[1, 2, 3]
  ),
  'pois_chiche': (sowingMonths: <int>[10, 11], harvestMonths: <int>[3, 4]),
  'feve': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3]),
  'lentille': (sowingMonths: <int>[10, 11], harvestMonths: <int>[3, 4]),

  // ── Rabi : bulbes et tubercules ─────────────────────────────────────
  'pomme_de_terre': (
    sowingMonths: <int>[10, 11],
    harvestMonths: <int>[1, 2, 3]
  ),
  'oignon': (sowingMonths: <int>[10, 11], harvestMonths: <int>[3, 4, 5]),
  'ail': (sowingMonths: <int>[10, 11], harvestMonths: <int>[3, 4]),
  'echalote': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3]),
  'poireau': (sowingMonths: <int>[9, 10], harvestMonths: <int>[1, 2, 3]),

  // ── Rabi : feuilles ─────────────────────────────────────────────────
  'laitue': (
    sowingMonths: <int>[9, 10, 11, 12],
    harvestMonths: <int>[11, 12, 1, 2, 3]
  ),
  'mache': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1, 2]),
  'roquette': (sowingMonths: <int>[10, 11], harvestMonths: <int>[11, 12, 1]),
  'epinard': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1, 2]),
  'cresson': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1, 2]),
  'blette': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2, 3]),
  'celeri': (sowingMonths: <int>[9, 10], harvestMonths: <int>[1, 2]),
  'fenouil': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2]),
  'endive': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1]),
  'artichaut': (sowingMonths: <int>[9, 10], harvestMonths: <int>[2, 3]),

  // ── Rabi : aromates qui montent en graine dès la mousson ────────────
  'coriandre': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1, 2]),
  'persil': (sowingMonths: <int>[9, 10], harvestMonths: <int>[12, 1, 2, 3]),
  'aneth': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1]),
  'cerfeuil': (sowingMonths: <int>[10, 11], harvestMonths: <int>[12, 1]),
  'moutarde_blanche': (
    sowingMonths: <int>[10, 11],
    harvestMonths: <int>[12, 1]
  ),
  'fraise': (sowingMonths: <int>[10, 11], harvestMonths: <int>[2, 3, 4]),

  // ── Deux saisons : kharif de mousson, puis rabi ─────────────────────
  'tomate': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 1, 2, 3]
  ),
  'poivron': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 1, 2, 3]
  ),
  'piment': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 11, 2, 3]
  ),
  'aubergine': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 11, 1, 2, 3]
  ),
  'haricot': (
    sowingMonths: <int>[6, 7, 10, 11],
    harvestMonths: <int>[9, 10, 1, 2]
  ),

  // ── Zaid : les cucurbitacées de la saison sèche et chaude ───────────
  'concombre': (sowingMonths: <int>[2, 3, 6, 7], harvestMonths: <int>[4, 5, 8, 9]),
  'cornichon': (
    sowingMonths: <int>[2, 3, 6, 7],
    harvestMonths: <int>[5, 6, 9, 10]
  ),
  'courgette': (
    sowingMonths: <int>[2, 3, 6, 7],
    harvestMonths: <int>[4, 5, 8, 9]
  ),
  'melon': (sowingMonths: <int>[1, 2], harvestMonths: <int>[4, 5]),
  'pasteque': (sowingMonths: <int>[1, 2], harvestMonths: <int>[4, 5]),
  'potiron': (
    sowingMonths: <int>[2, 3, 6, 7],
    harvestMonths: <int>[6, 7, 10, 11]
  ),
  'courge_butternut': (
    sowingMonths: <int>[2, 3, 6, 7],
    harvestMonths: <int>[6, 7, 10, 11]
  ),
  'gombo': (sowingMonths: <int>[2, 3, 6, 7], harvestMonths: <int>[5, 6, 9, 10]),
};

/// Retourne la surcharge de zone pour une culture, ou null si la base
/// soudanienne convient.
ZoneMonths? zoneOverride(ClimateZone zone, String vegetableId) {
  switch (zone) {
    case ClimateZone.sahel:
      return sahelCalendar[vegetableId];
    case ClimateZone.guinean:
      return guineanCalendar[vegetableId];
    case ClimateZone.coolWinter:
      return coolWinterCalendar[vegetableId];
    // Les autres zones n'utilisent pas la base ouest-africaine, ou
    // s'en servent telle quelle (soudanien, altitude).
    default:
      return null;
  }
}
