/// Le mode d'emploi d'un accessoire du catalogue.
///
/// ⚠️ Pourquoi un fichier à part et non cinq champs sur `Vegetable` :
/// les 130 cultures n'ont que faire d'un « combien il en faut pour un
/// carré », et le modèle porte déjà vingt champs. C'est le patron de
/// `local_names.dart`, `market_data.dart` et `market_buying_tips.dart` —
/// du contenu qui ne concerne qu'un sous-ensemble vit dans sa propre
/// table, keyée par l'identifiant du catalogue.
///
/// ⚠️ Ce que les fiches disaient avant le 02/11/2026 : un nom, un
/// emoji, une ligne de note et deux phrases de description. Pas de
/// calendrier, pas de maladies, pas de recettes — les 39 fiches
/// d'accessoires étaient donc les plus vides de l'app, remarque de
/// Jean. Un accessoire n'a pas de saison de semis, mais il a un moment,
/// un geste, une quantité et un entretien.
///
/// Les cinq champs sont du texte français, traduit par le
/// dictionnaire de `content_i18n.dart` comme les maladies et le
/// lexique. Les nombres qu'ils portent sont des doses et des
/// dimensions : un test vérifie qu'une traduction ne les change pas.
library;

class AccessoryGuide {
  /// Le moment de l'année, ou du cycle d'une culture, où il sert.
  final String when;

  /// Le geste. Ce qu'on fait, et la faute qu'on fait sans le savoir.
  final String how;

  /// Combien il en faut, à l'échelle d'un carré de 1,20 m.
  final String howMuch;

  /// Entretien, rangement, durée de vie.
  final String care;

  /// Ce qu'on peut fabriquer à la place. `null` quand il n'y a pas
  /// d'équivalent honnête — on ne forge pas un sécateur.
  final String? diy;

  const AccessoryGuide({
    required this.when,
    required this.how,
    required this.howMuch,
    required this.care,
    this.diy,
  });
}

