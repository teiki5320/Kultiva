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

  /// Les autres légumes du catalogue que la recette utilise.
  ///
  /// Une recette n'appartient plus à un seul légume. La ratatouille en
  /// emploie cinq ; rangée sous « aubergine » seule, elle restait
  /// invisible pour qui a des courgettes et des poivrons mais pas
  /// d'aubergine. Déclarer les légumes employés la rend trouvable
  /// depuis chacun d'eux.
  ///
  /// Le légume sous lequel elle est rangée n'a pas à se répéter ici.
  final List<String> uses;

  const Recipe({
    required this.name,
    required this.emoji,
    required this.description,
    this.minutes,
    this.serves,
    this.ingredients = const <String>[],
    this.steps = const <RecipeStep>[],
    this.uses = const <String>[],
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
    Recipe(
      name: 'Coulis de tomates en bocaux',
      emoji: '🫙',
      description:
          'Cinq kilos d\'un coup au jardin : le coulis est la seule réponse qui tient l\'hiver.',
      minutes: 120,
      serves: 8,
      uses: <String>['oignon', 'ail', 'basilic'],
      ingredients: <String>[
        '5 kg de tomates bien mûres',
        '2 oignons',
        '4 gousses d\'ail',
        '1 bouquet de basilic',
        '4 cuillères à soupe d\'huile d\'olive',
        '2 cuillères à café de sel, 1 de sucre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍅',
            'Lave les tomates, retire le pédoncule et les parties abîmées. '
            'Inutile de les peler : la passoire le fera.'),
        RecipeStep('🔪',
            'Coupe-les en quartiers et jette-les dans la grande marmite, sans '
            'eau — elles en rendront assez.'),
        RecipeStep('🔥',
            'Fais fondre oignons et ail à l\'huile, puis ajoute les tomates '
            'et le sel.'),
        RecipeStep('⏱',
            'Laisse cuire 45 minutes à découvert, en remuant de temps en '
            'temps. Le jus doit baisser de moitié.',
            minutes: 45),
        RecipeStep('🥣',
            'Passe au moulin à légumes : peaux et graines restent dedans. Un '
            'mixeur ferait un coulis rose et mousseux.'),
        RecipeStep('🔥',
            'Remets le coulis sur le feu avec le sucre et le basilic, et fais '
            'réduire encore 20 minutes. Il doit napper la cuillère.',
            minutes: 20),
        RecipeStep('🫙',
            'Remplis des bocaux propres à 2 cm du bord, ferme-les.'),
        RecipeStep('♨️',
            'Stérilise 30 minutes dans l\'eau bouillante, bocaux couverts '
            'd\'eau. C\'est l\'étape qui fait tenir un an.',
            minutes: 30),
        RecipeStep('🧊',
            'Laisse refroidir dans l\'eau, vérifie que chaque couvercle est '
            'creux. Un couvercle bombé : au réfrigérateur, et mange-le dans '
            'la semaine.'),
      ],
    ),
    Recipe(
      name: 'Tarte à la tomate et moutarde',
      emoji: '🥧',
      description:
          'Une couche de moutarde sous les tomates, du thym dessus.',
      minutes: 55,
      serves: 6,
      ingredients: <String>[
        '1 pâte brisée',
        '6 tomates mûres',
        '2 cuillères à soupe de moutarde',
        '150 g de gruyère râpé',
        'thym, sel, poivre, huile d\'olive',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥', 'Préchauffe le four à 200 °C.'),
        RecipeStep('🥧',
            'Étale la pâte dans le moule et pique-la à la fourchette.'),
        RecipeStep('🥄',
            'Tartine le fond de moutarde, puis saupoudre le gruyère : il '
            'empêchera la pâte de détremper.'),
        RecipeStep('🍅',
            'Coupe les tomates en rondelles, dispose-les en rosace, serrées.'),
        RecipeStep('🌿', 'Sel, poivre, thym, un filet d\'huile d\'olive.'),
        RecipeStep('⏱', 'Au four 35 minutes : les bords doivent dorer.',
            minutes: 35),
        RecipeStep('🍴',
            'Laisse tiédir 10 minutes avant de couper, sinon elle s\'écroule.'),
      ],
    ),
    Recipe(
      name: 'Salade tomate-oignon',
      emoji: '🥗',
      description:
          'Des tomates fraîches du jardin, un filet de citron, et le tour est joué.',
      minutes: 10,
      serves: 4,
      uses: <String>['oignon', 'basilic'],
      ingredients: <String>[
        '4 tomates bien mûres',
        '1 oignon rouge',
        '1 citron',
        '3 cuillères à soupe d\'huile d\'olive',
        'sel, poivre, basilic',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍅',
            'Coupe les tomates en quartiers, pas en dés : elles rendent moins '
            'd\'eau.'),
        RecipeStep('🧅',
            'Émince l\'oignon très fin. Si tu le trouves fort, rince-le à '
            'l\'eau froide.'),
        RecipeStep('🍋', 'Presse le citron, mélange-le à l\'huile, sel, poivre.'),
        RecipeStep('🥗', 'Verse sur les tomates, mélange délicatement.'),
        RecipeStep('🌿',
            'Déchire le basilic à la main par-dessus — au couteau il noircit.'),
      ],
    ),
    Recipe(
      name: 'Thiéboudienne',
      emoji: '🍛',
      description:
          'Le riz au poisson sénégalais, roi des plats, avec sa sauce tomate bien réduite.',
      minutes: 90,
      serves: 6,
      uses: <String>['carotte', 'aubergine', 'oignon', 'manioc', 'ail'],
      ingredients: <String>[
        '1 kg de poisson (thiof, mérou ou cabillaud)',
        '500 g de riz brisé',
        '6 tomates mûres + 2 cuillères de concentré',
        '1 chou, 2 carottes, 1 aubergine, 1 manioc',
        '2 oignons, 1 piment, persil, ail',
        'huile, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌿',
            'Pile ail, persil, piment et sel : c\'est le nokoss. Farcis-en '
            'les poissons par une entaille.'),
        RecipeStep('🔥',
            'Fais revenir les poissons dans l\'huile chaude, puis réserve-les.'),
        RecipeStep('🧅',
            'Dans la même huile, fais fondre les oignons, ajoute tomates et '
            'concentré. Laisse réduire 15 minutes à feu doux.',
            minutes: 15),
        RecipeStep('🥕',
            'Couvre d\'eau, ajoute les légumes du plus dur au plus tendre. '
            'Cuis 25 minutes.',
            minutes: 25),
        RecipeStep('🐟',
            'Remets le poisson 10 minutes, puis sors poisson et légumes et '
            'garde-les au chaud.',
            minutes: 10),
        RecipeStep('🍚',
            'Verse le riz dans la sauce restante — elle doit le couvrir d\'un '
            'doigt. Couvre et cuis 20 minutes sans remuer.',
            minutes: 20),
        RecipeStep('🍽',
            'Dresse le riz, le poisson au centre, les légumes autour.'),
      ],
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
    Recipe(
      name: 'Épinards à la crème',
      emoji: '🥛',
      description:
          'Fondus en deux minutes, liés à la crème : l\'accompagnement de base.',
      minutes: 20,
      serves: 4,
      ingredients: <String>[
        '1 kg d\'épinards frais',
        '20 cl de crème',
        '20 g de beurre',
        '1 gousse d\'ail',
        'sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Lave les épinards dans beaucoup d\'eau, deux fois, et équeute '
            'les grosses tiges.'),
        RecipeStep('🔥',
            'Jette-les dans la sauteuse beurrée, par poignées : ils réduisent '
            'des trois quarts.'),
        RecipeStep('🫗',
            'Quand ils sont tombés, presse-les pour en sortir l\'eau — sinon '
            'la crème ne tient pas.'),
        RecipeStep('🥛',
            'Remets-les avec la crème, l\'ail écrasé, sel, poivre, muscade.'),
        RecipeStep('⏱', 'Laisse épaissir 5 minutes à feu doux.', minutes: 5),
      ],
    ),
    Recipe(
      name: 'Tarte aux épinards et feta',
      emoji: '🥧',
      description:
          'Le sel de la feta contre le vert des épinards, dans une pâte croustillante.',
      minutes: 55,
      serves: 6,
      ingredients: <String>[
        '1 pâte feuilletée',
        '800 g d\'épinards',
        '200 g de feta',
        '2 oeufs, 15 cl de crème',
        '1 oignon, sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬', 'Fais tomber les épinards à la poêle, puis presse-les.'),
        RecipeStep('🧅', 'Fais blondir l\'oignon émincé et mélange-le dedans.'),
        RecipeStep('🥣',
            'Bats oeufs et crème, muscade, poivre. Pas de sel : la feta suffit.'),
        RecipeStep('🧀',
            'Garnis la pâte des épinards, émiette la feta, verse l\'appareil.'),
        RecipeStep('⏱', 'Four à 190 °C, 30 minutes.', minutes: 30),
      ],
    ),
    Recipe(
      name: 'Épinards sautés à l\'ail',
      emoji: '🧄',
      description:
          'Trois minutes à feu vif : la cuisson qui garde la couleur.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '800 g d\'épinards',
        '2 gousses d\'ail',
        '2 cuillères à soupe d\'huile d\'olive',
        'sel, piment, citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧄',
            'Fais blondir l\'ail émincé dans l\'huile, sans le brûler.'),
        RecipeStep('🔥',
            'Monte le feu, jette les épinards essorés et remue sans arrêt.'),
        RecipeStep('⏱',
            '3 minutes, pas plus : dès qu\'ils sont tombés, c\'est cuit.',
            minutes: 3),
        RecipeStep('🍋', 'Sel, une pointe de piment, un trait de citron.'),
      ],
    ),
  ],
  'oignon': <Recipe>[
    Recipe(
      name: 'Soupe à l\'oignon gratinée',
      emoji: '🧅',
      description:
          'Une heure de patience sur les oignons, et tout est joué.',
      minutes: 75,
      serves: 4,
      ingredients: <String>[
        '1 kg d\'oignons',
        '40 g de beurre',
        '1 cuillère à soupe de farine',
        '1,5 litre de bouillon',
        '4 tranches de pain, 150 g de gruyère',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Émince les oignons en fines lamelles.'),
        RecipeStep('🧈',
            'Fais-les blondir au beurre à feu doux **40 minutes** en remuant. '
            'C\'est toute la recette : pressé, ça ne marche pas.',
            minutes: 40),
        RecipeStep('🥄',
            'Saupoudre la farine, remue 2 minutes, puis verse le bouillon '
            'chaud.'),
        RecipeStep('⏱', 'Laisse mijoter 20 minutes.', minutes: 20),
        RecipeStep('🧀',
            'Verse en bols, pose le pain, couvre de gruyère.'),
        RecipeStep('🔥', 'Sous le gril 5 minutes, jusqu\'à la croûte.',
            minutes: 5),
      ],
    ),
    Recipe(
      name: 'Oignons confits',
      emoji: '🍯',
      description:
          'Doux et sirupeux, ils se gardent au frais et relèvent tout.',
      minutes: 60,
      serves: 6,
      ingredients: <String>[
        '1 kg d\'oignons',
        '3 cuillères à soupe de sucre',
        '5 cl de vinaigre de vin',
        '2 cuillères à soupe d\'huile',
        'sel, thym',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Émince les oignons.'),
        RecipeStep('🔥', 'Fais-les suer à l\'huile 15 minutes à couvert.',
            minutes: 15),
        RecipeStep('🍯',
            'Ajoute sucre, vinaigre, sel, thym. Découvre et laisse réduire.'),
        RecipeStep('⏱',
            'Encore 30 minutes à feu doux : ils doivent brunir et devenir '
            'sirupeux.',
            minutes: 30),
        RecipeStep('🫙',
            'En bocal, ils tiennent une semaine au réfrigérateur.'),
      ],
    ),
    Recipe(
      name: 'Tarte à l\'oignon',
      emoji: '🥧',
      description:
          'Des oignons fondus, des lardons, un appareil à la crème.',
      minutes: 65,
      serves: 6,
      ingredients: <String>[
        '1 pâte brisée',
        '800 g d\'oignons',
        '150 g de lardons',
        '20 cl de crème, 2 oeufs',
        'sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Émince les oignons, fais-les fondre 25 minutes.',
            minutes: 25),
        RecipeStep('🥓', 'Ajoute les lardons 5 minutes.', minutes: 5),
        RecipeStep('🥣', 'Bats crème, oeufs, poivre, muscade. Sale peu.'),
        RecipeStep('🥧', 'Garnis la pâte, verse l\'appareil.'),
        RecipeStep('⏱', 'Four à 190 °C, 30 minutes.', minutes: 30),
      ],
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
    Recipe(
      name: 'Parmigiana d\'aubergines',
      emoji: '🍆',
      description:
          'Des couches d\'aubergine, de tomate et de parmesan, longuement gratinées.',
      minutes: 95,
      serves: 6,
      ingredients: <String>[
        '3 grosses aubergines',
        '800 g de coulis de tomate',
        '200 g de mozzarella',
        '120 g de parmesan',
        'basilic, huile d\'olive, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍆', 'Coupe les aubergines en tranches de 1 cm.'),
        RecipeStep('🧂',
            'Sale-les et laisse-les dégorger 30 minutes : moins d\'amertume, '
            'moins d\'huile absorbée.',
            minutes: 30),
        RecipeStep('🔥',
            'Essuie-les et fais-les griller au four, 15 minutes à 220 °C, '
            'plutôt qu\'à la poêle — elles boivent moins d\'huile.',
            minutes: 15),
        RecipeStep('🍅',
            'Fais réduire le coulis 15 minutes avec du basilic et du sel.',
            minutes: 15),
        RecipeStep('🧀',
            'Monte en couches : sauce, aubergines, mozzarella, parmesan, et '
            'recommence.'),
        RecipeStep('⏱', 'Four à 180 °C, 35 minutes.', minutes: 35),
        RecipeStep('🍴',
            'Attends 15 minutes avant de couper : elle se tient beaucoup '
            'mieux.',
            minutes: 15),
      ],
    ),
    Recipe(
      name: 'Ratatouille',
      emoji: '🥘',
      description:
          'Chaque légume saisi à part, réunis à la fin : c\'est le secret.',
      minutes: 80,
      serves: 6,
      ingredients: <String>[
        '2 aubergines',
        '3 courgettes',
        '2 poivrons',
        '4 tomates',
        '2 oignons, 3 gousses d\'ail',
        'thym, laurier, huile d\'olive, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Coupe tous les légumes en cubes de même taille.'),
        RecipeStep('🍆',
            'Fais revenir les aubergines seules, à feu vif, puis réserve.'),
        RecipeStep('🥒',
            'Pareil pour les courgettes, puis les poivrons, puis les oignons. '
            'Chacun son tour, chacun son goût.'),
        RecipeStep('🍅',
            'Dans la cocotte, fais fondre tomates et ail avec thym et laurier, '
            '15 minutes.',
            minutes: 15),
        RecipeStep('🥘',
            'Réunis tout, sale, et laisse mijoter à découvert 30 minutes.',
            minutes: 30),
        RecipeStep('🌿',
            'Meilleure réchauffée le lendemain — vraiment.'),
      ],
    ),
    Recipe(
      name: 'Caviar d\'aubergine',
      emoji: '🥣',
      description:
          'Les aubergines brûlées au four, puis écrasées à l\'huile et au citron.',
      minutes: 60,
      serves: 4,
      ingredients: <String>[
        '3 aubergines',
        '1 gousse d\'ail',
        '1 citron',
        '3 cuillères à soupe d\'huile d\'olive',
        '1 cuillère à soupe de tahin (facultatif), sel, cumin',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥',
            'Pique les aubergines entières et enfourne-les à 220 °C, '
            '45 minutes, jusqu\'à ce que la peau cloque et noircisse.',
            minutes: 45),
        RecipeStep('🥄',
            'Coupe-les en deux et récupère la chair à la cuillère.'),
        RecipeStep('🫗',
            'Laisse-la égoutter 10 minutes dans une passoire.', minutes: 10),
        RecipeStep('🥣',
            'Écrase à la fourchette avec ail, citron, huile, cumin, sel. Pas '
            'au mixeur : on veut de la texture.'),
        RecipeStep('🫒', 'Un filet d\'huile dessus, avec du pain grillé.'),
      ],
    ),
  ],
  'laitue': <Recipe>[
    Recipe(
      name: 'Salade verte vinaigrette maison',
      emoji: '🥗',
      description:
          'Une laitue cueillie à l\'instant ne demande presque rien.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '1 belle laitue',
        '1 cuillère à café de moutarde',
        '1 cuillère à soupe de vinaigre',
        '3 cuillères à soupe d\'huile',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Lave les feuilles à l\'eau froide, sèche-les bien : l\'eau '
            'empêche la vinaigrette de tenir.'),
        RecipeStep('🥄',
            'Dans le fond du saladier, délaye moutarde, sel et vinaigre.'),
        RecipeStep('🫒',
            'Verse l\'huile en filet en fouettant : la sauce doit épaissir.'),
        RecipeStep('🥗',
            'Ajoute les feuilles et mélange **juste avant** de servir.'),
      ],
    ),
    Recipe(
      name: 'Laitue braisée aux petits pois',
      emoji: '🫛',
      description:
          'Oui, la laitue se cuit — fondante, avec des petits pois et un peu de lard.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '2 laitues',
        '300 g de petits pois écossés',
        '100 g de lardons',
        '1 oignon nouveau',
        '20 g de beurre, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬',
            'Coupe les laitues en quatre, garde-les attachées au trognon.'),
        RecipeStep('🥓', 'Fais dorer les lardons avec l\'oignon émincé.'),
        RecipeStep('🫛',
            'Ajoute les petits pois, les quartiers de laitue, le beurre et un '
            'fond d\'eau.'),
        RecipeStep('⏱', 'Couvre et laisse fondre 20 minutes à feu doux.',
            minutes: 20),
        RecipeStep('🧂', 'Poivre généreusement, sale peu : les lardons salent.'),
      ],
    ),
    Recipe(
      name: 'Velouté de laitue',
      emoji: '🍲',
      description:
          'La solution quand la laitue monte toute en même temps au potager.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '2 laitues (même un peu montées)',
        '2 pommes de terre',
        '1 oignon',
        '80 cl de bouillon',
        '10 cl de crème, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬',
            'Lave les laitues et hache-les grossièrement, côtes comprises.'),
        RecipeStep('🧅', 'Fais fondre l\'oignon, ajoute les pommes de terre.'),
        RecipeStep('🍲', 'Mouille au bouillon et cuis 15 minutes.', minutes: 15),
        RecipeStep('🥬',
            'Ajoute la laitue seulement **5 minutes** à la fin : au-delà elle '
            'perd sa couleur.',
            minutes: 5),
        RecipeStep('🥣', 'Mixe, ajoute la crème hors du feu, rectifie.'),
      ],
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
    Recipe(
      name: 'Carottes râpées au citron',
      emoji: '🥕',
      description:
          'Deux minutes de râpe, un citron, et la plus franche des entrées.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '6 carottes',
        '1 citron',
        '3 cuillères à soupe d\'huile',
        '1 cuillère à café de miel',
        'sel, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥕',
            'Râpe les carottes gros : trop fin, elles rendent leur eau.'),
        RecipeStep('🍋', 'Presse le citron, mélange huile, miel et sel.'),
        RecipeStep('🥗', 'Verse, mélange, laisse reposer 10 minutes.',
            minutes: 10),
        RecipeStep('🌿', 'Persil ciselé au dernier moment.'),
      ],
    ),
    Recipe(
      name: 'Carottes Vichy',
      emoji: '🧈',
      description:
          'Cuites dans leur eau avec beurre et sucre, elles se glacent toutes seules.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '800 g de carottes',
        '30 g de beurre',
        '1 cuillère à café de sucre',
        'sel, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥕', 'Coupe les carottes en rondelles épaisses.'),
        RecipeStep('🍲',
            'Mets-les dans une casserole large avec beurre, sucre, sel, et de '
            'l\'eau à mi-hauteur seulement.'),
        RecipeStep('⏱',
            'Cuis à découvert 20 minutes : l\'eau doit s\'évaporer et laisser '
            'un sirop.',
            minutes: 20),
        RecipeStep('🥄',
            'Remue en fin de cuisson pour les enrober de ce glaçage.'),
        RecipeStep('🌿', 'Persil, et à table.'),
      ],
    ),
    Recipe(
      name: 'Soupe de carottes au cumin',
      emoji: '🍲',
      description:
          'Le cumin réveille le sucré de la carotte — une soupe qui ne lasse pas.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '1 kg de carottes',
        '1 pomme de terre',
        '1 oignon',
        '1 cuillère à café de cumin',
        '1 litre de bouillon, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Fais fondre l\'oignon émincé dans un peu d\'huile.'),
        RecipeStep('🌶',
            'Ajoute le cumin et laisse-le chauffer 30 secondes : il doit '
            'sentir avant de mouiller.'),
        RecipeStep('🥕',
            'Ajoute carottes et pomme de terre en morceaux, puis le bouillon.'),
        RecipeStep('⏱', 'Cuis 25 minutes, couvercle posé.', minutes: 25),
        RecipeStep('🥣',
            'Mixe. Trop épaisse ? un peu de bouillon. Trop claire ? laisse '
            'réduire.'),
      ],
    ),
  ],
  'concombre': <Recipe>[
    Recipe(
      name: 'Tzatziki',
      emoji: '🥣',
      description:
          'Concombre râpé, yaourt grec, ail et menthe — frais et franc.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '1 concombre',
        '400 g de yaourt grec',
        '1 gousse d\'ail',
        'menthe fraîche',
        '1 cuillère à soupe d\'huile d\'olive, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥒', 'Râpe le concombre avec sa peau si elle est fine.'),
        RecipeStep('🧂',
            'Sale-le et laisse-le dégorger 15 minutes dans une passoire. '
            'C\'est l\'étape qu\'on saute et qui donne un tzatziki liquide.',
            minutes: 15),
        RecipeStep('🫗', 'Presse-le fort entre tes mains.'),
        RecipeStep('🥣',
            'Mélange au yaourt avec l\'ail écrasé, l\'huile et la menthe '
            'ciselée.'),
        RecipeStep('❄️', 'Au frais une heure avant de servir.', minutes: 60),
      ],
    ),
    Recipe(
      name: 'Soupe froide de concombre',
      emoji: '❄️',
      description:
          'Mixée crue, servie glacée : l\'entrée des jours de canicule.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '2 concombres',
        '20 cl de fromage blanc',
        '1 gousse d\'ail',
        'ciboulette, menthe',
        'sel, poivre, 1 trait de vinaigre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥒', 'Pèle les concombres et retire les graines du centre.'),
        RecipeStep('🥣',
            'Mixe avec le fromage blanc, l\'ail, le vinaigre, sel et poivre.'),
        RecipeStep('❄️',
            'Au réfrigérateur **2 heures** : tiède, cette soupe ne vaut rien.',
            minutes: 120),
        RecipeStep('🌿', 'Herbes ciselées au moment de servir.'),
      ],
    ),
    Recipe(
      name: 'Salade de concombre au yaourt',
      emoji: '🥗',
      description:
          'En rondelles fines, à peine habillées — on garde le croquant.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '1 concombre',
        '3 cuillères à soupe de yaourt',
        '1 échalote',
        'aneth ou ciboulette',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥒',
            'Coupe le concombre en rondelles très fines, à l\'économe si tu '
            'veux.'),
        RecipeStep('🧂',
            'Sale légèrement et laisse 10 minutes, puis égoutte sans presser : '
            'on veut qu\'il reste croquant.',
            minutes: 10),
        RecipeStep('🥣', 'Mélange yaourt, échalote hachée, herbes, poivre.'),
        RecipeStep('🥗', 'Assemble juste avant de passer à table.'),
      ],
    ),
  ],
  'courgette': <Recipe>[
    Recipe(
      name: 'Beignets de fleurs de courgette',
      emoji: '🌼',
      description:
          'Les fleurs mâles, en pâte légère, deux minutes dans l\'huile.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '12 fleurs de courgette mâles',
        '150 g de farine',
        '20 cl d\'eau glacée ou de bière',
        '1 pincée de sel',
        'huile de friture',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌼',
            'Cueille les fleurs mâles le matin, celles au bout d\'une tige '
            'fine — les femelles portent la courgette.'),
        RecipeStep('💧',
            'Ouvre-les, retire le pistil, secoue-les sans les laver si elles '
            'sont propres.'),
        RecipeStep('🥣',
            'Mélange farine, eau glacée et sel. La pâte doit napper, pas '
            'coller.'),
        RecipeStep('🔥', 'Chauffe l\'huile à 180 °C.'),
        RecipeStep('🍤',
            'Trempe chaque fleur, plonge-la 2 minutes, retourne à mi-cuisson.',
            minutes: 2),
        RecipeStep('🧂',
            'Égoutte sur du papier, sale tout de suite, mange tout de suite.'),
      ],
    ),
    Recipe(
      name: 'Courgettes farcies',
      emoji: '🥘',
      description:
          'Tes courgettes garnies de riz et de viande hachée, gratinées au four.',
      minutes: 70,
      serves: 4,
      ingredients: <String>[
        '4 courgettes rondes ou moyennes',
        '300 g de viande hachée',
        '100 g de riz',
        '1 oignon, 1 gousse d\'ail',
        '1 oeuf, 50 g de parmesan',
        'sel, poivre, herbes',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥', 'Préchauffe le four à 190 °C.'),
        RecipeStep('🥒',
            'Coupe les courgettes en deux, évide-les à la cuillère. Garde la '
            'chair.'),
        RecipeStep('🍚', 'Cuis le riz 10 minutes, il finira au four.',
            minutes: 10),
        RecipeStep('🧅',
            'Fais revenir oignon, ail et la chair hachée, puis la viande.'),
        RecipeStep('🥣',
            'Hors du feu, mélange avec le riz, l\'oeuf, le parmesan, sel et '
            'poivre.'),
        RecipeStep('🥘', 'Garnis les demi-courgettes, tasse bien.'),
        RecipeStep('⏱', 'Au four 40 minutes, à couvert les 20 premières.',
            minutes: 40),
      ],
    ),
    Recipe(
      name: 'Gratin de courgettes',
      emoji: '🧀',
      description:
          'Des tranches fondantes sous une croûte dorée, le plat familial par excellence.',
      minutes: 60,
      serves: 4,
      ingredients: <String>[
        '1 kg de courgettes',
        '20 cl de crème',
        '2 oeufs',
        '100 g de gruyère râpé',
        '1 gousse d\'ail, sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥒',
            'Coupe les courgettes en rondelles de 5 mm, sans les peler.'),
        RecipeStep('🧂',
            'Sale-les et laisse-les dégorger 20 minutes : c\'est ce qui évite '
            'le gratin à l\'eau.',
            minutes: 20),
        RecipeStep('🔥',
            'Presse-les dans un torchon, puis fais-les suer 10 minutes à la '
            'poêle.',
            minutes: 10),
        RecipeStep('🥣',
            'Bats crème, oeufs, muscade, l\'ail écrasé, sel et poivre.'),
        RecipeStep('🧀',
            'Dans le plat : courgettes, appareil, fromage par-dessus.'),
        RecipeStep('⏱', 'Four à 180 °C, 30 minutes jusqu\'à la croûte dorée.',
            minutes: 30),
      ],
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
    Recipe(
      name: 'Persillade',
      emoji: '🌿',
      description:
          'Ail et persil hachés ensemble, jetés à la fin sur tout et n\'importe quoi.',
      minutes: 5,
      serves: 4,
      ingredients: <String>[
        '1 bouquet de persil plat',
        '2 gousses d\'ail',
        'sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌿', 'Effeuille le persil, garde-le bien sec.'),
        RecipeStep('🔪',
            'Hache l\'ail et le persil **ensemble** : les deux parfums se '
            'mêlent au couteau.'),
        RecipeStep('🔥',
            'Jette-la dans la poêle **hors du feu** ou juste avant de servir. '
            'Cuite, elle brunit et amère.'),
      ],
    ),
    Recipe(
      name: 'Salsa verde',
      emoji: '🥣',
      description:
          'Persil, câpres, anchois, citron : la sauce qui réveille un poisson.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '1 gros bouquet de persil plat',
        '2 cuillères à soupe de câpres',
        '4 filets d\'anchois',
        '1 citron',
        '10 cl d\'huile d\'olive, 1 gousse d\'ail',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Hache persil, câpres, anchois et ail au couteau, assez gros.'),
        RecipeStep('🍋', 'Ajoute le zeste et le jus du citron.'),
        RecipeStep('🫒',
            'Détends à l\'huile : elle doit napper, pas couler.'),
        RecipeStep('🧂',
            'Goûte avant de saler — anchois et câpres salent beaucoup.'),
      ],
    ),
    Recipe(
      name: 'Poisson braisé au persil',
      emoji: '🐟',
      description:
          'Un poisson entier farci d\'herbes, braisé avec des tomates.',
      minutes: 45,
      serves: 4,
      ingredients: <String>[
        '1 poisson entier de 1 kg',
        '1 bouquet de persil',
        '3 tomates, 1 oignon',
        '2 gousses d\'ail, 1 citron',
        'huile, sel, poivre, piment',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌿',
            'Hache persil, ail, sel, piment. Entaille le poisson et farcis '
            'les entailles.'),
        RecipeStep('❄️',
            'Laisse-le prendre le goût 20 minutes au frais.', minutes: 20),
        RecipeStep('🔥', 'Saisis-le 3 minutes de chaque côté dans l\'huile.'),
        RecipeStep('🍅',
            'Ajoute oignon et tomates en morceaux, un verre d\'eau, couvre.'),
        RecipeStep('⏱', 'Braise 15 minutes à feu moyen.', minutes: 15),
        RecipeStep('🍋', 'Citron pressé dessus au moment de servir.'),
      ],
    ),
  ],
  'basilic': <Recipe>[
    Recipe(
      name: 'Pistou',
      emoji: '🌿',
      description:
          'Basilic, ail et huile, sans pignons : la version provençale.',
      minutes: 10,
      serves: 6,
      ingredients: <String>[
        '2 gros bouquets de basilic',
        '4 gousses d\'ail',
        '15 cl d\'huile d\'olive',
        '60 g de parmesan (facultatif)',
        'gros sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌿',
            'Effeuille le basilic. Les tiges amères ne vont pas au mortier.'),
        RecipeStep('🧄', 'Pile l\'ail au gros sel, puis ajoute les feuilles.'),
        RecipeStep('💪',
            'Écrase en tournant, par petites poignées : au mortier le basilic '
            'rend son parfum, au mixeur il chauffe et noircit.'),
        RecipeStep('🫒', 'Monte à l\'huile en filet jusqu\'à une pommade.'),
      ],
    ),
    Recipe(
      name: 'Soupe au pistou',
      emoji: '🍲',
      description:
          'Tous les légumes d\'été, et une cuillère de pistou au dernier moment.',
      minutes: 60,
      serves: 6,
      ingredients: <String>[
        '300 g de haricots blancs frais',
        '2 courgettes, 2 carottes, 2 pommes de terre',
        '200 g de haricots verts',
        '3 tomates',
        '100 g de pâtes courtes, pistou, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🫘',
            'Fais cuire les haricots blancs 30 minutes dans de l\'eau non '
            'salée.',
            minutes: 30),
        RecipeStep('🥕',
            'Ajoute les légumes en dés, du plus dur au plus tendre, et sale.'),
        RecipeStep('⏱', 'Cuis 20 minutes.', minutes: 20),
        RecipeStep('🍝', 'Ajoute les pâtes les 10 dernières minutes.',
            minutes: 10),
        RecipeStep('🌿',
            'Le pistou se met **hors du feu**, dans la soupière ou dans '
            'l\'assiette. Cuit, il perd tout.'),
      ],
    ),
    Recipe(
      name: 'Pesto maison',
      emoji: '🥣',
      description:
          'Avec pignons et parmesan, la version génoise, pour les pâtes.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '80 g de feuilles de basilic',
        '40 g de pignons',
        '60 g de parmesan',
        '1 gousse d\'ail',
        '12 cl d\'huile d\'olive, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥', 'Torréfie les pignons 2 minutes à sec.', minutes: 2),
        RecipeStep('🌿',
            'Mixe basilic, ail, pignons par à-coups pour ne pas chauffer.'),
        RecipeStep('🧀', 'Ajoute le parmesan, puis l\'huile en filet.'),
        RecipeStep('🍝',
            'Pour les pâtes : détends-le avec une cuillère d\'eau de cuisson, '
            'jamais sur le feu.'),
      ],
    ),
  ],
  'haricot': <Recipe>[
    Recipe(
      name: 'Haricots verts à la tomate',
      emoji: '🍅',
      description:
          'Mijotés dans une sauce tomate à l\'ail, à l\'huile d\'olive.',
      minutes: 45,
      serves: 4,
      ingredients: <String>[
        '800 g de haricots verts',
        '4 tomates',
        '1 oignon, 2 gousses d\'ail',
        '3 cuillères à soupe d\'huile d\'olive',
        'sel, poivre, thym',
      ],
      steps: <RecipeStep>[
        RecipeStep('🫛', 'Équeute les haricots, garde-les entiers.'),
        RecipeStep('🧅',
            'Fais fondre oignon et ail à l\'huile, ajoute les tomates '
            'concassées.'),
        RecipeStep('⏱', 'Laisse réduire 10 minutes.', minutes: 10),
        RecipeStep('🫛',
            'Ajoute les haricots, sale, couvre, et laisse 25 minutes à feu '
            'doux.',
            minutes: 25),
        RecipeStep('🌿',
            'Encore meilleurs tièdes, ou le lendemain.'),
      ],
    ),
    Recipe(
      name: 'Salade de haricots verts aux amandes',
      emoji: '🥗',
      description:
          'Cuits croquants, refroidis net, avec des amandes grillées.',
      minutes: 25,
      serves: 4,
      ingredients: <String>[
        '600 g de haricots verts',
        '60 g d\'amandes effilées',
        '1 échalote',
        'moutarde, vinaigre, huile',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Plonge les haricots dans une grande eau bouillante très salée.'),
        RecipeStep('⏱',
            '8 minutes : ils doivent plier sans casser.', minutes: 8),
        RecipeStep('❄️',
            'Égoutte et plonge-les aussitôt dans l\'eau glacée. C\'est ce qui '
            'fixe le vert.'),
        RecipeStep('🔥', 'Fais dorer les amandes à sec, 2 minutes.', minutes: 2),
        RecipeStep('🥗',
            'Vinaigrette à l\'échalote, amandes par-dessus au dernier moment.'),
      ],
    ),
    Recipe(
      name: 'Haricots verts sautés',
      emoji: '🧄',
      description:
          'Blanchis puis jetés à la poêle avec de l\'ail et du beurre.',
      minutes: 20,
      serves: 4,
      ingredients: <String>[
        '600 g de haricots verts',
        '2 gousses d\'ail',
        '30 g de beurre',
        'sel, poivre, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧', 'Blanchis les haricots 7 minutes à l\'eau salée.',
            minutes: 7),
        RecipeStep('🫗', 'Égoutte-les et sèche-les bien.'),
        RecipeStep('🧄',
            'Beurre dans la poêle, l\'ail émincé, puis les haricots.'),
        RecipeStep('🔥',
            '5 minutes à feu vif en remuant : quelques marques dorées, c\'est '
            'parfait.',
            minutes: 5),
        RecipeStep('🌿', 'Persil, poivre.'),
      ],
    ),
  ],
  'betterave': <Recipe>[
    Recipe(
      name: 'Betteraves rôties au four',
      emoji: '🔥',
      description:
          'Cuites en robe, elles concentrent leur sucre au lieu de le perdre dans l\'eau.',
      minutes: 75,
      serves: 4,
      ingredients: <String>[
        '6 betteraves moyennes',
        '2 cuillères à soupe d\'huile d\'olive',
        'gros sel, thym',
        '1 cuillère à soupe de vinaigre balsamique',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧼',
            'Brosse les betteraves sans les peler, coupe les fanes à 2 cm.'),
        RecipeStep('🫒',
            'Enrobe d\'huile, roule dans le gros sel, pose sur une plaque.'),
        RecipeStep('⏱',
            'Four à 200 °C, 60 minutes. Un couteau doit entrer sans '
            'résistance.',
            minutes: 60),
        RecipeStep('🧤',
            'Tiédies, la peau se retire au doigt — et ne tache pas les mains '
            'comme à cru.'),
        RecipeStep('🍯', 'Coupe en quartiers, un trait de balsamique.'),
      ],
    ),
    Recipe(
      name: 'Betterave chèvre et noix',
      emoji: '🧀',
      description:
          'Le trio qui ne rate jamais : le sucré, l\'acide et le croquant.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '4 betteraves cuites',
        '150 g de fromage de chèvre frais',
        '60 g de cerneaux de noix',
        '1 cuillère à soupe de miel',
        'huile, vinaigre, sel, poivre, ciboulette',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔴', 'Coupe les betteraves en dés réguliers.'),
        RecipeStep('🥄', 'Mélange huile, vinaigre, miel, sel, poivre.'),
        RecipeStep('🧀',
            'Dresse les dés, émiette le chèvre dessus, parsème les noix.'),
        RecipeStep('🌿',
            'Verse la sauce au dernier moment, ciboulette, et sers frais.'),
      ],
    ),
    Recipe(
      name: 'Soupe de betterave à l\'aneth',
      emoji: '🍲',
      description:
          'Une couleur impossible, et un goût de terre douce que l\'aneth éclaire.',
      minutes: 45,
      serves: 4,
      ingredients: <String>[
        '600 g de betteraves',
        '1 pomme de terre',
        '1 oignon',
        '80 cl de bouillon',
        '10 cl de crème, aneth, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Fais fondre l\'oignon émincé.'),
        RecipeStep('🔴',
            'Ajoute betteraves et pomme de terre en dés, puis le bouillon.'),
        RecipeStep('⏱', 'Cuis 30 minutes à couvert.', minutes: 30),
        RecipeStep('🥣', 'Mixe longuement : la betterave demande à être lisse.'),
        RecipeStep('🌿',
            'Crème hors du feu, beaucoup d\'aneth ciselé. Bon chaud comme '
            'glacé.'),
      ],
    ),
  ],
  'potiron': <Recipe>[
    Recipe(
      name: 'Soupe de potiron au lait de coco',
      emoji: '🥥',
      description:
          'Le lait de coco adoucit le potiron et lui donne du corps.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '1 kg de potiron',
        '40 cl de lait de coco',
        '1 oignon, 1 gousse d\'ail',
        '1 cuillère à café de gingembre râpé',
        '50 cl de bouillon, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃',
            'Épluche le potiron et coupe-le en gros cubes. Garde les graines : '
            'grillées au four, elles font un en-cas.'),
        RecipeStep('🧅',
            'Fais fondre oignon, ail et gingembre dans un peu d\'huile.'),
        RecipeStep('🍲', 'Ajoute le potiron et le bouillon, à hauteur.'),
        RecipeStep('⏱', 'Cuis 25 minutes à couvert.', minutes: 25),
        RecipeStep('🥥',
            'Verse le lait de coco, mixe, rectifie. Ne fais plus bouillir '
            'après : le coco se sépare.'),
      ],
    ),
    Recipe(
      name: 'Gratin de potiron',
      emoji: '🧀',
      description:
          'Fondant dessous, gratiné dessus, avec une pointe de muscade.',
      minutes: 70,
      serves: 6,
      ingredients: <String>[
        '1,2 kg de potiron',
        '20 cl de crème',
        '2 oeufs',
        '120 g de comté râpé',
        '2 cuillères à soupe de chapelure, sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃', 'Coupe le potiron en cubes et cuis-le 15 minutes.',
            minutes: 15),
        RecipeStep('🫗',
            'Égoutte-le très soigneusement et écrase-le à la fourchette : le '
            'potiron est gorgé d\'eau.'),
        RecipeStep('🥣',
            'Mélange avec crème, oeufs, la moitié du fromage, muscade, sel, '
            'poivre.'),
        RecipeStep('🧀',
            'Verse dans le plat, reste de fromage et chapelure par-dessus.'),
        RecipeStep('⏱', 'Four à 180 °C, 40 minutes.', minutes: 40),
      ],
    ),
    Recipe(
      name: 'Soupe au potiron',
      emoji: '🍲',
      description:
          'La version sans détour : potiron, pomme de terre, un peu de beurre.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '800 g de potiron',
        '2 pommes de terre',
        '1 oignon',
        '80 cl d\'eau ou de bouillon',
        '30 g de beurre, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃', 'Coupe potiron, pommes de terre et oignon en cubes.'),
        RecipeStep('🍲',
            'Mets tout dans la casserole, mouille à hauteur, sale.'),
        RecipeStep('⏱', 'Cuis 25 minutes, jusqu\'à ce que tout s\'écrase.',
            minutes: 25),
        RecipeStep('🧈', 'Mixe avec le beurre : c\'est lui qui fait le velouté.'),
      ],
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
      emoji: '🥗',
      description:
          'Tièdes, bien égouttés, avec une vinaigrette à l\'échalote.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '8 poireaux moyens',
        '1 échalote',
        '1 cuillère à café de moutarde',
        '1 cuillère à soupe de vinaigre',
        '3 cuillères à soupe d\'huile, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧼',
            'Fends le blanc en deux dans la longueur et rince : la terre se '
            'cache entre les feuilles.'),
        RecipeStep('💧',
            'Cuis 15 minutes à l\'eau bouillante salée, jusqu\'à ce qu\'un '
            'couteau traverse sans effort.',
            minutes: 15),
        RecipeStep('🫗',
            'Égoutte-les **debout** dans une passoire, 10 minutes : c\'est ce '
            'qui évite l\'assiette noyée.',
            minutes: 10),
        RecipeStep('🥄',
            'Vinaigrette : échalote hachée, moutarde, vinaigre, puis l\'huile '
            'en filet.'),
        RecipeStep('🍽', 'Nappe les poireaux encore tièdes.'),
      ],
    ),
    Recipe(
      name: 'Flamiche aux poireaux',
      emoji: '🥧',
      description:
          'La tarte du Nord : des poireaux fondus à la crème, sous une pâte.',
      minutes: 70,
      serves: 6,
      ingredients: <String>[
        '1 pâte brisée',
        '1 kg de poireaux',
        '20 cl de crème',
        '2 oeufs',
        '40 g de beurre, sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬', 'Émince les blancs de poireaux en fines rondelles.'),
        RecipeStep('🧈',
            'Fais-les fondre au beurre à couvert, 25 minutes, sans les '
            'colorer.',
            minutes: 25),
        RecipeStep('🫗',
            'Laisse-les tiédir et égoutte l\'eau rendue, sinon la tarte sera '
            'molle.'),
        RecipeStep('🥣', 'Mélange crème, oeufs, sel, poivre, muscade.'),
        RecipeStep('🥧', 'Garnis la pâte des poireaux, verse l\'appareil.'),
        RecipeStep('⏱', 'Four à 190 °C, 35 minutes.', minutes: 35),
      ],
    ),
    Recipe(
      name: 'Fondue de poireaux',
      emoji: '🧈',
      description:
          'La base qui accompagne un poisson, garnit une quiche ou se mange seule.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '6 poireaux',
        '30 g de beurre',
        '10 cl de crème',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬', 'Émince les blancs finement, rince, égoutte.'),
        RecipeStep('🧈',
            'Beurre dans la sauteuse, les poireaux, une pincée de sel, '
            'couvercle.'),
        RecipeStep('⏱',
            'Feu très doux 25 minutes. Ils doivent fondre, jamais roussir.',
            minutes: 25),
        RecipeStep('🥛', 'Crème hors du feu, poivre, et c\'est prêt.'),
      ],
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
      emoji: '🧈',
      description:
          'Beurre, sucre, un fond d\'eau : ils sortent brillants.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '800 g de navets',
        '30 g de beurre',
        '1 cuillère à café de sucre',
        'sel, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Pèle les navets et coupe-les en quartiers réguliers.'),
        RecipeStep('🍲',
            'Casserole large : beurre, sucre, sel, eau à mi-hauteur.'),
        RecipeStep('⏱',
            'Cuis à découvert 20 minutes, l\'eau doit s\'évaporer en sirop.',
            minutes: 20),
        RecipeStep('🥄', 'Remue pour les enrober, persil, et sers chaud.'),
      ],
    ),
    Recipe(
      name: 'Purée de navets',
      emoji: '🥣',
      description:
          'Moitié navet, moitié pomme de terre : plus légère qu\'une purée classique.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '500 g de navets',
        '500 g de pommes de terre',
        '20 cl de lait',
        '40 g de beurre',
        'sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Pèle et coupe navets et pommes de terre en morceaux égaux.'),
        RecipeStep('💧', 'Cuis-les à l\'eau salée 20 minutes.', minutes: 20),
        RecipeStep('🫗',
            'Égoutte et laisse-les sécher 2 minutes sur le feu éteint : une '
            'purée de navets tourne vite à la soupe.'),
        RecipeStep('🥣',
            'Écrase au presse-purée, pas au mixeur, avec le lait chaud et le '
            'beurre.'),
        RecipeStep('🧂', 'Sel, poivre, muscade.'),
      ],
    ),
    Recipe(
      name: 'Navets au miel et thym',
      emoji: '🍯',
      description:
          'Le miel prend le dessus sur l\'amertume des gros navets d\'hiver.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '800 g de navets',
        '2 cuillères à soupe de miel',
        '20 g de beurre',
        'thym, sel, poivre, 1 trait de vinaigre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Coupe les navets en gros dés.'),
        RecipeStep('🔥', 'Fais-les colorer au beurre à feu vif, 5 minutes.',
            minutes: 5),
        RecipeStep('🍯',
            'Ajoute miel, thym, sel, un trait de vinaigre, un fond d\'eau.'),
        RecipeStep('⏱', 'Couvre et laisse 20 minutes à feu doux.', minutes: 20),
        RecipeStep('🔥',
            'Découvre à la fin pour faire réduire et caraméliser.'),
      ],
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
      name: 'Confiture de fraises',
      emoji: '🫙',
      description:
          'Poids pour poids avec le sucre, un citron, et la cuisine sent l\'été.',
      minutes: 60,
      serves: 8,
      ingredients: <String>[
        '1 kg de fraises équeutées',
        '700 g de sucre',
        'le jus d\'un citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('🍓',
            'Coupe les grosses fraises en deux, laisse les petites entières.'),
        RecipeStep('🍬',
            'Mélange-les au sucre et au citron, laisse macérer au frais. Le '
            'jus sort tout seul.',
            minutes: 120),
        RecipeStep('🔥', 'Porte à ébullition et cuis à feu vif en écumant.',
            minutes: 20),
        RecipeStep('🥄',
            'Teste sur une assiette froide : une goutte qui se fige est '
            'prête.'),
        RecipeStep('🫙',
            'Mets en pots chauds, ferme et retourne jusqu\'à refroidissement.'),
      ],
    ),
    Recipe(
      name: 'Tarte aux fraises',
      emoji: '🥧',
      description:
          'Pâte sablée, crème pâtissière, fraises crues rangées dessus.',
      minutes: 90,
      serves: 6,
      ingredients: <String>[
        '1 pâte sablée',
        '600 g de fraises',
        '50 cl de lait',
        '4 jaunes d\'oeufs, 100 g de sucre',
        '50 g de maïzena, 1 gousse de vanille',
        '2 cuillères à soupe de gelée de groseille',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥧',
            'Étale la pâte, pique-la, couvre-la de papier et de légumes secs.'),
        RecipeStep('🔥',
            'Cuis-la **à blanc** 25 minutes à 180 °C : une pâte crue sous la '
            'crème détrempe en une heure.',
            minutes: 25),
        RecipeStep('🥛',
            'Fais chauffer le lait avec la vanille fendue.'),
        RecipeStep('🥚',
            'Fouette jaunes, sucre et maïzena, puis verse le lait chaud '
            'dessus en remuant.'),
        RecipeStep('🔥',
            'Remets sur le feu et fouette **sans arrêt** jusqu\'à ce que ça '
            'épaississe. Dès les premiers bouillons, c\'est prêt.',
            minutes: 5),
        RecipeStep('❄️',
            'Verse la crème sur une assiette, filme au contact, et laisse '
            'refroidir complètement.',
            minutes: 60),
        RecipeStep('🍓',
            'Garnis le fond de tarte de crème lissée, range les fraises '
            'coupées en deux, pointe vers le haut.'),
        RecipeStep('✨',
            'Fais fondre la gelée avec une cuillère d\'eau et badigeonne les '
            'fraises : c\'est ce qui les fait briller.'),
      ],
    ),
    Recipe(
      name: 'Fraises au sucre et menthe',
      emoji: '🍓',
      description:
          'Coupées une heure avant, elles rendent un sirop qu\'on sauce au pain.',
      minutes: 10,
      serves: 4,
      uses: <String>['menthe'],
      ingredients: <String>[
        '500 g de fraises',
        '2 cuillères à soupe de sucre',
        'une dizaine de feuilles de menthe',
        '1/2 citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Lave les fraises **avant** de les équeuter, sinon elles se '
            'gorgent d\'eau par la blessure.'),
        RecipeStep('🔪', 'Équeute-les et coupe-les en deux ou en quatre.'),
        RecipeStep('🍬',
            'Sucre-les, ajoute un trait de citron, mélange une fois.'),
        RecipeStep('⏱',
            'Laisse-les une heure à température ambiante : le sucre tire le '
            'jus et fait le sirop. Au réfrigérateur, ça ne marche qu\'à '
            'moitié.',
            minutes: 60),
        RecipeStep('🌿',
            'Déchire la menthe à la main juste avant de servir.'),
      ],
    ),
  ],
  'ail': <Recipe>[
    Recipe(
      name: 'Soupe à l\'ail',
      emoji: '🍲',
      description: 'Douce et réconfortante — l\'ail cuit perd toute sa morsure.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '2 têtes d\'ail',
        '1 litre de bouillon',
        '2 jaunes d\'oeufs',
        '4 tranches de pain',
        'huile d\'olive, thym, laurier, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧄',
            'Pèle les gousses et écrase-les à peine sous la lame.'),
        RecipeStep('🍲',
            'Fais-les blondir doucement à l\'huile, sans les brunir : brûlé, '
            'l\'ail devient amer.'),
        RecipeStep('💧',
            'Ajoute le bouillon, thym, laurier, et laisse frémir 20 minutes.',
            minutes: 20),
        RecipeStep('🥚',
            'Hors du feu, délaye les jaunes avec une louche de bouillon, puis '
            'reverse en fouettant.'),
        RecipeStep('🍞', 'Sers sur du pain grillé frotté d\'ail.'),
      ],
    ),
    Recipe(
      name: 'Aïoli',
      emoji: '🥣',
      description: 'Ail pilé, jaune d\'œuf, huile d\'olive en filet. Du muscle.',
      minutes: 15,
      serves: 4,
      ingredients: <String>[
        '4 gousses d\'ail',
        '1 jaune d\'oeuf',
        '20 cl d\'huile d\'olive',
        '1/2 citron, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧄',
            'Pile l\'ail avec du gros sel au mortier, jusqu\'à une crème.'),
        RecipeStep('🥚',
            'Ajoute le jaune, à température ambiante — froid, l\'émulsion '
            'rate.'),
        RecipeStep('🫒',
            'Verse l\'huile **goutte à goutte** en tournant toujours dans le '
            'même sens.'),
        RecipeStep('💪',
            'Quand ça monte, tu peux accélérer. Si ça tranche : repars d\'un '
            'jaune neuf et reverse l\'aïoli raté dessus.'),
        RecipeStep('🍋', 'Citron et sel pour finir.'),
      ],
    ),
    Recipe(
      name: 'Ail confit à l\'huile',
      emoji: '🫙',
      description:
          'Des gousses entières fondues à feu très doux, à tartiner.',
      minutes: 50,
      serves: 8,
      ingredients: <String>[
        '4 têtes d\'ail',
        '25 cl d\'huile d\'olive',
        'thym, laurier',
        'sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧄', 'Sépare les gousses, pèle-les sans les abîmer.'),
        RecipeStep('🫒',
            'Couvre-les d\'huile dans une petite casserole, avec les herbes.'),
        RecipeStep('⏱',
            'Feu **très** doux 40 minutes : l\'huile doit à peine frémir. '
            'Si elle bout, l\'ail frit au lieu de confire.',
            minutes: 40),
        RecipeStep('🫙',
            'En bocal avec son huile, au frais, deux semaines. L\'huile '
            'parfumée se garde pour les salades.'),
      ],
    ),
  ],
  'echalote': <Recipe>[
    Recipe(
      name: 'Sauce échalote au vin rouge',
      emoji: '🍷',
      description:
          'La sauce des steaks : des échalotes fondues dans le vin réduit.',
      minutes: 25,
      serves: 4,
      ingredients: <String>[
        '6 échalotes',
        '25 cl de vin rouge',
        '40 g de beurre froid',
        '1 cuillère à café de sucre',
        'thym, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Hache les échalotes très finement.'),
        RecipeStep('🧈',
            'Fais-les fondre dans un peu de beurre, 8 minutes, sans colorer.',
            minutes: 8),
        RecipeStep('🍷',
            'Verse le vin, le sucre, le thym, et laisse réduire des deux '
            'tiers.',
            minutes: 12),
        RecipeStep('🧈',
            'Hors du feu, incorpore le beurre **froid** en morceaux, en '
            'tournant : c\'est ce qui lie et fait briller.'),
        RecipeStep('🧂', 'Sel, poivre, et sers aussitôt.'),
      ],
    ),
    Recipe(
      name: 'Échalotes confites',
      emoji: '🍯',
      description:
          'Entières, au four, avec du vinaigre balsamique et du thym.',
      minutes: 55,
      serves: 4,
      ingredients: <String>[
        '500 g d\'échalotes',
        '2 cuillères à soupe de miel',
        '3 cuillères à soupe de vinaigre balsamique',
        '2 cuillères à soupe d\'huile',
        'thym, gros sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅',
            'Pèle les échalotes en les gardant entières, racine coupée court.'),
        RecipeStep('🥣', 'Mélange-les à l\'huile, au miel, au vinaigre.'),
        RecipeStep('⏱',
            'Four à 180 °C, 45 minutes, en remuant deux fois.', minutes: 45),
        RecipeStep('🍯',
            'Elles doivent être tendres au couteau et luisantes. Bon chaud ou '
            'froid, avec une viande ou un fromage.'),
      ],
    ),
    Recipe(
      name: 'Vinaigrette à l\'échalote',
      emoji: '🥗',
      description:
          'L\'échalote hachée adoucie par le vinaigre : la base de tout.',
      minutes: 10,
      serves: 6,
      ingredients: <String>[
        '2 échalotes',
        '3 cuillères à soupe de vinaigre de vin',
        '1 cuillère à café de moutarde',
        '8 cuillères à soupe d\'huile',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Hache les échalotes le plus fin possible.'),
        RecipeStep('🍶',
            'Laisse-les macérer 10 minutes dans le vinaigre salé : elles '
            'perdent leur agressivité.',
            minutes: 10),
        RecipeStep('🥄', 'Ajoute la moutarde, mélange.'),
        RecipeStep('🫒',
            'Huile en filet en fouettant. Se garde une semaine au frais.'),
      ],
    ),
  ],
  'celeri': <Recipe>[
    Recipe(
      name: 'Céleri rémoulade',
      emoji: '🥗',
      description:
          'Râpé cru dans une mayonnaise moutardée — le classique des charcutiers.',
      minutes: 20,
      serves: 4,
      ingredients: <String>[
        '1 céleri-rave',
        '1 jaune d\'oeuf',
        '1 cuillère à soupe de moutarde',
        '15 cl d\'huile',
        '1 citron, sel, poivre, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬',
            'Pèle le céleri et râpe-le en julienne, pas trop fin.'),
        RecipeStep('🍋',
            'Citronne-le aussitôt : il noircit en quelques minutes à l\'air.'),
        RecipeStep('🥣',
            'Monte une mayonnaise moutardée : jaune, moutarde, sel, puis '
            'l\'huile en filet.'),
        RecipeStep('🥗', 'Mélange, poivre, persil.'),
        RecipeStep('❄️',
            'Une heure au frais : le céleri s\'attendrit un peu.', minutes: 60),
      ],
    ),
    Recipe(
      name: 'Purée de céleri-rave',
      emoji: '🥣',
      description:
          'Plus fine qu\'une purée de pommes de terre, et moins lourde.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '1 céleri-rave (800 g)',
        '2 pommes de terre',
        '20 cl de lait',
        '40 g de beurre',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪', 'Coupe céleri et pommes de terre en cubes égaux.'),
        RecipeStep('🥛',
            'Cuis-les dans du lait coupé d\'eau, 25 minutes : le céleri y '
            'perd son amertume.',
            minutes: 25),
        RecipeStep('🫗', 'Égoutte en gardant un peu du liquide.'),
        RecipeStep('🥣',
            'Écrase avec le beurre, détends au liquide réservé.'),
        RecipeStep('🧂', 'Sel, poivre. Très bon avec du gibier.'),
      ],
    ),
    Recipe(
      name: 'Velouté de céleri aux noisettes',
      emoji: '🌰',
      description:
          'La noisette torréfiée épouse le céleri comme personne.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '1 céleri-rave',
        '1 pomme de terre, 1 oignon',
        '80 cl de bouillon',
        '60 g de noisettes',
        '10 cl de crème, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🌰',
            'Torréfie les noisettes 8 minutes au four à 170 °C, puis frotte-les '
            'pour ôter la peau.',
            minutes: 8),
        RecipeStep('🧅', 'Fais fondre l\'oignon, ajoute céleri et pomme de terre.'),
        RecipeStep('🍲', 'Bouillon à hauteur, cuis 25 minutes.', minutes: 25),
        RecipeStep('🥣', 'Mixe avec la moitié des noisettes et la crème.'),
        RecipeStep('🌰',
            'Reste de noisettes concassées sur le velouté, pour le croquant.'),
      ],
    ),
  ],
  'fenouil': <Recipe>[
    Recipe(
      name: 'Fenouil braisé à l\'orange',
      emoji: '🍊',
      description:
          'L\'orange contre l\'anis du fenouil : un accord évident.',
      minutes: 50,
      serves: 4,
      ingredients: <String>[
        '4 bulbes de fenouil',
        '2 oranges',
        '2 cuillères à soupe d\'huile d\'olive',
        '1 cuillère à café de miel',
        'sel, poivre, graines de fenouil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Coupe les bulbes en quartiers, garde un peu de coeur pour les '
            'tenir.'),
        RecipeStep('🔥', 'Fais-les colorer à l\'huile sur les deux faces.'),
        RecipeStep('🍊',
            'Verse le jus des oranges, le miel, les graines, sale.'),
        RecipeStep('⏱',
            'Couvre et braise 30 minutes à feu doux.', minutes: 30),
        RecipeStep('🔥',
            'Découvre 5 minutes pour faire réduire le jus en sirop.',
            minutes: 5),
      ],
    ),
    Recipe(
      name: 'Salade de fenouil cru',
      emoji: '🥗',
      description:
          'Tranché à la mandoline, citron et huile : croquant et net.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '2 bulbes de fenouil',
        '1 citron',
        '4 cuillères à soupe d\'huile d\'olive',
        'parmesan en copeaux',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Tranche le fenouil le plus fin possible, en travers du bulbe.'),
        RecipeStep('🍋',
            'Arrose aussitôt de citron : il noircit sinon, comme une pomme.'),
        RecipeStep('🫒', 'Huile, sel, poivre, mélange.'),
        RecipeStep('🧀',
            'Copeaux de parmesan dessus, et les petites plumes du fenouil.'),
      ],
    ),
    Recipe(
      name: 'Fenouil gratiné',
      emoji: '🧀',
      description:
          'Précuit puis gratiné à la crème : il devient tout doux.',
      minutes: 55,
      serves: 4,
      ingredients: <String>[
        '4 bulbes de fenouil',
        '20 cl de crème',
        '80 g de parmesan',
        '2 cuillères à soupe de chapelure',
        'sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Cuis les bulbes coupés en deux 20 minutes à l\'eau salée.',
            minutes: 20),
        RecipeStep('🫗', 'Égoutte-les bien, pose-les dans le plat.'),
        RecipeStep('🥛', 'Nappe de crème, sel, poivre.'),
        RecipeStep('🧀', 'Parmesan et chapelure par-dessus.'),
        RecipeStep('⏱', 'Four à 200 °C, 25 minutes.', minutes: 25),
      ],
    ),
  ],
  'blette': <Recipe>[
    Recipe(
      name: 'Blettes à la crème',
      emoji: '🥛',
      description:
          'Vert et côtes cuits séparément, réunis dans une crème au citron.',
      minutes: 40,
      serves: 4,
      ingredients: <String>[
        '1 botte de blettes',
        '20 cl de crème',
        '20 g de beurre',
        '1/2 citron',
        'sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Sépare le vert des côtes : ils ne cuisent pas en même temps.'),
        RecipeStep('💧',
            'Cuis les côtes 15 minutes à l\'eau citronnée — le citron les '
            'empêche de noircir.',
            minutes: 15),
        RecipeStep('🥬', 'Fais tomber le vert 5 minutes à la poêle beurrée.',
            minutes: 5),
        RecipeStep('🫗', 'Égoutte tout soigneusement.'),
        RecipeStep('🥛',
            'Réunis avec la crème, laisse épaissir 5 minutes, muscade.',
            minutes: 5),
      ],
    ),
    Recipe(
      name: 'Tourte de blettes niçoise',
      emoji: '🥧',
      description:
          'La tourte sucrée du pays niçois : blettes, raisins secs, pignons.',
      minutes: 80,
      serves: 8,
      ingredients: <String>[
        '2 pâtes brisées',
        'le vert d\'une botte de blettes',
        '2 pommes',
        '60 g de raisins secs, 40 g de pignons',
        '80 g de sucre, 1 oeuf, 1 citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬',
            'Hache finement le vert des blettes, cru — il ne se cuit pas '
            'avant.'),
        RecipeStep('🍎',
            'Mélange-le aux pommes râpées, raisins, pignons, sucre, zeste de '
            'citron.'),
        RecipeStep('🥧', 'Garnis la première pâte, couvre de la seconde, '
            'soude les bords.'),
        RecipeStep('🥚', 'Dore à l\'oeuf battu et pique le dessus.'),
        RecipeStep('⏱', 'Four à 180 °C, 45 minutes.', minutes: 45),
        RecipeStep('🍬', 'Sucre glace à froid. Surprenant, et très bon.'),
      ],
    ),
    Recipe(
      name: 'Gratin de côtes de blettes',
      emoji: '🧀',
      description:
          'Les côtes, qu\'on jette trop souvent, sous une béchamel légère.',
      minutes: 60,
      serves: 4,
      ingredients: <String>[
        'les côtes de 2 bottes de blettes',
        '40 g de beurre, 40 g de farine',
        '50 cl de lait',
        '100 g de gruyère',
        'sel, poivre, muscade, 1/2 citron',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔪',
            'Pèle les fils des côtes à l\'économe et coupe-les en tronçons.'),
        RecipeStep('💧', 'Cuis-les 20 minutes à l\'eau citronnée salée.',
            minutes: 20),
        RecipeStep('🥛',
            'Béchamel : beurre fondu, farine 2 minutes, lait chaud en '
            'fouettant.'),
        RecipeStep('🧀',
            'Mélange les côtes égouttées à la béchamel, verse dans le plat, '
            'fromage dessus.'),
        RecipeStep('⏱', 'Four à 190 °C, 25 minutes.', minutes: 25),
      ],
    ),
  ],
  'mache': <Recipe>[
    Recipe(
      name: 'Mâche, betterave et noix',
      emoji: '🥗',
      description:
          'La salade d\'hiver par excellence, trois ingrédients et c\'est tout.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '200 g de mâche',
        '2 betteraves cuites',
        '60 g de cerneaux de noix',
        '1 cuillère à café de moutarde',
        'vinaigre de cidre, huile de noix, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('💧',
            'Lave la mâche dans plusieurs eaux : le sable reste au coeur des '
            'bouquets.'),
        RecipeStep('🫗',
            'Sèche-la délicatement, elle s\'écrase vite.'),
        RecipeStep('🥄',
            'Vinaigrette à la moutarde et à l\'huile de noix.'),
        RecipeStep('🥗',
            'Dés de betterave, noix concassées, et mélange au dernier moment.'),
      ],
    ),
    Recipe(
      name: 'Velouté de mâche',
      emoji: '🍲',
      description:
          'Inattendu : un velouté très vert, au goût de noisette.',
      minutes: 25,
      serves: 4,
      ingredients: <String>[
        '300 g de mâche',
        '2 pommes de terre',
        '1 échalote',
        '70 cl de bouillon',
        '10 cl de crème, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥔',
            'Cuis les pommes de terre en dés avec l\'échalote dans le '
            'bouillon, 15 minutes.',
            minutes: 15),
        RecipeStep('🥬',
            'Jette la mâche et compte **2 minutes**, pas plus.', minutes: 2),
        RecipeStep('🥣', 'Mixe aussitôt, hors du feu.'),
        RecipeStep('🥛', 'Crème, sel, poivre. Sers vite, le vert passe.'),
      ],
    ),
    Recipe(
      name: 'Mâche aux lardons et œuf poché',
      emoji: '🍳',
      description:
          'Tiède, avec un jaune coulant qui fait la sauce.',
      minutes: 20,
      serves: 2,
      ingredients: <String>[
        '150 g de mâche',
        '100 g de lardons',
        '2 oeufs très frais',
        '1 cuillère à soupe de vinaigre',
        'pain, huile, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥓', 'Fais dorer les lardons, réserve-les dans leur gras.'),
        RecipeStep('🍞', 'Fais griller des dés de pain dans la même poêle.'),
        RecipeStep('💧',
            'Casse les oeufs dans une eau frémissante vinaigrée, 3 minutes.',
            minutes: 3),
        RecipeStep('🥗',
            'Mâche dans l\'assiette, lardons et croûtons tièdes dessus.'),
        RecipeStep('🍳',
            'Pose l\'oeuf, poivre, et perce-le à table.'),
      ],
    ),
  ],
  'roquette': <Recipe>[
    Recipe(
      name: 'Pesto de roquette',
      emoji: '🌿',
      description:
          'Plus poivré que le basilic, parfait quand la roquette monte.',
      minutes: 10,
      serves: 4,
      ingredients: <String>[
        '100 g de roquette',
        '50 g de parmesan',
        '40 g de pignons ou d\'amandes',
        '10 cl d\'huile d\'olive',
        '1 gousse d\'ail, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🔥',
            'Fais torréfier les pignons à sec 2 minutes : ça change tout.',
            minutes: 2),
        RecipeStep('🌿',
            'Mixe roquette, ail, pignons et parmesan par à-coups.'),
        RecipeStep('🫒',
            'Verse l\'huile en filet, mixeur en marche, jusqu\'à une pâte '
            'souple.'),
        RecipeStep('🧂',
            'Sale peu — le parmesan sale déjà. Un trait de citron si c\'est '
            'trop amer.'),
      ],
    ),
    Recipe(
      name: 'Roquette, parmesan, citron',
      emoji: '🧀',
      description:
          'Trois ingrédients, dix secondes : la salade des restaurants italiens.',
      minutes: 5,
      serves: 4,
      ingredients: <String>[
        '150 g de roquette',
        '80 g de parmesan',
        '1 citron',
        '3 cuillères à soupe d\'huile d\'olive',
        'poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥬', 'Dispose la roquette, à peine lavée et bien séchée.'),
        RecipeStep('🍋',
            'Jus de citron, huile, poivre — pas de sel, le parmesan y pourvoit.'),
        RecipeStep('🧀',
            'Copeaux de parmesan à l\'économe, généreusement.'),
        RecipeStep('🍽', 'Mélange dans l\'assiette, sers tout de suite.'),
      ],
    ),
    Recipe(
      name: 'Velouté de roquette et pomme de terre',
      emoji: '🍲',
      description:
          'La pomme de terre arrondit le poivré de la roquette.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '200 g de roquette',
        '3 pommes de terre',
        '1 oignon',
        '80 cl de bouillon',
        'crème, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Fais fondre l\'oignon, ajoute les pommes de terre.'),
        RecipeStep('🍲', 'Bouillon, et cuis 20 minutes.', minutes: 20),
        RecipeStep('🥬',
            'Ajoute la roquette 2 minutes avant la fin.', minutes: 2),
        RecipeStep('🥣',
            'Mixe. Goûte avant de saler : la roquette est déjà forte.'),
      ],
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
      emoji: '🫛',
      description:
          'Avec laitue, oignons nouveaux et beurre — la recette qui ne change pas.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '1 kg de petits pois écossés',
        '1 coeur de laitue',
        '8 oignons nouveaux',
        '40 g de beurre',
        '1 cuillère à café de sucre, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🫛', 'Écosse les pois : compte 1 kg en gousses pour 400 g.'),
        RecipeStep('🥬',
            'Coupe la laitue en lanières, les oignons en deux.'),
        RecipeStep('🍲',
            'Dans la cocotte : pois, laitue, oignons, beurre, sucre, sel et '
            '10 cl d\'eau.'),
        RecipeStep('⏱',
            'Couvre et laisse 20 minutes à feu doux, sans remuer.', minutes: 20),
        RecipeStep('🧈',
            'Il ne doit presque plus rester d\'eau : juste un jus beurré.'),
      ],
    ),
    Recipe(
      name: 'Velouté de petits pois à la menthe',
      emoji: '🌿',
      description:
          'Un vert éclatant, à condition de ne pas trop cuire.',
      minutes: 25,
      serves: 4,
      ingredients: <String>[
        '800 g de petits pois',
        '1 oignon',
        '70 cl de bouillon',
        'une dizaine de feuilles de menthe',
        '10 cl de crème, sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🧅', 'Fais fondre l\'oignon émincé sans le colorer.'),
        RecipeStep('🫛', 'Ajoute les pois et le bouillon chaud.'),
        RecipeStep('⏱',
            '8 minutes seulement : au-delà, le vert tourne au kaki.',
            minutes: 8),
        RecipeStep('🌿', 'Mixe avec la menthe, hors du feu.'),
        RecipeStep('🥛', 'Crème, sel, poivre. Bon chaud ou glacé.'),
      ],
    ),
    Recipe(
      name: 'Petits pois carottes',
      emoji: '🥕',
      description:
          'Le duo de l\'enfance, en frais ça n\'a rien à voir avec la conserve.',
      minutes: 30,
      serves: 4,
      ingredients: <String>[
        '600 g de petits pois',
        '4 carottes',
        '1 oignon',
        '30 g de beurre',
        'sel, poivre, persil',
      ],
      steps: <RecipeStep>[
        RecipeStep('🥕', 'Coupe les carottes en rondelles fines.'),
        RecipeStep('🧈',
            'Fais-les suer au beurre avec l\'oignon, 10 minutes.', minutes: 10),
        RecipeStep('🫛',
            'Ajoute les pois et un fond d\'eau, sale.'),
        RecipeStep('⏱', 'Couvre et cuis 15 minutes.', minutes: 15),
        RecipeStep('🌿', 'Persil, poivre, une noisette de beurre à la fin.'),
      ],
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
    Recipe(
      name: 'Velouté de potimarron',
      emoji: '🍲',
      description:
          'Sa peau se mange : pas d\'épluchage, et un goût de châtaigne.',
      minutes: 35,
      serves: 4,
      ingredients: <String>[
        '1 potimarron (1,2 kg)',
        '1 oignon',
        '70 cl de bouillon',
        '10 cl de crème',
        'sel, poivre, muscade',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃',
            'Lave le potimarron, coupe-le en cubes **sans l\'éplucher** : la '
            'peau fond à la cuisson.'),
        RecipeStep('🧅', 'Fais fondre l\'oignon, ajoute les cubes.'),
        RecipeStep('🍲', 'Mouille au bouillon, à hauteur.'),
        RecipeStep('⏱', 'Cuis 25 minutes à couvert.', minutes: 25),
        RecipeStep('🥣', 'Mixe, crème hors du feu, muscade.'),
      ],
    ),
    Recipe(
      name: 'Potimarron rôti au four',
      emoji: '🔥',
      description:
          'En quartiers, à l\'huile et au romarin : le four fait tout le travail.',
      minutes: 45,
      serves: 4,
      ingredients: <String>[
        '1 potimarron',
        '3 cuillères à soupe d\'huile d\'olive',
        '2 gousses d\'ail',
        'romarin, gros sel, poivre',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃',
            'Coupe le potimarron en quartiers, retire les graines, garde la '
            'peau.'),
        RecipeStep('🫒',
            'Enrobe d\'huile, ajoute l\'ail en chemise et le romarin.'),
        RecipeStep('⏱',
            'Four à 200 °C, 35 minutes. Retourne les quartiers à mi-cuisson.',
            minutes: 35),
        RecipeStep('🧂', 'Gros sel et poivre à la sortie.'),
      ],
    ),
    Recipe(
      name: 'Tarte au potimarron',
      emoji: '🥧',
      description:
          'Entre la tarte et le flan, à peine sucrée, très réconfortante.',
      minutes: 75,
      serves: 6,
      ingredients: <String>[
        '1 pâte brisée',
        '800 g de potimarron',
        '2 oeufs, 20 cl de crème',
        '60 g de sucre',
        'cannelle, muscade, sel',
      ],
      steps: <RecipeStep>[
        RecipeStep('🎃', 'Cuis le potimarron en cubes 20 minutes à la vapeur.',
            minutes: 20),
        RecipeStep('🥄', 'Écrase-le et laisse-le refroidir, bien égoutté.'),
        RecipeStep('🥣',
            'Mélange avec oeufs, crème, sucre, cannelle, muscade, une pincée '
            'de sel.'),
        RecipeStep('🥧', 'Verse sur la pâte étalée et piquée.'),
        RecipeStep('⏱',
            'Four à 180 °C, 40 minutes : le centre doit être juste pris.',
            minutes: 40),
      ],
    ),
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

