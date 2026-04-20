/// Lexique des termes de jardinage utilisés dans Kultiva.
///
/// Ajoute un mot à `lexicon` pour qu'il apparaisse automatiquement souligné
/// dans les textes wrappés avec `LexiconText`. Les clés sont en minuscules,
/// sans accent pour faciliter la correspondance.
class LexiconEntry {
  final String term;
  final String definition;
  const LexiconEntry(this.term, this.definition);
}

const List<LexiconEntry> lexicon = <LexiconEntry>[
  LexiconEntry(
    'solanacées',
    "Famille botanique qui regroupe tomate, aubergine, poivron, piment, pomme de terre. Tous ces légumes sont sensibles au mildiou et partagent souvent les mêmes maladies — d'où la règle de rotation qui déconseille de les replanter au même endroit avant 3-4 ans.",
  ),
  LexiconEntry(
    'rotation',
    "Changer chaque année l'emplacement des familles de légumes pour éviter que le sol ne s'épuise et que les maladies ne s'installent. Règle générale : attendre 3 à 4 ans avant de replanter la même famille au même endroit.",
  ),
  LexiconEntry(
    'compagnonnage',
    "Associer des plantes qui s'entraident : certaines repoussent les parasites de leurs voisines, d'autres enrichissent le sol ou attirent les pollinisateurs. Exemple classique : carotte + poireau.",
  ),
  LexiconEntry(
    'mildiou',
    "Maladie fongique qui apparaît par temps humide et tiède. Provoque des taches brunes sur les feuilles et pourrit les fruits. Touche surtout tomates, pommes de terre, vignes. Traitement bio : bouillie bordelaise, aération des plants et arrosage au pied.",
  ),
  LexiconEntry(
    'bouillie bordelaise',
    "Fongicide à base de sulfate de cuivre et de chaux, autorisé en agriculture biologique. Utilisée contre le mildiou et d'autres maladies cryptogamiques. À doser avec modération — le cuivre s'accumule dans le sol.",
  ),
  LexiconEntry(
    'paillage',
    "Couvrir le sol au pied des plants avec de la matière organique (paille, feuilles mortes, tontes séchées). Garde l'humidité, limite les mauvaises herbes et nourrit le sol en se décomposant.",
  ),
  LexiconEntry(
    'compost',
    "Terreau obtenu par décomposition naturelle des déchets de cuisine et du jardin. Améliore la structure du sol, nourrit les plantes, et se produit en 6 à 12 mois.",
  ),
  LexiconEntry(
    'repiquage',
    "Transplanter un jeune plant de l'endroit où il a germé vers sa place définitive au potager. À faire quand le plant a 4-6 vraies feuilles, de préférence en soirée pour limiter le stress hydrique.",
  ),
  LexiconEntry(
    'levée',
    "Moment où la graine sort de terre et développe ses premières feuilles (cotylédons). Durée variable selon l'espèce (radis : 3-5 jours, carotte : 15-20 jours).",
  ),
  LexiconEntry(
    'éclaircissage',
    "Supprimer les jeunes plants en surnombre pour laisser aux restants l'espace, la lumière et les nutriments nécessaires. À faire dès que les plants ont 2-3 vraies feuilles.",
  ),
  LexiconEntry(
    'buttage',
    "Ramener de la terre au pied des plants pour former une petite butte. Favorise l'enracinement (tomates), protège les tubercules de la lumière (pommes de terre) ou améliore le drainage.",
  ),
  LexiconEntry(
    'vivace',
    "Plante qui vit plusieurs années, au contraire d'une annuelle (cycle complet en une saison). Exemples au potager : rhubarbe, artichaut, asperge, ciboulette.",
  ),
  LexiconEntry(
    'annuelle',
    "Plante qui accomplit tout son cycle (germination, floraison, production de graines, mort) en une seule année. La plupart des légumes sont annuels : tomate, courgette, laitue.",
  ),
  LexiconEntry(
    'bisannuelle',
    "Plante dont le cycle s'étale sur deux ans : la première année, elle développe ses feuilles et racines, la seconde elle fleurit et produit des graines. Exemples : carotte, betterave, oignon porte-graine.",
  ),
  LexiconEntry(
    'godet',
    "Petit pot individuel (souvent en plastique ou tourbe) pour faire germer et élever un jeune plant avant de le repiquer en pleine terre. Taille typique : 7 à 10 cm.",
  ),
  LexiconEntry(
    'terreau',
    "Substrat cultivé prêt à l'emploi, mélange de matière organique décomposée, de fibres et parfois de minéraux. À distinguer de la terre du jardin : il est plus léger, plus riche et plus stérile.",
  ),
  LexiconEntry(
    'hors-gel',
    "Période sans risque de gelée nocturne. En France, on parle souvent de \"saints de glace\" (mi-mai) comme repère pour planter les légumes fragiles (tomate, courgette) dehors.",
  ),
  LexiconEntry(
    'semis direct',
    "Semer directement les graines en pleine terre, sans passer par un semis en godet. Idéal pour radis, carottes, haricots et toutes les plantes qui n'aiment pas être repiquées.",
  ),
  LexiconEntry(
    'drainage',
    "Capacité du sol à évacuer l'excès d'eau. Un bon drainage évite que les racines pourrissent. On l'améliore avec du sable grossier, des billes d'argile ou en travaillant la terre en profondeur.",
  ),
  LexiconEntry(
    'pollinisateurs',
    "Insectes (abeilles, bourdons, papillons, syrphes) qui transportent le pollen d'une fleur à l'autre et permettent aux plantes de produire des fruits et graines. Essentiels au potager — à protéger absolument.",
  ),

  // ─── Familles botaniques ─────────────────────────────────────────
  LexiconEntry(
    'cucurbitacées',
    "Famille des courges, courgettes, potirons, concombres, melons et pastèques. Elles adorent la chaleur, le soleil et un sol riche en compost. Attention à l'oïdium en fin d'été.",
  ),
  LexiconEntry(
    'brassicacées',
    "Famille des choux : chou-fleur, brocoli, chou pommé, kale, mais aussi radis, navet, roquette. Gros appétit en azote et sensibles à la hernie du chou — rotation longue conseillée (5-7 ans).",
  ),
  LexiconEntry(
    'fabacées',
    "Famille des haricots, pois, fèves, lentilles. Leur super-pouvoir : elles fixent l'azote de l'air dans le sol grâce à leurs racines, et enrichissent donc naturellement la terre pour la culture suivante.",
  ),
  LexiconEntry(
    'légumineuses',
    "Autre nom des fabacées : haricots, pois, fèves, lentilles. Elles enrichissent le sol en azote et sont indispensables dans la rotation des cultures.",
  ),
  LexiconEntry(
    'apiacées',
    "Famille des carottes, persil, céleri, fenouil, aneth, cerfeuil. Partagent les mêmes ravageurs (mouche de la carotte) — associées à l'oignon ou au poireau qui les repoussent.",
  ),
  LexiconEntry(
    'liliacées',
    "Famille des oignons, ail, échalotes, poireaux, ciboulette. Bons compagnons pour beaucoup de légumes grâce à leur odeur répulsive contre certains insectes.",
  ),
  LexiconEntry(
    'astéracées',
    "Famille des salades (laitue, scarole, chicorée), de l'artichaut et du pissenlit. Se reconnaissent à leurs fleurs en capitule (comme les marguerites).",
  ),

  // ─── Techniques de jardinage ─────────────────────────────────────
  LexiconEntry(
    'pincement',
    "Couper avec les ongles l'extrémité d'une tige pour stopper sa croissance en hauteur et forcer la plante à se ramifier. Très utilisé sur le basilic et pour retirer les gourmands des tomates.",
  ),
  LexiconEntry(
    'tuteurage',
    "Soutenir une plante à l'aide d'un bambou, d'un tuteur ou d'un treillis. Indispensable pour les tomates, concombres, haricots à rames : la plante reste droite, bien aérée et les fruits restent propres.",
  ),
  LexiconEntry(
    'palissage',
    "Guider et attacher une plante grimpante ou une branche le long d'un support (fil, treillis, mur). Économise la place et expose mieux les feuilles au soleil.",
  ),
  LexiconEntry(
    'stratification',
    "Exposer des graines au froid (congélateur ou hiver) pendant quelques semaines pour lever leur dormance et déclencher la germination. Imite le cycle naturel des saisons — utile pour les arbres fruitiers et certaines fleurs.",
  ),
  LexiconEntry(
    'engrais vert',
    "Plantes semées pour enrichir et protéger le sol entre deux cultures (moutarde, phacélie, trèfle). On les fauche et enfouit avant qu'elles montent en graine : elles libèrent azote et matière organique.",
  ),
  LexiconEntry(
    "purin d'ortie",
    "Macération d'orties dans de l'eau pendant 1 à 2 semaines. Dilué à 10 %, c'est un excellent engrais liquide riche en azote. Odeur forte mais très efficace !",
  ),
  LexiconEntry(
    'binage',
    "Gratter la surface du sol avec une binette pour casser la croûte, aérer la terre et arracher les mauvaises herbes naissantes. Dicton : \"un binage vaut deux arrosages\".",
  ),
  LexiconEntry(
    'sarclage',
    "Arracher ou couper les mauvaises herbes à la main ou au sarcloir, pour qu'elles n'étouffent pas les cultures et ne prennent pas l'eau.",
  ),
  LexiconEntry(
    'gourmand',
    "Petite pousse qui apparaît à l'aisselle d'une feuille, surtout sur les tomates. On les pince pour que la plante concentre son énergie sur les fruits plutôt que sur la végétation.",
  ),
  LexiconEntry(
    'bouturage',
    "Multiplier une plante en coupant un fragment de tige qu'on fait ensuite raciner dans l'eau ou dans du terreau. Très facile avec la menthe, le basilic, le géranium.",
  ),
  LexiconEntry(
    'amendement',
    "Matière ajoutée au sol pour améliorer sa structure durablement (compost, fumier, sable pour un sol lourd, chaux pour un sol acide). Différent de l'engrais qui nourrit directement la plante.",
  ),
  LexiconEntry(
    'pré-germination',
    "Faire germer les graines avant de les semer, par exemple entre deux feuilles de papier humide. Accélère la levée et permet de ne semer que les graines viables.",
  ),

  // ─── Maladies & nuisibles ────────────────────────────────────────
  LexiconEntry(
    'oïdium',
    "Maladie fongique en \"poudre blanche\" qui recouvre les feuilles par temps sec et chaud. Touche surtout courgettes, concombres, rosiers. Traiter avec du lait dilué ou du bicarbonate dès les premiers symptômes.",
  ),
  LexiconEntry(
    'rouille',
    "Champignon qui forme de petits points orangés ou bruns sous les feuilles. Favorisé par l'humidité. Arrose au pied, aère les plants et retire les feuilles atteintes.",
  ),
  LexiconEntry(
    'fumagine',
    "Dépôt noirâtre qui s'installe sur les feuilles après une attaque de pucerons ou cochenilles — elles excrètent un miellat sucré sur lequel ce champignon se développe.",
  ),
  LexiconEntry(
    'pourriture grise',
    "Aussi appelée botrytis : duvet gris qui s'installe sur feuilles, tiges et fruits par temps humide. Retire les parties atteintes et aère la culture.",
  ),
  LexiconEntry(
    'cloque',
    "Maladie du pêcher et du nectarinier : les jeunes feuilles se boursouflent et deviennent rouges au printemps. Traiter préventivement à la bouillie bordelaise avant l'ouverture des bourgeons.",
  ),
  LexiconEntry(
    'fonte des semis',
    "Les jeunes plants s'effondrent brusquement au niveau du collet à cause d'un champignon. Souvent dû à un excès d'humidité — aère bien et arrose avec parcimonie.",
  ),
  LexiconEntry(
    'chlorose',
    "Jaunissement des feuilles alors que les nervures restent vertes. Signe d'une carence en fer (souvent sur sol calcaire). Corrige avec un apport de chélate de fer ou de compost.",
  ),
  LexiconEntry(
    'doryphore',
    "Gros coléoptère rayé jaune et noir, bien connu comme nuisible n°1 de la pomme de terre. Les larves rose-orange dévorent le feuillage. Ramassage à la main = méthode la plus efficace.",
  ),
  LexiconEntry(
    'altise',
    "Minuscule insecte noir sauteur qui perce de petits trous dans les feuilles de radis, choux, roquette. Maintenir le sol humide et couvrir avec un filet anti-insectes les décourage.",
  ),
  LexiconEntry(
    'cochenille',
    "Insecte écailleux (blanc, brun ou noir) collé aux tiges et feuilles, où il suce la sève. Traite au savon noir ou avec un coton imbibé d'alcool.",
  ),
  LexiconEntry(
    'carpocapse',
    "Papillon dont la chenille creuse les fruits à pépins (pommes, poires) — c'est le fameux \"ver de la pomme\". Pose des pièges à phéromones au printemps pour limiter les dégâts.",
  ),

  // ─── Plantes & botanique ─────────────────────────────────────────
  LexiconEntry(
    'cotylédon',
    "Les toutes premières \"fausses feuilles\" qui sortent de la graine lors de la germination. Elles sont lisses et différentes des vraies feuilles qui suivent — repère clé pour savoir quand repiquer.",
  ),
  LexiconEntry(
    'plantule',
    "Très jeune plant qui vient de lever : il a juste ses cotylédons ou ses toutes premières vraies feuilles. Encore fragile, à bichonner.",
  ),
  LexiconEntry(
    'collet',
    "Zone de jonction entre la racine et la tige, juste au ras du sol. Très sensible à la pourriture : ne jamais enfouir ou pailler directement dessus.",
  ),
  LexiconEntry(
    'motte',
    "Bloc de terre qui entoure les racines d'un plant quand tu le sors de son godet. On repique toujours avec sa motte pour ne pas traumatiser les racines.",
  ),
  LexiconEntry(
    'stolon',
    "Longue tige rampante qui sort de la plante mère et crée un nouveau plant au sol. Le fraisier en est le champion : un pied peut en produire 10 en une saison !",
  ),
  LexiconEntry(
    'tubercule',
    "Réserve souterraine charnue qui stocke l'énergie de la plante. Pomme de terre, topinambour, patate douce sont des tubercules.",
  ),
  LexiconEntry(
    'bulbe',
    "Organe souterrain arrondi formé d'écailles serrées autour d'un bourgeon central. Oignon, ail, échalote, tulipe, narcisse sont des bulbes.",
  ),
  LexiconEntry(
    'rhizome',
    "Tige souterraine qui pousse horizontalement et produit des racines et des tiges aériennes. Gingembre, menthe, bambou se propagent par rhizomes.",
  ),
  LexiconEntry(
    'rustique',
    "Plante qui résiste au froid et au gel sans protection. Chou kale, poireau, mâche, épinard sont rustiques. À l'inverse, tomate ou basilic sont non rustiques.",
  ),
  LexiconEntry(
    'montée en graine',
    "Quand une plante passe en mode reproduction et fabrique une tige florale. Pour les légumes-feuilles (salade, épinard), c'est la fin de la récolte : les feuilles deviennent dures et amères.",
  ),
  LexiconEntry(
    'npk',
    "Les trois éléments essentiels à toute plante, affichés sur les engrais. N = azote (feuilles vertes), P = phosphore (racines et fleurs), K = potassium (fruits et résistance).",
  ),

  // ─── Sol & environnement ─────────────────────────────────────────
  LexiconEntry(
    'humus',
    "Couche supérieure sombre du sol, issue de la décomposition des matières organiques. C'est la partie la plus fertile et la plus vivante — l'objectif à nourrir avec le compost et le paillage.",
  ),
  LexiconEntry(
    'ph du sol',
    "Mesure l'acidité ou l'alcalinité du sol, de 0 à 14. Neutre = 7. La plupart des légumes préfèrent un pH entre 6,5 et 7,5 (légèrement acide à neutre). Des bandelettes en jardinerie permettent de le tester.",
  ),
  LexiconEntry(
    'mi-ombre',
    "Emplacement qui reçoit 3 à 5 heures de soleil direct par jour, ou un soleil filtré. Idéal pour les salades, épinards, mâche, menthe — qui grillent en plein soleil l'été.",
  ),
  LexiconEntry(
    'saints de glace',
    "Période du 11 au 13 mai, traditionnellement les dernières gelées en France. Avant cette date, on évite de sortir les légumes fragiles (tomate, courgette, basilic). Après = place libre !",
  ),

  // ─── Spécifique app Kultiva ──────────────────────────────────────
  LexiconEntry(
    'tamassi',
    "Ta créature virtuelle liée à ton potager dans Kultiva. Arrose-la, dis-lui bonjour, relève des défis : elle gagne de l'XP, monte de niveau et finit par évoluer en nouvelle forme !",
  ),
  LexiconEntry(
    'poussidex',
    "Ton \"Pokédex\" de jardinier dans Kultiva : collection de badges, défis photo et statistiques qui retracent tout ton parcours au potager.",
  ),
  LexiconEntry(
    'starter',
    "La toute première espèce de Tamassi que tu choisis au démarrage de l'app. Elle reste ton compagnon principal à cultiver au fil des jours.",
  ),
  LexiconEntry(
    'shiny',
    "Médaille et version \"légendaire\" d'un badge ou d'un Tamassi : la plus rare, la plus brillante. Obtenue après de longues séries d'actions parfaites !",
  ),
  LexiconEntry(
    'défi',
    "Mini-quête photo à réaliser dans Kultiva (photographier un semis, une récolte, une fleur…). Chaque défi réussi rapporte de l'XP et fait progresser vers un badge.",
  ),
  LexiconEntry(
    'streak',
    "Nombre de jours consécutifs où tu ouvres l'app. Plus la streak est longue, plus certains badges se débloquent (Régulier, Fidèle, Vétéran).",
  ),
];

/// Normalise un mot pour la recherche dans le lexique : minuscules et sans
/// accents simples. Permet d'ignorer la casse et les variations diacritiques.
String _normalize(String s) {
  return s
      .toLowerCase()
      .replaceAll(RegExp(r'[àâä]'), 'a')
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[îï]'), 'i')
      .replaceAll(RegExp(r'[ôö]'), 'o')
      .replaceAll(RegExp(r'[ûüù]'), 'u')
      .replaceAll('ç', 'c');
}

/// Cherche une entrée par terme (matching insensible à la casse / aux accents).
LexiconEntry? lookupLexicon(String term) {
  final needle = _normalize(term);
  for (final e in lexicon) {
    if (_normalize(e.term) == needle) return e;
  }
  return null;
}