/// Le mode d'emploi de chaque accessoire, par identifiant du catalogue.
const Map<String, AccessoryGuide> accessoryGuides = <String, AccessoryGuide>{
  // ─────────────────────────────── Outils ───────────────────────────────
  'acc_arrosoir': AccessoryGuide(
    when: 'Toute l\'année, et deux fois par jour en canicule.',
    how: 'Arrose au pied, jamais sur les feuilles : l\'eau sur le '
        'feuillage appelle le mildiou. Retire la pomme pour les plants '
        'installés, remets-la pour les jeunes semis que le jet '
        'déchausserait.',
    howMuch: 'Un arrosoir de 10 L couvre deux carrés de 1,20 m. En '
        'dessous de 5 L, tu feras trois allers-retours.',
    care: 'Vide-le avant l\'hiver : l\'eau qui gèle dedans fend le '
        'plastique. Rince la pomme, le calcaire la bouche trou par trou.',
  ),
  'acc_binette': AccessoryGuide(
    when: 'D\'avril à septembre, deux ou trois jours après chaque pluie.',
    how: 'Gratte les deux premiers centimètres quand la surface est '
        'sèche : tu casses la croûte et tu coupes les herbes au collet. '
        'Jamais plus profond — tu abîmerais les racines de ce que tu '
        'veux garder.',
    howMuch: 'Une seule. Un fer de 14 cm passe entre les rangs d\'un '
        'carré, un fer large ne passe nulle part.',
    care: 'Affûte le fer deux fois par saison et graisse le manche à '
        'l\'huile de lin.',
  ),
  'acc_etiquettes': AccessoryGuide(
    when: 'Au semis, avant d\'oublier — c\'est-à-dire tout de suite.',
    how: 'Écris le nom et la date, au crayon de papier : le feutre '
        's\'efface au soleil en trois semaines. Plante l\'étiquette au '
        'nord du rang, elle ne fera pas d\'ombre.',
    howMuch: 'Une par variété, pas par plant. Une vingtaine couvre un '
        'potager de quatre carrés.',
    care: 'Lave-les en fin de saison : elles se réécrivent des années.',
    diy: 'Des bandes découpées dans un pot de yaourt et un crayon de '
        'papier font exactement le même travail.',
  ),
  'acc_gants': AccessoryGuide(
    when: 'Pour la ronce, le rosier, le compost et tout ce qui pique.',
    how: 'Enlève-les pour semer et repiquer : les doigts nus sentent '
        'si la motte est assez humide, les gants l\'écrasent.',
    howMuch: 'Une paire enduite pour le gros œuvre, une paire fine pour '
        'la récolte. Deux paires, pas une.',
    care: 'Sèche-les à l\'ombre et à plat. Au soleil, l\'enduit '
        'craquelle en une saison.',
  ),
  'acc_grelinette': AccessoryGuide(
    when: 'En février-mars avant les semis, et en octobre avant l\'hiver.',
    how: 'Plante les dents, recule d\'un pas en basculant le manche '
        'vers toi : la terre se soulève et se fissure sans être '
        'retournée. Les couches du sol restent dans l\'ordre, et la vie '
        'qui les habite avec.',
    howMuch: 'Une grelinette à 4 dents suffit pour des carrés ; la '
        '5 dents est faite pour la pleine terre.',
    care: 'Brosse la terre des dents et passe un chiffon huilé avant de '
        'la ranger.',
  ),
  'acc_panier_recolte': AccessoryGuide(
    when: 'Du premier radis à la dernière courge.',
    how: 'Récolte le matin, avant que le soleil ne fasse transpirer les '
        'feuilles : les salades tiennent deux jours de plus. Ne tasse '
        'pas, les tomates du fond s\'écrasent sous le reste.',
    howMuch: 'Un panier de 10 L porte une récolte de courgettes. '
        'Au-delà, c\'est la cagette.',
    care: 'Rince-le et sèche-le à l\'ombre, surtout s\'il est en osier.',
    diy: 'Une cagette à fruits du marché fait l\'affaire, et elle '
        's\'empile.',
  ),
  'acc_plantoir': AccessoryGuide(
    when: 'D\'octobre à décembre pour l\'ail, l\'oignon et l\'échalote.',
    how: 'Enfonce, tourne d\'un quart de tour, retire : tu emportes une '
        'carotte de terre. Pose le bulbe pointe en haut au fond du trou '
        'et rebouche avec la terre prélevée.',
    howMuch: 'Un seul. La profondeur se règle à trois fois la hauteur '
        'du bulbe.',
    care: 'Essuie-le après usage : il rouille là où la peinture part.',
  ),
  'acc_secateur': AccessoryGuide(
    when: 'Toute l\'année : tailler, récolter, couper les gourmands.',
    how: 'Désinfecte la lame à l\'alcool entre deux plants quand l\'un '
        'est malade, sinon tu transportes le virus d\'un pied à '
        'l\'autre. Coupe en biais, juste au-dessus d\'un œil.',
    howMuch: 'Un seul, mais un dont les lames se remplacent : c\'est ce '
        'qui fait la différence entre dix ans et deux.',
    care: 'Essuie la sève après chaque usage, affûte une fois par mois, '
        'huile l\'axe.',
  ),
  'acc_transplantoir': AccessoryGuide(
    when: 'Au repiquage, de mars à juin.',
    how: 'Creuse plus large que la motte, pose, rebouche et tasse à la '
        'main avant d\'arroser. Ne tire jamais un plant par la tige : '
        'glisse la lame dessous et soulève la motte entière.',
    howMuch: 'Un seul. Le modèle gradué évite de deviner la profondeur.',
    care: 'Le manche en bois se fend s\'il passe l\'hiver dehors.',
  ),
  'acc_tuteur': AccessoryGuide(
    when: 'À la plantation — pas quand le plant penche. À ce '
        'moment-là, les racines occupent déjà la place du tuteur.',
    how: 'Plante le tuteur d\'abord, le plant ensuite, à 5 cm. Attache '
        'en huit avec un lien souple, sans serrer : la tige va grossir.',
    howMuch: 'Un par pied de tomate, trois par poquet de haricots '
        'grimpants.',
    care: 'Brosse et laisse sécher en fin de saison : les champignons '
        'passent l\'hiver dans le bois.',
    diy: 'Une branche de noisetier ou de châtaignier coupée en hiver '
        'tient trois saisons.',
  ),

  // ────────────────────────────── Structures ─────────────────────────────
  'acc_arche': AccessoryGuide(
    when: 'Au printemps, avant que les coureuses ne partent au sol.',
    how: 'Plante deux pieds de courge ou de haricot d\'Espagne de '
        'chaque côté et guide les premières tiges à la main : ensuite '
        'elles s\'accrochent seules. Les fruits suspendus restent '
        'propres et poussent droits.',
    howMuch: 'Une arche de 2 m de large nourrit quatre pieds grimpants '
        'et libère autant de surface au sol.',
    care: 'Ancre-la ou démonte-la avant les coups de vent d\'automne : '
        'couverte de feuilles, elle fait voile.',
    diy: 'Deux panneaux de treillis à béton cintrés et liés font une '
        'arche solide pour trois fois moins.',
  ),
  'acc_carre_potager': AccessoryGuide(
    when: 'Au montage du jardin, idéalement en février-mars.',
    how: 'Pose-le sur du carton brun, pas sur une bâche : le carton '
        'étouffe l\'herbe puis disparaît, et les vers remontent du sol. '
        'Remplis en couches — branches, tontes, compost, terreau en '
        'surface.',
    howMuch: '1,20 m de côté, pas plus : c\'est la portée de deux bras, '
        'et tu ne marcheras jamais dedans.',
    care: 'Huile l\'intérieur à l\'huile de lin tous les deux ans. '
        'Jamais de produit de traitement : il migre dans la terre.',
    diy: 'Quatre planches de douglas non traité de 27 mm, vissées aux '
        'angles sur des tasseaux.',
  ),
  'acc_chassis': AccessoryGuide(
    when: 'De février à avril, puis de septembre à novembre.',
    how: 'Oriente la pente au sud et ouvre dès que le soleil tape : '
        'il fait 15 °C de plus à l\'intérieur, et des semis cuisent en '
        'une heure. Referme avant le coucher du soleil.',
    howMuch: 'Un châssis de 1 m² abrite les semis de tout un potager de '
        'quatre carrés.',
    care: 'Lave le vitrage chaque automne : 20 % de lumière en plus '
        'pour un coup d\'éponge.',
    diy: 'Une vieille fenêtre posée sur un cadre de planches fait un '
        'châssis parfait.',
  ),
  'acc_cloche': AccessoryGuide(
    when: 'Les deux semaines qui suivent un repiquage précoce, et sur '
        'les derniers plants d\'automne.',
    how: 'Pose-la le soir, retire-la le matin si le soleil donne. '
        'Enfonce le bord d\'un centimètre dans la terre, sinon le vent '
        'la promène dans le jardin.',
    howMuch: 'Une par plant précoce. Quatre ou cinq suffisent — ce n\'est '
        'pas une couverture, c\'est une avance.',
    care: 'Range-les emboîtées à l\'abri : le plastique devient cassant '
        'après un hiver au gel.',
    diy: 'Une bouteille d\'eau de 5 L coupée, goulot laissé ouvert pour '
        'que l\'air circule.',
  ),
  'acc_rames_bambou': AccessoryGuide(
    when: 'En avril-mai, au semis des haricots et des pois grimpants.',
    how: 'Plante trois rames en tipi, liées en haut, et sème quatre '
        'grains au pied de chacune. Un tipi encaisse le vent qu\'un '
        'rang droit prend de plein fouet.',
    howMuch: 'Une rame de 1,80 m pour trois pieds. Neuf rames font un '
        'carré de haricots.',
    care: 'Rentre-les sèches et debout : couchées à terre tout l\'hiver, '
        'elles pourrissent par le bas.',
    diy: 'Le bambou se coupe en janvier dans n\'importe quelle haie qui '
        'en porte, et sèche deux mois à l\'abri.',
  ),
  'acc_serre_tunnel': AccessoryGuide(
    when: 'De mars à mai, puis de septembre aux premières gelées.',
    how: 'Tends la bâche sans pli : un pli retient l\'eau, et le poids '
        'déchire l\'arceau. Laisse les deux bouts ouverts par beau '
        'temps, sinon l\'air stagnant fait pourrir les salades.',
    howMuch: 'Un tunnel de 3 m couvre deux carrés mis bout à bout.',
    care: 'Replie la bâche sèche à l\'automne. Rangée mouillée, '
        'elle moisit en un hiver.',
    diy: 'Des arceaux en tuyau PER et une bâche de 100 microns clipsée '
        'rendent le même service.',
  ),
  'acc_table_culture': AccessoryGuide(
    when: 'Toute l\'année. C\'est d\'abord un choix de dos.',
    how: 'Remplis sur 25 cm au minimum : en dessous, la terre sèche en '
        'une demi-journée d\'été. Place-la à l\'est, le soleil du matin '
        'suffit aux salades et ne les brûle pas.',
    howMuch: 'Une table de 80 × 40 cm tient dix salades, ou un rang de '
        'radis qu\'on renouvelle toutes les trois semaines.',
    care: 'Vérifie que le fond est percé et que l\'eau sort vraiment : '
        'une table qui retient l\'eau noie les racines.',
  ),
  'acc_treillis_tomate': AccessoryGuide(
    when: 'À la plantation, en mai — pas une fois que le pied fait un '
        'mètre et part dans tous les sens.',
    how: 'Conduis une seule tige par pied en l\'enroulant autour '
        'd\'une ficelle verticale, et pince les gourmands chaque '
        'semaine. Moins de fruits, mais plus gros, et un feuillage qui '
        'sèche vite après la pluie — donc moins de mildiou.',
    howMuch: 'Un treillis de 1,20 m porte quatre pieds espacés de 40 cm.',
    care: 'Retire ficelles et feuilles sèches avant l\'hiver : le '
        'mildiou hiverne dessus.',
    diy: 'Une ficelle de chanvre tendue entre une barre haute et le sol '
        'fait exactement ça.',
  ),
  'acc_tuteurs_spirales': AccessoryGuide(
    when: 'À la plantation d\'une tomate.',
    how: 'Plante la spirale à 10 cm du pied et fais passer la tige dans '
        'les boucles au fur et à mesure : rien à attacher, la tige se '
        'cale d\'elle-même. Tourne toujours dans le même sens.',
    howMuch: 'Un par pied. 1,70 m de haut pour une tomate '
        'indéterminée, qui ne s\'arrête jamais de monter.',
    care: 'Essuie la terre et range-les au sec : ils durent dix ans.',
  ),

  // ────────────────────────────── Protection ─────────────────────────────
  'acc_anti_limaces': AccessoryGuide(
    when: 'Dès la plantation des salades, et après chaque pluie de '
        'printemps.',
    how: 'Éparpille quelques granulés autour des jeunes plants, jamais '
        'en tas : un tas rassemble les limaces au même endroit au lieu '
        'de les éloigner. Le phosphate de fer les fait cesser de '
        'manger, et elles meurent cachées — tu ne verras pas de '
        'cadavres, c\'est normal.',
    howMuch: '5 g par m², à renouveler après une forte pluie.',
    care: 'Garde la boîte fermée et au sec : mouillés, les granulés se '
        'délitent et ne servent plus.',
    diy: 'Une planche posée à plat le soir : tu ramasses dessous au '
        'matin. Gratuit, mais il faut y aller tous les jours.',
  ),
  'acc_filet_insectes': AccessoryGuide(
    when: 'De mai à août, contre la mouche de la carotte et la piéride '
        'du chou.',
    how: 'Pose-le dès le semis, avant que l\'insecte n\'arrive : '
        'posé après la ponte, il enferme les chenilles avec le chou. '
        'Enterre ou leste les bords, la mouche passe par le moindre jour.',
    howMuch: 'Maille de 0,8 mm contre la mouche de la carotte, 1,35 mm '
        'suffit contre les papillons. Prévois 1 m de plus que le carré '
        'dans chaque sens.',
    care: 'Rentre-le sec et plié : les UV le fragilisent en deux '
        'saisons dehors.',
  ),
  'acc_filet_oiseaux': AccessoryGuide(
    when: 'Trois semaines avant la maturité des fraises et des cerises.',
    how: 'Tends-le sur des arceaux, jamais à même les feuilles : posé '
        'dessus, les oiseaux picorent à travers et les oisillons s\'y '
        'prennent les pattes. Maille de 15 à 20 mm.',
    howMuch: 'La surface du carré, plus 50 cm de retombée sur chaque '
        'bord pour le fixer au sol.',
    care: 'Enroule-le au lieu de le froisser : les mailles se déchirent '
        'aux plis.',
  ),
  'acc_ombriere': AccessoryGuide(
    when: 'De juin à septembre en France. Aux heures chaudes toute '
        'l\'année sous les tropiques.',
    how: 'Tends-le à 50 cm au-dessus des cultures, pas posé dessus : '
        'l\'air doit circuler, sinon tu fabriques une étuve. 30 % '
        'd\'ombrage pour les tomates et les aubergines, 50 % pour les '
        'salades et les semis.',
    howMuch: 'Une toile de 2 × 3 m couvre deux carrés.',
    care: 'Les œillets lâchent avant la toile : double-les d\'une '
        'sangle cousue.',
    diy: 'Un vieux voilage, ou une canisse posée sur quatre piquets, '
        'tamise autant.',
  ),
  'acc_voile_forcage': AccessoryGuide(
    when: 'De février à avril, sur les semis et les premiers repiquages.',
    how: 'Pose-le flottant, bords enterrés, sans tendre : les plants le '
        'soulèvent en poussant. Il gagne 2 à 3 °C la nuit et coupe le '
        'vent, ce qui compte autant. Retire-le à la floraison, les '
        'insectes doivent pouvoir passer.',
    howMuch: 'Un voile P17 de 2 × 5 m couvre deux carrés et se recoupe '
        'aux ciseaux.',
    care: 'Il tient deux ou trois saisons. Répare les déchirures au '
        'ruban adhésif de serre.',
  ),
  'acc_voile_hivernage': AccessoryGuide(
    when: 'De novembre à mars, posé avant la première gelée '
        'annoncée.',
    how: 'Enveloppe sans serrer et laisse le haut ouvert : un voile '
        'fermé retient l\'humidité et fait pourrir le cœur de la '
        'plante. Il protège jusqu\'à −5 °C, pas au-delà — en dessous, '
        'il faut rentrer les pots.',
    howMuch: 'Un voile P30 de 2 × 5 m enveloppe trois artichauts, ou '
        'deux agrumes en pot.',
    care: 'Secoue la neige : son poids mouillé casse les branches que '
        'le voile protège.',
  ),

  // ─────────────────────────────── Le sol ────────────────────────────────
  'acc_activateur_compost': AccessoryGuide(
    when: 'Au démarrage d\'un tas, et quand il ne chauffe plus.',
    how: 'Saupoudre une poignée tous les 20 cm de déchets, puis arrose : '
        'il apporte l\'azote et les ferments qui manquent à un tas trop '
        'sec ou trop ligneux. ⚠️ Un tas qui sent mauvais manque d\'air, '
        'pas d\'activateur — retourne-le d\'abord.',
    howMuch: 'Une poignée par couche. Un tas bien équilibré en vert et '
        'en brun n\'en a besoin du tout.',
    care: 'Referme le sac : à l\'humidité, la poudre s\'agglomère en '
        'blocs.',
    diy: 'Une couche de tontes fraîches, ou du purin d\'ortie dilué, '
        'fait le même apport d\'azote.',
  ),
  'acc_composteur': AccessoryGuide(
    when: 'Toute l\'année. Le tas ne démarre vraiment qu\'au printemps, '
        'quand il se réchauffe.',
    how: 'Alterne une couche de vert — épluchures, tontes — et une '
        'couche de brun — feuilles, carton, broyat — à peu près '
        'moitié-moitié. Retourne tous les deux mois. Ni viande, ni '
        'laitage, ni plante malade.',
    howMuch: 'Un bac de 300 à 600 L suffit à une famille et rend de quoi '
        'pailler et amender quatre carrés par an.',
    care: 'Pose-le à l\'ombre et sur la terre nue : les vers '
        'doivent pouvoir monter du sol.',
    diy: 'Quatre palettes vissées en carré, dont une face démontable '
        'pour sortir le compost par le bas.',
  ),
  'acc_engrais': AccessoryGuide(
    when: 'Au printemps à la plantation, puis une fois par mois sur les '
        'gourmands : tomate, courgette, chou, poireau.',
    how: 'Griffe-le en surface et arrose. Enfoui trop profond, il '
        'nourrit sous les racines. Jamais sur une terre sèche, ni sur un '
        'plant qui souffre déjà de la chaleur.',
    howMuch: '100 g par m² au printemps, et c\'est tout. Trop d\'azote '
        'donne un feuillage magnifique et pas de fruits.',
    care: 'Les granulés se gardent des années au sec ; un engrais '
        'liquide, un an.',
    diy: 'Le purin d\'ortie dilué à 10 % remplace l\'azote, la cendre '
        'de bois tamisée apporte la potasse.',
  ),
  'acc_lombricomposteur': AccessoryGuide(
    when: 'Toute l\'année, et c\'est la solution quand il n\'y a pas '
        'de jardin.',
    how: 'Démarre avec 250 g de vers (Eisenia) et nourris petit : ils '
        'mangent environ la moitié de leur poids par jour, épluchures '
        'coupées fin. Ni agrumes, ni oignon, ni ail — ils acidifient le '
        'bac et les vers fuient.',
    howMuch: 'Trois plateaux traitent les déchets de deux personnes, et '
        'rendent du lombricompost plus le jus à diluer pour les plantes.',
    care: 'Entre 15 et 25 °C : ni au soleil d\'été, ni dehors en hiver. '
        'Un bac trop humide se corrige avec du carton déchiré.',
    diy: 'Deux seaux de 20 L emboîtés, le premier percé au fond, font '
        'un lombricomposteur d\'essai.',
  ),
  'acc_mulch_ecorces': AccessoryGuide(
    when: 'Au printemps, sur une terre réchauffée et désherbée.',
    how: 'Étale 5 à 7 cm en dégageant le collet des plants. Réserve-le '
        'aux massifs, aux fraisiers et aux petits fruits : il acidifie '
        'en se décomposant, et il est trop lent pour un carré qu\'on '
        'remanie chaque année.',
    howMuch: 'Un sac de 50 L couvre 1 m² sur 5 cm d\'épaisseur.',
    care: 'Il tient deux à trois ans. Recharge d\'un centimètre chaque '
        'printemps.',
  ),
  'acc_paillis_chanvre': AccessoryGuide(
    when: 'De mai aux premières gelées, dès que la terre est réchauffée.',
    how: 'Étale 3 à 5 cm sur une terre déjà humide et désherbée : '
        'pailler une terre sèche la garde sèche. Dégage le pied des '
        'plants de 5 cm, sinon le collet pourrit.',
    howMuch: 'Un sac de 100 L couvre 2,5 m² sur 4 cm — soit deux carrés.',
    care: 'Il disparaît en une saison en nourrissant le sol. C\'est '
        'voulu, pas un défaut.',
    diy: 'Les tontes séchées deux jours, les feuilles mortes ou la '
        'paille font le même travail pour rien.',
  ),
  'acc_terreau': AccessoryGuide(
    when: 'Au semis et au rempotage, de février à juin.',
    how: 'Tamise-le pour les semis : une graine de carotte ne traverse '
        'pas un morceau d\'écorce. En pleine terre, ne remplace jamais '
        'la terre par du terreau — mélange-les à moitié, le terreau seul '
        'sèche vite et se tasse.',
    howMuch: 'Un sac de 20 L remplit trente godets. Une table de '
        'culture de 80 × 40 cm sur 25 cm de profondeur en demande 80 L.',
    care: 'Referme le sac : à l\'air, le terreau sèche et devient '
        'hydrophobe — l\'eau glisse dessus sans entrer.',
  ),

  // ──────────────────────────── Bacs et graines ──────────────────────────
  'acc_bac': AccessoryGuide(
    when: 'Toute l\'année sur un balcon. Au printemps pour démarrer.',
    how: 'Compte 30 cm de profondeur pour une tomate, 20 pour des '
        'salades, 40 pour une carotte longue. Ne mets des billes '
        'd\'argile que si l\'eau ne s\'évacue pas : sinon elles '
        'prennent la place des racines.',
    howMuch: 'Un bac de 80 × 40 cm porte deux pieds de tomate, ou huit '
        'salades.',
    care: 'Une terre cuite pleine d\'eau éclate au gel : vide-la ou '
        'rentre-la avant l\'hiver.',
    diy: 'Un grand sac de terreau couché, percé dessous et fendu '
        'dessus, fait un bac de culture pour une saison.',
  ),
  'acc_graines': AccessoryGuide(
    when: 'En janvier-février, quand on prépare l\'année sur le papier.',
    how: 'Commence par cinq ou six variétés faciles — radis, laitue, '
        'haricot, courgette, basilic, tomate cerise — plutôt que par '
        'vingt sachets dont la moitié finira périmée. Note la date '
        'd\'achat sur chaque sachet.',
    howMuch: 'Un sachet de radis sème plusieurs rangs : échelonne-les '
        'de trois semaines. Un sachet de tomate suffit à plusieurs '
        'saisons.',
    care: 'Au sec, au frais, à l\'obscurité. Les graines de panais et '
        'd\'oignon ne germent plus après deux ans ; celles de tomate '
        'tiennent bien plus longtemps.',
    diy: 'Récupère tes graines de tomate : laisse fermenter la pulpe '
        'trois jours, rince, sèche. ⚠️ Pas sur un hybride F1, la '
        'descendance ne ressemble à rien.',
  ),

  // ───────────────────────────── Arrosage ───────────────────────────────
  'acc_goutte_a_goutte': AccessoryGuide(
    when: 'De mai à septembre, installé avant les grosses chaleurs.',
    how: 'Un goutteur par pied, pas un tuyau en serpentin : l\'eau doit '
        'arriver aux racines, pas entre les plants. Fais tourner tôt le '
        'matin, 20 à 30 minutes d\'affilée plutôt que peu chaque jour — '
        'un arrosage long fait descendre les racines.',
    howMuch: 'Quatre goutteurs de 2 L/h par carré de 1,20 m.',
    care: 'Démonte et rince les goutteurs à l\'automne, le calcaire les '
        'bouche. Vide la ligne avant le gel.',
  ),
  'acc_oyas': AccessoryGuide(
    when: 'De juin à septembre, et pendant les absences.',
    how: 'Enterre-la jusqu\'au col entre deux ou trois plants, puis '
        'remplis : la terre cuite suinte à la demande et les racines '
        'viennent chercher l\'eau. Garde le couvercle, sinon tu arroses '
        'les moustiques.',
    howMuch: 'Une oya de 5 L alimente trois pieds de tomate pendant '
        'trois à cinq jours en été. Deux par carré.',
    care: 'Déterre-la avant l\'hiver : pleine d\'eau, elle éclate au '
        'gel. Brosse le dépôt blanc à l\'eau claire, sans savon.',
    diy: 'Deux pots de terre cuite non émaillés collés bord à bord, '
        'le trou du bas bouché au mastic, font une oya.',
  ),
  'acc_programmateur': AccessoryGuide(
    when: 'Avant de partir, et de juin à août.',
    how: 'Règle un créneau long et peu fréquent : 30 minutes trois fois '
        'par semaine plutôt que 10 minutes tous les jours. ⚠️ Fais un '
        'cycle complet devant toi avant de partir — une pile faible ou '
        'un robinet à moitié ouvert, et tu retrouves tout sec.',
    howMuch: 'Un seul, sur le robinet, en tête du goutte à goutte.',
    care: 'Retire la pile et rentre le boîtier l\'hiver : il gèle et se '
        'fend.',
  ),
  'acc_recuperateur': AccessoryGuide(
    when: 'Toute l\'année : il se remplit l\'hiver pour servir l\'été.',
    how: 'Raccorde-le à une descente de gouttière avec un collecteur '
        'filtrant, et pose le robinet assez haut pour glisser un '
        'arrosoir dessous. L\'eau de pluie est sans calcaire et à '
        'température ambiante : les plants ne prennent pas le choc '
        'froid du robinet.',
    howMuch: '1 mm de pluie sur 10 m² de toit rend 10 L. Une cuve de '
        '300 L se vide en une semaine de canicule sur quatre carrés.',
    care: 'Couvre-la : à la lumière l\'eau verdit, et une cuve ouverte '
        'est un piège pour les animaux. Nettoie le fond une fois par an.',
    diy: 'Un bidon alimentaire de 200 L d\'occasion et un collecteur de '
        'gouttière suffisent.',
  ),
  'acc_tuyau_microporeux': AccessoryGuide(
    when: 'De mai à septembre, sur les rangs serrés.',
    how: 'Déroule-le le long du rang, enterré de 5 cm ou glissé sous le '
        'paillis, et branche-le sur un robinet à faible pression. Il est '
        'fait pour les rangs continus — salades, carottes, fraisiers — '
        'là où le goutte à goutte demanderait trente goutteurs.',
    howMuch: '15 m de tuyau couvrent quatre carrés de 1,20 m.',
    care: 'Il se bouche au calcaire et à la terre : rince-le à pleine '
        'pression en début de saison.',
  ),
};

/// Le mode d'emploi d'un accessoire, ou `null` si c'en est pas un.
AccessoryGuide? accessoryGuideFor(String id) => accessoryGuides[id];