/// Le **top 3** d'un légume : les trois recettes mises en avant.
///
/// Contrainte de Jean (01/11/2026) : trois par légume, toujours. C'est
/// ce qui rend la liste lisible — vingt idées de plat ne se choisissent
/// pas. L'ordre du catalogue **est** le classement : la première est
/// celle qu'on propose d'abord.
///
/// Rendre trois recettes et pas plus est volontaire. Ce qui dépasse
/// reste joignable par [otherRecipesFor], sous le top 3.
List<Recipe> top3For(String vegetableId) {
  final toutes = recipesByVegetable[vegetableId];
  if (toutes == null) return const <Recipe>[];
  return toutes.take(3).toList(growable: false);
}

/// Les recettes qui emploient ce légume **sans** être dans son top 3.
///
/// Deux sources : ce qui dépasse de sa propre liste, et les recettes
/// d'autres légumes qui le déclarent dans `uses`. Sans ça, une recette
/// hors du top 3 ne serait atteignable par aucun chemin de l'app —
/// c'est-à-dire un bug, pas une réserve (règle 10).
List<Recipe> otherRecipesFor(String vegetableId) {
  final out = <Recipe>[
    ...?recipesByVegetable[vegetableId]?.skip(3),
  ];
  recipesByVegetable.forEach((id, recettes) {
    if (id == vegetableId) return;
    for (final r in recettes) {
      if (r.uses.contains(vegetableId)) out.add(r);
    }
  });
  return out;
}

/// Le légume sous lequel une recette est rangée.
///
/// Nécessaire parce que la clé des favoris et du « déjà cuisiné » est
/// `légume/nom` : une recette vue depuis un légume emprunteur doit
/// garder la clé de son légume d'origine, sinon la même recette
/// apparaîtrait deux fois dans les favoris.
String? ownerOf(Recipe recipe) {
  for (final entry in recipesByVegetable.entries) {
    if (entry.value.contains(recipe)) return entry.key;
  }
  return null;
}
