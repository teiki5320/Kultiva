/// Conseils pour bien acheter semences, plants et boutures au marché
/// (Afrique de l'Ouest). Affichés dans la fiche légume en région AO,
/// à la place du lien d'achat Amazon (indisponible en AO).
class BuyingTip {
  /// Ce qu'on achète : 'graines', 'plants', 'semenceaux', 'boutures',
  /// 'rejets', 'éclats de touffe'…
  final String what;

  /// Conseil concret de sélection au marché, une à deux phrases.
  final String advice;

  const BuyingTip({required this.what, required this.advice});
}

const Map<String, List<BuyingTip>> marketBuyingTips = <String, List<BuyingTip>>{
  // ── Tubercules & racines (matériel de plantation) ──
  'igname': <BuyingTip>[
    BuyingTip(
      what: 'semenceaux',
      advice:
          "Choisis des semenceaux fermes de 200 à 400 g, sans taches noires ni pourriture. Un bon semenceau a une peau intacte et un « nombril » (tête) net ; écarte tout morceau ramolli ou déjà desséché.",
    ),
  ],
  'manioc': <BuyingTip>[
    BuyingTip(
      what: 'boutures',
      advice:
          "Prends des boutures de tige de 20 à 25 cm, prélevées au milieu d'une tige mûre et bien lignifiée (ni trop verte, ni trop âgée). Chaque bouture doit porter au moins 5 à 7 nœuds ; laisse de côté celles qui sont fendues, sèches ou couvertes de cochenilles blanches.",
    ),
  ],
  'patate_douce': <BuyingTip>[
    BuyingTip(
      what: 'boutures',
      advice:
          "Achète des boutures (lianes) de 25 à 30 cm avec 4 à 6 nœuds, coupées le matin sur des plants vigoureux. Prends-les bien vertes et fraîches, sans flétrissure, et plante-les vite : elles s'enracinent en quelques jours.",
    ),
  ],
  'taro': <BuyingTip>[
    BuyingTip(
      what: 'rejets',
      advice:
          "Choisis des rejets ou de petits cormes (tubercules) fermes, sans zones molles ni moisissure. Garde 15 à 20 cm de pétiole au-dessus du corme et une base à racines saines : c'est le gage d'une bonne reprise.",
    ),
  ],
  'bananier_plantain': <BuyingTip>[
    BuyingTip(
      what: 'rejets',
      advice:
          "Choisis des rejets « baïonnette » : jeunes pousses au feuillage encore effilé (lancéolé), issues d'un pied sain et productif. Ils reprennent mieux que les rejets à larges feuilles ; vérifie que le bulbe est ferme, sans galeries de charançons.",
    ),
  ],
  'pomme_de_terre': <BuyingTip>[
    BuyingTip(
      what: 'semenceaux',
      advice:
          "Prends des plants de semence de la taille d'un œuf, fermes et déjà pré-germés avec de petits germes trapus et verts. Évite les tubercules ridés, à longs germes blancs filés, ou vendus pour la consommation (souvent traités anti-germination).",
    ),
  ],
  'gingembre': <BuyingTip>[
    BuyingTip(
      what: 'rhizomes',
      advice:
          "Achète du gingembre frais et bien dodu, à peau tendue, portant des « yeux » (bourgeons) qui pointent déjà. Coupe-le en morceaux de 4 à 5 cm avec au moins un bourgeon chacun, laisse sécher la coupe un jour, puis plante ; évite les rhizomes ridés, mous ou moisis.",
    ),
  ],
  'citronnelle': <BuyingTip>[
    BuyingTip(
      what: 'éclats de touffe',
      advice:
          "La citronnelle se multiplie par éclats : prends une touffe avec des tiges bien vertes et surtout une base à racines vivantes. Une seule tige racinée reprend et fait une grosse touffe en quelques mois ; écarte les tiges sèches ou sans racines.",
    ),
  ],

  // ── Légumes-fruits (graines + plants de repiquage) ──
  'tomate': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines récentes (regarde la date sur le sachet) d'une variété qui aime la chaleur, comme Roma ou Mongal. En vrac, choisis un vendeur de confiance : des graines bien sèches, pleines et de couleur uniforme germent le mieux.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Si tu achètes des plants repiqués, choisis-les trapus (20 cm max), à tige épaisse et feuilles bien vertes. Fuis les plants filés, jaunis ou déjà en fleur dans un godet minuscule : ils peinent à redémarrer.",
    ),
  ],
  'piment': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines fraîches d'une variété locale bien piquante. Des graines trop vieilles germent lentement ; sème-les au chaud et sois patient, la levée peut prendre 2 à 3 semaines.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Prends de jeunes plants trapus et bien verts, à racines blanches non enroulées au fond du godet. Un plant court et ramifié produira plus qu'un plant haut et étiolé.",
    ),
  ],
  'poivron': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines récentes d'une variété tolérant la chaleur : le poivron germe lentement et aime le chaud. Sème en pépinière légèrement ombragée avant de repiquer.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Choisis un plant trapu à tige solide, feuilles vert foncé et racines saines. Évite les plants déjà chargés de fruits dans un petit godet, ils s'épuisent avant même d'être en terre.",
    ),
  ],
  'aubergine': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines fraîches : l'aubergine germe mieux au chaud (25 à 30 °C). En sachet, vérifie la date ; en vrac, préfère des graines pleines, sans poussière ni débris.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Repique des plants trapus de 10 à 15 cm, feuillage vert et racines saines. Fuis les plants filés ou tachés, plus fragiles au repiquage.",
    ),
  ],
  'aubergine_africaine': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Récupère les graines d'un beau fruit bien mûr (jaune-orangé) d'une variété locale comme le jaxatu ou le gboma. Les graines sèches se conservent bien ; garde celles issues des plants les plus sains et productifs.",
    ),
  ],
  'gombo': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis de grosses graines de gombo bien pleines, dures et de couleur uniforme, sans petits trous d'insectes. Prends-les de l'année (au-delà, la germination chute) et fais-les tremper une nuit avant de semer.",
    ),
  ],
  'pasteque': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis de grosses graines de pastèque bien pleines et sombres, sans fissure. Tu peux récupérer les graines d'un fruit bien mûr et sucré que tu as aimé : sèche-les soigneusement avant de les ranger.",
    ),
  ],
  'melon': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines de melon plates, pleines et claires. Petite astuce : le melon fructifie souvent mieux avec des graines de 2 ou 3 ans qu'avec des graines toutes fraîches — à condition qu'elles soient restées bien sèches et sans moisissure.",
    ),
  ],
  'concombre': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines de concombre plates et bien remplies, d'une variété adaptée à la chaleur. Récentes, elles lèvent en quelques jours ; conserve-les au sec, l'humidité les tue vite.",
    ),
  ],
  'courgette': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends de grosses graines de courgette bien pleines et fermes ; les plus lourdes donnent les plants les plus vigoureux. Deux ou trois graines par poquet suffisent, et sème directement en place.",
    ),
  ],

  // ── Légumes-feuilles & choux ──
  'laitue': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis une variété qui supporte la chaleur (batavia, feuille de chêne) et des graines récentes : la laitue lève mal quand la graine est vieille ou qu'il fait trop chaud. Sème à l'ombre légère en saison chaude.",
    ),
  ],
  'chou_pomme': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines récentes d'une variété tropicale (KK Cross, Oxylus). En vrac, méfie-toi des graines poussiéreuses : une graine de chou saine est ronde, dure et brun foncé.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Repique des plants trapus à 4 ou 5 vraies feuilles, tige courte et racines blanches. Évite les plants hauts et grêles, plus sensibles à la chaleur et aux chenilles.",
    ),
  ],
  'corete': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Pour la corète (mloukhiya, feuilles-gluantes), choisis des graines fraîches et bien sèches d'une variété à larges feuilles. Sème dense en pluie fine ; les graines de l'année lèvent nettement mieux.",
    ),
  ],
  'celosie': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "La célosie (feuille) a de toutes petites graines : prends-les fraîches et propres, sans trop de balle (débris). Sème en surface sans les enterrer, elles ont besoin de lumière pour germer.",
    ),
  ],
  'amarante': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "L'amarante a des graines minuscules : choisis un lot propre et bien sec, sans moisissure. Une pincée suffit pour un grand carré ; sème clair en surface et arrose en pluie fine pour ne pas les enfoncer.",
    ),
  ],
  'baselle': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "La baselle (épinard de Malabar) se sème facilement : prends des graines noires bien mûres et dures, et fais-les tremper une nuit car leur coque est épaisse.",
    ),
    BuyingTip(
      what: 'boutures',
      advice:
          "Encore plus simple : prends une bouture de tige de 15 à 20 cm sur un pied sain, elle s'enracine toute seule dans un sol humide.",
    ),
  ],
  'oseille': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Pour l'oseille, choisis des graines fraîches et bien sèches. C'est une culture facile et généreuse : sème clair, éclaircis, et un seul rang suffit à parfumer la sauce de toute la famille.",
    ),
  ],
  'persil': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Le persil germe lentement (2 à 3 semaines) et la graine vieillit vite : prends-la de l'année. Fais tremper les graines une nuit avant de semer pour accélérer la levée, et garde le sol frais.",
    ),
  ],
  'basilic': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines de basilic fraîches et propres, d'une variété qui aime la chaleur (le basilic africain, grand vert, prospère en AO). Sème en surface, à peine couvertes ; elles lèvent vite au chaud.",
    ),
  ],
  'menthe': <BuyingTip>[
    BuyingTip(
      what: 'boutures',
      advice:
          "La menthe se sème mal mais se bouture très facilement : prends une tige fraîche de 10 à 15 cm sur un pied sain, ôte les feuilles du bas et mets-la dans l'eau ou en terre humide. En une semaine, les racines apparaissent.",
    ),
  ],

  // ── Bulbes ──
  'oignon': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Pour l'oignon, préfère semer en pépinière plutôt qu'acheter des bulbes d'importation : c'est bien moins cher et mieux adapté. Choisis des graines très fraîches (Violet de Galmi par exemple) — elles perdent leur pouvoir germinatif en un an à peine.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "Si tu achètes des plants à repiquer, prends-les de la taille d'un crayon, ni trop gros ni filés, à racines fraîches ; repique-les rapidement pour éviter qu'ils sèchent.",
    ),
  ],

  // ── Racines potagères ──
  'carotte': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "La graine de carotte vieillit vite : prends-la de l'année et sème dense, tu éclairciras ensuite. Choisis une variété adaptée aux climats chauds (Nantaise, Amsterdam) et sème directement en place, la carotte n'aime pas le repiquage.",
    ),
  ],

  // ── Grandes cultures & légumineuses (attention aux semences traitées) ──
  'niebe': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines de niébé lisses, pleines et brillantes, sans petits trous ronds (signe de bruches). Un lot propre, sans poussière fine ni insectes, garde un bon taux de levée ; si les semences sont traitées (colorées), garde-les pour semer et ne les mange pas.",
    ),
  ],
  'arachide': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Achète l'arachide de semence en coques bien remplies ; décortique juste avant de semer et garde les grosses graines saines, sans moisissure ni germe cassé. Ne sème jamais des graines rances ou tachées de noir (aflatoxine), elles lèvent mal.",
    ),
  ],
  'mais': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des grains de semence gros et lourds, sans trous de charançon, d'une variété adaptée à ta saison des pluies. Des semences colorées (rose, rouge, vert) sont traitées au fongicide : elles germent mieux mais ne se mangent pas et ne se donnent pas aux animaux — réserve-les au semis.",
    ),
  ],
  'mil': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des épis ou des graines de mil bien pleins, d'une variété locale adaptée à la longueur de ta saison des pluies. Écarte les graines poussiéreuses ou grignotées ; si les semences sont traitées (colorées), garde-les pour semer, jamais pour la cuisine.",
    ),
  ],
  'sorgho': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Prends des graines de sorgho grosses, saines et de couleur homogène, sans moisissure. Une variété locale éprouvée germe et résiste mieux ; méfie-toi des graines traitées (colorées), destinées au semis et non à l'assiette.",
    ),
  ],
  'fonio': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "La graine de fonio est minuscule : choisis un lot très propre, bien vanné, sans sable ni balle. Prends-le auprès d'un producteur de confiance et sème à la volée sur sol bien affiné, la levée est fine et fragile.",
    ),
  ],
  'sesame': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines de sésame de l'année, propres, sèches et de couleur uniforme (claires ou noires selon la variété). Très fines, un petit sachet suffit ; vieilles, elles rancissent et lèvent mal.",
    ),
  ],
  'bissap': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Pour le bissap (oseille de Guinée, hibiscus), prends des graines réniformes brun foncé, dures et pleines, sans trous d'insectes. Les graines de l'année lèvent vite ; choisis la variété selon l'usage — calices rouges pour la boisson, feuilles pour la sauce.",
    ),
  ],

  // ── Arbres & vivaces multipliés au marché ──
  'moringa': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Choisis des graines de moringa fraîches, à coque beige et ailée, bien pleines (secoue-les : une graine vide sonne creux). Fraîches, elles germent en une semaine ; elles perdent vite leur pouvoir germinatif, alors évite les vieux stocks.",
    ),
    BuyingTip(
      what: 'boutures',
      advice:
          "Tu peux aussi prendre une bouture de branche dure d'environ 1 m : plantée directement, elle donne vite un arbre (mais aux racines moins profondes qu'un semis).",
    ),
  ],
  'papayer': <BuyingTip>[
    BuyingTip(
      what: 'graines',
      advice:
          "Récupère les graines noires d'une papaye bien mûre et savoureuse ; rince-les pour ôter la pulpe et sème-les fraîches, elles lèvent d'autant mieux. Sème plusieurs pieds pour pouvoir garder les femelles ou hermaphrodites, les plus productifs.",
    ),
    BuyingTip(
      what: 'plants',
      advice:
          "En pépinière, choisis de jeunes plants en sachet, trapus et bien verts, au pivot non spiralé. Repique-les jeunes (20 à 30 cm) : le papayer déteste qu'on abîme ses racines.",
    ),
  ],
};
