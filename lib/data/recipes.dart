/// Que faire de la récolte — trois idées par légume, cuisine française
/// d'abord, avec les classiques d'Afrique de l'Ouest conservés : ce
/// sont les seules recettes tropicales du catalogue, et le chantier
/// mondial en aura besoin.
class Recipe {
  final String name;
  final String emoji;
  final String description; // 1 phrase gourmande, ton Kultiva chaleureux

  /// Temps total en minutes, préparation comprise.
  final int? minutes;

  /// Pour combien de personnes.
  final int? serves;

  /// Ce qu'il faut sortir avant de commencer.
  final List<String> ingredients;

  /// Les étapes, dans l'ordre. Vide tant que la recette n'a pas été
  /// écrite en entier : elle s'affiche alors en carte, sans animation.
  final List<RecipeStep> steps;

  const Recipe({
    required this.name,
    required this.emoji,
    required this.description,
    this.minutes,
    this.serves,
    this.ingredients = const <String>[],
    this.steps = const <RecipeStep>[],
  });

  /// Une recette complète se déroule en animation ; une simple idée de
  /// plat reste une carte. Les deux cohabitent volontairement : écrire
  /// 400 recettes pas à pas d'un coup aurait retardé la liste, qui est
  /// déjà utile seule.
  bool get isAnimated => steps.isNotEmpty;

  /// « 35 min · 4 pers. », ou ce qu'on en sait.
  String? get subtitle {
    final bouts = <String>[
      if (minutes != null) '$minutes min',
      if (serves != null) '$serves pers.',
    ];
    return bouts.isEmpty ? null : bouts.join('  ·  ');
  }
}

/// Une étape d'une recette animée.
class RecipeStep {
  final String emoji;
  final String text;

  /// Durée de l'étape, quand elle en a une (cuisson, repos). Alimente
  /// le minuteur de l'animation.
  final int? minutes;

  const RecipeStep(this.emoji, this.text, {this.minutes});
}

