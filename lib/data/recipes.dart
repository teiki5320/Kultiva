/// Idées de plats liées aux récoltes — surtout cuisines d'Afrique de
/// l'Ouest, avec quelques classiques universels.
class Recipe {
  final String name;
  final String emoji;
  final String description; // 1 phrase gourmande, ton Kultiva chaleureux
  const Recipe({
    required this.name,
    required this.emoji,
    required this.description,
  });
}

/// Clé = `Vegetable.id` du catalogue (`vegetables_base.dart`).
const Map<String, List<Recipe>> recipesByVegetable = <String, List<Recipe>>{
  'gombo': <Recipe>[
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
    Recipe(
      name: 'Sauce feuilles de célosie',
      emoji: '🥬',
      description:
          'Les feuilles tendres de célosie mijotées avec tomate et poisson fumé.',
    ),
  ],
  'amarante': <Recipe>[
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
    Recipe(
      name: 'Sauce feuilles de baselle',
      emoji: '🥬',
      description:
          'L\'épinard de Ceylan mijoté en sauce onctueuse, douce et légèrement mucilagineuse.',
    ),
  ],
  'epinard': <Recipe>[
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
    Recipe(
      name: 'Sauce pili-pili',
      emoji: '🌶️',
      description:
          'La petite sauce piquante maison qui accompagne absolument tout, avec modération !',
    ),
  ],
  'aubergine_africaine': <Recipe>[
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
    Recipe(
      name: 'Salade fraîcheur',
      emoji: '🥗',
      description:
          'Ta laitue croquante tout juste cueillie, avec une vinaigrette bien citronnée.',
    ),
  ],
  'chou_pomme': <Recipe>[
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
    Recipe(
      name: 'Salade de concombre au yaourt',
      emoji: '🥒',
      description:
          'Des rondelles bien fraîches dans un yaourt à la menthe, idéal par forte chaleur.',
    ),
  ],
  'courgette': <Recipe>[
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
    Recipe(
      name: 'Jus de pastèque frais',
      emoji: '🍉',
      description:
          'La pastèque mixée avec un peu de citron vert, la boisson des grandes chaleurs.',
    ),
  ],
  'mais': <Recipe>[
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
    Recipe(
      name: 'Ragoût de taro',
      emoji: '🍲',
      description:
          'Le taro mijoté en sauce tomate, fondant et généreux, à servir bien chaud.',
    ),
  ],
  'citronnelle': <Recipe>[
    Recipe(
      name: 'Infusion de citronnelle',
      emoji: '🍵',
      description:
          'Quelques feuilles fraîches infusées, un parfum citronné qui apaise le soir.',
    ),
  ],
  'menthe': <Recipe>[
    Recipe(
      name: 'Ataya',
      emoji: '🫖',
      description:
          'Le thé à la menthe mousseux, préparé en trois services entre amis, sans se presser.',
    ),
  ],
  'persil': <Recipe>[
    Recipe(
      name: 'Poisson braisé au persil',
      emoji: '🐟',
      description:
          'Un poisson mariné au persil et à l\'ail, braisé comme sur les grills de Dakar.',
    ),
  ],
  'basilic': <Recipe>[
    Recipe(
      name: 'Pesto maison',
      emoji: '🌿',
      description:
          'Ton basilic pilé avec ail et huile d\'olive, pour des pâtes qui sentent l\'été.',
    ),
  ],
  'haricot': <Recipe>[
    Recipe(
      name: 'Haricots verts sautés',
      emoji: '🫘',
      description:
          'Des haricots croquants sautés à l\'ail, l\'accompagnement qui va avec tout.',
    ),
  ],
  'betterave': <Recipe>[
    Recipe(
      name: 'Salade de betterave',
      emoji: '🥗',
      description:
          'Des dés de betterave bien rouges en vinaigrette, un classique des salades de Dakar.',
    ),
  ],
  'potiron': <Recipe>[
    Recipe(
      name: 'Soupe au potiron',
      emoji: '🎃',
      description:
          'Le velouté orange et réconfortant, avec une pointe de crème si tu veux.',
    ),
  ],
  'courge_butternut': <Recipe>[
    Recipe(
      name: 'Velouté de butternut',
      emoji: '🍜',
      description:
          'Une soupe soyeuse au petit goût de noisette, douce comme un câlin.',
    ),
  ],
  'papayer': <Recipe>[
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
};