/// Clé = `Vegetable.id` du catalogue (`vegetables_base.dart`).
const Map<String, List<Recipe>> recipesByVegetable = <String, List<Recipe>>{
  'gombo': <Recipe>[
    Recipe(name: 'Gombos sautés à l\'ail', emoji: '🧄', description: 'À feu vif et peu de temps : c\'est ce qui évite le filant.', minutes: 20, serves: 4),
    Recipe(
      name: 'Soupou kandia',
      emoji: '🍲',
      description:
          'La sauce gombo sénégalaise onctueuse, à l\'huile de palme et au poisson.',
    ),
    Recipe(
      name: 'Sauce gombo',
      emoji: '🥣',
      description:
          'La grande sauce sahélienne qui accompagne le tô, mijotée avec viande ou poisson.',
    ),
  ],
  'tomate': <Recipe>[
    Recipe(name: 'Tarte à la tomate et moutarde', emoji: '🥧', description: 'Une couche de moutarde sous les tomates, du thym dessus.', minutes: 55, serves: 6),
    Recipe(
      name: 'Thiéboudienne',
      emoji: '🍛',
      description:
          'Le riz au poisson sénégalais, roi des plats, avec sa sauce tomate bien réduite.',
    ),
    Recipe(
      name: 'Salade tomate-oignon',
      emoji: '🥗',
      description:
          'Des tomates fraîches du jardin, un filet de citron, et le tour est joué.',
    ),
  ],
  'arachide': <Recipe>[
    Recipe(name: 'Beurre de cacahuète maison', emoji: '🥜', description: 'Grillées puis mixées longtemps : elles rendent leur huile seules.', minutes: 30, serves: 8),
    Recipe(
      name: 'Mafé',
      emoji: '🥜',
      description:
          'Le ragoût à la pâte d\'arachide, doux et généreux, servi sur du riz bien chaud.',
    ),
    Recipe(
      name: 'Kulikuli',
      emoji: '🍘',
      description:
          'Les croquettes d\'arachide frites et croustillantes, parfaites pour grignoter.',
    ),
  ],
  'bananier_plantain': <Recipe>[
    Recipe(
      name: 'Alloco',
      emoji: '🍌',
      description:
          'Les plantains bien mûrs frits à l\'ivoirienne, dorés et fondants à souhait.',
    ),
    Recipe(
      name: 'Kelewele',
      emoji: '🌶️',
      description:
          'Le plantain frit du Ghana, mariné au gingembre et au piment, sucré-épicé.',
    ),
    Recipe(
      name: 'Foutou banane',
      emoji: '🥣',
      description:
          'La boule de plantain pilé de Côte d\'Ivoire, à tremper dans une bonne sauce.',
    ),
  ],
  'igname': <Recipe>[
    Recipe(
      name: 'Foufou d\'igname',
      emoji: '🍠',
      description:
          'L\'igname pilée en boule moelleuse, indispensable avec une sauce bien relevée.',
    ),
    Recipe(
      name: 'Ragoût d\'igname',
      emoji: '🍲',
      description:
          'Des morceaux d\'igname mijotés dans une sauce tomate qui embaume la cuisine.',
    ),
    Recipe(
      name: 'Igname frite',
      emoji: '🍟',
      description:
          'Des frites d\'igname dorées, à tremper dans une petite sauce pimentée.',
    ),
  ],
  'manioc': <Recipe>[
    Recipe(
      name: 'Attiéké',
      emoji: '🍚',
      description:
          'La semoule de manioc ivoirienne, légère et acidulée, avec poisson braisé.',
    ),
    Recipe(
      name: 'Foufou de manioc',
      emoji: '🥣',
      description:
          'La pâte de manioc pilée, souple et réconfortante, compagne de toutes les sauces.',
    ),
    Recipe(
      name: 'Frites de manioc',
      emoji: '🍟',
      description:
          'Des bâtonnets de manioc frits, croustillants dehors et fondants dedans.',
    ),
  ],
  'mil': <Recipe>[
    Recipe(
      name: 'Tô de mil',
      emoji: '🥣',
      description:
          'La pâte de mil du Sahel, servie brûlante avec une sauce gombo ou feuilles.',
    ),
    Recipe(
      name: 'Thiakry',
      emoji: '🥛',
      description:
          'Le couscous de mil sucré au lait caillé, un dessert frais et gourmand.',
    ),
    Recipe(
      name: 'Couscous de mil',
      emoji: '🌾',
      description:
          'Le thiéré sénégalais, une semoule de mil vapeur qui accompagne les sauces du soir.',
    ),
  ],
  'sorgho': <Recipe>[
    Recipe(name: 'Galettes de sorgho', emoji: '🥞', description: 'Farine de sorgho, eau, sel, cuites sur une plaque brûlante.', minutes: 40, serves: 4),
    Recipe(
      name: 'Tô de sorgho',
      emoji: '🥣',
      description:
          'La version sorgho du tô, un classique du Burkina et du Mali à la sauce feuilles.',
    ),
    Recipe(
      name: 'Bouillie de sorgho',
      emoji: '🍚',
      description:
          'Une bouillie douce et nourrissante, parfaite pour bien démarrer la journée.',
    ),
  ],
  'fonio': <Recipe>[
    Recipe(name: 'Fonio aux légumes', emoji: '🥗', description: 'Cuit à la vapeur, grains détachés, avec les légumes du jour.', minutes: 35, serves: 4),
    Recipe(
      name: 'Couscous de fonio',
      emoji: '🌾',
      description:
          'La petite graine dorée cuite vapeur, légère et délicate, fierté du Fouta.',
    ),
    Recipe(
      name: 'Djouka de fonio',
      emoji: '🥜',
      description:
          'Le fonio à la poudre d\'arachide, un délice malien simple et parfumé.',
    ),
  ],
  'niebe': <Recipe>[
    Recipe(
      name: 'Akara',
      emoji: '🧆',
      description:
          'Les beignets de niébé croustillants, stars des petits déjeuners de rue.',
    ),
    Recipe(
      name: 'Moin-moin',
      emoji: '🫘',
      description:
          'Le flan de niébé vapeur du Nigeria, moelleux et délicatement épicé.',
    ),
    Recipe(
      name: 'Ndambé',
      emoji: '🥖',
      description:
          'Le ragoût de niébé sénégalais, servi dans du pain frais pour un sandwich costaud.',
    ),
  ],
  'bissap': <Recipe>[
    Recipe(name: 'Sorbet au bissap', emoji: '🍧', description: 'L\'infusion sucrée prise en sorbet, acidulée et profonde.', minutes: 40, serves: 4),
    Recipe(
      name: 'Jus de bissap',
      emoji: '🧃',
      description:
          'L\'infusion glacée d\'hibiscus, rouge rubis, sucrée et follement rafraîchissante.',
    ),
    Recipe(
      name: 'Sirop de bissap',
      emoji: '🍹',
      description:
          'Un sirop maison concentré, à garder au frais pour tes boissons de saison chaude.',
    ),
  ],
  'gingembre': <Recipe>[
    Recipe(name: 'Gingembre confit', emoji: '🍬', description: 'En lamelles, cuites dans un sirop, puis roulées au sucre.', minutes: 90, serves: 8),
    Recipe(
      name: 'Gnamakoudji',
      emoji: '🥤',
      description:
          'Le jus de gingembre frais qui pique et réveille, incontournable des marchés.',
    ),
    Recipe(
      name: 'Tisane gingembre-citron',
      emoji: '🍵',
      description:
          'Une infusion chaude et tonique, parfaite quand la gorge gratte un peu.',
    ),
  ],
  'moringa': <Recipe>[
    Recipe(name: 'Poudre de moringa', emoji: '🌿', description: 'Feuilles séchées à l\'ombre et pilées, à saupoudrer sur tout.', minutes: 30, serves: 8),
    Recipe(
      name: 'Soupe de moringa',
      emoji: '🍵',
      description:
          'Un bouillon vert aux feuilles fraîches de moringa, léger et plein de vitamines.',
    ),
    Recipe(
      name: 'Sauce feuilles de moringa',
      emoji: '🥬',
      description:
          'Les feuilles mijotées en sauce, un classique nourrissant du Sahel.',
    ),
  ],
  'corete': <Recipe>[
    Recipe(name: 'Corète à l\'arachide', emoji: '🥜', description: 'La sauce longue, liée à la pâte d\'arachide.', minutes: 60, serves: 4),
    Recipe(
      name: 'Sauce adémè',
      emoji: '🥬',
      description:
          'La sauce gluante et savoureuse du Togo et du Bénin, à base de feuilles de corète.',
    ),
    Recipe(
      name: 'Ewédu',
      emoji: '🍲',
      description:
          'La soupe de corète yoruba, mixée bien lisse, servie avec un ragoût de tomate.',
    ),
  ],
  'celosie': <Recipe>[
    Recipe(name: 'Célosie sautée à la tomate', emoji: '🍅', description: 'Les jeunes feuilles tombent en quelques minutes.', minutes: 25, serves: 4),
    Recipe(name: 'Soupe de célosie', emoji: '🍲', description: 'Avec de l\'oignon et du piment, nourrissante et verte.', minutes: 35, serves: 4),
    Recipe(
      name: 'Sauce feuilles de célosie',
      emoji: '🥬',
      description:
          'Les feuilles tendres de célosie mijotées avec tomate et poisson fumé.',
    ),
  ],
  'amarante': <Recipe>[
    Recipe(name: 'Amarante sautée à l\'ail', emoji: '🧄', description: 'Comme des épinards, mais avec plus de tenue.', minutes: 20, serves: 4),
    Recipe(
      name: 'Efo riro',
      emoji: '🍲',
      description:
          'Le ragoût de feuilles yoruba, riche et parfumé, où l\'amarante fait merveille.',
    ),
    Recipe(
      name: 'Sauce feuilles d\'amarante',
      emoji: '🥬',
      description:
          'Une sauce verte toute simple qui sublime le riz ou le tô du jour.',
    ),
  ],
  'baselle': <Recipe>[
    Recipe(name: 'Baselle à la sauce tomate', emoji: '🍅', description: 'Ses feuilles charnues épaississent la sauce d\'elles-mêmes.', minutes: 35, serves: 4),
    Recipe(name: 'Baselle vapeur au sésame', emoji: '🥢', description: 'Cinq minutes de vapeur, huile de sésame et soja.', minutes: 15, serves: 4),
    Recipe(
      name: 'Sauce feuilles de baselle',
      emoji: '🥬',
      description:
          'L\'épinard de Ceylan mijoté en sauce onctueuse, douce et légèrement mucilagineuse.',
    ),
  ],
  'epinard': <Recipe>[
    Recipe(name: 'Épinards à la crème', emoji: '🥣', description: 'Fondus au beurre, un peu de crème, beaucoup de muscade.', minutes: 25, serves: 4),
    Recipe(
      name: 'Épinards sautés à l\'ail',
      emoji: '🧄',
      description:
          'Des feuilles fraîches juste tombées à la poêle avec de l\'ail doré.',
    ),
    Recipe(
      name: 'Sauce épinard au poisson',
      emoji: '🐟',
      description:
          'Une sauce verte généreuse au poisson fumé, à verser sur un bon riz blanc.',
    ),
  ],
  'oignon': <Recipe>[
    Recipe(name: 'Oignons confits au vinaigre balsamique', emoji: '🍯', description: 'Deux heures à feu très doux : ils deviennent une confiture.', minutes: 130, serves: 8),
    Recipe(
      name: 'Poulet yassa',
      emoji: '🍗',
      description:
          'Le poulet mariné au citron et étouffé sous une montagne d\'oignons fondants.',
    ),
    Recipe(
      name: 'Soupe à l\'oignon',
      emoji: '🍜',
      description:
          'Le grand classique français, gratiné et réconfortant les soirs frais.',
    ),
  ],
  'piment': <Recipe>[
    Recipe(name: 'Sauce piquante maison', emoji: '🌶', description: 'Piments mixés avec ail, sel et vinaigre, fermentés une semaine.', minutes: 45, serves: 8),
    Recipe(name: 'Huile pimentée', emoji: '🫙', description: 'Piments séchés dans l\'huile chaude, jamais bouillante.', minutes: 25, serves: 8),
    Recipe(
      name: 'Sauce pili-pili',
      emoji: '🌶️',
      description:
          'La petite sauce piquante maison qui accompagne absolument tout, avec modération !',
    ),
  ],
  'aubergine_africaine': <Recipe>[
    Recipe(name: 'Djakhatou en sauce', emoji: '🍲', description: 'Amers et fermes, ils tiennent la cuisson longue.', minutes: 60, serves: 4),
    Recipe(
      name: 'Kedjenou de poulet',
      emoji: '🍗',
      description:
          'Le mijoté ivoirien à l\'étouffée, où l\'aubergine africaine fond dans la sauce.',
    ),
    Recipe(
      name: 'Sauce djakhatou',
      emoji: '🍆',
      description:
          'L\'aubergine amère mijotée à la sénégalaise, pour les amateurs de vrais goûts.',
    ),
  ],
  'aubergine': <Recipe>[
    Recipe(name: 'Parmigiana d\'aubergines', emoji: '🧀', description: 'Grillées en couches avec tomate, mozzarella et basilic.', minutes: 90, serves: 6),
    Recipe(
      name: 'Ratatouille',
      emoji: '🥘',
      description:
          'Le mijoté provençal où l\'aubergine s\'entend à merveille avec tout le jardin.',
    ),
    Recipe(
      name: 'Caviar d\'aubergine',
      emoji: '🥙',
      description:
          'Une purée d\'aubergine grillée à tartiner, fraîche et pleine de soleil.',
    ),
  ],
  'laitue': <Recipe>[
    Recipe(name: 'Laitue braisée aux petits pois', emoji: '🥬', description: 'Oui, la laitue se cuit — et c\'est délicieux.', minutes: 25, serves: 4),
    Recipe(name: 'Velouté de laitue', emoji: '🍲', description: 'Pour les laitues montées en graines qu\'on allait jeter.', minutes: 30, serves: 4),
    Recipe(
      name: 'Salade fraîcheur',
      emoji: '🥗',
      description:
          'Ta laitue croquante tout juste cueillie, avec une vinaigrette bien citronnée.',
    ),
  ],
  'chou_pomme': <Recipe>[
    Recipe(name: 'Choucroute maison', emoji: '🫙', description: 'Chou, sel, du temps. La fermentation fait le reste.', minutes: 60, serves: 8),
    Recipe(
      name: 'Riz gras',
      emoji: '🍛',
      description:
          'Le riz mijoté à la tomate du Burkina, avec ses gros morceaux de chou fondant.',
    ),
    Recipe(
      name: 'Salade de chou',
      emoji: '🥗',
      description:
          'Du chou finement émincé avec carottes et vinaigrette, croquant et frais.',
    ),
  ],
  'carotte': <Recipe>[
    Recipe(name: 'Carottes Vichy', emoji: '🧈', description: 'Beurre, sucre, eau à hauteur : le glaçage se fait tout seul.', minutes: 30, serves: 4),
    Recipe(
      name: 'Carottes râpées',
      emoji: '🥕',
      description:
          'La salade toute simple qui croque, relevée d\'un jus de citron frais.',
    ),
    Recipe(
      name: 'Soupe de légumes',
      emoji: '🍜',
      description:
          'Un velouté doux où tes carottes du jardin donnent toute leur couleur.',
    ),
  ],
  'concombre': <Recipe>[
    Recipe(name: 'Tzatziki', emoji: '🥣', description: 'Râpé, dégorgé au sel, mélangé au yaourt et à la menthe.', minutes: 20, serves: 4),
    Recipe(name: 'Soupe froide de concombre', emoji: '🍲', description: 'Mixé avec du yaourt et de l\'aneth, servi glacé.', minutes: 15, serves: 4),
    Recipe(
      name: 'Salade de concombre au yaourt',
      emoji: '🥒',
      description:
          'Des rondelles bien fraîches dans un yaourt à la menthe, idéal par forte chaleur.',
    ),
  ],
  'courgette': <Recipe>[
    Recipe(name: 'Beignets de fleurs de courgette', emoji: '🌼', description: 'Les fleurs mâles, en pâte légère, deux minutes dans l\'huile.', minutes: 35, serves: 4),
    Recipe(
      name: 'Courgettes farcies',
      emoji: '🥘',
      description:
          'Tes courgettes garnies de riz et de viande hachée, gratinées au four.',
    ),
    Recipe(
      name: 'Gratin de courgettes',
      emoji: '🧀',
      description:
          'Des tranches fondantes sous une croûte dorée, le plat familial par excellence.',
    ),
  ],
  'pasteque': <Recipe>[
    Recipe(name: 'Salade pastèque-feta-menthe', emoji: '🍉', description: 'Le salé de la feta contre le sucre du fruit.', minutes: 15, serves: 4),
    Recipe(name: 'Confiture d\'écorces de pastèque', emoji: '🫙', description: 'Le blanc de l\'écorce, qu\'on jette toujours à tort.', minutes: 90, serves: 8),
    Recipe(
      name: 'Jus de pastèque frais',
      emoji: '🍉',
      description:
          'La pastèque mixée avec un peu de citron vert, la boisson des grandes chaleurs.',
    ),
  ],
  'mais': <Recipe>[
    Recipe(name: 'Maïs grillé au beurre d\'herbes', emoji: '🌽', description: 'Sur la braise, tourné souvent, badigeonné à la fin.', minutes: 25, serves: 4),
    Recipe(
      name: 'Maïs grillé',
      emoji: '🌽',
      description:
          'L\'épi grillé au feu de bois comme au bord de la route, un régal fumé.',
    ),
    Recipe(
      name: 'Bouillie de maïs',
      emoji: '🍚',
      description:
          'Une bouillie douce et crémeuse, sucrée juste ce qu\'il faut pour le matin.',
    ),
  ],
  'patate_douce': <Recipe>[
    Recipe(name: 'Frites de patate douce au four', emoji: '🍟', description: 'Fécule de maïs avant cuisson : c\'est ce qui les rend croustillantes.', minutes: 45, serves: 4),
    Recipe(
      name: 'Frites de patate douce',
      emoji: '🍟',
      description:
          'Des frites dorées et sucrées-salées qui plaisent à toute la famille.',
    ),
    Recipe(
      name: 'Purée de patate douce',
      emoji: '🍠',
      description:
          'Une purée orange, veloutée et naturellement sucrée, douce comme tout.',
    ),
  ],
  'taro': <Recipe>[
    Recipe(name: 'Taro pilé', emoji: '🥣', description: 'Bouilli puis pilé au mortier jusqu\'à devenir élastique.', minutes: 70, serves: 4),
    Recipe(name: 'Chips de taro', emoji: '🍟', description: 'En lamelles très fines, frites jusqu\'à ce qu\'elles dorent.', minutes: 35, serves: 4),
    Recipe(
      name: 'Ragoût de taro',
      emoji: '🍲',
      description:
          'Le taro mijoté en sauce tomate, fondant et généreux, à servir bien chaud.',
    ),
  ],
  'citronnelle': <Recipe>[
    Recipe(name: 'Sirop de citronnelle', emoji: '🍹', description: 'Tiges froissées infusées dans un sirop, pour une limonade.', minutes: 35, serves: 8),
    Recipe(name: 'Poulet à la citronnelle', emoji: '🍗', description: 'Mariné au citron vert, à l\'ail et à la citronnelle hachée.', minutes: 60, serves: 4),
    Recipe(
      name: 'Infusion de citronnelle',
      emoji: '🍵',
      description:
          'Quelques feuilles fraîches infusées, un parfum citronné qui apaise le soir.',
    ),
  ],
  'menthe': <Recipe>[
    Recipe(name: 'Thé à la menthe', emoji: '🍵', description: 'Thé vert, bouquet entier, trois sucres. Versé de haut.', minutes: 15, serves: 4),
    Recipe(name: 'Taboulé à la menthe', emoji: '🥗', description: 'Plus de persil et de menthe que de semoule.', minutes: 30, serves: 4),
    Recipe(
      name: 'Ataya',
      emoji: '🫖',
      description:
          'Le thé à la menthe mousseux, préparé en trois services entre amis, sans se presser.',
    ),
  ],
  'persil': <Recipe>[
    Recipe(name: 'Persillade', emoji: '🌿', description: 'Persil et ail hachés, jetés en fin de cuisson.', minutes: 10, serves: 4),
    Recipe(name: 'Salsa verde', emoji: '🥣', description: 'Persil, câpres, anchois, huile — sur une viande ou un poisson.', minutes: 15, serves: 4),
    Recipe(
      name: 'Poisson braisé au persil',
      emoji: '🐟',
      description:
          'Un poisson mariné au persil et à l\'ail, braisé comme sur les grills de Dakar.',
    ),
  ],
  'basilic': <Recipe>[
    Recipe(name: 'Pistou', emoji: '🌿', description: 'Basilic, ail, huile d\'olive. Sans pignons, c\'est le pistou.', minutes: 15, serves: 4),
    Recipe(name: 'Soupe au pistou', emoji: '🍲', description: 'Les légumes d\'été, les haricots, et la cuillère de pistou à la fin.', minutes: 90, serves: 6),
    Recipe(
      name: 'Pesto maison',
      emoji: '🌿',
      description:
          'Ton basilic pilé avec ail et huile d\'olive, pour des pâtes qui sentent l\'été.',
    ),
  ],
  'haricot': <Recipe>[
    Recipe(name: 'Haricots verts à la tomate', emoji: '🍅', description: 'Mijotés une heure, à la grecque : ils fondent.', minutes: 70, serves: 4),
    Recipe(name: 'Salade de haricots verts aux amandes', emoji: '🥗', description: 'Croquants, amandes torréfiées, vinaigrette au citron.', minutes: 25, serves: 4),
    Recipe(
      name: 'Haricots verts sautés',
      emoji: '🫘',
      description:
          'Des haricots croquants sautés à l\'ail, l\'accompagnement qui va avec tout.',
    ),
  ],
  'betterave': <Recipe>[
    Recipe(name: 'Betteraves rôties au balsamique', emoji: '🔥', description: 'En papillote, puis pelées chaudes — la peau glisse.', minutes: 70, serves: 4),
    Recipe(name: 'Houmous de betterave', emoji: '🥣', description: 'Rose vif, avec des pois chiches et du tahini.', minutes: 25, serves: 4),
    Recipe(
      name: 'Salade de betterave',
      emoji: '🥗',
      description:
          'Des dés de betterave bien rouges en vinaigrette, un classique des salades de Dakar.',
    ),
  ],
  'potiron': <Recipe>[
    Recipe(name: 'Soupe de potiron au lait de coco', emoji: '🍲', description: 'Gingembre et coriandre, un plat complet.', minutes: 40, serves: 4),
    Recipe(name: 'Gratin de potiron', emoji: '🧀', description: 'Égoutté avant de gratiner, sinon il rend trop d\'eau.', minutes: 60, serves: 4),
    Recipe(
      name: 'Soupe au potiron',
      emoji: '🎃',
      description:
          'Le velouté orange et réconfortant, avec une pointe de crème si tu veux.',
    ),
  ],
  'courge_butternut': <Recipe>[
    Recipe(name: 'Butternut rôtie entière', emoji: '🔥', description: 'Coupée en deux, côté chair sur la plaque, une heure.', minutes: 70, serves: 4),
    Recipe(name: 'Risotto à la butternut', emoji: '🍚', description: 'Moitié en cubes, moitié en purée dans le bouillon.', minutes: 50, serves: 4),
    Recipe(
      name: 'Velouté de butternut',
      emoji: '🍜',
      description:
          'Une soupe soyeuse au petit goût de noisette, douce comme un câlin.',
    ),
  ],
  'papayer': <Recipe>[
    Recipe(name: 'Papaye verte mijotée', emoji: '🍲', description: 'Encore ferme, elle se cuisine comme une courge.', minutes: 45, serves: 4),
    Recipe(
      name: 'Salade de papaye verte',
      emoji: '🥗',
      description:
          'La papaye encore verte râpée en salade croquante, citronnée et un peu pimentée.',
    ),
    Recipe(
      name: 'Papaye au citron vert',
      emoji: '🍈',
      description:
          'Des tranches de papaye mûre arrosées de citron vert, le dessert le plus simple du monde.',
    ),
  ],
  // ─────────────────────────────────────────────────────────────
  //  Potager français — ajouté le 01/11/2026. Trois idées par
  //  récolte : ce qu'on fait le soir même, ce qu'on fait le
  //  dimanche, et ce qu'on fait pour garder.
  // ─────────────────────────────────────────────────────────────
  'pomme_de_terre': <Recipe>[
    Recipe(
      name: 'Gratin dauphinois',
      emoji: '🥔',
      description:
          'Des lamelles fines qui fondent dans la crème et l\'ail, une heure au four.',
      minutes: 80,
      serves: 4,
      ingredients: <String>[
        '1 kg de pommes de terre à chair ferme',
        '40 cl de crème liquide',
        '20 cl de lait',
        '1 gousse d\'ail',
        'Noix de muscade, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Épluche les pommes de terre et coupe-les en '
            'rondelles de 2 mm. Ne les rince pas : l\'amidon fait tenir '
            'le gratin.'),
        RecipeStep('🧄', 'Frotte le plat avec la gousse d\'ail coupée en '
            'deux, puis beurre-le.'),
        RecipeStep('🥛', 'Chauffe la crème et le lait avec la muscade, le '
            'sel et le poivre, sans faire bouillir.', minutes: 5),
        RecipeStep('🥔', 'Range les rondelles en couches serrées, verse le '
            'mélange chaud dessus jusqu\'à les couvrir.'),
        RecipeStep('🔥', 'Four à 160 °C. Le gratin est prêt quand la pointe '
            'd\'un couteau traverse sans résistance.', minutes: 60),
        RecipeStep('⏳', 'Laisse reposer dix minutes avant de servir : il se '
            'tient mieux à la découpe.', minutes: 10),
      ],
    ),
    Recipe(
      name: 'Pommes de terre sautées à l\'ail',
      emoji: '🍳',
      description:
          'Croustillantes dehors, fondantes dedans, avec du persil du jardin.',
      minutes: 30,
      serves: 4,
    ),
    Recipe(
      name: 'Soupe poireaux-pommes de terre',
      emoji: '🍲',
      description:
          'La soupe de tous les hivers, celle qu\'on refait sans recette.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '4 poireaux',
        '4 pommes de terre',
        '1 l d\'eau ou de bouillon',
        'Une noix de beurre, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Fends les poireaux en quatre dans la longueur et '
            'rince-les bien : la terre se cache entre les feuilles.'),
        RecipeStep('🧈', 'Fais-les suer au beurre à feu doux, sans les '
            'colorer.', minutes: 8),
        RecipeStep('🥔', 'Ajoute les pommes de terre en gros cubes et '
            'l\'eau. Sale peu : tu rectifieras à la fin.'),
        RecipeStep('🔥', 'Laisse frémir à couvert jusqu\'à ce que les cubes '
            's\'écrasent à la fourchette.', minutes: 25),
        RecipeStep('🥄', 'Mixe, ou écrase grossièrement si tu aimes les '
            'morceaux. Rectifie le sel.'),
      ],
    ),
  ],
  'poireau': <Recipe>[
    Recipe(
      name: 'Poireaux vinaigrette',
      emoji: '🥬',
      description:
          'Tièdes, bien égouttés, avec une vinaigrette moutardée et un œuf dur.',
      minutes: 30,
      serves: 4,
    ),
    Recipe(
      name: 'Tarte aux poireaux',
      emoji: '🥧',
      description:
          'Une fondue de poireaux au beurre sur une pâte brisée, crème et muscade.',
      minutes: 70,
      serves: 6,
    ),
    Recipe(
      name: 'Flamiche',
      emoji: '🧀',
      description:
          'La tourte du Nord : poireaux fondus, crème épaisse, deux pâtes.',
      minutes: 80,
      serves: 6,
    ),
  ],
  'radis': <Recipe>[
    Recipe(
      name: 'Radis beurre-sel',
      emoji: '🧈',
      description:
          'Cueillis le matin, croqués à midi : rien ne bat la simplicité.',
      minutes: 5,
      serves: 4,
    ),
    Recipe(
      name: 'Pesto de fanes de radis',
      emoji: '🌿',
      description:
          'Les fanes ne se jettent pas : mixées à l\'huile et aux amandes, elles font un pesto piquant.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        'Les fanes d\'une botte de radis',
        '50 g d\'amandes ou de noix',
        '50 g de parmesan',
        '10 cl d\'huile d\'olive',
        '1 gousse d\'ail, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌿', 'Trie les fanes : garde les feuilles tendres, jette '
            'les tiges dures et les feuilles jaunies.'),
        RecipeStep('💧', 'Lave-les à grande eau et essore-les bien — un '
            'pesto mouillé tourne vite.'),
        RecipeStep('🥣', 'Mixe les fanes avec l\'ail, les amandes et le '
            'parmesan, par à-coups.'),
        RecipeStep('🫒', 'Verse l\'huile en filet, moteur tournant, jusqu\'à '
            'la texture qui te plaît. Sale.'),
        RecipeStep('🫙', 'En bocal, couvert d\'huile, il tient une semaine '
            'au frais.'),
      ],
    ),
    Recipe(
      name: 'Radis rôtis au four',
      emoji: '🔥',
      description:
          'La cuisson les adoucit : ils deviennent doux comme des navets.',
      minutes: 30,
      serves: 4,
    ),
  ],
  'navet': <Recipe>[
    Recipe(
      name: 'Navets glacés',
      emoji: '✨',
      description: 'Beurre, sucre, un fond d\'eau : ils brillent et caramélisent.',
      minutes: 25,
      serves: 4,
    ),
    Recipe(
      name: 'Purée de navets',
      emoji: '🥣',
      description: 'Moitié navets moitié pommes de terre, pour la douceur.',
      minutes: 35,
      serves: 4,
    ),
    Recipe(
      name: 'Navets au miel et thym',
      emoji: '🍯',
      description: 'Rôtis en quartiers, avec le thym du jardin.',
      minutes: 40,
      serves: 4,
    ),
  ],
  'poivron': <Recipe>[
    Recipe(
      name: 'Poivrons marinés à l\'huile',
      emoji: '🫙',
      description:
          'Grillés, pelés, couchés dans l\'huile d\'olive à l\'ail : ils se gardent des semaines.',
      minutes: 45,
      serves: 6,
      ingredients: <String>[
        '6 poivrons charnus',
        'Huile d\'olive',
        '2 gousses d\'ail',
        'Sel, origan ou basilic',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥', 'Passe les poivrons entiers sous le gril jusqu\'à ce '
            'que la peau noircisse et cloque, en les retournant.', minutes: 25),
        RecipeStep('🛍', 'Enferme-les chauds dans un sac ou un saladier '
            'couvert : la vapeur décolle la peau toute seule.', minutes: 10),
        RecipeStep('✋', 'Pèle-les, ôte les graines, coupe-les en lanières. '
            'Ne les rince pas, tu perdrais le jus.'),
        RecipeStep('🫙', 'Range les lanières en bocal avec l\'ail en lamelles '
            'et les herbes, couvre entièrement d\'huile.'),
        RecipeStep('❄️', 'Au frais. Meilleurs au bout de deux jours.'),
      ],
    ),
    Recipe(
      name: 'Poivrons farcis',
      emoji: '🫑',
      description: 'Riz, viande ou lentilles, herbes : un plat complet au four.',
      minutes: 75,
      serves: 4,
    ),
    Recipe(
      name: 'Piperade',
      emoji: '🍳',
      description:
          'Poivrons, tomates et oignons mijotés, liés aux œufs — le Pays basque dans une poêle.',
      minutes: 40,
      serves: 4,
    ),
  ],
  'fraise': <Recipe>[
    Recipe(
      name: 'Fraises au sucre et menthe',
      emoji: '🍓',
      description:
          'Coupées une heure avant, elles rendent un sirop qu\'on sauce au pain.',
      minutes: 10,
      serves: 4,
    ),
    Recipe(
      name: 'Confiture de fraises',
      emoji: '🫙',
      description:
          'Poids pour poids avec le sucre, un citron, et la cuisine sent l\'été.',
      minutes: 60,
      serves: 8,
      ingredients: <String>[
        '1 kg de fraises équeutées',
        '700 g de sucre',
        'Le jus d\'un citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍓', 'Coupe les grosses fraises en deux, laisse les '
            'petites entières.'),
        RecipeStep('🍬', 'Mélange-les au sucre et au citron, laisse macérer '
            'au frais. Le jus sort tout seul.', minutes: 120),
        RecipeStep('🔥', 'Porte à ébullition et cuis à feu vif en écumant.',
            minutes: 20),
        RecipeStep('🥄', 'Teste sur une assiette froide : une goutte qui se '
            'fige est prête.'),
        RecipeStep('🫙', 'Mets en pots chauds, ferme et retourne jusqu\'à '
            'refroidissement.'),
      ],
    ),
    Recipe(
      name: 'Tarte aux fraises',
      emoji: '🥧',
      description: 'Pâte sablée, crème pâtissière, fraises crues rangées dessus.',
      minutes: 90,
      serves: 6,
    ),
  ],
  'ail': <Recipe>[
    Recipe(
      name: 'Soupe à l\'ail',
      emoji: '🍲',
      description: 'Douce et réconfortante — l\'ail cuit perd toute sa morsure.',
      minutes: 35,
      serves: 4,
    ),
    Recipe(
      name: 'Aïoli',
      emoji: '🥣',
      description: 'Ail pilé, jaune d\'œuf, huile d\'olive en filet. Du muscle.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Ail confit à l\'huile',
      emoji: '🫙',
      description:
          'Des gousses entières fondues à feu très doux, à tartiner.',
      minutes: 50,
      serves: 8,
    ),
  ],
  'echalote': <Recipe>[
    Recipe(
      name: 'Sauce échalote au vin rouge',
      emoji: '🍷',
      description: 'Réduite au beurre, elle transforme une viande grillée.',
      minutes: 25,
      serves: 4,
    ),
    Recipe(
      name: 'Échalotes confites',
      emoji: '🍯',
      description: 'Entières, au four, avec un filet de miel et de vinaigre.',
      minutes: 50,
      serves: 4,
    ),
    Recipe(
      name: 'Vinaigrette à l\'échalote',
      emoji: '🥗',
      description: 'Ciselée fin et laissée dix minutes dans le vinaigre.',
      minutes: 10,
      serves: 4,
    ),
  ],
  'celeri': <Recipe>[
    Recipe(
      name: 'Céleri rémoulade',
      emoji: '🥗',
      description: 'Râpé cru, mayonnaise moutardée, un trait de citron.',
      minutes: 20,
      serves: 4,
    ),
    Recipe(
      name: 'Purée de céleri-rave',
      emoji: '🥣',
      description: 'Plus parfumée qu\'une purée de pommes de terre, et plus légère.',
      minutes: 40,
      serves: 4,
    ),
    Recipe(
      name: 'Velouté de céleri aux noisettes',
      emoji: '🍲',
      description: 'Les noisettes torréfiées par-dessus font tout le plat.',
      minutes: 45,
      serves: 4,
    ),
  ],
  'fenouil': <Recipe>[
    Recipe(
      name: 'Fenouil braisé à l\'orange',
      emoji: '🍊',
      description: 'L\'anis du fenouil et l\'acidité de l\'orange se répondent.',
      minutes: 45,
      serves: 4,
    ),
    Recipe(
      name: 'Salade de fenouil cru',
      emoji: '🥗',
      description: 'Tranché à la mandoline, citron, huile d\'olive, parmesan.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Fenouil gratiné',
      emoji: '🧀',
      description: 'Blanchi puis passé au four avec de la crème et du comté.',
      minutes: 55,
      serves: 4,
    ),
  ],
  'blette': <Recipe>[
    Recipe(
      name: 'Blettes à la crème',
      emoji: '🥬',
      description: 'Côtes et vert cuits séparément, réunis dans la crème.',
      minutes: 35,
      serves: 4,
    ),
    Recipe(
      name: 'Tourte de blettes niçoise',
      emoji: '🥧',
      description: 'Sucrée-salée, avec raisins secs et pignons. Déroutante et bonne.',
      minutes: 90,
      serves: 6,
    ),
    Recipe(
      name: 'Gratin de côtes de blettes',
      emoji: '🧀',
      description: 'Béchamel, gruyère, et les côtes qui gardent du croquant.',
      minutes: 60,
      serves: 4,
    ),
  ],
  'mache': <Recipe>[
    Recipe(
      name: 'Mâche, betterave et noix',
      emoji: '🥗',
      description: 'La salade d\'hiver par excellence, avec une vinaigrette à la noix.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Velouté de mâche',
      emoji: '🍲',
      description: 'Mixée crue dans un bouillon chaud pour garder sa couleur.',
      minutes: 25,
      serves: 4,
    ),
    Recipe(
      name: 'Mâche aux lardons et œuf poché',
      emoji: '🍳',
      description: 'Tiède, le jaune qui coule fait la sauce.',
      minutes: 20,
      serves: 2,
    ),
  ],
  'roquette': <Recipe>[
    Recipe(
      name: 'Pesto de roquette',
      emoji: '🌿',
      description: 'Plus poivré qu\'au basilic, parfait sur des pâtes chaudes.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Roquette, parmesan, citron',
      emoji: '🥗',
      description: 'Trois ingrédients, rien de plus. Posée sur une pizza, c\'est mieux encore.',
      minutes: 5,
      serves: 2,
    ),
    Recipe(
      name: 'Velouté de roquette et pomme de terre',
      emoji: '🍲',
      description: 'La pomme de terre adoucit l\'amertume.',
      minutes: 35,
      serves: 4,
    ),
  ],
  'endive': <Recipe>[
    Recipe(
      name: 'Endives au jambon',
      emoji: '🧀',
      description: 'Braisées, roulées dans le jambon, nappées de béchamel.',
      minutes: 70,
      serves: 4,
    ),
    Recipe(
      name: 'Salade d\'endives aux noix et bleu',
      emoji: '🥗',
      description: 'L\'amertume, le gras et le croquant : l\'accord fonctionne toujours.',
      minutes: 10,
      serves: 4,
    ),
    Recipe(
      name: 'Endives braisées au miel',
      emoji: '🍯',
      description: 'Le miel contre l\'amertume, un filet de citron pour trancher.',
      minutes: 35,
      serves: 4,
    ),
  ],
  'artichaut': <Recipe>[
    Recipe(
      name: 'Artichauts à la vinaigrette',
      emoji: '🥬',
      description: 'Feuille à feuille, trempée, raclée entre les dents. Le fond pour la fin.',
      minutes: 45,
      serves: 2,
    ),
    Recipe(
      name: 'Artichauts à la barigoule',
      emoji: '🍲',
      description: 'Petits violets mijotés au vin blanc avec carotte et lard.',
      minutes: 60,
      serves: 4,
    ),
    Recipe(
      name: 'Fonds d\'artichauts farcis',
      emoji: '🧀',
      description: 'Garnis de brousse et d\'herbes, passés au four.',
      minutes: 70,
      serves: 4,
    ),
  ],
  'asperge': <Recipe>[
    Recipe(
      name: 'Asperges sauce mousseline',
      emoji: '🥚',
      description: 'Tièdes, une hollandaise allégée de crème fouettée.',
      minutes: 40,
      serves: 4,
    ),
    Recipe(
      name: 'Asperges vertes rôties',
      emoji: '🔥',
      description: 'Huile d\'olive, four très chaud, dix minutes. Zeste de citron à la sortie.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Risotto aux asperges',
      emoji: '🍚',
      description: 'Les pointes réservées pour la fin, les queues dans le bouillon.',
      minutes: 45,
      serves: 4,
    ),
  ],
  'petit_pois': <Recipe>[
    Recipe(
      name: 'Petits pois à la française',
      emoji: '🥬',
      description: 'Avec laitue, oignons nouveaux et un peu de beurre. Rien d\'autre.',
      minutes: 30,
      serves: 4,
    ),
    Recipe(
      name: 'Velouté de petits pois à la menthe',
      emoji: '🍲',
      description: 'Vert vif si tu le mixes vite et le refroidis aussitôt.',
      minutes: 25,
      serves: 4,
    ),
    Recipe(
      name: 'Petits pois carottes',
      emoji: '🥕',
      description: 'Le plat d\'accompagnement de l\'enfance, en bien meilleur.',
      minutes: 35,
      serves: 4,
    ),
  ],
  'pois_mange_tout': <Recipe>[
    Recipe(
      name: 'Pois gourmands sautés au wok',
      emoji: '🥢',
      description: 'Deux minutes à feu vif, sésame et sauce soja.',
      minutes: 12,
      serves: 4,
    ),
    Recipe(
      name: 'Salade de pois gourmands croquants',
      emoji: '🥗',
      description: 'Blanchis trente secondes, glacés à l\'eau froide.',
      minutes: 15,
      serves: 4,
    ),
    Recipe(
      name: 'Pois gourmands à la crème de menthe',
      emoji: '🌿',
      description: 'Une crème légère à la menthe fraîche du jardin.',
      minutes: 20,
      serves: 4,
    ),
  ],
  'feve': <Recipe>[
    Recipe(
      name: 'Fèves à la croque-sel',
      emoji: '🧂',
      description: 'Jeunes et tendres, écossées et croquées crues. Le printemps.',
      minutes: 10,
      serves: 4,
    ),
    Recipe(
      name: 'Purée de fèves au cumin',
      emoji: '🥣',
      description: 'Épluchées deux fois, écrasées à l\'huile d\'olive.',
      minutes: 40,
      serves: 4,
    ),
    Recipe(
      name: 'Fèves au chorizo',
      emoji: '🌶',
      description: 'Mijotées avec du chorizo et des oignons nouveaux.',
      minutes: 35,
      serves: 4,
    ),
  ],
  'rhubarbe': <Recipe>[
    Recipe(
      name: 'Tarte à la rhubarbe',
      emoji: '🥧',
      description:
          'Acide et sucrée, sur une pâte brisée avec un appareil à la crème.',
      minutes: 75,
      serves: 6,
      ingredients: <String>[
        '800 g de tiges de rhubarbe',
        '1 pâte brisée',
        '150 g de sucre',
        '2 œufs, 20 cl de crème',
        '1 c. à s. de poudre d\'amandes',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Coupe la rhubarbe en tronçons de 2 cm. Pas besoin '
            'de l\'éplucher si les tiges sont jeunes.'),
        RecipeStep('🍬', 'Saupoudre-la de la moitié du sucre et laisse '
            'dégorger : tu jetteras l\'eau rendue, sinon la tarte '
            'détrempe.', minutes: 30),
        RecipeStep('🥧', 'Étale la pâte, pique-la, saupoudre le fond de '
            'poudre d\'amandes — elle boira le jus restant.'),
        RecipeStep('🥚', 'Bats les œufs, la crème et le reste du sucre. '
            'Range la rhubarbe, verse l\'appareil.'),
        RecipeStep('🔥', 'Four à 180 °C jusqu\'à ce que la crème soit prise '
            'et dorée.', minutes: 40),
      ],
    ),
    Recipe(
      name: 'Compote de rhubarbe',
      emoji: '🥣',
      description: 'À peine sucrée, sur un fromage blanc.',
      minutes: 25,
      serves: 4,
    ),
    Recipe(
      name: 'Crumble rhubarbe-fraise',
      emoji: '🍓',
      description: 'L\'acidité de l\'une, le sucre de l\'autre, du beurre dessus.',
      minutes: 55,
      serves: 6,
    ),
  ],
  'cornichon': <Recipe>[
    Recipe(name: 'Cornichons au vinaigre', emoji: '🫙', description: 'Brossés au gros sel, séchés une nuit, couverts de vinaigre bouillant.', minutes: 40, serves: 8),
    Recipe(name: 'Cornichons à l\'aneth', emoji: '🌿', description: 'À la lacto-fermentation, en saumure : croquants et vivants.', minutes: 30, serves: 8),
    Recipe(name: 'Sauce tartare', emoji: '🥣', description: 'Hachés dans la mayonnaise avec câpres et estragon.', minutes: 10, serves: 4),
  ],
  'melon': <Recipe>[
    Recipe(name: 'Melon au jambon cru', emoji: '🍈', description: 'Le sucré et le salé, l\'été, sans rien cuire.', minutes: 10, serves: 4),
    Recipe(name: 'Soupe froide melon-menthe', emoji: '🍲', description: 'Mixé, bien glacé, un tour de poivre du moulin.', minutes: 15, serves: 4),
    Recipe(name: 'Melon en salade au chèvre frais', emoji: '🧀', description: 'Avec de la roquette et des pignons grillés.', minutes: 15, serves: 4),
  ],
  'chou_fleur': <Recipe>[
    Recipe(name: 'Gratin de chou-fleur', emoji: '🧀', description: 'Béchamel muscadée, gruyère, cuit juste assez pour rester entier.', minutes: 60, serves: 4),
    Recipe(name: 'Chou-fleur rôti aux épices', emoji: '🔥', description: 'En steaks épais, curcuma et cumin, four très chaud.', minutes: 40, serves: 4),
    Recipe(name: 'Taboulé de chou-fleur', emoji: '🥗', description: 'Mixé cru en semoule, citron, menthe et persil.', minutes: 20, serves: 4),
  ],
  'brocoli': <Recipe>[
    Recipe(name: 'Brocolis sautés à l\'ail', emoji: '🧄', description: 'Blanchis puis saisis, piment et sésame.', minutes: 20, serves: 4),
    Recipe(name: 'Velouté de brocoli', emoji: '🍲', description: 'Vert franc si tu le mixes à peine cuit.', minutes: 30, serves: 4),
    Recipe(name: 'Brocolis au four, parmesan et citron', emoji: '🍋', description: 'Les pointes qui grillent sont les meilleures.', minutes: 30, serves: 4),
  ],
  'chou_rave': <Recipe>[
    Recipe(name: 'Chou-rave râpé en rémoulade', emoji: '🥗', description: 'Cru, il croque comme une pomme et goûte la noisette.', minutes: 15, serves: 4),
    Recipe(name: 'Chou-rave sauté au beurre', emoji: '🧈', description: 'En bâtonnets, à peine dorés, avec du persil.', minutes: 20, serves: 4),
    Recipe(name: 'Gratin de chou-rave', emoji: '🧀', description: 'En lamelles fines, crème et comté.', minutes: 55, serves: 4),
  ],
  'chou_kale': <Recipe>[
    Recipe(name: 'Chips de kale', emoji: '🍟', description: 'Massées à l\'huile, cuites à four doux jusqu\'à craquer.', minutes: 25, serves: 4),
    Recipe(name: 'Salade de kale massé', emoji: '🥗', description: 'Masser les feuilles au citron les attendrit en deux minutes.', minutes: 15, serves: 4),
    Recipe(name: 'Kale sauté à l\'ail et au chorizo', emoji: '🌶', description: 'Le gras du chorizo enrobe les feuilles.', minutes: 20, serves: 4),
  ],
  'chou_bruxelles': <Recipe>[
    Recipe(name: 'Choux de Bruxelles rôtis au lard', emoji: '🔥', description: 'Coupés en deux, face contre la plaque : ils caramélisent.', minutes: 35, serves: 4),
    Recipe(name: 'Choux de Bruxelles à la crème', emoji: '🥣', description: 'Blanchis, puis fondus dans la crème à la muscade.', minutes: 35, serves: 4),
    Recipe(name: 'Salade de choux de Bruxelles crus', emoji: '🥗', description: 'Émincés très fin, pomme, noisettes, vinaigrette au miel.', minutes: 20, serves: 4),
  ],
  'chou_chinois': <Recipe>[
    Recipe(name: 'Chou chinois sauté au wok', emoji: '🥢', description: 'Gingembre, ail, sauce soja, deux minutes à feu vif.', minutes: 15, serves: 4),
    Recipe(name: 'Kimchi maison', emoji: '🫙', description: 'Salé, épicé, fermenté une semaine à température.', minutes: 60, serves: 8),
    Recipe(name: 'Salade de chou chinois au sésame', emoji: '🥗', description: 'Émincé cru, vinaigre de riz, huile de sésame.', minutes: 15, serves: 4),
  ],
  'pak_choi': <Recipe>[
    Recipe(name: 'Pak choï vapeur sauce soja', emoji: '🥬', description: 'Fendu en deux, cinq minutes de vapeur, un filet de soja.', minutes: 12, serves: 4),
    Recipe(name: 'Pak choï sauté à l\'ail', emoji: '🧄', description: 'Les tiges d\'abord, les feuilles à la fin.', minutes: 12, serves: 4),
    Recipe(name: 'Nouilles sautées au pak choï', emoji: '🍜', description: 'Un plat complet en un seul wok.', minutes: 25, serves: 4),
  ],
  'panais': <Recipe>[
    Recipe(name: 'Panais rôtis au miel', emoji: '🍯', description: 'Sucré naturellement, le four le confirme.', minutes: 45, serves: 4),
    Recipe(name: 'Velouté de panais', emoji: '🍲', description: 'Doux, épais, une pointe de muscade.', minutes: 35, serves: 4),
    Recipe(name: 'Purée panais-pomme de terre', emoji: '🥣', description: 'Moitié-moitié, pour ne pas écœurer.', minutes: 35, serves: 4),
  ],
  'salsifis': <Recipe>[
    Recipe(name: 'Salsifis à la crème', emoji: '🥣', description: 'Épluchés dans l\'eau citronnée, sinon ils noircissent.', minutes: 50, serves: 4),
    Recipe(name: 'Salsifis frits', emoji: '🍟', description: 'En beignets, croustillants dehors, fondants dedans.', minutes: 45, serves: 4),
    Recipe(name: 'Gratin de salsifis au jambon', emoji: '🧀', description: 'Un plat d\'hiver qu\'on a tort d\'avoir oublié.', minutes: 65, serves: 4),
  ],
  'topinambour': <Recipe>[
    Recipe(name: 'Velouté de topinambour', emoji: '🍲', description: 'Goût d\'artichaut, texture de velours.', minutes: 40, serves: 4),
    Recipe(name: 'Topinambours rôtis au thym', emoji: '🔥', description: 'Brossés sans éplucher, coupés en deux, au four.', minutes: 45, serves: 4),
    Recipe(name: 'Salade de topinambours crus', emoji: '🥗', description: 'Râpés fin, citron, noisettes. Surprenant et bon.', minutes: 15, serves: 4),
  ],
  'rutabaga': <Recipe>[
    Recipe(name: 'Purée de rutabaga', emoji: '🥣', description: 'Avec une pomme de terre et beaucoup de beurre.', minutes: 40, serves: 4),
    Recipe(name: 'Rutabaga rôti aux épices', emoji: '🔥', description: 'En cubes, paprika fumé, four chaud.', minutes: 45, serves: 4),
    Recipe(name: 'Potée au rutabaga', emoji: '🍲', description: 'Avec chou, carotte et lard, le plat des jours froids.', minutes: 120, serves: 6),
  ],
  'radis_noir': <Recipe>[
    Recipe(name: 'Carpaccio de radis noir', emoji: '🥗', description: 'Tranché à la mandoline, huile de noix, fleur de sel.', minutes: 15, serves: 4),
    Recipe(name: 'Radis noir râpé à la pomme', emoji: '🍏', description: 'La pomme adoucit son piquant.', minutes: 15, serves: 4),
    Recipe(name: 'Radis noir confit au four', emoji: '🔥', description: 'Il perd son amertume et devient presque sucré.', minutes: 50, serves: 4),
  ],
  'cresson': <Recipe>[
    Recipe(name: 'Potage au cresson', emoji: '🍲', description: 'Le classique : cresson, pomme de terre, crème.', minutes: 35, serves: 4),
    Recipe(name: 'Salade de cresson aux agrumes', emoji: '🍊', description: 'Le poivré du cresson contre l\'acidité de l\'orange.', minutes: 15, serves: 4),
    Recipe(name: 'Beurre de cresson', emoji: '🧈', description: 'Haché dans du beurre pommade, sur un poisson chaud.', minutes: 10, serves: 4),
  ],
  'oseille': <Recipe>[
    Recipe(name: 'Sauce à l\'oseille', emoji: '🐟', description: 'Fondue à la crème, pour un saumon ou un œuf poché.', minutes: 20, serves: 4),
    Recipe(name: 'Soupe à l\'oseille', emoji: '🍲', description: 'Acidulée, liée d\'un jaune d\'œuf hors du feu.', minutes: 30, serves: 4),
    Recipe(name: 'Omelette à l\'oseille', emoji: '🍳', description: 'Les feuilles fondent en quelques secondes.', minutes: 12, serves: 2),
  ],
  'pourpier': <Recipe>[
    Recipe(name: 'Salade de pourpier', emoji: '🥗', description: 'Charnu et citronné, cru avec de la tomate et de la feta.', minutes: 10, serves: 4),
    Recipe(name: 'Pourpier sauté à l\'ail', emoji: '🧄', description: 'Quelques secondes à la poêle, pas plus.', minutes: 10, serves: 4),
    Recipe(name: 'Soupe de pourpier à la turque', emoji: '🍲', description: 'Avec du yaourt et du riz, acidulée et nourrissante.', minutes: 35, serves: 4),
  ],
  'potimarron': <Recipe>[
    Recipe(name: 'Velouté de potimarron', emoji: '🍲', description: 'Peau comprise — elle devient fondante et porte le goût.', minutes: 40, serves: 4),
    Recipe(name: 'Potimarron rôti au four', emoji: '🔥', description: 'En quartiers, huile d\'olive, romarin, graines de courge.', minutes: 45, serves: 4),
    Recipe(name: 'Tarte au potimarron', emoji: '🥧', description: 'Sucrée ou salée, la chair sèche s\'y prête bien.', minutes: 80, serves: 6),
  ],
  'champignon_paris': <Recipe>[
    Recipe(name: 'Champignons à la persillade', emoji: '🌿', description: 'À feu vif pour qu\'ils dorent au lieu de rendre leur eau.', minutes: 20, serves: 4),
    Recipe(name: 'Duxelles', emoji: '🥣', description: 'Hachés fin et desséchés au beurre — la base de mille plats.', minutes: 30, serves: 4),
    Recipe(name: 'Champignons farcis au four', emoji: '🧀', description: 'Têtes garnies de duxelles et de chapelure.', minutes: 40, serves: 4),
  ],
  'pleurote': <Recipe>[
    Recipe(name: 'Pleurotes poêlées à l\'ail', emoji: '🍄', description: 'Déchirées à la main, saisies sans les tasser.', minutes: 20, serves: 4),
    Recipe(name: 'Pleurotes panées façon escalope', emoji: '🍟', description: 'Leur texture fibreuse s\'y prête remarquablement.', minutes: 30, serves: 4),
    Recipe(name: 'Fricassée de pleurotes à la crème', emoji: '🥣', description: 'Avec de l\'estragon et un trait de vin blanc.', minutes: 25, serves: 4),
  ],
  'shiitake': <Recipe>[
    Recipe(name: 'Shiitakés sautés au soja', emoji: '🥢', description: 'Sauce soja, mirin, un peu de sucre : le glaçage japonais.', minutes: 20, serves: 4),
    Recipe(name: 'Bouillon dashi aux shiitakés', emoji: '🍜', description: 'Même séchés, ils donnent une profondeur rare.', minutes: 40, serves: 4),
    Recipe(name: 'Shiitakés grillés au sésame', emoji: '🔥', description: 'Entiers, sur le gril, sel et huile de sésame.', minutes: 20, serves: 4),
  ],
  'haricot_beurre': <Recipe>[
    Recipe(name: 'Haricots beurre persillade', emoji: '🌿', description: 'Cuits croquants, sautés au beurre et à l\'ail.', minutes: 25, serves: 4),
    Recipe(name: 'Salade de haricots beurre', emoji: '🥗', description: 'Tièdes, échalote et vinaigrette à l\'ancienne.', minutes: 25, serves: 4),
    Recipe(name: 'Haricots beurre à la tomate', emoji: '🍅', description: 'Mijotés dans un coulis à l\'ail et au thym.', minutes: 40, serves: 4),
  ],
  'lentille': <Recipe>[
    Recipe(name: 'Salade de lentilles à l\'échalote', emoji: '🥗', description: 'Tièdes, vinaigrette moutardée, beaucoup d\'échalote.', minutes: 40, serves: 4),
    Recipe(name: 'Petit salé aux lentilles', emoji: '🍲', description: 'Le plat du dimanche, qui mijote sans surveillance.', minutes: 90, serves: 6),
    Recipe(name: 'Dahl de lentilles corail', emoji: '🌶', description: 'Coco, curcuma, gingembre — prêt en vingt minutes.', minutes: 30, serves: 4),
  ],
  'pois_chiche': <Recipe>[
    Recipe(name: 'Houmous', emoji: '🥣', description: 'Tahini, citron, ail, et un filet d\'huile par-dessus.', minutes: 20, serves: 4),
    Recipe(name: 'Falafels', emoji: '🧆', description: 'Crus et trempés, jamais cuits : c\'est le secret.', minutes: 45, serves: 4),
    Recipe(name: 'Pois chiches rôtis épicés', emoji: '🔥', description: 'À grignoter, croquants, au paprika fumé.', minutes: 40, serves: 4),
  ],
  'sarrasin': <Recipe>[
    Recipe(name: 'Galettes de sarrasin', emoji: '🥞', description: 'Farine, eau, sel, et du repos. Rien d\'autre.', minutes: 90, serves: 4),
    Recipe(name: 'Kacha', emoji: '🍚', description: 'Grains grillés puis gonflés au bouillon.', minutes: 35, serves: 4),
    Recipe(name: 'Salade de sarrasin aux herbes', emoji: '🥗', description: 'Froid, avec tout ce que le jardin donne ce jour-là.', minutes: 30, serves: 4),
  ],
  'pommier': <Recipe>[
    Recipe(
      name: 'Tarte aux pommes',
      emoji: '🥧',
      description: 'Des quartiers rangés en rosace sur une compote, et du sucre qui caramélise.',
      minutes: 70,
      serves: 6,
      ingredients: <String>[
        '1 pâte brisée',
        '6 pommes (4 pour la compote, 2 pour le dessus)',
        '50 g de sucre',
        'Une noix de beurre',
        'Cannelle (facultatif)',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍎', 'Épluche quatre pommes, coupe-les en morceaux et fais-les compoter à couvert avec deux cuillères d\'eau.', minutes: 20),
        RecipeStep('🥄', 'Écrase la compote à la fourchette, sucre-la légèrement. Laisse tiédir.'),
        RecipeStep('🥧', 'Étale la pâte dans le moule, pique le fond, étale la compote dessus.'),
        RecipeStep('🌹', 'Taille les deux pommes restantes en lamelles fines et range-les en rosace, en les faisant se chevaucher.'),
        RecipeStep('🧈', 'Parsème de noisettes de beurre et du reste de sucre.'),
        RecipeStep('🔥', 'Four à 190 °C jusqu\'à ce que les bords des lamelles brunissent.', minutes: 35),
      ],
    ),
    Recipe(name: 'Compote maison', emoji: '🥣', description: 'Sans sucre ajouté si les pommes sont mûres — elles suffisent.', minutes: 30, serves: 4),
    Recipe(name: 'Pommes au four', emoji: '🔥', description: 'Évidées, remplies de beurre, de sucre et d\'une noix.', minutes: 45, serves: 4),
  ],
  'poirier': <Recipe>[
    Recipe(name: 'Poires pochées au vin', emoji: '🍷', description: 'Vin rouge, cannelle, badiane : elles prennent une robe profonde.', minutes: 50, serves: 4),
    Recipe(name: 'Tarte Bourdaloue', emoji: '🥧', description: 'Poires et crème d\'amandes, le mariage classique.', minutes: 80, serves: 6),
    Recipe(name: 'Poires au chocolat', emoji: '🍫', description: 'Pochées, nappées chaud, avec une glace vanille.', minutes: 35, serves: 4),
  ],
  'cerisier': <Recipe>[
    Recipe(name: 'Clafoutis aux cerises', emoji: '🍒', description: 'Avec les noyaux, comme en Limousin : ils parfument la pâte.', minutes: 55, serves: 6),
    Recipe(name: 'Confiture de cerises', emoji: '🫙', description: 'Dénoyautées à la main, un peu de citron pour la prise.', minutes: 70, serves: 8),
    Recipe(name: 'Cerises au vinaigre', emoji: '🫙', description: 'En aigre-doux, pour accompagner une viande froide.', minutes: 30, serves: 8),
  ],
  'prunier': <Recipe>[
    Recipe(name: 'Tarte aux prunes', emoji: '🥧', description: 'Coupées en deux, côté chair vers le haut, sur de la poudre d\'amandes.', minutes: 65, serves: 6),
    Recipe(name: 'Confiture de prunes', emoji: '🫙', description: 'Épaisse et foncée, la plus facile des confitures.', minutes: 70, serves: 8),
    Recipe(name: 'Prunes rôties au thym', emoji: '🌿', description: 'Salées-sucrées, pour accompagner un canard.', minutes: 30, serves: 4),
  ],
  'pecher': <Recipe>[
    Recipe(name: 'Pêches au sirop', emoji: '🫙', description: 'Pelées après trente secondes d\'eau bouillante, mises en bocal.', minutes: 50, serves: 8),
    Recipe(name: 'Pêches rôties à la verveine', emoji: '🌿', description: 'Au four avec du miel et des feuilles de verveine du jardin.', minutes: 30, serves: 4),
    Recipe(name: 'Pêche Melba', emoji: '🍨', description: 'Pêche pochée, glace vanille, coulis de framboises.', minutes: 30, serves: 4),
  ],
  'abricotier': <Recipe>[
    Recipe(name: 'Confiture d\'abricots', emoji: '🫙', description: 'Quelques amandons cassés dedans : c\'est ce qui fait la différence.', minutes: 70, serves: 8),
    Recipe(name: 'Tarte aux abricots', emoji: '🥧', description: 'Leur acidité tient tête à la pâte sucrée.', minutes: 60, serves: 6),
    Recipe(name: 'Abricots rôtis au romarin', emoji: '🌿', description: 'Salé-sucré, en accompagnement ou en dessert.', minutes: 25, serves: 4),
  ],
  'vigne': <Recipe>[
    Recipe(name: 'Feuilles de vigne farcies', emoji: '🍃', description: 'Riz, herbes, citron — les jeunes feuilles du printemps.', minutes: 90, serves: 6),
    Recipe(name: 'Raisiné', emoji: '🫙', description: 'Du jus de raisin réduit des heures, sans une once de sucre.', minutes: 180, serves: 8),
    Recipe(name: 'Verjus', emoji: '🍾', description: 'Le jus des raisins verts, acide, qui remplace le vinaigre.', minutes: 30, serves: 8),
  ],
  'groseillier': <Recipe>[
    Recipe(name: 'Gelée de groseilles', emoji: '🫙', description: 'Le jus seul, filtré sans presser, pour qu\'elle reste claire.', minutes: 60, serves: 8),
    Recipe(name: 'Groseilles au sucre', emoji: '🍨', description: 'En grappes, trempées dans le blanc d\'œuf puis le sucre.', minutes: 20, serves: 4),
    Recipe(name: 'Bavarois aux groseilles', emoji: '🍮', description: 'Leur acidité réveille une crème sucrée.', minutes: 60, serves: 6),
  ],
  'cassissier': <Recipe>[
    Recipe(name: 'Crème de cassis', emoji: '🍷', description: 'Baies macérées dans l\'alcool, puis sucrées. Patience de deux mois.', minutes: 60, serves: 8),
    Recipe(name: 'Confiture de cassis', emoji: '🫙', description: 'Intense, presque amère, parfaite sur du pain grillé.', minutes: 60, serves: 8),
    Recipe(name: 'Sorbet au cassis', emoji: '🍧', description: 'Mixé cru, passé au tamis, sucré au sirop.', minutes: 40, serves: 4),
  ],
  'myrtillier': <Recipe>[
    Recipe(name: 'Tarte aux myrtilles', emoji: '🥧', description: 'Crues sur une crème, ou cuites — les deux marchent.', minutes: 60, serves: 6),
    Recipe(name: 'Muffins aux myrtilles', emoji: '🧁', description: 'Roulées dans la farine pour qu\'elles ne tombent pas au fond.', minutes: 40, serves: 6),
    Recipe(name: 'Confiture de myrtilles', emoji: '🫙', description: 'Peu de sucre, beaucoup de citron.', minutes: 50, serves: 8),
  ],
  'framboisier': <Recipe>[
    Recipe(name: 'Coulis de framboises', emoji: '🥣', description: 'Mixées crues, passées au tamis. Rien ne se perd du parfum.', minutes: 15, serves: 4),
    Recipe(name: 'Confiture de framboises', emoji: '🫙', description: 'Cuisson courte, pour garder le goût de la cueillette.', minutes: 40, serves: 8),
    Recipe(name: 'Framboisier', emoji: '🎂', description: 'Génoise, crème mousseline, framboises debout sur le pourtour.', minutes: 120, serves: 8),
  ],
  'murier': <Recipe>[
    Recipe(name: 'Confiture de mûres', emoji: '🫙', description: 'Passée au moulin si les graines te gênent.', minutes: 60, serves: 8),
    Recipe(name: 'Crumble aux mûres', emoji: '🍪', description: 'Avec des pommes, pour équilibrer l\'acidité.', minutes: 50, serves: 6),
    Recipe(name: 'Sirop de mûres', emoji: '🍹', description: 'Jus et sucre à parts égales, à allonger d\'eau pétillante.', minutes: 45, serves: 8),
  ],
  'figuier': <Recipe>[
    Recipe(name: 'Figues rôties au miel', emoji: '🍯', description: 'Ouvertes en croix, dix minutes de four, avec du chèvre.', minutes: 20, serves: 4),
    Recipe(name: 'Confiture de figues', emoji: '🫙', description: 'Avec un citron entier confit dedans.', minutes: 80, serves: 8),
    Recipe(name: 'Tarte aux figues et romarin', emoji: '🥧', description: 'Le romarin du jardin, posé entier sur la tarte.', minutes: 60, serves: 6),
  ],
  'noisetier': <Recipe>[
    Recipe(name: 'Pâte à tartiner maison', emoji: '🍫', description: 'Noisettes torréfiées, mixées longtemps jusqu\'à la crème.', minutes: 45, serves: 8),
    Recipe(name: 'Gâteau aux noisettes', emoji: '🍰', description: 'Sans farine, juste des noisettes moulues et des œufs.', minutes: 55, serves: 6),
    Recipe(name: 'Noisettes torréfiées au sel', emoji: '🧂', description: 'Quinze minutes de four, frottées dans un torchon.', minutes: 20, serves: 4),
  ],
  'kiwi': <Recipe>[
    Recipe(name: 'Salade de kiwis à la menthe', emoji: '🥗', description: 'Avec de l\'orange, c\'est le dessert d\'hiver le plus simple.', minutes: 15, serves: 4),
    Recipe(name: 'Confiture de kiwis', emoji: '🫙', description: 'Verte et acidulée, avec de la vanille.', minutes: 60, serves: 8),
    Recipe(name: 'Smoothie kiwi-pomme', emoji: '🥤', description: 'Attention : le kiwi fait tourner les laitages après une heure.', minutes: 10, serves: 2),
  ],
  'bleuet': <Recipe>[
    Recipe(name: 'Fleurs de bleuet en décoration', emoji: '💙', description: 'Les pétales, crus, posés sur une salade ou un gâteau.', minutes: 5, serves: 4),
    Recipe(name: 'Infusion de bleuet', emoji: '🍵', description: 'Fleurs séchées, douces, légèrement amères.', minutes: 10, serves: 2),
    Recipe(name: 'Sel aux fleurs', emoji: '🧂', description: 'Pétales séchés mélangés au gros sel.', minutes: 15, serves: 8),
  ],
  'thym': <Recipe>[
    Recipe(name: 'Huile au thym', emoji: '🫒', description: 'Branches sèches dans l\'huile tiède, deux semaines d\'attente.', minutes: 20, serves: 8),
    Recipe(name: 'Poulet au thym et citron', emoji: '🍗', description: 'Beaucoup de branches sous la peau, pas dessus.', minutes: 75, serves: 4),
    Recipe(name: 'Infusion de thym au miel', emoji: '🍵', description: 'Le remède de la maison quand la gorge gratte.', minutes: 10, serves: 2),
  ],
  'romarin': <Recipe>[
    Recipe(name: 'Pommes de terre au romarin', emoji: '🥔', description: 'En quartiers, gros sel, branches entières au four.', minutes: 45, serves: 4),
    Recipe(name: 'Sirop de romarin', emoji: '🍹', description: 'Pour un citron pressé ou un cocktail sans alcool.', minutes: 30, serves: 8),
    Recipe(name: 'Focaccia au romarin', emoji: '🍞', description: 'Les aiguilles enfoncées dans la pâte avant cuisson.', minutes: 150, serves: 6),
  ],
  'ciboulette': <Recipe>[
    Recipe(name: 'Fromage blanc aux herbes', emoji: '🥣', description: 'Ciboulette, échalote, ail : la cervelle de canut.', minutes: 10, serves: 4),
    Recipe(name: 'Omelette à la ciboulette', emoji: '🍳', description: 'Ajoutée hors du feu pour garder sa couleur.', minutes: 10, serves: 2),
    Recipe(name: 'Beurre à la ciboulette', emoji: '🧈', description: 'En rouleau au congélateur, à trancher sur une viande.', minutes: 15, serves: 8),
  ],
  'coriandre': <Recipe>[
    Recipe(name: 'Chermoula', emoji: '🌿', description: 'Coriandre, cumin, paprika, citron — la marinade du poisson.', minutes: 15, serves: 4),
    Recipe(name: 'Guacamole à la coriandre', emoji: '🥑', description: 'Écrasé à la fourchette, jamais mixé.', minutes: 15, serves: 4),
    Recipe(name: 'Salade thaïe à la coriandre', emoji: '🥗', description: 'Avec de la menthe, du citron vert et du piment.', minutes: 20, serves: 4),
  ],
  'aneth': <Recipe>[
    Recipe(name: 'Saumon gravlax', emoji: '🐟', description: 'Sel, sucre, beaucoup d\'aneth, deux jours au frais.', minutes: 40, serves: 6),
    Recipe(name: 'Sauce yaourt-aneth', emoji: '🥣', description: 'Avec du concombre râpé, pour un tzatziki du Nord.', minutes: 10, serves: 4),
    Recipe(name: 'Pommes de terre à l\'aneth', emoji: '🥔', description: 'Nouvelles, à l\'eau, beurre et aneth haché.', minutes: 30, serves: 4),
  ],
  'estragon': <Recipe>[
    Recipe(name: 'Sauce béarnaise', emoji: '🥣', description: 'Réduction au vinaigre et à l\'estragon, montée au beurre.', minutes: 30, serves: 4),
    Recipe(name: 'Poulet à l\'estragon', emoji: '🍗', description: 'Crème et estragon, un classique qui ne vieillit pas.', minutes: 60, serves: 4),
    Recipe(name: 'Vinaigre à l\'estragon', emoji: '🫙', description: 'Une branche dans la bouteille, trois semaines.', minutes: 10, serves: 8),
  ],
  'sauge': <Recipe>[
    Recipe(name: 'Beurre de sauge', emoji: '🧈', description: 'Feuilles frites dans le beurre noisette, sur des gnocchis.', minutes: 15, serves: 4),
    Recipe(name: 'Saltimbocca', emoji: '🥩', description: 'Veau, jambon cru et une feuille de sauge par escalope.', minutes: 30, serves: 4),
    Recipe(name: 'Infusion de sauge', emoji: '🍵', description: 'Digestive, avec une rondelle de citron.', minutes: 10, serves: 2),
  ],
  'laurier_sauce': <Recipe>[
    Recipe(name: 'Bouquet garni', emoji: '🌿', description: 'Thym, laurier, persil, ficelés ensemble. La base de tout.', minutes: 5, serves: 8),
    Recipe(name: 'Court-bouillon au laurier', emoji: '🐟', description: 'Pour pocher un poisson sans le dessécher.', minutes: 25, serves: 4),
    Recipe(name: 'Crème au laurier', emoji: '🍮', description: 'Infusé dans le lait chaud — un parfum inattendu en dessert.', minutes: 45, serves: 4),
  ],
  'origan': <Recipe>[
    Recipe(name: 'Sauce tomate à l\'origan', emoji: '🍅', description: 'Séché plutôt que frais : il est plus puissant.', minutes: 35, serves: 4),
    Recipe(name: 'Pizza margherita', emoji: '🍕', description: 'Origan sur la tomate avant le four, basilic après.', minutes: 120, serves: 4),
    Recipe(name: 'Feta marinée à l\'origan', emoji: '🧀', description: 'En cubes dans l\'huile, avec du citron et du poivre.', minutes: 15, serves: 4),
  ],
  'marjolaine': <Recipe>[
    Recipe(name: 'Farce aux herbes', emoji: '🌿', description: 'Plus douce que l\'origan, idéale dans une farce de volaille.', minutes: 20, serves: 4),
    Recipe(name: 'Courgettes à la marjolaine', emoji: '🥒', description: 'Sautées, avec de l\'ail et beaucoup d\'herbe fraîche.', minutes: 25, serves: 4),
    Recipe(name: 'Beurre maître d\'hôtel aux herbes', emoji: '🧈', description: 'Marjolaine, persil, citron.', minutes: 15, serves: 8),
  ],
  'sarriette': <Recipe>[
    Recipe(name: 'Haricots à la sarriette', emoji: '🫘', description: 'On la dit « herbe aux haricots » : elle les rend digestes.', minutes: 60, serves: 4),
    Recipe(name: 'Fromage de chèvre à la sarriette', emoji: '🧀', description: 'Le pèbre d\'ail provençal, roulé dans l\'herbe.', minutes: 10, serves: 4),
    Recipe(name: 'Marinade pour grillades', emoji: '🔥', description: 'Huile, ail, sarriette, citron.', minutes: 15, serves: 4),
  ],
  'cerfeuil': <Recipe>[
    Recipe(name: 'Potage au cerfeuil', emoji: '🍲', description: 'Ajouté à la fin seulement : la cuisson tue son parfum.', minutes: 30, serves: 4),
    Recipe(name: 'Sauce aux fines herbes', emoji: '🥣', description: 'Cerfeuil, ciboulette, persil, estragon — les quatre canoniques.', minutes: 10, serves: 4),
    Recipe(name: 'Œufs brouillés au cerfeuil', emoji: '🍳', description: 'Cuisson très douce, cerfeuil hors du feu.', minutes: 15, serves: 2),
  ],
  'capucine': <Recipe>[
    Recipe(name: 'Salade aux fleurs de capucine', emoji: '🌺', description: 'Poivrées comme du cresson, et très belles dans l\'assiette.', minutes: 10, serves: 4),
    Recipe(name: 'Câpres de capucine', emoji: '🫙', description: 'Les boutons floraux au vinaigre remplacent les vraies câpres.', minutes: 30, serves: 8),
    Recipe(name: 'Beurre de capucine', emoji: '🧈', description: 'Pétales hachés dans du beurre pommade.', minutes: 15, serves: 8),
  ],
  'bourrache': <Recipe>[
    Recipe(name: 'Fleurs de bourrache glacées', emoji: '🧊', description: 'Prises dans des glaçons, bleues dans le verre.', minutes: 10, serves: 8),
    Recipe(name: 'Bourrache en beignets', emoji: '🍟', description: 'Les feuilles, en pâte à beignets légère.', minutes: 30, serves: 4),
    Recipe(name: 'Soupe de bourrache', emoji: '🍲', description: 'Les jeunes feuilles ont un goût de concombre.', minutes: 30, serves: 4),
  ],
  'sesame': <Recipe>[
    Recipe(name: 'Tahini maison', emoji: '🥣', description: 'Graines torréfiées, mixées longtemps avec un filet d\'huile.', minutes: 30, serves: 8),
    Recipe(name: 'Gomasio', emoji: '🧂', description: 'Sésame grillé et sel, écrasés au mortier. Sur tout.', minutes: 15, serves: 8),
    Recipe(name: 'Croquants au sésame', emoji: '🍪', description: 'Caramel et graines, étalés fin, cassés en éclats.', minutes: 25, serves: 6),
  ],
  // Les tisanes et les fleurs comestibles. Les engrais verts
  // (phacélie, trèfle, moutarde) et les fleurs d'accompagnement
  // (œillet d'Inde, tagète, cosmos, zinnia) n'ont volontairement pas
  // de recette : on les sème pour le sol et les insectes.
  'camomille': <Recipe>[
    Recipe(name: 'Infusion de camomille', emoji: '🍵', description: 'Les capitules séchés à l\'ombre, une cuillère par tasse.', minutes: 10, serves: 2),
    Recipe(name: 'Sirop de camomille', emoji: '🍹', description: 'Infusé fort puis sucré, sur une salade de fruits.', minutes: 30, serves: 8),
    Recipe(name: 'Crème brûlée à la camomille', emoji: '🍮', description: 'Infusée dans la crème chaude, filtrée avant de cuire.', minutes: 60, serves: 4),
  ],
  'lavande': <Recipe>[
    Recipe(name: 'Sucre à la lavande', emoji: '🍬', description: 'Fleurs séchées enfouies dans le sucre, deux semaines.', minutes: 10, serves: 8),
    Recipe(name: 'Crème glacée à la lavande', emoji: '🍨', description: 'Très peu de fleurs : elle vire vite au savon.', minutes: 60, serves: 4),
    Recipe(name: 'Miel de lavande maison', emoji: '🍯', description: 'Un miel neutre parfumé à froid par les fleurs.', minutes: 15, serves: 8),
  ],
  'melisse': <Recipe>[
    Recipe(name: 'Infusion de mélisse', emoji: '🍵', description: 'Citronnée et apaisante, fraîche ou séchée.', minutes: 10, serves: 2),
    Recipe(name: 'Limonade à la mélisse', emoji: '🍋', description: 'Feuilles froissées dans l\'eau pétillante et le citron.', minutes: 15, serves: 4),
    Recipe(name: 'Salade de fruits à la mélisse', emoji: '🥗', description: 'Ciselée fin, elle remplace la menthe avec plus de douceur.', minutes: 15, serves: 4),
  ],
  'verveine': <Recipe>[
    Recipe(name: 'Infusion de verveine', emoji: '🍵', description: 'La tisane du soir, séchée en bouquets la tête en bas.', minutes: 10, serves: 2),
    Recipe(name: 'Crème à la verveine', emoji: '🍮', description: 'Infusée dans le lait chaud vingt minutes.', minutes: 50, serves: 4),
    Recipe(name: 'Sorbet à la verveine', emoji: '🍧', description: 'Vert pâle, très parfumé, servi avec des pêches.', minutes: 40, serves: 4),
  ],
  'souci': <Recipe>[
    Recipe(name: 'Riz au souci', emoji: '🍚', description: 'Les pétales colorent le riz en jaune — le « safran du pauvre ».', minutes: 25, serves: 4),
    Recipe(name: 'Salade aux pétales de souci', emoji: '🌼', description: 'Crus, légèrement amers, très décoratifs.', minutes: 10, serves: 4),
    Recipe(name: 'Beurre fleuri', emoji: '🧈', description: 'Pétales hachés dans du beurre pommade.', minutes: 15, serves: 8),
  ],
  'pensee': <Recipe>[
    Recipe(name: 'Fleurs cristallisées', emoji: '🍬', description: 'Passées au blanc d\'œuf et au sucre, séchées une nuit.', minutes: 40, serves: 8),
    Recipe(name: 'Salade fleurie', emoji: '🌸', description: 'Posées entières au dernier moment sur les feuilles.', minutes: 10, serves: 4),
    Recipe(name: 'Glaçons fleuris', emoji: '🧊', description: 'Une fleur par alvéole, de l\'eau, le congélateur.', minutes: 10, serves: 8),
  ],
  'tournesol': <Recipe>[
    Recipe(name: 'Graines de tournesol grillées', emoji: '🌻', description: 'À la poêle à sec, salées à la sortie.', minutes: 15, serves: 4),
    Recipe(name: 'Pain aux graines de tournesol', emoji: '🍞', description: 'Dans la pâte et sur la croûte.', minutes: 180, serves: 6),
    Recipe(name: 'Pousses de tournesol en salade', emoji: '🌱', description: 'Germées une semaine, croquantes et douces.', minutes: 10, serves: 4),
  ],
};
