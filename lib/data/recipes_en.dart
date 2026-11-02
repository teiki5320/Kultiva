import 'recipes_i18n.dart';

/// Les recettes du catalogue, en anglais.
///
/// Clé = `légume/nom français`, celle de `recipeTextKey()`. Une clé
/// absente retombe sur le français, et un champ vide aussi : ce fichier
/// peut donc être rempli par morceaux sans jamais casser l'app.
///
/// **Comment on le remplit.** Pas à la main dans ce fichier, qui ferait
/// plusieurs dizaines de milliers de lignes une fois complet, mais lot
/// par lot. Le squelette d'un lot se génère :
///
/// ```bash
/// dart run tool/exporter_recettes.dart --lots
/// dart run tool/exporter_recettes.dart --squelette --langue=en --lot=1
/// ```
///
/// Le squelette sort en Dart déjà valide, le français en commentaire
/// au-dessus de chaque chaîne vide. Il ne reste qu'à remplir et à
/// coller ici.
///
/// ⚠️ **Les nombres ne se traduisent pas.** Les grammes de sel, les
/// degrés, les pourcentages de vinaigre et les temps de stérilisation
/// sont des règles de sécurité alimentaire — une saumure à 3 % devenue
/// 2 % ne conserve plus, elle fait pousser autre chose.
/// `test/recipes_i18n_test.dart` compare les nombres de chaque
/// traduction aux nombres du français, et refuse le fichier s'ils ont
/// bougé. Les unités, elles, se traduisent : « 30 g de sel » devient
/// « 30 g of salt », jamais « 1 oz of salt ».
///
/// **La tomate est le modèle.** Ses trois conservations sont traduites
/// en entier, comme référence de ton et de niveau de détail pour les
/// 122 autres légumes. Les 733 autres recettes attendent leur lot.
const Map<String, RecipeText> recipeTextsEn = <String, RecipeText>{
  // ─────────────────────────── tomate ───────────────────────────
  'tomate/Coulis de tomates en bocaux': RecipeText(
    name: 'Canned tomato sauce',
    description: 'Five kilos at once: sterilised sauce is the only '
        'answer that lasts a whole winter without a freezer.',
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '5 kg ripe tomatoes',
      '2 onions',
      '4 garlic cloves',
      '1 bunch of basil',
      '4 tbsp olive oil',
      '2 tsp salt, 1 of sugar',
    ],
    steps: <String>[
      'Wash the tomatoes, remove the stalks and any bruised parts. No '
          'need to peel them — the mill will do that.',
      'Cut them into quarters and drop them into the big pot, with no '
          'water: they will release plenty.',
      'Soften the onions and garlic in the oil, then add the tomatoes '
          'and the salt.',
      'Let it cook for 45 minutes uncovered, stirring now and then. '
          'The juice should reduce by half.',
      'Pass it through a food mill: skins and seeds stay behind. A '
          'blender would give you a pink, foamy sauce.',
      'Back on the heat with the sugar and the basil, and reduce for '
          'another 20 minutes. It should coat the spoon.',
      'Fill clean jars to 2 cm from the rim and close them.',
      'Sterilise for 30 minutes in boiling water, the jars completely '
          'covered. This is the step that makes them keep for a year.',
      'Let them cool in the water, then check that every lid is dipped '
          'inwards. A domed lid means the fridge, and eat that one '
          'within the week.',
    ],
  ),
  'tomate/Tomates séchées à l\'huile': RecipeText(
    name: 'Oven-dried tomatoes in oil',
    description: 'A low oven concentrates all the sugar. After that, '
        'the oil keeps them.',
    keeps: '6 months in the fridge, under oil',
    ingredients: <String>[
      '2 kg plum tomatoes',
      'coarse salt',
      '3 garlic cloves',
      'thyme, oregano, basil',
      '30 cl olive oil',
    ],
    steps: <String>[
      'Cut the tomatoes in half lengthways. Plum tomatoes dry better: '
          'less water, more flesh.',
      'Lay them cut side up on a rack and salt them lightly — the salt '
          'draws the water out.',
      'Oven at 90 °C, fan on, **door held ajar** with a wooden spoon '
          'so the steam can escape.',
      'Count on 6 to 7 hours. They should stay supple, not brittle: '
          'too dry and they will never soften again.',
      'Pack them into a jar in layers, with the sliced garlic and the '
          'herbs.',
      'Cover them completely with oil — a tomato poking out will go '
          'mouldy. Wait 48 h before touching them.',
    ],
  ),
  'tomate/Tomates congelées entières': RecipeText(
    name: 'Whole frozen tomatoes',
    description: 'Ten minutes of work. The tomato is the one vegetable '
        'you can freeze raw with no preparation at all.',
    keeps: '8 months in the freezer',
    ingredients: <String>[
      'ripe tomatoes, as many as you like',
      'freezer bags',
    ],
    steps: <String>[
      'Pick sound tomatoes. A split or spotted one keeps no better for '
          'being cold.',
      'Wash them and **dry them well**: any water left behind turns to '
          'frost and glues them together.',
      'Remove the stalks and leave them whole. No peeling, no '
          'blanching.',
      'Spread them on a tray, apart from each other, and freeze for 2 '
          'hours.',
      'Once hard, tip them into a bag. They will not set into a block, '
          'so you can take three at a time.',
      'To use: run them under warm water and the skin slips off by '
          'itself. For sauces and soups, not for a salad.',
    ],
  ),

  // ─────────── abricotier (6 recettes) ───────────
  'abricotier/Oreillons d\'abricots au sirop': RecipeText(
    // FR: Oreillons d'abricots au sirop
    name: 'Apricot halves in syrup',
    // FR: Le classique des placards de grand-mère : une tarte aux abricots possible même en février.
    description: 'A grandmother\'s-cupboard classic: an apricot tart is possible even in February.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '2 kg ripe but firm apricots', // FR: 2 kg d'abricots mûrs mais fermes
      '1 litre of water', // FR: 1 litre d'eau
      '300 g of sugar', // FR: 300 g de sucre
      '5 jars of 50 cl with new seals', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les abricots et écarte ceux qui sont tachés ou trop mous.
      'Wash the apricots and set aside any that are spotted or too soft.',
      // FR: Ouvre-les en deux à la main en suivant le sillon et retire le noyau.
      'Split them in two by hand, following the groove, and remove the stone.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes pour faire le sirop.
      'Bring the water and sugar to the boil for 2 minutes to make the syrup.',
      // FR: Range les oreillons **bombé vers le haut**, bien serrés, couvre de sirop chaud jusqu'à 2 cm du bord et ferme avec des joints neufs.
      'Pack the halves **domed side up**, tightly, cover with hot syrup to 2 cm from the rim and close with new seals.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Sterilise the jars completely covered in water, for 25 minutes from the moment it boils.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange vite.
      'Let them cool in the water, then check the vacuum. A jar that has not sealed goes in the fridge and gets eaten quickly.',
    ],
  ),
  'abricotier/Abricots secs maison': RecipeText(
    // FR: Abricots secs maison
    name: 'Homemade dried apricots',
    // FR: Plus foncés que ceux du commerce car sans soufre, mais avec un vrai goût d'abricot.
    description: 'Darker than shop-bought ones because there is no sulphur, but with a real apricot flavour.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '2 kg very ripe apricots', // FR: 2 kg d'abricots bien mûrs
      '1 litre of cold water', // FR: 1 litre d'eau froide
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Ouvre les abricots en deux, retire le noyau, puis retourne chaque moitié comme un gant pour l'aplatir.
      'Split the apricots in two, remove the stone, then turn each half inside out like a glove to flatten it.',
      // FR: Trempe-les 5 minutes dans l'eau citronnée : ils foncent moins au séchage.
      'Soak them for 5 minutes in the lemon water: they darken less as they dry.',
      // FR: Égoutte-les et éponge-les sur un torchon.
      'Drain them and pat them dry on a tea towel.',
      // FR: Pose-les peau en dessous sur des grilles et sèche au four à **60 °C**, porte entrouverte.
      'Lay them skin side down on racks and dry in the oven at **60 °C**, door held ajar.',
      // FR: Teste : l'abricot est souple, un peu collant, et ne laisse aucun jus quand tu le plies.
      'Test: the apricot is supple, a little sticky, and releases no juice when you fold it.',
      // FR: Laisse refroidir, mets en bocal et secoue chaque jour une semaine. De la buée, et c'est retour au four.
      'Let them cool, put them in jars and shake each jar every day for a week. If you see condensation, back in the oven they go.',
    ],
  ),
  'abricotier/Oreillons d\'abricots congelés': RecipeText(
    // FR: Oreillons d'abricots congelés
    name: 'Frozen apricot halves',
    // FR: Dix minutes pour ouvrir, dénoyauter, poser sur plaque : la récolte de trop est sauvée.
    description: 'Ten minutes to halve, stone and tray: the surplus harvest is saved.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg ripe but firm apricots', // FR: 2 kg d'abricots mûrs mais fermes
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les abricots et sèche-les bien sur un torchon.
      'Wash the apricots and dry them well on a tea towel.',
      // FR: Ouvre-les en deux en suivant le sillon et retire le noyau.
      'Split them in two along the groove and remove the stone.',
      // FR: Pose les oreillons côté coupé vers le haut sur une plaque, **sans qu'ils se touchent**, et congèle 3 heures.
      'Lay the halves cut side up on a tray, **not touching each other**, and freeze for 3 hours.',
      // FR: Verse-les en sac une fois durs. Ils vont encore congelés sur une pâte à tarte ou dans une compote.
      'Tip them into a bag once hard. They go straight onto a tart base or into a compote, still frozen.',
    ],
  ),
  'abricotier/Confiture d\'abricots': RecipeText(
    // FR: Confiture d'abricots
    name: 'Apricot jam',
    // FR: Quelques amandons cassés dedans : c'est ce qui fait la différence.
    description: 'A few cracked kernels stirred in: that is what makes the difference.',
  ),
  'abricotier/Tarte aux abricots': RecipeText(
    // FR: Tarte aux abricots
    name: 'Apricot tart',
    // FR: Leur acidité tient tête à la pâte sucrée.
    description: 'Their sharpness stands up to the sweet pastry.',
  ),
  'abricotier/Abricots rôtis au romarin': RecipeText(
    // FR: Abricots rôtis au romarin
    name: 'Roast apricots with rosemary',
    // FR: Salé-sucré, en accompagnement ou en dessert.
    description: 'Sweet and savoury, as a side or a dessert.',
  ),

  // ─────────── ail (6 recettes) ───────────
  'ail/Tresses d\'ail séchées': RecipeText(
    // FR: Tresses d'ail séchées
    name: 'Dried garlic plaits',
    // FR: Bien séché après l'arrachage, l'ail se garde jusqu'au printemps suspendu dans un coin frais et sec.
    description: 'Properly dried after lifting, garlic keeps until spring hung in a cool, dry corner.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 months in a dry place, out of the light',
    ingredients: <String>[
      '30 freshly lifted garlic bulbs, with their stalks', // FR: 30 têtes d'ail fraîchement arrachées, avec leurs fanes
      'kitchen string', // FR: de la ficelle de cuisine
    ],
    steps: <String>[
      // FR: Arrache l'ail par temps sec, quand les deux tiers des feuilles ont jauni. Brosse la terre à la main, **sans laver**.
      'Lift the garlic in dry weather, when two thirds of the leaves have yellowed. Brush the soil off by hand, **without washing**.',
      // FR: Laisse-le sécher 2 à 3 semaines à l'ombre, dans un endroit aéré : un abri, un grenier, pas en plein soleil.
      'Leave it to dry for 2 to 3 weeks in the shade, somewhere airy: a shed or an attic, not in full sun.',
      // FR: Coupe les racines au ras du bulbe et retire la première peau terreuse.
      'Cut the roots right back to the bulb and peel off the first dirty skin.',
      // FR: Tresse les fanes encore un peu souples par trois, en ajoutant une tête à chaque passage, et noue avec la ficelle.
      'Plait the stalks while they are still a little supple, three at a time, adding one bulb with each pass, and tie off with the string.',
      // FR: Suspends la tresse au frais et au sec, entre 10 et 15 °C idéalement. Écarte vite une tête molle ou qui germe.
      'Hang the plait somewhere cool and dry, ideally between 10 and 15 °C. Quickly remove any bulb that goes soft or sprouts.',
    ],
  ),
  'ail/Gousses d\'ail congelées': RecipeText(
    // FR: Gousses d'ail congelées
    name: 'Frozen garlic cloves',
    // FR: Pour les têtes abîmées qui ne tiendront pas l'hiver : épluchées et congelées, elles se râpent encore gelées.
    description: 'For damaged bulbs that will not last the winter: peeled and frozen, they can still be grated straight from the freezer.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '5 garlic bulbs', // FR: 5 têtes d'ail
      'a jar or a small freezer box', // FR: un bocal ou une petite boîte de congélation
    ],
    steps: <String>[
      // FR: Sépare les gousses et écarte celles qui sont tachées ou molles.
      'Separate the cloves and set aside any that are spotted or soft.',
      // FR: Fais-les tremper 10 minutes dans l'eau tiède : la peau se décolle toute seule.
      'Soak them for 10 minutes in lukewarm water: the skin comes away by itself.',
      // FR: Épluche-les et coupe le petit talon dur. Sèche-les bien dans un torchon.
      'Peel them and cut off the small hard base. Dry them well in a tea towel.',
      // FR: Mets-les entières dans un bocal bien fermé : l'odeur d'ail passe sinon à tout le congélateur.
      'Put them whole in a tightly closed jar: otherwise the garlic smell spreads to the whole freezer.',
      // FR: À l'usage, râpe-les ou hache-les **encore gelées**. Décongelées, elles deviennent molles et collent au couteau.
      'To use, grate or chop them **still frozen**. Thawed, they go soft and stick to the knife.',
    ],
  ),
  'ail/Gousses d\'ail au vinaigre': RecipeText(
    // FR: Gousses d'ail au vinaigre
    name: 'Garlic cloves in vinegar',
    // FR: Adoucies par le vinaigre, elles se croquent à l'apéritif ou se hachent dans une vinaigrette.
    description: 'Mellowed by the vinegar, they can be crunched as an aperitif nibble or chopped into a vinaigrette.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '400 g of peeled garlic cloves', // FR: 400 g de gousses d'ail épluchées
      '50 cl of white vinegar at 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '1 tablespoon of sugar', // FR: 1 cuillère à soupe de sucre
      '1 teaspoon of fine salt', // FR: 1 cuillère à café de sel fin
      '1 teaspoon of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Épluche les gousses (10 minutes de trempage à l'eau tiède aident beaucoup) et coupe les talons.
      'Peel the cloves (10 minutes in lukewarm water helps a lot) and cut off the bases.',
      // FR: Blanchis-les **1 minute** dans l'eau bouillante pour adoucir leur piquant.
      'Blanch them for **1 minute** in boiling water to soften their bite.',
      // FR: Égoutte-les et passe-les sous l'eau froide, puis tasse-les dans des bocaux propres avec le poivre.
      'Drain them and run them under cold water, then pack them into clean jars with the peppercorns.',
      // FR: Porte le vinaigre pur à ébullition avec le sucre et le sel.
      'Bring the undiluted vinegar to the boil with the sugar and salt.',
      // FR: Verse sur l'ail pour le **couvrir entièrement**, ferme et laisse refroidir, puis réfrigérateur.
      'Pour over the garlic to **cover it completely**, close, leave to cool, then into the fridge.',
      // FR: Attends 3 semaines avant de goûter. Si des gousses bleuissent, c'est une réaction naturelle de l'ail à l'acide, sans danger.
      'Wait 3 weeks before tasting. If some cloves turn blue, it is a natural reaction of garlic to acid and perfectly harmless.',
    ],
  ),
  'ail/Soupe à l\'ail': RecipeText(
    // FR: Soupe à l'ail
    name: 'Garlic soup',
    // FR: Douce et réconfortante — l'ail cuit perd toute sa morsure.
    description: 'Gentle and comforting: cooked garlic loses all its bite.',
    ingredients: <String>[
      '2 garlic bulbs', // FR: 2 têtes d'ail
      '1 litre of stock', // FR: 1 litre de bouillon
      '2 egg yolks', // FR: 2 jaunes d'oeufs
      '4 slices of bread', // FR: 4 tranches de pain
      'olive oil, thyme, bay leaf, salt', // FR: huile d'olive, thym, laurier, sel
    ],
    steps: <String>[
      // FR: Pèle les gousses et écrase-les à peine sous la lame.
      'Peel the cloves and barely crush them under the blade.',
      // FR: Fais-les blondir doucement à l'huile, sans les brunir : brûlé, l'ail devient amer.
      'Soften them gently in the oil without browning them: burnt garlic turns bitter.',
      // FR: Ajoute le bouillon, thym, laurier, et laisse frémir 20 minutes.
      'Add the stock, thyme and bay leaf, and simmer for 20 minutes.',
      // FR: Hors du feu, délaye les jaunes avec une louche de bouillon, puis reverse en fouettant.
      'Off the heat, loosen the yolks with a ladle of stock, then pour back in, whisking.',
      // FR: Sers sur du pain grillé frotté d'ail.
      'Serve over toasted bread rubbed with garlic.',
    ],
  ),
  'ail/Aïoli': RecipeText(
    // FR: Aïoli
    name: 'Aïoli',
    // FR: Ail pilé, jaune d'œuf, huile d'olive en filet. Du muscle.
    description: 'Pounded garlic, egg yolk, olive oil in a thin stream. Plenty of punch.',
    ingredients: <String>[
      '4 garlic cloves', // FR: 4 gousses d'ail
      '1 egg yolk', // FR: 1 jaune d'oeuf
      '20 cl of olive oil', // FR: 20 cl d'huile d'olive
      '1/2 lemon, salt', // FR: 1/2 citron, sel
    ],
    steps: <String>[
      // FR: Pile l'ail avec du gros sel au mortier, jusqu'à une crème.
      'Pound the garlic with coarse salt in a mortar until creamy.',
      // FR: Ajoute le jaune, à température ambiante — froid, l'émulsion rate.
      'Add the yolk, at room temperature: cold, the emulsion fails.',
      // FR: Verse l'huile **goutte à goutte** en tournant toujours dans le même sens.
      'Pour in the oil **drop by drop**, always stirring in the same direction.',
      // FR: Quand ça monte, tu peux accélérer. Si ça tranche : repars d'un jaune neuf et reverse l'aïoli raté dessus.
      'Once it starts to thicken, you can speed up. If it splits, start again from a fresh yolk and pour the failed aïoli onto it.',
      // FR: Citron et sel pour finir.
      'Finish with lemon and salt.',
    ],
  ),
  'ail/Ail confit à l\'huile': RecipeText(
    // FR: Ail confit à l'huile
    name: 'Garlic confit in oil',
    // FR: Des gousses entières fondues à feu très doux, à tartiner.
    description: 'Whole cloves melted on a very low heat, ready to spread.',
    ingredients: <String>[
      '4 garlic bulbs', // FR: 4 têtes d'ail
      '25 cl of olive oil', // FR: 25 cl d'huile d'olive
      'thyme, bay leaf', // FR: thym, laurier
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Sépare les gousses, pèle-les sans les abîmer.
      'Separate the cloves and peel them without damaging them.',
      // FR: Couvre-les d'huile dans une petite casserole, avec les herbes.
      'Cover them with oil in a small saucepan, with the herbs.',
      // FR: Feu **très** doux 40 minutes : l'huile doit à peine frémir. Si elle bout, l'ail frit au lieu de confire.
      '**Very** low heat for 40 minutes: the oil should barely tremble. If it boils, the garlic fries instead of confiting.',
      // FR: En bocal avec son huile, au frais, deux semaines. L'huile parfumée se garde pour les salades.
      'Keep in a jar with its oil in the fridge, for two weeks. The flavoured oil can be saved for salads.',
    ],
  ),

  // ─────────── amarante (6 recettes) ───────────
  'amarante/Amarante blanchie au congélateur': RecipeText(
    // FR: Amarante blanchie au congélateur
    name: 'Blanched amaranth for the freezer',
    // FR: Une minute de blanchiment, et les feuilles tendres d'amarante passent l'hiver bien vertes.
    description: 'One minute of blanching, and the tender amaranth leaves stay nicely green all winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of amaranth leaves', // FR: 1 kg de feuilles d'amarante
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et garde les pointes tendres avec les feuilles.
      'Strip the leaves from the stems and keep the tender tips with the leaves.',
      // FR: Lave dans plusieurs eaux, la terre colle sous les feuilles.
      'Wash in several changes of water: soil clings under the leaves.',
      // FR: Plonge dans une grande eau bouillante salée, à gros bouillons.
      'Plunge into a large pan of boiling salted water, at a rolling boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée : le choc fixe le vert.
      'Drain and plunge straight into the iced water: the shock fixes the green.',
      // FR: Presse en boule entre tes mains pour chasser toute l'eau.
      'Squeeze into a ball between your hands to get all the water out.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque puis mets-les en sac.
      'Shape portion-sized balls, freeze them for 2 hours on a tray, then put them in bags.',
    ],
  ),
  'amarante/Pesto d\'amarante en glaçons': RecipeText(
    // FR: Pesto d'amarante en glaçons
    name: 'Amaranth pesto cubes',
    // FR: Un quart d'heure et des cubes verts à jeter dans les pâtes ou le riz tout l'hiver.
    description: 'A quarter of an hour of work, and green cubes to drop into pasta or rice all winter.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '300 g of amaranth leaves', // FR: 300 g de feuilles d'amarante
      '60 g of roasted peanuts', // FR: 60 g d'arachides grillées
      '1 garlic clove', // FR: 1 gousse d'ail
      '15 cl of oil', // FR: 15 cl d'huile
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles et **sèche-les bien** : de l'eau dans le pesto le fait tourner.
      'Wash the leaves and **dry them well**: water in the pesto makes it turn.',
      // FR: Mixe les feuilles, l'ail et les arachides par à-coups, pour ne pas chauffer les feuilles.
      'Blitz the leaves, garlic and peanuts in short bursts, so the leaves do not heat up.',
      // FR: Verse l'huile en filet en mixant, puis sale.
      'Pour in the oil in a thin stream while blending, then add salt.',
      // FR: Remplis un bac à glaçons, un cube par portion, et couvre chaque cube d'un filet d'huile.
      'Fill an ice-cube tray, one cube per portion, and cover each cube with a thin layer of oil.',
      // FR: Démoule une fois durs et garde-les en sac. Un cube fond directement dans un plat chaud.
      'Turn them out once hard and keep them in a bag. A cube melts straight into a hot dish.',
    ],
  ),
  'amarante/Graines d\'amarante battues': RecipeText(
    // FR: Graines d'amarante battues
    name: 'Threshed amaranth seeds',
    // FR: Laisse quelques pieds monter en graines : battues et séchées, elles se gardent un an et se cuisent comme une céréale.
    description: 'Let a few plants run to seed: threshed and dried, they keep for a year and cook like a grain.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, protected from insects',
    ingredients: <String>[
      'ripe amaranth seed heads', // FR: les panicules d'amarante mûres
      'a sheet or a large paper bag', // FR: un drap ou un grand sac en papier
      'a fine sieve', // FR: un tamis fin
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les panicules quand les graines tombent si tu secoues la tige au-dessus de ta main.
      'Cut the seed heads when the seeds fall if you shake the stem over your hand.',
      // FR: Suspends-les tête en bas dans un grand sac en papier, dans un endroit sec et aéré, une semaine.
      'Hang them upside down in a large paper bag, somewhere dry and airy, for a week.',
      // FR: Frotte les panicules entre tes mains au-dessus du drap pour faire tomber les graines.
      'Rub the seed heads between your hands over the sheet to make the seeds drop.',
      // FR: Passe au tamis puis souffle doucement par-dessus pour enlever les débris légers.
      'Pass through the sieve, then blow gently over it to remove the light debris.',
      // FR: Étale les graines et finis de les sécher 1 heure au four à 40 °C, porte entrouverte.
      'Spread the seeds out and finish drying them for 1 hour in the oven at 40 °C, door held ajar.',
      // FR: Mets-les en bocaux hermétiques au frais et au sec. Elles se cuisent toujours avant de se manger, 20 minutes dans l'eau.
      'Put them in airtight jars in a cool, dry place. They are always cooked before eating: 20 minutes in water.',
    ],
  ),
  'amarante/Amarante sautée à l\'ail': RecipeText(
    // FR: Amarante sautée à l'ail
    name: 'Amaranth sautéed with garlic',
    // FR: Comme des épinards, mais avec plus de tenue.
    description: 'Like spinach, but with more body.',
  ),
  'amarante/Efo riro': RecipeText(
    // FR: Efo riro
    name: 'Efo riro',
    // FR: Le ragoût de feuilles yoruba, riche et parfumé, où l'amarante fait merveille.
    description: 'The Yoruba leaf stew, rich and fragrant, where amaranth shines.',
  ),
  'amarante/Sauce feuilles d\'amarante': RecipeText(
    // FR: Sauce feuilles d'amarante
    name: 'Amaranth leaf sauce',
    // FR: Une sauce verte toute simple qui sublime le riz ou le tô du jour.
    description: 'A simple green sauce that lifts rice or the day\'s tô.',
  ),

  // ─────────── aneth (6 recettes) ───────────
  'aneth/Brins d\'aneth au congélateur': RecipeText(
    // FR: Brins d'aneth au congélateur
    name: 'Dill sprigs for the freezer',
    // FR: Congelé en brins, l'aneth garde tout son parfum anisé, bien mieux que séché.
    description: 'Frozen in sprigs, dill keeps all its aniseed scent, far better than dried.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '3 bunches of dill', // FR: 3 bouquets d'aneth
      'zip-lock freezer bags', // FR: des sacs de congélation à zip
    ],
    steps: <String>[
      // FR: Rince l'aneth à l'eau froide, sans le laisser tremper.
      'Rinse the dill in cold water without letting it soak.',
      // FR: Étale-le sur un torchon et tamponne : il doit être **parfaitement sec**.
      'Spread it on a tea towel and pat it dry: it must be **perfectly dry**.',
      // FR: Détache les plumets fins des grosses tiges, qui restent dures. Garde les tiges pour un court-bouillon.
      'Pick the fine fronds off the thick stalks, which stay tough. Keep the stalks for a poaching stock.',
      // FR: Mets les plumets à plat dans un sac, chasse l'air et ferme. Pose le sac à plat dans le congélateur.
      'Lay the fronds flat in a bag, press out the air and seal. Put the bag flat in the freezer.',
      // FR: Une fois gelé, émiette directement à travers le sac : l'aneth se casse en miettes prêtes à l'emploi.
      'Once frozen, crumble it straight through the bag: the dill breaks into ready-to-use flakes.',
    ],
  ),
  'aneth/Concombres lacto-fermentés à l\'aneth': RecipeText(
    // FR: Concombres lacto-fermentés à l'aneth
    name: 'Lacto-fermented dill cucumbers',
    // FR: La saumure à l'aneth et à l'ail, et tes petits concombres deviennent des malossols acidulés.
    description: 'Add a dill-and-garlic brine, and your little cucumbers become tangy, lightly salted pickles.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '1 kg of small firm cucumbers', // FR: 1 kg de petits concombres fermes
      '1 litre of unchlorinated water and 30 g of salt', // FR: 1 litre d'eau non chlorée et 30 g de sel
      '4 dill heads with a few fronds', // FR: 4 ombelles d'aneth avec quelques plumets
      '4 garlic cloves', // FR: 4 gousses d'ail
      '3 vine or oak leaves', // FR: 3 feuilles de vigne ou de chêne
      'two 1-litre jars and a weight', // FR: deux bocaux de 1 litre et un poids
    ],
    steps: <String>[
      // FR: Lave les concombres en frottant et coupe le bout de la fleur : il contient une enzyme qui les ramollit.
      'Scrub the cucumbers and cut off the blossom end: it contains an enzyme that makes them soft.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau**, sans chauffer.
      'Dissolve **30 g of salt in 1 litre of water**, without heating.',
      // FR: Mets au fond des bocaux l'aneth, l'ail écrasé et les feuilles de vigne : leur tanin garde le croquant.
      'Put the dill, the crushed garlic and the vine leaves at the bottom of the jars: their tannin keeps things crunchy.',
      // FR: Range les concombres debout, bien serrés, jusqu'à 3 cm du bord.
      'Stand the cucumbers upright, packed tightly, up to 3 cm from the rim.',
      // FR: Verse la saumure et pose un poids : tout doit rester **sous le liquide**, sinon ça moisit.
      'Pour in the brine and add a weight: everything must stay **under the liquid**, or it will go mouldy.',
      // FR: Laisse fermenter à 18–22 °C, couvercle posé sans serrer. Une semaine à dix jours, la saumure se trouble et pétille : c'est normal.
      'Leave to ferment at 18–22 °C, lid resting on top without being tightened. After a week to ten days the brine goes cloudy and fizzy: that is normal.',
      // FR: Goûte : dès qu'ils sont acidulés à cœur, ferme et range-les au réfrigérateur pour arrêter la fermentation.
      'Taste: as soon as they are tangy right through, close the jars and put them in the fridge to stop the fermentation.',
    ],
  ),
  'aneth/Ombelles d\'aneth séchées': RecipeText(
    // FR: Ombelles d'aneth séchées
    name: 'Dried dill heads',
    // FR: Les fleurs et les graines sèchent très bien et parfument les saumures et le pain toute l'année.
    description: 'The flowers and seeds dry very well and flavour brines and bread all year round.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      'about fifteen dill heads gone to seed', // FR: une quinzaine d'ombelles d'aneth en graines
      'a large paper bag', // FR: un grand sac en papier
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les ombelles avec 20 cm de tige quand les graines sont formées et commencent à brunir.
      'Cut the dill heads with 20 cm of stem once the seeds have formed and are starting to turn brown.',
      // FR: Suspends-les tête en bas dans un sac en papier, à l'abri et au sec, deux semaines.
      'Hang them upside down in a paper bag, somewhere sheltered and dry, for two weeks.',
      // FR: Elles sont prêtes quand les graines se détachent d'une pichenette.
      'They are ready when the seeds come off with a flick of the finger.',
      // FR: Garde quelques ombelles entières pour tes bocaux de cornichons, égrène les autres.
      'Keep a few whole heads for your gherkin jars and shake the seeds off the rest.',
      // FR: Passe les graines au tamis pour ôter les bouts de tige, puis mets-les en bocal **bien sec**.
      'Pass the seeds through a sieve to remove bits of stem, then put them in a **very dry** jar.',
    ],
  ),
  'aneth/Saumon gravlax': RecipeText(
    // FR: Saumon gravlax
    name: 'Salmon gravlax',
    // FR: Sel, sucre, beaucoup d'aneth, deux jours au frais.
    description: 'Salt, sugar, lots of dill, two days somewhere cold.',
  ),
  'aneth/Sauce yaourt-aneth': RecipeText(
    // FR: Sauce yaourt-aneth
    name: 'Yoghurt and dill sauce',
    // FR: Avec du concombre râpé, pour un tzatziki du Nord.
    description: 'With grated cucumber, for a northern tzatziki.',
  ),
  'aneth/Pommes de terre à l\'aneth': RecipeText(
    // FR: Pommes de terre à l'aneth
    name: 'Potatoes with dill',
    // FR: Nouvelles, à l'eau, beurre et aneth haché.
    description: 'New potatoes, boiled, with butter and chopped dill.',
  ),

  // ─────────── arachide (6 recettes) ───────────
  'arachide/Arachides séchées en coque': RecipeText(
    // FR: Arachides séchées en coque
    name: 'Peanuts dried in the shell',
    // FR: Bien séchées et gardées dans leur coque, elles se conservent jusqu'à la prochaine récolte.
    description: 'Well dried and kept in their shells, they last until the next harvest.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, protected from insects',
    ingredients: <String>[
      'peanut plants pulled up in dry weather', // FR: les plants d'arachide arrachés par temps sec
      'drying racks or a clean sheet', // FR: des claies ou un drap propre
      'cloth or jute sacks', // FR: des sacs en toile ou en jute
    ],
    steps: <String>[
      // FR: Arrache les pieds quand le feuillage jaunit et que l'intérieur des coques a des veines brunes. Secoue la terre.
      'Pull up the plants when the foliage turns yellow and the inside of the shells shows brown veins. Shake off the soil.',
      // FR: Laisse les plants **retournés**, gousses vers le ciel, 3 à 4 jours au soleil sur le champ ou sur un drap.
      'Leave the plants **turned over**, pods facing the sky, for 3 to 4 days in the sun, in the field or on a sheet.',
      // FR: Détache les gousses et étale-les en couche mince sur des claies, à l'ombre et dans un endroit aéré.
      'Pick off the pods and spread them in a thin layer on racks, in the shade somewhere airy.',
      // FR: Laisse sécher 1 à 2 semaines en remuant tous les deux jours. Rentre-les dès qu'il pleut.
      'Leave to dry for 1 to 2 weeks, turning them every other day. Bring them in as soon as it rains.',
      // FR: Teste : la coque est cassante, la graine croque et sa peau rouge s'enlève toute seule.
      'Test: the shell is brittle, the seed crunches and its red skin comes off by itself.',
      // FR: Trie une à une. **Jette toute graine moisie, noircie ou amère** : ces moisissures ne se rattrapent pas.
      'Sort them one by one. **Throw out any seed that is mouldy, blackened or bitter**: that mould cannot be rescued.',
      // FR: Garde-les en coque dans des sacs en toile suspendus, au sec et au frais. Décortique au fur et à mesure.
      'Keep them in the shell in hanging cloth sacks, somewhere dry and cool. Shell them as you need them.',
    ],
  ),
  'arachide/Arachides fraîches bouillies au sel': RecipeText(
    // FR: Arachides fraîches bouillies au sel
    name: 'Fresh peanuts boiled in salt',
    // FR: Le goût du bord de route : les arachides fraîches cuites dans leur coque, à sortir du congélateur pour le goûter.
    description: 'The taste of the roadside stall: fresh peanuts cooked in their shells, to bring out of the freezer for a snack.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of fresh peanuts in the shell, just pulled up', // FR: 1 kg d'arachides fraîches en coque, juste arrachées
      '3 litres of water', // FR: 3 litres d'eau
      '60 g of coarse salt', // FR: 60 g de gros sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les coques dans plusieurs eaux en les frottant : la terre reste coincée dans les creux.
      'Wash the shells in several changes of water, rubbing them: soil stays stuck in the hollows.',
      // FR: Mets-les dans une grande marmite avec l'eau et le sel, en les tenant sous l'eau avec une assiette.
      'Put them in a large pot with the water and salt, holding them under the water with a plate.',
      // FR: Fais bouillir à couvert jusqu'à ce que la graine soit tendre comme un haricot cuit.
      'Boil with the lid on until the seed is as tender as a cooked bean.',
      // FR: Coupe le feu et laisse-les tremper dans l'eau salée : c'est là que le sel entre dans la coque.
      'Turn off the heat and leave them to soak in the salted water: that is how the salt gets inside the shell.',
      // FR: Égoutte et laisse refroidir complètement, étalées sur un plateau.
      'Drain and leave to cool completely, spread on a tray.',
      // FR: Mets en sacs, chasse l'air, note la date. Réchauffe 5 minutes dans l'eau bouillante au moment de servir.
      'Put in bags, press out the air and note the date. Reheat for 5 minutes in boiling water when serving.',
    ],
  ),
  'arachide/Arachides décortiquées au congélateur': RecipeText(
    // FR: Arachides décortiquées au congélateur
    name: 'Shelled peanuts in the freezer',
    // FR: Au froid, elles ne rancissent pas et les charançons n'ont aucune chance : tes cacahuètes restent comme au premier jour.
    description: 'In the cold they do not go rancid and weevils have no chance: your peanuts stay as good as on day one.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'very dry shelled peanuts', // FR: des arachides bien sèches, décortiquées
      'freezer bags or jars', // FR: des sacs ou bocaux de congélation
    ],
    steps: <String>[
      // FR: Décortique les arachides sèches et retire les graines ridées, tachées ou percées.
      'Shell the dry peanuts and remove any seeds that are wrinkled, spotted or pierced.',
      // FR: Trie encore à la lumière : **une graine moisie suffit à gâcher un sac**, jette-la sans hésiter.
      'Sort them again in good light: **one mouldy seed is enough to spoil a bag**, so throw it out without hesitation.',
      // FR: Remplis des sacs en chassant l'air ou des bocaux bien fermés, par portions d'un mafé ou d'une grillade.
      'Fill bags, pressing out the air, or tightly closed jars, in the amount you need for a mafé or a grill.',
      // FR: Congèle à plat. Pas besoin de décongeler : elles se grillent ou se pilent directement.
      'Freeze flat. No need to thaw: they can be roasted or pounded straight from the freezer.',
    ],
  ),
  'arachide/Beurre de cacahuète maison': RecipeText(
    // FR: Beurre de cacahuète maison
    name: 'Homemade peanut butter',
    // FR: Grillées puis mixées longtemps : elles rendent leur huile seules.
    description: 'Roasted, then blended for a long time: they release their own oil.',
  ),
  'arachide/Mafé': RecipeText(
    // FR: Mafé
    name: 'Mafé',
    // FR: Le ragoût à la pâte d'arachide, doux et généreux, servi sur du riz bien chaud.
    description: 'The peanut-paste stew, mild and generous, served over steaming hot rice.',
  ),
  'arachide/Kulikuli': RecipeText(
    // FR: Kulikuli
    name: 'Kulikuli',
    // FR: Les croquettes d'arachide frites et croustillantes, parfaites pour grignoter.
    description: 'Fried, crunchy peanut fritters, perfect for snacking.',
  ),

  // ─────────── artichaut (6 recettes) ───────────
  'artichaut/Fonds d\'artichauts congelés': RecipeText(
    // FR: Fonds d'artichauts congelés
    name: 'Frozen artichoke hearts',
    // FR: Tournés, citronnés et blanchis, les fonds sont prêts pour une poêlée ou une salade quand la récolte est passée.
    description: 'Trimmed, lemoned and blanched, the hearts are ready for a stir-fry or a salad once the harvest is over.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '10 large artichokes', // FR: 10 gros artichauts
      '2 lemons', // FR: 2 citrons
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Remplis un saladier d'eau avec le jus d'un citron : chaque fond y plonge dès qu'il est taillé, sinon il noircit.
      'Fill a bowl with water and the juice of one lemon: each heart goes in as soon as it is trimmed, or it turns black.',
      // FR: Casse la queue, retire les feuilles et taille le fond au couteau. Frotte-le aussitôt avec le citron.
      'Snap off the stalk, strip the leaves and trim the heart with a knife. Rub it straight away with lemon.',
      // FR: Blanchis les fonds **7 minutes** dans une grande eau salée et citronnée à gros bouillons.
      'Blanch the hearts for **7 minutes** in a large pan of salted, lemony water at a rolling boil.',
      // FR: Plonge-les dans l'eau glacée, puis retire le foin à la petite cuillère, il part facilement maintenant.
      'Plunge them into iced water, then scoop out the choke with a teaspoon: it comes away easily now.',
      // FR: Égoutte-les à l'envers sur un torchon et sèche-les bien.
      'Drain them upside down on a tea towel and dry them well.',
      // FR: Congèle-les sur une plaque sans qu'ils se touchent, puis passe-les en sac.
      'Freeze them on a tray without touching, then put them in bags.',
    ],
  ),
  'artichaut/Petits violets à l\'huile d\'olive': RecipeText(
    // FR: Petits violets à l'huile d'olive
    name: 'Baby purple artichokes in olive oil',
    // FR: Cuits dans un bain vinaigré puis couverts d'huile : l'antipasto italien, à garder au frais.
    description: 'Cooked in a vinegar bath, then covered in oil: the Italian antipasto, to keep in the fridge.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 weeks in the fridge',
    ingredients: <String>[
      '12 small purple artichokes', // FR: 12 petits artichauts violets
      '50 cl of white vinegar at 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '1 tablespoon of salt', // FR: 1 cuillère à soupe de sel
      '40 cl of olive oil', // FR: 40 cl d'huile d'olive
      '1 dried bay leaf', // FR: 1 feuille de laurier séchée
    ],
    steps: <String>[
      // FR: Retire les feuilles dures jusqu'au cœur tendre, coupe le haut et pèle la tige. Coupe en quatre et retire le foin s'il y en a.
      'Strip off the tough leaves down to the tender heart, cut off the top and peel the stalk. Cut into quarters and remove the choke if there is one.',
      // FR: Porte l'eau, le vinaigre et le sel à ébullition et cuis les quartiers dedans : c'est ce bain qui **les acidifie**.
      'Bring the water, vinegar and salt to the boil and cook the quarters in it: this bath is what **acidifies them**.',
      // FR: Égoutte-les et laisse-les sécher à plat sur un torchon propre, une bonne heure, jusqu'à ce qu'ils ne soient plus humides.
      'Drain them and leave them to dry flat on a clean tea towel for a good hour, until they are no longer damp.',
      // FR: Range-les dans un bocal ébouillanté avec le laurier sec. Pas d'ail cru, pas d'herbes fraîches.
      'Pack them into a scalded jar with the dried bay leaf. No raw garlic, no fresh herbs.',
      // FR: Couvre entièrement d'huile, tapote pour chasser les bulles et ferme.
      'Cover completely with oil, tap to release the bubbles and close.',
      // FR: Range **tout de suite au réfrigérateur**. Sors le bocal une demi-heure avant de servir, l'huile figée redevient liquide.
      'Put them **straight into the fridge**. Take the jar out half an hour before serving: the set oil turns liquid again.',
    ],
  ),
  'artichaut/Cœurs d\'artichauts au vinaigre': RecipeText(
    // FR: Cœurs d'artichauts au vinaigre
    name: 'Artichoke hearts in vinegar',
    // FR: Quelques petits artichauts tournés et plongés dans un vinaigre aux aromates : un bocal vite fait pour l'apéritif.
    description: 'A few baby artichokes trimmed and dropped into a herby vinegar: a quick jar for the aperitif.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '6 small purple artichokes', // FR: 6 petits artichauts violets
      '1 lemon', // FR: 1 citron
      '25 cl of white wine vinegar at 6 %', // FR: 25 cl de vinaigre de vin blanc à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
      '1 teaspoon of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Taille les petits artichauts jusqu'au cœur tendre, coupe-les en deux et frotte-les au citron.
      'Trim the baby artichokes down to the tender heart, cut them in half and rub them with lemon.',
      // FR: Porte l'eau, le vinaigre et le sel à ébullition, plonge les cœurs et laisse cuire.
      'Bring the water, vinegar and salt to the boil, add the hearts and let them cook.',
      // FR: Sors-les à l'écumoire et tasse-les dans un bocal ébouillanté avec le poivre.
      'Lift them out with a slotted spoon and pack them into a scalded jar with the peppercorns.',
      // FR: Verse le liquide bouillant par-dessus pour **les couvrir entièrement**, ferme et laisse refroidir.
      'Pour the boiling liquid over them to **cover them completely**, close and leave to cool.',
      // FR: Range au réfrigérateur et attends une semaine que le goût se fasse.
      'Keep in the fridge and wait a week for the flavour to develop.',
    ],
  ),
  'artichaut/Artichauts à la vinaigrette': RecipeText(
    // FR: Artichauts à la vinaigrette
    name: 'Artichokes with vinaigrette',
    // FR: Feuille à feuille, trempée, raclée entre les dents. Le fond pour la fin.
    description: 'Leaf by leaf, dipped, scraped between the teeth. The heart comes last.',
  ),
  'artichaut/Artichauts à la barigoule': RecipeText(
    // FR: Artichauts à la barigoule
    name: 'Artichokes à la barigoule',
    // FR: Petits violets mijotés au vin blanc avec carotte et lard.
    description: 'Baby purple artichokes simmered in white wine with carrot and bacon.',
  ),
  'artichaut/Fonds d\'artichauts farcis': RecipeText(
    // FR: Fonds d'artichauts farcis
    name: 'Stuffed artichoke hearts',
    // FR: Garnis de brousse et d'herbes, passés au four.
    description: 'Filled with brousse cheese and herbs, then baked.',
  ),

  // ─────────── asperge (6 recettes) ───────────
  'asperge/Asperges blanchies au congélateur': RecipeText(
    // FR: Asperges blanchies au congélateur
    name: 'Blanched asparagus for the freezer',
    // FR: Quand la planche donne plus que tu ne manges, deux à trois minutes d'eau bouillante sauvent la récolte.
    description: 'When the bed gives more than you can eat, two to three minutes in boiling water save the harvest.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of green or white asparagus', // FR: 1,5 kg d'asperges vertes ou blanches
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Casse le bas des asperges là où il cède tout seul. Pèle les blanches depuis la pointe, les vertes seulement en bas si elles sont grosses.
      'Snap off the bottom of the asparagus where it gives way by itself. Peel the white ones from the tip down, the green ones only at the bottom if they are thick.',
      // FR: Rince-les et trie-les par grosseur : elles ne blanchissent pas toutes au même rythme.
      'Rinse them and sort them by thickness: they do not all blanch at the same rate.',
      // FR: Plonge-les dans une grande eau salée bouillante : **2 minutes** pour les fines vertes, 3 pour les grosses et les blanches.
      'Plunge them into a large pan of boiling salted water: **2 minutes** for thin green ones, 3 for thick ones and white ones.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le temps qu'elles soient froides.
      'Transfer them straight into iced water, until they are cold.',
      // FR: Égoutte et sèche-les dans un torchon, une par une si besoin.
      'Drain and dry them in a tea towel, one by one if need be.',
      // FR: Congèle à plat sur une plaque, puis mets en sacs. Fais-les cuire **sans décongeler**, sinon elles ramollissent.
      'Freeze flat on a tray, then put in bags. Cook them **without thawing**, or they go soft.',
    ],
  ),
  'asperge/Pickles d\'asperges vertes': RecipeText(
    // FR: Pickles d'asperges vertes
    name: 'Green asparagus pickles',
    // FR: Debout dans leur bocal, croquantes et acidulées : un apéritif de printemps qui dure jusqu'à l'été.
    description: 'Standing upright in their jar, crunchy and tangy: a spring nibble that lasts until summer.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of green asparagus', // FR: 1 kg d'asperges vertes
      '40 cl of white vinegar at 6 %', // FR: 40 cl de vinaigre blanc à 6 %
      '40 cl of water', // FR: 40 cl d'eau
      '1 tablespoon of salt', // FR: 1 cuillère à soupe de sel
      '1 tablespoon of sugar', // FR: 1 cuillère à soupe de sucre
      'a few sprigs of dill', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Casse le bas dur des asperges et coupe-les à la hauteur de tes bocaux, moins 2 cm.
      'Snap off the tough bottoms of the asparagus and cut the spears to the height of your jars, minus 2 cm.',
      // FR: Blanchis-les **1 minute** dans l'eau bouillante, juste pour qu'elles restent bien vertes.
      'Blanch them for **1 minute** in boiling water, just enough to keep them bright green.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte-les.
      'Cool them in iced water and drain.',
      // FR: Range-les debout, pointes en haut, bien serrées, avec l'aneth.
      'Stand them upright, tips up, tightly packed, with the dill.',
      // FR: Porte le vinaigre, l'eau, le sel et le sucre à ébullition.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse bouillant jusqu'à **couvrir les pointes**, ferme, laisse refroidir et range au réfrigérateur.
      'Pour in boiling hot until the **tips are covered**, close, leave to cool and put in the fridge.',
    ],
  ),
  'asperge/Bouillon d\'épluchures d\'asperges': RecipeText(
    // FR: Bouillon d'épluchures d'asperges
    name: 'Asparagus peel stock',
    // FR: Les pelures et les talons font un bouillon parfumé à congeler, la base d'un risotto ou d'une soupe hors saison.
    description: 'The peelings and ends make a fragrant stock to freeze, the base of an out-of-season risotto or soup.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      'the peelings and ends from 2 kg of asparagus', // FR: les épluchures et talons de 2 kg d'asperges
      '1 onion', // FR: 1 oignon
      '1.5 litres of water', // FR: 1,5 litre d'eau
      '1 bay leaf', // FR: 1 feuille de laurier
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Rince les épluchures et les talons, coupe les talons en morceaux.
      'Rinse the peelings and ends, and cut the ends into pieces.',
      // FR: Coupe l'oignon en quatre, sans l'éplucher : la peau donne une jolie couleur dorée.
      'Quarter the onion without peeling it: the skin gives a lovely golden colour.',
      // FR: Mets tout dans l'eau froide avec le laurier, porte à ébullition puis laisse frémir.
      'Put everything in cold water with the bay leaf, bring to the boil, then let it simmer.',
      // FR: Filtre dans une passoire fine en pressant bien, puis sale légèrement.
      'Strain through a fine sieve, pressing well, then season lightly with salt.',
      // FR: Refroidis vite la casserole dans l'eau froide.
      'Cool the pan quickly in cold water.',
      // FR: Répartis en boîtes ou en sacs à plat, à 2 cm du bord, et note la date.
      'Pour into boxes or flat bags, leaving 2 cm at the top, and note the date.',
    ],
  ),
  'asperge/Asperges sauce mousseline': RecipeText(
    // FR: Asperges sauce mousseline
    name: 'Asparagus with mousseline sauce',
    // FR: Tièdes, une hollandaise allégée de crème fouettée.
    description: 'Served lukewarm, with a hollandaise lightened with whipped cream.',
  ),
  'asperge/Asperges vertes rôties': RecipeText(
    // FR: Asperges vertes rôties
    name: 'Roast green asparagus',
    // FR: Huile d'olive, four très chaud, dix minutes. Zeste de citron à la sortie.
    description: 'Olive oil, a very hot oven, ten minutes. Lemon zest when it comes out.',
  ),
  'asperge/Risotto aux asperges': RecipeText(
    // FR: Risotto aux asperges
    name: 'Asparagus risotto',
    // FR: Les pointes réservées pour la fin, les queues dans le bouillon.
    description: 'The tips saved for the end, the stalks in the stock.',
  ),

  // ─────────── aubergine (6 recettes) ───────────
  'aubergine/Aubergines grillées à l\'huile d\'olive': RecipeText(
    // FR: Aubergines grillées à l'huile d'olive
    name: 'Grilled aubergines in olive oil',
    // FR: Grillées, arrosées de vinaigre et noyées d'huile : l'antipasto italien qui attend au frais.
    description: 'Grilled, sprinkled with vinegar and drowned in oil: the Italian antipasto that waits in the fridge.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 weeks in the fridge',
    ingredients: <String>[
      '2 kg of aubergines', // FR: 2 kg d'aubergines
      '2 tablespoons of coarse salt', // FR: 2 cuillères à soupe de gros sel
      '10 cl of wine vinegar', // FR: 10 cl de vinaigre de vin
      '50 cl of olive oil', // FR: 50 cl d'huile d'olive
      '1 teaspoon of dried oregano', // FR: 1 cuillère à café d'origan séché
    ],
    steps: <String>[
      // FR: Lave les aubergines, coupe le pédoncule, essuie-les bien.
      'Wash the aubergines, cut off the stalk and dry them well.',
      // FR: Coupe-les en tranches de 1 cm dans la longueur, pas plus fines : elles se déchireraient au gril.
      'Cut them lengthways into slices 1 cm thick, no thinner: they would tear on the grill.',
      // FR: Sale les tranches et laisse-les dégorger dans une passoire. Elles rendent une eau amère.
      'Salt the slices and leave them to drain in a colander. They release a bitter liquid.',
      // FR: Éponge-les, puis grille-les à sec sur une poêle-gril bien chaude, 3 à 4 minutes par face.
      'Pat them dry, then grill them dry on a very hot griddle pan, 3 to 4 minutes per side.',
      // FR: Arrose chaque tranche encore chaude d'un peu de vinaigre : il **acidifie** la chair et la protège.
      'Sprinkle each slice while still hot with a little vinegar: it **acidifies** the flesh and protects it.',
      // FR: Range-les en couches dans des bocaux propres, une pincée d'origan **séché** entre chaque couche. Pas d'ail cru.
      'Layer them in clean jars, with a pinch of **dried** oregano between each layer. No raw garlic.',
      // FR: Couvre d'huile jusqu'à **1 cm au-dessus** des tranches, tasse pour chasser les bulles, ferme et file au réfrigérateur.
      'Cover with oil to **1 cm above** the slices, press down to release the bubbles, close and straight into the fridge.',
      // FR: Sors le bocal 20 minutes avant de servir : l'huile fige au froid, c'est normal. Reprends-en toujours avec une cuillère propre.
      'Take the jar out 20 minutes before serving: the oil sets in the cold, which is normal. Always take some out with a clean spoon.',
    ],
  ),
  'aubergine/Rondelles d\'aubergine blanchies au citron': RecipeText(
    // FR: Rondelles d'aubergine blanchies au citron
    name: 'Lemon-blanched aubergine slices',
    // FR: Crue, l'aubergine devient spongieuse au congélateur ; quatre minutes à l'eau citronnée, et elle tient l'hiver.
    description: 'Raw, aubergine turns spongy in the freezer; four minutes in lemony water and it lasts all winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of aubergines', // FR: 1,5 kg d'aubergines
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les aubergines en rondelles de 1 cm, sans les éplucher. Fais-le au dernier moment, elles noircissent vite.
      'Cut the aubergines into 1 cm slices without peeling them. Do it at the last moment, as they blacken quickly.',
      // FR: Porte une grande casserole d'eau à gros bouillons avec le jus des citrons : c'est lui qui **garde la chair claire**.
      'Bring a large pan of water to a rolling boil with the lemon juice: it **keeps the flesh pale**.',
      // FR: Plonge les rondelles par petites fournées et compte 4 minutes à partir de la reprise de l'ébullition.
      'Plunge the slices in small batches and count 4 minutes from when the water returns to the boil.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le temps qu'elles soient froides à cœur.
      'Transfer them straight into iced water, until they are cold right through.',
      // FR: Égoutte et sèche-les sur un torchon propre, en appuyant doucement : l'eau qui reste devient du givre.
      'Drain and dry them on a clean tea towel, pressing gently: any water left turns to frost.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent, congèle 2 heures, puis mets-les en sac. Pour moussaka, curry et ratatouille.
      'Spread them on a tray without touching, freeze for 2 hours, then put them in bags. For moussaka, curry and ratatouille.',
    ],
  ),
  'aubergine/Bâtonnets d\'aubergine au vinaigre': RecipeText(
    // FR: Bâtonnets d'aubergine au vinaigre
    name: 'Aubergine sticks in vinegar',
    // FR: Un pickle méconnu : la chair fondante s'imbibe de vinaigre et d'ail, parfait avec du pain et du fromage.
    description: 'A little-known pickle: the melting flesh soaks up vinegar and garlic, perfect with bread and cheese.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of aubergines', // FR: 1 kg d'aubergines
      '30 g of salt', // FR: 30 g de sel
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 teaspoon of chilli flakes', // FR: 1 cuillère à café de piment en flocons
    ],
    steps: <String>[
      // FR: Épluche les aubergines une bande sur deux et coupe-les en bâtonnets de la taille d'un doigt.
      'Peel the aubergines in alternate strips and cut them into sticks the size of a finger.',
      // FR: Mélange-les au sel et laisse-les dégorger une heure dans une passoire.
      'Toss them with the salt and leave them to drain for an hour in a colander.',
      // FR: Rince-les à l'eau froide et presse-les à pleines mains pour chasser le jus amer.
      'Rinse them in cold water and squeeze them with both hands to get rid of the bitter juice.',
      // FR: Porte le vinaigre et l'eau à ébullition, plonge les bâtonnets 2 minutes : ils deviennent translucides.
      'Bring the vinegar and water to the boil and drop the sticks in for 2 minutes: they turn translucent.',
      // FR: Tasse-les dans des bocaux propres avec l'ail en lamelles et le piment.
      'Pack them into clean jars with the sliced garlic and the chilli.',
      // FR: Verse le vinaigre bouillant par-dessus : les bâtonnets doivent être **entièrement couverts**. Ferme et laisse refroidir.
      'Pour the boiling vinegar over them: the sticks must be **completely covered**. Close and leave to cool.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'ouvrir : le vinaigre a besoin de ce temps pour entrer au cœur.
      'Keep in the fridge and wait 3 days before opening: the vinegar needs that time to reach the middle.',
    ],
  ),
  'aubergine/Parmigiana d\'aubergines': RecipeText(
    // FR: Parmigiana d'aubergines
    name: 'Aubergine parmigiana',
    // FR: Des couches d'aubergine, de tomate et de parmesan, longuement gratinées.
    description: 'Layers of aubergine, tomato and Parmesan, baked until well browned.',
    ingredients: <String>[
      '3 large aubergines', // FR: 3 grosses aubergines
      '800 g of tomato sauce', // FR: 800 g de coulis de tomate
      '200 g of mozzarella', // FR: 200 g de mozzarella
      '120 g of Parmesan', // FR: 120 g de parmesan
      'basil, olive oil, salt', // FR: basilic, huile d'olive, sel
    ],
    steps: <String>[
      // FR: Coupe les aubergines en tranches de 1 cm.
      'Cut the aubergines into 1 cm slices.',
      // FR: Sale-les et laisse-les dégorger 30 minutes : moins d'amertume, moins d'huile absorbée.
      'Salt them and leave them to drain for 30 minutes: less bitterness, less oil absorbed.',
      // FR: Essuie-les et fais-les griller au four, 15 minutes à 220 °C, plutôt qu'à la poêle — elles boivent moins d'huile.
      'Pat them dry and bake them in the oven for 15 minutes at 220 °C rather than frying — they soak up less oil.',
      // FR: Fais réduire le coulis 15 minutes avec du basilic et du sel.
      'Reduce the tomato sauce for 15 minutes with basil and salt.',
      // FR: Monte en couches : sauce, aubergines, mozzarella, parmesan, et recommence.
      'Build in layers: sauce, aubergines, mozzarella, Parmesan, and repeat.',
      // FR: Four à 180 °C, 35 minutes.
      'Oven at 180 °C, 35 minutes.',
      // FR: Attends 15 minutes avant de couper : elle se tient beaucoup mieux.
      'Wait 15 minutes before cutting: it holds together much better.',
    ],
  ),
  'aubergine/Ratatouille': RecipeText(
    // FR: Ratatouille
    name: 'Ratatouille',
    // FR: Chaque légume saisi à part, réunis à la fin : c'est le secret.
    description: 'Each vegetable browned separately, brought together at the end: that is the secret.',
    ingredients: <String>[
      '2 aubergines', // FR: 2 aubergines
      '3 courgettes', // FR: 3 courgettes
      '2 peppers', // FR: 2 poivrons
      '4 tomatoes', // FR: 4 tomates
      '2 onions, 3 garlic cloves', // FR: 2 oignons, 3 gousses d'ail
      'thyme, bay leaf, olive oil, salt', // FR: thym, laurier, huile d'olive, sel
    ],
    steps: <String>[
      // FR: Coupe tous les légumes en cubes de même taille.
      'Cut all the vegetables into cubes of the same size.',
      // FR: Fais revenir les aubergines seules, à feu vif, puis réserve.
      'Fry the aubergines on their own over a high heat, then set aside.',
      // FR: Pareil pour les courgettes, puis les poivrons, puis les oignons. Chacun son tour, chacun son goût.
      'Do the same with the courgettes, then the peppers, then the onions. Each in turn, each with its own flavour.',
      // FR: Dans la cocotte, fais fondre tomates et ail avec thym et laurier, 15 minutes.
      'In the casserole, melt the tomatoes and garlic with thyme and bay leaf for 15 minutes.',
      // FR: Réunis tout, sale, et laisse mijoter à découvert 30 minutes.
      'Bring everything together, add salt and leave to simmer uncovered for 30 minutes.',
      // FR: Meilleure réchauffée le lendemain — vraiment.
      'Better reheated the next day — really.',
    ],
  ),
  'aubergine/Caviar d\'aubergine': RecipeText(
    // FR: Caviar d'aubergine
    name: 'Aubergine caviar',
    // FR: Les aubergines brûlées au four, puis écrasées à l'huile et au citron.
    description: 'Aubergines charred in the oven, then mashed with oil and lemon.',
    ingredients: <String>[
      '3 aubergines', // FR: 3 aubergines
      '1 garlic clove', // FR: 1 gousse d'ail
      '1 lemon', // FR: 1 citron
      '3 tablespoons of olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      '1 tablespoon of tahini (optional), salt, cumin', // FR: 1 cuillère à soupe de tahin (facultatif), sel, cumin
    ],
    steps: <String>[
      // FR: Pique les aubergines entières et enfourne-les à 220 °C, 45 minutes, jusqu'à ce que la peau cloque et noircisse.
      'Prick the whole aubergines and put them in the oven at 220 °C for 45 minutes, until the skin blisters and blackens.',
      // FR: Coupe-les en deux et récupère la chair à la cuillère.
      'Cut them in half and scoop out the flesh with a spoon.',
      // FR: Laisse-la égoutter 10 minutes dans une passoire.
      'Leave it to drain for 10 minutes in a colander.',
      // FR: Écrase à la fourchette avec ail, citron, huile, cumin, sel. Pas au mixeur : on veut de la texture.
      'Mash with a fork with garlic, lemon, oil, cumin and salt. Not in a blender: you want texture.',
      // FR: Un filet d'huile dessus, avec du pain grillé.
      'A drizzle of oil on top, with toasted bread.',
    ],
  ),

  // ─────────── aubergine_africaine (6 recettes) ───────────
  'aubergine_africaine/Djakhatou blanchis au congélateur': RecipeText(
    // FR: Djakhatou blanchis au congélateur
    name: 'Blanched djakhatou for the freezer',
    // FR: Blanchis quatre minutes et congelés, ils se jettent directement dans le thiéboudienne ou la sauce.
    description: 'Blanched for four minutes and frozen, they go straight into the thiéboudienne or the sauce.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of African aubergines', // FR: 1,5 kg d'aubergines africaines
      'the juice of one lemon', // FR: le jus d'un citron
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les aubergines et retire le calice vert.
      'Wash the aubergines and remove the green calyx.',
      // FR: Coupe les petites en deux, les grosses en quatre.
      'Cut the small ones in half and the large ones in quarters.',
      // FR: Ajoute le jus de citron à une grande eau bouillante salée : il empêche la chair de noircir.
      'Add the lemon juice to a large pan of boiling salted water: it stops the flesh from blackening.',
      // FR: Plonge les morceaux à gros bouillons.
      'Plunge the pieces in at a rolling boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée, le même temps.
      'Drain and plunge straight into iced water, for the same length of time.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Drain and dry well on a tea towel.',
      // FR: Étale sur une plaque, congèle 2 heures, puis mets en sacs.
      'Spread on a tray, freeze for 2 hours, then put in bags.',
    ],
  ),
  'aubergine_africaine/Rondelles d\'aubergine africaine séchées': RecipeText(
    // FR: Rondelles d'aubergine africaine séchées
    name: 'Dried African aubergine slices',
    // FR: Séchées en rondelles, elles se gardent des mois et se réhydratent dans les sauces mijotées.
    description: 'Dried in slices, they keep for months and rehydrate in slow-cooked sauces.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 months in a dry place, out of the light',
    ingredients: <String>[
      '1 kg of African aubergines', // FR: 1 kg d'aubergines africaines
      'the juice of one lemon', // FR: le jus d'un citron
      '1 bowl of water', // FR: 1 saladier d'eau
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Lave les aubergines et retire le calice.
      'Wash the aubergines and remove the calyx.',
      // FR: Coupe-les en rondelles de 5 mm, toutes de la même épaisseur.
      'Cut them into slices 5 mm thick, all the same thickness.',
      // FR: Plonge-les 5 minutes dans l'eau citronnée pour qu'elles ne noircissent pas, puis égoutte.
      'Soak them for 5 minutes in the lemon water so they do not blacken, then drain.',
      // FR: Étale en une couche et sèche à **60 °C**, porte entrouverte. Au soleil, compte 2 à 3 jours.
      'Spread in a single layer and dry at **60 °C**, door held ajar. In the sun, count 2 to 3 days.',
      // FR: Elles sont prêtes quand elles sont cassantes et sans aucun cœur mou.
      'They are ready when they are brittle with no soft centre at all.',
      // FR: Mets en bocal hermétique. Fais-les tremper 20 minutes avant de les ajouter à la sauce.
      'Put in an airtight jar. Soak them for 20 minutes before adding them to the sauce.',
    ],
  ),
  'aubergine_africaine/Djakhatou grillés à l\'huile': RecipeText(
    // FR: Djakhatou grillés à l'huile
    name: 'Grilled djakhatou in oil',
    // FR: Grillés et couverts d'huile, ils font un antipasto fondant et légèrement amer à garder au frais.
    description: 'Grilled and covered in oil, they make a melting, slightly bitter antipasto to keep in the fridge.',
    // FR: 2 semaines au réfrigérateur
    keeps: '2 weeks in the fridge',
    ingredients: <String>[
      '1 kg of African aubergines', // FR: 1 kg d'aubergines africaines
      '25 cl of olive oil', // FR: 25 cl d'huile d'olive
      '1 teaspoon of dried thyme', // FR: 1 cuillère à café de thym séché
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les aubergines, retire le calice et coupe-les en tranches de 1 cm.
      'Wash the aubergines, remove the calyx and cut them into 1 cm slices.',
      // FR: Sale-les légèrement et laisse dégorger, puis éponge-les.
      'Salt them lightly and leave them to drain, then pat them dry.',
      // FR: Fais-les griller à la poêle ou sous le gril, jusqu'à ce qu'elles soient **tendres à cœur** et marquées.
      'Grill them in a pan or under the grill until they are **tender right through** and marked.',
      // FR: Laisse-les refroidir complètement sur une grille.
      'Leave them to cool completely on a rack.',
      // FR: Range-les dans un bocal propre en saupoudrant de thym **séché**, jamais d'ail ni d'herbes crus.
      'Layer them in a clean jar, sprinkling with **dried** thyme, never with raw garlic or herbs.',
      // FR: Couvre entièrement d'huile, tasse pour chasser les bulles, et ferme.
      'Cover completely with oil, press down to release the bubbles, and close.',
      // FR: Toujours au réfrigérateur. Sors le bocal 20 minutes avant de servir, l'huile fige au froid.
      'Always in the fridge. Take the jar out 20 minutes before serving, as the oil sets in the cold.',
    ],
  ),
  'aubergine_africaine/Djakhatou en sauce': RecipeText(
    // FR: Djakhatou en sauce
    name: 'Djakhatou in sauce',
    // FR: Amers et fermes, ils tiennent la cuisson longue.
    description: 'Bitter and firm, they stand up to long cooking.',
  ),
  'aubergine_africaine/Kedjenou de poulet': RecipeText(
    // FR: Kedjenou de poulet
    name: 'Chicken kedjenou',
    // FR: Le mijoté ivoirien à l'étouffée, où l'aubergine africaine fond dans la sauce.
    description: 'The Ivorian slow-steamed stew, where the African aubergine melts into the sauce.',
  ),
  'aubergine_africaine/Sauce djakhatou': RecipeText(
    // FR: Sauce djakhatou
    name: 'Djakhatou sauce',
    // FR: L'aubergine amère mijotée à la sénégalaise, pour les amateurs de vrais goûts.
    description: 'The bitter aubergine simmered the Senegalese way, for those who like real flavours.',
  ),

  // ─────────── bananier_plantain (6 recettes) ───────────
  'bananier_plantain/Plantains mûrs en tronçons congelés': RecipeText(
    // FR: Plantains mûrs en tronçons congelés
    name: 'Ripe plantain chunks for the freezer',
    // FR: Quand tout le régime mûrit d'un coup, un quart d'heure et tes plantains attendent la poêle au congélateur.
    description: 'When the whole bunch ripens at once, a quarter of an hour and your plantains wait for the frying pan in the freezer.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      'ripe plantains, yellow skin spotted with black', // FR: des plantains mûrs, peau jaune tachée de noir
      'baking paper', // FR: du papier cuisson
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les deux bouts, incise la peau sur toute la longueur et retire-la d'un bloc.
      'Cut off both ends, slit the skin along its length and peel it off in one piece.',
      // FR: Coupe en tronçons de 4 cm, ou directement en biais comme pour les frire.
      'Cut into 4 cm chunks, or straight on the diagonal as for frying.',
      // FR: Étale-les sur une plaque recouverte de papier cuisson, **sans qu'ils se touchent**, et congèle 2 heures.
      'Spread them on a tray lined with baking paper, **not touching**, and freeze for 2 hours.',
      // FR: Verse-les en sac une fois durs, chasse l'air et note la date.
      'Tip them into a bag once hard, press out the air and note the date.',
      // FR: À l'usage, fais-les frire encore à moitié gelés, à feu moyen : décongelés, ils boivent l'huile.
      'To use, fry them while still half frozen, over a medium heat: thawed, they soak up the oil.',
    ],
  ),
  'bananier_plantain/Farine de plantain vert': RecipeText(
    // FR: Farine de plantain vert
    name: 'Green plantain flour',
    // FR: Séché et moulu, le plantain vert devient une farine qui se garde un an et se cuit en pâte ou en bouillie.
    description: 'Dried and ground, green plantain becomes a flour that keeps for a year and cooks into a dough or a porridge.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      '2 kg of very green plantains', // FR: 2 kg de plantains bien verts
      'the juice of one lemon', // FR: le jus d'un citron
      '1 bowl of cold water', // FR: 1 saladier d'eau froide
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Huile-toi les mains ou mets des gants : la sève du plantain vert tache. Coupe les bouts et fends la peau le long des arêtes pour l'enlever.
      'Oil your hands or wear gloves: the sap of green plantain stains. Cut off the ends and slit the skin along the ridges to remove it.',
      // FR: Coupe la chair en rondelles fines de 3 mm, au couteau ou à la mandoline.
      'Cut the flesh into thin slices 3 mm thick, with a knife or a mandoline.',
      // FR: Plonge-les au fur et à mesure dans l'eau citronnée : sans ça, elles noircissent en dix minutes.
      'Drop them into the lemon water as you go: without that, they blacken in ten minutes.',
      // FR: Égoutte, étale en une couche et sèche à **60 °C**, porte entrouverte, jusqu'à ce qu'elles cassent net. Au soleil, 3 à 4 jours.
      'Drain, spread in a single layer and dry at **60 °C**, door held ajar, until they snap cleanly. In the sun, 3 to 4 days.',
      // FR: Mixe les rondelles refroidies en poudre fine, puis passe-la au tamis et remixe ce qui reste.
      'Blend the cooled slices to a fine powder, then pass it through a sieve and blend again what is left.',
      // FR: Mets en bocal hermétique bien sec. Pour l'utiliser, verse-la en pluie dans l'eau bouillante en remuant.
      'Put in a very dry airtight jar. To use, pour it in a stream into boiling water, stirring.',
    ],
  ),
  'bananier_plantain/Plantains semi-frits à congeler': RecipeText(
    // FR: Plantains semi-frits à congeler
    name: 'Part-fried plantains for the freezer',
    // FR: Frits une fois, aplatis, congelés : il ne reste qu'une deuxième friture de trois minutes pour des tostones croustillants.
    description: 'Fried once, flattened, frozen: all that is left is a second three-minute fry for crisp tostones.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      '4 green or just-yellow plantains', // FR: 4 plantains verts ou juste jaunes
      'frying oil', // FR: huile de friture
      'baking paper', // FR: du papier cuisson
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les plantains et coupe-les en tronçons épais de 3 cm.
      'Peel the plantains and cut them into chunks 3 cm thick.',
      // FR: Fais-les frire dans l'huile à 160 °C jusqu'à ce qu'ils soient tendres mais **encore pâles**.
      'Fry them in oil at 160 °C until they are tender but **still pale**.',
      // FR: Égoutte-les et écrase chaque tronçon avec le fond d'un verre, à 1 cm d'épaisseur.
      'Drain them and flatten each chunk with the bottom of a glass, to 1 cm thick.',
      // FR: Laisse refroidir complètement sur du papier absorbant.
      'Leave to cool completely on kitchen paper.',
      // FR: Pose-les sur une plaque garnie de papier cuisson et congèle 2 heures, puis mets-les en sac.
      'Lay them on a tray lined with baking paper and freeze for 2 hours, then put them in a bag.',
      // FR: Le jour J, plonge-les encore gelés dans l'huile à 180 °C, 3 minutes. Sale à la sortie.
      'On the day, drop them still frozen into oil at 180 °C for 3 minutes. Salt as they come out.',
    ],
  ),
  'bananier_plantain/Alloco': RecipeText(
    // FR: Alloco
    name: 'Alloco',
    // FR: Les plantains bien mûrs frits à l'ivoirienne, dorés et fondants à souhait.
    description: 'Very ripe plantains fried the Ivorian way, golden and meltingly soft.',
  ),
  'bananier_plantain/Kelewele': RecipeText(
    // FR: Kelewele
    name: 'Kelewele',
    // FR: Le plantain frit du Ghana, mariné au gingembre et au piment, sucré-épicé.
    description: 'Ghana\'s fried plantain, marinated in ginger and chilli, sweet and spicy.',
  ),
  'bananier_plantain/Foutou banane': RecipeText(
    // FR: Foutou banane
    name: 'Foutou banane',
    // FR: La boule de plantain pilé de Côte d'Ivoire, à tremper dans une bonne sauce.
    description: 'The pounded plantain ball from Côte d\'Ivoire, for dipping in a good sauce.',
  ),

  // ─────────── baselle (6 recettes) ───────────
  'baselle/Baselle blanchie au congélateur': RecipeText(
    // FR: Baselle blanchie au congélateur
    name: 'Blanched Malabar spinach for the freezer',
    // FR: Feuilles charnues et tiges tendres, blanchies puis congelées : elles retrouvent leur fondant dans la sauce.
    description: 'Fleshy leaves and tender stems, blanched then frozen: they turn melting again in the sauce.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of Malabar spinach, leaves and tender stems', // FR: 1 kg de baselle, feuilles et tiges tendres
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Sépare les feuilles des tiges et coupe les tiges tendres en tronçons de 3 cm.
      'Separate the leaves from the stems and cut the tender stems into 3 cm pieces.',
      // FR: Lave le tout dans plusieurs eaux.
      'Wash everything in several changes of water.',
      // FR: Plonge d'abord les tiges dans l'eau bouillante salée 1 minute, puis ajoute les feuilles pour une minute de plus.
      'Plunge the stems first into boiling salted water for 1 minute, then add the leaves for one minute more.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée.
      'Drain and plunge straight into iced water.',
      // FR: Égoutte bien et presse doucement : la baselle est gluante, inutile de l'essorer à fond.
      'Drain well and press gently: Malabar spinach is slimy, so there is no need to wring it out completely.',
      // FR: Répartis à plat en sacs, une portion par sac, et congèle.
      'Spread flat in bags, one portion per bag, and freeze.',
    ],
  ),
  'baselle/Velouté de baselle à congeler': RecipeText(
    // FR: Velouté de baselle à congeler
    name: 'Malabar spinach soup for the freezer',
    // FR: La baselle épaissit d'elle-même : un velouté onctueux sans crème, parfait pour le congélateur.
    description: 'Malabar spinach thickens by itself: a creamy soup with no cream, perfect for the freezer.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '600 g of Malabar spinach', // FR: 600 g de baselle
      '3 potatoes', // FR: 3 pommes de terre
      '1 onion', // FR: 1 oignon
      '1.2 litres of stock', // FR: 1,2 litre de bouillon
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave la baselle et hache grossièrement feuilles et tiges tendres.
      'Wash the Malabar spinach and roughly chop the leaves and tender stems.',
      // FR: Épluche et coupe en dés les pommes de terre et l'oignon.
      'Peel and dice the potatoes and the onion.',
      // FR: Cuis pommes de terre et oignon dans le bouillon.
      'Cook the potatoes and onion in the stock.',
      // FR: Ajoute la baselle et cuis quelques minutes, juste qu'elle fonde.
      'Add the Malabar spinach and cook for a few minutes, just until it wilts.',
      // FR: Mixe hors du feu. **Sans crème** : elle tranche à la décongélation, tu l'ajouteras dans l'assiette.
      'Blend off the heat. **No cream**: it splits when thawed, so add it in the bowl.',
      // FR: Refroidis vite, casserole dans l'eau froide.
      'Cool quickly, with the pan in cold water.',
      // FR: Répartis en portions en laissant 2 cm de vide, et note la date.
      'Divide into portions, leaving 2 cm of space at the top, and note the date.',
    ],
  ),
  'baselle/Feuilles de baselle congelées crues': RecipeText(
    // FR: Feuilles de baselle congelées crues
    name: 'Raw frozen Malabar spinach leaves',
    // FR: Un quart d'heure quand la liane déborde : crues et congelées, elles finissent dans les sauces mijotées.
    description: 'A quarter of an hour when the vine overflows: raw and frozen, the leaves end up in slow-cooked sauces.',
    // FR: 3 mois au congélateur
    keeps: '3 months in the freezer',
    ingredients: <String>[
      'fresh Malabar spinach leaves', // FR: des feuilles de baselle fraîches
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Cueille les feuilles et les pointes tendres, retire les tiges dures.
      'Pick the leaves and tender tips, and remove the tough stems.',
      // FR: Lave et **sèche à fond** dans un torchon : l'eau restante fait du givre.
      'Wash and **dry thoroughly** in a tea towel: any water left turns to frost.',
      // FR: Mets en sacs par portions, à plat, en chassant l'air.
      'Put in bags in portions, flat, pressing out the air.',
      // FR: Jette-les encore gelées dans la sauce en fin de cuisson. Crues, elles se gardent moins longtemps que blanchies.
      'Drop them still frozen into the sauce at the end of cooking. Raw, they keep for less time than blanched.',
    ],
  ),
  'baselle/Baselle à la sauce tomate': RecipeText(
    // FR: Baselle à la sauce tomate
    name: 'Malabar spinach in tomato sauce',
    // FR: Ses feuilles charnues épaississent la sauce d'elles-mêmes.
    description: 'Its fleshy leaves thicken the sauce by themselves.',
  ),
  'baselle/Baselle vapeur au sésame': RecipeText(
    // FR: Baselle vapeur au sésame
    name: 'Steamed Malabar spinach with sesame',
    // FR: Cinq minutes de vapeur, huile de sésame et soja.
    description: 'Five minutes of steam, sesame oil and soy sauce.',
  ),
  'baselle/Sauce feuilles de baselle': RecipeText(
    // FR: Sauce feuilles de baselle
    name: 'Malabar spinach leaf sauce',
    // FR: L'épinard de Ceylan mijoté en sauce onctueuse, douce et légèrement mucilagineuse.
    description: 'Ceylon spinach simmered into a creamy, mild and slightly mucilaginous sauce.',
  ),

  // ─────────── basilic (6 recettes) ───────────
  'basilic/Pâte de basilic sans fromage': RecipeText(
    // FR: Pâte de basilic sans fromage
    name: 'Cheese-free basil paste',
    // FR: Le basilic à l'huile, mixé sans parmesan ni pignons : la base qui se congèle le mieux, tu finis le pesto au moment de servir.
    description: 'Basil in oil, blended without Parmesan or pine nuts: the base that freezes best. You finish the pesto when you serve it.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '200 g of basil leaves', // FR: 200 g de feuilles de basilic
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      '1 pinch of salt', // FR: 1 pincée de sel
      'small pots or an ice-cube tray', // FR: des petits pots ou un bac à glaçons
    ],
    steps: <String>[
      // FR: Effeuille le basilic et jette les tiges dures et les fleurs.
      'Pick the basil leaves off and throw away the tough stalks and the flowers.',
      // FR: Rince rapidement et **sèche très bien** les feuilles dans un torchon, sans les froisser : meurtries, elles noircissent.
      'Rinse quickly and **dry the leaves very well** in a tea towel, without crumpling them: bruised, they turn black.',
      // FR: Mixe par à-coups avec l'huile et le sel, sans laisser chauffer la lame, jusqu'à une pâte grossière.
      'Blend in short bursts with the oil and salt, without letting the blade heat up, to a coarse paste.',
      // FR: Répartis en petits pots ou en bac à glaçons et couvre d'un filet d'huile : c'est ce qui **garde le vert**.
      'Divide between small pots or an ice-cube tray and cover with a thin layer of oil: that is what **keeps it green**.',
      // FR: Congèle aussitôt. À l'usage, ajoute parmesan, pignons et ail à la pâte décongelée.
      'Freeze straight away. To use, add Parmesan, pine nuts and garlic to the thawed paste.',
    ],
  ),
  'basilic/Glaçons de basilic à l\'huile d\'olive': RecipeText(
    // FR: Glaçons de basilic à l'huile d'olive
    name: 'Basil olive oil cubes',
    // FR: Des feuilles hachées prises dans l'huile, à faire fondre dans une sauce tomate ou sur un gratin.
    description: 'Chopped leaves set in oil, to melt into a tomato sauce or over a gratin.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '3 big handfuls of basil', // FR: 3 grosses poignées de basilic
      '10 cl of olive oil', // FR: 10 cl d'huile d'olive
      'ice-cube trays', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Effeuille, rince et sèche bien les feuilles.
      'Pick the leaves, rinse them and dry them well.',
      // FR: Hache-les grossièrement avec un couteau bien aiguisé, qui coupe sans écraser.
      'Chop them roughly with a very sharp knife, which cuts without crushing.',
      // FR: Remplis les bacs aux trois quarts de basilic haché.
      'Fill the trays three quarters full with chopped basil.',
      // FR: Couvre d'huile d'olive jusqu'à ce que les feuilles soient **entièrement noyées**.
      'Cover with olive oil until the leaves are **completely submerged**.',
      // FR: Congèle jusqu'à ce qu'ils soient durs, puis démoule et garde en sac. Toujours au congélateur, jamais à température ambiante.
      'Freeze until hard, then turn out and keep in a bag. Always in the freezer, never at room temperature.',
    ],
  ),
  'basilic/Vinaigre de basilic': RecipeText(
    // FR: Vinaigre de basilic
    name: 'Basil vinegar',
    // FR: Les dernières tiges, avant les premières gelées, infusées dans du vinaigre : l'été dans chaque vinaigrette.
    description: 'The last stems before the first frosts, steeped in vinegar: summer in every vinaigrette.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, out of the light',
    ingredients: <String>[
      '2 big handfuls of basil', // FR: 2 grosses poignées de basilic
      '75 cl of white wine vinegar at 6 %', // FR: 75 cl de vinaigre de vin blanc à 6 %
      '1 clean glass bottle', // FR: 1 bouteille en verre propre
    ],
    steps: <String>[
      // FR: Rince les tiges et **sèche-les à fond** : une goutte d'eau suffit à troubler le vinaigre.
      'Rinse the stems and **dry them thoroughly**: a single drop of water is enough to cloud the vinegar.',
      // FR: Froisse légèrement les feuilles entre tes mains pour libérer l'arôme.
      'Bruise the leaves lightly between your hands to release the aroma.',
      // FR: Tasse le basilic dans un bocal propre et couvre-le entièrement de vinaigre.
      'Pack the basil into a clean jar and cover it completely with vinegar.',
      // FR: Ferme et laisse infuser 2 semaines à l'abri de la lumière, en secouant de temps en temps.
      'Close and leave to steep for 2 weeks out of the light, shaking now and then.',
      // FR: Filtre dans une bouteille propre et jette les feuilles : sorties du vinaigre, elles ne se gardent pas.
      'Strain into a clean bottle and throw the leaves away: once out of the vinegar, they do not keep.',
    ],
  ),
  'basilic/Pistou': RecipeText(
    // FR: Pistou
    name: 'Pistou',
    // FR: Basilic, ail et huile, sans pignons : la version provençale.
    description: 'Basil, garlic and oil, no pine nuts: the Provençal version.',
    ingredients: <String>[
      '2 big bunches of basil', // FR: 2 gros bouquets de basilic
      '4 garlic cloves', // FR: 4 gousses d'ail
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      '60 g of Parmesan (optional)', // FR: 60 g de parmesan (facultatif)
      'coarse salt', // FR: gros sel
    ],
    steps: <String>[
      // FR: Effeuille le basilic. Les tiges amères ne vont pas au mortier.
      'Pick the basil leaves. The bitter stalks do not belong in the mortar.',
      // FR: Pile l'ail au gros sel, puis ajoute les feuilles.
      'Pound the garlic with coarse salt, then add the leaves.',
      // FR: Écrase en tournant, par petites poignées : au mortier le basilic rend son parfum, au mixeur il chauffe et noircit.
      'Crush with a circular motion, a small handful at a time: in a mortar basil gives up its scent, in a blender it heats up and turns black.',
      // FR: Monte à l'huile en filet jusqu'à une pommade.
      'Work in the oil in a thin stream until it forms a paste.',
    ],
  ),
  'basilic/Soupe au pistou': RecipeText(
    // FR: Soupe au pistou
    name: 'Pistou soup',
    // FR: Tous les légumes d'été, et une cuillère de pistou au dernier moment.
    description: 'All the summer vegetables, and a spoonful of pistou at the last moment.',
    ingredients: <String>[
      '300 g of fresh white beans', // FR: 300 g de haricots blancs frais
      '2 courgettes, 2 carrots, 2 potatoes', // FR: 2 courgettes, 2 carottes, 2 pommes de terre
      '200 g of green beans', // FR: 200 g de haricots verts
      '3 tomatoes', // FR: 3 tomates
      '100 g of short pasta, pistou, salt', // FR: 100 g de pâtes courtes, pistou, sel
    ],
    steps: <String>[
      // FR: Fais cuire les haricots blancs 30 minutes dans de l'eau non salée.
      'Cook the white beans for 30 minutes in unsalted water.',
      // FR: Ajoute les légumes en dés, du plus dur au plus tendre, et sale.
      'Add the diced vegetables, from the hardest to the most tender, and add salt.',
      // FR: Cuis 20 minutes.
      'Cook for 20 minutes.',
      // FR: Ajoute les pâtes les 10 dernières minutes.
      'Add the pasta for the last 10 minutes.',
      // FR: Le pistou se met **hors du feu**, dans la soupière ou dans l'assiette. Cuit, il perd tout.
      'The pistou goes in **off the heat**, in the tureen or in the bowl. Cooked, it loses everything.',
    ],
  ),
  'basilic/Pesto maison': RecipeText(
    // FR: Pesto maison
    name: 'Homemade pesto',
    // FR: Avec pignons et parmesan, la version génoise, pour les pâtes.
    description: 'With pine nuts and Parmesan, the Genoese version, for pasta.',
    ingredients: <String>[
      '80 g of basil leaves', // FR: 80 g de feuilles de basilic
      '40 g of pine nuts', // FR: 40 g de pignons
      '60 g of Parmesan', // FR: 60 g de parmesan
      '1 garlic clove', // FR: 1 gousse d'ail
      '12 cl of olive oil, salt', // FR: 12 cl d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Torréfie les pignons 2 minutes à sec.
      'Toast the pine nuts for 2 minutes in a dry pan.',
      // FR: Mixe basilic, ail, pignons par à-coups pour ne pas chauffer.
      'Blend the basil, garlic and pine nuts in short bursts so they do not heat up.',
      // FR: Ajoute le parmesan, puis l'huile en filet.
      'Add the Parmesan, then the oil in a thin stream.',
      // FR: Pour les pâtes : détends-le avec une cuillère d'eau de cuisson, jamais sur le feu.
      'For pasta: loosen it with a spoonful of the cooking water, never over the heat.',
    ],
  ),

  // ─────────── betterave (6 recettes) ───────────
  'betterave/Betteraves en tranches au vinaigre': RecipeText(
    // FR: Betteraves en tranches au vinaigre
    name: 'Sliced beetroot in vinegar',
    // FR: Cuites, tranchées et noyées de vinaigre épicé : le pickle rubis des grands-mères, prêt pour toutes les salades.
    description: 'Cooked, sliced and drowned in spiced vinegar: the ruby-red pickle of grandmothers, ready for every salad.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '2 kg of beetroot', // FR: 2 kg de betteraves
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '100 g of sugar', // FR: 100 g de sucre
      '1 tablespoon of salt', // FR: 1 cuillère à soupe de sel
      '1 onion, 4 cloves', // FR: 1 oignon, 4 clous de girofle
    ],
    steps: <String>[
      // FR: Brosse les betteraves sans les éplucher et laisse 3 cm de tige : entières, elles ne saignent pas.
      'Scrub the beetroot without peeling and leave 3 cm of stalk: whole, they do not bleed.',
      // FR: Cuis-les à l'eau frémissante jusqu'à ce qu'un couteau entre facilement.
      'Cook them in barely simmering water until a knife goes in easily.',
      // FR: Passe-les sous l'eau froide : la peau glisse alors toute seule sous les doigts.
      'Run them under cold water: the skin then slips off under your fingers.',
      // FR: Coupe-les en tranches de 5 mm et l'oignon en fines rondelles.
      'Cut them into 5 mm slices and the onion into thin rings.',
      // FR: Porte à ébullition vinaigre, eau, sucre, sel et girofle.
      'Bring the vinegar, water, sugar, salt and cloves to the boil.',
      // FR: Range betteraves et oignon en couches dans des bocaux propres, jusqu'à 2 cm du bord.
      'Layer the beetroot and onion in clean jars, up to 2 cm from the rim.',
      // FR: Verse le vinaigre bouillant pour **tout recouvrir**, ferme, laisse refroidir et range au réfrigérateur. Prêtes en 3 jours.
      'Pour in the boiling vinegar to **cover everything**, close, leave to cool and put in the fridge. Ready in 3 days.',
    ],
  ),
  'betterave/Betterave crue râpée en portions': RecipeText(
    // FR: Betterave crue râpée en portions
    name: 'Portions of grated raw beetroot',
    // FR: Un quart d'heure à la râpe, et tu as de quoi faire soupes, gâteaux et poêlées tout l'hiver.
    description: 'A quarter of an hour at the grater, and you have enough for soups, cakes and stir-fries all winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of raw beetroot', // FR: 1,5 kg de betteraves crues
      'gloves', // FR: des gants
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les betteraves à la brosse et coupe les deux bouts.
      'Scrub the beetroot with a brush and cut off both ends.',
      // FR: Épluche-les avec des gants : le jus rouge **tache les doigts** pour la journée.
      'Peel them wearing gloves: the red juice **stains your fingers** for the day.',
      // FR: Râpe-les gros, à la main ou au robot. Crue, la betterave garde tout son sucre.
      'Grate coarsely, by hand or in the food processor. Raw, beetroot keeps all its sugar.',
      // FR: Répartis en sachets de 200 g, aplatis-les et chasse l'air. Utilise-la **cuite** : décongelée crue, elle devient molle.
      'Divide into 200 g bags, flatten them and press out the air. Use it **cooked**: thawed raw, it goes soft.',
    ],
  ),
  'betterave/Betterave râpée lacto-fermentée': RecipeText(
    // FR: Betterave râpée lacto-fermentée
    name: 'Lacto-fermented grated beetroot',
    // FR: Crue, râpée et salée, elle fermente en un condiment acidulé et croquant qui se garde des mois.
    description: 'Raw, grated and salted, it ferments into a tangy, crunchy condiment that keeps for months.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '1 kg of raw peeled beetroot', // FR: 1 kg de betteraves crues épluchées
      '20 g of non-iodised salt', // FR: 20 g de sel non iodé
      '1 teaspoon of caraway seeds', // FR: 1 cuillère à café de graines de carvi
      '1 small piece of ginger', // FR: 1 petit morceau de gingembre
    ],
    steps: <String>[
      // FR: Épluche les betteraves avec des gants et râpe-les côté gros trous. Pèse : il faut **20 g de sel par kilo**.
      'Peel the beetroot wearing gloves and grate it on the coarse side. Weigh it: you need **20 g of salt per kilo**.',
      // FR: Mélange la râpée avec le sel, le carvi et le gingembre râpé, et masse quelques minutes jusqu'à ce que le jus sorte.
      'Mix the grated beetroot with the salt, caraway and grated ginger, and massage for a few minutes until the juice comes out.',
      // FR: Tasse très fort par couches dans un bocal propre, avec le poing, jusqu'à ce que le jus **remonte au-dessus**.
      'Pack it down very hard in layers in a clean jar, with your fist, until the juice **rises above it**.',
      // FR: Pose un poids, laisse 3 cm de vide, et laisse fermenter 1 à 2 semaines vers 20 °C. Appuie chaque jour pour chasser les bulles.
      'Add a weight, leave 3 cm of space, and let it ferment for 1 to 2 weeks at around 20 °C. Press it down every day to release the bubbles.',
      // FR: Quand c'est acidulé à ton goût, ferme et range au réfrigérateur. Toujours une cuillère propre.
      'When it is tangy enough for you, close the jar and put it in the fridge. Always use a clean spoon.',
    ],
  ),
  'betterave/Betteraves rôties au four': RecipeText(
    // FR: Betteraves rôties au four
    name: 'Oven-roasted beetroot',
    // FR: Cuites en robe, elles concentrent leur sucre au lieu de le perdre dans l'eau.
    description: 'Cooked in their skins, they concentrate their sugar instead of losing it in the water.',
    ingredients: <String>[
      '6 medium beetroot', // FR: 6 betteraves moyennes
      '2 tablespoons of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      'coarse salt, thyme', // FR: gros sel, thym
      '1 tablespoon of balsamic vinegar', // FR: 1 cuillère à soupe de vinaigre balsamique
    ],
    steps: <String>[
      // FR: Brosse les betteraves sans les peler, coupe les fanes à 2 cm.
      'Scrub the beetroot without peeling and cut the leaves off at 2 cm.',
      // FR: Enrobe d'huile, roule dans le gros sel, pose sur une plaque.
      'Coat with oil, roll in the coarse salt and put on a tray.',
      // FR: Four à 200 °C, 60 minutes. Un couteau doit entrer sans résistance.
      'Oven at 200 °C, 60 minutes. A knife should go in without resistance.',
      // FR: Tiédies, la peau se retire au doigt — et ne tache pas les mains comme à cru.
      'Once lukewarm, the skin comes off with your fingers — and does not stain your hands the way it does raw.',
      // FR: Coupe en quartiers, un trait de balsamique.
      'Cut into wedges, with a dash of balsamic.',
    ],
  ),
  'betterave/Betterave chèvre et noix': RecipeText(
    // FR: Betterave chèvre et noix
    name: 'Beetroot, goat\'s cheese and walnuts',
    // FR: Le trio qui ne rate jamais : le sucré, l'acide et le croquant.
    description: 'The trio that never fails: sweet, sharp and crunchy.',
    ingredients: <String>[
      '4 cooked beetroot', // FR: 4 betteraves cuites
      '150 g of fresh goat\'s cheese', // FR: 150 g de fromage de chèvre frais
      '60 g of walnut halves', // FR: 60 g de cerneaux de noix
      '1 tablespoon of honey', // FR: 1 cuillère à soupe de miel
      'oil, vinegar, salt, pepper, chives', // FR: huile, vinaigre, sel, poivre, ciboulette
    ],
    steps: <String>[
      // FR: Coupe les betteraves en dés réguliers.
      'Cut the beetroot into even cubes.',
      // FR: Mélange huile, vinaigre, miel, sel, poivre.
      'Mix oil, vinegar, honey, salt and pepper.',
      // FR: Dresse les dés, émiette le chèvre dessus, parsème les noix.
      'Arrange the cubes, crumble the goat\'s cheese over them and scatter the walnuts.',
      // FR: Verse la sauce au dernier moment, ciboulette, et sers frais.
      'Pour on the dressing at the last moment, add chives and serve cold.',
    ],
  ),
  'betterave/Soupe de betterave à l\'aneth': RecipeText(
    // FR: Soupe de betterave à l'aneth
    name: 'Beetroot and dill soup',
    // FR: Une couleur impossible, et un goût de terre douce que l'aneth éclaire.
    description: 'An impossible colour, and a taste of sweet earth that dill brightens.',
    ingredients: <String>[
      '600 g of beetroot', // FR: 600 g de betteraves
      '1 potato', // FR: 1 pomme de terre
      '1 onion', // FR: 1 oignon
      '80 cl of stock', // FR: 80 cl de bouillon
      '10 cl of cream, dill, salt, pepper', // FR: 10 cl de crème, aneth, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé.
      'Soften the sliced onion.',
      // FR: Ajoute betteraves et pomme de terre en dés, puis le bouillon.
      'Add the diced beetroot and potato, then the stock.',
      // FR: Cuis 30 minutes à couvert.
      'Cook for 30 minutes with the lid on.',
      // FR: Mixe longuement : la betterave demande à être lisse.
      'Blend for a long time: beetroot needs to be smooth.',
      // FR: Crème hors du feu, beaucoup d'aneth ciselé. Bon chaud comme glacé.
      'Stir in the cream off the heat, with plenty of snipped dill. Good hot or chilled.',
    ],
  ),

  // ─────────── bissap (6 recettes) ───────────
  'bissap/Calices de bissap séchés': RecipeText(
    // FR: Calices de bissap séchés
    name: 'Dried bissap calyces',
    // FR: Séchés à l'ombre, les calices gardent leur rouge profond et font du bissap toute l'année.
    description: 'Dried in the shade, the calyces keep their deep red and make bissap all year round.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      'fresh bissap calyces', // FR: les calices frais de bissap
      'a tube or a small rigid pipe', // FR: un tube ou un petit tuyau rigide
      'drying racks or a clean sheet', // FR: des claies ou un drap propre
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe la base du calice et pousse la capsule verte avec un tube : elle sort d'un coup, le calice reste entier.
      'Cut the base of the calyx and push out the green capsule with a tube: it pops out in one go and the calyx stays whole.',
      // FR: Rince rapidement les calices et égoutte-les bien.
      'Rinse the calyces quickly and drain them well.',
      // FR: Étale-les en couche mince à l'ombre, dans un endroit aéré, 4 à 5 jours en les retournant chaque jour. Le soleil direct les ternit.
      'Spread them in a thin layer in the shade, somewhere airy, for 4 to 5 days, turning them every day. Direct sun dulls them.',
      // FR: Teste : ils doivent être craquants comme du papier. Mous, ils moisiront dans le bocal.
      'Test: they should be crisp as paper. Soft, they will go mouldy in the jar.',
      // FR: Mets-les en bocaux hermétiques, à l'abri de la lumière. Garde les capsules pour ressemer.
      'Put them in airtight jars, out of the light. Keep the capsules for sowing.',
    ],
  ),
  'bissap/Gelée de bissap': RecipeText(
    // FR: Gelée de bissap
    name: 'Bissap jelly',
    // FR: Le bissap est plein de pectine : il fait une gelée qui prend toute seule, acidulée et rouge rubis.
    description: 'Bissap is full of pectin: it makes a jelly that sets by itself, tangy and ruby red.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '500 g of fresh bissap calyces', // FR: 500 g de calices de bissap frais
      '1 litre of water', // FR: 1 litre d'eau
      '800 g of sugar', // FR: 800 g de sucre
      'the juice of one lemon', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Sépare les calices des capsules et rince-les.
      'Separate the calyces from the capsules and rinse them.',
      // FR: Fais-les cuire dans l'eau à petits bouillons, à couvert, jusqu'à ce qu'ils soient tout mous.
      'Cook them in the water at a gentle simmer, covered, until completely soft.',
      // FR: Verse dans un torchon propre au-dessus d'un saladier et laisse couler sans presser trop fort.
      'Pour into a clean cloth over a bowl and let it drip without squeezing too hard.',
      // FR: Mesure 1 litre de jus, ajoute le sucre et le citron, et porte à ébullition en remuant.
      'Measure 1 litre of juice, add the sugar and lemon, and bring to the boil, stirring.',
      // FR: Cuis à feu vif en écumant.
      'Cook over a high heat, skimming.',
      // FR: Teste sur une assiette froide : une goutte qui se ride quand tu la pousses du doigt, c'est prêt.
      'Test on a cold plate: a drop that wrinkles when you push it with a finger is ready.',
      // FR: Verse dans des pots ébouillantés jusqu'à 1 cm du bord, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars to 1 cm from the rim, close and turn upside down until cool.',
    ],
  ),
  'bissap/Calices frais congelés': RecipeText(
    // FR: Calices frais congelés
    name: 'Frozen fresh calyces',
    // FR: Un quart d'heure, et tes calices frais attendent l'envie d'une gelée ou d'un bissap bien rouge.
    description: 'A quarter of an hour, and your fresh calyces wait until you fancy a jelly or a deep red bissap.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'fresh bissap calyces', // FR: des calices de bissap frais
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les capsules en les poussant avec un tube par la base du calice.
      'Remove the capsules by pushing them out with a tube through the base of the calyx.',
      // FR: Rince et **sèche bien** les calices sur un torchon.
      'Rinse and **dry the calyces well** on a tea towel.',
      // FR: Étale-les sur une plaque et congèle 1 heure, puis mets-les en sac.
      'Spread them on a tray and freeze for 1 hour, then put them in a bag.',
      // FR: Utilise-les encore gelés, directement dans l'eau chaude ou la casserole de confiture.
      'Use them still frozen, straight into hot water or the jam pan.',
    ],
  ),
  'bissap/Sorbet au bissap': RecipeText(
    // FR: Sorbet au bissap
    name: 'Bissap sorbet',
    // FR: L'infusion sucrée prise en sorbet, acidulée et profonde.
    description: 'The sweetened infusion churned into a sorbet, tangy and deep.',
  ),
  'bissap/Jus de bissap': RecipeText(
    // FR: Jus de bissap
    name: 'Bissap juice',
    // FR: L'infusion glacée d'hibiscus, rouge rubis, sucrée et follement rafraîchissante.
    description: 'The iced hibiscus infusion, ruby red, sweet and wonderfully refreshing.',
  ),
  'bissap/Sirop de bissap': RecipeText(
    // FR: Sirop de bissap
    name: 'Bissap syrup',
    // FR: Un sirop maison concentré, à garder au frais pour tes boissons de saison chaude.
    description: 'A concentrated homemade syrup, to keep in the fridge for your hot-weather drinks.',
  ),

  // ─────────── blette (6 recettes) ───────────
  'blette/Vert de blettes en boulettes': RecipeText(
    // FR: Vert de blettes en boulettes
    name: 'Swiss chard leaf balls',
    // FR: Une minute dans l'eau bouillante, pressé en boules : du vert prêt pour les omelettes et les farces tout l'hiver.
    description: 'One minute in boiling water, squeezed into balls: greens ready for omelettes and stuffings all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of Swiss chard (the leaves)', // FR: 2 kg de blettes (le vert)
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Sépare le vert des côtes en coupant de part et d'autre de la nervure. Garde les côtes pour les pickles.
      'Separate the leaves from the ribs by cutting along either side of the midrib. Keep the ribs for pickles.',
      // FR: Lave les feuilles dans plusieurs eaux et coupe-les grossièrement.
      'Wash the leaves in several changes of water and chop them roughly.',
      // FR: Plonge-les dans une grande eau salée bouillante, **1 minute**, juste le temps qu'elles s'affaissent.
      'Plunge them into a large pan of boiling salted water for **1 minute**, just long enough for them to collapse.',
      // FR: Fais-les tomber dans l'eau glacée pour fixer le vert.
      'Drop them into iced water to set the green.',
      // FR: Presse-les très fort entre tes mains pour chasser l'eau, et forme des boulettes d'une portion.
      'Squeeze them very hard between your hands to get the water out, and shape into portion-sized balls.',
      // FR: Congèle-les 2 heures sur une plaque, puis passe-les en sac.
      'Freeze them for 2 hours on a tray, then put them in a bag.',
    ],
  ),
  'blette/Côtes de blettes au vinaigre': RecipeText(
    // FR: Côtes de blettes au vinaigre
    name: 'Swiss chard ribs in vinegar',
    // FR: Les côtes rouges et jaunes deviennent des pickles croquants qui font de l'effet dans un bocal.
    description: 'The red and yellow ribs become crunchy pickles that look wonderful in a jar.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '800 g of Swiss chard ribs', // FR: 800 g de côtes de blettes
      '40 cl of cider vinegar at 6 %', // FR: 40 cl de vinaigre de cidre à 6 %
      '40 cl of water', // FR: 40 cl d'eau
      '2 tablespoons of sugar', // FR: 2 cuillères à soupe de sucre
      '1 tablespoon of fine salt', // FR: 1 cuillère à soupe de sel fin
      '1 teaspoon of coriander seeds', // FR: 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Rince les côtes et retire les fils des plus larges en tirant avec un couteau, comme pour la rhubarbe.
      'Rinse the ribs and remove the strings from the widest ones by pulling with a knife, as you would for rhubarb.',
      // FR: Coupe-les en bâtonnets de la hauteur de tes bocaux, moins 2 cm.
      'Cut them into sticks the height of your jars, minus 2 cm.',
      // FR: Range-les debout, bien serrés, avec les graines de coriandre.
      'Stand them upright, tightly packed, with the coriander seeds.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement** les côtes, ferme et laisse refroidir.
      'Pour in boiling hot until the ribs are **completely covered**, close and leave to cool.',
      // FR: Range au réfrigérateur et attends 3 jours. Les côtes colorées teintent le liquide, c'est joli et normal.
      'Keep in the fridge and wait 3 days. The coloured ribs tint the liquid, which is pretty and normal.',
    ],
  ),
  'blette/Hachis de blettes à l\'oignon': RecipeText(
    // FR: Hachis de blettes à l'oignon
    name: 'Chopped Swiss chard with onion',
    // FR: Côtes et vert fondus ensemble, congelés en portions : une base prête pour une quiche, des pâtes ou des raviolis.
    description: 'Ribs and leaves melted together and frozen in portions: a ready base for a quiche, pasta or ravioli.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of whole Swiss chard', // FR: 1,5 kg de blettes entières
      '2 onions', // FR: 2 oignons
      '2 tablespoons of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave les blettes, sépare côtes et vert, et retire les fils des grosses côtes.
      'Wash the chard, separate ribs and leaves, and remove the strings from the thick ribs.',
      // FR: Coupe les côtes en petits dés et hache grossièrement le vert. Émince les oignons.
      'Cut the ribs into small dice and roughly chop the leaves. Slice the onions.',
      // FR: Fais revenir oignons et côtes dans l'huile à couvert, jusqu'à ce qu'ils soient tendres.
      'Soften the onions and ribs in the oil with the lid on, until tender.',
      // FR: Ajoute le vert et laisse cuire à découvert pour évaporer l'eau, en remuant.
      'Add the leaves and cook uncovered to evaporate the water, stirring.',
      // FR: Sale, poivre, râpe un peu de muscade. Goûte : c'est plus facile d'assaisonner maintenant qu'après.
      'Add salt, pepper and a little grated nutmeg. Taste: it is easier to season now than afterwards.',
      // FR: Refroidis vite en étalant sur une plaque, puis répartis en boîtes d'une portion, à 2 cm du bord, et congèle.
      'Cool quickly by spreading on a tray, then divide into single-portion boxes, 2 cm from the top, and freeze.',
    ],
  ),
  'blette/Blettes à la crème': RecipeText(
    // FR: Blettes à la crème
    name: 'Creamy Swiss chard',
    // FR: Vert et côtes cuits séparément, réunis dans une crème au citron.
    description: 'Leaves and ribs cooked separately, brought together in a lemony cream.',
    ingredients: <String>[
      '1 bunch of Swiss chard', // FR: 1 botte de blettes
      '20 cl of cream', // FR: 20 cl de crème
      '20 g of butter', // FR: 20 g de beurre
      '1/2 lemon', // FR: 1/2 citron
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Sépare le vert des côtes : ils ne cuisent pas en même temps.
      'Separate the leaves from the ribs: they do not cook in the same time.',
      // FR: Cuis les côtes 15 minutes à l'eau citronnée — le citron les empêche de noircir.
      'Cook the ribs for 15 minutes in lemony water — the lemon stops them from blackening.',
      // FR: Fais tomber le vert 5 minutes à la poêle beurrée.
      'Wilt the leaves for 5 minutes in a buttered pan.',
      // FR: Égoutte tout soigneusement.
      'Drain everything carefully.',
      // FR: Réunis avec la crème, laisse épaissir 5 minutes, muscade.
      'Bring together with the cream, let it thicken for 5 minutes, add nutmeg.',
    ],
  ),
  'blette/Tourte de blettes niçoise': RecipeText(
    // FR: Tourte de blettes niçoise
    name: 'Niçoise Swiss chard pie',
    // FR: La tourte sucrée du pays niçois : blettes, raisins secs, pignons.
    description: 'The sweet pie of the Nice region: chard, raisins, pine nuts.',
    ingredients: <String>[
      '2 shortcrust pastry sheets', // FR: 2 pâtes brisées
      'the leaves from one bunch of Swiss chard', // FR: le vert d'une botte de blettes
      '2 apples', // FR: 2 pommes
      '60 g of raisins, 40 g of pine nuts', // FR: 60 g de raisins secs, 40 g de pignons
      '80 g of sugar, 1 egg, 1 lemon', // FR: 80 g de sucre, 1 oeuf, 1 citron
    ],
    steps: <String>[
      // FR: Hache finement le vert des blettes, cru — il ne se cuit pas avant.
      'Finely chop the chard leaves, raw — they are not cooked beforehand.',
      // FR: Mélange-le aux pommes râpées, raisins, pignons, sucre, zeste de citron.
      'Mix them with the grated apples, raisins, pine nuts, sugar and lemon zest.',
      // FR: Garnis la première pâte, couvre de la seconde, soude les bords.
      'Fill the first pastry sheet, cover with the second and seal the edges.',
      // FR: Dore à l'oeuf battu et pique le dessus.
      'Brush with beaten egg and prick the top.',
      // FR: Four à 180 °C, 45 minutes.
      'Oven at 180 °C, 45 minutes.',
      // FR: Sucre glace à froid. Surprenant, et très bon.
      'Icing sugar once cold. Surprising, and very good.',
    ],
  ),
  'blette/Gratin de côtes de blettes': RecipeText(
    // FR: Gratin de côtes de blettes
    name: 'Swiss chard rib gratin',
    // FR: Les côtes, qu'on jette trop souvent, sous une béchamel légère.
    description: 'The ribs, so often thrown away, under a light béchamel.',
    ingredients: <String>[
      'the ribs from 2 bunches of Swiss chard', // FR: les côtes de 2 bottes de blettes
      '40 g of butter, 40 g of flour', // FR: 40 g de beurre, 40 g de farine
      '50 cl of milk', // FR: 50 cl de lait
      '100 g of Gruyère', // FR: 100 g de gruyère
      'salt, pepper, nutmeg, 1/2 lemon', // FR: sel, poivre, muscade, 1/2 citron
    ],
    steps: <String>[
      // FR: Pèle les fils des côtes à l'économe et coupe-les en tronçons.
      'Peel the strings off the ribs with a vegetable peeler and cut them into pieces.',
      // FR: Cuis-les 20 minutes à l'eau citronnée salée.
      'Cook them for 20 minutes in salted lemony water.',
      // FR: Béchamel : beurre fondu, farine 2 minutes, lait chaud en fouettant.
      'Béchamel: melt the butter, add the flour for 2 minutes, then hot milk, whisking.',
      // FR: Mélange les côtes égouttées à la béchamel, verse dans le plat, fromage dessus.
      'Mix the drained ribs into the béchamel, pour into the dish and put the cheese on top.',
      // FR: Four à 190 °C, 25 minutes.
      'Oven at 190 °C, 25 minutes.',
    ],
  ),

  // ─────────── bleuet (6 recettes) ───────────
  'bleuet/Pétales de bleuet séchés': RecipeText(
    // FR: Pétales de bleuet séchés
    name: 'Dried cornflower petals',
    // FR: Séchés à l'ombre, ils gardent leur bleu intense pour décorer gâteaux et salades toute l'année.
    description: 'Dried in the shade, they keep their intense blue to decorate cakes and salads all year round.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 year in a jar, out of the light',
    ingredients: <String>[
      'about fifty fully open cornflower blooms', // FR: une cinquantaine de fleurs de bleuet bien ouvertes
      'newspaper or a drying rack', // FR: du papier journal ou une claie
      'an opaque jar', // FR: un bocal opaque
    ],
    steps: <String>[
      // FR: Cueille les fleurs en fin de matinée, quand la rosée est partie, le jour où elles viennent de s'ouvrir.
      'Pick the flowers late in the morning, once the dew has gone, on the day they have just opened.',
      // FR: Pince la base de chaque fleur et tire les petits pétales bleus : la partie verte ne se garde pas.
      'Pinch the base of each flower and pull out the little blue petals: the green part does not keep.',
      // FR: Étale-les en une couche fine sur du papier, **à l'ombre**, dans une pièce sèche et aérée, pendant 3 jours.
      'Spread them in a thin layer on paper, **in the shade**, in a dry, airy room, for 3 days.',
      // FR: Teste : un pétale sec est cassant comme du papier. S'il est encore mou, laisse-le un jour de plus.
      'Test: a dry petal is brittle as paper. If it is still soft, leave it another day.',
      // FR: Range-les en bocal opaque : à la lumière, le bleu passe au gris en quelques semaines.
      'Store them in an opaque jar: in the light, the blue turns grey within a few weeks.',
    ],
  ),
  'bleuet/Glaçons fleuris au bleuet': RecipeText(
    // FR: Glaçons fleuris au bleuet
    name: 'Cornflower ice cubes',
    // FR: Un quart d'heure pour des glaçons qui transforment un verre d'eau en jolie boisson d'été.
    description: 'A quarter of an hour for ice cubes that turn a glass of water into a pretty summer drink.',
    // FR: 3 mois au congélateur
    keeps: '3 months in the freezer',
    ingredients: <String>[
      'about twenty cornflower blooms', // FR: une vingtaine de fleurs de bleuet
      '50 cl of boiled water, cooled', // FR: 50 cl d'eau bouillie refroidie
      'an ice-cube tray', // FR: un bac à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Détache les pétales ou garde de petites fleurs entières, sans la partie verte.
      'Pull off the petals, or keep small whole flowers, without the green part.',
      // FR: Remplis le bac à moitié avec l'eau bouillie refroidie : elle donne des glaçons **bien transparents**.
      'Fill the tray halfway with the cooled boiled water: it gives **crystal-clear** ice cubes.',
      // FR: Pose les pétales dans chaque case et congèle une heure : ils restent ainsi au milieu du glaçon.
      'Place the petals in each compartment and freeze for an hour: that way they stay in the middle of the cube.',
      // FR: Complète avec le reste de l'eau froide et remets au congélateur jusqu'à ce que ce soit dur.
      'Top up with the rest of the cold water and put back in the freezer until hard.',
      // FR: Démoule les glaçons et garde-les en sac, à l'écart des aliments qui sentent fort.
      'Turn the cubes out and keep them in a bag, away from strong-smelling food.',
    ],
  ),
  'bleuet/Vinaigre rose au bleuet': RecipeText(
    // FR: Vinaigre rose au bleuet
    name: 'Pink cornflower vinegar',
    // FR: Au contact du vinaigre, le bleu vire au rose : un condiment tout doux et très joli sur une salade.
    description: 'On contact with the vinegar, the blue turns pink: a very mild, very pretty condiment for a salad.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '2 big handfuls of cornflower petals', // FR: 2 grosses poignées de pétales de bleuet
      '50 cl of cider or white wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de cidre ou de vin blanc à 6 % minimum
      '1 clean jar', // FR: 1 bocal propre
      '2 bottles of 25 cl', // FR: 2 bouteilles de 25 cl
    ],
    steps: <String>[
      // FR: Détache les pétales des fleurs cueillies le matin, sans la partie verte qui donnerait de l'amertume.
      'Pull the petals off flowers picked in the morning, without the green part, which would add bitterness.',
      // FR: Mets les pétales dans le bocal en les tassant légèrement.
      'Put the petals in the jar, pressing them down lightly.',
      // FR: Verse le vinaigre : les pétales doivent être **entièrement couverts**. Regarde la couleur virer en quelques minutes.
      'Pour in the vinegar: the petals must be **completely covered**. Watch the colour change within minutes.',
      // FR: Ferme et laisse infuser 2 semaines à l'abri de la lumière, en secouant de temps en temps.
      'Close and leave to steep for 2 weeks out of the light, shaking now and then.',
      // FR: Filtre à travers un linge fin et mets en bouteilles propres. Garde à l'ombre pour ne pas perdre la couleur.
      'Strain through a fine cloth and pour into clean bottles. Keep in the shade so the colour does not fade.',
    ],
  ),
  'bleuet/Fleurs de bleuet en décoration': RecipeText(
    // FR: Fleurs de bleuet en décoration
    name: 'Cornflowers as decoration',
    // FR: Les pétales, crus, posés sur une salade ou un gâteau.
    description: 'The petals, raw, scattered over a salad or a cake.',
  ),
  'bleuet/Infusion de bleuet': RecipeText(
    // FR: Infusion de bleuet
    name: 'Cornflower infusion',
    // FR: Fleurs séchées, douces, légèrement amères.
    description: 'Dried flowers, mild, slightly bitter.',
  ),
  'bleuet/Sel aux fleurs': RecipeText(
    // FR: Sel aux fleurs
    name: 'Flower salt',
    // FR: Pétales séchés mélangés au gros sel.
    description: 'Dried petals mixed into coarse salt.',
  ),

  // ─────────── bourrache (6 recettes) ───────────
  'bourrache/Jeunes feuilles de bourrache blanchies': RecipeText(
    // FR: Jeunes feuilles de bourrache blanchies
    name: 'Blanched young borage leaves',
    // FR: Blanchies comme des épinards, elles farcissent raviolis et tourtes à la mode ligure tout l'hiver.
    description: 'Blanched like spinach, they fill ravioli and pies Ligurian-style all winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of young borage leaves', // FR: 1 kg de jeunes feuilles de bourrache
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Prends seulement les **jeunes feuilles** du cœur, et mets des gants : elles piquent. Coupe les pétioles.
      'Take only the **young leaves** from the centre, and wear gloves: they prickle. Cut off the stalks.',
      // FR: Lave-les dans plusieurs eaux froides.
      'Wash them in several changes of cold water.',
      // FR: Plonge-les dans une grande eau salée à gros bouillons, 1 minute. Les poils piquants disparaissent à la cuisson.
      'Plunge them into a large pan of salted water at a rolling boil for 1 minute. The prickly hairs disappear as they cook.',
      // FR: Égoutte et plonge-les aussitôt dans l'eau glacée pour fixer le vert.
      'Drain and plunge them straight into iced water to set the green.',
      // FR: Presse-les en boule entre tes mains, **vraiment fort** : l'eau qui reste devient du givre.
      'Squeeze them into a ball between your hands, **really hard**: any water left turns to frost.',
      // FR: Forme des boulettes d'une portion, congèle-les sur plaque, puis mets-les en sac.
      'Shape portion-sized balls, freeze them on a tray, then put them in a bag.',
    ],
  ),
  'bourrache/Gelée de fleurs de bourrache': RecipeText(
    // FR: Gelée de fleurs de bourrache
    name: 'Borage flower jelly',
    // FR: Les étoiles bleues donnent une gelée rose tendre au goût léger de concombre : la surprise du petit-déjeuner.
    description: 'The blue stars make a soft pink jelly with a light cucumber flavour: the breakfast surprise.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '3 handfuls of borage flowers (about 60 g)', // FR: 3 poignées de fleurs de bourrache (environ 60 g)
      '75 cl of water', // FR: 75 cl d'eau
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '750 g of sugar', // FR: 750 g de sucre
      '1 sachet of pectin for 1 kg of fruit', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Tire chaque fleur hors de son calice velu : ne garde que l'étoile bleue.
      'Pull each flower out of its hairy calyx: keep only the blue star.',
      // FR: Porte l'eau à ébullition, verse-la sur les fleurs, couvre et coupe le feu.
      'Bring the water to the boil, pour it over the flowers, cover and turn off the heat.',
      // FR: Laisse infuser une heure, puis filtre en pressant les fleurs.
      'Leave to steep for an hour, then strain, pressing the flowers.',
      // FR: Ajoute le jus de citron : l'infusion vire du bleu au rose.
      'Add the lemon juice: the infusion turns from blue to pink.',
      // FR: Mélange la pectine à un peu du sucre, verse-la dans l'infusion, porte à ébullition puis ajoute le reste du sucre.
      'Mix the pectin with a little of the sugar, stir it into the infusion, bring to the boil, then add the rest of the sugar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Boil hard, stirring, following the instructions on the pectin packet.',
      // FR: Verse en pots chauds ébouillantés, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pour into hot scalded jars, close straight away and turn upside down until cool.',
    ],
  ),
  'bourrache/Fleurs de bourrache séchées pour le décor': RecipeText(
    // FR: Fleurs de bourrache séchées pour le décor
    name: 'Dried borage flowers for decoration',
    // FR: Séchées vite et à l'ombre, elles gardent une partie de leur bleu pour décorer biscuits et infusions.
    description: 'Dried quickly and in the shade, they keep some of their blue to decorate biscuits and infusions.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, out of the light',
    ingredients: <String>[
      '2 handfuls of borage flowers', // FR: 2 poignées de fleurs de bourrache
      'a drying rack, a sieve or a grid', // FR: une claie, un tamis ou une grille
      'a small airtight box', // FR: une petite boîte hermétique
    ],
    steps: <String>[
      // FR: Cueille les fleurs fraîchement ouvertes, rosée évaporée, et détache-les de leur calice.
      'Pick freshly opened flowers once the dew has evaporated, and detach them from their calyx.',
      // FR: Ne les lave pas : étale-les une par une sur la claie, sans qu'elles se touchent.
      'Do not wash them: lay them out one by one on the rack, not touching.',
      // FR: Fais-les sécher à l'ombre dans une pièce chaude et aérée, ou au déshydrateur à 35 °C. **Plus c'est rapide, plus le bleu tient.**
      'Dry them in the shade in a warm, airy room, or in a dehydrator at 35 °C. **The quicker, the better the blue holds.**',
      // FR: Elles sont prêtes quand elles sont fines comme du papier et se brisent au toucher.
      'They are ready when they are thin as paper and break at a touch.',
      // FR: Range-les dans une boîte hermétique, dans le noir : la lumière les décolore en quelques semaines.
      'Store them in an airtight box, in the dark: light fades them within a few weeks.',
    ],
  ),
  'bourrache/Fleurs de bourrache glacées': RecipeText(
    // FR: Fleurs de bourrache glacées
    name: 'Frozen borage flowers',
    // FR: Prises dans des glaçons, bleues dans le verre.
    description: 'Set in ice cubes, blue in the glass.',
  ),
  'bourrache/Bourrache en beignets': RecipeText(
    // FR: Bourrache en beignets
    name: 'Borage fritters',
    // FR: Les feuilles, en pâte à beignets légère.
    description: 'The leaves, in a light fritter batter.',
  ),
  'bourrache/Soupe de bourrache': RecipeText(
    // FR: Soupe de bourrache
    name: 'Borage soup',
    // FR: Les jeunes feuilles ont un goût de concombre.
    description: 'The young leaves taste of cucumber.',
  ),

  // ─────────── brocoli (6 recettes) ───────────
  'brocoli/Fleurettes de brocoli blanchies au congélateur': RecipeText(
    // FR: Fleurettes de brocoli blanchies au congélateur
    name: 'Blanched broccoli florets for the freezer',
    // FR: Trois minutes dans l'eau bouillante, et tes brocolis restent verts et fermes jusqu'au printemps.
    description: 'Three minutes in boiling water, and your broccoli stays green and firm until spring.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of broccoli', // FR: 2 kg de brocolis
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Fais tremper les têtes 10 minutes dans l'eau froide salée, tête en bas : les petites chenilles sortent toutes seules.
      'Soak the heads for 10 minutes in cold salted water, head down: the little caterpillars come out by themselves.',
      // FR: Détaille en fleurettes de taille égale, et pèle la tige avant de la couper en rondelles : elle se congèle aussi.
      'Cut into florets of equal size, and peel the stalk before slicing it into rounds: it freezes well too.',
      // FR: Plonge-les par petites quantités dans une grande eau bouillante, **3 minutes** chrono à la reprise de l'ébullition.
      'Plunge them in small batches into a large pan of boiling water, timing **3 minutes** from when it returns to the boil.',
      // FR: Transfère aussitôt dans l'eau glacée, autant de temps que la cuisson : c'est ce qui **fixe le vert**.
      'Transfer straight into iced water for as long as the cooking took: that is what **sets the green**.',
      // FR: Égoutte puis sèche sur un torchon propre. Chaque goutte restée devient du givre.
      'Drain, then dry on a clean tea towel. Every drop left turns to frost.',
      // FR: Étale sur une plaque sans qu'elles se touchent, congèle 2 heures, puis verse en sacs datés.
      'Spread on a tray without touching, freeze for 2 hours, then pour into dated bags.',
    ],
  ),
  'brocoli/Pesto de brocoli en glaçons': RecipeText(
    // FR: Pesto de brocoli en glaçons
    name: 'Broccoli pesto cubes',
    // FR: Le brocoli un peu trop monté devient un pesto doux, à jeter en cube dans des pâtes chaudes.
    description: 'Broccoli that has bolted a little becomes a mild pesto, to drop as a cube into hot pasta.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '500 g of broccoli (florets and peeled stalks)', // FR: 500 g de brocoli (fleurettes et tiges pelées)
      '50 g of almonds', // FR: 50 g d'amandes
      '1 garlic clove', // FR: 1 gousse d'ail
      '12 cl of olive oil', // FR: 12 cl d'huile d'olive
      'the juice of half a lemon', // FR: le jus d'un demi-citron
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Cuis les fleurettes et les tiges en morceaux 3 minutes à l'eau bouillante salée.
      'Cook the florets and the stalks, cut into pieces, for 3 minutes in boiling salted water.',
      // FR: Refroidis-les dans l'eau glacée, puis égoutte et presse-les bien dans un torchon.
      'Cool them in iced water, then drain and press them well in a tea towel.',
      // FR: Mixe brocoli, amandes, ail et citron par à-coups, en versant l'huile en filet. **Pas de parmesan** : tu le râperas au moment de servir.
      'Blend the broccoli, almonds, garlic and lemon in short bursts, pouring in the oil in a thin stream. **No Parmesan**: you will grate it when serving.',
      // FR: Sale légèrement et goûte : le froid estompe un peu le sel.
      'Season lightly with salt and taste: the cold dulls the salt a little.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile pour éviter qu'il noircisse.
      'Fill an ice-cube tray and cover each compartment with a thin layer of oil so it does not blacken.',
      // FR: Démoule les cubes une fois durs, au bout de 4 heures, et garde-les en sac daté.
      'Turn the cubes out once hard, after 4 hours, and keep them in a dated bag.',
    ],
  ),
  'brocoli/Pickles de tiges de brocoli': RecipeText(
    // FR: Pickles de tiges de brocoli
    name: 'Broccoli stalk pickles',
    // FR: Les grosses tiges qu'on jette souvent deviennent des bâtonnets croquants pour l'apéro.
    description: 'The thick stalks that so often get thrown away become crunchy sticks for the aperitif.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '500 g of broccoli stalks', // FR: 500 g de tiges de brocoli
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 20 g of sugar', // FR: 10 g de sel, 20 g de sucre
      '1 garlic clove, 1 teaspoon of mustard seeds', // FR: 1 gousse d'ail, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Pèle les tiges à l'économe jusqu'à la chair vert pâle, puis coupe-les en bâtonnets de la taille d'un doigt.
      'Peel the stalks with a vegetable peeler down to the pale green flesh, then cut them into sticks the size of a finger.',
      // FR: Range-les debout et serrés dans deux bocaux ébouillantés, avec l'ail coupé en deux et la moutarde.
      'Stand them upright and tightly packed in two scalded jars, with the garlic cut in half and the mustard.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre, et remue jusqu'à ce qu'ils fondent.
      'Bring the vinegar, water, salt and sugar to the boil, and stir until they dissolve.',
      // FR: Verse le liquide bouillant jusqu'à **recouvrir entièrement** les bâtonnets, à 1 cm du bord, et ferme.
      'Pour the boiling liquid over to **cover the sticks completely**, to 1 cm from the rim, and close.',
      // FR: Laisse refroidir puis mets au réfrigérateur. Attends **3 jours** avant d'ouvrir : le vinaigre doit pénétrer jusqu'au cœur.
      'Leave to cool then put in the fridge. Wait **3 days** before opening: the vinegar needs to reach the middle.',
    ],
  ),
  'brocoli/Brocolis sautés à l\'ail': RecipeText(
    // FR: Brocolis sautés à l'ail
    name: 'Broccoli stir-fried with garlic',
    // FR: Blanchis puis saisis, piment et sésame.
    description: 'Blanched then seared, with chilli and sesame.',
  ),
  'brocoli/Velouté de brocoli': RecipeText(
    // FR: Velouté de brocoli
    name: 'Broccoli soup',
    // FR: Vert franc si tu le mixes à peine cuit.
    description: 'A bright green if you blend it barely cooked.',
  ),
  'brocoli/Brocolis au four, parmesan et citron': RecipeText(
    // FR: Brocolis au four, parmesan et citron
    name: 'Oven-roasted broccoli with Parmesan and lemon',
    // FR: Les pointes qui grillent sont les meilleures.
    description: 'The tips that char are the best bits.',
  ),

  // ─────────── camomille (6 recettes) ───────────
  'camomille/Capitules de camomille séchés à l\'ombre': RecipeText(
    // FR: Capitules de camomille séchés à l'ombre
    name: 'Chamomile flower heads dried in the shade',
    // FR: Les petites fleurs sèchent en une semaine et te donnent des infusions pour toute l'année.
    description: 'The little flowers dry in a week and give you herbal teas for the whole year.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      'fully open Roman chamomile flower heads', // FR: des capitules de camomille romaine bien ouverts
      'a drying rack, a sieve or a tea towel', // FR: une claie, un tamis ou un torchon
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille les fleurs par temps sec, en fin de matinée, quand elles sont **juste épanouies**. Coupe sous la tête, sans tige.
      'Pick the flowers in dry weather, late in the morning, when they have **just opened**. Cut under the head, with no stem.',
      // FR: Ne les lave pas. Étale-les en une seule couche sur la claie.
      'Do not wash them. Spread them in a single layer on the rack.',
      // FR: Laisse-les une semaine à l'ombre, dans une pièce sèche et aérée, en les retournant chaque jour.
      'Leave them for a week in the shade, in a dry, airy room, turning them every day.',
      // FR: Elles sont prêtes quand le cœur jaune s'effrite entre tes doigts.
      'They are ready when the yellow centre crumbles between your fingers.',
      // FR: Mets-les en bocal bien fermé. La romaine est amère : trois ou quatre capitules suffisent pour une tasse.
      'Put them in a tightly closed jar. Roman chamomile is bitter: three or four flower heads are enough for a cup.',
    ],
  ),
  'camomille/Gelée de camomille à la pomme': RecipeText(
    // FR: Gelée de camomille à la pomme
    name: 'Chamomile and apple jelly',
    // FR: Le jus de pomme fait la gelée, la camomille lui donne un parfum de miel et de foin.
    description: 'The apple juice makes the jelly set, the chamomile gives it a scent of honey and hay.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1 litre of pure apple juice', // FR: 1 litre de pur jus de pomme
      '2 handfuls of chamomile flower heads (or 15 g dried)', // FR: 2 poignées de capitules de camomille (ou 15 g séchés)
      'the juice of one lemon', // FR: le jus d'un citron
      '800 g of sugar', // FR: 800 g de sucre
      '1 sachet of pectin for 1 kg of fruit', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Fais chauffer le jus de pomme jusqu'aux premiers frémissements, puis coupe le feu.
      'Heat the apple juice until it just begins to tremble, then turn off the heat.',
      // FR: Jette les capitules dedans, couvre et laisse infuser **10 minutes seulement** : plus longtemps, la romaine devient amère.
      'Drop in the flower heads, cover and leave to steep for **only 10 minutes**: any longer and Roman chamomile turns bitter.',
      // FR: Filtre dans une passoire fine et presse les fleurs.
      'Strain through a fine sieve and press the flowers.',
      // FR: Ajoute le citron et la pectine mélangée à un peu de sucre, porte à ébullition, puis verse le reste du sucre.
      'Add the lemon and the pectin mixed with a little sugar, bring to the boil, then pour in the rest of the sugar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Boil hard, stirring, following the instructions on the pectin packet.',
      // FR: Mets en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into hot scalded jars, close and turn upside down until cool.',
    ],
  ),
  'camomille/Glaçons d\'infusion de camomille': RecipeText(
    // FR: Glaçons d'infusion de camomille
    name: 'Chamomile infusion ice cubes',
    // FR: Avec les fleurs fraîches du jour : des cubes à jeter dans une citronnade ou une infusion glacée.
    description: 'Made with the day\'s fresh flowers: cubes to drop into a lemonade or an iced infusion.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      'a small handful of fresh flower heads', // FR: une petite poignée de capitules frais
      '50 cl of water', // FR: 50 cl d'eau
      'two ice-cube trays', // FR: deux bacs à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Porte l'eau à frémissement, verse-la sur les fleurs et couvre.
      'Bring the water to a tremble, pour it over the flowers and cover.',
      // FR: Laisse infuser 5 minutes, pas plus : c'est déjà bien parfumé, et bien amer au-delà.
      'Leave to steep for 5 minutes, no more: it is already well scented, and very bitter beyond that.',
      // FR: Filtre et garde deux ou trois fleurs pour les mettre dans les cubes.
      'Strain and keep two or three flowers to put in the cubes.',
      // FR: Refroidis l'infusion vite, casserole posée dans l'eau froide.
      'Cool the infusion quickly, with the pan standing in cold water.',
      // FR: Remplis les bacs, pose une fleur dans quelques cases et congèle. Démoule ensuite en sac fermé.
      'Fill the trays, place a flower in a few compartments and freeze. Then turn out into a closed bag.',
    ],
  ),
  'camomille/Infusion de camomille': RecipeText(
    // FR: Infusion de camomille
    name: 'Chamomile infusion',
    // FR: Les capitules séchés à l'ombre, une cuillère par tasse.
    description: 'Flower heads dried in the shade, one spoonful per cup.',
  ),
  'camomille/Sirop de camomille': RecipeText(
    // FR: Sirop de camomille
    name: 'Chamomile syrup',
    // FR: Infusé fort puis sucré, sur une salade de fruits.
    description: 'Brewed strong then sweetened, over a fruit salad.',
  ),
  'camomille/Crème brûlée à la camomille': RecipeText(
    // FR: Crème brûlée à la camomille
    name: 'Chamomile crème brûlée',
    // FR: Infusée dans la crème chaude, filtrée avant de cuire.
    description: 'Infused in the hot cream, strained before baking.',
  ),

  // ─────────── capucine (6 recettes) ───────────
  'capucine/Pickles de graines vertes de capucine': RecipeText(
    // FR: Pickles de graines vertes de capucine
    name: 'Green nasturtium seed pickles',
    // FR: Les graines encore vertes deviennent de petites billes piquantes à la façon des câpres.
    description: 'The seeds, still green, become little peppery beads in the manner of capers.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '200 g of green nasturtium seeds', // FR: 200 g de graines vertes de capucine
      '1 litre of water and 50 g of salt', // FR: 1 litre d'eau et 50 g de sel
      '25 cl of white or cider vinegar at 6 % minimum', // FR: 25 cl de vinaigre blanc ou de cidre à 6 % minimum
      '1 bay leaf, a few peppercorns', // FR: 1 feuille de laurier, quelques grains de poivre
      '3 small clean pots', // FR: 3 petits pots propres
    ],
    steps: <String>[
      // FR: Cueille les graines quand elles sont **vertes et tendres** : un ongle doit s'y enfoncer. Sépare les trios.
      'Pick the seeds when they are **green and tender**: a fingernail should sink into them. Separate the clusters of three.',
      // FR: Rince-les à l'eau froide et égoutte.
      'Rinse them in cold water and drain.',
      // FR: Fais-les tremper 24 heures dans l'eau salée : le sel adoucit leur piquant et les raffermit.
      'Soak them for 24 hours in the salted water: the salt softens their bite and firms them up.',
      // FR: Égoutte, rince et répartis-les dans les pots avec le poivre et un morceau de laurier.
      'Drain, rinse and divide between the pots with the pepper and a piece of bay leaf.',
      // FR: Porte le vinaigre pur à ébullition.
      'Bring the undiluted vinegar to the boil.',
      // FR: Verse-le bouillant sur les graines pour les **couvrir entièrement**, ferme aussitôt.
      'Pour it boiling over the seeds to **cover them completely**, close straight away.',
      // FR: Une fois froids, range les pots au réfrigérateur et attends un mois avant d'y goûter.
      'Once cold, put the pots in the fridge and wait a month before tasting.',
    ],
  ),
  'capucine/Pesto de feuilles de capucine': RecipeText(
    // FR: Pesto de feuilles de capucine
    name: 'Nasturtium leaf pesto',
    // FR: Les feuilles ont un piquant de cresson : en pesto congelé, elles relèvent des pâtes en plein hiver.
    description: 'The leaves have the bite of watercress: as a frozen pesto, they liven up pasta in the depths of winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '150 g of young nasturtium leaves', // FR: 150 g de jeunes feuilles de capucine
      '50 g of walnut halves', // FR: 50 g de cerneaux de noix
      '1 garlic clove', // FR: 1 gousse d'ail
      '12 cl of olive oil', // FR: 12 cl d'huile d'olive
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles, retire les tiges et **sèche-les bien** : de l'eau ferait tourner le pesto.
      'Wash the leaves, remove the stalks and **dry them well**: water would make the pesto turn.',
      // FR: Mixe les feuilles, les noix et l'ail par à-coups pour ne pas chauffer la verdure.
      'Blend the leaves, walnuts and garlic in short bursts so the greenery does not heat up.',
      // FR: Verse l'huile en filet en mixant, puis sale. Garde le fromage pour le moment de servir.
      'Pour in the oil in a thin stream while blending, then add salt. Save the cheese for serving.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile.
      'Fill an ice-cube tray and cover each compartment with a thin layer of oil.',
      // FR: Démoule les cubes une fois durs et garde-les en sac fermé. Un cube par assiette de pâtes.
      'Turn the cubes out once hard and keep them in a closed bag. One cube per plate of pasta.',
    ],
  ),
  'capucine/Vinaigre rouge aux fleurs de capucine': RecipeText(
    // FR: Vinaigre rouge aux fleurs de capucine
    name: 'Red nasturtium flower vinegar',
    // FR: Les fleurs orange donnent un vinaigre poivré et cuivré, superbe sur une salade de tomates.
    description: 'The orange flowers give a peppery, copper-coloured vinegar, superb on a tomato salad.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, out of the light',
    ingredients: <String>[
      '40 nasturtium flowers', // FR: 40 fleurs de capucine
      '1 peeled garlic clove', // FR: 1 gousse d'ail pelée
      '50 cl of red wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin rouge à 6 % minimum
      'a clean jar', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Cueille les fleurs bien ouvertes, le matin, sans traitement. Regarde dans l'éperon : il abrite parfois un insecte.
      'Pick fully open flowers in the morning, from untreated plants. Look into the spur: there is sometimes an insect inside.',
      // FR: Mets-les dans le bocal avec l'ail coupé en deux.
      'Put them in the jar with the garlic cut in half.',
      // FR: Couvre de vinaigre pur jusqu'en haut : tout doit être **sous le liquide**.
      'Cover with undiluted vinegar right to the top: everything must be **under the liquid**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps.
      'Close and leave to steep for two weeks in the shade, shaking now and then.',
      // FR: Filtre dans une bouteille propre et jette fleurs et ail : on ne les laisse pas indéfiniment.
      'Strain into a clean bottle and throw away the flowers and garlic: they are not left in indefinitely.',
    ],
  ),
  'capucine/Salade aux fleurs de capucine': RecipeText(
    // FR: Salade aux fleurs de capucine
    name: 'Salad with nasturtium flowers',
    // FR: Poivrées comme du cresson, et très belles dans l'assiette.
    description: 'Peppery like watercress, and very pretty on the plate.',
  ),
  'capucine/Câpres de capucine': RecipeText(
    // FR: Câpres de capucine
    name: 'Nasturtium capers',
    // FR: Les boutons floraux au vinaigre remplacent les vraies câpres.
    description: 'The flower buds in vinegar stand in for real capers.',
  ),
  'capucine/Beurre de capucine': RecipeText(
    // FR: Beurre de capucine
    name: 'Nasturtium butter',
    // FR: Pétales hachés dans du beurre pommade.
    description: 'Chopped petals worked into softened butter.',
  ),

  // ─────────── carotte (6 recettes) ───────────
  'carotte/Rondelles de carottes blanchies congelées': RecipeText(
    // FR: Rondelles de carottes blanchies congelées
    name: 'Blanched, frozen carrot rounds',
    // FR: Trois minutes d'eau bouillante, et tes carottes gardent leur couleur et leur goût sucré jusqu'au printemps.
    description: 'Three minutes in boiling water, and your carrots keep their colour and their sweet flavour until spring.',
    // FR: 12 mois au congélateur
    keeps: '12 months in the freezer',
    ingredients: <String>[
      '2 kg carrots', // FR: 2 kg de carottes
      'coarse salt', // FR: gros sel
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les carottes sous l'eau ; épluche seulement les grosses.
      'Scrub the carrots under running water; peel only the big ones.',
      // FR: Coupe-les en rondelles d'un demi-centimètre, toutes de la même épaisseur pour qu'elles blanchissent pareil.
      'Cut them into rounds half a centimetre thick, all the same thickness so they blanch evenly.',
      // FR: Plonge-les par fournées dans l'eau bouillante salée et compte **3 minutes** à la reprise de l'ébullition.
      'Drop them in batches into salted boiling water and count **3 minutes** from when it comes back to the boil.',
      // FR: Transfère-les aussitôt dans l'eau glacée, autant de temps qu'elles ont cuit.
      'Move them straight into the iced water, for as long as they cooked.',
      // FR: Égoutte et sèche-les sur un torchon : chaque goutte qui reste devient du givre.
      'Drain them and dry them on a tea towel: every drop left behind turns into frost.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis verse-les en sac : tu en prendras une poignée à la fois.
      'Spread them on a tray, freeze for 2 hours, then tip them into bags: you will take out a handful at a time.',
    ],
  ),
  'carotte/Carottes lacto-fermentées au gingembre': RecipeText(
    // FR: Carottes lacto-fermentées au gingembre
    name: 'Lacto-fermented carrots with ginger',
    // FR: Des bâtonnets croquants et acidulés qui se gardent des mois, sans cuisson ni vinaigre : juste du sel et de la patience.
    description: 'Crunchy, tangy sticks that keep for months, with no cooking and no vinegar: just salt and patience.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '1 kg carrots', // FR: 1 kg de carottes
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '1 piece of ginger, 4 cm long', // FR: 1 morceau de gingembre de 4 cm
      '2 garlic cloves', // FR: 2 gousses d'ail
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %. Eau du robinet laissée une nuit à l'air, ou eau de source.
      'Dissolve **30 g of salt in 1 litre of water**: that is a 3 % brine. Use tap water left out overnight, or spring water.',
      // FR: Épluche les carottes et coupe-les en bâtonnets un peu plus courts que la hauteur du bocal.
      'Peel the carrots and cut them into sticks a little shorter than the height of the jar.',
      // FR: Range-les debout bien serrés dans un bocal propre, avec le gingembre et l'ail en lamelles.
      'Stand them upright, packed tightly, in a clean jar, with the ginger and garlic in thin slices.',
      // FR: Verse la saumure jusqu'à **couvrir de 2 cm**, en laissant 3 cm de vide sous le couvercle.
      'Pour in the brine until it **covers them by 2 cm**, leaving 3 cm of space under the lid.',
      // FR: Pose un poids pour que rien ne dépasse, ferme sans serrer et laisse 10 à 15 jours vers 20 °C, à l'abri de la lumière.
      'Put a weight on top so nothing sticks out, close the lid without tightening it and leave for 10 to 15 days at about 20 °C, away from the light.',
      // FR: Quand la saumure est trouble et que ça sent l'aigrelet, serre le couvercle et range au réfrigérateur.
      'When the brine turns cloudy and smells slightly sour, tighten the lid and put the jar in the fridge.',
    ],
  ),
  'carotte/Pickles de carottes au cumin': RecipeText(
    // FR: Pickles de carottes au cumin
    name: 'Carrot pickles with cumin',
    // FR: Le vinaigre chaud, le cumin et une pointe de sucre : les carottes deviennent un apéritif qu'on ressort toute l'année.
    description: 'Hot vinegar, cumin and a pinch of sugar: the carrots become a nibble you can bring out all year.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 kg carrots', // FR: 1 kg de carottes
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '60 g of sugar', // FR: 60 g de sucre
      '15 g of salt', // FR: 15 g de sel
      '2 tsp cumin seeds', // FR: 2 cuillères à café de graines de cumin
    ],
    steps: <String>[
      // FR: Épluche les carottes et coupe-les en bâtonnets ou en rondelles biseautées.
      'Peel the carrots and cut them into sticks or slanted rounds.',
      // FR: Blanchis-les **3 minutes** à l'eau bouillante : elles s'imprègnent mieux et restent croquantes.
      'Blanch them for **3 minutes** in boiling water: they soak up the pickle better and stay crunchy.',
      // FR: Rafraîchis-les sous l'eau froide et égoutte-les.
      'Cool them under cold water and drain them.',
      // FR: Fais griller le cumin à sec 1 minute, puis ajoute vinaigre, eau, sucre et sel, et porte à ébullition.
      'Toast the cumin in a dry pan for 1 minute, then add the vinegar, water, sugar and salt, and bring to the boil.',
      // FR: Tasse les carottes dans des bocaux propres jusqu'à 2 cm du bord.
      'Pack the carrots into clean jars up to 2 cm from the rim.',
      // FR: Verse le vinaigre bouillant pour **les couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur. Prêtes en 3 jours.
      'Pour in the boiling vinegar so that it **covers them completely**, close the jars, let them cool and put them in the fridge. Ready in 3 days.',
    ],
  ),
  'carotte/Carottes râpées au citron': RecipeText(
    // FR: Carottes râpées au citron
    name: 'Grated carrots with lemon',
    // FR: Deux minutes de râpe, un citron, et la plus franche des entrées.
    description: 'Two minutes with a grater, one lemon, and the most honest starter there is.',
    ingredients: <String>[
      '6 carrots', // FR: 6 carottes
      '1 lemon', // FR: 1 citron
      '3 tbsp oil', // FR: 3 cuillères à soupe d'huile
      '1 tsp honey', // FR: 1 cuillère à café de miel
      'salt, parsley', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Râpe les carottes gros : trop fin, elles rendent leur eau.
      'Grate the carrots coarsely: grated too fine, they release their water.',
      // FR: Presse le citron, mélange huile, miel et sel.
      'Squeeze the lemon and mix it with the oil, honey and salt.',
      // FR: Verse, mélange, laisse reposer 10 minutes.
      'Pour it over, toss, and leave to stand for 10 minutes.',
      // FR: Persil ciselé au dernier moment.
      'Chop the parsley and add it at the last moment.',
    ],
  ),
  'carotte/Carottes Vichy': RecipeText(
    // FR: Carottes Vichy
    name: 'Vichy carrots',
    // FR: Cuites dans leur eau avec beurre et sucre, elles se glacent toutes seules.
    description: 'Cooked in their own water with butter and sugar, they glaze themselves.',
    ingredients: <String>[
      '800 g carrots', // FR: 800 g de carottes
      '30 g of butter', // FR: 30 g de beurre
      '1 tsp sugar', // FR: 1 cuillère à café de sucre
      'salt, parsley', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Coupe les carottes en rondelles épaisses.
      'Cut the carrots into thick rounds.',
      // FR: Mets-les dans une casserole large avec beurre, sucre, sel, et de l'eau à mi-hauteur seulement.
      'Put them in a wide pan with the butter, sugar and salt, and water only halfway up.',
      // FR: Cuis à découvert 20 minutes : l'eau doit s'évaporer et laisser un sirop.
      'Cook uncovered for 20 minutes: the water should evaporate and leave a syrup.',
      // FR: Remue en fin de cuisson pour les enrober de ce glaçage.
      'Stir at the end of cooking to coat them in the glaze.',
      // FR: Persil, et à table.
      'Parsley, and to the table.',
    ],
  ),
  'carotte/Soupe de carottes au cumin': RecipeText(
    // FR: Soupe de carottes au cumin
    name: 'Carrot and cumin soup',
    // FR: Le cumin réveille le sucré de la carotte — une soupe qui ne lasse pas.
    description: 'Cumin wakes up the sweetness of the carrot — a soup you never tire of.',
    ingredients: <String>[
      '1 kg carrots', // FR: 1 kg de carottes
      '1 potato', // FR: 1 pomme de terre
      '1 onion', // FR: 1 oignon
      '1 tsp cumin', // FR: 1 cuillère à café de cumin
      '1 litre of stock, salt, pepper', // FR: 1 litre de bouillon, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé dans un peu d'huile.
      'Soften the sliced onion in a little oil.',
      // FR: Ajoute le cumin et laisse-le chauffer 30 secondes : il doit sentir avant de mouiller.
      'Add the cumin and let it warm for 30 seconds: you should smell it before you add liquid.',
      // FR: Ajoute carottes et pomme de terre en morceaux, puis le bouillon.
      'Add the chopped carrots and potato, then the stock.',
      // FR: Cuis 25 minutes, couvercle posé.
      'Cook for 25 minutes with the lid on.',
      // FR: Mixe. Trop épaisse ? un peu de bouillon. Trop claire ? laisse réduire.
      'Blend. Too thick? Add a little stock. Too thin? Let it reduce.',
    ],
  ),

  // ─────────── cassissier (6 recettes) ───────────
  'cassissier/Grains de cassis congelés': RecipeText(
    // FR: Grains de cassis congelés
    name: 'Frozen blackcurrants',
    // FR: Le cassis supporte le congélateur mieux que personne : il en ressort aussi parfumé qu'à la cueillette.
    description: 'Blackcurrants handle the freezer better than anything: they come out as fragrant as the day they were picked.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg blackcurrants', // FR: 1 kg de cassis
      'a fork', // FR: une fourchette
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrappe le cassis en passant les dents d'une fourchette le long des grappes.
      'Strip the blackcurrants from their stalks by running the prongs of a fork along the clusters.',
      // FR: Rince rapidement s'il le faut, puis sèche les grains sur un torchon.
      'Rinse quickly if you need to, then dry the berries on a tea towel.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Spread them on a tray so they do not touch and freeze for 2 hours.',
      // FR: Verse-les en sac une fois durs. Ils vont directement dans un gâteau, un sorbet ou une compote.
      'Tip them into a bag once they are hard. They go straight into a cake, a sorbet or a compote.',
    ],
  ),
  'cassissier/Gelée de cassis': RecipeText(
    // FR: Gelée de cassis
    name: 'Blackcurrant jelly',
    // FR: Le cassis est si riche en pectine que sa gelée prend en quelques minutes, dense et brillante.
    description: 'Blackcurrants are so rich in pectin that their jelly sets in a few minutes, dense and glossy.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1.5 kg stripped blackcurrants', // FR: 1,5 kg de cassis égrappé
      '30 cl of water', // FR: 30 cl d'eau
      '1 kg of sugar per litre of juice', // FR: 1 kg de sucre par litre de jus
      '6 jam jars', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Cuis le cassis avec l'eau à couvert, en écrasant, jusqu'à ce que tous les grains éclatent.
      'Cook the blackcurrants with the water, covered, crushing them, until every berry has burst.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse doucement.
      'Pour into a clean tea towel set over a sieve and let it drip, then press gently.',
      // FR: Mesure le jus, ajoute **1 kg de sucre par litre** et porte à ébullition en remuant.
      'Measure the juice, add **1 kg of sugar per litre** and bring to the boil, stirring.',
      // FR: Cuis à gros bouillons en écumant : pas plus, sinon la gelée devient caoutchouteuse.
      'Boil hard, skimming: no longer, or the jelly turns rubbery.',
      // FR: Teste sur une assiette froide : une goutte qui se fige et se ride au doigt est prête.
      'Test on a cold plate: a drop that sets and wrinkles when you push it with a finger is ready.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars, close them and turn them upside down until cool.',
    ],
  ),
  'cassissier/Feuilles de cassis séchées pour infusion': RecipeText(
    // FR: Feuilles de cassis séchées pour infusion
    name: 'Dried blackcurrant leaves for infusion',
    // FR: On oublie souvent les feuilles : séchées, elles donnent une infusion au parfum de cassis tout l'hiver.
    description: 'The leaves are often forgotten: dried, they make an infusion that tastes of blackcurrant all winter.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 year in a jar, away from the light',
    ingredients: <String>[
      '2 big handfuls of young blackcurrant leaves', // FR: 2 grosses poignées de jeunes feuilles de cassis
      'a tea towel or a drying rack', // FR: un torchon ou une claie
      'an opaque jar', // FR: un bocal opaque
    ],
    steps: <String>[
      // FR: Cueille de jeunes feuilles saines en fin de matinée, quand la rosée est partie. Prends-en un peu sur chaque branche.
      'Pick young, healthy leaves late in the morning, once the dew has gone. Take a few from each branch.',
      // FR: Ne les lave que si elles sont sales, et sèche-les bien sur un torchon.
      'Wash them only if they are dirty, and dry them well on a tea towel.',
      // FR: Étale-les en une couche sur une claie, **à l'ombre**, dans une pièce sèche et aérée, pendant une semaine.
      'Spread them in a single layer on a rack, **in the shade**, in a dry, airy room, for a week.',
      // FR: Teste : une feuille sèche craque entre tes doigts. Si elle plie encore, attends deux jours de plus.
      'Test: a dry leaf snaps between your fingers. If it still bends, wait two more days.',
      // FR: Émiette-les grossièrement et range-les en bocal opaque. Une cuillère à soupe pour une tasse d'eau frémissante.
      'Crumble them roughly and store them in an opaque jar. One tablespoon for a cup of simmering water.',
    ],
  ),
  'cassissier/Crème de cassis': RecipeText(
    // FR: Crème de cassis
    name: 'Blackcurrant liqueur',
    // FR: Baies macérées dans l'alcool, puis sucrées. Patience de deux mois.
    description: 'Berries steeped in alcohol, then sweetened. Two months of patience.',
  ),
  'cassissier/Confiture de cassis': RecipeText(
    // FR: Confiture de cassis
    name: 'Blackcurrant jam',
    // FR: Intense, presque amère, parfaite sur du pain grillé.
    description: 'Intense, almost bitter, perfect on toast.',
  ),
  'cassissier/Sorbet au cassis': RecipeText(
    // FR: Sorbet au cassis
    name: 'Blackcurrant sorbet',
    // FR: Mixé cru, passé au tamis, sucré au sirop.
    description: 'Blended raw, pushed through a sieve, sweetened with syrup.',
  ),

  // ─────────── celeri (6 recettes) ───────────
  'celeri/Mirepoix céleri-carotte-oignon': RecipeText(
    // FR: Mirepoix céleri-carotte-oignon
    name: 'Celery, carrot and onion mirepoix',
    // FR: Le trio de base de toutes les sauces, coupé une fois pour toutes et prêt à jeter dans la cocotte.
    description: 'The base trio of every sauce, chopped once and ready to drop into the pot.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 head of celery', // FR: 1 pied de céleri-branche
      '4 carrots', // FR: 4 carottes
      '3 onions', // FR: 3 oignons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les branches de céleri à fond, la terre se loge dans le creux du bas. Garde les feuilles pour le sel de céleri.
      'Wash the celery stalks thoroughly: the soil hides in the hollow at the bottom. Keep the leaves for the celery salt.',
      // FR: Retire les fils des grosses branches avec un économe, puis coupe en petits dés de 5 mm.
      'Pull the strings off the big stalks with a peeler, then cut into small 5 mm dice.',
      // FR: Épluche carottes et oignons et taille-les à la même taille, pour qu'ils cuisent ensemble.
      'Peel the carrots and onions and cut them to the same size, so they cook together.',
      // FR: Mélange les trois légumes dans un saladier.
      'Mix the three vegetables in a bowl.',
      // FR: Répartis en sachets d'une portion, à plat, et congèle. Ils vont **gelés** dans la cocotte, sans décongeler.
      'Divide into single-portion bags, laid flat, and freeze. They go into the pot **frozen**, without thawing.',
    ],
  ),
  'celeri/Sel de céleri maison': RecipeText(
    // FR: Sel de céleri maison
    name: 'Homemade celery salt',
    // FR: Les feuilles qu'on jette, séchées et mixées au sel : un assaisonnement pour les tomates, les œufs et les soupes.
    description: 'The leaves you would throw away, dried and blended with salt: a seasoning for tomatoes, eggs and soups.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in the dry, away from the light',
    ingredients: <String>[
      'the leaves of 2 heads of celery', // FR: les feuilles de 2 pieds de céleri
      '150 g of coarse salt or fleur de sel', // FR: 150 g de gros sel ou de fleur de sel
      'a small, very dry glass jar', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les bien en les roulant dans un torchon.
      'Rinse the leaves and dry them well by rolling them in a tea towel.',
      // FR: Étale-les sur une plaque et fais-les sécher au four à **60 °C**, porte entrouverte.
      'Spread them on a tray and dry them in the oven at **60 °C**, with the door ajar.',
      // FR: Elles sont prêtes quand elles s'émiettent sous les doigts. Encore souples, laisse-les un peu plus.
      'They are ready when they crumble under your fingers. If they are still soft, leave them a little longer.',
      // FR: Mixe les feuilles refroidies avec le sel, par à-coups, jusqu'à une poudre verte.
      'Blend the cooled leaves with the salt, in pulses, until you have a green powder.',
      // FR: Mets en pot bien fermé. Le sel garde le vert et le parfum : pas besoin d'autre chose.
      'Put it in a tightly closed jar. The salt keeps the colour and the aroma: nothing else is needed.',
    ],
  ),
  'celeri/Céleri-rave râpé fermenté': RecipeText(
    // FR: Céleri-rave râpé fermenté
    name: 'Fermented grated celeriac',
    // FR: Râpé et salé comme une choucroute, il devient acidulé et croquant, parfait en crudité d'hiver.
    description: 'Grated and salted like sauerkraut, it turns tangy and crunchy, perfect as a winter raw vegetable.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1.5 kg celeriac', // FR: 1,5 kg de céleri-rave
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '1 tart apple', // FR: 1 pomme acide
      '1 tsp mustard seeds', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Épluche le céleri au couteau, assez épais pour enlever toute la peau terreuse, et râpe-le avec la pomme.
      'Peel the celeriac with a knife, thickly enough to remove all the earthy skin, and grate it with the apple.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**, avec la moutarde. Malaxe 5 minutes avec les mains.
      'Weigh the grated mixture and add **20 g of salt per kilo**, with the mustard. Knead with your hands for 5 minutes.',
      // FR: Laisse reposer, le temps que le sel fasse sortir le jus.
      'Leave to stand while the salt draws out the juice.',
      // FR: Tasse fort dans un bocal, jusqu'à ce que le jus remonte et couvre tout, en laissant 3 cm sous le bord.
      'Pack it down hard in a jar until the juice rises and covers everything, leaving 3 cm below the rim.',
      // FR: Pose un poids pour garder tout **sous le jus**. S'il en manque, complète avec une saumure à 30 g de sel par litre.
      'Put a weight on top to keep everything **under the juice**. If there is not enough, top up with a brine of 30 g of salt per litre.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer, puis range au réfrigérateur.
      'Leave to ferment for 2 weeks at 18–22 °C, with the lid resting on top without tightening, then put it in the fridge.',
    ],
  ),
  'celeri/Céleri rémoulade': RecipeText(
    // FR: Céleri rémoulade
    name: 'Celeriac rémoulade',
    // FR: Râpé cru dans une mayonnaise moutardée — le classique des charcutiers.
    description: 'Grated raw into a mustardy mayonnaise — the deli classic.',
    ingredients: <String>[
      '1 celeriac', // FR: 1 céleri-rave
      '1 egg yolk', // FR: 1 jaune d'oeuf
      '1 tbsp mustard', // FR: 1 cuillère à soupe de moutarde
      '15 cl of oil', // FR: 15 cl d'huile
      '1 lemon, salt, pepper, parsley', // FR: 1 citron, sel, poivre, persil
    ],
    steps: <String>[
      // FR: Pèle le céleri et râpe-le en julienne, pas trop fin.
      'Peel the celeriac and cut it into julienne, not too fine.',
      // FR: Citronne-le aussitôt : il noircit en quelques minutes à l'air.
      'Squeeze lemon over it straight away: it turns black within minutes in the air.',
      // FR: Monte une mayonnaise moutardée : jaune, moutarde, sel, puis l'huile en filet.
      'Make a mustardy mayonnaise: yolk, mustard, salt, then the oil in a thin stream.',
      // FR: Mélange, poivre, persil.
      'Mix, add pepper and parsley.',
      // FR: Une heure au frais : le céleri s'attendrit un peu.
      'An hour in the fridge: the celeriac softens a little.',
    ],
  ),
  'celeri/Purée de céleri-rave': RecipeText(
    // FR: Purée de céleri-rave
    name: 'Celeriac mash',
    // FR: Plus fine qu'une purée de pommes de terre, et moins lourde.
    description: 'Finer than potato mash, and lighter.',
    ingredients: <String>[
      '1 celeriac (800 g)', // FR: 1 céleri-rave (800 g)
      '2 potatoes', // FR: 2 pommes de terre
      '20 cl of milk', // FR: 20 cl de lait
      '40 g of butter', // FR: 40 g de beurre
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Coupe céleri et pommes de terre en cubes égaux.
      'Cut the celeriac and potatoes into equal cubes.',
      // FR: Cuis-les dans du lait coupé d'eau, 25 minutes : le céleri y perd son amertume.
      'Cook them in milk cut with water for 25 minutes: the celeriac loses its bitterness in it.',
      // FR: Égoutte en gardant un peu du liquide.
      'Drain, keeping a little of the liquid.',
      // FR: Écrase avec le beurre, détends au liquide réservé.
      'Mash with the butter and loosen with the reserved liquid.',
      // FR: Sel, poivre. Très bon avec du gibier.
      'Salt and pepper. Very good with game.',
    ],
  ),
  'celeri/Velouté de céleri aux noisettes': RecipeText(
    // FR: Velouté de céleri aux noisettes
    name: 'Celeriac and hazelnut soup',
    // FR: La noisette torréfiée épouse le céleri comme personne.
    description: 'Toasted hazelnuts and celeriac are made for each other.',
    ingredients: <String>[
      '1 celeriac', // FR: 1 céleri-rave
      '1 potato, 1 onion', // FR: 1 pomme de terre, 1 oignon
      '80 cl of stock', // FR: 80 cl de bouillon
      '60 g of hazelnuts', // FR: 60 g de noisettes
      '10 cl of cream, salt, pepper', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Torréfie les noisettes 8 minutes au four à 170 °C, puis frotte-les pour ôter la peau.
      'Toast the hazelnuts for 8 minutes in the oven at 170 °C, then rub them to remove the skins.',
      // FR: Fais fondre l'oignon, ajoute céleri et pomme de terre.
      'Soften the onion, then add the celeriac and potato.',
      // FR: Bouillon à hauteur, cuis 25 minutes.
      'Add stock to cover and cook for 25 minutes.',
      // FR: Mixe avec la moitié des noisettes et la crème.
      'Blend with half the hazelnuts and the cream.',
      // FR: Reste de noisettes concassées sur le velouté, pour le croquant.
      'Scatter the remaining hazelnuts, roughly crushed, over the soup for crunch.',
    ],
  ),

  // ─────────── celosie (6 recettes) ───────────
  'celosie/Célosie blanchie en boulettes': RecipeText(
    // FR: Célosie blanchie en boulettes
    name: 'Blanched celosia balls',
    // FR: Blanchie une minute et pressée en boulettes : une portion de feuilles prête pour chaque sauce.
    description: 'Blanched for one minute and pressed into balls: a portion of leaves ready for every sauce.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg celosia leaves', // FR: 1 kg de feuilles de célosie
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et coupe les grosses feuilles en lanières.
      'Strip the leaves from the stems and cut the big leaves into strips.',
      // FR: Lave dans plusieurs eaux : la terre se cache à la base des feuilles.
      'Wash in several changes of water: the soil hides at the base of the leaves.',
      // FR: Plonge dans une grande eau bouillante salée, à gros bouillons.
      'Drop into a large pan of salted water at a rolling boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer le vert.
      'Drain and plunge straight into the iced water to set the green.',
      // FR: Presse fort entre tes mains pour chasser l'eau.
      'Squeeze hard between your hands to drive out the water.',
      // FR: Forme des boulettes, congèle 2 heures sur une plaque, puis mets en sac.
      'Shape into balls, freeze for 2 hours on a tray, then put into bags.',
    ],
  ),
  'celosie/Célosie fondue à l\'oignon': RecipeText(
    // FR: Célosie fondue à l'oignon
    name: 'Celosia wilted with onion',
    // FR: Déjà fondue avec l'oignon, elle n'attend plus que la tomate ou le poisson : une base de sauce toute prête.
    description: 'Already wilted with the onion, it only needs tomato or fish: a ready-made sauce base.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg celosia leaves', // FR: 1 kg de feuilles de célosie
      '2 onions', // FR: 2 oignons
      '3 tbsp oil', // FR: 3 cuillères à soupe d'huile
      'salt', // FR: sel
      'freezer boxes', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Effeuille et lave la célosie, puis hache-la grossièrement.
      'Strip and wash the celosia, then chop it roughly.',
      // FR: Émince les oignons finement.
      'Slice the onions finely.',
      // FR: Fais revenir les oignons dans l'huile jusqu'à ce qu'ils soient tendres et dorés.
      'Fry the onions in the oil until soft and golden.',
      // FR: Ajoute la célosie par poignées et remue jusqu'à ce qu'elle ait fondu et rendu son eau.
      'Add the celosia by the handful and stir until it has wilted and released its water.',
      // FR: Sale légèrement : tu ajusteras dans la sauce finale.
      'Salt lightly: you will adjust in the final sauce.',
      // FR: Refroidis vite, casserole dans l'eau froide, puis répartis en boîtes en laissant 2 cm de vide et congèle.
      'Cool quickly, with the pan standing in cold water, then divide into boxes, leaving 2 cm of space, and freeze.',
    ],
  ),
  'celosie/Feuilles de célosie séchées': RecipeText(
    // FR: Feuilles de célosie séchées
    name: 'Dried celosia leaves',
    // FR: Séchées à l'ombre, les feuilles s'émiettent dans les soupes et les sauces quand le jardin est vide.
    description: 'Dried in the shade, the leaves crumble into soups and sauces when the garden is empty.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in the dry, away from the light',
    ingredients: <String>[
      'healthy celosia leaves', // FR: des feuilles de célosie bien saines
      'drying racks or a clean sheet', // FR: des claies ou un drap propre
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les tiges et écarte les feuilles abîmées ou piquées.
      'Strip the leaves from the stems and discard any that are damaged or pecked by insects.',
      // FR: Rince et égoutte bien sur un torchon.
      'Rinse and drain well on a tea towel.',
      // FR: Étale en une couche à l'ombre, dans un endroit aéré, 2 à 3 jours en retournant chaque jour.
      'Spread in a single layer in the shade, somewhere airy, for 2 to 3 days, turning them every day.',
      // FR: Elles sont prêtes quand elles craquent sous les doigts.
      'They are ready when they snap between your fingers.',
      // FR: Mets-les en bocaux hermétiques. Émiette-les dans la sauce 10 minutes avant la fin de la cuisson.
      'Put them in airtight jars. Crumble them into the sauce 10 minutes before the end of cooking.',
    ],
  ),
  'celosie/Célosie sautée à la tomate': RecipeText(
    // FR: Célosie sautée à la tomate
    name: 'Celosia sautéed with tomato',
    // FR: Les jeunes feuilles tombent en quelques minutes.
    description: 'Young leaves wilt in a few minutes.',
  ),
  'celosie/Soupe de célosie': RecipeText(
    // FR: Soupe de célosie
    name: 'Celosia soup',
    // FR: Avec de l'oignon et du piment, nourrissante et verte.
    description: 'With onion and chilli, nourishing and green.',
  ),
  'celosie/Sauce feuilles de célosie': RecipeText(
    // FR: Sauce feuilles de célosie
    name: 'Celosia leaf sauce',
    // FR: Les feuilles tendres de célosie mijotées avec tomate et poisson fumé.
    description: 'Tender celosia leaves simmered with tomato and smoked fish.',
  ),

  // ─────────── cerfeuil (6 recettes) ───────────
  'cerfeuil/Cerfeuil ciselé congelé': RecipeText(
    // FR: Cerfeuil ciselé congelé
    name: 'Frozen chopped chervil',
    // FR: Le cerfeuil fane en un jour et ne supporte pas le séchage : le congélateur est son seul refuge.
    description: 'Chervil wilts within a day and cannot be dried: the freezer is its only refuge.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '3 bunches of chervil', // FR: 3 bouquets de cerfeuil
      'a small rigid freezer box', // FR: une petite boîte rigide de congélation
    ],
    steps: <String>[
      // FR: Rince le cerfeuil délicatement, ses feuilles se froissent vite.
      'Rinse the chervil gently: its leaves bruise easily.',
      // FR: Étale-le sur un torchon et tamponne jusqu'à ce qu'il soit **bien sec**.
      'Spread it on a tea towel and pat until it is **completely dry**.',
      // FR: Ôte les grosses tiges et cisèle les feuilles aux ciseaux, sans les écraser au couteau.
      'Remove the thick stems and snip the leaves with scissors, without crushing them with a knife.',
      // FR: Mets-les en vrac dans la boîte, sans tasser, ferme et congèle.
      'Put them loose in the box, without packing them down, close it and freeze.',
      // FR: Ajoute-le gelé **hors du feu** dans le potage ou la sauce : la chaleur tue son parfum anisé.
      'Add it frozen **off the heat** to the soup or sauce: heat kills its aniseed flavour.',
    ],
  ),
  'cerfeuil/Beurre de cerfeuil en rouleau': RecipeText(
    // FR: Beurre de cerfeuil en rouleau
    name: 'Chervil butter roll',
    // FR: Enfermé dans le beurre, le cerfeuil garde son goût délicat jusqu'à l'hiver.
    description: 'Locked in butter, chervil keeps its delicate flavour until winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '250 g of soft butter', // FR: 250 g de beurre mou
      '2 bunches of chervil', // FR: 2 bouquets de cerfeuil
      '1 small shallot', // FR: 1 petite échalote
      '1 pinch of fleur de sel', // FR: 1 pincée de fleur de sel
      'cling film', // FR: du film alimentaire
    ],
    steps: <String>[
      // FR: Lave et sèche le cerfeuil, puis garde seulement les feuilles.
      'Wash and dry the chervil, then keep only the leaves.',
      // FR: Hache-les finement avec l'échalote.
      'Chop them finely with the shallot.',
      // FR: Écrase le beurre mou à la fourchette avec le cerfeuil, l'échalote et le sel.
      'Mash the soft butter with a fork together with the chervil, shallot and salt.',
      // FR: Roule-le dans le film en boudin bien serré et noue les deux bouts.
      'Roll it in cling film into a tight sausage and tie both ends.',
      // FR: Congèle. Coupe une rondelle encore gelée sur un poisson poché, des carottes ou une pomme de terre chaude.
      'Freeze. Cut a slice while still frozen and put it on poached fish, carrots or a hot potato.',
    ],
  ),
  'cerfeuil/Vinaigre blanc au cerfeuil': RecipeText(
    // FR: Vinaigre blanc au cerfeuil
    name: 'Chervil white vinegar',
    // FR: Une façon de garder sa note d'anis douce pour les vinaigrettes d'hiver.
    description: 'A way to keep its gentle aniseed note for winter vinaigrettes.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, away from the light',
    ingredients: <String>[
      '2 bunches of chervil', // FR: 2 bouquets de cerfeuil
      '50 cl of white wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'a clean jar', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Rince le cerfeuil et sèche-le parfaitement sur un torchon.
      'Rinse the chervil and dry it perfectly on a tea towel.',
      // FR: Tasse-le légèrement dans le bocal, tiges comprises.
      'Pack it lightly into the jar, stalks included.',
      // FR: Verse le vinaigre pur à froid pour le couvrir **entièrement** : chaud, il cuirait ce cerfeuil fragile.
      'Pour in the vinegar cold and undiluted to cover it **completely**: hot, it would cook this delicate chervil.',
      // FR: Laisse infuser deux semaines à l'ombre, en secouant tous les deux jours.
      'Leave to infuse for two weeks in the shade, shaking every two days.',
      // FR: Filtre dans une bouteille propre et jette le cerfeuil, qui a tout donné.
      'Strain into a clean bottle and throw away the chervil, which has given everything.',
    ],
  ),
  'cerfeuil/Potage au cerfeuil': RecipeText(
    // FR: Potage au cerfeuil
    name: 'Chervil soup',
    // FR: Ajouté à la fin seulement : la cuisson tue son parfum.
    description: 'Added only at the end: cooking kills its aroma.',
  ),
  'cerfeuil/Sauce aux fines herbes': RecipeText(
    // FR: Sauce aux fines herbes
    name: 'Fines herbes sauce',
    // FR: Cerfeuil, ciboulette, persil, estragon — les quatre canoniques.
    description: 'Chervil, chives, parsley, tarragon — the four classics.',
  ),
  'cerfeuil/Œufs brouillés au cerfeuil': RecipeText(
    // FR: Œufs brouillés au cerfeuil
    name: 'Scrambled eggs with chervil',
    // FR: Cuisson très douce, cerfeuil hors du feu.
    description: 'Very gentle cooking, chervil off the heat.',
  ),

  // ─────────── cerisier (6 recettes) ───────────
  'cerisier/Cerises au sirop en bocaux': RecipeText(
    // FR: Cerises au sirop en bocaux
    name: 'Cherries in syrup in jars',
    // FR: Un bocal de cerises en plein hiver, et le clafoutis de janvier a le goût de juin.
    description: 'A jar of cherries in the depths of winter, and January\'s clafoutis tastes of June.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '2 kg cherries', // FR: 2 kg de cerises
      '1 litre of water', // FR: 1 litre d'eau
      '300 g of sugar', // FR: 300 g de sucre
      'the juice of one lemon', // FR: le jus d'un citron
      '5 jars of 50 cl with new seals', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les cerises, équeute-les et écarte celles qui sont fendues ou piquées.
      'Wash the cherries, remove the stalks and set aside any that are split or pecked.',
      // FR: Dénoyaute-les ou garde-les entières : **avec le noyau**, elles se tiennent mieux et gardent plus de goût.
      'Stone them or keep them whole: **with the stone**, they hold their shape better and have more flavour.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes, puis ajoute le jus de citron.
      'Bring the water and sugar to the boil for 2 minutes, then add the lemon juice.',
      // FR: Tasse les cerises dans les bocaux et couvre de sirop chaud **jusqu'à 2 cm du bord**. Ferme avec des joints neufs.
      'Pack the cherries into the jars and cover with hot syrup **to 2 cm from the rim**. Close with new seals.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Sterilise the jars completely covered in water, for 25 minutes from the moment it boils.',
      // FR: Laisse refroidir dans l'eau et vérifie le vide : couvercle creux, joint qui tient. Sinon, au frais et à manger vite.
      'Let them cool in the water and check the vacuum: lid dipped inwards, seal holding. If not, into the fridge and eat soon.',
    ],
  ),
  'cerisier/Cerises dénoyautées congelées': RecipeText(
    // FR: Cerises dénoyautées congelées
    name: 'Frozen stoned cherries',
    // FR: Dénoyautées une fois pour toutes, elles tombent directement dans un gâteau ou une compote.
    description: 'Stoned once and for all, they drop straight into a cake or a compote.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 kg very ripe cherries', // FR: 1 kg de cerises bien mûres
      'a cherry stoner', // FR: un dénoyauteur
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les cerises **avec leur queue**, pour que l'eau n'entre pas dans le fruit.
      'Wash the cherries **with their stalks on**, so the water does not get into the fruit.',
      // FR: Sèche-les bien sur un torchon : toute goutte restée devient du givre.
      'Dry them well on a tea towel: every drop left behind turns into frost.',
      // FR: Équeute et dénoyaute-les au-dessus d'un saladier pour garder le jus.
      'Remove the stalks and stone them over a bowl to catch the juice.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent** et congèle 3 heures.
      'Spread them on a tray **so they do not touch** and freeze for 3 hours.',
      // FR: Verse-les en sac une fois dures : elles ne forment pas de bloc et se prennent à la poignée.
      'Tip them into a bag once hard: they do not form a block and you can take them by the handful.',
    ],
  ),
  'cerisier/Cerises séchées maison': RecipeText(
    // FR: Cerises séchées maison
    name: 'Homemade dried cherries',
    // FR: Plus acidulées qu'un raisin sec, elles réveillent un muesli, un cake ou une farce de volaille.
    description: 'Tangier than a raisin, they liven up a muesli, a cake or a poultry stuffing.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '1.5 kg very ripe cherries', // FR: 1,5 kg de cerises bien mûres
      'a cherry stoner', // FR: un dénoyauteur
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Lave les cerises avec leur queue, puis sèche-les.
      'Wash the cherries with their stalks on, then dry them.',
      // FR: Équeute et dénoyaute-les, ou coupe-les en deux pour qu'elles sèchent plus vite.
      'Remove the stalks and stone them, or halve them so they dry faster.',
      // FR: Pose-les côté coupé vers le haut sur des grilles et sèche au four à **65 °C**, porte entrouverte.
      'Place them cut side up on racks and dry in the oven at **65 °C**, with the door ajar.',
      // FR: Teste : elles doivent être fripées et souples comme des raisins secs, sans jus quand tu les presses.
      'Test: they should be wrinkled and soft like raisins, with no juice when you press them.',
      // FR: Laisse-les refroidir, mets-les en bocal et secoue chaque jour une semaine. De la buée, et c'est retour au four.
      'Let them cool, put them in a jar and shake it every day for a week. If you see condensation, back into the oven they go.',
    ],
  ),
  'cerisier/Clafoutis aux cerises': RecipeText(
    // FR: Clafoutis aux cerises
    name: 'Cherry clafoutis',
    // FR: Avec les noyaux, comme en Limousin : ils parfument la pâte.
    description: 'With the stones in, as in the Limousin: they flavour the batter.',
  ),
  'cerisier/Confiture de cerises': RecipeText(
    // FR: Confiture de cerises
    name: 'Cherry jam',
    // FR: Dénoyautées à la main, un peu de citron pour la prise.
    description: 'Stoned by hand, with a little lemon to help it set.',
  ),
  'cerisier/Cerises au vinaigre': RecipeText(
    // FR: Cerises au vinaigre
    name: 'Cherries in vinegar',
    // FR: En aigre-doux, pour accompagner une viande froide.
    description: 'Sweet and sour, to go with cold meat.',
  ),

  // ─────────── champignon_paris (6 recettes) ───────────
  'champignon_paris/Champignons poêlés pour le congélateur': RecipeText(
    // FR: Champignons poêlés pour le congélateur
    name: 'Mushrooms pan-fried for the freezer',
    // FR: Crus, ils rendent de l'eau et deviennent spongieux ; poêlés d'abord, ils se congèlent parfaitement.
    description: 'Raw, they release water and turn spongy; pan-fried first, they freeze perfectly.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg button mushrooms', // FR: 1,5 kg de champignons de Paris
      '30 g of butter', // FR: 30 g de beurre
      '1 tbsp oil', // FR: 1 cuillère à soupe d'huile
      'salt', // FR: sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le bout terreux des pieds et essuie les champignons avec un linge humide. **Ne les fais pas tremper** : ils boivent l'eau comme une éponge.
      'Trim the earthy end of the stalks and wipe the mushrooms with a damp cloth. **Do not soak them**: they drink up water like a sponge.',
      // FR: Émince-les en lamelles de 5 mm.
      'Slice them into 5 mm slices.',
      // FR: Fais-les sauter à feu vif dans le beurre et l'huile, en plusieurs fois, jusqu'à ce que leur eau soit **complètement évaporée** et qu'ils dorent.
      'Fry them over high heat in the butter and oil, in several batches, until their water has **completely evaporated** and they turn golden.',
      // FR: Sale en fin de cuisson seulement : salés trop tôt, ils rendent leur eau et bouillent au lieu de dorer.
      'Salt only at the end of cooking: salted too early, they release their water and boil instead of browning.',
      // FR: Étale-les sur une assiette et laisse refroidir.
      'Spread them on a plate and leave to cool.',
      // FR: Mets en sacs d'une portion, à plat, et date. Réchauffe-les directement à la poêle.
      'Put into single-portion bags, laid flat, and date them. Reheat them straight in the pan.',
    ],
  ),
  'champignon_paris/Lamelles de champignons séchées': RecipeText(
    // FR: Lamelles de champignons séchées
    name: 'Dried mushroom slices',
    // FR: Séchés, ils concentrent leur goût et se gardent un an : une poignée réhydratée suffit pour une sauce.
    description: 'Dried, they concentrate their flavour and keep for a year: a rehydrated handful is enough for a sauce.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 year in the dry, in an airtight jar',
    ingredients: <String>[
      '1 kg very firm button mushrooms', // FR: 1 kg de champignons de Paris bien fermes
      'racks or trays', // FR: des grilles ou plaques
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Essuie les champignons sans les mouiller et coupe le bout des pieds.
      'Wipe the mushrooms without wetting them and trim the ends of the stalks.',
      // FR: Tranche-les en lamelles régulières de 5 mm.
      'Cut them into even 5 mm slices.',
      // FR: Étale-les sur des grilles sans qu'elles se touchent et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Spread them on racks so they do not touch and dry at 50 °C, with the door ajar, or in a dehydrator.',
      // FR: Retourne-les à mi-temps. Elles sont prêtes quand elles sont **cassantes**, plus du tout souples.
      'Turn them halfway through. They are ready when they are **brittle**, not at all bendy.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Pour cuisiner, trempe-les 20 minutes dans l'eau tiède, et garde l'eau pour la sauce.
      'Let them cool and put them in airtight jars. To cook, soak them for 20 minutes in lukewarm water, and keep the water for the sauce.',
    ],
  ),
  'champignon_paris/Champignons marinés au vinaigre': RecipeText(
    // FR: Champignons marinés au vinaigre
    name: 'Mushrooms marinated in vinegar',
    // FR: Petits champignons entiers, cuits dans un bouillon vinaigré aux aromates : l'antipasto de ton potager.
    description: 'Small whole mushrooms, cooked in a spiced vinegar stock: the antipasto from your own garden.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '800 g small button mushrooms', // FR: 800 g de petits champignons de Paris
      '40 cl of white vinegar at 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl of water', // FR: 40 cl d'eau
      '15 g of salt', // FR: 15 g de sel
      '2 bay leaves, 3 sprigs of thyme, 1 tsp peppercorns', // FR: 2 feuilles de laurier, 3 brins de thym, 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Essuie les champignons, coupe le bout des pieds et laisse-les entiers. Coupe en deux les plus gros.
      'Wipe the mushrooms, trim the ends of the stalks and leave them whole. Halve the biggest ones.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sel avec le laurier, le thym et le poivre.
      'Bring the vinegar, water and salt to the boil with the bay, thyme and pepper.',
      // FR: Ajoute les champignons et laisse frémir **5 minutes** : ils cuisent dans le vinaigre, c'est ce qui les conserve.
      'Add the mushrooms and simmer for **5 minutes**: they cook in the vinegar, and that is what preserves them.',
      // FR: Répartis-les avec les aromates dans deux bocaux ébouillantés.
      'Divide them with the herbs between two scalded jars.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Pour in the boiling liquid to **cover them completely**, close the jars and leave to cool.',
      // FR: Range au réfrigérateur et attends 2 jours. Pour servir, égoutte-les et arrose d'un filet d'huile dans l'assiette.
      'Put in the fridge and wait 2 days. To serve, drain them and drizzle with a little oil on the plate.',
    ],
  ),
  'champignon_paris/Champignons à la persillade': RecipeText(
    // FR: Champignons à la persillade
    name: 'Mushrooms with persillade',
    // FR: À feu vif pour qu'ils dorent au lieu de rendre leur eau.
    description: 'Over high heat, so they brown instead of releasing their water.',
  ),
  'champignon_paris/Duxelles': RecipeText(
    // FR: Duxelles
    name: 'Duxelles',
    // FR: Hachés fin et desséchés au beurre — la base de mille plats.
    description: 'Finely chopped and dried out in butter — the base of a thousand dishes.',
  ),
  'champignon_paris/Champignons farcis au four': RecipeText(
    // FR: Champignons farcis au four
    name: 'Oven-baked stuffed mushrooms',
    // FR: Têtes garnies de duxelles et de chapelure.
    description: 'Caps filled with duxelles and breadcrumbs.',
  ),

  // ─────────── chou_bruxelles (6 recettes) ───────────
  'chou_bruxelles/Choux de Bruxelles blanchis congelés': RecipeText(
    // FR: Choux de Bruxelles blanchis congelés
    name: 'Frozen blanched Brussels sprouts',
    // FR: Blanchis entiers puis congelés sur plaque, ils passent directement du sac à la poêle.
    description: 'Blanched whole then frozen on a tray, they go straight from the bag to the pan.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg Brussels sprouts', // FR: 2 kg de choux de Bruxelles
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles extérieures abîmées et recoupe la base. Trie-les par taille.
      'Remove the damaged outer leaves and trim the base. Sort them by size.',
      // FR: Rince-les à l'eau froide et fais une petite croix au pied des plus gros.
      'Rinse them in cold water and cut a small cross in the base of the biggest ones.',
      // FR: Blanchis dans une grande eau bouillante salée : **3 minutes** pour les petits, **4 minutes** pour les gros.
      'Blanch in a large pan of salted boiling water: **3 minutes** for the small ones, **4 minutes** for the big ones.',
      // FR: Plonge-les aussitôt dans l'eau glacée, le temps qu'ils soient froids à cœur.
      'Plunge them straight into the iced water until they are cold right through.',
      // FR: Égoutte et sèche-les bien en les roulant dans un torchon.
      'Drain and dry them well by rolling them in a tea towel.',
      // FR: Congèle-les 2 heures sur une plaque sans qu'ils se touchent, puis mets-les en sac daté.
      'Freeze them for 2 hours on a tray, not touching, then put them in a dated bag.',
    ],
  ),
  'chou_bruxelles/Choux de Bruxelles lacto-fermentés': RecipeText(
    // FR: Choux de Bruxelles lacto-fermentés
    name: 'Lacto-fermented Brussels sprouts',
    // FR: Coupés en deux et noyés de saumure, ils deviennent acidulés et croquants, parfaits en apéritif.
    description: 'Halved and drowned in brine, they turn tangy and crunchy, perfect as a nibble with drinks.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 kg Brussels sprouts', // FR: 1 kg de choux de Bruxelles
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '2 garlic cloves, 1 bay leaf', // FR: 2 gousses d'ail, 1 feuille de laurier
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : c'est ta saumure à 3 %. L'eau du robinet chlorée freine la fermentation, laisse-la reposer une nuit ou prends de l'eau de source.
      'Dissolve **30 g of salt in 1 litre of water**: that is your 3 % brine. Chlorinated tap water slows fermentation, so let it stand overnight or use spring water.',
      // FR: Nettoie les choux et coupe-les en deux pour que la saumure pénètre.
      'Clean the sprouts and cut them in half so the brine gets in.',
      // FR: Tasse-les dans deux bocaux avec l'ail écrasé et le laurier, en laissant 3 cm de vide en haut.
      'Pack them into two jars with the crushed garlic and the bay leaf, leaving 3 cm of space at the top.',
      // FR: Verse la saumure pour les couvrir, puis pose un poids : **rien ne doit dépasser**.
      'Pour in the brine to cover them, then add a weight: **nothing should stick out**.',
      // FR: Ferme sans serrer et laisse fermenter 2 semaines à 18–22 °C, sur une assiette. Des bulles et une saumure trouble, c'est bon signe.
      'Close without tightening and leave to ferment for 2 weeks at 18–22 °C, standing on a plate. Bubbles and a cloudy brine are a good sign.',
      // FR: Goûte : quand c'est acidulé, serre les couvercles et passe au réfrigérateur.
      'Taste: when it is tangy, tighten the lids and move to the fridge.',
    ],
  ),
  'chou_bruxelles/Pickles de choux de Bruxelles': RecipeText(
    // FR: Pickles de choux de Bruxelles
    name: 'Brussels sprout pickles',
    // FR: Blanchis deux minutes puis mis au vinaigre épicé : une façon inattendue de finir une grosse récolte.
    description: 'Blanched for two minutes then put in spiced vinegar: an unexpected way to finish off a big harvest.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '800 g small Brussels sprouts', // FR: 800 g de petits choux de Bruxelles
      '30 cl of white vinegar at 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl of water', // FR: 30 cl d'eau
      '12 g of salt, 30 g of sugar', // FR: 12 g de sel, 30 g de sucre
      '1 tsp mustard seeds, 1 small chilli', // FR: 1 cuillère à café de graines de moutarde, 1 petit piment
    ],
    steps: <String>[
      // FR: Nettoie les choux et coupe les plus gros en deux.
      'Clean the sprouts and halve the biggest ones.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante salée : crus, le vinaigre ne les pénètre pas.
      'Blanch them for **2 minutes** in salted boiling water: raw, the vinegar does not get into them.',
      // FR: Refroidis-les dans l'eau glacée et égoutte.
      'Cool them in iced water and drain.',
      // FR: Remplis deux bocaux ébouillantés avec les choux, la moutarde et le piment.
      'Fill two scalded jars with the sprouts, the mustard and the chilli.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel et le sucre.
      'Boil the vinegar, water, salt and sugar.',
      // FR: Verse bouillant pour **couvrir entièrement** les choux, ferme, laisse refroidir et range au frais. Attends une semaine avant d'ouvrir.
      'Pour it over boiling hot to **cover the sprouts completely**, close the jars, leave to cool and keep in a cool place. Wait a week before opening.',
    ],
  ),
  'chou_bruxelles/Choux de Bruxelles rôtis au lard': RecipeText(
    // FR: Choux de Bruxelles rôtis au lard
    name: 'Roasted Brussels sprouts with bacon',
    // FR: Coupés en deux, face contre la plaque : ils caramélisent.
    description: 'Halved, cut side down on the tray: they caramelise.',
  ),
  'chou_bruxelles/Choux de Bruxelles à la crème': RecipeText(
    // FR: Choux de Bruxelles à la crème
    name: 'Creamed Brussels sprouts',
    // FR: Blanchis, puis fondus dans la crème à la muscade.
    description: 'Blanched, then melted into nutmeg cream.',
  ),
  'chou_bruxelles/Salade de choux de Bruxelles crus': RecipeText(
    // FR: Salade de choux de Bruxelles crus
    name: 'Raw Brussels sprout salad',
    // FR: Émincés très fin, pomme, noisettes, vinaigrette au miel.
    description: 'Sliced very thin, with apple, hazelnuts and a honey vinaigrette.',
  ),

  // ─────────── chou_chinois (6 recettes) ───────────
  'chou_chinois/Chou chinois en saumure au gingembre': RecipeText(
    // FR: Chou chinois en saumure au gingembre
    name: 'Napa cabbage in ginger brine',
    // FR: Tout simplement en saumure, sans pâte de piment : un chou acidulé et doux à glisser dans les soupes et les bols de riz.
    description: 'Simply in brine, with no chilli paste: a mild, tangy cabbage to slip into soups and rice bowls.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 large Napa cabbage (about 1.5 kg)', // FR: 1 gros chou chinois (environ 1,5 kg)
      '1.5 litres of unchlorinated water', // FR: 1,5 litre d'eau non chlorée
      '45 g of non-iodised salt', // FR: 45 g de sel non iodé
      '1 piece of ginger, 4 cm long', // FR: 1 morceau de gingembre de 4 cm
      '2 garlic cloves', // FR: 2 gousses d'ail
    ],
    steps: <String>[
      // FR: Fais dissoudre **45 g de sel dans 1,5 litre d'eau** : saumure à 3 %.
      'Dissolve **45 g of salt in 1.5 litres of water**: a 3 % brine.',
      // FR: Coupe le chou en tronçons de 4 cm, le gingembre en fines lamelles et l'ail en deux.
      'Cut the cabbage into 4 cm pieces, the ginger into thin slices and the garlic in half.',
      // FR: Rince les tronçons à l'eau froide et égoutte-les.
      'Rinse the pieces in cold water and drain them.',
      // FR: Tasse le chou dans trois bocaux en intercalant gingembre et ail, jusqu'à 3 cm du bord.
      'Pack the cabbage into three jars, layering in the ginger and garlic, up to 3 cm from the rim.',
      // FR: Couvre de saumure et pose un poids : les feuilles flottent, il faut les **maintenir dessous**.
      'Cover with brine and add a weight: the leaves float, so you must **keep them under**.',
      // FR: Laisse fermenter à 18–22 °C, couvercle posé sans serrer, de 1 à 2 semaines. Goûte à partir du 5e jour.
      'Leave to ferment at 18–22 °C, with the lid resting on top without tightening, for 1 to 2 weeks. Taste from day 5.',
      // FR: Quand c'est acidulé à ton goût, ferme et passe au réfrigérateur.
      'When it is as tangy as you like it, close the jars and move them to the fridge.',
    ],
  ),
  'chou_chinois/Pickles rapides de chou chinois': RecipeText(
    // FR: Pickles rapides de chou chinois
    name: 'Quick Napa cabbage pickles',
    // FR: Un quart d'heure, et les côtes blanches deviennent un condiment aigre-doux pour les nouilles et les sandwichs.
    description: 'A quarter of an hour, and the white ribs become a sweet-and-sour relish for noodles and sandwiches.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '600 g Napa cabbage ribs', // FR: 600 g de côtes de chou chinois
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 40 g of sugar', // FR: 10 g de sel, 40 g de sucre
      '1 tsp sesame seeds', // FR: 1 cuillère à café de graines de sésame
    ],
    steps: <String>[
      // FR: Sépare les côtes blanches du vert et taille-les en biais en lanières d'un doigt. Garde le vert pour une poêlée.
      'Separate the white ribs from the green and cut them on the diagonal into strips as wide as a finger. Keep the green for a stir-fry.',
      // FR: Remplis deux bocaux ébouillantés avec les lanières et le sésame.
      'Fill two scalded jars with the strips and the sesame seeds.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre jusqu'à dissolution.
      'Boil the vinegar, water, salt and sugar until dissolved.',
      // FR: Verse bouillant pour **couvrir entièrement** les côtes, ferme aussitôt.
      'Pour it over boiling hot to **cover the ribs completely** and close the jars straight away.',
      // FR: Laisse refroidir puis range au réfrigérateur. Prêt dès le lendemain.
      'Leave to cool, then put in the fridge. Ready the next day.',
    ],
  ),
  'chou_chinois/Chou chinois blanchi pour les soupes': RecipeText(
    // FR: Chou chinois blanchi pour les soupes
    name: 'Blanched Napa cabbage for soups',
    // FR: Une minute dans l'eau, et il attend au congélateur le prochain bouillon ou la prochaine soupe de nouilles.
    description: 'One minute in the water, and it waits in the freezer for the next broth or noodle soup.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg Napa cabbage', // FR: 1,5 kg de chou chinois
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le chou en lanières de 3 cm, en séparant les côtes du vert tendre.
      'Cut the cabbage into 3 cm strips, separating the ribs from the tender green.',
      // FR: Lave et égoutte les lanières.
      'Wash and drain the strips.',
      // FR: Blanchis les côtes **1 minute 30** puis ajoute le vert pour 30 secondes, dans une grande eau bouillante salée.
      'Blanch the ribs for **1 minute 30 seconds**, then add the green for 30 seconds, in a large pan of salted boiling water.',
      // FR: Plonge tout dans l'eau glacée, puis presse bien pour chasser l'eau.
      'Plunge everything into the iced water, then squeeze well to drive out the water.',
      // FR: Mets en sacs à plat, en portions d'une soupe. Il se met directement, encore gelé, dans le bouillon : décongelé, il est trop mou pour un sauté.
      'Put into bags laid flat, in soup-sized portions. It goes straight into the broth, still frozen: thawed, it is too soft for a stir-fry.',
    ],
  ),
  'chou_chinois/Chou chinois sauté au wok': RecipeText(
    // FR: Chou chinois sauté au wok
    name: 'Wok-fried Napa cabbage',
    // FR: Gingembre, ail, sauce soja, deux minutes à feu vif.
    description: 'Ginger, garlic, soy sauce, two minutes over high heat.',
  ),
  'chou_chinois/Kimchi maison': RecipeText(
    // FR: Kimchi maison
    name: 'Homemade kimchi',
    // FR: Salé, épicé, fermenté une semaine à température.
    description: 'Salted, spiced, fermented for a week at room temperature.',
  ),
  'chou_chinois/Salade de chou chinois au sésame': RecipeText(
    // FR: Salade de chou chinois au sésame
    name: 'Napa cabbage and sesame salad',
    // FR: Émincé cru, vinaigre de riz, huile de sésame.
    description: 'Sliced raw, with rice vinegar and sesame oil.',
  ),

  // ─────────── chou_fleur (6 recettes) ───────────
  'chou_fleur/Fleurettes de chou-fleur blanchies': RecipeText(
    // FR: Fleurettes de chou-fleur blanchies
    name: 'Blanched cauliflower florets',
    // FR: Trois minutes dans l'eau bouillante, et ton chou-fleur attend sagement le gratin de janvier.
    description: 'Three minutes in boiling water, and your cauliflower waits patiently for the January gratin.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 cauliflowers', // FR: 2 chou-fleurs
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles et détaille le chou-fleur en fleurettes de 3 cm, de taille régulière.
      'Remove the leaves and break the cauliflower into 3 cm florets, all about the same size.',
      // FR: Fais-les tremper 10 minutes dans l'eau salée : les petites chenilles cachées remontent à la surface.
      'Soak them for 10 minutes in salted water: any small caterpillars hiding in there float to the surface.',
      // FR: Plonge les fleurettes dans une grande eau salée bouillante, **3 minutes**.
      'Drop the florets into a large pan of salted boiling water for **3 minutes**.',
      // FR: Transfère-les aussitôt dans l'eau glacée, jusqu'à ce qu'elles soient froides à cœur.
      'Move them straight into the iced water until they are cold right through.',
      // FR: Égoutte-les tête en bas et sèche-les bien dans un torchon.
      'Drain them upside down and dry them well in a tea towel.',
      // FR: Congèle-les sur une plaque, puis passe-les en sac. Elles se cuisent sans décongeler.
      'Freeze them on a tray, then tip them into bags. They cook without thawing.',
    ],
  ),
  'chou_fleur/Piccalilli au chou-fleur': RecipeText(
    // FR: Piccalilli au chou-fleur
    name: 'Cauliflower piccalilli',
    // FR: Le condiment anglais jaune vif à la moutarde et au curcuma, pour la viande froide et les sandwichs.
    description: 'The bright yellow English relish made with mustard and turmeric, for cold meat and sandwiches.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 cauliflower, 2 carrots and 1 onion', // FR: 1 chou-fleur, 2 carottes et 1 oignon
      '50 g of coarse salt', // FR: 50 g de gros sel
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '150 g of sugar', // FR: 150 g de sucre
      '2 tbsp mustard powder, 1 of turmeric', // FR: 2 cuillères à soupe de moutarde en poudre, 1 de curcuma
      '2 tbsp cornflour', // FR: 2 cuillères à soupe de maïzena
    ],
    steps: <String>[
      // FR: Taille le chou-fleur en toutes petites fleurettes, les carottes en petits dés et l'oignon en morceaux.
      'Cut the cauliflower into very small florets, the carrots into small dice and the onion into pieces.',
      // FR: Mélange les légumes au gros sel et laisse dégorger une nuit au frais : ils restent croquants.
      'Mix the vegetables with the coarse salt and leave overnight in a cool place to draw out the water: they stay crunchy.',
      // FR: Rince-les à grande eau et égoutte-les bien.
      'Rinse them thoroughly and drain well.',
      // FR: Délaie moutarde, curcuma et maïzena dans un peu de vinaigre froid, puis ajoute le reste du vinaigre et le sucre.
      'Whisk the mustard, turmeric and cornflour into a little cold vinegar, then add the rest of the vinegar and the sugar.',
      // FR: Porte cette sauce à ébullition en fouettant jusqu'à ce qu'elle épaississe, ajoute les légumes et cuis-les dedans.
      'Bring this sauce to the boil, whisking until it thickens, then add the vegetables and cook them in it.',
      // FR: Remplis des pots ébouillantés, ferme et laisse refroidir, puis range au réfrigérateur. Attends une semaine avant d'ouvrir.
      'Fill scalded jars, close them and leave to cool, then keep in the fridge. Wait a week before opening.',
    ],
  ),
  'chou_fleur/Chou-fleur fermenté au curcuma': RecipeText(
    // FR: Chou-fleur fermenté au curcuma
    name: 'Fermented cauliflower with turmeric',
    // FR: En saumure, les fleurettes deviennent acidulées et dorées, à picorer à l'apéritif ou à glisser dans une salade.
    description: 'In brine, the florets turn tangy and golden, to nibble with drinks or slip into a salad.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 cauliflower', // FR: 1 chou-fleur
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '1 tsp turmeric', // FR: 1 cuillère à café de curcuma
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 tsp coriander seeds', // FR: 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel** et le curcuma dans 1 litre d'eau : c'est la saumure.
      'Dissolve **30 g of salt** and the turmeric in 1 litre of water: that is the brine.',
      // FR: Détaille le chou-fleur en fleurettes de 3 cm et rince-les.
      'Break the cauliflower into 3 cm florets and rinse them.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et la coriandre, jusqu'à 3 cm du bord.
      'Pack them into a jar with the crushed garlic and the coriander, up to 3 cm from the rim.',
      // FR: Verse la saumure pour couvrir et pose un poids : les fleurettes flottent, elles doivent rester **sous la saumure**.
      'Pour in the brine to cover and add a weight: the florets float, and they must stay **under the brine**.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer. L'odeur un peu soufrée est normale chez les choux.
      'Leave to ferment for 2 weeks at 18–22 °C, with the lid resting on top without tightening. A slightly sulphurous smell is normal with brassicas.',
      // FR: Quand c'est assez acide à ton goût, ferme bien et range au réfrigérateur.
      'When it is as sour as you like it, close the lid tightly and put the jar in the fridge.',
    ],
  ),
  'chou_fleur/Gratin de chou-fleur': RecipeText(
    // FR: Gratin de chou-fleur
    name: 'Cauliflower cheese',
    // FR: Béchamel muscadée, gruyère, cuit juste assez pour rester entier.
    description: 'Nutmeg béchamel, Gruyère, cooked just enough to keep the florets whole.',
  ),
  'chou_fleur/Chou-fleur rôti aux épices': RecipeText(
    // FR: Chou-fleur rôti aux épices
    name: 'Spiced roasted cauliflower',
    // FR: En steaks épais, curcuma et cumin, four très chaud.
    description: 'In thick steaks, with turmeric and cumin, in a very hot oven.',
  ),
  'chou_fleur/Taboulé de chou-fleur': RecipeText(
    // FR: Taboulé de chou-fleur
    name: 'Cauliflower tabbouleh',
    // FR: Mixé cru en semoule, citron, menthe et persil.
    description: 'Blitzed raw into a couscous-like grain, with lemon, mint and parsley.',
  ),

  // ─────────── chou_kale (6 recettes) ───────────
  'chou_kale/Kale blanchi en boulettes': RecipeText(
    // FR: Kale blanchi en boulettes
    name: 'Blanched kale balls',
    // FR: Deux minutes à l'eau, une boulette pressée, et tu as une portion de vert prête pour une soupe ou une poêlée.
    description: 'Two minutes in water, one pressed ball, and you have a portion of greens ready for a soup or a stir-fry.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1.5 kg kale leaves', // FR: 1,5 kg de feuilles de kale
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les feuilles dans plusieurs eaux, en frottant le revers où se cachent les pucerons.
      'Wash the leaves in several changes of water, rubbing the underside where the aphids hide.',
      // FR: Arrache la feuille de la grosse côte, qui reste dure même cuite, et déchire en morceaux.
      'Pull each leaf off its thick rib, which stays tough even when cooked, and tear the leaf into pieces.',
      // FR: Plonge le kale par poignées dans une grande eau bouillante salée, **2 minutes**.
      'Drop the kale by the handful into a large pan of salted boiling water for **2 minutes**.',
      // FR: Transfère aussitôt dans l'eau glacée : le vert devient éclatant et ne bougera plus.
      'Move it straight into the iced water: the green turns bright and will not change again.',
      // FR: Presse le kale fort entre tes mains pour chasser l'eau, et forme des boulettes d'une portion.
      'Squeeze the kale hard between your hands to drive out the water, and shape into single-portion balls.',
      // FR: Congèle-les 2 heures sur une plaque, puis range-les en sac daté.
      'Freeze them for 2 hours on a tray, then put them in a dated bag.',
    ],
  ),
  'chou_kale/Flocons de kale séchés': RecipeText(
    // FR: Flocons de kale séchés
    name: 'Dried kale flakes',
    // FR: Séché tout doucement puis émietté, il se saupoudre dans les soupes, les omelettes et les sauces tout l'hiver.
    description: 'Dried very gently then crumbled, it can be sprinkled into soups, omelettes and sauces all winter.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in the dry, away from the light',
    ingredients: <String>[
      '1 kg kale leaves', // FR: 1 kg de feuilles de kale
      'a clean tea towel', // FR: un torchon propre
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Lave les feuilles et **sèche-les complètement** à la centrifugeuse puis au torchon.
      'Wash the leaves and **dry them completely** in a salad spinner, then in a tea towel.',
      // FR: Retire les côtes et déchire les feuilles en morceaux de la taille d'une paume.
      'Remove the ribs and tear the leaves into pieces the size of a palm.',
      // FR: Étale-les en une seule couche sur des plaques et enfourne à 60 °C, porte entrouverte d'une cuillère en bois.
      'Spread them in a single layer on trays and put them in the oven at 60 °C, with the door propped open by a wooden spoon.',
      // FR: Vérifie : une feuille prête se brise net entre tes doigts. Si elle plie encore, continue 30 minutes.
      'Check: a ready leaf snaps cleanly between your fingers. If it still bends, carry on for 30 minutes.',
      // FR: Laisse refroidir puis émiette à la main ou mixe en flocons.
      'Let it cool, then crumble by hand or blend into flakes.',
      // FR: Mets en bocaux bien secs, fermés, et range dans un placard sombre.
      'Put into very dry jars, close them and store in a dark cupboard.',
    ],
  ),
  'chou_kale/Pesto de kale en glaçons': RecipeText(
    // FR: Pesto de kale en glaçons
    name: 'Kale pesto cubes',
    // FR: Plus corsé qu'un pesto de basilic, il tient au congélateur sans noircir.
    description: 'Stronger than a basil pesto, it holds in the freezer without turning black.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '300 g kale leaves without ribs', // FR: 300 g de feuilles de kale sans côtes
      '50 g of walnuts', // FR: 50 g de noix
      '2 garlic cloves', // FR: 2 gousses d'ail
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      'the juice of half a lemon, salt', // FR: le jus d'un demi-citron, sel
    ],
    steps: <String>[
      // FR: Blanchis les feuilles 1 minute à l'eau bouillante salée : ça adoucit leur amertume.
      'Blanch the leaves for 1 minute in salted boiling water: it softens their bitterness.',
      // FR: Refroidis-les dans l'eau glacée, puis presse-les très fort.
      'Cool them in iced water, then squeeze them very hard.',
      // FR: Mixe kale, noix, ail et citron par à-coups, en versant l'huile en filet. **Sans fromage**, tu l'ajouteras à table.
      'Blend the kale, walnuts, garlic and lemon in pulses, pouring in the oil in a thin stream. **No cheese**: you will add that at the table.',
      // FR: Sale et goûte, puis remplis un bac à glaçons et couvre chaque case d'un filet d'huile.
      'Season and taste, then fill an ice cube tray and cover each compartment with a film of oil.',
      // FR: Démoule quand c'est dur, au bout de 4 heures, et garde les cubes en sac daté.
      'Turn out once hard, after 4 hours, and keep the cubes in a dated bag.',
    ],
  ),
  'chou_kale/Chips de kale': RecipeText(
    // FR: Chips de kale
    name: 'Kale chips',
    // FR: Massées à l'huile, cuites à four doux jusqu'à craquer.
    description: 'Massaged with oil, baked in a low oven until crisp.',
  ),
  'chou_kale/Salade de kale massé': RecipeText(
    // FR: Salade de kale massé
    name: 'Massaged kale salad',
    // FR: Masser les feuilles au citron les attendrit en deux minutes.
    description: 'Massaging the leaves with lemon tenderises them in two minutes.',
  ),
  'chou_kale/Kale sauté à l\'ail et au chorizo': RecipeText(
    // FR: Kale sauté à l'ail et au chorizo
    name: 'Kale sautéed with garlic and chorizo',
    // FR: Le gras du chorizo enrobe les feuilles.
    description: 'The chorizo fat coats the leaves.',
  ),

  // ─────────── chou_pomme (6 recettes) ───────────
  'chou_pomme/Lanières de chou blanchies congelées': RecipeText(
    // FR: Lanières de chou blanchies congelées
    name: 'Blanched frozen cabbage strips',
    // FR: Une minute et demie dans l'eau bouillante, et ton chou est prêt pour les potées et les poêlées de l'hiver.
    description: 'A minute and a half in boiling water, and your cabbage is ready for the hotpots and stir-fries of winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 large white cabbage (about 2 kg)', // FR: 1 gros chou pommé (environ 2 kg)
      'coarse salt', // FR: gros sel
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles extérieures abîmées, coupe le chou en quatre et ôte le trognon.
      'Remove the damaged outer leaves, cut the cabbage into four and cut out the core.',
      // FR: Émince chaque quartier en lanières d'un centimètre.
      'Slice each quarter into strips one centimetre wide.',
      // FR: Rince les lanières dans une bassine d'eau froide pour décoller la terre et les petites bêtes.
      'Rinse the strips in a bowl of cold water to wash off the soil and any little creatures.',
      // FR: Plonge-les par grosses poignées dans l'eau bouillante salée et compte **2 minutes**, pas plus.
      'Drop them in big handfuls into salted boiling water and count **2 minutes**, no more.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour arrêter la cuisson.
      'Drain and plunge straight into the iced water to stop the cooking.',
      // FR: Égoutte à fond et essore à la centrifugeuse à salade ou dans un torchon.
      'Drain thoroughly and dry in a salad spinner or a tea towel.',
      // FR: Mets en sacs à plat par portions d'un repas, chasse l'air et congèle. Se cuisine sans décongeler.
      'Put into bags laid flat, in meal-sized portions, press out the air and freeze. Cook without thawing.',
    ],
  ),
  'chou_pomme/Chou rouge aigre-doux en bocal': RecipeText(
    // FR: Chou rouge aigre-doux en bocal
    name: 'Sweet-and-sour red cabbage in a jar',
    // FR: Salé une nuit puis noyé de vinaigre épicé, le chou rouge devient un condiment violet qui réveille l'hiver.
    description: 'Salted overnight then drowned in spiced vinegar, red cabbage becomes a purple relish that wakes up the winter.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 red cabbage (about 1.5 kg)', // FR: 1 chou rouge (environ 1,5 kg)
      '40 g of coarse salt', // FR: 40 g de gros sel
      '60 cl of cider vinegar at 6 %', // FR: 60 cl de vinaigre de cidre à 6 %
      '40 cl of water', // FR: 40 cl d'eau
      '80 g of sugar', // FR: 80 g de sucre
      '1 tsp juniper berries and 2 bay leaves', // FR: 1 cuillère à café de baies de genièvre et 2 feuilles de laurier
    ],
    steps: <String>[
      // FR: Ôte le trognon et émince le chou très finement, à la mandoline si tu en as une.
      'Remove the core and slice the cabbage very finely, on a mandoline if you have one.',
      // FR: Mélange-le au gros sel dans un saladier, couvre et laisse **une nuit** : il rend son eau et s'assouplit.
      'Mix it with the coarse salt in a bowl, cover and leave **overnight**: it releases its water and softens.',
      // FR: Rince-le soigneusement à l'eau froide et égoutte-le en le pressant.
      'Rinse it carefully in cold water and drain it, squeezing.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le genièvre et le laurier, puis laisse tiédir 10 minutes.
      'Bring the vinegar, water, sugar, juniper and bay to the boil, then let it cool for 10 minutes.',
      // FR: Tasse le chou dans des bocaux propres jusqu'à 2 cm du bord.
      'Pack the cabbage into clean jars up to 2 cm from the rim.',
      // FR: Verse le vinaigre jusqu'à **recouvrir entièrement** le chou, tasse avec une cuillère pour chasser l'air, ferme.
      'Pour in the vinegar until the cabbage is **completely covered**, press down with a spoon to push out the air, and close.',
      // FR: Range au réfrigérateur et attends une semaine : il devient croquant, rose vif et bien parfumé.
      'Put in the fridge and wait a week: it turns crunchy, bright pink and well flavoured.',
    ],
  ),
  'chou_pomme/Kimchi de chou pommé': RecipeText(
    // FR: Kimchi de chou pommé
    name: 'White cabbage kimchi',
    // FR: Le kimchi se fait aussi avec un chou d'ici : salé, pimenté, fermenté, il vit et s'affine au frais pendant des mois.
    description: 'Kimchi can be made with a local cabbage too: salted, spiced, fermented, it lives and matures in the cool for months.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 white cabbage of 1 kg, without the core', // FR: 1 chou pommé de 1 kg, sans trognon
      '20 g of fine non-iodised salt', // FR: 20 g de sel fin non iodé
      '4 garlic cloves', // FR: 4 gousses d'ail
      '1 piece of ginger, 3 cm long', // FR: 1 morceau de gingembre de 3 cm
      '2 tbsp Korean chilli flakes or mild chilli flakes', // FR: 2 cuillères à soupe de piment coréen ou de piment doux en flocons
      '4 spring onions', // FR: 4 oignons nouveaux
    ],
    steps: <String>[
      // FR: Coupe le chou en carrés de 3 cm et pèse-le : il te faut **20 g de sel par kilo** de chou.
      'Cut the cabbage into 3 cm squares and weigh it: you need **20 g of salt per kilo** of cabbage.',
      // FR: Masse le chou avec le sel à pleines mains quelques minutes, puis laisse-le reposer : il va rendre son jus.
      'Massage the cabbage with the salt in your hands for a few minutes, then leave it to stand: it will release its juice.',
      // FR: Mixe l'ail, le gingembre et le piment avec 2 cuillères d'eau pour faire une pâte.
      'Blend the garlic, ginger and chilli with 2 spoonfuls of water to make a paste.',
      // FR: Mélange la pâte et les oignons nouveaux émincés au chou, avec son jus. Mets des gants, ça pique.
      'Mix the paste and the sliced spring onions into the cabbage, with its juice. Wear gloves, it stings.',
      // FR: Tasse fort dans un bocal propre jusqu'à ce que le jus remonte et **recouvre le chou**. Laisse 3 cm de vide.
      'Pack it down hard in a clean jar until the juice rises and **covers the cabbage**. Leave 3 cm of space.',
      // FR: Pose un poids (un petit sac congélation rempli d'eau) et laisse fermenter 5 à 7 jours vers 20 °C, en appuyant chaque jour.
      'Add a weight (a small freezer bag filled with water) and leave to ferment for 5 to 7 days at about 20 °C, pressing down every day.',
      // FR: Quand il est bien acidulé, range-le au réfrigérateur. Il continue de mûrir doucement.
      'When it is nicely tangy, put it in the fridge. It carries on maturing gently.',
    ],
  ),
  'chou_pomme/Choucroute maison': RecipeText(
    // FR: Choucroute maison
    name: 'Homemade sauerkraut',
    // FR: Chou, sel, du temps. La fermentation fait le reste.
    description: 'Cabbage, salt, time. Fermentation does the rest.',
  ),
  'chou_pomme/Riz gras': RecipeText(
    // FR: Riz gras
    name: 'Riz gras',
    // FR: Le riz mijoté à la tomate du Burkina, avec ses gros morceaux de chou fondant.
    description: 'Rice simmered in tomato, Burkina-style, with big pieces of melting cabbage.',
  ),
  'chou_pomme/Salade de chou': RecipeText(
    // FR: Salade de chou
    name: 'Cabbage salad',
    // FR: Du chou finement émincé avec carottes et vinaigrette, croquant et frais.
    description: 'Finely sliced cabbage with carrots and vinaigrette, crunchy and fresh.',
  ),

  // ─────────── chou_rave (6 recettes) ───────────
  'chou_rave/Chou-rave fermenté au sel': RecipeText(
    // FR: Chou-rave fermenté au sel
    name: 'Salt-fermented kohlrabi',
    // FR: Râpé et salé comme une choucroute, il devient acidulé et se garde des mois sans cuisson.
    description: 'Grated and salted like sauerkraut, it turns tangy and keeps for months with no cooking.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '2 kg kohlrabi', // FR: 2 kg de chou-rave
      '40 g of fine non-iodised salt (20 g per kg)', // FR: 40 g de sel fin non iodé (20 g par kg)
      '1 tsp caraway seeds', // FR: 1 cuillère à café de graines de carvi
      '3 jars of 75 cl', // FR: 3 bocaux de 75 cl
    ],
    steps: <String>[
      // FR: Épluche les choux-raves en enlevant bien la couche fibreuse, puis râpe-les gros.
      'Peel the kohlrabi, making sure you remove the fibrous layer, then grate it coarsely.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**. Mélange avec le carvi.
      'Weigh the grated kohlrabi and add **20 g of salt per kilo**. Mix with the caraway.',
      // FR: Malaxe à pleines mains 5 minutes : le sel fait sortir le jus, et c'est ce jus qui sera ta saumure.
      'Knead with your hands for 5 minutes: the salt draws out the juice, and that juice will be your brine.',
      // FR: Tasse fort dans les bocaux, couche par couche, jusqu'à ce que le jus remonte au-dessus. Laisse 3 cm de vide en haut.
      'Pack it down hard into the jars, layer by layer, until the juice rises above it. Leave 3 cm of space at the top.',
      // FR: Pose un poids (petit pot rempli d'eau, galet ébouillanté) : tout doit rester **sous le jus**. Complète si besoin avec de l'eau salée à 30 g par litre.
      'Put a weight on top (a small jar filled with water, a scalded pebble): everything must stay **under the juice**. If needed, top up with salted water at 30 g per litre.',
      // FR: Ferme sans serrer et laisse fermenter à 18–22 °C pendant 2 semaines, sur une assiette : ça déborde parfois les premiers jours.
      'Close without tightening and leave to ferment at 18–22 °C for 2 weeks, standing on a plate: it sometimes overflows in the first few days.',
      // FR: Quand c'est acidulé à ton goût, serre les couvercles et passe les bocaux au réfrigérateur.
      'When it is as tangy as you like it, tighten the lids and move the jars to the fridge.',
    ],
  ),
  'chou_rave/Bâtonnets de chou-rave au vinaigre': RecipeText(
    // FR: Bâtonnets de chou-rave au vinaigre
    name: 'Kohlrabi sticks in vinegar',
    // FR: Un quart d'heure, et le chou-rave garde son croquant de pomme dans un bocal au frais.
    description: 'A quarter of an hour, and kohlrabi keeps its apple-like crunch in a jar in the fridge.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '600 g kohlrabi', // FR: 600 g de chou-rave
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 25 g of sugar', // FR: 10 g de sel, 25 g de sucre
      '1 small chilli, a few sprigs of dill', // FR: 1 petit piment, quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Épluche le chou-rave et coupe-le en bâtonnets de 1 cm d'épaisseur.
      'Peel the kohlrabi and cut it into sticks 1 cm thick.',
      // FR: Serre-les debout dans deux bocaux ébouillantés, avec l'aneth et le piment fendu.
      'Pack them upright into two scalded jars, with the dill and the split chilli.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre jusqu'à dissolution.
      'Boil the vinegar, water, salt and sugar until dissolved.',
      // FR: Verse bouillant pour **couvrir entièrement** les bâtonnets, ferme aussitôt.
      'Pour it over boiling hot to **cover the sticks completely** and close the jars straight away.',
      // FR: Laisse refroidir puis range au réfrigérateur. Ils sont bons au bout de 2 jours.
      'Leave to cool, then put in the fridge. They are good after 2 days.',
    ],
  ),
  'chou_rave/Dés de chou-rave blanchis congelés': RecipeText(
    // FR: Dés de chou-rave blanchis congelés
    name: 'Blanched frozen kohlrabi cubes',
    // FR: Coupé en dés et blanchi deux minutes, il file tout droit dans les soupes et les poêlées d'hiver.
    description: 'Diced and blanched for two minutes, it goes straight into winter soups and stir-fries.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1.5 kg kohlrabi', // FR: 1,5 kg de chou-rave
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche généreusement et coupe en dés de 2 cm, réguliers pour qu'ils blanchissent pareil.
      'Peel generously and cut into 2 cm dice, all the same size so they blanch evenly.',
      // FR: Plonge les dés dans une grande eau bouillante salée, **2 minutes** à la reprise de l'ébullition.
      'Drop the dice into a large pan of salted boiling water for **2 minutes** from when it comes back to the boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour stopper la cuisson.
      'Drain and plunge straight into the iced water to stop the cooking.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Drain and dry well on a tea towel.',
      // FR: Congèle à plat sur une plaque 2 heures, puis mets en sacs datés : les dés resteront séparés.
      'Freeze flat on a tray for 2 hours, then put into dated bags: the dice will stay separate.',
    ],
  ),
  'chou_rave/Chou-rave râpé en rémoulade': RecipeText(
    // FR: Chou-rave râpé en rémoulade
    name: 'Kohlrabi rémoulade',
    // FR: Cru, il croque comme une pomme et goûte la noisette.
    description: 'Raw, it crunches like an apple and tastes of hazelnut.',
  ),
  'chou_rave/Chou-rave sauté au beurre': RecipeText(
    // FR: Chou-rave sauté au beurre
    name: 'Kohlrabi sautéed in butter',
    // FR: En bâtonnets, à peine dorés, avec du persil.
    description: 'In sticks, barely golden, with parsley.',
  ),
  'chou_rave/Gratin de chou-rave': RecipeText(
    // FR: Gratin de chou-rave
    name: 'Kohlrabi gratin',
    // FR: En lamelles fines, crème et comté.
    description: 'In thin slices, with cream and Comté.',
  ),

  // ─────────── ciboulette (6 recettes) ───────────
  'ciboulette/Ciboulette ciselée en boîte au congélateur': RecipeText(
    // FR: Ciboulette ciselée en boîte au congélateur
    name: 'Chopped chives in a freezer box',
    // FR: Séchée, la ciboulette ne sent plus rien ; congelée, elle garde son piquant d'oignon tout l'hiver.
    description: 'Dried, chives lose their smell; frozen, they keep their onion bite all winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '4 good handfuls of chives', // FR: 4 belles poignées de ciboulette
      'a rigid box or a freezer jar', // FR: une boîte rigide ou un bocal de congélation
    ],
    steps: <String>[
      // FR: Rince les brins à l'eau froide et secoue-les bien.
      'Rinse the stems in cold water and shake them well.',
      // FR: Étale-les sur un torchon et laisse-les **sécher complètement**. Une ciboulette humide gèle en bloc.
      'Spread them on a tea towel and leave them to **dry completely**. Damp chives freeze into a block.',
      // FR: Cisèle-la finement aux ciseaux, en tronçons de 3 à 5 mm. Retire les bouts jaunis.
      'Snip them finely with scissors, into pieces 3 to 5 mm long. Remove any yellowed ends.',
      // FR: Verse-la en vrac dans une boîte rigide, sans tasser, et ferme. Note la date.
      'Pour them loose into a rigid box, without packing them down, and close it. Write the date on it.',
      // FR: Secoue la boîte de temps en temps les premiers jours : elle reste en grains et se pince directement.
      'Shake the box from time to time over the first few days: they stay in separate grains and you can pinch out what you need.',
      // FR: À l'usage, jette-la **encore gelée** dans l'omelette ou la sauce. Décongelée, elle devient molle.
      'When using, throw them in **still frozen** into the omelette or sauce. Thawed, they go limp.',
    ],
  ),
  'ciboulette/Vinaigre rose aux fleurs de ciboulette': RecipeText(
    // FR: Vinaigre rose aux fleurs de ciboulette
    name: 'Pink chive flower vinegar',
    // FR: Les pompons mauves colorent le vinaigre en rose et lui donnent un doux goût d'oignon.
    description: 'The mauve pompoms turn the vinegar pink and give it a mild onion flavour.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, away from the light',
    ingredients: <String>[
      '2 handfuls of fully open chive flowers', // FR: 2 poignées de fleurs de ciboulette bien ouvertes
      '50 cl of white wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'a clean glass jar', // FR: un bocal en verre propre
    ],
    steps: <String>[
      // FR: Coupe les fleurs juste sous le pompon, une fois bien ouvertes et sans rosée.
      'Cut the flowers just below the pompom, once fully open and free of dew.',
      // FR: Plonge-les dans l'eau froide et secoue : de petites bêtes se cachent entre les fleurettes. Sèche-les sur un torchon.
      'Dip them in cold water and shake: little creatures hide between the florets. Dry them on a tea towel.',
      // FR: Remplis le bocal aux deux tiers de fleurs, sans tasser.
      'Fill the jar two-thirds full of flowers, without packing them down.',
      // FR: Verse le vinaigre pur jusqu'en haut : les fleurs doivent être **entièrement couvertes**, sinon elles moisissent.
      'Pour in the undiluted vinegar to the top: the flowers must be **completely covered**, otherwise they go mouldy.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant le bocal tous les deux ou trois jours.
      'Close and leave to infuse for two weeks in the shade, shaking the jar every two or three days.',
      // FR: Filtre dans une passoire fine, mets en bouteille propre et jette les fleurs fatiguées.
      'Strain through a fine sieve, pour into a clean bottle and throw away the spent flowers.',
    ],
  ),
  'ciboulette/Sel vert à la ciboulette': RecipeText(
    // FR: Sel vert à la ciboulette
    name: 'Green chive salt',
    // FR: Mixée au gros sel puis séchée au four, la ciboulette se garde un an dans une salière.
    description: 'Blended with coarse salt then dried in the oven, chives keep for a year in a salt shaker.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 year in the cupboard, in a closed jar',
    ingredients: <String>[
      '100 g chives', // FR: 100 g de ciboulette
      '300 g of coarse sea salt', // FR: 300 g de gros sel de mer
      'a tray and baking paper', // FR: une plaque et du papier cuisson
    ],
    steps: <String>[
      // FR: Lave et **sèche à fond** la ciboulette, puis coupe-la en tronçons.
      'Wash the chives and **dry them thoroughly**, then cut them into pieces.',
      // FR: Mixe-la par à-coups avec le gros sel jusqu'à un sable vert humide.
      'Blend them in pulses with the coarse salt until you have a damp green sand.',
      // FR: Étale en couche fine sur la plaque et enfourne à 50 °C, porte entrouverte avec une cuillère en bois.
      'Spread in a thin layer on the tray and put in the oven at 50 °C, with the door propped open by a wooden spoon.',
      // FR: Émiette et remue toutes les demi-heures : le sel est prêt quand il coule entre les doigts sans coller.
      'Crumble and stir every half hour: the salt is ready when it runs through your fingers without sticking.',
      // FR: Laisse refroidir complètement sur la plaque, sinon la condensation le refait prendre en bloc.
      'Leave to cool completely on the tray, otherwise condensation makes it clump into a block again.',
      // FR: Mets en pot bien sec. Il perd un peu de vert avec les mois, pas son goût.
      'Put it in a very dry jar. It loses a little of its green over the months, but not its flavour.',
    ],
  ),
  'ciboulette/Fromage blanc aux herbes': RecipeText(
    // FR: Fromage blanc aux herbes
    name: 'Fromage frais with herbs',
    // FR: Ciboulette, échalote, ail : la cervelle de canut.
    description: 'Chives, shallot, garlic: the Lyon cervelle de canut.',
  ),
  'ciboulette/Omelette à la ciboulette': RecipeText(
    // FR: Omelette à la ciboulette
    name: 'Chive omelette',
    // FR: Ajoutée hors du feu pour garder sa couleur.
    description: 'Added off the heat to keep its colour.',
  ),
  'ciboulette/Beurre à la ciboulette': RecipeText(
    // FR: Beurre à la ciboulette
    name: 'Chive butter',
    // FR: En rouleau au congélateur, à trancher sur une viande.
    description: 'Rolled and frozen, to slice onto meat.',
  ),

  // ─────────── citronnelle (6 recettes) ───────────
  'citronnelle/Tiges de citronnelle congelées': RecipeText(
    // FR: Tiges de citronnelle congelées
    name: 'Frozen lemongrass stalks',
    // FR: La citronnelle se congèle presque sans perdre d'arôme : un quart d'heure, et tu en as pour toute l'année.
    description: 'Lemongrass freezes with almost no loss of aroma: a quarter of an hour, and you are set for the whole year.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '20 lemongrass stalks', // FR: 20 tiges de citronnelle
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la base racinaire et la partie verte et sèche du haut : garde les 15 cm du bas, blancs et tendres.
      'Cut off the root base and the dry green top: keep the bottom 15 cm, white and tender.',
      // FR: Retire la première feuille dure, rince et sèche bien les tiges.
      'Remove the first tough layer, then rinse and dry the stalks well.',
      // FR: Laisse-les entières pour parfumer les bouillons, ou émince-en une partie en rondelles fines pour les sautés.
      'Leave them whole to flavour broths, or slice some of them into thin rounds for stir-fries.',
      // FR: Mets-les en sac à plat, chasse l'air et congèle. Elles se coupent **encore gelées**, plus facilement que fraîches.
      'Put them in a bag laid flat, press out the air and freeze. They cut **while still frozen**, more easily than fresh.',
    ],
  ),
  'citronnelle/Pâte de citronnelle au gingembre': RecipeText(
    // FR: Pâte de citronnelle au gingembre
    name: 'Lemongrass and ginger paste',
    // FR: La base de tous les currys d'Asie du Sud-Est, mixée une fois et congelée en cubes prêts à jeter dans la poêle.
    description: 'The base of every Southeast Asian curry, blended once and frozen in cubes ready to drop into the pan.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '10 lemongrass stalks', // FR: 10 tiges de citronnelle
      '1 piece of ginger, 6 cm long', // FR: 1 morceau de gingembre de 6 cm
      '4 garlic cloves', // FR: 4 gousses d'ail
      '2 shallots', // FR: 2 échalotes
      '5 cl of neutral oil', // FR: 5 cl d'huile neutre
    ],
    steps: <String>[
      // FR: Garde la partie blanche et tendre des tiges, retire la feuille extérieure et émince en fines rondelles.
      'Keep the white, tender part of the stalks, remove the outer layer and slice into thin rounds.',
      // FR: Épluche le gingembre, l'ail et les échalotes, et coupe-les grossièrement.
      'Peel the ginger, garlic and shallots and chop them roughly.',
      // FR: Mixe le tout avec l'huile jusqu'à obtenir une pâte fine. Racle les bords plusieurs fois, la citronnelle est fibreuse.
      'Blend everything with the oil to a fine paste. Scrape down the sides several times: lemongrass is fibrous.',
      // FR: Remplis un bac à glaçons, un cube par plat, et congèle jusqu'à ce qu'ils soient durs.
      'Fill an ice cube tray, one cube per dish, and freeze until hard.',
      // FR: Démoule et garde en sac au congélateur. Avec l'ail cru dedans, **jamais à température ambiante** : utilise les cubes gelés, directement dans la poêle chaude.
      'Turn out and keep in a bag in the freezer. With raw garlic in it, **never at room temperature**: use the cubes frozen, straight into a hot pan.',
    ],
  ),
  'citronnelle/Feuilles de citronnelle séchées pour tisane': RecipeText(
    // FR: Feuilles de citronnelle séchées pour tisane
    name: 'Dried lemongrass leaves for herbal tea',
    // FR: Les longues feuilles vertes, trop dures pour la cuisine, font une tisane citronnée tout l'hiver.
    description: 'The long green leaves, too tough for cooking, make a lemony herbal tea all winter.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in the dry, away from the light',
    ingredients: <String>[
      'the green leaves of 20 lemongrass stalks', // FR: les feuilles vertes de 20 tiges de citronnelle
      'scissors', // FR: des ciseaux
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les à fond dans un torchon.
      'Rinse the leaves and dry them thoroughly in a tea towel.',
      // FR: Coupe-les aux ciseaux en tronçons de 2 à 3 cm.
      'Cut them with scissors into 2 to 3 cm pieces.',
      // FR: Étale-les en couche fine sur une plaque et sèche au four à **40 °C**, porte entrouverte, ou à l'air dans un endroit sec et ombragé pendant une semaine.
      'Spread them in a thin layer on a tray and dry in the oven at **40 °C**, with the door ajar, or in the air somewhere dry and shaded for a week.',
      // FR: Elles sont prêtes quand elles cassent sous les doigts et ne sont plus souples du tout.
      'They are ready when they snap under your fingers and are not at all bendy.',
      // FR: Range-les en bocal fermé, dans un placard sombre. Une cuillère à soupe pour une tasse d'eau frémissante, 5 minutes.
      'Store in a closed jar in a dark cupboard. One tablespoon for a cup of simmering water, for 5 minutes.',
    ],
  ),
  'citronnelle/Sirop de citronnelle': RecipeText(
    // FR: Sirop de citronnelle
    name: 'Lemongrass syrup',
    // FR: Tiges froissées infusées dans un sirop, pour une limonade.
    description: 'Bruised stalks infused in a syrup, for a lemonade.',
  ),
  'citronnelle/Poulet à la citronnelle': RecipeText(
    // FR: Poulet à la citronnelle
    name: 'Lemongrass chicken',
    // FR: Mariné au citron vert, à l'ail et à la citronnelle hachée.
    description: 'Marinated in lime, garlic and chopped lemongrass.',
  ),
  'citronnelle/Infusion de citronnelle': RecipeText(
    // FR: Infusion de citronnelle
    name: 'Lemongrass infusion',
    // FR: Quelques feuilles fraîches infusées, un parfum citronné qui apaise le soir.
    description: 'A few fresh leaves infused, a lemony scent that soothes the evening.',
  ),

  // ─────────── concombre (6 recettes) ───────────
  'concombre/Pickles de concombre à l\'aneth': RecipeText(
    // FR: Pickles de concombre à l'aneth
    name: 'Dill cucumber pickles',
    // FR: La meilleure façon d'écouler une vague de concombres : en tranches croquantes, à l'aneth et à l'ail.
    description: 'The best way to use up a glut of cucumbers: in crunchy slices, with dill and garlic.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1.5 kg firm cucumbers', // FR: 1,5 kg de concombres fermes
      '30 g of salt', // FR: 30 g de sel
      '50 cl of white vinegar at 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '2 tbsp sugar', // FR: 2 cuillères à soupe de sucre
      '1 bunch of dill and 3 garlic cloves', // FR: 1 bouquet d'aneth et 3 gousses d'ail
    ],
    steps: <String>[
      // FR: Lave les concombres et coupe un fin bout côté fleur : il contient une enzyme qui ramollit les pickles.
      'Wash the cucumbers and cut off a thin slice at the blossom end: it contains an enzyme that softens pickles.',
      // FR: Coupe-les en rondelles épaisses ou en quartiers dans la longueur.
      'Cut them into thick rounds or into lengthways quarters.',
      // FR: Sale-les et laisse-les dégorger avec quelques glaçons par-dessus : c'est le secret du **croquant**.
      'Salt them and leave them to draw out their water with a few ice cubes on top: that is the secret of the **crunch**.',
      // FR: Rince-les à l'eau froide et égoutte-les bien.
      'Rinse them in cold water and drain well.',
      // FR: Tasse-les dans des bocaux propres avec l'aneth et l'ail en lamelles.
      'Pack them into clean jars with the dill and the garlic in thin slices.',
      // FR: Porte à ébullition vinaigre, eau et sucre jusqu'à ce que le sucre soit fondu.
      'Bring the vinegar, water and sugar to the boil until the sugar has dissolved.',
      // FR: Verse le vinaigre chaud jusqu'à **couvrir entièrement** les concombres, ferme et range au réfrigérateur après refroidissement. Prêts en 2 jours.
      'Pour in the hot vinegar until the cucumbers are **completely covered**, close the jars and put them in the fridge once cool. Ready in 2 days.',
    ],
  ),
  'concombre/Concombres lacto-fermentés': RecipeText(
    // FR: Concombres lacto-fermentés
    name: 'Lacto-fermented cucumbers',
    // FR: Les vrais « malossols » d'Europe de l'Est : juste une saumure, de l'aneth, et la fermentation fait le reste.
    description: 'The real Eastern European "malossols": just a brine and some dill, and fermentation does the rest.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 kg small firm cucumbers', // FR: 1 kg de petits concombres fermes
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '4 garlic cloves', // FR: 4 gousses d'ail
      'a few heads of dill', // FR: quelques têtes d'aneth
      '2 vine or oak leaves', // FR: 2 feuilles de vigne ou de chêne
    ],
    steps: <String>[
      // FR: Lave les concombres à l'eau froide sans frotter fort et coupe le bout côté fleur.
      'Wash the cucumbers in cold water without scrubbing hard and cut off the blossom end.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau** pour faire la saumure.
      'Dissolve **30 g of salt in 1 litre of water** to make the brine.',
      // FR: Mets les feuilles de vigne au fond du bocal : leurs tanins gardent les concombres fermes.
      'Put the vine leaves at the bottom of the jar: their tannins keep the cucumbers firm.',
      // FR: Range les concombres debout et serrés, avec l'ail écrasé et l'aneth entre eux.
      'Stand the cucumbers upright and tightly packed, with the crushed garlic and the dill between them.',
      // FR: Couvre de saumure et pose un poids : **tout doit rester sous le liquide**, sinon ça moisit.
      'Cover with brine and add a weight: **everything must stay under the liquid**, or it will go mouldy.',
      // FR: Laisse 1 à 2 semaines vers 20 °C. Retire l'éventuelle mousse blanche en surface, c'est normal.
      'Leave for 1 to 2 weeks at about 20 °C. Remove any white scum on the surface, it is normal.',
      // FR: Quand ils sont vert olive et acidulés jusqu'au cœur, range-les au réfrigérateur.
      'When they are olive green and tangy right through, put them in the fridge.',
    ],
  ),
  'concombre/Glaçons de concombre et menthe': RecipeText(
    // FR: Glaçons de concombre et menthe
    name: 'Cucumber and mint ice cubes',
    // FR: Un concombre ne se congèle pas en tranches, mais mixé il fait des glaçons parfaits pour les gaspachos et l'eau fraîche.
    description: 'A cucumber does not freeze in slices, but blended it makes perfect ice cubes for gazpachos and cool water.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg cucumbers', // FR: 1 kg de concombres
      'the juice of one lemon', // FR: le jus d'un citron
      'about ten mint leaves', // FR: une dizaine de feuilles de menthe
      'ice cube trays', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Lave les concombres ; épluche-les une bande sur deux si la peau est épaisse.
      'Wash the cucumbers; peel them in alternate strips if the skin is thick.',
      // FR: Coupe-les en tronçons et retire les graines à la cuillère si elles sont grosses.
      'Cut them into chunks and scoop out the seeds with a spoon if they are big.',
      // FR: Mixe finement avec le citron et la menthe : le citron empêche le jus de **griser au froid**.
      'Blend finely with the lemon and mint: the lemon stops the juice **turning grey in the cold**.',
      // FR: Verse dans les bacs à glaçons et congèle jusqu'à ce qu'ils soient bien durs.
      'Pour into ice cube trays and freeze until very hard.',
      // FR: Démoule et garde les cubes en sac. Trois cubes dans un yaourt mixé, et voilà une soupe froide.
      'Turn out and keep the cubes in a bag. Three cubes in a blended yoghurt, and you have a cold soup.',
    ],
  ),
  'concombre/Tzatziki': RecipeText(
    // FR: Tzatziki
    name: 'Tzatziki',
    // FR: Concombre râpé, yaourt grec, ail et menthe — frais et franc.
    description: 'Grated cucumber, Greek yoghurt, garlic and mint — fresh and straightforward.',
    ingredients: <String>[
      '1 cucumber', // FR: 1 concombre
      '400 g of Greek yoghurt', // FR: 400 g de yaourt grec
      '1 garlic clove', // FR: 1 gousse d'ail
      'fresh mint', // FR: menthe fraîche
      '1 tbsp olive oil, salt', // FR: 1 cuillère à soupe d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Râpe le concombre avec sa peau si elle est fine.
      'Grate the cucumber with its skin if it is thin.',
      // FR: Sale-le et laisse-le dégorger 15 minutes dans une passoire. C'est l'étape qu'on saute et qui donne un tzatziki liquide.
      'Salt it and leave it to drain for 15 minutes in a colander. This is the step people skip, and it gives a runny tzatziki.',
      // FR: Presse-le fort entre tes mains.
      'Squeeze it hard between your hands.',
      // FR: Mélange au yaourt avec l'ail écrasé, l'huile et la menthe ciselée.
      'Mix it into the yoghurt with the crushed garlic, the oil and the chopped mint.',
      // FR: Au frais une heure avant de servir.
      'Chill for an hour before serving.',
    ],
  ),
  'concombre/Soupe froide de concombre': RecipeText(
    // FR: Soupe froide de concombre
    name: 'Cold cucumber soup',
    // FR: Mixée crue, servie glacée : l'entrée des jours de canicule.
    description: 'Blended raw, served ice cold: the starter for heatwave days.',
    ingredients: <String>[
      '2 cucumbers', // FR: 2 concombres
      '20 cl of fromage frais', // FR: 20 cl de fromage blanc
      '1 garlic clove', // FR: 1 gousse d'ail
      'chives, mint', // FR: ciboulette, menthe
      'salt, pepper, 1 dash of vinegar', // FR: sel, poivre, 1 trait de vinaigre
    ],
    steps: <String>[
      // FR: Pèle les concombres et retire les graines du centre.
      'Peel the cucumbers and remove the seeds from the centre.',
      // FR: Mixe avec le fromage blanc, l'ail, le vinaigre, sel et poivre.
      'Blend with the fromage frais, garlic, vinegar, salt and pepper.',
      // FR: Au réfrigérateur **2 heures** : tiède, cette soupe ne vaut rien.
      'Chill for **2 hours**: lukewarm, this soup is not worth eating.',
      // FR: Herbes ciselées au moment de servir.
      'Chop the herbs and add them at the moment of serving.',
    ],
  ),
  'concombre/Salade de concombre au yaourt': RecipeText(
    // FR: Salade de concombre au yaourt
    name: 'Cucumber and yoghurt salad',
    // FR: En rondelles fines, à peine habillées — on garde le croquant.
    description: 'In thin slices, barely dressed — we keep the crunch.',
    ingredients: <String>[
      '1 cucumber', // FR: 1 concombre
      '3 tbsp yoghurt', // FR: 3 cuillères à soupe de yaourt
      '1 shallot', // FR: 1 échalote
      'dill or chives', // FR: aneth ou ciboulette
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Coupe le concombre en rondelles très fines, à l'économe si tu veux.
      'Cut the cucumber into very thin slices, with a peeler if you like.',
      // FR: Sale légèrement et laisse 10 minutes, puis égoutte sans presser : on veut qu'il reste croquant.
      'Salt lightly and leave for 10 minutes, then drain without squeezing: we want it to stay crunchy.',
      // FR: Mélange yaourt, échalote hachée, herbes, poivre.
      'Mix the yoghurt, chopped shallot, herbs and pepper.',
      // FR: Assemble juste avant de passer à table.
      'Combine just before you sit down to eat.',
    ],
  ),

  // ─────────── corete (6 recettes) ───────────
  'corete/Corète hachée crue en portions': RecipeText(
    // FR: Corète hachée crue en portions
    name: 'Raw chopped jute mallow in portions',
    // FR: Hachée fin et congelée crue, elle garde toute sa bave : tu la jettes directement dans la sauce.
    description: 'Chopped fine and frozen raw, it keeps all its sliminess: you drop it straight into the sauce.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg jute mallow leaves', // FR: 1 kg de feuilles de corète
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et garde seulement les feuilles tendres.
      'Strip the leaves from the stems and keep only the tender ones.',
      // FR: Lave-les dans plusieurs eaux, puis **sèche-les bien** : mouillées, elles collent en bloc.
      'Wash them in several changes of water, then **dry them well**: wet, they stick together in a block.',
      // FR: Hache-les fin, au couteau ou au hachoir, comme pour la sauce.
      'Chop them fine, with a knife or a chopper, as for the sauce.',
      // FR: Répartis en sacs à plat, une portion par sac. Mets-la gelée dans le bouillon chaud et fouette.
      'Divide into bags laid flat, one portion per bag. Add it frozen to the hot broth and whisk.',
    ],
  ),
  'corete/Feuilles de corète séchées': RecipeText(
    // FR: Feuilles de corète séchées
    name: 'Dried jute mallow leaves',
    // FR: Séchée à l'ombre, la corète se garde des mois et retrouve sa texture filante dès qu'elle touche l'eau chaude.
    description: 'Dried in the shade, jute mallow keeps for months and gets its stringy, slippery texture back as soon as it meets hot water.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in the dry, away from the light',
    ingredients: <String>[
      'leafy jute mallow stems', // FR: des tiges de corète feuillues
      'drying racks or a clean sheet', // FR: des claies ou un drap propre
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les tiges et écarte les feuilles abîmées.
      'Strip the leaves from the stems and discard any that are damaged.',
      // FR: Rince rapidement et étale sur un torchon pour égoutter.
      'Rinse quickly and spread on a tea towel to drain.',
      // FR: Étale en couche mince à l'ombre, dans un endroit aéré, 2 à 3 jours en remuant chaque jour.
      'Spread in a thin layer in the shade, somewhere airy, for 2 to 3 days, stirring every day.',
      // FR: Quand elles s'émiettent sous les doigts, c'est sec. Molles, elles noircissent en bocal.
      'When they crumble under your fingers, they are dry. Still soft, they turn black in the jar.',
      // FR: Mets en bocaux hermétiques. Pour cuisiner, émiette-les dans le bouillon frémissant et fouette.
      'Put into airtight jars. To cook, crumble them into the simmering broth and whisk.',
    ],
  ),
  'corete/Corète blanchie congelée': RecipeText(
    // FR: Corète blanchie congelée
    name: 'Frozen blanched jute mallow',
    // FR: Une minute de blanchiment, et la corète garde un vert vif pour les sauces de l'hiver.
    description: 'One minute of blanching, and jute mallow keeps a bright green for the winter\'s sauces.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg jute mallow leaves', // FR: 1 kg de feuilles de corète
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille et lave les feuilles dans plusieurs eaux.
      'Strip the leaves and wash them in several changes of water.',
      // FR: Plonge-les dans une grande eau bouillante, à gros bouillons.
      'Drop them into a large pan of boiling water at a rolling boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer la couleur.
      'Drain and plunge straight into the iced water to set the colour.',
      // FR: Égoutte et presse doucement : elles sont gluantes, pas besoin d'essorer à fond.
      'Drain and press gently: they are slimy, so there is no need to squeeze them dry.',
      // FR: Répartis en portions dans des sacs à plat et congèle.
      'Divide into portions in bags laid flat and freeze.',
    ],
  ),
  'corete/Corète à l\'arachide': RecipeText(
    // FR: Corète à l'arachide
    name: 'Jute mallow with groundnut',
    // FR: La sauce longue, liée à la pâte d'arachide.
    description: 'The long sauce, thickened with groundnut paste.',
  ),
  'corete/Sauce adémè': RecipeText(
    // FR: Sauce adémè
    name: 'Adémè sauce',
    // FR: La sauce gluante et savoureuse du Togo et du Bénin, à base de feuilles de corète.
    description: 'The slippery, flavourful sauce of Togo and Benin, made with jute mallow leaves.',
  ),
  'corete/Ewédu': RecipeText(
    // FR: Ewédu
    name: 'Ewedu',
    // FR: La soupe de corète yoruba, mixée bien lisse, servie avec un ragoût de tomate.
    description: 'Yoruba jute mallow soup, blended smooth, served with a tomato stew.',
  ),

  // ─────────── coriandre (6 recettes) ───────────
  'coriandre/Glaçons de coriandre à l\'huile': RecipeText(
    // FR: Glaçons de coriandre à l'huile
    name: 'Coriander oil cubes',
    // FR: La coriandre séchée n'a plus de goût : dans l'huile, au congélateur, elle reste vive.
    description: 'Dried coriander has no flavour left: in oil, in the freezer, it stays lively.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 big bunches of coriander', // FR: 2 gros bouquets de coriandre
      '10 cl of neutral or olive oil', // FR: 10 cl d'huile neutre ou d'olive
      'an ice cube tray', // FR: un bac à glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave la coriandre dans plusieurs eaux, le sable reste collé au pied.
      'Wash the coriander in several changes of water: the grit clings to the base.',
      // FR: Essore-la puis sèche-la sur un torchon. Garde les tiges tendres : elles ont autant de goût.
      'Spin it dry, then dry it on a tea towel. Keep the tender stalks: they have just as much flavour.',
      // FR: Hache-la grossièrement au couteau.
      'Chop it roughly with a knife.',
      // FR: Remplis le bac à glaçons aux trois quarts de coriandre, puis couvre **juste à ras** d'huile.
      'Fill the ice cube tray three-quarters full of coriander, then cover with oil **just to the brim**.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, démoule et garde-les en sac.
      'Freeze until the cubes are hard, turn them out and keep them in a bag.',
      // FR: Jette un cube **directement dans la poêle** ou le curry en fin de cuisson. Ne le laisse pas dégeler à température ambiante.
      'Drop a cube **straight into the pan** or curry at the end of cooking. Do not let it thaw at room temperature.',
    ],
  ),
  'coriandre/Pâte verte coriandre-gingembre': RecipeText(
    // FR: Pâte verte coriandre-gingembre
    name: 'Green coriander and ginger paste',
    // FR: Une base toute prête pour les currys, soupes et marinades, en portions dans le congélateur.
    description: 'A ready-made base for curries, soups and marinades, in portions in the freezer.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '200 g coriander with the stalks', // FR: 200 g de coriandre avec les tiges
      '40 g of fresh ginger', // FR: 40 g de gingembre frais
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 green chilli', // FR: 1 piment vert
      'the juice of one lime', // FR: le jus d'un citron vert
      '8 cl of neutral oil, 1 tsp salt', // FR: 8 cl d'huile neutre, 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Lave et sèche la coriandre, coupe-la en tronçons, tiges comprises.
      'Wash and dry the coriander and cut it into pieces, stalks included.',
      // FR: Épluche le gingembre à la cuillère et l'ail. Épépine le piment si tu veux une pâte douce.
      'Peel the ginger with a spoon, and peel the garlic. Deseed the chilli if you want a mild paste.',
      // FR: Mixe tout avec le citron vert, l'huile et le sel jusqu'à une pâte lisse. Racle les parois deux fois.
      'Blend everything with the lime juice, oil and salt to a smooth paste. Scrape down the sides twice.',
      // FR: Remplis un bac à glaçons : un cube, c'est une poêlée pour quatre.
      'Fill an ice cube tray: one cube makes a stir-fry for four.',
      // FR: Congèle jusqu'à ce que ce soit dur, puis démoule en sac **bien fermé**, sinon tout le congélateur sent la coriandre.
      'Freeze until hard, then turn out into a **tightly closed** bag, or the whole freezer will smell of coriander.',
      // FR: À l'usage, fais revenir le cube encore gelé 1 minute dans un peu d'huile avant d'ajouter le reste.
      'When using, fry the cube still frozen for 1 minute in a little oil before adding the rest.',
    ],
  ),
  'coriandre/Graines de coriandre séchées': RecipeText(
    // FR: Graines de coriandre séchées
    name: 'Dried coriander seeds',
    // FR: Laisse quelques pieds monter en graines : tu récoltes une épice citronnée gratuite pour un an.
    description: 'Let a few plants run to seed: you harvest a free lemony spice for a year.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in the dry, away from the light',
    ingredients: <String>[
      'coriander stems gone to seed', // FR: des tiges de coriandre montées en graines
      'a large paper bag', // FR: un grand sac en papier
      'string', // FR: de la ficelle
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les graines **virent au beige**, avant qu'elles ne tombent toutes seules.
      'Cut the stems when the seeds **turn beige**, before they fall on their own.',
      // FR: Fais de petites bottes de cinq ou six tiges et lie-les à la ficelle.
      'Make small bunches of five or six stems and tie them with string.',
      // FR: Suspends-les tête en bas dans un sac en papier, dans un endroit sec et aéré, deux semaines. Le sac recueille ce qui tombe.
      'Hang them upside down in a paper bag, somewhere dry and airy, for two weeks. The bag catches whatever falls.',
      // FR: Secoue et frotte les ombelles dans le sac : les graines se détachent seules.
      'Shake and rub the seed heads inside the bag: the seeds come away on their own.',
      // FR: Souffle doucement dessus au-dessus d'un saladier pour chasser les débris, ou passe-les au tamis.
      'Blow gently over a bowl to get rid of the debris, or pass them through a sieve.',
      // FR: Mets-les en bocal **entières**, et mouds-les ou écrase-les seulement au moment de cuisiner.
      'Put them in a jar **whole**, and grind or crush them only when you cook.',
    ],
  ),
  'coriandre/Chermoula': RecipeText(
    // FR: Chermoula
    name: 'Chermoula',
    // FR: Coriandre, cumin, paprika, citron — la marinade du poisson.
    description: 'Coriander, cumin, paprika, lemon — the fish marinade.',
  ),
  'coriandre/Guacamole à la coriandre': RecipeText(
    // FR: Guacamole à la coriandre
    name: 'Coriander guacamole',
    // FR: Écrasé à la fourchette, jamais mixé.
    description: 'Mashed with a fork, never blended.',
  ),
  'coriandre/Salade thaïe à la coriandre': RecipeText(
    // FR: Salade thaïe à la coriandre
    name: 'Thai coriander salad',
    // FR: Avec de la menthe, du citron vert et du piment.
    description: 'With mint, lime and chilli.',
  ),

  // ─────────── cornichon (6 recettes) ───────────
  'cornichon/Cornichons à l\'ancienne au vinaigre blanc': RecipeText(
    // FR: Cornichons à l'ancienne au vinaigre blanc
    name: 'Old-fashioned gherkins in white vinegar',
    // FR: Dégorgés une nuit au gros sel puis couverts de vinaigre pur : la méthode des grands-mères, qui tient toute l'année.
    description: 'Drawn out overnight in coarse salt then covered with undiluted vinegar: grandmothers\' method, which lasts all year.',
    // FR: 1 an au placard, au réfrigérateur une fois ouvert
    keeps: '1 year in the cupboard, in the fridge once opened',
    ingredients: <String>[
      '1 kg firm gherkins, picked small', // FR: 1 kg de cornichons fermes, cueillis petits
      '100 g of coarse salt', // FR: 100 g de gros sel
      '1 litre of white vinegar at 8 %', // FR: 1 litre de vinaigre blanc à 8 %
      '10 small pickling onions', // FR: 10 petits oignons grelots
      'a few sprigs of tarragon', // FR: quelques branches d'estragon
      '1 tbsp peppercorns', // FR: 1 cuillère à soupe de grains de poivre
    ],
    steps: <String>[
      // FR: Brosse les cornichons sous l'eau pour retirer les petits picots et la fleur séchée. Coupe le bout de la queue.
      'Scrub the gherkins under water to remove the little prickles and the dried blossom. Cut off the end of the stalk.',
      // FR: Roule-les dans le gros sel et laisse-les dégorger une nuit : c'est ce qui les rend **croquants**.
      'Roll them in the coarse salt and leave them overnight to draw out their water: that is what makes them **crunchy**.',
      // FR: Rince-les à l'eau vinaigrée pour retirer le sel, puis sèche-les un par un dans un torchon.
      'Rinse them in vinegared water to remove the salt, then dry them one by one in a tea towel.',
      // FR: Tasse-les dans des bocaux ébouillantés avec les oignons épluchés, l'estragon et le poivre.
      'Pack them into scalded jars with the peeled onions, the tarragon and the pepper.',
      // FR: Verse le vinaigre froid jusqu'à **couvrir largement**, 1 cm au-dessus des cornichons, et ferme.
      'Pour in the cold vinegar to **cover generously**, 1 cm above the gherkins, and close the jars.',
      // FR: Attends au moins 4 semaines avant d'ouvrir, au frais et à l'abri de la lumière. S'il baisse, recomplète de vinaigre.
      'Wait at least 4 weeks before opening, in a cool place away from the light. If the level drops, top up with vinegar.',
    ],
  ),
  'cornichon/Cornichons fermentés à la russe': RecipeText(
    // FR: Cornichons fermentés à la russe
    name: 'Russian-style fermented gherkins',
    // FR: Sans vinaigre, juste une saumure : des cornichons aigres et parfumés comme en Europe de l'Est.
    description: 'No vinegar, just a brine: sour, fragrant gherkins as in Eastern Europe.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '1.5 kg firm gherkins', // FR: 1,5 kg de cornichons fermes
      '1.5 litres of unchlorinated water', // FR: 1,5 litre d'eau non chlorée
      '45 g of non-iodised salt', // FR: 45 g de sel non iodé
      '4 garlic cloves', // FR: 4 gousses d'ail
      '2 heads of dill', // FR: 2 ombelles d'aneth
      '2 vine or bay leaves', // FR: 2 feuilles de vigne ou de laurier
    ],
    steps: <String>[
      // FR: Prépare la saumure : **30 g de sel par litre d'eau**, soit 45 g pour 1,5 litre.
      'Make the brine: **30 g of salt per litre of water**, so 45 g for 1.5 litres.',
      // FR: Brosse les cornichons et coupe un millimètre du bout de la fleur : il contient une enzyme qui ramollit.
      'Scrub the gherkins and cut one millimetre off the blossom end: it contains an enzyme that softens them.',
      // FR: Tasse-les debout dans le bocal avec l'ail écrasé, l'aneth et les feuilles de vigne, qui les gardent fermes.
      'Pack them upright in the jar with the crushed garlic, the dill and the vine leaves, which keep them firm.',
      // FR: Verse la saumure et pose un poids : tout doit rester **sous la saumure**, à 3 cm du bord.
      'Pour in the brine and add a weight: everything must stay **under the brine**, 3 cm from the rim.',
      // FR: Laisse fermenter 10 jours à 18–22 °C, couvercle posé sans serrer. La saumure se trouble, c'est normal.
      'Leave to ferment for 10 days at 18–22 °C, with the lid resting on top without tightening. The brine turns cloudy, that is normal.',
      // FR: Quand ils sont aigres à cœur, ferme et range au réfrigérateur. Un cornichon mou ou visqueux, jette-le.
      'When they are sour right through, close the jar and put it in the fridge. A gherkin that is soft or slimy, throw it away.',
    ],
  ),
  'cornichon/Rondelles de cornichons aigres-douces': RecipeText(
    // FR: Rondelles de cornichons aigres-douces
    name: 'Sweet-and-sour gherkin slices',
    // FR: Pour les cornichons qui ont trop grossi : en rondelles sucrées-acides, ils font la garniture idéale des burgers.
    description: 'For gherkins that have grown too big: as sweet-and-sour slices, they are the ideal burger topping.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '800 g large gherkins', // FR: 800 g de gros cornichons
      '1 onion', // FR: 1 oignon
      '30 cl of cider vinegar at 6 %', // FR: 30 cl de vinaigre de cidre à 6 %
      '30 cl of water', // FR: 30 cl d'eau
      '80 g of sugar', // FR: 80 g de sucre
      '1 tbsp salt, 1 tsp mustard seeds', // FR: 1 cuillère à soupe de sel, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Lave les cornichons et coupe les deux bouts.
      'Wash the gherkins and cut off both ends.',
      // FR: Tranche-les en rondelles de 5 mm et émince l'oignon finement.
      'Slice them into 5 mm rounds and slice the onion finely.',
      // FR: Tasse rondelles et oignon dans des bocaux propres avec la moutarde.
      'Pack the slices and onion into clean jars with the mustard seeds.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement**, ferme et laisse refroidir, puis range au réfrigérateur.
      'Pour it over boiling hot to **cover completely**, close the jars and leave to cool, then put in the fridge.',
    ],
  ),
  'cornichon/Cornichons au vinaigre': RecipeText(
    // FR: Cornichons au vinaigre
    name: 'Gherkins in vinegar',
    // FR: Brossés au gros sel, séchés une nuit, couverts de vinaigre bouillant.
    description: 'Scrubbed with coarse salt, dried overnight, covered with boiling vinegar.',
  ),
  'cornichon/Cornichons à l\'aneth': RecipeText(
    // FR: Cornichons à l'aneth
    name: 'Dill gherkins',
    // FR: À la lacto-fermentation, en saumure : croquants et vivants.
    description: 'Lacto-fermented, in brine: crunchy and alive.',
  ),
  'cornichon/Sauce tartare': RecipeText(
    // FR: Sauce tartare
    name: 'Tartare sauce',
    // FR: Hachés dans la mayonnaise avec câpres et estragon.
    description: 'Chopped into mayonnaise with capers and tarragon.',
  ),

  // ─────────── courge_butternut (6 recettes) ───────────
  'courge_butternut/Butternut rôtie en cubes à congeler': RecipeText(
    // FR: Butternut rôtie en cubes à congeler
    name: 'Roasted butternut cubes to freeze',
    // FR: Rôtie avant de geler, elle garde son goût de noisette caramélisée et ressort en dix minutes au four.
    description: 'Roasted before freezing, it keeps its caramelised, nutty flavour and is ready in ten minutes in the oven.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 butternut squashes', // FR: 2 courges butternut
      '3 tbsp olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      '1 tsp salt', // FR: 1 cuillère à café de sel
      'baking paper', // FR: du papier cuisson
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le haut et le bas, épluche à l'économe, ouvre en deux et retire les graines.
      'Cut off the top and bottom, peel with a peeler, halve and remove the seeds.',
      // FR: Coupe la chair en cubes de 2 cm.
      'Cut the flesh into 2 cm cubes.',
      // FR: Mélange-les à l'huile et au sel, puis étale-les sur des plaques couvertes de papier, sans les entasser.
      'Toss them with the oil and salt, then spread them on trays lined with paper, without crowding.',
      // FR: Rôtis 25 minutes à 200 °C, jusqu'à ce que les bords dorent mais que les cubes **tiennent encore**.
      'Roast for 25 minutes at 200 °C, until the edges turn golden but the cubes **still hold their shape**.',
      // FR: Laisse refroidir complètement sur la plaque.
      'Leave to cool completely on the tray.',
      // FR: Congèle la plaque 2 heures, puis verse en sac. Pour risottos, salades tièdes et veloutés minute.
      'Freeze the tray for 2 hours, then tip into a bag. For risottos, warm salads and instant soups.',
    ],
  ),
  'courge_butternut/Butternut râpée crue au congélateur': RecipeText(
    // FR: Butternut râpée crue au congélateur
    name: 'Raw grated butternut for the freezer',
    // FR: Râpée crue en sachets, elle va directement dans les galettes, les cakes et les gratins, sans éplucher une courge un soir de semaine.
    description: 'Grated raw into bags, it goes straight into fritters, cakes and gratins, with no squash to peel on a weeknight.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 large butternut squash', // FR: 1 grosse courge butternut
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche la courge à l'économe, coupe-la en deux et retire les graines.
      'Peel the squash with a peeler, halve it and remove the seeds.',
      // FR: Coupe-la en gros morceaux qui tiennent en main, puis râpe-les côté gros trous ou au robot.
      'Cut it into large chunks that fit in your hand, then grate them on the coarse side of the grater or with a food processor.',
      // FR: Répartis la râpée en sachets de 250 g, aplatis-les en galettes fines pour qu'ils gèlent et dégèlent vite.
      'Divide the grated squash into 250 g bags and flatten them into thin slabs so they freeze and thaw quickly.',
      // FR: Chasse l'air, ferme et congèle à plat. Note la date et le poids : **utilise-la encore gelée**, elle rend moins d'eau.
      'Press out the air, close and freeze flat. Note the date and the weight: **use it still frozen**, it releases less water.',
    ],
  ),
  'courge_butternut/Chips de butternut séchées': RecipeText(
    // FR: Chips de butternut séchées
    name: 'Dried butternut crisps',
    // FR: Tranchées très fin et séchées doucement, elles se croquent comme des chips et se gardent des mois.
    description: 'Sliced very thin and dried gently, they crunch like crisps and keep for months.',
    // FR: 3 mois au sec, en bocal hermétique
    keeps: '3 months in the dry, in an airtight jar',
    ingredients: <String>[
      '1 butternut squash', // FR: 1 courge butternut
      '1 tbsp olive oil', // FR: 1 cuillère à soupe d'huile d'olive
      '1 tsp fine salt', // FR: 1 cuillère à café de sel fin
      'baking paper', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Épluche le col de la courge (la partie pleine, sans graines) et tranche-le à la mandoline, **2 mm** d'épaisseur.
      'Peel the neck of the squash (the solid part, without seeds) and slice it on a mandoline, **2 mm** thick.',
      // FR: Mélange les tranches avec l'huile et le sel, juste de quoi les faire briller.
      'Toss the slices with the oil and salt, just enough to make them shine.',
      // FR: Étale-les en une seule couche sur des plaques couvertes de papier, sans qu'elles se chevauchent.
      'Spread them in a single layer on trays lined with paper, without overlapping.',
      // FR: Sèche au four à **90 °C**, porte entrouverte, en les retournant à mi-temps.
      'Dry in the oven at **90 °C**, with the door ajar, turning them halfway through.',
      // FR: Elles sont prêtes quand elles cassent net. Les molles du milieu repassent une demi-heure.
      'They are ready when they snap cleanly. The soft ones from the middle go back in for half an hour.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les mettre en bocal, sinon la vapeur les ramollit.
      'Leave them to cool completely on the tray before putting them in a jar, otherwise the steam softens them.',
    ],
  ),
  'courge_butternut/Butternut rôtie entière': RecipeText(
    // FR: Butternut rôtie entière
    name: 'Whole roasted butternut',
    // FR: Coupée en deux, côté chair sur la plaque, une heure.
    description: 'Halved, cut side down on the tray, for an hour.',
  ),
  'courge_butternut/Risotto à la butternut': RecipeText(
    // FR: Risotto à la butternut
    name: 'Butternut risotto',
    // FR: Moitié en cubes, moitié en purée dans le bouillon.
    description: 'Half in cubes, half as a purée in the stock.',
  ),
  'courge_butternut/Velouté de butternut': RecipeText(
    // FR: Velouté de butternut
    name: 'Butternut soup',
    // FR: Une soupe soyeuse au petit goût de noisette, douce comme un câlin.
    description: 'A silky soup with a hint of hazelnut, soft as a cuddle.',
  ),

  // ─────────── laurier_sauce (6 recettes) ───────────
  'laurier_sauce/Feuilles de laurier séchées à plat': RecipeText(
    // FR: Feuilles de laurier séchées à plat
    name: 'Bay leaves dried flat',
    // FR: Séchées bien à plat et à l'ombre, elles restent vertes et parfumées toute l'année.
    description: 'Dried flat and in the shade, they stay green and fragrant all year.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'sprigs of bay laurel', // FR: des rameaux de laurier-sauce
      'sheets of newspaper or a tea towel', // FR: des feuilles de papier journal ou un torchon
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille sur un **vrai laurier-sauce** (Laurus nobilis). Le laurier-rose et le laurier-cerise sont toxiques : dans le doute, ne cueille pas.
      'Pick from a **true bay laurel** (Laurus nobilis). Oleander and cherry laurel are toxic: if in doubt, do not pick.',
      // FR: Essuie les feuilles avec un linge humide, détache-les des rameaux et garde les plus belles.
      'Wipe the leaves with a damp cloth, pull them off the sprigs and keep the best ones.',
      // FR: Étale-les en une seule couche entre deux feuilles de papier, posées sur une claie ou un plateau.
      'Spread them in a single layer between two sheets of paper, on a rack or a tray.',
      // FR: Laisse-les deux semaines à l'ombre, dans une pièce sèche et aérée. Un livre léger posé dessus les garde bien plates.
      'Leave them for two weeks in the shade, in a dry, airy room. A light book on top keeps them nice and flat.',
      // FR: Elles sont prêtes quand elles cassent net. Range-les entières en bocal, elles parfument mieux qu'émiettées.
      'They are ready when they snap cleanly. Store them whole in a jar: they flavour better than crumbled ones.',
    ],
  ),
  'laurier_sauce/Rameaux de laurier au congélateur': RecipeText(
    // FR: Rameaux de laurier au congélateur
    name: 'Bay sprigs in the freezer',
    // FR: Dix minutes, et des feuilles qui ont le parfum du frais pour tes bouillons et tes pot-au-feu.
    description: 'Ten minutes, and leaves that smell fresh for your stocks and stews.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'a few sprigs of bay laurel', // FR: quelques rameaux de laurier-sauce
      'a zip-lock freezer bag', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les rameaux et essuie-les soigneusement avec un torchon.
      'Rinse the sprigs and dry them carefully with a tea towel.',
      // FR: Coupe-les en petits rameaux de quatre ou cinq feuilles, faciles à sortir un par un.
      'Cut them into small sprigs of four or five leaves, easy to take out one at a time.',
      // FR: Glisse-les dans le sac, chasse l'air, ferme et congèle à plat.
      'Slip them into the bag, press out the air, seal and freeze flat.',
      // FR: À l'usage, mets la feuille **encore gelée** dans la cocotte et retire-la avant de servir.
      'To use, put the leaf in the pot **still frozen** and take it out before serving.',
    ],
  ),
  'laurier_sauce/Vinaigre de cidre au laurier et poivre': RecipeText(
    // FR: Vinaigre de cidre au laurier et poivre
    name: 'Cider vinegar with bay and pepper',
    // FR: Un vinaigre chaud et boisé pour les lentilles, les marinades et les sauces au jus de viande.
    description: 'A warm, woody vinegar for lentils, marinades and meat gravies.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, away from light',
    ingredients: <String>[
      '10 dried bay leaves', // FR: 10 feuilles de laurier-sauce séchées
      '1 tsp black peppercorns', // FR: 1 cuillère à café de poivre noir en grains
      '75 cl cider vinegar at 6 % minimum', // FR: 75 cl de vinaigre de cidre à 6 % minimum
      'a clean bottle', // FR: une bouteille propre
    ],
    steps: <String>[
      // FR: Froisse légèrement les feuilles de laurier entre tes doigts pour libérer leur parfum.
      'Crumple the bay leaves lightly between your fingers to release their scent.',
      // FR: Glisse-les dans la bouteille avec le poivre en grains.
      'Slip them into the bottle with the peppercorns.',
      // FR: Fais chauffer le vinaigre jusqu'aux premiers frémissements, sans le faire bouillir.
      'Heat the vinegar until it just starts to tremble, without letting it boil.',
      // FR: Verse-le sur les feuilles avec un entonnoir : elles doivent être **entièrement couvertes**.
      'Pour it over the leaves with a funnel: they must be **completely covered**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en retournant la bouteille de temps en temps.
      'Close and leave to infuse for two weeks in the shade, turning the bottle over now and then.',
      // FR: Filtre, remets une feuille propre dans la bouteille pour le joli, et referme.
      'Strain, put a clean leaf back in the bottle for looks, and close again.',
    ],
  ),
  'laurier_sauce/Bouquet garni': RecipeText(
    // FR: Bouquet garni
    name: 'Bouquet garni',
    // FR: Thym, laurier, persil, ficelés ensemble. La base de tout.
    description: 'Thyme, bay and parsley tied together. The base of everything.',
  ),
  'laurier_sauce/Court-bouillon au laurier': RecipeText(
    // FR: Court-bouillon au laurier
    name: 'Bay court-bouillon',
    // FR: Pour pocher un poisson sans le dessécher.
    description: 'For poaching a fish without drying it out.',
  ),
  'laurier_sauce/Crème au laurier': RecipeText(
    // FR: Crème au laurier
    name: 'Bay cream',
    // FR: Infusé dans le lait chaud — un parfum inattendu en dessert.
    description: 'Infused in hot milk: an unexpected flavour in a dessert.',
  ),

  // ─────────── lavande (6 recettes) ───────────
  'lavande/Bouquets de lavande séchés pour la cuisine': RecipeText(
    // FR: Bouquets de lavande séchés pour la cuisine
    name: 'Dried lavender bunches for cooking',
    // FR: Cueillie en boutons et séchée à l'ombre, elle te donne des fleurs à cuisiner pour toute l'année.
    description: 'Picked in bud and dried in the shade, it gives you flowers to cook with all year round.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'stems of true lavender with half-open flower spikes', // FR: des tiges de lavande vraie aux épis à moitié ouverts
      'rubber bands', // FR: des élastiques
      'a sheet or a large piece of paper', // FR: un drap ou une grande feuille de papier
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Pour la cuisine, prends de la **lavande vraie**, pas du lavandin au goût camphré. Coupe quand un tiers des fleurs est ouvert, le matin après la rosée.
      'For cooking, use **true lavender**, not lavandin, which tastes of camphor. Cut when a third of the flowers are open, in the morning after the dew has dried.',
      // FR: Fais des bouquets d'une vingtaine de tiges serrés par un élastique : il suit les tiges quand elles rétrécissent.
      'Make bunches of about twenty stems held with a rubber band: it tightens as the stems shrink.',
      // FR: Suspends-les tête en bas dans un endroit sombre, sec et aéré, deux semaines.
      'Hang them upside down in a dark, dry, airy place for two weeks.',
      // FR: Égrène les épis au-dessus du drap en les frottant entre tes mains.
      'Rub the spikes between your hands over the sheet to strip off the flowers.',
      // FR: Passe les fleurs au tamis pour ôter les bouts de tige, puis mets-les en bocal.
      'Pass the flowers through a sieve to remove bits of stem, then put them in a jar.',
      // FR: Elle est très puissante : une demi-cuillère à café parfume tout un gâteau.
      'It is very strong: half a teaspoon flavours a whole cake.',
    ],
  ),
  'lavande/Gelée de lavande': RecipeText(
    // FR: Gelée de lavande
    name: 'Lavender jelly',
    // FR: Une gelée mauve et parfumée pour les tartines, le fromage de chèvre ou les sablés.
    description: 'A mauve, fragrant jelly for toast, goat\'s cheese or shortbread.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1 litre of pure apple juice', // FR: 1 litre de pur jus de pomme
      '2 tbsp dried lavender flowers', // FR: 2 cuillères à soupe de fleurs de lavande séchées
      'the juice of a lemon', // FR: le jus d'un citron
      '800 g of sugar', // FR: 800 g de sucre
      '1 sachet of pectin per 1 kg of fruit', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Fais frémir le jus de pomme puis coupe le feu.
      'Bring the apple juice to a simmer, then turn off the heat.',
      // FR: Ajoute la lavande, couvre et infuse **10 minutes**. Trop longtemps, elle a un goût de savon.
      'Add the lavender, cover and infuse for **10 minutes**. Any longer and it tastes of soap.',
      // FR: Filtre soigneusement : aucune fleur ne doit rester dans la gelée.
      'Strain carefully: no flower should be left in the jelly.',
      // FR: Ajoute le jus de citron, il ravive la couleur.
      'Add the lemon juice: it brightens the colour.',
      // FR: Incorpore la pectine mélangée à un peu de sucre, porte à ébullition, puis ajoute le reste du sucre.
      'Stir in the pectin mixed with a little sugar, bring to the boil, then add the rest of the sugar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Boil hard, stirring, for as long as the pectin packet says.',
      // FR: Verse en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into hot, scalded jars, close and turn them upside down until cool.',
    ],
  ),
  'lavande/Glaçons de lavande et citron': RecipeText(
    // FR: Glaçons de lavande et citron
    name: 'Lavender and lemon ice cubes',
    // FR: Un quart d'heure, et des cubes violets qui parfument limonades et eaux pétillantes tout l'été.
    description: 'A quarter of an hour, and purple cubes that scent lemonades and sparkling water all summer.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      'about ten fresh lavender spikes', // FR: une dizaine d'épis de lavande fraîche
      '1 unwaxed lemon', // FR: 1 citron non traité
      'water', // FR: de l'eau
      'two ice cube trays', // FR: deux bacs à glaçons
    ],
    steps: <String>[
      // FR: Rince les épis à l'eau froide et secoue-les.
      'Rinse the spikes in cold water and shake them dry.',
      // FR: Détache les fleurs des épis et prélève de fines lanières de zeste de citron.
      'Pull the flowers off the spikes and peel thin strips of lemon zest.',
      // FR: Mets quelques fleurs et un bout de zeste dans chaque case : **pas plus**, sinon la boisson devient savonneuse.
      'Put a few flowers and a bit of zest in each compartment: **no more**, or the drink turns soapy.',
      // FR: Verse l'eau froide à ras. Une eau bouillie puis refroidie donne des glaçons plus transparents.
      'Fill to the brim with cold water. Water that has been boiled and cooled gives clearer ice cubes.',
      // FR: Congèle jusqu'à ce que ce soit dur, puis démoule les glaçons dans un sac fermé.
      'Freeze until hard, then pop the cubes out into a sealed bag.',
    ],
  ),
  'lavande/Sucre à la lavande': RecipeText(
    // FR: Sucre à la lavande
    name: 'Lavender sugar',
    // FR: Fleurs séchées enfouies dans le sucre, deux semaines.
    description: 'Dried flowers buried in sugar for two weeks.',
  ),
  'lavande/Crème glacée à la lavande': RecipeText(
    // FR: Crème glacée à la lavande
    name: 'Lavender ice cream',
    // FR: Très peu de fleurs : elle vire vite au savon.
    description: 'Very few flowers: it turns soapy quickly.',
  ),
  'lavande/Miel de lavande maison': RecipeText(
    // FR: Miel de lavande maison
    name: 'Homemade lavender honey',
    // FR: Un miel neutre parfumé à froid par les fleurs.
    description: 'A mild honey scented cold by the flowers.',
  ),

  // ─────────── lentille (6 recettes) ───────────
  'lentille/Lentilles récoltées et séchées': RecipeText(
    // FR: Lentilles récoltées et séchées
    name: 'Harvested and dried lentils',
    // FR: Battues, triées et bien sèches, tes lentilles se gardent comme celles du commerce, sans un seul insecte.
    description: 'Threshed, sorted and properly dry, your lentils keep like shop-bought ones, without a single insect.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, safe from insects',
    ingredients: <String>[
      'lentil plants harvested when the pods are brown', // FR: les plants de lentilles récoltés quand les gousses sont brunes
      'a large sheet', // FR: un grand drap
      'very dry glass jars', // FR: des bocaux en verre bien secs
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Arrache les plants quand la plupart des gousses sont brunes et sonnent, et laisse-les finir de sécher une semaine à l'abri, sur un drap.
      'Pull up the plants when most of the pods are brown and rattle, and leave them to finish drying for a week under cover, on a sheet.',
      // FR: Bats les plants sur le drap ou piétine-les dans un sac : les gousses s'ouvrent et libèrent les graines.
      'Beat the plants on the sheet or stamp on them in a bag: the pods split open and release the seeds.',
      // FR: Vanne au vent ou devant un ventilateur, en versant d'un seau à l'autre, pour chasser les débris.
      'Winnow in the wind or in front of a fan, pouring from one bucket to another, to blow away the debris.',
      // FR: Trie à la main sur un plateau : retire cailloux, graines percées ou tachées.
      'Sort by hand on a tray: remove stones and any pierced or spotted seeds.',
      // FR: Étale les lentilles en couche fine et laisse-les sécher encore quelques jours : une graine prête **ne marque plus** sous la dent.
      'Spread the lentils in a thin layer and leave them to dry a few more days: a ready seed **leaves no mark** under the tooth.',
      // FR: Passe-les **3 jours au congélateur** en sacs : ça tue les œufs de bruche invisibles qui perceraient tes graines au placard.
      'Put them **3 days in the freezer** in bags: it kills the invisible bruchid beetle eggs that would otherwise bore into your seeds in the cupboard.',
      // FR: Laisse-les revenir à température ambiante dans le sac fermé, puis mets en bocaux hermétiques, au sec. Toujours cuites avant de manger.
      'Let them come back to room temperature in the closed bag, then put them in airtight jars, somewhere dry. Always cook them before eating.',
    ],
  ),
  'lentille/Lentilles précuites en portions': RecipeText(
    // FR: Lentilles précuites en portions
    name: 'Pre-cooked lentils in portions',
    // FR: Cuites al dente un quart d'heure et congelées à plat : une salade ou un plat mijoté prêt en cinq minutes.
    description: 'Cooked al dente for a quarter of an hour and frozen flat: a salad or a slow-cooked dish ready in five minutes.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of dried green lentils', // FR: 1 kg de lentilles vertes sèches
      '1 onion studded with a clove', // FR: 1 oignon piqué d'un clou de girofle
      '1 bay leaf', // FR: 1 feuille de laurier
      'salt', // FR: sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les lentilles à l'eau froide en retirant les petits cailloux.
      'Rinse the lentils in cold water, picking out any small stones.',
      // FR: Mets-les dans trois fois leur volume d'eau froide avec l'oignon et le laurier, **sans sel**, et cuis à petit frémissement.
      'Put them in three times their volume of cold water with the onion and bay leaf, **without salt**, and cook at a gentle simmer.',
      // FR: Sale en fin de cuisson : salées au départ, leur peau durcit. Arrête quand elles sont encore un peu fermes, elles finiront de cuire au réchauffage.
      'Salt at the end of cooking: salted at the start, their skins toughen. Stop while they are still a little firm: they will finish cooking when reheated.',
      // FR: Égoutte et rince-les à l'eau froide pour stopper la cuisson, puis égoutte bien.
      'Drain and rinse in cold water to stop the cooking, then drain well.',
      // FR: Répartis en sacs d'une portion, aplatis-les et date. Elles se réchauffent encore gelées, dans une sauce ou à la vapeur.
      'Divide into single-portion bags, flatten them and write the date. They reheat straight from frozen, in a sauce or steamed.',
    ],
  ),
  'lentille/Soupe de lentilles au cumin à congeler': RecipeText(
    // FR: Soupe de lentilles au cumin à congeler
    name: 'Cumin lentil soup to freeze',
    // FR: Une grande marmite pour la semaine et des portions au congélateur pour les soirs d'hiver.
    description: 'A big pot for the week and portions in the freezer for winter evenings.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '500 g of dried green lentils', // FR: 500 g de lentilles vertes sèches
      '2 carrots', // FR: 2 carottes
      '1 onion', // FR: 1 oignon
      '2 garlic cloves', // FR: 2 gousses d'ail
      '2 litres of stock', // FR: 2 litres de bouillon
      '1 tsp cumin, salt', // FR: 1 cuillère à café de cumin, sel
    ],
    steps: <String>[
      // FR: Rince les lentilles et retire les éventuels cailloux.
      'Rinse the lentils and remove any stones.',
      // FR: Coupe l'oignon et les carottes en petits dés, écrase l'ail.
      'Dice the onion and carrots small, crush the garlic.',
      // FR: Fais revenir l'oignon, les carottes, l'ail et le cumin dans un filet d'huile, 5 minutes.
      'Soften the onion, carrots, garlic and cumin in a drizzle of oil for 5 minutes.',
      // FR: Ajoute les lentilles et le bouillon, et laisse cuire à frémissement jusqu'à ce qu'elles soient fondantes.
      'Add the lentils and stock, and simmer until they are soft.',
      // FR: Mixe à moitié, pour garder des morceaux, puis sale.
      'Blend half of it, to keep some texture, then add salt.',
      // FR: Refroidis vite, casserole dans l'eau froide : une soupe tiède congelée fait de gros cristaux.
      'Cool it quickly, with the pan standing in cold water: a lukewarm soup that goes into the freezer forms big crystals.',
      // FR: Répartis en portions en laissant 2 cm de vide, ferme et date.
      'Divide into portions, leaving 2 cm of space, close and write the date.',
    ],
  ),
  'lentille/Salade de lentilles à l\'échalote': RecipeText(
    // FR: Salade de lentilles à l'échalote
    name: 'Lentil salad with shallot',
    // FR: Tièdes, vinaigrette moutardée, beaucoup d'échalote.
    description: 'Warm, with a mustard dressing and plenty of shallot.',
  ),
  'lentille/Petit salé aux lentilles': RecipeText(
    // FR: Petit salé aux lentilles
    name: 'Salt pork with lentils',
    // FR: Le plat du dimanche, qui mijote sans surveillance.
    description: 'The Sunday dish, which simmers away without watching.',
  ),
  'lentille/Dahl de lentilles corail': RecipeText(
    // FR: Dahl de lentilles corail
    name: 'Red lentil dahl',
    // FR: Coco, curcuma, gingembre — prêt en vingt minutes.
    description: 'Coconut, turmeric, ginger: ready in twenty minutes.',
  ),

  // ─────────── mache (5 recettes) ───────────
  'mache/Velouté de mâche à congeler': RecipeText(
    // FR: Velouté de mâche à congeler
    name: 'Lamb\'s lettuce soup to freeze',
    // FR: Une salade ne se conserve pas — son velouté, si. C'est la réponse pour toute feuille tendre.
    description: 'A salad cannot be kept, but its soup can. This is the answer for any tender leaf.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '600 g of lamb\'s lettuce', // FR: 600 g de mâche
      '4 potatoes', // FR: 4 pommes de terre
      '2 shallots', // FR: 2 échalotes
      '1.2 litres of stock', // FR: 1,2 litre de bouillon
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave la mâche dans plusieurs eaux : le sable reste au coeur des bouquets, et il ne part pas à la cuisson.
      'Wash the lamb\'s lettuce in several changes of water: the grit hides in the heart of the rosettes, and it will not go away in the cooking.',
      // FR: Cuis pommes de terre et échalotes en dés dans le bouillon, 15 minutes.
      'Cook the diced potatoes and shallots in the stock for 15 minutes.',
      // FR: Jette la mâche et compte **2 minutes**, pas plus. Au-delà, le vert tourne au kaki et ne revient jamais.
      'Add the lamb\'s lettuce and count **2 minutes**, no more. Any longer and the green turns khaki and never comes back.',
      // FR: Mixe aussitôt, hors du feu. **Sans crème** : elle tranche à la décongélation. Tu l'ajouteras dans l'assiette.
      'Blend straight away, off the heat. **No cream**: it splits when thawed. Add it in the bowl instead.',
      // FR: Refroidis vite — casserole dans l'eau froide. Un velouté tiède mis au congélateur fait de gros cristaux qui le rendent granuleux.
      'Cool it quickly, with the pan standing in cold water. A lukewarm soup put in the freezer forms big crystals that make it grainy.',
      // FR: Répartis en portions d'un repas, en laissant 2 cm de vide : ça gonfle en gelant. Note la date.
      'Divide into one-meal portions, leaving 2 cm of space: it expands as it freezes. Write the date.',
    ],
  ),
  'mache/Mâche blanchie congelée': RecipeText(
    // FR: Mâche blanchie congelée
    name: 'Blanched lamb\'s lettuce, frozen',
    // FR: Blanchie vingt secondes, essorée, congelée en boulettes : prête pour une omelette ou un gratin.
    description: 'Blanched for twenty seconds, squeezed dry and frozen in little balls: ready for an omelette or a gratin.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of lamb\'s lettuce', // FR: 1 kg de mâche
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Lave la mâche à fond et équeute les racines encore attachées.
      'Wash the lamb\'s lettuce thoroughly and trim off any roots still attached.',
      // FR: Porte une grande eau salée à gros bouillons. Beaucoup d'eau : elle ne doit pas refroidir quand tu jettes les feuilles.
      'Bring a large pan of salted water to a rolling boil. Plenty of water: it must not cool down when you drop the leaves in.',
      // FR: Plonge la mâche **20 secondes**, pas plus. Le blanchiment tue les enzymes qui jaunissent les feuilles au congélateur ; trop long, et il n'y a plus de feuille.
      'Plunge the lamb\'s lettuce in for **20 seconds**, no more. Blanching kills the enzymes that turn the leaves yellow in the freezer; too long, and there is no leaf left.',
      // FR: Sors-la et plonge-la aussitôt dans l'eau glacée. Ce choc fixe le vert.
      'Lift it out and plunge it straight into the iced water. This shock sets the green.',
      // FR: Presse-la en boule entre tes mains pour chasser l'eau — vraiment fort. L'eau qui reste devient du givre.
      'Squeeze it into a ball between your hands to drive out the water, really hard. Any water left turns to frost.',
      // FR: Forme des boulettes de la taille d'une portion, pose-les sur une plaque, congèle 2 heures, puis mets-les en sac.
      'Shape balls the size of a portion, set them on a tray, freeze for 2 hours, then put them in a bag.',
    ],
  ),
  'mache/Pesto de mâche en glaçons': RecipeText(
    // FR: Pesto de mâche en glaçons
    name: 'Lamb\'s lettuce pesto in ice cubes',
    // FR: Un quart d'heure, et des cubes verts à jeter dans des pâtes tout l'hiver.
    description: 'A quarter of an hour, and green cubes to toss into pasta all winter.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '300 g of lamb\'s lettuce', // FR: 300 g de mâche
      '60 g of hazelnuts or almonds', // FR: 60 g de noisettes ou d'amandes
      '80 g of Parmesan', // FR: 80 g de parmesan
      '1 garlic clove', // FR: 1 gousse d'ail
      '15 cl of olive oil, salt', // FR: 15 cl d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Fais torréfier les noisettes à sec 3 minutes : la mâche a un goût de noisette, on l'appuie.
      'Dry-toast the hazelnuts for 3 minutes: lamb\'s lettuce already tastes of hazelnut, so this leans into it.',
      // FR: Lave la mâche et **sèche-la bien**. De l'eau dans un pesto le fait tourner.
      'Wash the lamb\'s lettuce and **dry it well**. Water in a pesto makes it turn.',
      // FR: Mixe mâche, ail et noisettes par à-coups, pour ne pas chauffer et noircir les feuilles.
      'Blitz the lamb\'s lettuce, garlic and hazelnuts in short bursts, so they do not heat up and blacken the leaves.',
      // FR: Verse l'huile en filet. **Garde le parmesan de côté** : au congélateur il devient farineux, tu l'ajouteras au moment de servir.
      'Pour in the oil in a thin stream. **Keep the Parmesan aside**: in the freezer it turns floury, so add it when serving.',
      // FR: Remplis un bac à glaçons, un cube par portion de pâtes, et couvre d'un filet d'huile.
      'Fill an ice cube tray, one cube per portion of pasta, and cover with a thin film of oil.',
      // FR: Démoule les cubes une fois durs et garde-les en sac. Un cube fond directement dans les pâtes chaudes.
      'Pop the cubes out once hard and keep them in a bag. A cube melts straight into hot pasta.',
    ],
  ),
  'mache/Mâche, betterave et noix': RecipeText(
    // FR: Mâche, betterave et noix
    name: 'Lamb\'s lettuce, beetroot and walnuts',
    // FR: La salade d'hiver par excellence, trois ingrédients et c'est tout.
    description: 'The winter salad par excellence: three ingredients and that is all.',
    ingredients: <String>[
      '200 g of lamb\'s lettuce', // FR: 200 g de mâche
      '2 cooked beetroots', // FR: 2 betteraves cuites
      '60 g of walnut halves', // FR: 60 g de cerneaux de noix
      '1 tsp mustard', // FR: 1 cuillère à café de moutarde
      'cider vinegar, walnut oil, salt', // FR: vinaigre de cidre, huile de noix, sel
    ],
    steps: <String>[
      // FR: Lave la mâche dans plusieurs eaux : le sable reste au coeur des bouquets.
      'Wash the lamb\'s lettuce in several changes of water: the grit hides in the heart of the rosettes.',
      // FR: Sèche-la délicatement, elle s'écrase vite.
      'Dry it gently, it bruises easily.',
      // FR: Vinaigrette à la moutarde et à l'huile de noix.
      'Mustard and walnut oil dressing.',
      // FR: Dés de betterave, noix concassées, et mélange au dernier moment.
      'Diced beetroot, crushed walnuts, and toss at the last moment.',
    ],
  ),
  'mache/Mâche aux lardons et œuf poché': RecipeText(
    // FR: Mâche aux lardons et œuf poché
    name: 'Lamb\'s lettuce with bacon lardons and poached egg',
    // FR: Tiède, avec un jaune coulant qui fait la sauce.
    description: 'Warm, with a runny yolk that makes the sauce.',
    ingredients: <String>[
      '150 g of lamb\'s lettuce', // FR: 150 g de mâche
      '100 g of bacon lardons', // FR: 100 g de lardons
      '2 very fresh eggs', // FR: 2 oeufs très frais
      '1 tbsp vinegar', // FR: 1 cuillère à soupe de vinaigre
      'bread, oil, pepper', // FR: pain, huile, poivre
    ],
    steps: <String>[
      // FR: Fais dorer les lardons, réserve-les dans leur gras.
      'Brown the lardons and set them aside in their fat.',
      // FR: Fais griller des dés de pain dans la même poêle.
      'Toast diced bread in the same pan.',
      // FR: Casse les oeufs dans une eau frémissante vinaigrée, 3 minutes.
      'Break the eggs into simmering water with the vinegar, 3 minutes.',
      // FR: Mâche dans l'assiette, lardons et croûtons tièdes dessus.
      'Lamb\'s lettuce on the plate, warm lardons and croutons on top.',
      // FR: Pose l'oeuf, poivre, et perce-le à table.
      'Add the egg, pepper, and pierce it at the table.',
    ],
  ),

  // ─────────── mais (6 recettes) ───────────
  'mais/Grains de maïs doux au congélateur': RecipeText(
    // FR: Grains de maïs doux au congélateur
    name: 'Sweetcorn kernels in the freezer',
    // FR: Le maïs perd son sucre dans les heures qui suivent la cueillette : blanchi tout de suite, il le garde jusqu'à Noël.
    description: 'Corn loses its sugar within hours of picking: blanched straight away, it keeps it until Christmas.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '6 sweetcorn cobs picked the same day', // FR: 6 épis de maïs doux cueillis du jour
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les épis et retire toutes les soies, au besoin avec une brosse à légumes.
      'Husk the cobs and remove all the silks, with a vegetable brush if needed.',
      // FR: Plonge les épis entiers dans une grande casserole d'eau bouillante non salée : **4 minutes**.
      'Plunge the whole cobs into a large pan of unsalted boiling water: **4 minutes**.',
      // FR: Transfère-les dans l'eau glacée jusqu'à ce qu'ils soient froids à cœur, autant de temps que la cuisson.
      'Move them into the iced water until cold right through: about as long as they cooked.',
      // FR: Pose chaque épi debout dans un grand plat et égrène au couteau, de haut en bas, sans racler le cœur.
      'Stand each cob upright in a large dish and slice the kernels off with a knife, from top to bottom, without scraping the core.',
      // FR: Étale les grains sur une plaque, congèle 1 heure, puis verse en sac : ils restent bien séparés.
      'Spread the kernels on a tray, freeze for 1 hour, then pour into a bag: they stay nicely separate.',
    ],
  ),
  'mais/Relish de maïs et poivron': RecipeText(
    // FR: Relish de maïs et poivron
    name: 'Sweetcorn and pepper relish',
    // FR: Un condiment jaune et rouge, sucré-acidulé, qui transforme un hamburger ou une assiette de riz.
    description: 'A yellow and red condiment, sweet and sharp, that transforms a burger or a plate of rice.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      'the kernels of 6 sweetcorn cobs (about 800 g)', // FR: les grains de 6 épis de maïs (environ 800 g)
      '2 red peppers', // FR: 2 poivrons rouges
      '1 onion', // FR: 1 oignon
      '50 cl cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '150 g of sugar and 1 tbsp salt', // FR: 150 g de sucre et 1 cuillère à soupe de sel
      '1 tsp turmeric and 1 of mustard seeds', // FR: 1 cuillère à café de curcuma et 1 de graines de moutarde
    ],
    steps: <String>[
      // FR: Blanchis les épis 4 minutes, rafraîchis-les et égrène-les au couteau.
      'Blanch the cobs for 4 minutes, cool them and slice off the kernels with a knife.',
      // FR: Coupe les poivrons et l'oignon en petits dés, de la taille des grains.
      'Dice the peppers and onion small, the size of the kernels.',
      // FR: Porte le vinaigre, le sucre, le sel et les épices à ébullition. **Pas d'eau** : le relish reste bien acide.
      'Bring the vinegar, sugar, salt and spices to the boil. **No water**: the relish stays properly acidic.',
      // FR: Ajoute tous les légumes et laisse frémir en remuant de temps en temps.
      'Add all the vegetables and simmer, stirring now and then.',
      // FR: Remplis des bocaux propres jusqu'à 2 cm du bord, en tassant pour que le liquide **recouvre** les légumes.
      'Fill clean jars to 2 cm from the rim, pressing down so the liquid **covers** the vegetables.',
      // FR: Ferme, laisse refroidir et range au réfrigérateur. Il est meilleur après une semaine.
      'Close, leave to cool and store in the fridge. It is better after a week.',
    ],
  ),
  'mais/Maïs doux séché au four': RecipeText(
    // FR: Maïs doux séché au four
    name: 'Sweetcorn dried in the oven',
    // FR: Séchés, les grains deviennent de petites billes sucrées qui se gardent au placard et regonflent dans les soupes.
    description: 'Dried, the kernels become little sweet beads that keep in the cupboard and plump up again in soups.',
    // FR: 1 an au sec, en bocal fermé
    keeps: '1 year in a dry place, in a closed jar',
    ingredients: <String>[
      '12 sweetcorn cobs', // FR: 12 épis de maïs doux
      'baking parchment', // FR: du papier cuisson
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les épis et retire bien les soies.
      'Husk the cobs and remove the silks thoroughly.',
      // FR: Blanchis-les 4 minutes à l'eau bouillante : ça fixe le sucre avant le séchage.
      'Blanch them for 4 minutes in boiling water: it fixes the sugar before drying.',
      // FR: Rafraîchis-les dans l'eau glacée, égoutte, puis égrène au couteau.
      'Cool them in iced water, drain, then slice the kernels off with a knife.',
      // FR: Étale les grains en une seule couche sur des plaques couvertes de papier, four à **60 °C**, porte entrouverte avec une cuillère en bois.
      'Spread the kernels in a single layer on trays lined with paper, oven at **60 °C**, door held ajar with a wooden spoon.',
      // FR: Remue toutes les 2 heures. C'est prêt quand les grains sont durs, ridés et cassent net sous la dent.
      'Stir every 2 hours. They are ready when the kernels are hard, wrinkled and snap cleanly under the tooth.',
      // FR: Laisse refroidir complètement avant de les enfermer en bocal. Pour cuisiner : 2 heures de trempage, puis 30 minutes de cuisson.
      'Let them cool completely before sealing them in a jar. To cook: 2 hours of soaking, then 30 minutes of cooking.',
    ],
  ),
  'mais/Maïs grillé au beurre d\'herbes': RecipeText(
    // FR: Maïs grillé au beurre d'herbes
    name: 'Grilled corn with herb butter',
    // FR: Sur la braise, tourné souvent, badigeonné à la fin.
    description: 'Over the embers, turned often and brushed at the end.',
  ),
  'mais/Maïs grillé': RecipeText(
    // FR: Maïs grillé
    name: 'Grilled corn',
    // FR: L'épi grillé au feu de bois comme au bord de la route, un régal fumé.
    description: 'Corn on the cob grilled over a wood fire, roadside style: a smoky treat.',
  ),
  'mais/Bouillie de maïs': RecipeText(
    // FR: Bouillie de maïs
    name: 'Corn porridge',
    // FR: Une bouillie douce et crémeuse, sucrée juste ce qu'il faut pour le matin.
    description: 'A soft, creamy porridge, sweetened just enough for the morning.',
  ),

  // ─────────── manioc (6 recettes) ───────────
  'manioc/Manioc épluché congelé cru': RecipeText(
    // FR: Manioc épluché congelé cru
    name: 'Peeled cassava, frozen raw',
    // FR: Le manioc frais noircit en trois jours ; épluché et congelé, il attend des mois. À cuire toujours avant de manger.
    description: 'Fresh cassava turns black in three days; peeled and frozen, it waits for months. Always cook before eating.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 kg of fresh cassava', // FR: 2 kg de manioc frais
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les racines en tronçons de 8 cm. Fends la peau sur la longueur et soulève-la avec la lame : l'écorce et la couche rose partent ensemble.
      'Cut the roots into 8 cm pieces. Slit the skin lengthways and lift it away with the blade: the bark and the pink layer come off together.',
      // FR: Rince bien les tronçons et jette ceux qui ont des veines noires ou bleues.
      'Rinse the pieces well and throw away any with black or blue veins.',
      // FR: Sèche-les dans un torchon pour éviter le givre.
      'Dry them in a tea towel to avoid frost.',
      // FR: Mets-les en sacs par portions, chasse l'air et note la date.
      'Put them in bags in portions, press out the air and write the date.',
      // FR: Cuis-les **sans décongeler** dans l'eau bouillante salée, 25 à 30 minutes jusqu'à tendreté, puis retire la fibre centrale. **Jamais cru.**
      'Cook them **without thawing** in boiling salted water, 25 to 30 minutes until tender, then remove the central fibre. **Never raw.**',
    ],
  ),
  'manioc/Manioc précuit pour la poêle': RecipeText(
    // FR: Manioc précuit pour la poêle
    name: 'Pre-cooked cassava for the frying pan',
    // FR: Bouilli puis congelé, il ne reste qu'à le dorer : le manioc du soir en dix minutes.
    description: 'Boiled then frozen, it only needs browning: evening cassava in ten minutes.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of fresh cassava', // FR: 2 kg de manioc frais
      'coarse salt', // FR: gros sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche le manioc en enlevant toute l'écorce et la couche rose, coupe en tronçons de 6 cm.
      'Peel the cassava, removing all the bark and the pink layer, and cut into 6 cm pieces.',
      // FR: Cuis dans une grande eau salée jusqu'à ce que la chair s'entrouvre et devienne translucide.
      'Cook in plenty of salted water until the flesh splits open and turns translucent.',
      // FR: Égoutte, coupe chaque tronçon en deux et retire la **fibre centrale**, dure et filandreuse.
      'Drain, cut each piece in half and remove the **central fibre**, hard and stringy.',
      // FR: Laisse refroidir complètement à l'air, en une couche.
      'Leave to cool completely in the open air, in a single layer.',
      // FR: Congèle 2 heures sur plaque, puis mets en sacs.
      'Freeze for 2 hours on a tray, then put in bags.',
      // FR: Fais-les dorer encore gelés à la poêle ou à la friture, ou réchauffe-les à la vapeur.
      'Brown them still frozen in a frying pan or deep fat, or reheat them by steaming.',
    ],
  ),
  'manioc/Farine de manioc rouie': RecipeText(
    // FR: Farine de manioc rouie
    name: 'Retted cassava flour',
    // FR: Le trempage de plusieurs jours puis le séchage, c'est la méthode qui rend le manioc sûr et le garde un an.
    description: 'Soaking for several days then drying is the method that makes cassava safe and keeps it for a year.',
    // FR: 1 an au sec, à l'abri de l'humidité
    keeps: '1 year in a dry place, away from damp',
    ingredients: <String>[
      '3 kg of fresh cassava', // FR: 3 kg de manioc frais
      'a large bucket of clean water', // FR: un grand seau d'eau propre
      'a sturdy cloth', // FR: un torchon solide
      'an airtight jar or bucket', // FR: un bocal ou seau hermétique
    ],
    steps: <String>[
      // FR: Épluche le manioc en enlevant écorce et couche rose, coupe-le en gros tronçons.
      'Peel the cassava, removing the bark and the pink layer, and cut it into big pieces.',
      // FR: Mets-le à tremper dans un seau d'eau, bien couvert d'eau. **Change l'eau chaque jour.**
      'Put it to soak in a bucket of water, well covered. **Change the water every day.**',
      // FR: Laisse rouir 3 à 4 jours, jusqu'à ce que les morceaux s'écrasent sous le doigt. Sur un manioc amer, cette étape **n'est jamais facultative**.
      'Leave to ret for 3 to 4 days, until the pieces mash under your finger. With bitter cassava, this step is **never optional**.',
      // FR: Égoutte, retire les fibres, puis presse la pulpe dans un torchon pour chasser le maximum d'eau.
      'Drain, remove the fibres, then press the pulp in a cloth to squeeze out as much water as possible.',
      // FR: Émiette et sèche à 60 °C jusqu'à ce que ça soit cassant et sec, ou 2 à 3 jours au soleil.
      'Crumble and dry at 60 °C until brittle and dry, or 2 to 3 days in the sun.',
      // FR: Pile ou mixe, puis tamise finement.
      'Pound or blitz, then sift finely.',
      // FR: Stocke en bocal hermétique. La farine se cuit toujours dans l'eau bouillante en remuant avant de se manger.
      'Store in an airtight jar. The flour is always cooked in boiling water, stirring, before it is eaten.',
    ],
  ),
  'manioc/Attiéké': RecipeText(
    // FR: Attiéké
    name: 'Attiéké',
    // FR: La semoule de manioc ivoirienne, légère et acidulée, avec poisson braisé.
    description: 'The Ivorian cassava couscous, light and slightly tangy, with grilled fish.',
  ),
  'manioc/Foufou de manioc': RecipeText(
    // FR: Foufou de manioc
    name: 'Cassava fufu',
    // FR: La pâte de manioc pilée, souple et réconfortante, compagne de toutes les sauces.
    description: 'The pounded cassava dough, soft and comforting, the companion of every sauce.',
  ),
  'manioc/Frites de manioc': RecipeText(
    // FR: Frites de manioc
    name: 'Cassava chips',
    // FR: Des bâtonnets de manioc frits, croustillants dehors et fondants dedans.
    description: 'Fried cassava sticks, crisp outside and soft inside.',
  ),

  // ─────────── marjolaine (6 recettes) ───────────
  'marjolaine/Marjolaine séchée en petites bottes': RecipeText(
    // FR: Marjolaine séchée en petites bottes
    name: 'Marjoram dried in little bunches',
    // FR: Plus douce que l'origan, elle sèche aussi bien et parfume tes plats mijotés tout l'hiver.
    description: 'Milder than oregano, it dries just as well and flavours your slow-cooked dishes all winter.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'stems of marjoram just before flowering', // FR: des tiges de marjolaine juste avant la floraison
      'string', // FR: de la ficelle
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges à 5 cm du sol, en fin de matinée, quand les boutons floraux apparaissent.
      'Cut the stems 5 cm above the ground, late in the morning, when the flower buds appear.',
      // FR: Lie-les en petites bottes de la grosseur d'un pouce : trop serrées, elles noircissent au cœur.
      'Tie them in small bunches as thick as a thumb: too tight, and they blacken at the heart.',
      // FR: Suspends-les tête en bas à l'ombre, dans un endroit sec et aéré, une dizaine de jours.
      'Hang them upside down in the shade, in a dry, airy place, for about ten days.',
      // FR: Effeuille au-dessus d'un plateau quand les feuilles se brisent sous les doigts.
      'Strip the leaves over a tray when they crumble under your fingers.',
      // FR: Mets en bocal bien fermé et note la date : son parfum fléchit au bout d'un an.
      'Put them in a tightly closed jar and write the date: the scent fades after a year.',
    ],
  ),
  'marjolaine/Glaçons de marjolaine à l\'eau': RecipeText(
    // FR: Glaçons de marjolaine à l'eau
    name: 'Marjoram ice cubes in water',
    // FR: Des cubes parfumés à jeter dans une soupe ou une sauce, sans une goutte de gras.
    description: 'Fragrant cubes to drop into a soup or sauce, without a drop of fat.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 handfuls of marjoram leaves', // FR: 2 poignées de feuilles de marjolaine
      'water', // FR: de l'eau
      'an ice cube tray', // FR: un bac à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les tiges et égoutte-les.
      'Rinse the stems and drain them.',
      // FR: Effeuille et hache finement les feuilles.
      'Strip the leaves and chop them finely.',
      // FR: Remplis chaque case à moitié de marjolaine et couvre d'eau froide en tassant pour que tout baigne.
      'Fill each compartment halfway with marjoram and cover with cold water, pressing down so everything is submerged.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les en sac fermé.
      'Freeze until the cubes are hard, then pop them out into a sealed bag.',
      // FR: Ajoute un cube **en fin de cuisson** dans les soupes et les sauces : il fond en deux minutes.
      'Add a cube **at the end of cooking** to soups and sauces: it melts in two minutes.',
    ],
  ),
  'marjolaine/Herbes de Provence du jardin': RecipeText(
    // FR: Herbes de Provence du jardin
    name: 'Garden herbes de Provence',
    // FR: Ta marjolaine séchée avec le thym, la sarriette et le romarin : le mélange des grillades, sans rien acheter.
    description: 'Your dried marjoram with thyme, savory and rosemary: the grilling blend, without buying a thing.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      '4 tbsp dried marjoram', // FR: 4 cuillères à soupe de marjolaine séchée
      '4 tbsp dried thyme', // FR: 4 cuillères à soupe de thym séché
      '2 tbsp dried savory', // FR: 2 cuillères à soupe de sarriette séchée
      '1 tbsp dried rosemary', // FR: 1 cuillère à soupe de romarin séché
      '1 tbsp dried oregano', // FR: 1 cuillère à soupe d'origan séché
    ],
    steps: <String>[
      // FR: Fais sécher chaque herbe en petites bottes, à l'ombre et au sec, une dizaine de jours. Elles doivent toutes **casser net**.
      'Dry each herb in small bunches, in the shade and somewhere dry, for about ten days. They must all **snap cleanly**.',
      // FR: Effeuille-les une par une au-dessus d'un plateau et retire tous les bouts de tige.
      'Strip them one by one over a tray and remove every bit of stem.',
      // FR: Hache grossièrement les aiguilles de romarin, trop longues et dures entières.
      'Roughly chop the rosemary needles, too long and hard to use whole.',
      // FR: Mélange toutes les herbes dans un saladier en les froissant légèrement entre tes mains.
      'Mix all the herbs in a large bowl, crumpling them lightly between your hands.',
      // FR: Mets en bocal bien fermé, loin de la cuisinière et de la lumière.
      'Put in a tightly closed jar, away from the cooker and from light.',
    ],
  ),
  'marjolaine/Farce aux herbes': RecipeText(
    // FR: Farce aux herbes
    name: 'Herb stuffing',
    // FR: Plus douce que l'origan, idéale dans une farce de volaille.
    description: 'Milder than oregano, ideal in a poultry stuffing.',
  ),
  'marjolaine/Courgettes à la marjolaine': RecipeText(
    // FR: Courgettes à la marjolaine
    name: 'Courgettes with marjoram',
    // FR: Sautées, avec de l'ail et beaucoup d'herbe fraîche.
    description: 'Sautéed, with garlic and plenty of fresh herb.',
  ),
  'marjolaine/Beurre maître d\'hôtel aux herbes': RecipeText(
    // FR: Beurre maître d'hôtel aux herbes
    name: 'Herb maître d\'hôtel butter',
    // FR: Marjolaine, persil, citron.
    description: 'Marjoram, parsley, lemon.',
  ),

  // ─────────── melisse (6 recettes) ───────────
  'melisse/Feuilles de mélisse séchées': RecipeText(
    // FR: Feuilles de mélisse séchées
    name: 'Dried lemon balm leaves',
    // FR: Son parfum citronné est fragile : séchée vite et à l'ombre, elle se garde pour les infusions d'hiver.
    description: 'Its lemony scent is fragile: dried quickly and in the shade, it keeps for winter infusions.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      'lemon balm stems cut before flowering', // FR: des tiges de mélisse coupées avant la floraison
      'a rack or a tea towel', // FR: une claie ou un torchon
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges **avant la floraison**, en fin de matinée : après, les feuilles sentent moins le citron.
      'Cut the stems **before flowering**, late in the morning: afterwards the leaves smell less of lemon.',
      // FR: Détache les feuilles et étale-les en une seule couche sur la claie, sans les laver si elles sont propres.
      'Pull off the leaves and spread them in a single layer on the rack, without washing them if they are clean.',
      // FR: Laisse-les quatre à cinq jours à l'ombre dans une pièce chaude et aérée, ou quelques heures au déshydrateur à 35 °C.
      'Leave them four to five days in the shade in a warm, airy room, or a few hours in a dehydrator at 35 °C.',
      // FR: Elles sont prêtes quand elles craquent. Si elles noircissent, c'est qu'elles ont séché trop lentement.
      'They are ready when they crackle. If they turn black, they dried too slowly.',
      // FR: Mets-les en bocal **entières** et bien fermé, émiette-les seulement dans la théière.
      'Put them in a jar **whole** and tightly closed, and crumble them only in the teapot.',
    ],
  ),
  'melisse/Sirop de mélisse au citron': RecipeText(
    // FR: Sirop de mélisse au citron
    name: 'Lemon balm and lemon syrup',
    // FR: Infusée puis cuite au sucre, la mélisse se boit en sirop à l'eau fraîche jusqu'à l'été suivant.
    description: 'Infused then cooked with sugar, lemon balm can be drunk as a syrup in cold water until next summer.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '100 g of lemon balm leaves', // FR: 100 g de feuilles de mélisse
      '1 litre of water', // FR: 1 litre d'eau
      '1 kg of sugar', // FR: 1 kg de sucre
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '4 bottles of 25 cl with new caps or seals', // FR: 4 bouteilles de 25 cl avec capsules ou joints neufs
    ],
    steps: <String>[
      // FR: Rince les feuilles et froisse-les légèrement entre tes mains.
      'Rinse the leaves and crumple them lightly between your hands.',
      // FR: Porte l'eau à ébullition, verse-la sur les feuilles et couvre.
      'Bring the water to the boil, pour it over the leaves and cover.',
      // FR: Laisse infuser hors du feu, sans jamais faire bouillir la mélisse : elle perdrait son parfum.
      'Leave to infuse off the heat, never boiling the lemon balm: it would lose its scent.',
      // FR: Filtre en pressant bien les feuilles.
      'Strain, pressing the leaves well.',
      // FR: Ajoute le sucre et le jus de citron, porte à ébullition et laisse bouillir en écumant.
      'Add the sugar and the lemon juice, bring to the boil and boil, skimming.',
      // FR: Verse chaud dans les bouteilles propres jusqu'à 2 cm du bord, et ferme avec des capsules neuves.
      'Pour hot into the clean bottles up to 2 cm from the rim, and close with new caps.',
      // FR: Stérilise 20 minutes dans l'eau bouillante, bouteilles **entièrement couvertes**. Laisse refroidir dans l'eau.
      'Sterilise for 20 minutes in boiling water, bottles **completely covered**. Leave to cool in the water.',
      // FR: Vérifie que les capsules sont creusées. Sinon, garde la bouteille au réfrigérateur et bois-la vite.
      'Check that the caps are dipped inwards. If not, keep the bottle in the fridge and drink it soon.',
    ],
  ),
  'melisse/Glaçons de mélisse': RecipeText(
    // FR: Glaçons de mélisse
    name: 'Lemon balm ice cubes',
    // FR: Un quart d'heure, et la fraîcheur citronnée de la mélisse dans tes boissons d'été.
    description: 'A quarter of an hour, and the lemony freshness of lemon balm in your summer drinks.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 handfuls of lemon balm leaves', // FR: 2 poignées de feuilles de mélisse
      'water', // FR: de l'eau
      'two ice cube trays', // FR: deux bacs à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les feuilles et égoutte-les.
      'Rinse the leaves and drain them.',
      // FR: Cisèle-les grossièrement, ou garde de petites feuilles entières pour le joli.
      'Chop them roughly, or keep small whole leaves for looks.',
      // FR: Remplis chaque case à moitié de feuilles, puis complète d'eau froide.
      'Fill each compartment halfway with leaves, then top up with cold water.',
      // FR: Congèle jusqu'à ce que ce soit dur, démoule et garde-les en sac fermé.
      'Freeze until hard, pop them out and keep them in a sealed bag.',
      // FR: Jette-les dans l'eau, la citronnade ou une salade de fruits. Pour une infusion, jette deux cubes dans l'eau chaude.
      'Drop them into water, lemonade or a fruit salad. For an infusion, drop two cubes into hot water.',
    ],
  ),
  'melisse/Infusion de mélisse': RecipeText(
    // FR: Infusion de mélisse
    name: 'Lemon balm infusion',
    // FR: Citronnée et apaisante, fraîche ou séchée.
    description: 'Lemony and soothing, fresh or dried.',
  ),
  'melisse/Limonade à la mélisse': RecipeText(
    // FR: Limonade à la mélisse
    name: 'Lemon balm lemonade',
    // FR: Feuilles froissées dans l'eau pétillante et le citron.
    description: 'Crumpled leaves in sparkling water and lemon.',
  ),
  'melisse/Salade de fruits à la mélisse': RecipeText(
    // FR: Salade de fruits à la mélisse
    name: 'Fruit salad with lemon balm',
    // FR: Ciselée fin, elle remplace la menthe avec plus de douceur.
    description: 'Finely shredded, it replaces mint, more gently.',
  ),

  // ─────────── melon (6 recettes) ───────────
  'melon/Billes de melon congelées': RecipeText(
    // FR: Billes de melon congelées
    name: 'Frozen melon balls',
    // FR: Quand tous les melons mûrissent la même semaine : en billes congelées, ils finissent en smoothies et sorbets minute.
    description: 'When all the melons ripen in the same week: as frozen balls, they end up as smoothies and instant sorbets.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '3 very ripe melons', // FR: 3 melons bien mûrs
      'the juice of a lemon', // FR: le jus d'un citron
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave et essuie l'écorce avant de couper : le couteau porte sinon la terre jusque dans la chair.
      'Wash and wipe the rind before cutting: otherwise the knife carries soil into the flesh.',
      // FR: Coupe les melons en deux, retire les graines et forme des billes à la cuillère parisienne, ou taille des cubes.
      'Cut the melons in half, remove the seeds and scoop out balls with a melon baller, or cut cubes.',
      // FR: Arrose d'un filet de citron et mélange délicatement.
      'Drizzle with a little lemon juice and toss gently.',
      // FR: Étale sur une plaque **sans qu'elles se touchent** et congèle 3 heures.
      'Spread on a tray **without letting them touch** and freeze for 3 hours.',
      // FR: Verse-les en sacs une fois dures. Décongelées elles sont molles : mixe-les encore gelées en smoothie ou en granité.
      'Pour them into bags once hard. Thawed, they are soft: blend them still frozen into a smoothie or a granita.',
    ],
  ),
  'melon/Confiture de melon à l\'orange': RecipeText(
    // FR: Confiture de melon à l'orange
    name: 'Melon and orange jam',
    // FR: La confiture du Midi : le melon macéré au sucre et relevé d'orange et de citron, pour les tartines d'hiver.
    description: 'The jam of the South of France: melon macerated in sugar and lifted with orange and lemon, for winter toast.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '1.5 kg of melon flesh', // FR: 1,5 kg de chair de melon
      '1 kg of sugar', // FR: 1 kg de sucre
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '1 unwaxed orange', // FR: 1 orange non traitée
    ],
    steps: <String>[
      // FR: Épluche les melons, retire les graines et coupe la chair en petits dés. Coupe l'orange en très fines tranches.
      'Peel the melons, remove the seeds and cut the flesh into small dice. Cut the orange into very thin slices.',
      // FR: Mélange melon, orange, sucre et jus de citron, couvre et laisse macérer une nuit au frais.
      'Mix the melon, orange, sugar and lemon juice, cover and leave to macerate overnight somewhere cool.',
      // FR: Porte à ébullition, puis cuis à feu moyen en remuant souvent et en écumant.
      'Bring to the boil, then cook over medium heat, stirring often and skimming.',
      // FR: Ne lésine pas sur le citron : le melon est peu acide, c'est le citron qui **fait prendre et qui conserve**.
      'Do not skimp on the lemon: melon is low in acid, and it is the lemon that **sets it and preserves it**.',
      // FR: Teste sur une assiette froide : la goutte doit se figer. Le melon est long à prendre, sois patient.
      'Test on a cold plate: the drop should set. Melon is slow to set, so be patient.',
      // FR: Mets en pots ébouillantés remplis à 1 cm du bord, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pour into scalded jars filled to 1 cm from the rim, close at once and turn upside down until cool.',
    ],
  ),
  'melon/Lamelles de melon séchées': RecipeText(
    // FR: Lamelles de melon séchées
    name: 'Dried melon slices',
    // FR: Séché doucement, le melon devient une friandise souple et très sucrée pour les goûters.
    description: 'Dried gently, melon becomes a soft, very sweet treat for snack time.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      '2 ripe but firm melons', // FR: 2 melons bien mûrs mais fermes
      'baking parchment', // FR: du papier cuisson
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Épluche les melons, retire les graines et coupe la chair en lamelles régulières de 5 mm.
      'Peel the melons, remove the seeds and cut the flesh into even slices of 5 mm.',
      // FR: Tamponne les lamelles dans un torchon pour enlever le jus de surface.
      'Pat the slices in a tea towel to remove the surface juice.',
      // FR: Étale-les sur les plaques sans qu'elles se touchent et sèche au four à **60 °C**, porte entrouverte, ou au déshydrateur.
      'Spread them on the trays without letting them touch and dry in the oven at **60 °C**, door held ajar, or in a dehydrator.',
      // FR: Retourne-les à mi-séchage. Elles sont prêtes quand elles sont **souples comme du cuir**, sans aucune humidité au centre.
      'Turn them halfway through. They are ready when they are **supple like leather**, with no moisture at all in the middle.',
      // FR: Laisse refroidir, mets en bocal et secoue chaque jour la première semaine. De la buée ? Remets-les au four.
      'Leave to cool, put in a jar and shake it every day for the first week. Any condensation? Put them back in the oven.',
    ],
  ),
  'melon/Melon au jambon cru': RecipeText(
    // FR: Melon au jambon cru
    name: 'Melon with Parma ham',
    // FR: Le sucré et le salé, l'été, sans rien cuire.
    description: 'Sweet and salty, in summer, with no cooking.',
  ),
  'melon/Soupe froide melon-menthe': RecipeText(
    // FR: Soupe froide melon-menthe
    name: 'Cold melon and mint soup',
    // FR: Mixé, bien glacé, un tour de poivre du moulin.
    description: 'Blended, well chilled, with a turn of the pepper mill.',
  ),
  'melon/Melon en salade au chèvre frais': RecipeText(
    // FR: Melon en salade au chèvre frais
    name: 'Melon salad with fresh goat\'s cheese',
    // FR: Avec de la roquette et des pignons grillés.
    description: 'With rocket and toasted pine nuts.',
  ),

  // ─────────── menthe (6 recettes) ───────────
  'menthe/Glaçons de menthe': RecipeText(
    // FR: Glaçons de menthe
    name: 'Mint ice cubes',
    // FR: Les feuilles prises dans la glace gardent leur vert : un cube pour une limonade, trois pour une sauce au yaourt.
    description: 'Leaves caught in ice keep their green: one cube for a lemonade, three for a yoghurt sauce.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '4 good handfuls of mint', // FR: 4 belles poignées de menthe
      'water', // FR: de l'eau
      'ice cube trays', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Rince les tiges et effeuille-les. Jette les feuilles tachées ou abîmées.
      'Rinse the stems and pull off the leaves. Throw away any spotted or damaged leaves.',
      // FR: Hache grossièrement les feuilles, ou laisse-les entières pour les boissons.
      'Roughly chop the leaves, or leave them whole for drinks.',
      // FR: Remplis les bacs aux deux tiers de feuilles et couvre d'eau froide, en appuyant pour **noyer** les feuilles.
      'Fill the trays two-thirds full of leaves and cover with cold water, pressing down to **drown** the leaves.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les dans un sac bien fermé.
      'Freeze until the cubes are hard, then pop them out into a tightly closed bag.',
    ],
  ),
  'menthe/Menthe séchée en bouquets': RecipeText(
    // FR: Menthe séchée en bouquets
    name: 'Mint dried in bunches',
    // FR: Pendue tête en bas dans un coin sec, la menthe sèche toute seule et parfume le thé tout l'hiver.
    description: 'Hung upside down in a dry corner, mint dries all by itself and scents your tea all winter.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'about ten bunches of mint', // FR: une dizaine de bouquets de menthe
      'string or rubber bands', // FR: de la ficelle ou des élastiques
      'paper bags', // FR: des sacs en papier
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les tiges le matin, une fois la rosée partie et **avant la floraison** : c'est là qu'elles ont le plus d'arôme.
      'Cut the stems in the morning, once the dew has gone and **before flowering**: that is when they have the most aroma.',
      // FR: Ne les lave que si elles sont terreuses, et sèche-les alors très bien : l'humidité les fait moisir.
      'Wash them only if they are muddy, and then dry them very well: damp makes them go mouldy.',
      // FR: Fais de petits bouquets d'une dizaine de tiges, liés serré : les tiges rétrécissent en séchant.
      'Make small bunches of about ten stems, tied tight: the stems shrink as they dry.',
      // FR: Pends-les tête en bas dans un endroit sec, aéré et sombre, dans un sac en papier percé contre la poussière.
      'Hang them upside down somewhere dry, airy and dark, inside a paper bag with holes punched in it to keep the dust off.',
      // FR: Quand les feuilles craquent sous les doigts, effeuille-les au-dessus d'une feuille de papier. Garde les feuilles entières.
      'When the leaves crackle under your fingers, strip them over a sheet of paper. Keep the leaves whole.',
      // FR: Mets-les en bocal fermé, au placard. Émiette-les seulement au moment de t'en servir.
      'Put them in a closed jar, in the cupboard. Crumble them only when you use them.',
    ],
  ),
  'menthe/Gelée de pomme à la menthe': RecipeText(
    // FR: Gelée de pomme à la menthe
    name: 'Apple and mint jelly',
    // FR: Les pommes donnent la prise, la menthe donne tout le reste : la gelée qui accompagne l'agneau.
    description: 'The apples give the set, the mint gives everything else: the jelly that goes with lamb.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '1.5 kg of tart apples', // FR: 1,5 kg de pommes acides
      '1 litre of water', // FR: 1 litre d'eau
      'a big handful of mint', // FR: une grosse poignée de menthe
      'about 750 g of sugar', // FR: environ 750 g de sucre
      'the juice of a lemon', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Coupe les pommes en quartiers **sans les éplucher ni les épépiner** : la pectine est dans la peau et les pépins.
      'Cut the apples into quarters **without peeling or deseeding them**: the pectin is in the skin and the pips.',
      // FR: Cuis-les à couvert avec l'eau et la moitié de la menthe, jusqu'à ce qu'elles soient en bouillie.
      'Cook them covered with the water and half the mint, until they are mushy.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse couler le jus sans presser, sinon la gelée sera trouble.
      'Pour into a clean cloth set over a sieve and let the juice drip through without pressing, or the jelly will be cloudy.',
      // FR: Pèse le jus et ajoute **750 g de sucre par litre**, plus le citron.
      'Weigh the juice and add **750 g of sugar per litre**, plus the lemon.',
      // FR: Fais bouillir à feu vif en écumant, jusqu'à ce qu'une goutte se fige sur une assiette froide.
      'Boil over high heat, skimming, until a drop sets on a cold plate.',
      // FR: Hors du feu, ajoute le reste de menthe hachée très fin et remue.
      'Off the heat, add the rest of the mint, very finely chopped, and stir.',
      // FR: Mets en pots ébouillantés remplis à ras, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pour into scalded jars filled to the brim, close at once and turn upside down until cool.',
    ],
  ),
  'menthe/Thé à la menthe': RecipeText(
    // FR: Thé à la menthe
    name: 'Mint tea',
    // FR: Thé vert, bouquet entier, trois sucres. Versé de haut.
    description: 'Green tea, a whole bunch, three sugars. Poured from a height.',
  ),
  'menthe/Taboulé à la menthe': RecipeText(
    // FR: Taboulé à la menthe
    name: 'Mint tabbouleh',
    // FR: Plus de persil et de menthe que de semoule.
    description: 'More parsley and mint than bulgur.',
  ),
  'menthe/Ataya': RecipeText(
    // FR: Ataya
    name: 'Ataya',
    // FR: Le thé à la menthe mousseux, préparé en trois services entre amis, sans se presser.
    description: 'Frothy mint tea, made in three rounds among friends, without hurrying.',
  ),

  // ─────────── mil (6 recettes) ───────────
  'mil/Mil séché en épis et battu': RecipeText(
    // FR: Mil séché en épis et battu
    name: 'Millet dried on the head and threshed',
    // FR: Bien sec et bien protégé, le grain de mil tient jusqu'à la récolte suivante.
    description: 'Properly dry and well protected, millet grain lasts until the next harvest.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, safe from insects',
    ingredients: <String>[
      'millet heads cut when ripe', // FR: les épis de mil coupés à maturité
      'a tarpaulin or a clean sheet', // FR: une bâche ou un drap propre
      'a stick or a pestle', // FR: un bâton ou un pilon
      'airtight sacks or drums', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Coupe les épis quand le grain est dur sous l'ongle et que la tige jaunit.
      'Cut the heads when the grain is hard under the nail and the stalk is turning yellow.',
      // FR: Étale-les sur une bâche au soleil une semaine, en les rentrant chaque soir à l'abri de la rosée.
      'Spread them on a tarpaulin in the sun for a week, bringing them in each evening, away from the dew.',
      // FR: Teste : un grain croqué doit casser net, pas s'écraser. Sinon, encore deux jours.
      'Test: a grain you bite should snap cleanly, not squash. If not, two more days.',
      // FR: Bats les épis au bâton sur la bâche, ou frotte-les entre les mains pour faire tomber le grain.
      'Beat the heads with a stick on the tarpaulin, or rub them between your hands to loosen the grain.',
      // FR: Vanne par vent léger en versant le grain de haut : les balles s'envolent, le grain lourd reste.
      'Winnow in a light wind, pouring the grain from a height: the chaff blows away, the heavy grain stays.',
      // FR: Passe le grain **3 jours au congélateur** ou bien au soleil brûlant : ça tue les œufs de charançon.
      'Put the grain **3 days in the freezer** or in the blazing sun: it kills weevil eggs.',
      // FR: Stocke dans des sacs ou fûts hermétiques bien remplis, au frais et au sec, surélevés du sol.
      'Store in well-filled airtight sacks or drums, somewhere cool and dry, raised off the ground.',
    ],
  ),
  'mil/Grains de mil passés au froid': RecipeText(
    // FR: Grains de mil passés au froid
    name: 'Millet grains put through the cold',
    // FR: Un quart d'heure pour mettre ton mil à l'abri des charançons et du rance, prêt à piler à la demande.
    description: 'A quarter of an hour to protect your millet from weevils and rancidity, ready to pound on demand.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'threshed, very dry millet', // FR: du mil battu et bien sec
      'thick freezer bags', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Étale le grain sur un plateau et retire petits cailloux, balles et grains noircis.
      'Spread the grain on a tray and remove small stones, chaff and blackened grains.',
      // FR: Remplis des sacs par portions d'un repas, chasse l'air et ferme bien.
      'Fill bags in one-meal portions, press out the air and seal well.',
      // FR: Congèle à plat. Le froid tue les insectes et les œufs en 3 jours, et le grain ne bouge plus ensuite.
      'Freeze flat. The cold kills insects and their eggs in 3 days, and after that the grain no longer changes.',
      // FR: Avant de piler, laisse le sac fermé revenir à température 2 heures : ouvert froid, le grain prend l'humidité.
      'Before pounding, leave the closed bag to come up to temperature for 2 hours: opened cold, the grain picks up moisture.',
    ],
  ),
  'mil/Farine de mil maison': RecipeText(
    // FR: Farine de mil maison
    name: 'Homemade millet flour',
    // FR: Lavée, séchée, pilée : la farine prête pour la bouillie du matin. Elle rancit vite, alors on la garde au froid.
    description: 'Washed, dried, pounded: the flour is ready for morning porridge. It goes rancid fast, so keep it cold.',
    // FR: 1 mois au sec, 6 mois au congélateur
    keeps: '1 month in a dry place, 6 months in the freezer',
    ingredients: <String>[
      '1 kg of hulled millet', // FR: 1 kg de mil décortiqué
      'clean water', // FR: de l'eau propre
      'a fine sieve', // FR: un tamis fin
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le mil dans plusieurs eaux en le frottant, jusqu'à ce que l'eau reste claire. Les cailloux restent au fond.
      'Wash the millet in several changes of water, rubbing it, until the water stays clear. Stones stay at the bottom.',
      // FR: Laisse-le tremper 1 heure puis égoutte bien dans une passoire.
      'Leave it to soak for 1 hour, then drain well in a colander.',
      // FR: Pile ou mixe le grain encore humide par petites quantités.
      'Pound or blitz the still-damp grain in small batches.',
      // FR: Passe au tamis fin et repile ce qui reste dessus.
      'Pass through a fine sieve and pound again what is left on top.',
      // FR: Étale la farine en couche mince et sèche au four à 50 °C ou au soleil, en émiettant les grumeaux.
      'Spread the flour in a thin layer and dry in the oven at 50 °C or in the sun, breaking up the lumps.',
      // FR: Mets-la en sacs : un mois au sec dans un bocal, six mois au congélateur. **Jette-la si elle sent l'amer.**
      'Put it in bags: one month in a dry place in a jar, six months in the freezer. **Throw it away if it smells bitter.**',
    ],
  ),
  'mil/Tô de mil': RecipeText(
    // FR: Tô de mil
    name: 'Millet tô',
    // FR: La pâte de mil du Sahel, servie brûlante avec une sauce gombo ou feuilles.
    description: 'The millet dough of the Sahel, served piping hot with an okra or leaf sauce.',
  ),
  'mil/Thiakry': RecipeText(
    // FR: Thiakry
    name: 'Thiakry',
    // FR: Le couscous de mil sucré au lait caillé, un dessert frais et gourmand.
    description: 'Millet couscous sweetened with curdled milk, a fresh and indulgent dessert.',
  ),
  'mil/Couscous de mil': RecipeText(
    // FR: Couscous de mil
    name: 'Millet couscous',
    // FR: Le thiéré sénégalais, une semoule de mil vapeur qui accompagne les sauces du soir.
    description: 'The Senegalese thiéré, a steamed millet semolina that goes with evening sauces.',
  ),

  // ─────────── moringa (6 recettes) ───────────
  'moringa/Feuilles de moringa séchées à l\'ombre': RecipeText(
    // FR: Feuilles de moringa séchées à l'ombre
    name: 'Moringa leaves dried in the shade',
    // FR: Séchées à l'ombre, les folioles restent bien vertes et s'émiettent dans les sauces toute l'année.
    description: 'Dried in the shade, the leaflets stay nice and green and crumble into sauces all year.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      'leafy moringa branches', // FR: des branches de moringa feuillues
      'a clean sheet or racks', // FR: un drap propre ou des claies
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Rince les branches entières à grande eau et secoue-les.
      'Rinse the whole branches under plenty of water and shake them dry.',
      // FR: Suspends-les en bouquets ou étale-les à l'**ombre**, dans un endroit aéré. Le soleil direct les jaunit.
      'Hang them in bunches or spread them out in the **shade**, somewhere airy. Direct sun turns them yellow.',
      // FR: Quand les folioles craquent sous les doigts, fais-les tomber en passant la main le long des tiges.
      'When the leaflets crackle under your fingers, strip them off by running your hand down the stems.',
      // FR: Retire les petites tiges et les folioles jaunes ou noires.
      'Remove the small stems and any yellow or black leaflets.',
      // FR: Garde-les entières en bocal hermétique : elles gardent mieux leur goût qu'en poudre. Émiette au moment de cuisiner.
      'Keep them whole in an airtight jar: they hold their flavour better than as a powder. Crumble when you cook.',
    ],
  ),
  'moringa/Moringa blanchi au congélateur': RecipeText(
    // FR: Moringa blanchi au congélateur
    name: 'Blanched moringa in the freezer',
    // FR: Une minute dans l'eau bouillante, et les folioles gardent leur vert pour les soupes et les sauces de l'hiver.
    description: 'One minute in boiling water, and the leaflets keep their green for winter soups and sauces.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of moringa leaflets', // FR: 1 kg de folioles de moringa
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Détache les folioles des tiges en faisant glisser tes doigts le long de chaque rameau.
      'Pull the leaflets off the stems by sliding your fingers along each sprig.',
      // FR: Lave-les dans plusieurs eaux et égoutte.
      'Wash them in several changes of water and drain.',
      // FR: Plonge-les dans une grande eau bouillante salée, à gros bouillons.
      'Plunge them into a large pan of salted water at a rolling boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer le vert.
      'Drain and plunge straight into the iced water to fix the green.',
      // FR: Presse-les en boule entre tes mains, vraiment fort, pour chasser l'eau.
      'Squeeze them into a ball between your hands, really hard, to drive out the water.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque puis mets-les en sac.
      'Shape portion-sized balls, freeze them for 2 hours on a tray, then put them in a bag.',
    ],
  ),
  'moringa/Folioles de moringa congelées crues': RecipeText(
    // FR: Folioles de moringa congelées crues
    name: 'Moringa leaflets frozen raw',
    // FR: Vingt minutes et c'est rangé : pour les sauces mijotées, le moringa cru congelé fait très bien l'affaire.
    description: 'Twenty minutes and it is put away: for slow-cooked sauces, raw frozen moringa does the job very well.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      'fresh moringa leaflets', // FR: des folioles de moringa fraîches
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrène les folioles des tiges et jette celles qui jaunissent.
      'Strip the leaflets from the stems and throw away any that are turning yellow.',
      // FR: Lave-les et **sèche-les à fond** dans un torchon ou une essoreuse à salade.
      'Wash them and **dry them thoroughly** in a tea towel or a salad spinner.',
      // FR: Mets-les en sacs par poignées d'une portion, à plat, en chassant l'air.
      'Put them in bags in portion-sized handfuls, flat, pressing out the air.',
      // FR: Jette-les **encore gelées** dans la sauce chaude en fin de cuisson : décongelées, elles s'écrasent.
      'Drop them in **still frozen** to the hot sauce at the end of cooking: thawed, they turn to mush.',
    ],
  ),
  'moringa/Poudre de moringa': RecipeText(
    // FR: Poudre de moringa
    name: 'Moringa powder',
    // FR: Feuilles séchées à l'ombre et pilées, à saupoudrer sur tout.
    description: 'Leaves dried in the shade and pounded, to sprinkle on everything.',
  ),
  'moringa/Soupe de moringa': RecipeText(
    // FR: Soupe de moringa
    name: 'Moringa soup',
    // FR: Un bouillon vert aux feuilles fraîches de moringa, léger et plein de vitamines.
    description: 'A green broth of fresh moringa leaves, light and full of vitamins.',
  ),
  'moringa/Sauce feuilles de moringa': RecipeText(
    // FR: Sauce feuilles de moringa
    name: 'Moringa leaf sauce',
    // FR: Les feuilles mijotées en sauce, un classique nourrissant du Sahel.
    description: 'The leaves simmered into a sauce, a nourishing classic of the Sahel.',
  ),

  // ─────────── murier (6 recettes) ───────────
  'murier/Mûres congelées sur plaque': RecipeText(
    // FR: Mûres congelées sur plaque
    name: 'Blackberries frozen on a tray',
    // FR: Un quart d'heure au retour de cueillette, et tu as des mûres pour les crumbles jusqu'au printemps.
    description: 'A quarter of an hour when you get back from picking, and you have blackberries for crumbles until spring.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg of blackberries', // FR: 1 kg de mûres
      'freezer bags or boxes', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie les mûres, retire les queues et écarte celles qui sont moisies ou encore rouges.
      'Sort the blackberries, remove the stalks and set aside any that are mouldy or still red.',
      // FR: Rince-les très rapidement, seulement si elles sont sales, puis sèche-les à plat sur un torchon.
      'Rinse them very quickly, only if they are dirty, then dry them flat on a tea towel.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Spread them on a tray without letting them touch and freeze for 2 hours.',
      // FR: Mets-les en boîte une fois dures : elles restent entières et se prennent à la poignée.
      'Put them in a box once hard: they stay whole and you can take them by the handful.',
    ],
  ),
  'murier/Gelée de mûres sans pépins': RecipeText(
    // FR: Gelée de mûres sans pépins
    name: 'Seedless blackberry jelly',
    // FR: La mûre a beaucoup de pépins et peu de pectine : passée et citronnée, elle donne une gelée noire et brillante.
    description: 'Blackberries have lots of seeds and little pectin: sieved and lemony, they give a glossy black jelly.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '2 kg of blackberries', // FR: 2 kg de mûres
      '10 cl of water', // FR: 10 cl d'eau
      '750 g of sugar per litre of juice', // FR: 750 g de sucre par litre de jus
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '6 jam jars', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Cuis les mûres avec l'eau à couvert, en écrasant, jusqu'à ce qu'elles soient en bouillie.
      'Cook the blackberries with the water, covered, crushing them, until they are mushy.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse doucement.
      'Pour into a clean cloth set over a sieve and leave to drip, then press gently.',
      // FR: Mesure le jus, ajoute 750 g de sucre par litre et le jus des citrons : **sans citron, la gelée ne prend pas**.
      'Measure the juice, add 750 g of sugar per litre and the juice of the lemons: **without lemon, the jelly will not set**.',
      // FR: Porte à ébullition et cuis à gros bouillons en écumant.
      'Bring to the boil and boil hard, skimming.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. Sinon, deux minutes de plus.
      'Test on a cold plate: a drop that sets is ready. If not, two more minutes.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars, close and turn upside down until cool.',
    ],
  ),
  'murier/Cuir de mûres et pommes': RecipeText(
    // FR: Cuir de mûres et pommes
    name: 'Blackberry and apple leather',
    // FR: Une purée étalée et séchée au four : des rouleaux de fruits à glisser dans le cartable.
    description: 'A purée spread out and dried in the oven: fruit rolls to slip into a school bag.',
    // FR: 3 mois en bocal, au sec
    keeps: '3 months in a jar, in a dry place',
    ingredients: <String>[
      '500 g of blackberries', // FR: 500 g de mûres
      '3 apples', // FR: 3 pommes
      '2 tbsp honey', // FR: 2 cuillères à soupe de miel
      'baking parchment', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Épluche et épépine les pommes, coupe-les en dés : elles apportent la tenue que la mûre n'a pas.
      'Peel and core the apples and dice them: they give the body that blackberries lack.',
      // FR: Cuis pommes et mûres à couvert, à feu doux, jusqu'à ce que tout s'écrase.
      'Cook the apples and blackberries covered over low heat until everything mashes down.',
      // FR: Passe au moulin à légumes grille fine pour retirer les pépins, puis ajoute le miel.
      'Pass through a food mill with the fine disc to remove the seeds, then add the honey.',
      // FR: Étale la purée sur une plaque couverte de papier cuisson, en couche **régulière de 4 mm**.
      'Spread the purée on a tray lined with baking parchment, in an **even layer 4 mm thick**.',
      // FR: Sèche au four à **60 °C**, porte entrouverte : c'est prêt quand le centre ne colle plus au doigt.
      'Dry in the oven at **60 °C**, door held ajar: it is ready when the centre no longer sticks to your finger.',
      // FR: Laisse refroidir, découpe en bandes avec le papier, roule-les et range-les en bocal.
      'Leave to cool, cut into strips with the paper, roll them up and store in a jar.',
    ],
  ),
  'murier/Confiture de mûres': RecipeText(
    // FR: Confiture de mûres
    name: 'Blackberry jam',
    // FR: Passée au moulin si les graines te gênent.
    description: 'Put through the mill if the seeds bother you.',
  ),
  'murier/Crumble aux mûres': RecipeText(
    // FR: Crumble aux mûres
    name: 'Blackberry crumble',
    // FR: Avec des pommes, pour équilibrer l'acidité.
    description: 'With apples, to balance the acidity.',
  ),
  'murier/Sirop de mûres': RecipeText(
    // FR: Sirop de mûres
    name: 'Blackberry syrup',
    // FR: Jus et sucre à parts égales, à allonger d'eau pétillante.
    description: 'Juice and sugar in equal parts, to top up with sparkling water.',
  ),

  // ─────────── myrtillier (6 recettes) ───────────
  'myrtillier/Myrtilles congelées sur plaque': RecipeText(
    // FR: Myrtilles congelées sur plaque
    name: 'Blueberries frozen on a tray',
    // FR: La plus simple de toutes : elles gèlent une à une et se prennent à la poignée pour un muffin ou un porridge.
    description: 'The simplest of all: they freeze one by one and you can take them by the handful for a muffin or porridge.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg of blueberries', // FR: 1 kg de myrtilles
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Trie les myrtilles et retire feuilles, queues et baies écrasées.
      'Sort the blueberries and remove leaves, stalks and crushed berries.',
      // FR: Ne les lave que si elles sont sales : la pellicule blanche qui les couvre les protège au congélateur.
      'Wash them only if they are dirty: the whitish bloom that covers them protects them in the freezer.',
      // FR: Étale-les sur une plaque en une couche et congèle 2 heures.
      'Spread them on a tray in a single layer and freeze for 2 hours.',
      // FR: Verse-les en sac une fois dures. Dans une pâte, mets-les **encore congelées** : elles ne la tachent pas en violet.
      'Pour them into a bag once hard. In a batter, add them **still frozen**: they will not stain it purple.',
    ],
  ),
  'myrtillier/Myrtilles au sirop léger': RecipeText(
    // FR: Myrtilles au sirop léger
    name: 'Blueberries in light syrup',
    // FR: Quelques bocaux de myrtilles au placard, et une tarte ou un yaourt prend des couleurs en plein hiver.
    description: 'A few jars of blueberries in the cupboard, and a tart or a yoghurt takes on colour in the middle of winter.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '1.5 kg of blueberries', // FR: 1,5 kg de myrtilles
      '75 cl of water', // FR: 75 cl d'eau
      '200 g of sugar', // FR: 200 g de sucre
      'the juice of a lemon', // FR: le jus d'un citron
      '4 jars of 50 cl with new seals', // FR: 4 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Trie et rince les myrtilles, puis égoutte-les.
      'Sort and rinse the blueberries, then drain them.',
      // FR: Porte l'eau, le sucre et le jus de citron à ébullition 2 minutes.
      'Bring the water, sugar and lemon juice to the boil for 2 minutes.',
      // FR: Remplis les bocaux de myrtilles en tassant doucement, couvre de sirop chaud **jusqu'à 2 cm du bord** et ferme avec des joints neufs.
      'Fill the jars with blueberries, pressing down gently, cover with hot syrup **up to 2 cm from the rim** and close with new seals.',
      // FR: Stérilise les bocaux couverts d'eau, 20 minutes à partir de l'ébullition.
      'Sterilise the jars covered with water, 20 minutes from the moment it boils.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide : couvercle creux, joint qui tient. Sinon, au frais et à manger vite.
      'Leave to cool in the water, then check the vacuum: lid dipped inwards, seal holding. If not, keep it in the fridge and eat it soon.',
    ],
  ),
  'myrtillier/Myrtilles séchées': RecipeText(
    // FR: Myrtilles séchées
    name: 'Dried blueberries',
    // FR: Séchées, elles remplacent les raisins secs dans un muesli, avec un goût bien plus vif.
    description: 'Dried, they replace raisins in muesli, with a much livelier taste.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '1 kg of blueberries', // FR: 1 kg de myrtilles
      'a bowl of iced water', // FR: un saladier d'eau glacée
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Trie et rince les myrtilles.
      'Sort and rinse the blueberries.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille, sinon elles mettent deux jours à sécher.
      'Plunge them into boiling water for **30 seconds**: the skin cracks, otherwise they take two days to dry.',
      // FR: Passe-les dans l'eau glacée, puis égoutte et sèche-les sur un torchon.
      'Move them to the iced water, then drain and dry them on a tea towel.',
      // FR: Étale-les sur des grilles couvertes de papier cuisson et sèche au four à **60 °C**, porte entrouverte.
      'Spread them on racks lined with baking parchment and dry in the oven at **60 °C**, door held ajar.',
      // FR: Quand elles sont fripées et souples sans jus, laisse refroidir et mets en bocal. Surveille la buée la première semaine.
      'When they are wrinkled and supple with no juice, leave to cool and put in a jar. Watch for condensation in the first week.',
    ],
  ),
  'myrtillier/Tarte aux myrtilles': RecipeText(
    // FR: Tarte aux myrtilles
    name: 'Blueberry tart',
    // FR: Crues sur une crème, ou cuites — les deux marchent.
    description: 'Raw on a cream base, or baked: both work.',
  ),
  'myrtillier/Muffins aux myrtilles': RecipeText(
    // FR: Muffins aux myrtilles
    name: 'Blueberry muffins',
    // FR: Roulées dans la farine pour qu'elles ne tombent pas au fond.
    description: 'Rolled in flour so they do not sink to the bottom.',
  ),
  'myrtillier/Confiture de myrtilles': RecipeText(
    // FR: Confiture de myrtilles
    name: 'Blueberry jam',
    // FR: Peu de sucre, beaucoup de citron.
    description: 'Little sugar, plenty of lemon.',
  ),

  // ─────────── navet (6 recettes) ───────────
  'navet/Dés de navets blanchis': RecipeText(
    // FR: Dés de navets blanchis
    name: 'Blanched diced turnips',
    // FR: Deux minutes dans l'eau bouillante, et tu as des navets prêts pour le pot-au-feu ou le couscous tout l'hiver.
    description: 'Two minutes in boiling water, and you have turnips ready for stews or couscous all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of turnips', // FR: 2 kg de navets
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les navets et coupe-les en dés de 2 cm, réguliers pour qu'ils blanchissent tous pareil.
      'Peel the turnips and cut them into 2 cm dice, all the same size so they blanch evenly.',
      // FR: Plonge-les par fournées dans une grande eau salée bouillante, **2 minutes**.
      'Plunge them in batches into a large pan of boiling salted water for **2 minutes**.',
      // FR: Fais-les tomber aussitôt dans l'eau glacée, le temps qu'ils soient froids à cœur.
      'Drop them straight into the iced water, for as long as it takes them to go cold right through.',
      // FR: Égoutte et sèche-les dans un torchon : chaque goutte devient du givre.
      'Drain and dry them in a tea towel: every drop turns to frost.',
      // FR: Étale sur une plaque, congèle 2 heures, puis verse en sacs. Ils resteront détachés.
      'Spread on a tray, freeze for 2 hours, then pour into bags. They will stay separate.',
    ],
  ),
  'navet/Navets roses façon torshi': RecipeText(
    // FR: Navets roses façon torshi
    name: 'Pink turnips, torshi style',
    // FR: Le pickle libanais : une tranche de betterave suffit à teinter les navets d'un rose fuchsia.
    description: 'The Lebanese pickle: one slice of beetroot is enough to tint the turnips fuchsia pink.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of small turnips', // FR: 1 kg de petits navets
      '1 small raw beetroot', // FR: 1 petite betterave crue
      '50 cl white vinegar at 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '40 g of salt', // FR: 40 g de sel
      '3 garlic cloves', // FR: 3 gousses d'ail
    ],
    steps: <String>[
      // FR: Épluche les navets et coupe-les en bâtonnets ou en quartiers. Épluche la betterave et tranche-la en rondelles.
      'Peel the turnips and cut them into sticks or quarters. Peel the beetroot and slice it into rounds.',
      // FR: Remplis les bocaux en intercalant navets, rondelles de betterave et ail écrasé.
      'Fill the jars, layering turnips, beetroot rounds and crushed garlic.',
      // FR: Porte l'eau, le vinaigre et le sel à frémissement pour dissoudre le sel, puis laisse tiédir.
      'Bring the water, vinegar and salt to a simmer to dissolve the salt, then leave to cool a little.',
      // FR: Verse le liquide jusqu'à **couvrir entièrement** les légumes. Ce qui dépasse brunit.
      'Pour in the liquid until the vegetables are **completely covered**. Anything poking out turns brown.',
      // FR: Ferme et laisse une semaine au réfrigérateur avant d'ouvrir : le rose gagne le cœur des navets.
      'Close and leave for a week in the fridge before opening: the pink reaches the heart of the turnips.',
    ],
  ),
  'navet/Navets râpés fermentés au sel': RecipeText(
    // FR: Navets râpés fermentés au sel
    name: 'Grated turnips fermented in salt',
    // FR: La choucroute de navets des campagnes allemandes : juste du sel, et le temps fait le reste.
    description: 'The turnip sauerkraut of the German countryside: just salt, and time does the rest.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '2 kg of turnips', // FR: 2 kg de navets
      '40 g of non-iodised salt', // FR: 40 g de sel non iodé
      '1 tsp caraway seeds', // FR: 1 cuillère à café de graines de carvi
    ],
    steps: <String>[
      // FR: Épluche les navets et râpe-les grossièrement. Pèse la râpée.
      'Peel the turnips and grate them coarsely. Weigh the gratings.',
      // FR: Ajoute **20 g de sel par kilo** de navets râpés et le carvi, mélange avec les mains.
      'Add **20 g of salt per kilo** of grated turnips and the caraway, and mix with your hands.',
      // FR: Laisse reposer : le sel tire l'eau et fait tout seul la saumure.
      'Leave to rest: the salt draws out the water and makes its own brine.',
      // FR: Tasse fort dans un bocal, poing après poing, jusqu'à ce que le jus remonte au-dessus.
      'Pack firmly into a jar, fistful after fistful, until the juice rises above.',
      // FR: Pose un poids pour que tout reste **sous le jus**. S'il en manque, complète avec de la saumure à 30 g de sel par litre.
      'Set a weight on top so everything stays **under the juice**. If there is not enough, top up with brine at 30 g of salt per litre.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer, puis range au réfrigérateur.
      'Leave to ferment for 2 weeks at 18–22 °C, lid resting on without being tightened, then move to the fridge.',
    ],
  ),
  'navet/Navets glacés': RecipeText(
    // FR: Navets glacés
    name: 'Glazed turnips',
    // FR: Beurre, sucre, un fond d'eau : ils sortent brillants.
    description: 'Butter, sugar, a little water: they come out shiny.',
    ingredients: <String>[
      '800 g of turnips', // FR: 800 g de navets
      '30 g of butter', // FR: 30 g de beurre
      '1 tsp sugar', // FR: 1 cuillère à café de sucre
      'salt, parsley', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Pèle les navets et coupe-les en quartiers réguliers.
      'Peel the turnips and cut them into even quarters.',
      // FR: Casserole large : beurre, sucre, sel, eau à mi-hauteur.
      'Wide pan: butter, sugar, salt, water halfway up.',
      // FR: Cuis à découvert 20 minutes, l'eau doit s'évaporer en sirop.
      'Cook uncovered for 20 minutes; the water should evaporate into a syrup.',
      // FR: Remue pour les enrober, persil, et sers chaud.
      'Stir to coat them, add parsley, and serve hot.',
    ],
  ),
  'navet/Purée de navets': RecipeText(
    // FR: Purée de navets
    name: 'Turnip purée',
    // FR: Moitié navet, moitié pomme de terre : plus légère qu'une purée classique.
    description: 'Half turnip, half potato: lighter than a classic mash.',
    ingredients: <String>[
      '500 g of turnips', // FR: 500 g de navets
      '500 g of potatoes', // FR: 500 g de pommes de terre
      '20 cl of milk', // FR: 20 cl de lait
      '40 g of butter', // FR: 40 g de beurre
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Pèle et coupe navets et pommes de terre en morceaux égaux.
      'Peel the turnips and potatoes and cut them into equal pieces.',
      // FR: Cuis-les à l'eau salée 20 minutes.
      'Cook them in salted water for 20 minutes.',
      // FR: Égoutte et laisse-les sécher 2 minutes sur le feu éteint : une purée de navets tourne vite à la soupe.
      'Drain and leave them to dry for 2 minutes in the pan on the switched-off hob: a turnip purée quickly turns into soup.',
      // FR: Écrase au presse-purée, pas au mixeur, avec le lait chaud et le beurre.
      'Mash with a potato masher, not a blender, with the hot milk and the butter.',
      // FR: Sel, poivre, muscade.
      'Salt, pepper, nutmeg.',
    ],
  ),
  'navet/Navets au miel et thym': RecipeText(
    // FR: Navets au miel et thym
    name: 'Turnips with honey and thyme',
    // FR: Le miel prend le dessus sur l'amertume des gros navets d'hiver.
    description: 'The honey wins out over the bitterness of big winter turnips.',
    ingredients: <String>[
      '800 g of turnips', // FR: 800 g de navets
      '2 tbsp honey', // FR: 2 cuillères à soupe de miel
      '20 g of butter', // FR: 20 g de beurre
      'thyme, salt, pepper, 1 dash of vinegar', // FR: thym, sel, poivre, 1 trait de vinaigre
    ],
    steps: <String>[
      // FR: Coupe les navets en gros dés.
      'Cut the turnips into big dice.',
      // FR: Fais-les colorer au beurre à feu vif, 5 minutes.
      'Brown them in the butter over high heat, 5 minutes.',
      // FR: Ajoute miel, thym, sel, un trait de vinaigre, un fond d'eau.
      'Add honey, thyme, salt, a dash of vinegar and a little water.',
      // FR: Couvre et laisse 20 minutes à feu doux.
      'Cover and leave for 20 minutes over low heat.',
      // FR: Découvre à la fin pour faire réduire et caraméliser.
      'Uncover at the end to reduce and caramelise.',
    ],
  ),

  // ─────────── niebe (6 recettes) ───────────
  'niebe/Niébé sec en sacs hermétiques': RecipeText(
    // FR: Niébé sec en sacs hermétiques
    name: 'Dried cowpeas in airtight sacks',
    // FR: Bien séché et enfermé sans air, le niébé échappe aux bruches et se garde jusqu'à la récolte suivante.
    description: 'Well dried and sealed away from air, cowpeas escape the bruchid beetles and keep until the next harvest.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, safe from insects',
    ingredients: <String>[
      'cowpea pods left to dry on the plant', // FR: les gousses de niébé sèches sur pied
      'a clean tarpaulin', // FR: une bâche propre
      'airtight sacks or tightly closed drums', // FR: des sacs hermétiques ou des bidons bien fermés
    ],
    steps: <String>[
      // FR: Récolte les gousses quand elles sont jaunes-brunes et craquent sous les doigts.
      'Harvest the pods when they are yellow-brown and crackle under your fingers.',
      // FR: Étale-les au soleil sur une bâche jusqu'à ce qu'elles s'ouvrent toutes seules, environ une semaine.
      'Spread them in the sun on a tarpaulin until they split open by themselves, about a week.',
      // FR: Bats-les doucement au bâton ou écosse-les à la main, puis vanne pour enlever les cosses.
      'Beat them gently with a stick or shell them by hand, then winnow to remove the pods.',
      // FR: Trie : retire les graines percées d'un petit trou rond, c'est la bruche, et les graines tachées.
      'Sort: remove seeds pierced by a small round hole (that is the bruchid beetle) and any spotted seeds.',
      // FR: Passe les graines **3 jours au congélateur**, ou mets-les dans un bidon plein à ras et fermé : sans air, les insectes meurent.
      'Put the seeds **3 days in the freezer**, or in a drum filled to the brim and closed: without air, the insects die.',
      // FR: Stocke au frais et au sec dans des sacs triples ou des bidons hermétiques. Le niébé sec se cuit toujours avant de se manger.
      'Store somewhere cool and dry in triple-layer sacks or airtight drums. Dried cowpeas are always cooked before eating.',
    ],
  ),
  'niebe/Niébé frais blanchi au congélateur': RecipeText(
    // FR: Niébé frais blanchi au congélateur
    name: 'Fresh cowpeas blanched for the freezer',
    // FR: Les graines fraîches écossées, deux minutes dans l'eau bouillante, et elles gardent leur tendre tout l'hiver.
    description: 'Fresh shelled seeds, two minutes in boiling water, and they stay tender all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 kg of fresh shelled cowpeas', // FR: 1 kg de niébé frais écossé
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les graines écossées et retire celles qui sont tachées ou trop dures.
      'Rinse the shelled seeds and remove any that are spotted or too hard.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante, compte à partir de la reprise de l'ébullition.
      'Plunge them into a large pan of boiling water, counting from the moment it returns to the boil.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée 2 minutes pour stopper la cuisson.
      'Drain and plunge straight into the iced water for 2 minutes to stop the cooking.',
      // FR: Égoutte et sèche sur un torchon. Moins il reste d'eau, moins il y a de givre.
      'Drain and dry on a tea towel. The less water is left, the less frost there is.',
      // FR: Étale sur une plaque, congèle 1 heure, puis mets en sac.
      'Spread on a tray, freeze for 1 hour, then put in a bag.',
      // FR: Cuis-les sans décongeler, 15 à 20 minutes dans l'eau ou la sauce : le blanchiment ne suffit pas à les cuire.
      'Cook them without thawing, 15 to 20 minutes in water or sauce: blanching is not enough to cook them.',
    ],
  ),
  'niebe/Niébé cuit en portions': RecipeText(
    // FR: Niébé cuit en portions
    name: 'Cooked cowpeas in portions',
    // FR: Une grosse marmite de niébé cuit, et des portions prêtes pour un ndambé ou une salade sans attendre.
    description: 'A big pot of cooked cowpeas, and portions ready for a ndambé or a salad without waiting.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '500 g of dried cowpeas', // FR: 500 g de niébé sec
      '2 litres of water', // FR: 2 litres d'eau
      '1 bay leaf', // FR: 1 feuille de laurier
      'salt', // FR: sel
      'freezer boxes', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie le niébé, rince-le et laisse-le tremper si tu as le temps : il cuira plus vite.
      'Sort the cowpeas, rinse them and leave them to soak if you have time: they will cook faster.',
      // FR: Mets-le dans l'eau froide avec le laurier, porte à ébullition et écume la mousse grise.
      'Put them in cold water with the bay leaf, bring to the boil and skim off the grey foam.',
      // FR: Laisse frémir jusqu'à ce que le grain s'écrase entre deux doigts. **Sale seulement à la fin**, sinon la peau durcit.
      'Simmer until a bean mashes between two fingers. **Salt only at the end**, or the skins toughen.',
      // FR: Laisse refroidir dans un peu de son eau de cuisson, ça l'empêche de sécher.
      'Leave to cool in a little of their cooking water, which stops them drying out.',
      // FR: Répartis en boîtes avec un peu de jus, en laissant 2 cm de vide, et note la date.
      'Divide into boxes with a little of the liquid, leaving 2 cm of space, and write the date.',
    ],
  ),
  'niebe/Akara': RecipeText(
    // FR: Akara
    name: 'Akara',
    // FR: Les beignets de niébé croustillants, stars des petits déjeuners de rue.
    description: 'Crispy cowpea fritters, the stars of street breakfasts.',
  ),
  'niebe/Moin-moin': RecipeText(
    // FR: Moin-moin
    name: 'Moin-moin',
    // FR: Le flan de niébé vapeur du Nigeria, moelleux et délicatement épicé.
    description: 'The steamed cowpea custard of Nigeria, soft and delicately spiced.',
  ),
  'niebe/Ndambé': RecipeText(
    // FR: Ndambé
    name: 'Ndambé',
    // FR: Le ragoût de niébé sénégalais, servi dans du pain frais pour un sandwich costaud.
    description: 'The Senegalese cowpea stew, served in fresh bread for a hearty sandwich.',
  ),

  // ─────────── noisetier (6 recettes) ───────────
  'noisetier/Noisettes séchées en coque': RecipeText(
    // FR: Noisettes séchées en coque
    name: 'Hazelnuts dried in the shell',
    // FR: Bien sèches, les noisettes se gardent tout l'hiver dans leur coque, qui est leur meilleure boîte.
    description: 'Properly dry, hazelnuts keep all winter in their shells, which are their best container.',
    // FR: 1 an en coque, au sec et au frais
    keeps: '1 year in the shell, somewhere dry and cool',
    ingredients: <String>[
      'hazelnuts fallen on the ground', // FR: les noisettes tombées au sol
      'crates or racks', // FR: des cagettes ou des claies
      'cloth nets or sacks', // FR: des filets ou sacs en toile
    ],
    steps: <String>[
      // FR: Ramasse les noisettes au sol tous les deux jours, avant les écureuils, et retire leur collerette verte.
      'Gather the nuts from the ground every two days, before the squirrels do, and remove their green husk.',
      // FR: Plonge-les dans un seau d'eau : celles qui **flottent** sont vides ou véreuses, jette-les.
      'Drop them in a bucket of water: those that **float** are empty or wormy, so throw them away.',
      // FR: Étale les bonnes en une couche dans des cagettes, dans un grenier sec et aéré, et remue-les de temps en temps. Deux semaines.
      'Spread the good ones in a single layer in crates, in a dry, airy loft, and turn them from time to time. Two weeks.',
      // FR: Casse-en une : l'amande doit se détacher de la coque et se casser net, sans plier.
      'Crack one open: the kernel should come away from the shell and snap cleanly, without bending.',
      // FR: Range-les en filets ou sacs de toile suspendus, dans un endroit frais et sec, hors de portée des souris.
      'Store them in nets or cloth sacks hung up, somewhere cool and dry, out of reach of mice.',
    ],
  ),
  'noisetier/Noisettes décortiquées au congélateur': RecipeText(
    // FR: Noisettes décortiquées au congélateur
    name: 'Shelled hazelnuts in the freezer',
    // FR: Une fois cassées, elles rancissent vite : au congélateur, elles restent comme au premier jour.
    description: 'Once cracked, they go rancid quickly: in the freezer, they stay as good as the first day.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg of dried hazelnuts in the shell', // FR: 1 kg de noisettes sèches en coque
      'a nutcracker', // FR: un casse-noix
      'freezer bags or jars', // FR: des sacs ou bocaux de congélation
    ],
    steps: <String>[
      // FR: Casse les noisettes au casse-noix, ou plusieurs à la fois dans un torchon avec un maillet.
      'Crack the hazelnuts with a nutcracker, or several at a time in a tea towel with a mallet.',
      // FR: Trie les amandes et jette celles qui sont noircies, ridées ou piquées : **une seule rance** gâte tout le sachet.
      'Sort the kernels and throw away any that are blackened, shrivelled or pricked: **a single rancid one** spoils the whole bag.',
      // FR: Mets-les en sachets de 250 g, chasse l'air et ferme bien : les noisettes prennent les odeurs.
      'Put them in bags of 250 g, press out the air and seal well: hazelnuts take on smells.',
      // FR: Congèle à plat. Elles s'utilisent sans décongeler, pour torréfier, mixer ou mettre dans une pâte.
      'Freeze flat. They can be used without thawing, to roast, blitz or add to a batter.',
    ],
  ),
  'noisetier/Poudre de noisettes torréfiées': RecipeText(
    // FR: Poudre de noisettes torréfiées
    name: 'Roasted hazelnut powder',
    // FR: Torréfiées puis moulues, elles donnent une poudre qui parfume un gâteau bien mieux que celle du commerce.
    description: 'Roasted then ground, they make a powder that flavours a cake far better than the shop-bought kind.',
    // FR: 2 mois en bocal au réfrigérateur, 6 mois au congélateur
    keeps: '2 months in a jar in the fridge, 6 months in the freezer',
    ingredients: <String>[
      '500 g of shelled hazelnuts', // FR: 500 g de noisettes décortiquées
      'a clean tea towel', // FR: un torchon propre
      'a glass jar', // FR: un bocal en verre
    ],
    steps: <String>[
      // FR: Étale les noisettes sur une plaque et fais-les torréfier au four à **160 °C**, en secouant à mi-temps.
      'Spread the hazelnuts on a tray and roast in the oven at **160 °C**, shaking halfway through.',
      // FR: Verse-les chaudes dans un torchon et frotte : la peau brune s'en va presque toute seule.
      'Tip them hot into a tea towel and rub: the brown skin comes off almost by itself.',
      // FR: Laisse-les refroidir complètement, sinon la poudre tourne en pâte.
      'Let them cool completely, or the powder turns to paste.',
      // FR: Mixe par **petits à-coups** : trop longtemps, l'huile sort et tu obtiens une pâte à tartiner.
      'Blitz in **short bursts**: too long and the oil comes out, and you get a spread.',
      // FR: Mets en bocal fermé et garde au réfrigérateur : l'huile de noisette rancit vite à température ambiante.
      'Put in a closed jar and keep in the fridge: hazelnut oil quickly goes rancid at room temperature.',
    ],
  ),
  'noisetier/Pâte à tartiner maison': RecipeText(
    // FR: Pâte à tartiner maison
    name: 'Homemade chocolate hazelnut spread',
    // FR: Noisettes torréfiées, mixées longtemps jusqu'à la crème.
    description: 'Roasted hazelnuts, blitzed for a long time until creamy.',
  ),
  'noisetier/Gâteau aux noisettes': RecipeText(
    // FR: Gâteau aux noisettes
    name: 'Hazelnut cake',
    // FR: Sans farine, juste des noisettes moulues et des œufs.
    description: 'No flour, just ground hazelnuts and eggs.',
  ),
  'noisetier/Noisettes torréfiées au sel': RecipeText(
    // FR: Noisettes torréfiées au sel
    name: 'Salted roasted hazelnuts',
    // FR: Quinze minutes de four, frottées dans un torchon.
    description: 'Fifteen minutes in the oven, rubbed in a tea towel.',
  ),

  // ─────────── oignon (6 recettes) ───────────
  'oignon/Oignons ressuyés en tresses': RecipeText(
    // FR: Oignons ressuyés en tresses
    name: 'Onions cured and plaited',
    // FR: Bien séchés et tressés, les oignons de garde passent l'hiver suspendus, jusqu'au printemps.
    description: 'Well dried and plaited, storage onions get through the winter hanging up, until spring.',
    // FR: 6 mois au sec, au frais et à l'ombre
    keeps: '6 months in a dry, cool, shady place',
    ingredients: <String>[
      'storage onions pulled up in dry weather', // FR: les oignons de garde arrachés par temps sec
      'kitchen string', // FR: de la ficelle de cuisine
      'a dry, airy place in the shade', // FR: un endroit sec, aéré et à l'ombre
    ],
    steps: <String>[
      // FR: Arrache les oignons quand les fanes sont couchées et jaunies, par une journée sèche.
      'Pull up the onions when the tops have flopped over and yellowed, on a dry day.',
      // FR: Laisse-les 2 à 3 jours sur le sol, au soleil, puis à l'abri sec et aéré.
      'Leave them 2 to 3 days on the ground in the sun, then somewhere dry, airy and sheltered.',
      // FR: Laisse-les ressuyer 2 semaines, jusqu'à ce que la peau soit craquante et le collet bien sec.
      'Leave them to cure for 2 weeks, until the skin is papery and the neck is completely dry.',
      // FR: Brosse la terre à la main sans enlever les peaux, et coupe les racines à 1 cm.
      'Brush off the soil by hand without removing the skins, and trim the roots to 1 cm.',
      // FR: Trie : mange d'abord les oignons au collet épais ou mou, ils ne se gardent pas.
      'Sort: eat first any onions with a thick or soft neck, as they will not keep.',
      // FR: Tresse les fanes sèches autour d'une ficelle, un oignon après l'autre, comme une natte.
      'Plait the dry tops around a piece of string, one onion after another, like a braid.',
      // FR: Suspends les tresses au frais, au sec et à l'ombre. Vérifie chaque mois et retire ceux qui germent ou ramollissent.
      'Hang the plaits somewhere cool, dry and shady. Check each month and remove any that sprout or go soft.',
    ],
  ),
  'oignon/Oignons émincés congelés': RecipeText(
    // FR: Oignons émincés congelés
    name: 'Frozen sliced onions',
    // FR: Un quart d'heure de larmes une fois, et plus jamais d'oignon à éplucher pour une sauce en semaine.
    description: 'A quarter of an hour of tears, once, and never again an onion to peel for a weekday sauce.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of onions', // FR: 2 kg d'oignons
      'thick freezer bags', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Épluche les oignons et émince-les ou coupe-les en dés, comme tu les utilises le plus.
      'Peel the onions and slice or dice them, whichever way you use them most.',
      // FR: Étale-les sur une plaque et congèle 1 heure pour qu'ils ne fassent pas un bloc.
      'Spread them on a tray and freeze for 1 hour so they do not freeze into a block.',
      // FR: Mets-les en sacs par portions, chasse l'air, et **double l'emballage** : sinon tout le congélateur sent l'oignon.
      'Put them in bags in portions, press out the air, and **double-bag them**: otherwise the whole freezer smells of onion.',
      // FR: Jette-les encore gelés dans la poêle chaude. Ils sont parfaits cuits, pas en salade.
      'Drop them still frozen into the hot pan. They are perfect cooked, not in a salad.',
    ],
  ),
  'oignon/Pickles d\'oignons rouges': RecipeText(
    // FR: Pickles d'oignons rouges
    name: 'Pickled red onions',
    // FR: Roses, croquants, acidulés : une poignée sur une salade, un burger ou un poisson grillé.
    description: 'Pink, crunchy, tangy: a handful on a salad, a burger or grilled fish.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of red onions', // FR: 1 kg d'oignons rouges
      '40 cl cider vinegar at 6 %', // FR: 40 cl de vinaigre de cidre à 6 %
      '40 cl of water', // FR: 40 cl d'eau
      '2 tbsp sugar', // FR: 2 cuillères à soupe de sucre
      '1 tbsp salt', // FR: 1 cuillère à soupe de sel
    ],
    steps: <String>[
      // FR: Épluche les oignons et coupe-les en rondelles fines de 3 mm.
      'Peel the onions and cut them into thin rounds of 3 mm.',
      // FR: Tasse-les dans des bocaux ébouillantés sans les écraser.
      'Pack them into scalded jars without squashing them.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel jusqu'à ce qu'ils fondent.
      'Bring the vinegar, water, sugar and salt to the boil until they dissolve.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement** les oignons, à 1 cm du bord. Ferme.
      'Pour the boiling liquid over to **cover the onions completely**, up to 1 cm from the rim. Close.',
      // FR: Laisse refroidir puis mets au réfrigérateur. Ils sont roses et prêts dès le lendemain.
      'Leave to cool then put in the fridge. They are pink and ready the next day.',
    ],
  ),
  'oignon/Soupe à l\'oignon gratinée': RecipeText(
    // FR: Soupe à l'oignon gratinée
    name: 'French onion soup with a cheese crust',
    // FR: Une heure de patience sur les oignons, et tout est joué.
    description: 'An hour of patience with the onions, and the job is done.',
    ingredients: <String>[
      '1 kg of onions', // FR: 1 kg d'oignons
      '40 g of butter', // FR: 40 g de beurre
      '1 tbsp flour', // FR: 1 cuillère à soupe de farine
      '1.5 litres of stock', // FR: 1,5 litre de bouillon
      '4 slices of bread, 150 g of Gruyère', // FR: 4 tranches de pain, 150 g de gruyère
    ],
    steps: <String>[
      // FR: Émince les oignons en fines lamelles.
      'Slice the onions into thin strips.',
      // FR: Fais-les blondir au beurre à feu doux **40 minutes** en remuant. C'est toute la recette : pressé, ça ne marche pas.
      'Let them turn golden in the butter over low heat for **40 minutes**, stirring. That is the whole recipe: rushed, it does not work.',
      // FR: Saupoudre la farine, remue 2 minutes, puis verse le bouillon chaud.
      'Sprinkle in the flour, stir for 2 minutes, then pour in the hot stock.',
      // FR: Laisse mijoter 20 minutes.
      'Simmer for 20 minutes.',
      // FR: Verse en bols, pose le pain, couvre de gruyère.
      'Ladle into bowls, add the bread and cover with Gruyère.',
      // FR: Sous le gril 5 minutes, jusqu'à la croûte.
      'Under the grill for 5 minutes, until crusty.',
    ],
  ),
  'oignon/Oignons confits': RecipeText(
    // FR: Oignons confits
    name: 'Onion confit',
    // FR: Doux et sirupeux, ils se gardent au frais et relèvent tout.
    description: 'Soft and syrupy, it keeps in the fridge and lifts everything.',
    ingredients: <String>[
      '1 kg of onions', // FR: 1 kg d'oignons
      '3 tbsp sugar', // FR: 3 cuillères à soupe de sucre
      '5 cl of wine vinegar', // FR: 5 cl de vinaigre de vin
      '2 tbsp oil', // FR: 2 cuillères à soupe d'huile
      'salt, thyme', // FR: sel, thym
    ],
    steps: <String>[
      // FR: Émince les oignons.
      'Slice the onions.',
      // FR: Fais-les suer à l'huile 15 minutes à couvert.
      'Sweat them in the oil for 15 minutes, covered.',
      // FR: Ajoute sucre, vinaigre, sel, thym. Découvre et laisse réduire.
      'Add sugar, vinegar, salt and thyme. Uncover and let it reduce.',
      // FR: Encore 30 minutes à feu doux : ils doivent brunir et devenir sirupeux.
      'Another 30 minutes over low heat: they should brown and turn syrupy.',
      // FR: En bocal, ils tiennent une semaine au réfrigérateur.
      'In a jar, they keep for a week in the fridge.',
    ],
  ),
  'oignon/Tarte à l\'oignon': RecipeText(
    // FR: Tarte à l'oignon
    name: 'Onion tart',
    // FR: Des oignons fondus, des lardons, un appareil à la crème.
    description: 'Melting onions, bacon lardons, a creamy egg filling.',
    ingredients: <String>[
      '1 shortcrust pastry case', // FR: 1 pâte brisée
      '800 g of onions', // FR: 800 g d'oignons
      '150 g of bacon lardons', // FR: 150 g de lardons
      '20 cl of cream, 2 eggs', // FR: 20 cl de crème, 2 oeufs
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Émince les oignons, fais-les fondre 25 minutes.
      'Slice the onions and cook them down for 25 minutes.',
      // FR: Ajoute les lardons 5 minutes.
      'Add the lardons for 5 minutes.',
      // FR: Bats crème, oeufs, poivre, muscade. Sale peu.
      'Beat the cream, eggs, pepper and nutmeg. Go easy on the salt.',
      // FR: Garnis la pâte, verse l'appareil.
      'Fill the pastry case, pour in the egg mixture.',
      // FR: Four à 190 °C, 30 minutes.
      'Oven at 190 °C, 30 minutes.',
    ],
  ),

  // ─────────── origan (6 recettes) ───────────
  'origan/Bouquets d\'origan séchés': RecipeText(
    // FR: Bouquets d'origan séchés
    name: 'Oregano dried in bunches',
    // FR: L'origan est plus parfumé sec que frais : c'est sa conservation reine.
    description: 'Oregano is more fragrant dried than fresh: drying is the best way to keep it.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'oregano stems at the start of flowering', // FR: des tiges d'origan en début de floraison
      'string', // FR: de la ficelle
      'a large paper bag', // FR: un grand sac en papier
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les **premières fleurs s'ouvrent** : c'est là que l'arôme est au maximum.
      'Cut the stems when the **first flowers open**: that is when the aroma is at its strongest.',
      // FR: Secoue-les pour faire tomber les insectes et lie-les en petits bouquets lâches.
      'Shake them to dislodge any insects and tie them into small, loose bunches.',
      // FR: Suspends-les tête en bas dans un sac en papier percé de quelques trous, à l'ombre et au sec, une dizaine de jours.
      'Hang them upside down in a paper bag with a few holes punched in it, in the shade and somewhere dry, for about ten days.',
      // FR: Frotte les tiges au-dessus d'une feuille de papier : feuilles et fleurs se détachent ensemble.
      'Rub the stems over a sheet of paper: leaves and flowers come off together.',
      // FR: Retire les bouts de tige et mets en bocal bien fermé. Émiette-le entre tes paumes juste avant de l'utiliser.
      'Remove the bits of stem and put in a tightly closed jar. Crumble it between your palms just before using.',
    ],
  ),
  'origan/Glaçons d\'origan à l\'huile d\'olive': RecipeText(
    // FR: Glaçons d'origan à l'huile d'olive
    name: 'Oregano and olive oil ice cubes',
    // FR: Pour garder aussi le goût de l'origan frais, prêt à fondre dans une sauce tomate.
    description: 'To keep the taste of fresh oregano too, ready to melt into a tomato sauce.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 good handfuls of oregano leaves', // FR: 2 belles poignées de feuilles d'origan
      '10 cl of olive oil', // FR: 10 cl d'huile d'olive
      'an ice cube tray', // FR: un bac à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les tiges et sèche-les bien sur un torchon.
      'Rinse the stems and dry them well on a tea towel.',
      // FR: Effeuille et hache grossièrement les feuilles.
      'Strip the leaves and chop them roughly.',
      // FR: Remplis les cases du bac aux trois quarts de feuilles et couvre d'huile d'olive à ras.
      'Fill the compartments three-quarters full of leaves and top up with olive oil to the brim.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les en sac.
      'Freeze until the cubes are hard, then pop them out into a bag.',
      // FR: Jette un cube gelé directement dans la sauce ou la poêle. **Ne garde jamais** l'huile aux herbes décongelée hors du frigo.
      'Drop a frozen cube straight into the sauce or the pan. **Never keep** thawed herb oil out of the fridge.',
    ],
  ),
  'origan/Huile d\'olive à l\'origan séché': RecipeText(
    // FR: Huile d'olive à l'origan séché
    name: 'Olive oil with dried oregano',
    // FR: Un filet sur la pizza ou la feta, à faire avec ton origan déjà séché et à garder au frais.
    description: 'A drizzle on pizza or feta, made with oregano you have already dried and kept cool.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '3 tbsp very dry oregano', // FR: 3 cuillères à soupe d'origan bien sec
      '25 cl of olive oil', // FR: 25 cl d'huile d'olive
      '1 small clean, dry bottle', // FR: 1 petite bouteille propre et sèche
    ],
    steps: <String>[
      // FR: Utilise de l'origan **parfaitement sec**, jamais frais : l'eau des herbes fraîches dans l'huile est dangereuse.
      'Use **perfectly dry** oregano, never fresh: the water in fresh herbs in oil is dangerous.',
      // FR: Fais tiédir l'huile à feu très doux avec l'origan, sans frémissement, puis coupe le feu.
      'Warm the oil with the oregano over very low heat, without letting it simmer, then turn off the heat.',
      // FR: Laisse infuser hors du feu jusqu'à ce que l'huile soit tiède.
      'Leave to infuse off the heat until the oil is lukewarm.',
      // FR: Filtre dans la bouteille à travers une passoire fine et un entonnoir.
      'Strain into the bottle through a fine sieve and a funnel.',
      // FR: Ferme et range-la **tout de suite au réfrigérateur**. Elle fige au froid : sors-la 15 minutes avant de t'en servir.
      'Close and put it **straight into the fridge**. It sets in the cold: take it out 15 minutes before using.',
    ],
  ),
  'origan/Sauce tomate à l\'origan': RecipeText(
    // FR: Sauce tomate à l'origan
    name: 'Tomato sauce with oregano',
    // FR: Séché plutôt que frais : il est plus puissant.
    description: 'Dried rather than fresh: it is stronger.',
  ),
  'origan/Pizza margherita': RecipeText(
    // FR: Pizza margherita
    name: 'Pizza margherita',
    // FR: Origan sur la tomate avant le four, basilic après.
    description: 'Oregano on the tomato before the oven, basil after.',
  ),
  'origan/Feta marinée à l\'origan': RecipeText(
    // FR: Feta marinée à l'origan
    name: 'Feta marinated with oregano',
    // FR: En cubes dans l'huile, avec du citron et du poivre.
    description: 'In cubes in oil, with lemon and pepper.',
  ),

  // ─────────── oseille (6 recettes) ───────────
  'oseille/Oseille fondue au beurre à congeler': RecipeText(
    // FR: Oseille fondue au beurre à congeler
    name: 'Sorrel melted in butter, to freeze',
    // FR: L'oseille fond en une minute dans le beurre : congelée en portions, elle donne une sauce acidulée en un instant.
    description: 'Sorrel melts in a minute in butter: frozen in portions, it gives a tangy sauce in an instant.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of sorrel', // FR: 1 kg d'oseille
      '50 g of butter', // FR: 50 g de beurre
      'salt', // FR: sel
      'an ice cube tray or small boxes', // FR: un bac à glaçons ou de petites boîtes
    ],
    steps: <String>[
      // FR: Lave l'oseille et égoutte-la bien.
      'Wash the sorrel and drain it well.',
      // FR: Retire les tiges en tirant dessus : elles emportent la nervure centrale, qui est dure.
      'Remove the stalks by pulling on them: they take the tough central rib with them.',
      // FR: Fais fondre le beurre dans une grande casserole, jette l'oseille et remue : en **2 à 3 minutes** elle fond en purée kaki.
      'Melt the butter in a large pan, add the sorrel and stir: in **2 to 3 minutes** it melts into a khaki purée.',
      // FR: Sale légèrement et laisse évaporer l'eau 2 minutes de plus.
      'Salt lightly and let the water evaporate for 2 more minutes.',
      // FR: Laisse refroidir complètement.
      'Leave to cool completely.',
      // FR: Répartis dans un bac à glaçons ou de petites boîtes, congèle, puis démoule en sac daté.
      'Divide into an ice cube tray or small boxes, freeze, then pop out into a dated bag.',
    ],
  ),
  'oseille/Oseille hachée en glaçons': RecipeText(
    // FR: Oseille hachée en glaçons
    name: 'Chopped sorrel in ice cubes',
    // FR: Dix minutes, crue et hachée : chaque glaçon parfume une omelette ou une soupe en fin de cuisson.
    description: 'Ten minutes, raw and chopped: each cube flavours an omelette or a soup at the end of cooking.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '500 g of sorrel', // FR: 500 g d'oseille
      'a little water', // FR: un peu d'eau
      'an ice cube tray', // FR: un bac à glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave l'oseille et sèche-la au torchon.
      'Wash the sorrel and dry it with a tea towel.',
      // FR: Équeute et cisèle finement les feuilles en lanières.
      'Trim the stalks and cut the leaves into fine ribbons.',
      // FR: Tasse l'oseille dans les cases d'un bac à glaçons et complète avec un fond d'eau pour la protéger de l'air.
      'Pack the sorrel into the compartments of an ice cube tray and top up with a little water to protect it from the air.',
      // FR: Congèle 4 heures, puis démoule les cubes et garde-les en sac. Utilise-les directement dans la poêle ou la casserole, sans décongeler.
      'Freeze for 4 hours, then pop the cubes out and keep them in a bag. Use them straight in the pan or pot, without thawing.',
    ],
  ),
  'oseille/Oseille séchée': RecipeText(
    // FR: Oseille séchée
    name: 'Dried sorrel',
    // FR: Séchée à l'ombre, elle garde son acidité pour parfumer les soupes et les sauces en plein hiver.
    description: 'Dried in the shade, it keeps its tartness to flavour soups and sauces in the depths of winter.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      '500 g of sorrel leaves', // FR: 500 g de feuilles d'oseille
      'racks or trays', // FR: des grilles ou plaques
      '2 small, very dry jars', // FR: 2 petits bocaux bien secs
    ],
    steps: <String>[
      // FR: Lave les feuilles et sèche-les complètement à l'essoreuse puis au torchon.
      'Wash the leaves and dry them completely, first in a salad spinner then in a tea towel.',
      // FR: Équeute-les et laisse-les entières.
      'Trim the stalks and leave the leaves whole.',
      // FR: Étale-les sans qu'elles se chevauchent et sèche au four à 40 °C, porte entrouverte, ou au déshydrateur.
      'Spread them without overlapping and dry in the oven at 40 °C, door held ajar, or in a dehydrator.',
      // FR: Elles sont prêtes quand elles se brisent entre les doigts. Si elles plient encore, continue.
      'They are ready when they snap between your fingers. If they still bend, keep going.',
      // FR: Émiette-les grossièrement et mets-les en bocaux fermés, dans un placard sombre.
      'Crumble them roughly and put them in closed jars, in a dark cupboard.',
    ],
  ),
  'oseille/Sauce à l\'oseille': RecipeText(
    // FR: Sauce à l'oseille
    name: 'Sorrel sauce',
    // FR: Fondue à la crème, pour un saumon ou un œuf poché.
    description: 'Melted into cream, for salmon or a poached egg.',
  ),
  'oseille/Soupe à l\'oseille': RecipeText(
    // FR: Soupe à l'oseille
    name: 'Sorrel soup',
    // FR: Acidulée, liée d'un jaune d'œuf hors du feu.
    description: 'Tangy, thickened with an egg yolk off the heat.',
  ),
  'oseille/Omelette à l\'oseille': RecipeText(
    // FR: Omelette à l'oseille
    name: 'Sorrel omelette',
    // FR: Les feuilles fondent en quelques secondes.
    description: 'The leaves melt in a few seconds.',
  ),

  // ─────────── pourpier (6 recettes) ───────────
  'pourpier/Pourpier au vinaigre': RecipeText(
    // FR: Pourpier au vinaigre
    name: 'Pickled purslane',
    // FR: Comme on le faisait autrefois dans le Midi : les tiges charnues au vinaigre se croquent comme des cornichons.
    description: 'The old way in the south of France: the fleshy stems keep their crunch in vinegar, just like gherkins.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '500 g of purslane stems and leaves', // FR: 500 g de tiges et feuilles de pourpier
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 15 g of sugar', // FR: 10 g de sel, 15 g de sucre
      '1 garlic clove, 1 tsp of peppercorns', // FR: 1 gousse d'ail, 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Lave le pourpier dans plusieurs eaux : il pousse au ras du sol et garde du sable.
      'Wash the purslane in several changes of water: it grows right at ground level and holds on to sand.',
      // FR: Coupe-le en tronçons de 5 cm en gardant les feuilles attachées aux tiges.
      'Cut it into 5 cm lengths, keeping the leaves attached to the stems.',
      // FR: Tasse-le dans deux bocaux ébouillantés avec l'ail coupé en deux et le poivre.
      'Pack it into two scalded jars with the garlic cut in half and the pepper.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement** le pourpier, ferme et laisse refroidir.
      'Pour it in boiling, to **cover the purslane completely**, close the jars and let them cool.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'y goûter.
      'Keep in the fridge and wait 3 days before tasting.',
    ],
  ),
  'pourpier/Pourpier blanchi congelé': RecipeText(
    // FR: Pourpier blanchi congelé
    name: 'Blanched frozen purslane',
    // FR: Une minute dans l'eau, et sa texture charnue t'attend pour les soupes et les omelettes d'hiver.
    description: 'One minute in the water, and its fleshy texture is waiting for you in winter soups and omelettes.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of purslane', // FR: 1 kg de pourpier
      'coarse salt', // FR: gros sel
      '1 large bowl of iced water', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le pourpier dans plusieurs eaux et retire les racines.
      'Wash the purslane in several changes of water and trim off the roots.',
      // FR: Coupe-le en tronçons de 3 cm.
      'Cut it into 3 cm lengths.',
      // FR: Plonge-le dans une grande eau bouillante salée **1 minute**.
      'Drop it into a large pan of salted boiling water for **1 minute**.',
      // FR: Transfère aussitôt dans l'eau glacée.
      'Move it straight into the iced water.',
      // FR: Égoutte puis presse légèrement : il rend beaucoup d'eau.
      'Drain, then press gently: it gives off a lot of water.',
      // FR: Mets en sacs d'une portion, à plat, et date-les.
      'Pack it flat into single-portion bags and write the date on them.',
    ],
  ),
  'pourpier/Pourpier lacto-fermenté': RecipeText(
    // FR: Pourpier lacto-fermenté
    name: 'Lacto-fermented purslane',
    // FR: En saumure quelques jours, il devient acidulé et garde son croquant juteux.
    description: 'A few days in brine and it turns pleasantly sour, with its juicy crunch intact.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '600 g of purslane', // FR: 600 g de pourpier
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '2 garlic cloves', // FR: 2 gousses d'ail
      'a few sprigs of dill', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Dissolve **30 g of salt in 1 litre of water**: that makes a 3 % brine.',
      // FR: Lave soigneusement le pourpier dans plusieurs eaux et égoutte-le.
      'Wash the purslane carefully in several changes of water and drain it.',
      // FR: Tasse-le en tronçons dans deux bocaux avec l'ail et l'aneth, jusqu'à 3 cm du bord.
      'Pack it, in lengths, into two jars with the garlic and dill, up to 3 cm from the rim.',
      // FR: Couvre de saumure et pose un poids pour que tout reste **sous la saumure**.
      'Cover with brine and add a weight so that everything stays **under the brine**.',
      // FR: Ferme sans serrer et laisse fermenter 5 à 7 jours à 18–22 °C, sur une assiette.
      'Close without tightening and leave to ferment for 5 to 7 days at 18–22 °C, standing on a plate.',
      // FR: Quand c'est acidulé, serre les couvercles et range au réfrigérateur.
      'Once it is pleasantly sour, tighten the lids and move to the fridge.',
    ],
  ),
  'pourpier/Salade de pourpier': RecipeText(
    // FR: Salade de pourpier
    name: 'Purslane salad',
    // FR: Charnu et citronné, cru avec de la tomate et de la feta.
    description: 'Fleshy and lemony, raw with tomato and feta.',
  ),
  'pourpier/Pourpier sauté à l\'ail': RecipeText(
    // FR: Pourpier sauté à l'ail
    name: 'Garlic-fried purslane',
    // FR: Quelques secondes à la poêle, pas plus.
    description: 'A few seconds in the pan, no more.',
  ),
  'pourpier/Soupe de pourpier à la turque': RecipeText(
    // FR: Soupe de pourpier à la turque
    name: 'Turkish-style purslane soup',
    // FR: Avec du yaourt et du riz, acidulée et nourrissante.
    description: 'With yoghurt and rice: tangy and filling.',
  ),

  // ─────────── prunier (6 recettes) ───────────
  'prunier/Pruneaux maison': RecipeText(
    // FR: Pruneaux maison
    name: 'Homemade prunes',
    // FR: Un prunier croule toujours d'un coup : séchées lentement, les prunes deviennent des pruneaux pour toute l'année.
    description: 'A plum tree always gives everything at once: dried slowly, the plums become prunes for the whole year.',
    // FR: 1 an en bocal, au sec
    keeps: '1 year in a jar, in a dry place',
    ingredients: <String>[
      '3 kg of very ripe Ente plums or quetsches', // FR: 3 kg de prunes d'Ente ou de quetsches bien mûres
      'oven racks', // FR: des grilles de four
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Lave les prunes et garde seulement les plus mûres, celles qui se détachent toutes seules de l'arbre.
      'Wash the plums and keep only the ripest ones, the ones that come away from the tree on their own.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille et l'eau s'évapore mieux.
      'Dip them in boiling water for **30 seconds**: the skin cracks and the water evaporates more easily.',
      // FR: Rafraîchis-les à l'eau froide, puis égoutte-les et sèche-les sur un torchon.
      'Cool them in cold water, then drain them and dry them on a tea towel.',
      // FR: Range-les entières sur des grilles et sèche au four à **60 °C**, porte entrouverte. Tu peux le faire en deux ou trois séances.
      'Lay them whole on racks and dry in the oven at **60 °C**, door ajar. You can do it in two or three sessions.',
      // FR: Teste : le pruneau est ridé, souple, et ne laisse aucun jus quand tu le pinces.
      'Test: a prune is wrinkled, supple, and leaves no juice when you pinch it.',
      // FR: Laisse refroidir et mets en bocal. Surveille la buée la première semaine, sinon remets au four.
      'Let them cool and pack them into jars. Watch for condensation during the first week, and if you see any, put them back in the oven.',
    ],
  ),
  'prunier/Moitiés de prunes au sirop': RecipeText(
    // FR: Moitiés de prunes au sirop
    name: 'Plum halves in syrup',
    // FR: Quetsches ou reines-claudes en bocaux, prêtes pour une tarte d'hiver en dix minutes.
    description: 'Quetsches or greengages in jars, ready for a winter tart in ten minutes.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '2 kg of firm plums', // FR: 2 kg de prunes fermes
      '1 litre of water', // FR: 1 litre d'eau
      '300 g of sugar', // FR: 300 g de sucre
      '5 jars of 50 cl with new seals', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les prunes et écarte celles qui sont abîmées ou trop molles.
      'Wash the plums and set aside any that are bruised or too soft.',
      // FR: Coupe-les en deux et retire le noyau.
      'Cut them in half and remove the stone.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes pour faire le sirop.
      'Bring the water and sugar to the boil for 2 minutes to make the syrup.',
      // FR: Range les moitiés côté peau vers l'extérieur, couvre de sirop chaud **jusqu'à 2 cm du bord** et ferme avec des joints neufs.
      'Arrange the halves skin side out, cover with hot syrup **to 2 cm from the rim** and close with new seals.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Sterilise the jars, completely covered with water, for 25 minutes from the point of boiling.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange vite.
      'Let them cool in the water, then check the vacuum. A jar that has not sealed goes in the fridge and is eaten soon.',
    ],
  ),
  'prunier/Demi-prunes congelées': RecipeText(
    // FR: Demi-prunes congelées
    name: 'Frozen plum halves',
    // FR: Dénoyautées et posées sur plaque, elles sortent du congélateur une à une pour une tarte ou un crumble.
    description: 'Stoned and laid out on a tray, they come out of the freezer one at a time for a tart or a crumble.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of ripe but firm plums', // FR: 2 kg de prunes mûres mais fermes
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les prunes et sèche-les bien sur un torchon.
      'Wash the plums and dry them well on a tea towel.',
      // FR: Coupe-les en deux et retire le noyau.
      'Cut them in half and remove the stone.',
      // FR: Pose-les côté coupé vers le haut sur une plaque, **sans qu'elles se touchent**, et congèle 3 heures.
      'Lay them cut side up on a tray, **not touching each other**, and freeze for 3 hours.',
      // FR: Verse-les en sac une fois dures. Sur une tarte, pose-les encore congelées : elles rendent moins de jus.
      'Tip them into a bag once they are hard. For a tart, put them on still frozen: they release less juice.',
    ],
  ),
  'prunier/Tarte aux prunes': RecipeText(
    // FR: Tarte aux prunes
    name: 'Plum tart',
    // FR: Coupées en deux, côté chair vers le haut, sur de la poudre d'amandes.
    description: 'Cut in half, flesh side up, on a layer of ground almonds.',
  ),
  'prunier/Confiture de prunes': RecipeText(
    // FR: Confiture de prunes
    name: 'Plum jam',
    // FR: Épaisse et foncée, la plus facile des confitures.
    description: 'Thick and dark, the easiest of all jams.',
  ),
  'prunier/Prunes rôties au thym': RecipeText(
    // FR: Prunes rôties au thym
    name: 'Thyme-roasted plums',
    // FR: Salées-sucrées, pour accompagner un canard.
    description: 'Sweet and savoury, to go with duck.',
  ),

  // ─────────── radis (6 recettes) ───────────
  'radis/Pickles de radis roses': RecipeText(
    // FR: Pickles de radis roses
    name: 'Pink radish pickles',
    // FR: Vingt minutes, et une botte qui allait ramollir devient un condiment rose vif pour tout le mois.
    description: 'Twenty minutes, and a bunch that was about to go soft becomes a bright pink condiment for the whole month.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '2 bunches of radishes (about 500 g)', // FR: 2 bottes de radis (environ 500 g)
      '25 cl of cider vinegar at 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '1 tbsp of sugar', // FR: 1 cuillère à soupe de sucre
      '1 tsp of fine salt', // FR: 1 cuillère à café de sel fin
      '1 tsp of mustard seeds', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Coupe les fanes (garde-les pour une soupe) et frotte les radis sous l'eau.
      'Cut off the tops (keep them for a soup) and scrub the radishes under water.',
      // FR: Tranche-les en fines rondelles, ou en quatre s'ils sont petits.
      'Slice them into thin rounds, or into quarters if they are small.',
      // FR: Tasse-les dans deux bocaux propres avec les graines de moutarde.
      'Pack them into two clean jars with the mustard seeds.',
      // FR: Porte à ébullition vinaigre, eau, sucre et sel, juste le temps de tout dissoudre.
      'Bring the vinegar, water, sugar and salt to the boil, just long enough to dissolve everything.',
      // FR: Verse bouillant sur les radis jusqu'à **les couvrir entièrement**, ferme et laisse refroidir.
      'Pour it over the radishes boiling, until **they are completely covered**, close the jars and let them cool.',
      // FR: Range au réfrigérateur. Ils sont bons dès le lendemain, et le rose passe dans le liquide : c'est normal.
      'Keep in the fridge. They are good from the next day, and the pink runs into the liquid: that is normal.',
    ],
  ),
  'radis/Radis lacto-fermentés': RecipeText(
    // FR: Radis lacto-fermentés
    name: 'Lacto-fermented radishes',
    // FR: Dans une simple saumure, ils deviennent acidulés et piquants, et gardent leur croquant des semaines.
    description: 'In a simple brine they turn sour and peppery, and stay crunchy for weeks.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '600 g of radishes', // FR: 600 g de radis
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 tsp of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %, ni plus ni moins.
      'Dissolve **30 g of salt in 1 litre of water**: that is the 3 % brine, no more and no less.',
      // FR: Frotte les radis, coupe la racine et la queue, laisse-les entiers ou coupe les gros en deux.
      'Scrub the radishes, trim off the root and the tail, and leave them whole or halve the big ones.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et le poivre, jusqu'à 3 cm du bord.
      'Pack them into a jar with the crushed garlic and the pepper, up to 3 cm from the rim.',
      // FR: Verse la saumure pour **couvrir entièrement** et pose un poids dessus (un petit pot rempli d'eau). Rien ne doit dépasser.
      'Pour in the brine to **cover completely** and put a weight on top (a small jar filled with water). Nothing should stick out.',
      // FR: Ferme sans serrer et laisse une semaine à 18–22 °C, à l'abri du soleil. Des petites bulles, c'est bon signe.
      'Close without tightening and leave for a week at 18–22 °C, out of the sun. Little bubbles are a good sign.',
      // FR: Goûte : quand c'est assez acide, serre le couvercle et passe au réfrigérateur pour freiner la fermentation.
      'Taste: when it is sour enough, tighten the lid and move to the fridge to slow the fermentation.',
    ],
  ),
  'radis/Soupe de fanes de radis à congeler': RecipeText(
    // FR: Soupe de fanes de radis à congeler
    name: 'Radish top soup to freeze',
    // FR: Les fanes partent souvent au compost : en soupe congelée, elles font un repas gratuit en hiver.
    description: 'The tops often end up on the compost heap: as a frozen soup, they make a free meal in winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      'the tops from 3 bunches of radishes', // FR: les fanes de 3 bottes de radis
      '2 potatoes', // FR: 2 pommes de terre
      '1 onion', // FR: 1 oignon
      '1 litre of stock', // FR: 1 litre de bouillon
      '1 knob of butter, salt, pepper', // FR: 1 noix de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Lave les fanes dans plusieurs eaux et jette les feuilles jaunies ou abîmées.
      'Wash the tops in several changes of water and throw away any yellowed or damaged leaves.',
      // FR: Fais fondre l'oignon émincé au beurre, sans le colorer.
      'Soften the sliced onion in the butter, without letting it colour.',
      // FR: Ajoute les pommes de terre en dés et le bouillon, laisse cuire à couvert.
      'Add the diced potatoes and the stock, and cook with the lid on.',
      // FR: Jette les fanes et compte **3 minutes**, pas plus, pour garder le vert.
      'Add the tops and allow **3 minutes**, no more, to keep them green.',
      // FR: Mixe hors du feu, sale et poivre. Pas de crème : tu l'ajouteras au réchauffage.
      'Blend off the heat, then season with salt and pepper. No cream: you will add it when you reheat.',
      // FR: Refroidis vite la casserole dans l'eau froide, puis répartis en boîtes en laissant 2 cm de vide et congèle.
      'Cool the pan quickly in cold water, then divide into tubs leaving 2 cm of space at the top, and freeze.',
    ],
  ),
  'radis/Radis beurre-sel': RecipeText(
    // FR: Radis beurre-sel
    name: 'Radishes with butter and salt',
    // FR: Cueillis le matin, croqués à midi : rien ne bat la simplicité.
    description: 'Picked in the morning, crunched at lunchtime: nothing beats the simplicity.',
  ),
  'radis/Pesto de fanes de radis': RecipeText(
    // FR: Pesto de fanes de radis
    name: 'Radish top pesto',
    // FR: Les fanes ne se jettent pas : mixées à l'huile et aux amandes, elles font un pesto piquant.
    description: 'Do not throw the tops away: blended with oil and almonds, they make a peppery pesto.',
    ingredients: <String>[
      'The tops from one bunch of radishes', // FR: Les fanes d'une botte de radis
      '50 g of almonds or walnuts', // FR: 50 g d'amandes ou de noix
      '50 g of Parmesan', // FR: 50 g de parmesan
      '10 cl of olive oil', // FR: 10 cl d'huile d'olive
      '1 garlic clove, salt', // FR: 1 gousse d'ail, sel
    ],
    steps: <String>[
      // FR: Trie les fanes : garde les feuilles tendres, jette les tiges dures et les feuilles jaunies.
      'Sort the tops: keep the tender leaves, throw away the tough stems and yellowed leaves.',
      // FR: Lave-les à grande eau et essore-les bien — un pesto mouillé tourne vite.
      'Wash them in plenty of water and spin them dry — a wet pesto turns quickly.',
      // FR: Mixe les fanes avec l'ail, les amandes et le parmesan, par à-coups.
      'Blend the tops with the garlic, almonds and Parmesan, in short bursts.',
      // FR: Verse l'huile en filet, moteur tournant, jusqu'à la texture qui te plaît. Sale.
      'Pour in the oil in a thin stream with the motor running, until it has the texture you like. Add salt.',
      // FR: En bocal, couvert d'huile, il tient une semaine au frais.
      'In a jar, covered with oil, it keeps for a week in the cool.',
    ],
  ),
  'radis/Radis rôtis au four': RecipeText(
    // FR: Radis rôtis au four
    name: 'Oven-roasted radishes',
    // FR: La cuisson les adoucit : ils deviennent doux comme des navets.
    description: 'Cooking softens them: they turn as mild as turnips.',
  ),

  // ─────────── radis_noir (6 recettes) ───────────
  'radis_noir/Radis noir râpé lacto-fermenté': RecipeText(
    // FR: Radis noir râpé lacto-fermenté
    name: 'Lacto-fermented grated black radish',
    // FR: Fermenté, il perd son piquant agressif et devient un condiment acidulé pour les salades et les tartines.
    description: 'Fermented, it loses its harsh bite and becomes a tangy condiment for salads and open sandwiches.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 kg of black radish', // FR: 1 kg de radis noir
      '20 g of fine non-iodised salt (20 g per kg)', // FR: 20 g de sel fin non iodé (20 g par kg)
      '1 carrot', // FR: 1 carotte
      '2 jars of 50 cl', // FR: 2 bocaux de 50 cl
    ],
    steps: <String>[
      // FR: Brosse les radis sous l'eau. Tu peux garder la peau noire, ou l'enlever pour un goût plus doux.
      'Scrub the radishes under water. You can keep the black skin, or peel it for a milder taste.',
      // FR: Râpe le radis et la carotte gros, puis pèse le tout.
      'Coarsely grate the radish and the carrot, then weigh the lot.',
      // FR: Ajoute **20 g de sel par kilo** de légumes râpés et malaxe jusqu'à ce que le jus sorte.
      'Add **20 g of salt per kilo** of grated vegetables and knead until the juice comes out.',
      // FR: Tasse fort dans les bocaux pour faire remonter le jus au-dessus, en laissant 3 cm de vide.
      'Pack firmly into the jars so the juice rises above, leaving 3 cm of space.',
      // FR: Pose un poids pour que **tout reste sous le jus**, et ferme sans serrer.
      'Add a weight so that **everything stays under the juice**, and close without tightening.',
      // FR: Laisse fermenter 1 à 2 semaines à 18–22 °C. Ça sent fort le soufre au début : c'est normal, ça s'adoucit.
      'Leave to ferment for 1 to 2 weeks at 18–22 °C. It smells strongly of sulphur at first: that is normal, and it mellows.',
      // FR: Quand c'est acidulé, serre les couvercles et range au réfrigérateur.
      'Once it is pleasantly sour, tighten the lids and move to the fridge.',
    ],
  ),
  'radis_noir/Rondelles de radis noir au vinaigre': RecipeText(
    // FR: Rondelles de radis noir au vinaigre
    name: 'Pickled black radish rounds',
    // FR: Un quart d'heure, et ses rondelles marbrées de noir deviennent un pickle croquant qui se garde au frais.
    description: 'A quarter of an hour, and its black-marbled rounds become a crunchy pickle that keeps in the fridge.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '600 g of black radish', // FR: 600 g de radis noir
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 30 g of sugar', // FR: 10 g de sel, 30 g de sucre
      '1 tsp of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Brosse bien les radis, garde la peau : c'est elle qui fait le joli liseré noir.
      'Scrub the radishes well and keep the skin: it makes the pretty black edge.',
      // FR: Coupe-les en rondelles fines de 3 mm.
      'Cut them into thin 3 mm rounds.',
      // FR: Remplis deux bocaux ébouillantés avec les rondelles et le poivre.
      'Fill two scalded jars with the rounds and the pepper.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme et laisse refroidir avant de ranger au réfrigérateur.
      'Pour it in boiling to **cover completely**, close the jars and let them cool before putting them in the fridge.',
    ],
  ),
  'radis_noir/Radis noir séché en lanières': RecipeText(
    // FR: Radis noir séché en lanières
    name: 'Dried black radish strips',
    // FR: Comme au Japon avec le daïkon : séché en lanières, il se garde des mois et se réhydrate en dix minutes pour les soupes.
    description: 'The Japanese way, as with daikon: dried in strips, it keeps for months and rehydrates in ten minutes for soups.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      '1.5 kg of black radish', // FR: 1,5 kg de radis noir
      'racks or trays', // FR: des grilles ou plaques
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Épluche les radis et taille-les en fines lanières de 3 mm, comme des allumettes longues.
      'Peel the radishes and cut them into thin 3 mm strips, like long matchsticks.',
      // FR: Étale-les en couche fine sur des grilles et enfourne à 55 °C, porte entrouverte d'une cuillère en bois.
      'Spread them in a thin layer on racks and put them in the oven at 55 °C, the door held ajar with a wooden spoon.',
      // FR: Remue-les toutes les heures. Elles sont prêtes quand elles sont sèches, souples comme du cuir et ne collent plus.
      'Stir them every hour. They are ready when they are dry, supple as leather and no longer sticky.',
      // FR: Laisse-les refroidir et sécher encore une nuit à l'air libre sur un torchon.
      'Let them cool and dry for one more night in the open air on a tea towel.',
      // FR: Mets en bocaux bien secs. Pour les utiliser, trempe-les 10 minutes dans l'eau tiède.
      'Pack them into very dry jars. To use them, soak them for 10 minutes in lukewarm water.',
    ],
  ),
  'radis_noir/Carpaccio de radis noir': RecipeText(
    // FR: Carpaccio de radis noir
    name: 'Black radish carpaccio',
    // FR: Tranché à la mandoline, huile de noix, fleur de sel.
    description: 'Sliced on a mandoline, with walnut oil and flaky salt.',
  ),
  'radis_noir/Radis noir râpé à la pomme': RecipeText(
    // FR: Radis noir râpé à la pomme
    name: 'Grated black radish with apple',
    // FR: La pomme adoucit son piquant.
    description: 'The apple softens its bite.',
  ),
  'radis_noir/Radis noir confit au four': RecipeText(
    // FR: Radis noir confit au four
    name: 'Oven-confit black radish',
    // FR: Il perd son amertume et devient presque sucré.
    description: 'It loses its bitterness and turns almost sweet.',
  ),

  // ─────────── rhubarbe (6 recettes) ───────────
  'rhubarbe/Tronçons de rhubarbe congelés': RecipeText(
    // FR: Tronçons de rhubarbe congelés
    name: 'Frozen rhubarb pieces',
    // FR: Crue, coupée et congelée : la rhubarbe ne demande rien d'autre, et elle sera prête pour toutes tes tartes.
    description: 'Raw, cut up and frozen: rhubarb needs nothing else, and it will be ready for all your tarts.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '2 kg of rhubarb stalks', // FR: 2 kg de tiges de rhubarbe
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe et jette **toutes les feuilles** : elles ne se mangent pas. Retire aussi le pied blanc.
      'Cut off and throw away **all the leaves**: they are not edible. Trim off the white base too.',
      // FR: Rince les tiges et essuie-les bien.
      'Rinse the stalks and dry them well.',
      // FR: Retire les fils des grosses tiges en tirant avec un couteau, puis coupe en tronçons de 2 cm.
      'Pull the strings off the thick stalks with a knife, then cut into 2 cm pieces.',
      // FR: Étale sur une plaque et congèle 2 heures pour qu'ils ne se soudent pas.
      'Spread on a tray and freeze for 2 hours so they do not stick together.',
      // FR: Verse-les en sacs par 500 g, la dose d'une tarte ou d'un crumble. Ils s'utilisent sans décongeler.
      'Tip them into bags of 500 g, enough for one tart or crumble. They can be used without thawing.',
    ],
  ),
  'rhubarbe/Confiture de rhubarbe au gingembre': RecipeText(
    // FR: Confiture de rhubarbe au gingembre
    name: 'Rhubarb and ginger jam',
    // FR: Une nuit de macération dans le sucre, une pointe de gingembre, et la rhubarbe devient une confiture vive et fondante.
    description: 'A night macerating in sugar, a touch of ginger, and rhubarb becomes a bright, melting jam.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '1.5 kg of peeled rhubarb', // FR: 1,5 kg de rhubarbe épluchée
      '1 kg of sugar', // FR: 1 kg de sucre
      'the juice of one lemon', // FR: le jus d'un citron
      '1 piece of fresh ginger, 4 cm', // FR: 1 morceau de gingembre frais de 4 cm
    ],
    steps: <String>[
      // FR: Jette les feuilles, retire les fils et coupe les tiges en tronçons de 1 cm.
      'Throw away the leaves, remove the strings and cut the stalks into 1 cm pieces.',
      // FR: Mélange-les au sucre et au citron dans une bassine, couvre et laisse macérer une nuit : le jus sort tout seul.
      'Mix them with the sugar and lemon in a preserving pan, cover and leave to macerate overnight: the juice comes out by itself.',
      // FR: Épluche le gingembre et râpe-le finement dans la bassine.
      'Peel the ginger and grate it finely into the pan.',
      // FR: Porte à ébullition et cuis à feu vif en remuant et en écumant.
      'Bring to the boil and cook over a high heat, stirring and skimming.',
      // FR: Teste une goutte sur une assiette froide : si elle se fige et se ride sous le doigt, c'est prêt.
      'Test a drop on a cold plate: if it sets and wrinkles under your finger, it is ready.',
      // FR: Mets en pots ébouillantés remplis jusqu'à 1 cm du bord, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pour into scalded jars filled to 1 cm from the rim, close at once and turn them upside down until cool.',
    ],
  ),
  'rhubarbe/Rhubarbe au sirop en bocaux': RecipeText(
    // FR: Rhubarbe au sirop en bocaux
    name: 'Rhubarb in syrup, in jars',
    // FR: Acide comme un fruit, la rhubarbe supporte très bien le bocal : des tronçons entiers prêts à servir sur un yaourt.
    description: 'Tart like a fruit, rhubarb takes to the jar very well: whole pieces ready to serve on yoghurt.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '1.5 kg of rhubarb', // FR: 1,5 kg de rhubarbe
      '1 litre of water', // FR: 1 litre d'eau
      '300 g of sugar', // FR: 300 g de sucre
      'jars with new seals or lids', // FR: des bocaux à joints ou couvercles neufs
    ],
    steps: <String>[
      // FR: Jette les feuilles, retire les fils et coupe les tiges en tronçons de 3 cm.
      'Throw away the leaves, remove the strings and cut the stalks into 3 cm pieces.',
      // FR: Fais bouillir l'eau et le sucre 2 minutes pour obtenir un sirop léger.
      'Boil the water and sugar for 2 minutes to make a light syrup.',
      // FR: Tasse la rhubarbe crue dans des bocaux propres, puis verse le sirop chaud jusqu'à **2 cm du bord**.
      'Pack the raw rhubarb into clean jars, then pour in the hot syrup up to **2 cm from the rim**.',
      // FR: Tapote les bocaux pour chasser les bulles, essuie le bord et ferme avec des joints ou couvercles neufs.
      'Tap the jars to release air bubbles, wipe the rim and close with new seals or lids.',
      // FR: Pose-les dans un grand faitout, couvre-les d'eau et stérilise **20 minutes à partir de l'ébullition**.
      'Stand them in a large pot, cover with water and sterilise for **20 minutes from the point of boiling**.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide : couvercle creux, c'est bon. Sinon, au réfrigérateur et à manger vite.
      'Let them cool in the water, then check the vacuum: a dipped lid is good. If not, it goes in the fridge and is eaten soon.',
    ],
  ),
  'rhubarbe/Tarte à la rhubarbe': RecipeText(
    // FR: Tarte à la rhubarbe
    name: 'Rhubarb tart',
    // FR: Acide et sucrée, sur une pâte brisée avec un appareil à la crème.
    description: 'Tart and sweet, on shortcrust pastry with a creamy custard.',
    ingredients: <String>[
      '800 g of rhubarb stalks', // FR: 800 g de tiges de rhubarbe
      '1 shortcrust pastry', // FR: 1 pâte brisée
      '150 g of sugar', // FR: 150 g de sucre
      '2 eggs, 20 cl of cream', // FR: 2 œufs, 20 cl de crème
      '1 tbsp of ground almonds', // FR: 1 c. à s. de poudre d'amandes
    ],
    steps: <String>[
      // FR: Coupe la rhubarbe en tronçons de 2 cm. Pas besoin de l'éplucher si les tiges sont jeunes.
      'Cut the rhubarb into 2 cm pieces. No need to peel it if the stalks are young.',
      // FR: Saupoudre-la de la moitié du sucre et laisse dégorger : tu jetteras l'eau rendue, sinon la tarte détrempe.
      'Sprinkle it with half the sugar and leave it to draw out its juice: throw away the water it gives off, or the tart will go soggy.',
      // FR: Étale la pâte, pique-la, saupoudre le fond de poudre d'amandes — elle boira le jus restant.
      'Roll out the pastry, prick it and sprinkle the base with ground almonds — they will soak up the remaining juice.',
      // FR: Bats les œufs, la crème et le reste du sucre. Range la rhubarbe, verse l'appareil.
      'Beat the eggs, the cream and the rest of the sugar. Arrange the rhubarb and pour the custard over.',
      // FR: Four à 180 °C jusqu'à ce que la crème soit prise et dorée.
      'Oven at 180 °C until the custard is set and golden.',
    ],
  ),
  'rhubarbe/Compote de rhubarbe': RecipeText(
    // FR: Compote de rhubarbe
    name: 'Rhubarb compote',
    // FR: À peine sucrée, sur un fromage blanc.
    description: 'Barely sweetened, on fromage blanc.',
  ),
  'rhubarbe/Crumble rhubarbe-fraise': RecipeText(
    // FR: Crumble rhubarbe-fraise
    name: 'Rhubarb and strawberry crumble',
    // FR: L'acidité de l'une, le sucre de l'autre, du beurre dessus.
    description: 'The tartness of one, the sweetness of the other, with butter on top.',
  ),

  // ─────────── romarin (6 recettes) ───────────
  'romarin/Romarin séché en bottes': RecipeText(
    // FR: Romarin séché en bottes
    name: 'Rosemary dried in bunches',
    // FR: Le romarin pousse toute l'année, mais une botte séchée sous la main évite d'aller au jardin sous la pluie.
    description: 'Rosemary grows all year round, but a dried bunch to hand saves you going out to the garden in the rain.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 year in a jar, away from light',
    ingredients: <String>[
      'an armful of rosemary sprigs', // FR: une brassée de branches de romarin
      'kitchen string', // FR: de la ficelle de cuisine
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Coupe des branches de 15 cm sur les pousses de l'année, en fin de matinée par temps sec.
      'Cut 15 cm sprigs from this year\'s shoots, late in the morning in dry weather.',
      // FR: Ne les lave que si elles sont sales, et sèche-les bien sur un torchon.
      'Only wash them if they are dirty, and dry them well on a tea towel.',
      // FR: Lie-les en petites bottes d'une dizaine de branches, bien serrées.
      'Tie them into small, tight bunches of about ten sprigs.',
      // FR: Suspends-les tête en bas dans un endroit sec, sombre et aéré, pendant 10 jours.
      'Hang them upside down in a dry, dark, airy place for 10 days.',
      // FR: Teste : les aiguilles se détachent en passant les doigts le long de la tige et se cassent net.
      'Test: the needles come away when you run your fingers down the stem, and snap cleanly.',
      // FR: Égrène les aiguilles en bocal fermé. **Garde-les entières** et écrase-les au moment de cuisiner : le parfum reste dedans.
      'Strip the needles into a closed jar. **Keep them whole** and crush them just as you cook: the fragrance stays inside.',
    ],
  ),
  'romarin/Gelée pomme-romarin': RecipeText(
    // FR: Gelée pomme-romarin
    name: 'Apple and rosemary jelly',
    // FR: La gelée des Anglais pour l'agneau : la pomme fait prendre, le romarin parfume.
    description: 'The British jelly for lamb: the apple makes it set, the rosemary scents it.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1.5 kg of tart apples', // FR: 1,5 kg de pommes acidulées
      '1.5 litres of water', // FR: 1,5 litre d'eau
      '800 g of sugar per litre of juice', // FR: 800 g de sucre par litre de jus
      'the juice of one lemon', // FR: le jus d'un citron
      '4 sprigs of rosemary', // FR: 4 branches de romarin
      '6 small jam jars', // FR: 6 petits pots de confiture
    ],
    steps: <String>[
      // FR: Coupe les pommes en morceaux **avec peau et pépins** : c'est là qu'est la pectine.
      'Cut the apples into pieces **with the skin and pips**: that is where the pectin is.',
      // FR: Cuis-les dans l'eau à couvert, jusqu'à ce qu'elles soient en bouillie.
      'Cook them in the water with the lid on, until they fall apart.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter **sans presser**, pour une gelée limpide.
      'Pour into a clean cloth set over a sieve and leave to drip **without pressing**, for a clear jelly.',
      // FR: Mesure le jus, ajoute 800 g de sucre par litre, le citron et les branches de romarin, puis porte à ébullition.
      'Measure the juice, add 800 g of sugar per litre, the lemon and the rosemary sprigs, then bring to the boil.',
      // FR: Cuis à gros bouillons en écumant, puis teste sur une assiette froide : une goutte qui se fige est prête.
      'Boil hard, skimming, then test on a cold plate: a drop that sets is ready.',
      // FR: Retire les branches, ajoute une pincée d'aiguilles hachées, mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Remove the sprigs, add a pinch of chopped needles, pour into scalded jars, close and turn upside down until cool.',
    ],
  ),
  'romarin/Romarin haché en cubes': RecipeText(
    // FR: Romarin haché en cubes
    name: 'Chopped rosemary cubes',
    // FR: Haché une fois, congelé à l'huile d'olive : un cube pour des pommes de terre sautées ou un rôti.
    description: 'Chopped once, frozen in olive oil: one cube for sautéed potatoes or a roast.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '6 sprigs of rosemary', // FR: 6 branches de romarin
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      'an ice cube tray', // FR: un bac à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les branches et **sèche-les parfaitement** sur un torchon.
      'Rinse the sprigs and **dry them thoroughly** on a tea towel.',
      // FR: Égrène les aiguilles et hache-les finement : entières, elles restent dures sous la dent.
      'Strip the needles and chop them finely: whole, they stay hard to bite.',
      // FR: Mets une cuillère à soupe d'aiguilles par case et couvre d'huile d'olive.
      'Put one tablespoon of needles in each compartment and cover with olive oil.',
      // FR: Congèle jusqu'à ce que ce soit bien dur.
      'Freeze until rock hard.',
      // FR: Démoule et garde en sac. Le cube va **directement dans la poêle ou le plat**, sans attendre à température ambiante.
      'Pop them out and keep them in a bag. The cube goes **straight into the pan or dish**, without waiting at room temperature.',
    ],
  ),
  'romarin/Pommes de terre au romarin': RecipeText(
    // FR: Pommes de terre au romarin
    name: 'Rosemary potatoes',
    // FR: En quartiers, gros sel, branches entières au four.
    description: 'In wedges, with coarse salt and whole sprigs in the oven.',
  ),
  'romarin/Sirop de romarin': RecipeText(
    // FR: Sirop de romarin
    name: 'Rosemary syrup',
    // FR: Pour un citron pressé ou un cocktail sans alcool.
    description: 'For a fresh lemonade or an alcohol-free cocktail.',
  ),
  'romarin/Focaccia au romarin': RecipeText(
    // FR: Focaccia au romarin
    name: 'Rosemary focaccia',
    // FR: Les aiguilles enfoncées dans la pâte avant cuisson.
    description: 'The needles pressed into the dough before baking.',
  ),

  // ─────────── roquette (6 recettes) ───────────
  'roquette/Cubes de roquette à l\'huile': RecipeText(
    // FR: Cubes de roquette à l'huile
    name: 'Rocket cubes in oil',
    // FR: Quand la roquette monte toute d'un coup, mixée et congelée elle relève une soupe ou une sauce en un cube.
    description: 'When the rocket bolts all at once, blended and frozen it lifts a soup or a sauce in a single cube.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '300 g of rocket', // FR: 300 g de roquette
      '10 cl of olive oil', // FR: 10 cl d'huile d'olive
      '1 pinch of salt', // FR: 1 pincée de sel
      'an ice cube tray', // FR: un bac à glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave la roquette et **sèche-la bien** à l'essoreuse : l'eau fait des cubes givrés et fades.
      'Wash the rocket and **dry it well** in a salad spinner: water makes frosty, bland cubes.',
      // FR: Retire les tiges les plus dures et les feuilles jaunies.
      'Remove the toughest stems and any yellowed leaves.',
      // FR: Mixe par à-coups avec l'huile et le sel, jusqu'à une purée grossière.
      'Blend in short bursts with the oil and salt, to a rough purée.',
      // FR: Remplis le bac à glaçons, tasse bien et congèle jusqu'à ce que ce soit dur.
      'Fill the ice cube tray, pack it down well and freeze until hard.',
      // FR: Démoule les cubes et garde-les en sac. Utilise-les **directement gelés**, sans les laisser dégeler à l'air.
      'Pop out the cubes and keep them in a bag. Use them **straight from frozen**, without letting them thaw in the air.',
    ],
  ),
  'roquette/Roquette fondue à congeler': RecipeText(
    // FR: Roquette fondue à congeler
    name: 'Wilted rocket to freeze',
    // FR: Juste tombée à la poêle et pressée, la roquette perd son volume mais garde son piquant pour l'hiver.
    description: 'Just wilted in the pan and pressed, rocket loses its volume but keeps its peppery bite for winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '800 g of rocket', // FR: 800 g de roquette
      '2 garlic cloves', // FR: 2 gousses d'ail
      '2 tbsp of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave la roquette dans plusieurs eaux et égoutte-la grossièrement.
      'Wash the rocket in several changes of water and drain it roughly.',
      // FR: Fais chauffer l'huile avec l'ail écrasé une minute, sans le laisser brunir.
      'Heat the oil with the crushed garlic for a minute, without letting it brown.',
      // FR: Jette la roquette par poignées et remue jusqu'à ce qu'elle tombe, **2 minutes** en tout.
      'Add the rocket by the handful and stir until it wilts, **2 minutes** in all.',
      // FR: Sale légèrement, retire l'ail et laisse refroidir dans une passoire.
      'Salt lightly, remove the garlic and leave to cool in a colander.',
      // FR: Presse fort pour chasser le jus, puis forme des galets d'une portion.
      'Press hard to squeeze out the juice, then shape into single-portion pucks.',
      // FR: Congèle-les sur une plaque, puis mets-les en sac. Parfaits dans des pâtes, une omelette ou une pizza.
      'Freeze them on a tray, then put them in a bag. Perfect in pasta, an omelette or on a pizza.',
    ],
  ),
  'roquette/Poudre de roquette séchée': RecipeText(
    // FR: Poudre de roquette séchée
    name: 'Dried rocket powder',
    // FR: Séchée doucement et réduite en poudre, elle saupoudre les œufs, le fromage frais et les soupes d'un piquant poivré.
    description: 'Dried gently and ground to a powder, it sprinkles a peppery kick over eggs, fresh cheese and soups.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      '400 g of rocket', // FR: 400 g de roquette
      'baking paper', // FR: du papier cuisson
      'a small, very dry glass jar', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Lave la roquette et sèche-la parfaitement à l'essoreuse puis au torchon.
      'Wash the rocket and dry it thoroughly, first in a salad spinner and then with a tea towel.',
      // FR: Retire les grosses tiges, elles sèchent bien plus lentement que les feuilles.
      'Remove the thick stems: they dry far more slowly than the leaves.',
      // FR: Étale les feuilles en une seule couche et sèche au four à **50 °C**, porte entrouverte.
      'Spread the leaves in a single layer and dry in the oven at **50 °C**, door ajar.',
      // FR: Elles sont prêtes quand elles **crissent** et s'émiettent. Souples, laisse-les encore.
      'They are ready when they **crackle** and crumble. If they are still supple, leave them longer.',
      // FR: Une fois froides, émiette-les ou mixe-les en poudre, puis mets en pot bien fermé.
      'Once cold, crumble them or blend them to a powder, then put them in a tightly closed jar.',
    ],
  ),
  'roquette/Pesto de roquette': RecipeText(
    // FR: Pesto de roquette
    name: 'Rocket pesto',
    // FR: Plus poivré que le basilic, parfait quand la roquette monte.
    description: 'Peppier than basil, perfect when the rocket bolts.',
    ingredients: <String>[
      '100 g of rocket', // FR: 100 g de roquette
      '50 g of Parmesan', // FR: 50 g de parmesan
      '40 g of pine nuts or almonds', // FR: 40 g de pignons ou d'amandes
      '10 cl of olive oil', // FR: 10 cl d'huile d'olive
      '1 garlic clove, salt', // FR: 1 gousse d'ail, sel
    ],
    steps: <String>[
      // FR: Fais torréfier les pignons à sec 2 minutes : ça change tout.
      'Dry-toast the pine nuts for 2 minutes: it changes everything.',
      // FR: Mixe roquette, ail, pignons et parmesan par à-coups.
      'Blend the rocket, garlic, pine nuts and Parmesan in short bursts.',
      // FR: Verse l'huile en filet, mixeur en marche, jusqu'à une pâte souple.
      'Pour in the oil in a thin stream with the blender running, to a smooth paste.',
      // FR: Sale peu — le parmesan sale déjà. Un trait de citron si c'est trop amer.
      'Go easy on the salt — Parmesan is already salty. Add a squeeze of lemon if it is too bitter.',
    ],
  ),
  'roquette/Roquette, parmesan, citron': RecipeText(
    // FR: Roquette, parmesan, citron
    name: 'Rocket, Parmesan, lemon',
    // FR: Trois ingrédients, dix secondes : la salade des restaurants italiens.
    description: 'Three ingredients, ten seconds: the salad of Italian restaurants.',
    ingredients: <String>[
      '150 g of rocket', // FR: 150 g de roquette
      '80 g of Parmesan', // FR: 80 g de parmesan
      '1 lemon', // FR: 1 citron
      '3 tbsp of olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      'pepper', // FR: poivre
    ],
    steps: <String>[
      // FR: Dispose la roquette, à peine lavée et bien séchée.
      'Arrange the rocket, barely washed and well dried.',
      // FR: Jus de citron, huile, poivre — pas de sel, le parmesan y pourvoit.
      'Lemon juice, oil, pepper — no salt, the Parmesan takes care of that.',
      // FR: Copeaux de parmesan à l'économe, généreusement.
      'Shave the Parmesan with a peeler, generously.',
      // FR: Mélange dans l'assiette, sers tout de suite.
      'Toss on the plate and serve at once.',
    ],
  ),
  'roquette/Velouté de roquette et pomme de terre': RecipeText(
    // FR: Velouté de roquette et pomme de terre
    name: 'Rocket and potato soup',
    // FR: La pomme de terre arrondit le poivré de la roquette.
    description: 'The potato rounds off the pepperiness of the rocket.',
    ingredients: <String>[
      '200 g of rocket', // FR: 200 g de roquette
      '3 potatoes', // FR: 3 pommes de terre
      '1 onion', // FR: 1 oignon
      '80 cl of stock', // FR: 80 cl de bouillon
      'cream, salt, pepper', // FR: crème, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon, ajoute les pommes de terre.
      'Soften the onion, then add the potatoes.',
      // FR: Bouillon, et cuis 20 minutes.
      'Add the stock and cook for 20 minutes.',
      // FR: Ajoute la roquette 2 minutes avant la fin.
      'Add the rocket 2 minutes before the end.',
      // FR: Mixe. Goûte avant de saler : la roquette est déjà forte.
      'Blend. Taste before salting: rocket is already strong.',
    ],
  ),

  // ─────────── rutabaga (6 recettes) ───────────
  'rutabaga/Dés de rutabaga blanchis': RecipeText(
    // FR: Dés de rutabaga blanchis
    name: 'Blanched swede cubes',
    // FR: Coupé en dés et blanchi trois minutes, il est prêt pour les potées et les rôtis de tout l'hiver.
    description: 'Diced and blanched for three minutes, it is ready for stews and roasts all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of swedes', // FR: 2 kg de rutabagas
      'coarse salt', // FR: gros sel
      '1 large bowl of iced water', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche généreusement : la peau est épaisse, surtout sur les gros. Coupe en dés de 2 cm.
      'Peel generously: the skin is thick, especially on the big ones. Cut into 2 cm cubes.',
      // FR: Blanchis les dés **3 minutes** dans une grande eau bouillante salée.
      'Blanch the cubes for **3 minutes** in a large pan of salted boiling water.',
      // FR: Plonge-les aussitôt dans l'eau glacée.
      'Plunge them straight into the iced water.',
      // FR: Égoutte et sèche sur un torchon.
      'Drain and dry on a tea towel.',
      // FR: Congèle sur plaque 2 heures, puis mets en sacs datés.
      'Freeze on a tray for 2 hours, then put them in dated bags.',
    ],
  ),
  'rutabaga/Rutabaga râpé fermenté': RecipeText(
    // FR: Rutabaga râpé fermenté
    name: 'Fermented grated swede',
    // FR: Râpé et salé comme une choucroute, il devient une sorte de « choucroute de navet » douce et acidulée.
    description: 'Grated and salted like sauerkraut, it becomes a mild, tangy "turnip sauerkraut".',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '2 kg of swedes', // FR: 2 kg de rutabagas
      '40 g of fine non-iodised salt (20 g per kg)', // FR: 40 g de sel fin non iodé (20 g par kg)
      '1 tsp of juniper berries', // FR: 1 cuillère à café de baies de genièvre
      '3 jars of 75 cl', // FR: 3 bocaux de 75 cl
    ],
    steps: <String>[
      // FR: Épluche les rutabagas et râpe-les gros.
      'Peel the swedes and grate them coarsely.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**, avec le genièvre.
      'Weigh the grated swede and add **20 g of salt per kilo**, with the juniper.',
      // FR: Malaxe à pleines mains jusqu'à ce que le jus perle, une dizaine de minutes.
      'Knead with your hands until the juice beads, about ten minutes.',
      // FR: Tasse très fort dans les bocaux pour que le jus remonte au-dessus, en laissant 3 cm de vide.
      'Pack very firmly into the jars so the juice rises above, leaving 3 cm of space.',
      // FR: Pose un poids pour garder la râpée **sous son jus**. S'il en manque, complète avec de l'eau salée à 30 g par litre.
      'Add a weight to keep the grated swede **under its juice**. If there is not enough, top up with brine at 30 g of salt per litre.',
      // FR: Ferme sans serrer et laisse fermenter 3 semaines à 18–22 °C, sur une assiette.
      'Close without tightening and leave to ferment for 3 weeks at 18–22 °C, standing on a plate.',
      // FR: Quand c'est acidulé, serre les couvercles et passe au réfrigérateur.
      'Once it is pleasantly sour, tighten the lids and move to the fridge.',
    ],
  ),
  'rutabaga/Pickles de rutabaga au gingembre': RecipeText(
    // FR: Pickles de rutabaga au gingembre
    name: 'Ginger pickled swede',
    // FR: En fins bâtonnets, son goût de chou sucré prend très bien le vinaigre et le gingembre.
    description: 'Cut into thin sticks, its sweet cabbagey flavour takes very well to vinegar and ginger.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '700 g of swede', // FR: 700 g de rutabaga
      '30 cl of white vinegar at 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl of water', // FR: 30 cl d'eau
      '12 g of salt, 40 g of sugar', // FR: 12 g de sel, 40 g de sucre
      '1 piece of ginger, 3 cm', // FR: 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Épluche le rutabaga et taille-le en fins bâtonnets de 5 mm, le gingembre en lamelles.
      'Peel the swede and cut it into thin 5 mm sticks, and the ginger into slices.',
      // FR: Serre-les dans deux bocaux ébouillantés.
      'Pack them tightly into two scalded jars.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement** et ferme aussitôt.
      'Pour it in boiling to **cover completely** and close at once.',
      // FR: Laisse refroidir puis range au réfrigérateur. Attends 3 jours avant d'ouvrir.
      'Let them cool, then keep in the fridge. Wait 3 days before opening.',
    ],
  ),
  'rutabaga/Purée de rutabaga': RecipeText(
    // FR: Purée de rutabaga
    name: 'Swede mash',
    // FR: Avec une pomme de terre et beaucoup de beurre.
    description: 'With a potato and plenty of butter.',
  ),
  'rutabaga/Rutabaga rôti aux épices': RecipeText(
    // FR: Rutabaga rôti aux épices
    name: 'Spiced roasted swede',
    // FR: En cubes, paprika fumé, four chaud.
    description: 'Cubed, with smoked paprika, in a hot oven.',
  ),
  'rutabaga/Potée au rutabaga': RecipeText(
    // FR: Potée au rutabaga
    name: 'Swede hotpot',
    // FR: Avec chou, carotte et lard, le plat des jours froids.
    description: 'With cabbage, carrot and bacon: the dish for cold days.',
  ),

  // ─────────── salsifis (6 recettes) ───────────
  'salsifis/Salsifis précuits au congélateur': RecipeText(
    // FR: Salsifis précuits au congélateur
    name: 'Pre-cooked salsify for the freezer',
    // FR: Le salsifis se pèle une fois pour toutes : précuit et congelé, il est prêt pour la crème ou la poêle.
    description: 'Salsify is peeled once and for all: pre-cooked and frozen, it is ready for cream or the frying pan.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 kg of salsify', // FR: 1 kg de salsifis
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '1 tbsp of flour', // FR: 1 cuillère à soupe de farine
      'coarse salt', // FR: gros sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les racines sous l'eau, puis prépare un saladier d'eau froide additionnée du jus d'un citron.
      'Scrub the roots under water, then prepare a bowl of cold water with the juice of one lemon.',
      // FR: Épluche-les **avec des gants** à l'économe (le latex colle et tache les doigts), coupe en tronçons de 5 cm et jette-les aussitôt dans l'eau citronnée : ils noircissent à l'air.
      'Peel them with a peeler, **wearing gloves** (the latex sticks to and stains your fingers), cut into 5 cm lengths and drop them straight into the lemon water: they go black in the air.',
      // FR: Délaie la farine dans une grande eau bouillante salée avec le reste du citron, et cuis les tronçons **5 minutes** : ils restent blancs et fermes.
      'Whisk the flour into a large pan of salted boiling water with the rest of the lemon, and cook the pieces for **5 minutes**: they stay white and firm.',
      // FR: Égoutte puis plonge-les dans l'eau glacée.
      'Drain, then plunge them into iced water.',
      // FR: Sèche-les bien sur un torchon.
      'Dry them well on a tea towel.',
      // FR: Congèle sur plaque 2 heures, puis mets en sacs datés. À cuire ensuite 10 minutes, encore gelés.
      'Freeze on a tray for 2 hours, then put them in dated bags. Cook them afterwards for 10 minutes, still frozen.',
    ],
  ),
  'salsifis/Salsifis au vinaigre et à l\'estragon': RecipeText(
    // FR: Salsifis au vinaigre et à l'estragon
    name: 'Salsify pickled in vinegar and tarragon',
    // FR: Leur goût d'huître et d'artichaut se marie très bien au vinaigre : un condiment rare et élégant.
    description: 'Their oyster-and-artichoke flavour goes very well with vinegar: a rare, elegant condiment.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '800 g of salsify', // FR: 800 g de salsifis
      '30 cl of white vinegar at 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl of water', // FR: 30 cl d'eau
      '12 g of salt, 20 g of sugar', // FR: 12 g de sel, 20 g de sucre
      'a few sprigs of tarragon', // FR: quelques brins d'estragon
      'the juice of one lemon', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Épluche les salsifis avec des gants, coupe-les en bâtonnets et plonge-les dans l'eau citronnée au fur et à mesure.
      'Peel the salsify with gloves on, cut it into sticks and drop it into the lemon water as you go.',
      // FR: Cuis-les **5 minutes** à l'eau bouillante salée : crus, ils restent trop fibreux.
      'Cook it for **5 minutes** in salted boiling water: raw, it stays too fibrous.',
      // FR: Égoutte et rafraîchis à l'eau froide.
      'Drain and cool under cold water.',
      // FR: Range-les debout dans deux bocaux ébouillantés avec l'estragon.
      'Stand the sticks upright in two scalded jars with the tarragon.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel et le sucre.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur. Attends 3 jours avant d'y goûter.
      'Pour it in boiling to **cover completely**, close, let it cool and keep in the fridge. Wait 3 days before tasting.',
    ],
  ),
  'salsifis/Poêlée de salsifis au beurre à congeler': RecipeText(
    // FR: Poêlée de salsifis au beurre à congeler
    name: 'Buttered salsify sauté to freeze',
    // FR: Dorés au beurre et à l'échalote, puis congelés : ils n'ont plus qu'à réchauffer à la poêle.
    description: 'Browned in butter with shallot, then frozen: all it needs is reheating in a pan.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of salsify', // FR: 1,5 kg de salsifis
      '40 g of butter', // FR: 40 g de beurre
      '2 shallots', // FR: 2 échalotes
      '1 bunch of parsley', // FR: 1 bouquet de persil
      'the juice of one lemon, salt', // FR: le jus d'un citron, sel
    ],
    steps: <String>[
      // FR: Épluche les salsifis avec des gants, coupe-les en tronçons et garde-les dans l'eau citronnée.
      'Peel the salsify with gloves on, cut it into lengths and keep it in the lemon water.',
      // FR: Cuis-les 10 minutes à l'eau bouillante salée, puis égoutte.
      'Cook it for 10 minutes in salted boiling water, then drain.',
      // FR: Fais fondre les échalotes émincées dans le beurre, ajoute les salsifis et fais-les dorer 10 minutes.
      'Soften the sliced shallots in the butter, add the salsify and brown it for 10 minutes.',
      // FR: Hors du feu, ajoute le persil haché et sale.
      'Off the heat, add the chopped parsley and salt.',
      // FR: Étale sur une plaque et laisse refroidir complètement.
      'Spread on a tray and leave to cool completely.',
      // FR: Mets en sacs d'une portion, à plat, et date-les.
      'Pack it flat into single-portion bags and write the date on them.',
    ],
  ),
  'salsifis/Salsifis à la crème': RecipeText(
    // FR: Salsifis à la crème
    name: 'Salsify in cream',
    // FR: Épluchés dans l'eau citronnée, sinon ils noircissent.
    description: 'Peel it in lemon water, or it goes black.',
  ),
  'salsifis/Salsifis frits': RecipeText(
    // FR: Salsifis frits
    name: 'Fried salsify',
    // FR: En beignets, croustillants dehors, fondants dedans.
    description: 'As fritters, crisp outside and soft inside.',
  ),
  'salsifis/Gratin de salsifis au jambon': RecipeText(
    // FR: Gratin de salsifis au jambon
    name: 'Salsify and ham gratin',
    // FR: Un plat d'hiver qu'on a tort d'avoir oublié.
    description: 'A winter dish that was wrongly forgotten.',
  ),

  // ─────────── sarrasin (6 recettes) ───────────
  'sarrasin/Grains de sarrasin battus et séchés': RecipeText(
    // FR: Grains de sarrasin battus et séchés
    name: 'Threshed and dried buckwheat grain',
    // FR: Battu, vanné, bien sec : le grain se garde un an et tu le moudras au fur et à mesure.
    description: 'Threshed, winnowed, bone dry: the grain keeps for a year and you grind it as you go.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, safe from insects',
    ingredients: <String>[
      'buckwheat stalks that are three-quarters brown', // FR: les tiges de sarrasin aux trois quarts brunes
      'a tarpaulin or an old sheet', // FR: une bâche ou un vieux drap
      'a stick', // FR: un bâton
      'well-sealed jars or buckets', // FR: des bocaux ou seaux bien fermés
    ],
    steps: <String>[
      // FR: Fauche quand **les trois quarts** des grains sont bruns : si tu attends qu'ils le soient tous, les premiers tombent au sol.
      'Cut when **three-quarters** of the grains are brown: if you wait until they all are, the first ones fall to the ground.',
      // FR: Fais de petites bottes et laisse-les debout sous un abri aéré pendant 10 jours.
      'Make small bundles and leave them standing under an airy shelter for 10 days.',
      // FR: Bats les bottes sur une bâche avec un bâton, ou frotte les têtes entre tes mains gantées.
      'Beat the bundles on a tarpaulin with a stick, or rub the heads between your gloved hands.',
      // FR: Vanne devant un ventilateur ou par vent léger : les débris s'envolent, les grains triangulaires retombent.
      'Winnow in front of a fan or in a light breeze: the debris blows away, and the triangular grains fall back.',
      // FR: Étale les grains en couche fine 3 jours pour finir de sécher : ils doivent se casser net sous la dent.
      'Spread the grains in a thin layer for 3 days to finish drying: they should snap cleanly between your teeth.',
      // FR: Passe-les 48 heures au congélateur contre les mites, puis range-les en bocaux bien fermés, au frais et au sec.
      'Put them in the freezer for 48 hours against moths, then store in well-sealed jars, somewhere cool and dry.',
    ],
  ),
  'sarrasin/Farine de blé noir maison': RecipeText(
    // FR: Farine de blé noir maison
    name: 'Homemade buckwheat flour',
    // FR: Moulue au dernier moment, elle a un parfum que la farine du commerce a perdu depuis longtemps.
    description: 'Ground at the last moment, it has a fragrance that shop-bought flour lost long ago.',
    // FR: 3 mois au sec, en bocal fermé
    keeps: '3 months in a dry place, in a closed jar',
    ingredients: <String>[
      '500 g of very dry buckwheat grains', // FR: 500 g de grains de sarrasin bien secs
      'a grain mill or a powerful blender', // FR: un moulin à céréales ou un blender puissant
      'a fine sieve', // FR: un tamis fin
      'a glass jar', // FR: un bocal en verre
    ],
    steps: <String>[
      // FR: Passe les grains au moulin en réglage fin, **par petites quantités** pour que la farine ne chauffe pas.
      'Put the grains through the mill on a fine setting, **in small batches** so the flour does not heat up.',
      // FR: Tamise : la farine grise passe, les morceaux d'écorce noire restent dans le tamis.
      'Sift: the grey flour goes through, and the pieces of black husk stay in the sieve.',
      // FR: Repasse au moulin ce qui reste, puis tamise encore. Les écorces vides partent au compost.
      'Run what is left through the mill again, then sift once more. The empty husks go on the compost.',
      // FR: Mets en bocal fermé et note la date. Une farine complète rancit vite : mouds-en peu à la fois.
      'Put it in a closed jar and note the date. Wholemeal flour goes rancid quickly: grind only a little at a time.',
    ],
  ),
  'sarrasin/Pile de galettes de blé noir congelées': RecipeText(
    // FR: Pile de galettes de blé noir congelées
    name: 'Stack of frozen buckwheat galettes',
    // FR: Une séance de crêpière pour douze dîners : elles passent du congélateur à la poêle sans se casser.
    description: 'One session at the crêpe pan for twelve dinners: they go from the freezer to the pan without breaking.',
    // FR: 3 mois au congélateur
    keeps: '3 months in the freezer',
    ingredients: <String>[
      '500 g of buckwheat flour', // FR: 500 g de farine de sarrasin
      '1 litre of cold water', // FR: 1 litre d'eau froide
      '1 egg', // FR: 1 œuf
      '10 g of coarse salt', // FR: 10 g de gros sel
      'butter for the pan', // FR: du beurre pour la poêle
      'baking paper', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Mélange farine et sel, verse l'eau petit à petit en fouettant, puis l'œuf : une pâte lisse et assez fluide.
      'Mix the flour and salt, pour in the water a little at a time, whisking, then add the egg: a smooth, fairly runny batter.',
      // FR: Laisse reposer **2 heures** au frais : la pâte prend du corps et les galettes se tiennent mieux.
      'Leave to rest for **2 hours** in the cool: the batter gains body and the galettes hold together better.',
      // FR: Cuis les galettes dans une poêle bien chaude et beurrée, une minute de chaque côté, sans les garnir.
      'Cook the galettes in a very hot buttered pan, one minute on each side, with no filling.',
      // FR: Laisse-les refroidir à plat sur une grille, **sans les empiler chaudes** : la vapeur les ramollit.
      'Let them cool flat on a rack, **without stacking them while hot**: the steam makes them soggy.',
      // FR: Empile-les avec une feuille de papier cuisson entre chaque, glisse la pile dans un grand sac à plat et congèle.
      'Stack them with a sheet of baking paper between each, slide the stack flat into a large bag and freeze.',
      // FR: Le jour venu, pose une galette encore congelée dans la poêle chaude et garnis-la : deux minutes suffisent.
      'When the day comes, put a galette in the hot pan still frozen and add the filling: two minutes is enough.',
    ],
  ),
  'sarrasin/Galettes de sarrasin': RecipeText(
    // FR: Galettes de sarrasin
    name: 'Buckwheat galettes',
    // FR: Farine, eau, sel, et du repos. Rien d'autre.
    description: 'Flour, water, salt, and rest. Nothing else.',
  ),
  'sarrasin/Kacha': RecipeText(
    // FR: Kacha
    name: 'Kasha',
    // FR: Grains grillés puis gonflés au bouillon.
    description: 'Toasted grains swollen in stock.',
  ),
  'sarrasin/Salade de sarrasin aux herbes': RecipeText(
    // FR: Salade de sarrasin aux herbes
    name: 'Buckwheat salad with herbs',
    // FR: Froid, avec tout ce que le jardin donne ce jour-là.
    description: 'Cold, with everything the garden gives that day.',
  ),

  // ─────────── sarriette (6 recettes) ───────────
  'sarriette/Bottes de sarriette séchées': RecipeText(
    // FR: Bottes de sarriette séchées
    name: 'Summer savory dried in bunches',
    // FR: La sarriette garde presque tout son poivre au séchage : une botte suffit pour tous tes haricots de l'hiver.
    description: 'Savory keeps almost all its pepperiness when dried: one bunch is enough for all your winter beans.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'savory stems at the start of flowering', // FR: des tiges de sarriette en début de floraison
      'string', // FR: de la ficelle
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges au début de la floraison, par une journée sèche, en laissant 10 cm à la plante.
      'Cut the stems at the start of flowering, on a dry day, leaving 10 cm on the plant.',
      // FR: Lie-les en petites bottes et retire les feuilles du bas, qui toucheraient la ficelle.
      'Tie them into small bunches and strip off the lower leaves, which would touch the string.',
      // FR: Suspends-les tête en bas dans un endroit sombre, sec et aéré, une dizaine de jours.
      'Hang them upside down in a dark, dry, airy place for about ten days.',
      // FR: Elles sont prêtes quand les tiges cassent au lieu de plier.
      'They are ready when the stems snap instead of bending.',
      // FR: Égrène feuilles et fleurs dans un bocal, ou garde quelques brins entiers à glisser dans la cocotte.
      'Strip the leaves and flowers into a jar, or keep a few whole sprigs to slip into the casserole.',
    ],
  ),
  'sarriette/Vinaigre de vin à la sarriette': RecipeText(
    // FR: Vinaigre de vin à la sarriette
    name: 'Savory wine vinegar',
    // FR: Un vinaigre poivré qui réveille les salades de haricots, de lentilles ou de pois chiches.
    description: 'A peppery vinegar that wakes up bean, lentil or chickpea salads.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, away from light',
    ingredients: <String>[
      '6 sprigs of fresh savory', // FR: 6 brins de sarriette fraîche
      '75 cl of red or white wine vinegar at 6 % minimum', // FR: 75 cl de vinaigre de vin rouge ou blanc à 6 % minimum
      'a clean bottle', // FR: une bouteille propre
    ],
    steps: <String>[
      // FR: Rince les brins et laisse-les sécher complètement sur un torchon, une goutte d'eau dilue le vinaigre.
      'Rinse the sprigs and let them dry completely on a tea towel: a single drop of water dilutes the vinegar.',
      // FR: Glisse-les dans la bouteille, tête en bas.
      'Slip them into the bottle, head down.',
      // FR: Verse le vinaigre pur jusqu'au goulot : la sarriette doit être **entièrement immergée**.
      'Pour in the vinegar, undiluted, up to the neck: the savory must be **completely submerged**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps.
      'Close and leave to infuse for two weeks in the shade, shaking from time to time.',
      // FR: Filtre et remets un brin propre si tu veux. Une herbe qui dépasse du vinaigre finit par moisir.
      'Strain and add a clean sprig if you like. A herb sticking out of the vinegar ends up mouldy.',
    ],
  ),
  'sarriette/Brins de sarriette au congélateur': RecipeText(
    // FR: Brins de sarriette au congélateur
    name: 'Savory sprigs in the freezer',
    // FR: Dix minutes, et tu as le parfum de la sarriette fraîche pour les fèves de printemps.
    description: 'Ten minutes, and you have the flavour of fresh savory for spring broad beans.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      'a bunch of savory', // FR: une botte de sarriette
      'a zip freezer bag', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les brins et sèche-les bien dans un torchon.
      'Rinse the sprigs and dry them well in a tea towel.',
      // FR: Coupe-les en tronçons de 5 cm, la longueur d'un brin pour une casserole.
      'Cut them into 5 cm lengths, one sprig\'s worth for one pan.',
      // FR: Mets-les dans le sac à plat, chasse l'air, ferme et congèle.
      'Lay them flat in the bag, press out the air, close and freeze.',
      // FR: Jette un brin gelé dans l'eau de cuisson des haricots ou des fèves, et retire-le avant de servir.
      'Drop a frozen sprig into the cooking water of beans or broad beans, and take it out before serving.',
    ],
  ),
  'sarriette/Haricots à la sarriette': RecipeText(
    // FR: Haricots à la sarriette
    name: 'Savory beans',
    // FR: On la dit « herbe aux haricots » : elle les rend digestes.
    description: 'It is called the "bean herb": it makes them digestible.',
  ),
  'sarriette/Fromage de chèvre à la sarriette': RecipeText(
    // FR: Fromage de chèvre à la sarriette
    name: 'Savory goat\'s cheese',
    // FR: Le pèbre d'ail provençal, roulé dans l'herbe.
    description: 'The Provençal "pèbre d\'ail" cheese, rolled in the herb.',
  ),
  'sarriette/Marinade pour grillades': RecipeText(
    // FR: Marinade pour grillades
    name: 'Marinade for grills',
    // FR: Huile, ail, sarriette, citron.
    description: 'Oil, garlic, savory, lemon.',
  ),

  // ─────────── sauge (6 recettes) ───────────
  'sauge/Bouquets de sauge séchés': RecipeText(
    // FR: Bouquets de sauge séchés
    name: 'Sage bunches, dried',
    // FR: La sauge est l'une des rares herbes qui gagnent au séchage : son goût devient plus rond.
    description: 'Sage is one of the few herbs that improve with drying: its flavour becomes rounder.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'leafy sage stems', // FR: des tiges de sauge feuillues
      'string or rubber bands', // FR: de la ficelle ou des élastiques
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe des tiges de 20 cm en fin de matinée, par temps sec, de préférence avant la floraison.
      'Cut 20 cm stems late in the morning in dry weather, preferably before flowering.',
      // FR: Retire les feuilles abîmées et lie les tiges en bouquets de cinq ou six, pas plus épais.
      'Remove any damaged leaves and tie the stems into bunches of five or six, no thicker.',
      // FR: Suspends-les tête en bas dans un endroit sec, aéré et **à l'ombre**, une dizaine de jours.
      'Hang them upside down in a dry, airy place **in the shade** for about ten days.',
      // FR: Elles sont sèches quand les feuilles craquent. Si elles plient encore, laisse-les quelques jours de plus.
      'They are dry when the leaves crackle. If they still bend, leave them a few more days.',
      // FR: Effeuille dans un bocal en gardant les feuilles **entières** : elles gardent mieux leur parfum.
      'Strip the leaves into a jar, keeping them **whole**: they hold their fragrance better.',
    ],
  ),
  'sauge/Sel de sauge et romarin': RecipeText(
    // FR: Sel de sauge et romarin
    name: 'Sage and rosemary salt',
    // FR: Le sel des rôtis et des pommes de terre sautées, prêt pour toute l'année en une après-midi.
    description: 'The salt for roasts and sautéed potatoes, ready for the whole year in one afternoon.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 year in the cupboard, in a closed jar',
    ingredients: <String>[
      '40 g of sage leaves', // FR: 40 g de feuilles de sauge
      '2 sprigs of rosemary', // FR: 2 branches de romarin
      '250 g of coarse grey salt', // FR: 250 g de gros sel gris
      'the zest of one unwaxed lemon', // FR: le zeste d'un citron non traité
    ],
    steps: <String>[
      // FR: Lave et **sèche parfaitement** les feuilles de sauge et les aiguilles de romarin.
      'Wash the sage leaves and rosemary needles and **dry them thoroughly**.',
      // FR: Mixe-les par à-coups avec le gros sel et le zeste jusqu'à un sable vert grossier.
      'Blend them in short bursts with the coarse salt and the zest to a coarse green sand.',
      // FR: Étale en couche fine sur une plaque garnie de papier et sèche au four à 50 °C, porte entrouverte.
      'Spread in a thin layer on a paper-lined tray and dry in the oven at 50 °C, door ajar.',
      // FR: Émiette avec une fourchette toutes les demi-heures pour casser les grumeaux.
      'Crumble with a fork every half hour to break up the lumps.',
      // FR: Laisse refroidir complètement à l'air avant de mettre en pot.
      'Leave to cool completely in the open air before putting it in a jar.',
      // FR: Mets en bocal sec et bien fermé, loin de la vapeur de la cuisinière.
      'Put it in a dry, tightly closed jar, away from the steam of the cooker.',
    ],
  ),
  'sauge/Feuilles de sauge congelées à plat': RecipeText(
    // FR: Feuilles de sauge congelées à plat
    name: 'Sage leaves, frozen flat',
    // FR: Un quart d'heure, et tu as des feuilles entières à faire crépiter dans le beurre en plein hiver.
    description: 'A quarter of an hour, and you have whole leaves to sizzle in butter in the depths of winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      'about a hundred nice sage leaves', // FR: une centaine de belles feuilles de sauge
      'baking paper', // FR: du papier cuisson
      'a freezer box', // FR: une boîte de congélation
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les une par une dans un torchon.
      'Rinse the leaves and dry them one by one in a tea towel.',
      // FR: Coupe le pétiole et écarte les feuilles tachées ou trouées.
      'Cut off the stalk and set aside any spotted or holey leaves.',
      // FR: Étale-les sur une plaque garnie de papier, **sans qu'elles se chevauchent**, et congèle 1 heure.
      'Spread them on a paper-lined tray, **not overlapping**, and freeze for 1 hour.',
      // FR: Range-les dans la boîte en couches séparées par du papier cuisson.
      'Arrange them in the box in layers separated by baking paper.',
      // FR: Jette-les gelées dans le beurre chaud : elles foncent un peu, mais le goût est là.
      'Drop them frozen into hot butter: they darken a little, but the flavour is there.',
    ],
  ),
  'sauge/Beurre de sauge': RecipeText(
    // FR: Beurre de sauge
    name: 'Sage butter',
    // FR: Feuilles frites dans le beurre noisette, sur des gnocchis.
    description: 'Leaves fried in brown butter, over gnocchi.',
  ),
  'sauge/Saltimbocca': RecipeText(
    // FR: Saltimbocca
    name: 'Saltimbocca',
    // FR: Veau, jambon cru et une feuille de sauge par escalope.
    description: 'Veal, cured ham and a sage leaf on each escalope.',
  ),
  'sauge/Infusion de sauge': RecipeText(
    // FR: Infusion de sauge
    name: 'Sage tea',
    // FR: Digestive, avec une rondelle de citron.
    description: 'Good for digestion, with a slice of lemon.',
  ),

  // ─────────── sesame (6 recettes) ───────────
  'sesame/Graines de sésame battues et séchées': RecipeText(
    // FR: Graines de sésame battues et séchées
    name: 'Threshed and dried sesame seeds',
    // FR: Coupé au bon moment, séché tête en bas, battu : ton sésame se garde un an au sec.
    description: 'Cut at the right moment, dried upside down, threshed: your sesame keeps for a year in a dry place.',
    // FR: 1 an au sec, à l'abri de la lumière et des insectes
    keeps: '1 year in a dry place, away from light and insects',
    ingredients: <String>[
      'sesame stalks', // FR: les tiges de sésame
      'a sheet or large paper bags', // FR: un drap ou de grands sacs en papier
      'a sieve', // FR: un tamis
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les **capsules du bas jaunissent** et que les feuilles tombent, avant qu'elles ne s'ouvrent et sèment tout au sol.
      'Cut the stalks when the **lower pods turn yellow** and the leaves fall, before the pods open and sow everything on the ground.',
      // FR: Lie-les en bottes et suspends-les tête en bas au-dessus d'un drap, ou enferme les têtes dans des sacs en papier.
      'Tie them into bundles and hang them upside down over a sheet, or enclose the heads in paper bags.',
      // FR: Laisse sécher deux à trois semaines dans un endroit sec et aéré : les capsules s'ouvrent d'elles-mêmes.
      'Leave to dry for two to three weeks in a dry, airy place: the pods open by themselves.',
      // FR: Secoue et tape les bottes sur le drap : les graines tombent toutes seules.
      'Shake and tap the bundles over the sheet: the seeds fall out on their own.',
      // FR: Passe-les au tamis, puis vanne-les en soufflant doucement pour chasser les débris.
      'Pass them through the sieve, then winnow by blowing gently to get rid of the debris.',
      // FR: Étale les graines en couche fine sur un plateau trois jours de plus, à l'ombre, en remuant chaque jour.
      'Spread the seeds in a thin layer on a tray for three more days, in the shade, stirring every day.',
      // FR: Mets-les 48 heures au congélateur pour tuer d'éventuels œufs d'insectes, puis en bocal bien fermé au placard.
      'Put them in the freezer for 48 hours to kill any insect eggs, then into a tightly closed jar in the cupboard.',
    ],
  ),
  'sesame/Réserve de sésame au congélateur': RecipeText(
    // FR: Réserve de sésame au congélateur
    name: 'Sesame stock in the freezer',
    // FR: Riche en huile, le sésame rancit au placard en quelques mois ; au froid, il reste frais deux ans.
    description: 'Rich in oil, sesame goes rancid in the cupboard within a few months; in the cold, it stays fresh for two years.',
    // FR: 2 ans au congélateur
    keeps: '2 years in the freezer',
    ingredients: <String>[
      'very dry sesame seeds', // FR: des graines de sésame bien sèches
      'freezer jars or sachets', // FR: des bocaux ou sachets de congélation
    ],
    steps: <String>[
      // FR: Vérifie que les graines sont **parfaitement sèches** : elles doivent couler comme du sable, sans coller.
      'Check that the seeds are **perfectly dry**: they should pour like sand, without sticking.',
      // FR: Répartis-les en petits bocaux ou sachets d'environ 200 g, la quantité d'un mois.
      'Divide them into small jars or sachets of about 200 g, a month\'s worth.',
      // FR: Chasse l'air, ferme bien et congèle. Note la date sur chaque sachet.
      'Press out the air, close tightly and freeze. Write the date on each sachet.',
      // FR: Utilise-les directement gelées : elles ne collent pas et se torréfient très bien sans décongeler.
      'Use them straight from frozen: they do not stick and toast very well without thawing.',
    ],
  ),
  'sesame/Sésame torréfié en bocal': RecipeText(
    // FR: Sésame torréfié en bocal
    name: 'Toasted sesame in a jar',
    // FR: Une poêlée d'avance, prête à saupoudrer sur les salades, les légumes et le riz.
    description: 'One panful in advance, ready to sprinkle over salads, vegetables and rice.',
    // FR: 3 mois au sec, en bocal fermé
    keeps: '3 months in a dry place, in a closed jar',
    ingredients: <String>[
      '300 g of very dry sesame seeds', // FR: 300 g de graines de sésame bien sèches
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Si ton sésame vient du jardin, rince-le dans une passoire fine et égoutte-le bien pour enlever la poussière.
      'If your sesame comes from the garden, rinse it in a fine sieve and drain it well to remove the dust.',
      // FR: Fais-le dorer dans une grande poêle sèche, à feu moyen, en couche fine.
      'Toast it in a large dry pan, over a medium heat, in a thin layer.',
      // FR: Remue **sans arrêt** : il passe du blond au brûlé en quelques secondes. Arrête dès qu'il sent la noisette et commence à sauter.
      'Stir **constantly**: it goes from pale gold to burnt in a few seconds. Stop as soon as it smells nutty and starts to jump.',
      // FR: Verse-le aussitôt sur une assiette froide, sinon il continue à cuire dans la poêle, et laisse refroidir.
      'Tip it straight onto a cold plate, or it keeps cooking in the pan, and let it cool.',
      // FR: Mets en bocal seulement quand il est **complètement froid**, et range-le à l'abri de la chaleur.
      'Put it in a jar only when it is **completely cold**, and store it away from heat.',
    ],
  ),
  'sesame/Tahini maison': RecipeText(
    // FR: Tahini maison
    name: 'Homemade tahini',
    // FR: Graines torréfiées, mixées longtemps avec un filet d'huile.
    description: 'Toasted seeds, blended for a long time with a thin stream of oil.',
  ),
  'sesame/Gomasio': RecipeText(
    // FR: Gomasio
    name: 'Gomasio',
    // FR: Sésame grillé et sel, écrasés au mortier. Sur tout.
    description: 'Toasted sesame and salt, crushed in a mortar. On everything.',
  ),
  'sesame/Croquants au sésame': RecipeText(
    // FR: Croquants au sésame
    name: 'Sesame brittle',
    // FR: Caramel et graines, étalés fin, cassés en éclats.
    description: 'Caramel and seeds, spread thin, broken into shards.',
  ),

  // ─────────── shiitake (6 recettes) ───────────
  'shiitake/Shiitakés séchés': RecipeText(
    // FR: Shiitakés séchés
    name: 'Dried shiitake',
    // FR: C'est ainsi qu'on les garde en Asie : séchés, leur goût devient même plus profond qu'à l'état frais.
    description: 'This is how they are kept in Asia: dried, their flavour becomes even deeper than when fresh.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 year in a dry place, in an airtight jar',
    ingredients: <String>[
      '1 kg of shiitake', // FR: 1 kg de shiitakés
      'racks or trays', // FR: des grilles ou plaques
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Coupe les pieds, durs et fibreux : garde-les pour un bouillon. Essuie les chapeaux sans les mouiller.
      'Cut off the stems, which are tough and fibrous: keep them for a stock. Wipe the caps without wetting them.',
      // FR: Laisse les petits entiers et coupe les gros en lamelles de 5 mm.
      'Leave the small ones whole and cut the big ones into 5 mm slices.',
      // FR: Pose-les lamelles vers le haut sur des grilles et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Lay them gills up on racks and dry at 50 °C, door ajar, or in a dehydrator.',
      // FR: Ils sont prêts quand ils sont durs et légers, et cassants pour les lamelles.
      'They are ready when they are hard and light, and brittle for the slices.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Réhydrate-les 30 minutes dans l'eau tiède : cette eau est un bouillon parfumé.
      'Let them cool and put them in airtight jars. Rehydrate them for 30 minutes in lukewarm water: that water is a fragrant stock.',
    ],
  ),
  'shiitake/Shiitakés sautés à congeler': RecipeText(
    // FR: Shiitakés sautés à congeler
    name: 'Sautéed shiitake to freeze',
    // FR: Saisis rapidement et congelés en portions, ils sont prêts pour un wok ou un bouillon en deux minutes.
    description: 'Quickly seared and frozen in portions, they are ready for a wok or a broth in two minutes.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of shiitake', // FR: 1 kg de shiitakés
      '2 tbsp of neutral oil', // FR: 2 cuillères à soupe d'huile neutre
      '1 tsp of salt', // FR: 1 cuillère à café de sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les pieds et essuie les chapeaux avec un linge humide, sans les tremper.
      'Cut off the stems and wipe the caps with a damp cloth, without soaking them.',
      // FR: Émince les chapeaux en lamelles de 5 mm.
      'Slice the caps into 5 mm strips.',
      // FR: Fais-les sauter à feu vif dans l'huile, en deux fois, jusqu'à ce qu'ils soient dorés et que l'eau soit évaporée.
      'Fry them over a high heat in the oil, in two batches, until golden and the water has evaporated.',
      // FR: Sale en fin de cuisson.
      'Add the salt at the end of cooking.',
      // FR: Étale-les sur une assiette pour qu'ils refroidissent vite.
      'Spread them on a plate so they cool quickly.',
      // FR: Mets en sacs d'une portion, à plat, et date.
      'Pack them flat into single-portion bags and write the date on them.',
    ],
  ),
  'shiitake/Shiitakés marinés au vinaigre et gingembre': RecipeText(
    // FR: Shiitakés marinés au vinaigre et gingembre
    name: 'Shiitake pickled in vinegar and ginger',
    // FR: Cuits dans un vinaigre aigre-doux au gingembre, ils accompagnent un bol de riz ou une salade froide.
    description: 'Cooked in a sweet-and-sour ginger vinegar, they go with a bowl of rice or a cold salad.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '600 g of shiitake', // FR: 600 g de shiitakés
      '30 cl of white vinegar at 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl of water', // FR: 30 cl d'eau
      '10 g of salt, 40 g of sugar', // FR: 10 g de sel, 40 g de sucre
      '1 piece of ginger, 4 cm', // FR: 1 morceau de gingembre de 4 cm
      '1 tbsp of soy sauce', // FR: 1 cuillère à soupe de sauce soja
    ],
    steps: <String>[
      // FR: Retire les pieds, essuie les chapeaux et coupe les gros en deux. Taille le gingembre en fines lamelles.
      'Remove the stems, wipe the caps and halve the big ones. Cut the ginger into thin slices.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel, le sucre, le soja et le gingembre.
      'Bring the vinegar, water, salt, sugar, soy sauce and ginger to the boil.',
      // FR: Ajoute les shiitakés et laisse frémir **5 minutes**.
      'Add the shiitake and simmer for **5 minutes**.',
      // FR: Répartis-les dans deux bocaux ébouillantés avec le gingembre.
      'Divide them between two scalded jars with the ginger.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Pour in the boiling liquid to **cover completely**, close the jars and let them cool.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'y goûter.
      'Keep in the fridge and wait 2 days before tasting.',
    ],
  ),
  'shiitake/Shiitakés sautés au soja': RecipeText(
    // FR: Shiitakés sautés au soja
    name: 'Shiitake sautéed in soy',
    // FR: Sauce soja, mirin, un peu de sucre : le glaçage japonais.
    description: 'Soy sauce, mirin, a little sugar: the Japanese glaze.',
  ),
  'shiitake/Bouillon dashi aux shiitakés': RecipeText(
    // FR: Bouillon dashi aux shiitakés
    name: 'Shiitake dashi stock',
    // FR: Même séchés, ils donnent une profondeur rare.
    description: 'Even dried, they give a rare depth.',
  ),
  'shiitake/Shiitakés grillés au sésame': RecipeText(
    // FR: Shiitakés grillés au sésame
    name: 'Grilled shiitake with sesame',
    // FR: Entiers, sur le gril, sel et huile de sésame.
    description: 'Whole, on the grill, with salt and sesame oil.',
  ),

  // ─────────── sorgho (6 recettes) ───────────
  'sorgho/Panicules de sorgho séchées et battues': RecipeText(
    // FR: Panicules de sorgho séchées et battues
    name: 'Dried and threshed sorghum panicles',
    // FR: Le grain bien sec, vanné et protégé des insectes, c'est la réserve de toute l'année.
    description: 'Well-dried grain, winnowed and protected from insects, is the stock for the whole year.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 year in a dry place, safe from insects',
    ingredients: <String>[
      'sorghum panicles cut at maturity', // FR: les panicules de sorgho coupées à maturité
      'a clean tarpaulin', // FR: une bâche propre
      'a stick', // FR: un bâton
      'airtight sacks or drums', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Coupe les panicules quand le grain ne se raye plus à l'ongle, avec 20 cm de tige pour les suspendre.
      'Cut the panicles when the grain can no longer be scratched with a fingernail, leaving 20 cm of stalk to hang them by.',
      // FR: Suspends-les tête en bas sous un abri aéré, ou étale-les au soleil, une bonne semaine.
      'Hang them upside down under an airy shelter, or spread them in the sun, for a good week.',
      // FR: Teste : un grain croqué casse net et sonne sec. S'il est pâteux, attends encore.
      'Test: a grain you bite snaps cleanly and sounds dry. If it is doughy, wait longer.',
      // FR: Bats les panicules au bâton sur la bâche, puis frotte entre les mains ce qui résiste.
      'Beat the panicles with a stick on the tarpaulin, then rub what resists between your hands.',
      // FR: Vanne en versant le grain de haut par vent léger pour faire partir les balles.
      'Winnow by pouring the grain from a height in a light breeze, so the chaff blows away.',
      // FR: Passe le grain 3 jours au congélateur pour tuer les œufs de charançon.
      'Put the grain in the freezer for 3 days to kill weevil eggs.',
      // FR: Stocke en sacs ou fûts hermétiques pleins à ras, au frais, au sec et surélevés.
      'Store in airtight sacks or drums filled to the brim, somewhere cool, dry and off the ground.',
    ],
  ),
  'sorgho/Sorgho en grain au congélateur': RecipeText(
    // FR: Sorgho en grain au congélateur
    name: 'Sorghum grain in the freezer',
    // FR: Au froid, plus de charançons ni de grain qui sent le vieux : un quart d'heure et c'est réglé.
    description: 'In the cold, no more weevils and no grain that smells stale: a quarter of an hour and it is done.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'threshed, very dry sorghum', // FR: du sorgho battu et bien sec
      'thick freezer bags', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Trie le grain sur un plateau : enlève cailloux, balles et grains noirs ou moisis.
      'Sort the grain on a tray: remove stones, chaff and black or mouldy grains.',
      // FR: Remplis des sacs par portions, chasse l'air et ferme bien.
      'Fill the bags in portions, press out the air and close tightly.',
      // FR: Congèle à plat. En 3 jours, le froid tue aussi les œufs cachés dans le grain.
      'Freeze flat. In 3 days, the cold also kills any eggs hidden in the grain.',
      // FR: Avant usage, laisse le sac fermé revenir à température 2 heures, pour que le grain ne prenne pas l'humidité.
      'Before use, let the bag come to room temperature for 2 hours while still closed, so the grain does not take on moisture.',
    ],
  ),
  'sorgho/Grains de sorgho cuits en portions': RecipeText(
    // FR: Grains de sorgho cuits en portions
    name: 'Cooked sorghum grain in portions',
    // FR: Le sorgho entier demande une heure de cuisson : fais-en une grosse marmite, et tu as des portions prêtes comme du riz.
    description: 'Whole sorghum needs an hour of cooking: make a big pot, and you have portions ready like rice.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '500 g of sorghum grain', // FR: 500 g de sorgho en grain
      '1.5 litres of water', // FR: 1,5 litre d'eau
      '1 tsp of salt', // FR: 1 cuillère à café de sel
      'freezer boxes or bags', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Rince le sorgho dans plusieurs eaux jusqu'à ce qu'elle soit claire.
      'Rinse the sorghum in several changes of water until it runs clear.',
      // FR: Laisse-le tremper 2 heures si tu peux : il cuira plus vite et plus régulièrement.
      'Soak it for 2 hours if you can: it will cook faster and more evenly.',
      // FR: Mets-le dans l'eau salée froide, porte à ébullition et laisse frémir à couvert. Le grain doit être tendre mais encore un peu ferme.
      'Put it in cold salted water, bring to the boil and simmer with the lid on. The grain should be tender but still a little firm.',
      // FR: Égoutte s'il reste de l'eau et étale sur un plateau pour refroidir vite.
      'Drain if any water is left and spread on a tray to cool quickly.',
      // FR: Répartis en portions à plat dans des sacs, grains bien séparés, et congèle.
      'Divide into portions flat in bags, grains well separated, and freeze.',
      // FR: Réchauffe 5 minutes à la poêle avec un filet d'eau, ou jette directement dans une soupe.
      'Reheat for 5 minutes in a pan with a splash of water, or drop straight into a soup.',
    ],
  ),
  'sorgho/Galettes de sorgho': RecipeText(
    // FR: Galettes de sorgho
    name: 'Sorghum galettes',
    // FR: Farine de sorgho, eau, sel, cuites sur une plaque brûlante.
    description: 'Sorghum flour, water, salt, cooked on a scorching hot plate.',
  ),
  'sorgho/Tô de sorgho': RecipeText(
    // FR: Tô de sorgho
    name: 'Sorghum tô',
    // FR: La version sorgho du tô, un classique du Burkina et du Mali à la sauce feuilles.
    description: 'The sorghum version of tô, a Burkina Faso and Mali classic, served with a leaf sauce.',
  ),
  'sorgho/Bouillie de sorgho': RecipeText(
    // FR: Bouillie de sorgho
    name: 'Sorghum porridge',
    // FR: Une bouillie douce et nourrissante, parfaite pour bien démarrer la journée.
    description: 'A soft, nourishing porridge, perfect for starting the day well.',
  ),

  // ─────────── souci (6 recettes) ───────────
  'souci/Pétales de souci séchés': RecipeText(
    // FR: Pétales de souci séchés
    name: 'Dried calendula petals',
    // FR: Le « safran du pauvre » : des pétales orange qui colorent riz, soupes et pains toute l'année.
    description: 'The "poor man\'s saffron": orange petals that colour rice, soups and breads all year round.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'about thirty fully open calendula flowers', // FR: une trentaine de fleurs de souci bien ouvertes
      'newspaper or a drying rack', // FR: du papier journal ou une claie
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille des fleurs de **Calendula officinalis**, pas d'œillets d'Inde, en fin de matinée, sans traitement.
      'Pick flowers of **Calendula officinalis**, not French marigolds, late in the morning, from plants that have not been treated.',
      // FR: Arrache les pétales du cœur d'un geste : le cœur vert est amer et sèche mal.
      'Pull the petals off the centre in one go: the green centre is bitter and dries badly.',
      // FR: Étale-les en couche fine sur le papier, sans qu'ils se chevauchent.
      'Spread them in a thin layer on the paper, not overlapping.',
      // FR: Laisse-les quatre à cinq jours à l'ombre, dans un endroit sec, en remuant chaque jour. Au soleil, ils pâlissent.
      'Leave them for four to five days in the shade, in a dry place, turning them every day. In the sun, they fade.',
      // FR: Ils sont prêts quand ils crissent sous les doigts. Mets-les en bocal, dans le noir.
      'They are ready when they rustle under your fingers. Put them in a jar, in the dark.',
    ],
  ),
  'souci/Sel doré au souci': RecipeText(
    // FR: Sel doré au souci
    name: 'Golden calendula salt',
    // FR: Des pétales séchés mêlés au gros sel : une salière orange pour les œufs et les légumes rôtis.
    description: 'Dried petals mixed into coarse salt: an orange salt cellar for eggs and roasted vegetables.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 year in the cupboard, in a closed jar',
    ingredients: <String>[
      '4 tbsp of very dry calendula petals', // FR: 4 cuillères à soupe de pétales de souci bien secs
      '250 g of coarse salt or flaky salt', // FR: 250 g de gros sel ou de fleur de sel
      'the dried zest of a lemon (optional)', // FR: le zeste séché d'un citron (facultatif)
    ],
    steps: <String>[
      // FR: Utilise des pétales **parfaitement secs** : des pétales frais feraient fondre le sel en bloc.
      'Use **perfectly dry** petals: fresh ones would make the salt clump into a block.',
      // FR: Écrase-les grossièrement au mortier ou entre tes paumes.
      'Crush them roughly in a mortar or between your palms.',
      // FR: Mélange-les au sel et au zeste dans un saladier.
      'Mix them with the salt and zest in a bowl.',
      // FR: Mets en pot bien sec et ferme. Secoue-le une fois par semaine les premiers temps.
      'Put it in a very dry jar and close it. Shake it once a week at first.',
      // FR: Saupoudre au dernier moment sur les œufs, le riz ou un poisson : la couleur reste vive hors cuisson.
      'Sprinkle on at the last moment over eggs, rice or fish: the colour stays bright when it is not cooked.',
    ],
  ),
  'souci/Glaçons aux pétales de souci': RecipeText(
    // FR: Glaçons aux pétales de souci
    name: 'Calendula petal ice cubes',
    // FR: Des cubes éclaboussés d'orange pour les carafes d'eau et les apéritifs d'été.
    description: 'Cubes splashed with orange for water jugs and summer aperitifs.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      '10 calendula flowers', // FR: 10 fleurs de souci
      'boiled water, cooled', // FR: de l'eau bouillie refroidie
      'two ice cube trays', // FR: deux bacs à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Plonge les fleurs dans l'eau froide et secoue-les pour faire partir les petites bêtes.
      'Dunk the flowers in cold water and shake them to get rid of any little creatures.',
      // FR: Détache les pétales et laisse le cœur de côté.
      'Pull off the petals and leave the centres aside.',
      // FR: Remplis les cases d'eau à moitié et répartis quelques pétales.
      'Half fill the compartments with water and scatter in a few petals.',
      // FR: Congèle 1 heure, puis complète d'eau et remets au congélateur : les pétales restent **au milieu** au lieu de flotter.
      'Freeze for 1 hour, then top up with water and return to the freezer: the petals stay **in the middle** instead of floating.',
      // FR: Une fois durs, démoule les glaçons dans un sac fermé.
      'Once hard, pop the ice cubes into a closed bag.',
    ],
  ),
  'souci/Riz au souci': RecipeText(
    // FR: Riz au souci
    name: 'Calendula rice',
    // FR: Les pétales colorent le riz en jaune — le « safran du pauvre ».
    description: 'The petals turn the rice yellow — the "poor man\'s saffron".',
  ),
  'souci/Salade aux pétales de souci': RecipeText(
    // FR: Salade aux pétales de souci
    name: 'Calendula petal salad',
    // FR: Crus, légèrement amers, très décoratifs.
    description: 'Raw, slightly bitter, very decorative.',
  ),
  'souci/Beurre fleuri': RecipeText(
    // FR: Beurre fleuri
    name: 'Flower butter',
    // FR: Pétales hachés dans du beurre pommade.
    description: 'Chopped petals in softened butter.',
  ),

  // ─────────── taro (6 recettes) ───────────
  'taro/Taro cuit en morceaux au congélateur': RecipeText(
    // FR: Taro cuit en morceaux au congélateur
    name: 'Cooked taro pieces in the freezer',
    // FR: Le taro se cuit toujours avant d'être mangé : autant le cuire d'un coup, et en avoir prêt pour les ragoûts.
    description: 'Taro is always cooked before eating: you might as well cook it all at once, and have some ready for stews.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of taro', // FR: 2 kg de taro
      'kitchen gloves', // FR: des gants de cuisine
      'coarse salt', // FR: gros sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: **Enfile des gants** : la sève du taro cru irrite la peau. Épluche-le épais, jusqu'à la chair blanche ou mauve.
      '**Put on gloves**: the sap of raw taro irritates the skin. Peel it thickly, down to the white or purple flesh.',
      // FR: Coupe-le en morceaux de 4 cm et rince-les à grande eau, jusqu'à ce qu'elle ne soit plus gluante.
      'Cut it into 4 cm pieces and rinse them in plenty of water, until it is no longer slimy.',
      // FR: Cuis à l'eau bouillante salée jusqu'à ce que la pointe du couteau entre **sans résistance** : cru, le taro est toxique.
      'Cook in salted boiling water until the point of a knife goes in **without resistance**: raw, taro is toxic.',
      // FR: Égoutte et laisse refroidir complètement sur une grille.
      'Drain and leave to cool completely on a rack.',
      // FR: Mets en sacs par portions, à plat, et congèle. Ajoute-les gelés en fin de cuisson d'un ragoût ou écrase-les chauds.
      'Pack into bags in portions, flat, and freeze. Add them frozen at the end of a stew\'s cooking, or mash them hot.',
    ],
  ),
  'taro/Cubes de taro crus congelés': RecipeText(
    // FR: Cubes de taro crus congelés
    name: 'Raw frozen taro cubes',
    // FR: Épluché et coupé une fois pour toutes, le taro se congèle cru : il ne reste plus qu'à le cuire, sans gants.
    description: 'Peeled and cut once and for all, taro freezes raw: all that is left is to cook it, no gloves needed.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of taro', // FR: 1,5 kg de taro
      'kitchen gloves', // FR: des gants de cuisine
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Avec des gants, épluche le taro épais et coupe-le en cubes de 3 cm.
      'With gloves on, peel the taro thickly and cut it into 3 cm cubes.',
      // FR: Rince bien les cubes pour enlever le mucilage, puis sèche-les dans un torchon.
      'Rinse the cubes well to remove the slime, then dry them in a tea towel.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Spread them on a tray, not touching, and freeze for 2 hours.',
      // FR: Verse-les en sac et note bien sur l'étiquette « **cru, à cuire** ».
      'Tip them into a bag and write "**raw, to be cooked**" clearly on the label.',
      // FR: À l'usage, jette-les gelés dans l'eau bouillante ou la sauce et cuis au moins 25 minutes, jusqu'à ce qu'ils soient fondants. Jamais crus.
      'To use, drop them frozen into boiling water or sauce and cook for at least 25 minutes, until soft. Never raw.',
    ],
  ),
  'taro/Cossettes de taro séchées': RecipeText(
    // FR: Cossettes de taro séchées
    name: 'Dried taro slices',
    // FR: Cuites puis séchées, les tranches de taro se gardent au sec et se moulent en farine pour les bouillies et les pâtes.
    description: 'Cooked then dried, taro slices keep in a dry place and can be ground into flour for porridges and doughs.',
    // FR: 6 mois au sec, à l'abri des insectes
    keeps: '6 months in a dry place, safe from insects',
    ingredients: <String>[
      '2 kg of taro', // FR: 2 kg de taro
      'kitchen gloves', // FR: des gants de cuisine
      'baking paper', // FR: du papier cuisson
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Avec des gants, épluche le taro et coupe-le en tranches de 5 mm.
      'With gloves on, peel the taro and cut it into 5 mm slices.',
      // FR: Cuis les tranches à l'eau frémissante jusqu'à ce qu'elles soient tendres mais encore entières.
      'Cook the slices in barely simmering water until tender but still whole.',
      // FR: Égoutte-les délicatement et étale-les sur des plaques, une seule couche.
      'Drain them gently and spread them on trays in a single layer.',
      // FR: Sèche au four à **60 °C**, porte entrouverte, ou au soleil sous un voile, jusqu'à ce qu'elles cassent net.
      'Dry in the oven at **60 °C**, door ajar, or in the sun under a net, until they snap cleanly.',
      // FR: Laisse refroidir et range en bocal hermétique, ou moud-les en farine au blender.
      'Let them cool and store in an airtight jar, or grind them into flour in a blender.',
      // FR: La farine se cuit encore à l'eau en remuant pour faire une pâte ou une bouillie, comme un foufou.
      'The flour is cooked again in water, stirring, to make a dough or porridge, like a fufu.',
    ],
  ),
  'taro/Taro pilé': RecipeText(
    // FR: Taro pilé
    name: 'Pounded taro',
    // FR: Bouilli puis pilé au mortier jusqu'à devenir élastique.
    description: 'Boiled then pounded in a mortar until elastic.',
  ),
  'taro/Chips de taro': RecipeText(
    // FR: Chips de taro
    name: 'Taro crisps',
    // FR: En lamelles très fines, frites jusqu'à ce qu'elles dorent.
    description: 'Cut very thin and fried until golden.',
  ),
  'taro/Ragoût de taro': RecipeText(
    // FR: Ragoût de taro
    name: 'Taro stew',
    // FR: Le taro mijoté en sauce tomate, fondant et généreux, à servir bien chaud.
    description: 'Taro simmered in tomato sauce, soft and generous, to serve piping hot.',
  ),

  // ─────────── thym (6 recettes) ───────────
  'thym/Bouquets de thym séchés': RecipeText(
    // FR: Bouquets de thym séchés
    name: 'Thyme bunches, dried',
    // FR: Le thym sèche mieux que toutes les autres herbes : il garde presque tout son parfum pendant un an.
    description: 'Thyme dries better than any other herb: it keeps almost all its fragrance for a year.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 year in a jar, away from light',
    ingredients: <String>[
      'a big armful of thyme', // FR: une grosse brassée de thym
      'kitchen string', // FR: de la ficelle de cuisine
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Coupe les tiges **juste avant la floraison**, en fin de matinée par temps sec : c'est là qu'elles sont les plus parfumées.
      'Cut the stems **just before flowering**, late in the morning in dry weather: that is when they are at their most fragrant.',
      // FR: Ne lave le thym que s'il est terreux, et sèche-le bien sur un torchon.
      'Only wash the thyme if it is muddy, and dry it well on a tea towel.',
      // FR: Fais de petits bouquets d'une dizaine de tiges, liés serré : les tiges rétrécissent en séchant.
      'Make small bunches of about ten stems, tied tight: the stems shrink as they dry.',
      // FR: Suspends-les tête en bas dans un endroit sec, sombre et aéré pendant une semaine.
      'Hang them upside down in a dry, dark, airy place for a week.',
      // FR: Teste : les feuilles se détachent en les frottant et craquent entre tes doigts.
      'Test: the leaves come away when rubbed and crackle between your fingers.',
      // FR: Effeuille au-dessus d'un plat, et range les feuilles en bocal fermé. Les tiges sèches parfument un feu de barbecue.
      'Strip the leaves over a dish and store them in a closed jar. The dry stems will scent a barbecue fire.',
    ],
  ),
  'thym/Glaçons de thym à l\'huile d\'olive': RecipeText(
    // FR: Glaçons de thym à l'huile d'olive
    name: 'Thyme and olive oil cubes',
    // FR: Un cube jeté dans la poêle, et le plat démarre avec le thym et l'huile déjà prêts.
    description: 'Drop one cube in the pan, and the dish starts with the thyme and oil already in place.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 bunch of fresh thyme', // FR: 1 bouquet de thym frais
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      'an ice cube tray', // FR: un bac à glaçons
      'a freezer bag', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince le thym et **sèche-le parfaitement** : l'eau ferait des cristaux et éclabousserait dans la poêle.
      'Rinse the thyme and **dry it thoroughly**: water would form crystals and spit in the pan.',
      // FR: Effeuille les tiges et hache grossièrement les feuilles.
      'Strip the stems and roughly chop the leaves.',
      // FR: Remplis les cases du bac aux deux tiers de feuilles, puis couvre d'huile d'olive.
      'Fill the compartments two-thirds full of leaves, then cover with olive oil.',
      // FR: Congèle jusqu'à ce que ce soit bien dur.
      'Freeze until rock hard.',
      // FR: Démoule et garde en sac. Un cube sorti va **directement dans la poêle**, jamais à traîner sur le plan de travail.
      'Pop them out and keep them in a bag. A cube taken out goes **straight into the pan**, never left sitting on the worktop.',
    ],
  ),
  'thym/Vinaigre au thym et laurier': RecipeText(
    // FR: Vinaigre au thym et laurier
    name: 'Thyme and bay vinegar',
    // FR: Quelques brins dans une bouteille de vinaigre, et toutes tes vinaigrettes sentent la garrigue.
    description: 'A few sprigs in a bottle of vinegar, and all your dressings smell of the Provençal hills.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '6 nice sprigs of thyme', // FR: 6 beaux brins de thym
      '2 bay leaves', // FR: 2 feuilles de laurier
      '50 cl of wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin à 6 % minimum
      '1 clean bottle', // FR: 1 bouteille propre
    ],
    steps: <String>[
      // FR: Rince le thym et le laurier, puis **sèche-les parfaitement** sur un torchon pendant une heure.
      'Rinse the thyme and bay, then **dry them thoroughly** on a tea towel for an hour.',
      // FR: Glisse les brins et les feuilles dans la bouteille.
      'Slip the sprigs and leaves into the bottle.',
      // FR: Verse le vinaigre jusqu'en haut : les herbes doivent être entièrement couvertes, sinon elles moisissent.
      'Pour in the vinegar right to the top: the herbs must be completely covered, or they go mouldy.',
      // FR: Bouche et laisse infuser 3 semaines à l'abri de la lumière.
      'Seal and leave to infuse for 3 weeks away from light.',
      // FR: Filtre et remets en bouteille propre sans les herbes : elles ont tout donné et finiraient par ramollir.
      'Strain and pour back into a clean bottle without the herbs: they have given all they have and would end up going soft.',
    ],
  ),
  'thym/Huile au thym': RecipeText(
    // FR: Huile au thym
    name: 'Thyme oil',
    // FR: Branches sèches dans l'huile tiède, deux semaines d'attente.
    description: 'Dry sprigs in warm oil, two weeks of waiting.',
  ),
  'thym/Poulet au thym et citron': RecipeText(
    // FR: Poulet au thym et citron
    name: 'Thyme and lemon chicken',
    // FR: Beaucoup de branches sous la peau, pas dessus.
    description: 'Plenty of sprigs under the skin, not on top.',
  ),
  'thym/Infusion de thym au miel': RecipeText(
    // FR: Infusion de thym au miel
    name: 'Thyme and honey tea',
    // FR: Le remède de la maison quand la gorge gratte.
    description: 'The house remedy for a scratchy throat.',
  ),

  // ─────────── tomate (6 recettes) ───────────
  'tomate/Tarte à la tomate et moutarde': RecipeText(
    // FR: Tarte à la tomate et moutarde
    name: 'Tomato and mustard tart',
    // FR: Une couche de moutarde sous les tomates, du thym dessus.
    description: 'A layer of mustard under the tomatoes, thyme on top.',
    ingredients: <String>[
      '1 shortcrust pastry', // FR: 1 pâte brisée
      '6 ripe tomatoes', // FR: 6 tomates mûres
      '2 tbsp of mustard', // FR: 2 cuillères à soupe de moutarde
      '150 g of grated Gruyère', // FR: 150 g de gruyère râpé
      'thyme, salt, pepper, olive oil', // FR: thym, sel, poivre, huile d'olive
    ],
    steps: <String>[
      // FR: Préchauffe le four à 200 °C.
      'Preheat the oven to 200 °C.',
      // FR: Étale la pâte dans le moule et pique-la à la fourchette.
      'Roll the pastry out into the tin and prick it with a fork.',
      // FR: Tartine le fond de moutarde, puis saupoudre le gruyère : il empêchera la pâte de détremper.
      'Spread the base with mustard, then sprinkle over the Gruyère: it stops the pastry going soggy.',
      // FR: Coupe les tomates en rondelles, dispose-les en rosace, serrées.
      'Cut the tomatoes into rounds and arrange them in a tight rosette.',
      // FR: Sel, poivre, thym, un filet d'huile d'olive.
      'Salt, pepper, thyme, a drizzle of olive oil.',
      // FR: Au four 35 minutes : les bords doivent dorer.
      'Bake for 35 minutes: the edges should turn golden.',
      // FR: Laisse tiédir 10 minutes avant de couper, sinon elle s'écroule.
      'Leave to cool for 10 minutes before cutting, or it collapses.',
    ],
  ),
  'tomate/Salade tomate-oignon': RecipeText(
    // FR: Salade tomate-oignon
    name: 'Tomato and onion salad',
    // FR: Des tomates fraîches du jardin, un filet de citron, et le tour est joué.
    description: 'Fresh tomatoes from the garden, a squeeze of lemon, and you are done.',
    ingredients: <String>[
      '4 very ripe tomatoes', // FR: 4 tomates bien mûres
      '1 red onion', // FR: 1 oignon rouge
      '1 lemon', // FR: 1 citron
      '3 tbsp of olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      'salt, pepper, basil', // FR: sel, poivre, basilic
    ],
    steps: <String>[
      // FR: Coupe les tomates en quartiers, pas en dés : elles rendent moins d'eau.
      'Cut the tomatoes into wedges, not cubes: they release less water.',
      // FR: Émince l'oignon très fin. Si tu le trouves fort, rince-le à l'eau froide.
      'Slice the onion very thinly. If you find it strong, rinse it in cold water.',
      // FR: Presse le citron, mélange-le à l'huile, sel, poivre.
      'Squeeze the lemon, mix the juice with the oil, salt and pepper.',
      // FR: Verse sur les tomates, mélange délicatement.
      'Pour over the tomatoes and toss gently.',
      // FR: Déchire le basilic à la main par-dessus — au couteau il noircit.
      'Tear the basil by hand over the top — cut with a knife, it turns black.',
    ],
  ),
  'tomate/Thiéboudienne': RecipeText(
    // FR: Thiéboudienne
    name: 'Thiéboudienne',
    // FR: Le riz au poisson sénégalais, roi des plats, avec sa sauce tomate bien réduite.
    description: 'The Senegalese fish and rice, king of dishes, with its well-reduced tomato sauce.',
    ingredients: <String>[
      '1 kg of fish (thiof, grouper or cod)', // FR: 1 kg de poisson (thiof, mérou ou cabillaud)
      '500 g of broken rice', // FR: 500 g de riz brisé
      '6 ripe tomatoes + 2 spoonfuls of tomato purée', // FR: 6 tomates mûres + 2 cuillères de concentré
      '1 cabbage, 2 carrots, 1 aubergine, 1 cassava root', // FR: 1 chou, 2 carottes, 1 aubergine, 1 manioc
      '2 onions, 1 chilli, parsley, garlic', // FR: 2 oignons, 1 piment, persil, ail
      'oil, salt, pepper', // FR: huile, sel, poivre
    ],
    steps: <String>[
      // FR: Pile ail, persil, piment et sel : c'est le nokoss. Farcis-en les poissons par une entaille.
      'Pound the garlic, parsley, chilli and salt together: this is the nokoss. Stuff the fish with it through a slit.',
      // FR: Fais revenir les poissons dans l'huile chaude, puis réserve-les.
      'Fry the fish in hot oil, then set aside.',
      // FR: Dans la même huile, fais fondre les oignons, ajoute tomates et concentré. Laisse réduire 15 minutes à feu doux.
      'In the same oil, soften the onions, then add the tomatoes and purée. Let it reduce for 15 minutes over a low heat.',
      // FR: Couvre d'eau, ajoute les légumes du plus dur au plus tendre. Cuis 25 minutes.
      'Cover with water and add the vegetables, from the hardest to the most tender. Cook for 25 minutes.',
      // FR: Remets le poisson 10 minutes, puis sors poisson et légumes et garde-les au chaud.
      'Put the fish back for 10 minutes, then take out the fish and vegetables and keep them warm.',
      // FR: Verse le riz dans la sauce restante — elle doit le couvrir d'un doigt. Couvre et cuis 20 minutes sans remuer.
      'Pour the rice into the remaining sauce — it should cover it by a finger\'s width. Cover and cook for 20 minutes without stirring.',
      // FR: Dresse le riz, le poisson au centre, les légumes autour.
      'Serve the rice with the fish in the centre and the vegetables around it.',
    ],
  ),

  // ─────────── topinambour (6 recettes) ───────────
  'topinambour/Topinambours lacto-fermentés': RecipeText(
    // FR: Topinambours lacto-fermentés
    name: 'Lacto-fermented Jerusalem artichokes',
    // FR: En saumure, ils gardent leur croquant de châtaigne et deviennent bien plus faciles à digérer.
    description: 'In brine they keep their chestnut-like crunch and become much easier to digest.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1.5 kg of Jerusalem artichokes', // FR: 1,5 kg de topinambours
      '1.5 litres of unchlorinated water', // FR: 1,5 litre d'eau non chlorée
      '45 g of non-iodised salt', // FR: 45 g de sel non iodé
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 tsp of fennel seeds', // FR: 1 cuillère à café de graines de fenouil
    ],
    steps: <String>[
      // FR: Fais dissoudre **45 g de sel dans 1,5 litre d'eau** : saumure à 3 %.
      'Dissolve **45 g of salt in 1.5 litres of water**: that makes a 3 % brine.',
      // FR: Brosse les topinambours sous l'eau en insistant dans les creux, où la terre reste.
      'Scrub the Jerusalem artichokes under water, working into the hollows where the soil lingers.',
      // FR: Inutile de les éplucher : coupe-les en rondelles de 5 mm.
      'No need to peel them: cut them into 5 mm rounds.',
      // FR: Tasse les rondelles dans trois bocaux avec l'ail écrasé et le fenouil, jusqu'à 3 cm du bord.
      'Pack the rounds into three jars with the crushed garlic and the fennel, up to 3 cm from the rim.',
      // FR: Couvre de saumure et pose un poids pour que **tout reste dessous**.
      'Cover with brine and add a weight so that **everything stays under it**.',
      // FR: Ferme sans serrer et laisse fermenter 2 semaines à 18–22 °C, sur une assiette.
      'Close without tightening and leave to ferment for 2 weeks at 18–22 °C, standing on a plate.',
      // FR: Quand ils sont acidulés, serre les couvercles et range au réfrigérateur.
      'Once they are pleasantly sour, tighten the lids and move to the fridge.',
    ],
  ),
  'topinambour/Pickles de topinambour au curcuma': RecipeText(
    // FR: Pickles de topinambour au curcuma
    name: 'Jerusalem artichoke pickles with turmeric',
    // FR: Vingt minutes, et un bocal doré et croquant qui réveille les salades d'hiver.
    description: 'Twenty minutes, and you have a golden, crunchy jar that wakes up winter salads.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '700 g of Jerusalem artichokes', // FR: 700 g de topinambours
      '30 cl of white vinegar at 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl of water', // FR: 30 cl d'eau
      '12 g of salt, 30 g of sugar', // FR: 12 g de sel, 30 g de sucre
      '1 tsp of turmeric, 1 tsp of mustard seeds', // FR: 1 cuillère à café de curcuma, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Brosse soigneusement les topinambours sous l'eau.
      'Scrub the Jerusalem artichokes carefully under water.',
      // FR: Coupe-les en fines rondelles de 3 mm, à la mandoline si tu en as une.
      'Cut them into thin 3 mm rounds, on a mandoline if you have one.',
      // FR: Remplis deux bocaux ébouillantés avec les rondelles et la moutarde.
      'Fill two scalded jars with the rounds and the mustard.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel, le sucre et le curcuma.
      'Bring the vinegar, water, salt, sugar and turmeric to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Pour it in boiling to **cover completely**, close the jars and let them cool.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'ouvrir.
      'Keep in the fridge and wait 2 days before opening.',
    ],
  ),
  'topinambour/Purée de topinambour en portions': RecipeText(
    // FR: Purée de topinambour en portions
    name: 'Jerusalem artichoke purée in portions',
    // FR: Cuite et mixée, elle se congèle en briques prêtes pour une purée ou la base d'un velouté.
    description: 'Cooked and blended, it freezes in blocks ready for a mash or the base of a soup.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of Jerusalem artichokes', // FR: 2 kg de topinambours
      'the juice of one lemon', // FR: le jus d'un citron
      '50 g of butter', // FR: 50 g de beurre
      'salt', // FR: sel
      'freezer boxes or bags', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les topinambours à l'économe et plonge-les au fur et à mesure dans de l'eau citronnée : ils noircissent vite.
      'Peel the Jerusalem artichokes with a peeler and drop them into lemon water as you go: they blacken quickly.',
      // FR: Cuis-les à l'eau salée jusqu'à ce qu'ils soient tendres sous la lame.
      'Cook them in salted water until a knife slips in easily.',
      // FR: Égoutte bien et mixe avec le beurre. **Sans crème ni lait** : ils tranchent à la décongélation.
      'Drain well and blend with the butter. **No cream or milk**: they split when thawed.',
      // FR: Refroidis vite : plat posé dans l'eau froide, en remuant de temps en temps.
      'Cool quickly: stand the dish in cold water, stirring from time to time.',
      // FR: Répartis en portions, en laissant 2 cm de vide, ferme et date.
      'Divide into portions, leaving 2 cm of space at the top, close and write the date.',
    ],
  ),
  'topinambour/Velouté de topinambour': RecipeText(
    // FR: Velouté de topinambour
    name: 'Jerusalem artichoke soup',
    // FR: Goût d'artichaut, texture de velours.
    description: 'An artichoke flavour with a velvet texture.',
  ),
  'topinambour/Topinambours rôtis au thym': RecipeText(
    // FR: Topinambours rôtis au thym
    name: 'Thyme-roasted Jerusalem artichokes',
    // FR: Brossés sans éplucher, coupés en deux, au four.
    description: 'Scrubbed but not peeled, halved, in the oven.',
  ),
  'topinambour/Salade de topinambours crus': RecipeText(
    // FR: Salade de topinambours crus
    name: 'Raw Jerusalem artichoke salad',
    // FR: Râpés fin, citron, noisettes. Surprenant et bon.
    description: 'Finely grated, with lemon and hazelnuts. Surprising and good.',
  ),

  // ─────────── tournesol (6 recettes) ───────────
  'tournesol/Têtes de tournesol séchées et égrenées': RecipeText(
    // FR: Têtes de tournesol séchées et égrenées
    name: 'Dried and threshed sunflower heads',
    // FR: Protégées des oiseaux puis séchées tête en bas, elles te donnent des graines pour toute l'année.
    description: 'Protected from the birds, then dried upside down, they give you seeds for the whole year.',
    // FR: 1 an au sec, à l'abri de la lumière et des insectes
    keeps: '1 year in a dry place, away from light and insects',
    ingredients: <String>[
      'ripe sunflower heads', // FR: des têtes de tournesol mûres
      'paper bags or netting', // FR: des sacs en papier ou du voile
      'string', // FR: de la ficelle
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Quand les pétales tombent et que le **dos de la tête jaunit**, enferme-la dans un sac en papier ou un voile contre les oiseaux.
      'When the petals fall and the **back of the head turns yellow**, cover it with a paper bag or netting to keep the birds off.',
      // FR: Coupe la tête avec 30 cm de tige quand le dos vire au brun et que les graines sont bien pleines.
      'Cut the head with 30 cm of stalk once the back turns brown and the seeds are nice and plump.',
      // FR: Suspends-la tête en bas dans un endroit sec et aéré, deux à trois semaines, toujours dans son sac.
      'Hang it upside down somewhere dry and airy for two to three weeks, always in its bag.',
      // FR: Frotte la tête avec la paume ou une brosse dure : les graines se détachent d'elles-mêmes.
      'Rub the head with your palm or a stiff brush: the seeds come away on their own.',
      // FR: Étale-les sur un plateau trois jours de plus, à l'ombre. Une graine bien sèche craque sous la dent.
      'Spread them on a tray for three more days, in the shade. A properly dry seed cracks between your teeth.',
      // FR: Passe-les 48 heures au congélateur contre les mites, puis range-les en bocal bien fermé, dans leur coque.
      'Put them in the freezer for 48 hours against moths, then store them in a tightly closed jar, still in their shells.',
    ],
  ),
  'tournesol/Graines décortiquées au congélateur': RecipeText(
    // FR: Graines décortiquées au congélateur
    name: 'Shelled seeds in the freezer',
    // FR: Sans leur coque, les graines rancissent vite au placard ; au froid, elles restent fraîches un an.
    description: 'Without their shells, seeds go rancid quickly in the cupboard; in the cold, they stay fresh for a year.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'shelled sunflower seeds, completely dry', // FR: des graines de tournesol décortiquées et bien sèches
      'freezer jars or bags', // FR: des bocaux ou sachets de congélation
    ],
    steps: <String>[
      // FR: Écarte les graines tachées, moisies ou vides avant de stocker.
      'Set aside any seeds that are stained, mouldy or empty before storing.',
      // FR: Vérifie qu'elles sont **parfaitement sèches** : elles doivent rouler sans coller.
      'Check that they are **completely dry**: they should roll around without sticking.',
      // FR: Répartis-les en sachets de 200 g, une quantité facile à finir.
      'Divide them into 200 g bags, an amount that is easy to finish.',
      // FR: Chasse l'air, ferme bien, note la date et congèle.
      'Squeeze out the air, close tightly, write the date on it and freeze.',
      // FR: Utilise-les directement sans décongeler, dans le pain, les salades ou une poêle sèche.
      'Use them straight from the freezer, no need to thaw, in bread, in salads or in a dry frying pan.',
    ],
  ),
  'tournesol/Graines en coque salées à l\'apéro': RecipeText(
    // FR: Graines en coque salées à l'apéro
    name: 'Salted in-shell seeds for snacking',
    // FR: Trempées dans l'eau salée puis séchées au four, comme celles qu'on grignote dans le Sud.
    description: 'Soaked in salted water then dried in the oven, like the ones people nibble in the South.',
    // FR: 2 mois au sec, en bocal fermé
    keeps: '2 months in a dry place, in a closed jar',
    ingredients: <String>[
      '500 g of sunflower seeds in the shell, completely dry', // FR: 500 g de graines de tournesol en coque, bien sèches
      '2 litres of water', // FR: 2 litres d'eau
      '70 g of salt', // FR: 70 g de sel
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Dissous le sel dans l'eau froide.
      'Dissolve the salt in the cold water.',
      // FR: Plonges-y les graines et laisse tremper toute une nuit, environ 8 heures. Une assiette dessus les garde sous l'eau.
      'Add the seeds and leave to soak overnight, about 8 hours. A plate on top keeps them under the water.',
      // FR: Égoutte-les et étale-les sur un torchon pour enlever l'eau de surface.
      'Drain them and spread them on a tea towel to take off the surface water.',
      // FR: Étale-les en une couche sur une plaque et sèche-les au four à 130 °C, en remuant tous les quarts d'heure.
      'Spread them in a single layer on a baking tray and dry them in the oven at 130 °C, stirring every quarter of an hour.',
      // FR: Elles sont prêtes quand la coque est sèche et l'amande blonde et croquante. Goûte-en une, refroidie.
      'They are ready when the shell is dry and the kernel is golden and crunchy. Taste one once it has cooled.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les mettre en bocal.
      'Let them cool completely on the tray before putting them in the jar.',
    ],
  ),
  'tournesol/Graines de tournesol grillées': RecipeText(
    // FR: Graines de tournesol grillées
    name: 'Toasted sunflower seeds',
    // FR: À la poêle à sec, salées à la sortie.
    description: 'Dry-fried in a pan, salted as they come off the heat.',
  ),
  'tournesol/Pain aux graines de tournesol': RecipeText(
    // FR: Pain aux graines de tournesol
    name: 'Sunflower seed bread',
    // FR: Dans la pâte et sur la croûte.
    description: 'In the dough and on the crust.',
  ),
  'tournesol/Pousses de tournesol en salade': RecipeText(
    // FR: Pousses de tournesol en salade
    name: 'Sunflower shoot salad',
    // FR: Germées une semaine, croquantes et douces.
    description: 'Sprouted for a week, crunchy and mild.',
  ),

  // ─────────── verveine (6 recettes) ───────────
  'verveine/Bouquets de verveine séchés': RecipeText(
    // FR: Bouquets de verveine séchés
    name: 'Dried lemon verbena bunches',
    // FR: La verveine garde son parfum de citron mieux que toute autre herbe au séchage : fais-en des réserves.
    description: 'Lemon verbena keeps its lemony scent when dried better than any other herb: make yourself a stock.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'stems of lemon verbena', // FR: des tiges de verveine citronnée
      'string', // FR: de la ficelle
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges de 20 à 30 cm par temps sec, de préférence juste avant la floraison. La plante repousse aussitôt.
      'Cut stems 20 to 30 cm long in dry weather, ideally just before flowering. The plant grows straight back.',
      // FR: Lie-les en petits bouquets lâches, sans les laver si elles sont propres.
      'Tie them in small, loose bunches, without washing them if they are clean.',
      // FR: Suspends-les tête en bas dans un endroit **sombre et aéré**, une dizaine de jours.
      'Hang them upside down somewhere **dark and airy** for about ten days.',
      // FR: Les feuilles sont prêtes quand elles se détachent en craquant.
      'The leaves are ready when they come away with a crackle.',
      // FR: Effeuille-les entières dans un bocal : cinq ou six feuilles suffisent pour une théière.
      'Strip them off whole into a jar: five or six leaves are enough for a teapot.',
    ],
  ),
  'verveine/Gelée de verveine citronnée': RecipeText(
    // FR: Gelée de verveine citronnée
    name: 'Lemon verbena jelly',
    // FR: Une gelée blonde au parfum de citron, divine sur une tartine ou avec un yaourt.
    description: 'A golden jelly with a lemony scent, wonderful on toast or with yoghurt.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '2 generous handfuls of verbena leaves (about 40 g)', // FR: 2 belles poignées de feuilles de verveine (environ 40 g)
      '1 litre of water', // FR: 1 litre d'eau
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '800 g of sugar', // FR: 800 g de sucre
      '1 sachet of pectin per 1 kg of fruit', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Rince les feuilles et froisse-les entre tes mains pour libérer leurs huiles.
      'Rinse the leaves and crush them between your hands to release their oils.',
      // FR: Porte l'eau à ébullition, verse-la sur les feuilles et couvre.
      'Bring the water to the boil, pour it over the leaves and cover.',
      // FR: Laisse infuser hors du feu, puis filtre en pressant les feuilles.
      'Leave to infuse off the heat, then strain, pressing the leaves.',
      // FR: Ajoute le jus de citron, qui aide la gelée à prendre.
      'Add the lemon juice, which helps the jelly set.',
      // FR: Incorpore la pectine mélangée à un peu de sucre, porte à ébullition, puis verse le reste du sucre.
      'Stir in the pectin mixed with a little of the sugar, bring to the boil, then add the rest of the sugar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Boil hard, stirring, for the time given on the pectin packet.',
      // FR: Mets en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into hot, scalded jars, close them and turn them upside down until cool.',
    ],
  ),
  'verveine/Feuilles de verveine congelées': RecipeText(
    // FR: Feuilles de verveine congelées
    name: 'Frozen lemon verbena leaves',
    // FR: Dix minutes, et le parfum de la verveine fraîche pour tes crèmes et tes desserts d'hiver.
    description: 'Ten minutes, and the scent of fresh verbena for your creams and winter desserts.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '3 handfuls of verbena leaves', // FR: 3 poignées de feuilles de verveine
      'a zip-top freezer bag', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les bien dans un torchon.
      'Rinse the leaves and dry them well in a tea towel.',
      // FR: Détache-les des tiges, en les gardant entières.
      'Pull them off the stems, keeping them whole.',
      // FR: Mets-les à plat dans le sac, chasse l'air, ferme et congèle à plat.
      'Lay them flat in the bag, squeeze out the air, close it and freeze flat.',
      // FR: Infuse-les **encore gelées** dans le lait chaud d'une crème ou dans l'eau d'une tisane. Elles noircissent, pas leur goût.
      'Infuse them **still frozen** in the hot milk for a cream or in the water for a herbal tea. They turn black, but their flavour doesn\'t.',
    ],
  ),
  'verveine/Infusion de verveine': RecipeText(
    // FR: Infusion de verveine
    name: 'Verbena tea',
    // FR: La tisane du soir, séchée en bouquets la tête en bas.
    description: 'The evening herbal tea, dried in bunches hung upside down.',
  ),
  'verveine/Crème à la verveine': RecipeText(
    // FR: Crème à la verveine
    name: 'Verbena cream',
    // FR: Infusée dans le lait chaud vingt minutes.
    description: 'Infused in hot milk for twenty minutes.',
  ),
  'verveine/Sorbet à la verveine': RecipeText(
    // FR: Sorbet à la verveine
    name: 'Verbena sorbet',
    // FR: Vert pâle, très parfumé, servi avec des pêches.
    description: 'Pale green, very fragrant, served with peaches.',
  ),

  // ─────────── vigne (6 recettes) ───────────
  'vigne/Raisins secs maison': RecipeText(
    // FR: Raisins secs maison
    name: 'Homemade raisins',
    // FR: Une treille entière ne se mange pas en dix jours : séché, le raisin se garde toute l'année.
    description: 'A whole vine arbour can\'t be eaten in ten days: dried, the grapes keep all year.',
    // FR: 1 an en bocal, au sec
    keeps: '1 year in a jar, in a dry place',
    ingredients: <String>[
      '2 kg of seedless table grapes, fully ripe', // FR: 2 kg de raisin de table sans pépins, bien mûr
      'a bowl of iced water', // FR: un saladier d'eau glacée
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Égrappe le raisin, lave les grains et écarte ceux qui sont fendus ou moisis.
      'Pick the grapes off the stems, wash them and set aside any that are split or mouldy.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille et le grain sèche deux fois plus vite.
      'Plunge them into boiling water for **30 seconds**: the skin cracks and the grapes dry twice as fast.',
      // FR: Passe-les aussitôt dans l'eau glacée, puis égoutte et sèche-les sur un torchon.
      'Straight away, put them in the iced water, then drain them and dry them on a tea towel.',
      // FR: Étale-les en une couche sur des grilles et sèche au four à **60 °C**, porte entrouverte. Remue-les de temps en temps.
      'Spread them in a single layer on racks and dry them in the oven at **60 °C**, door held ajar. Stir them from time to time.',
      // FR: Teste : le grain est fripé et souple, sans jus quand tu l'écrases entre deux doigts.
      'Test: the grape is wrinkled and supple, with no juice when you squash it between two fingers.',
      // FR: Laisse refroidir et mets en bocal. Secoue-le chaque jour une semaine : s'il y a de la buée, remets au four.
      'Leave to cool and put them in a jar. Shake it every day for a week: if you see condensation, put them back in the oven.',
    ],
  ),
  'vigne/Grains de raisin congelés': RecipeText(
    // FR: Grains de raisin congelés
    name: 'Frozen grapes',
    // FR: Croqués directement sortis du congélateur, ils ont la texture d'un sorbet. Les enfants adorent.
    description: 'Eaten straight from the freezer, they have the texture of a sorbet. Children love them.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 kg of table grapes', // FR: 1 kg de raisin de table
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrappe le raisin et lave les grains dans une passoire.
      'Pick the grapes off the stems and wash them in a colander.',
      // FR: Sèche-les bien sur un torchon, en les roulant doucement : l'eau restée colle les grains entre eux.
      'Dry them well on a tea towel, rolling them gently: any water left on them glues the grapes together.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 3 heures.
      'Spread them on a tray so they don\'t touch, and freeze for 3 hours.',
      // FR: Verse-les en sac une fois durs. Ils se mangent **encore congelés**, ou remplacent des glaçons dans un verre.
      'Tip them into a bag once they are hard. Eat them **still frozen**, or use them instead of ice cubes in a glass.',
    ],
  ),
  'vigne/Gelée de raisin à la pomme': RecipeText(
    // FR: Gelée de raisin à la pomme
    name: 'Grape and apple jelly',
    // FR: Le raisin manque de pectine, la pomme en a pour deux : ensemble, ils font une gelée qui prend toute seule.
    description: 'Grapes are short of pectin and apples have enough for two: together they make a jelly that sets by itself.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '2 kg of grapes', // FR: 2 kg de raisin
      '2 tart apples', // FR: 2 pommes acidulées
      '750 g of sugar per litre of juice', // FR: 750 g de sucre par litre de jus
      'the juice of one lemon', // FR: le jus d'un citron
      '6 jam jars', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Égrappe et lave le raisin. Coupe les pommes en morceaux **avec peau et pépins** : c'est là qu'est la pectine.
      'Pick the grapes off the stems and wash them. Cut the apples into pieces **with the skin and pips**: that is where the pectin is.',
      // FR: Cuis raisin et pommes avec un verre d'eau, à couvert, en écrasant de temps en temps.
      'Cook the grapes and apples with a glass of water, covered, crushing them from time to time.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter sans presser, pour une gelée limpide.
      'Pour into a clean cloth set over a colander and leave to drip without pressing, for a clear jelly.',
      // FR: Mesure le jus, ajoute 750 g de sucre par litre et le jus de citron, puis porte à ébullition en écumant.
      'Measure the juice, add 750 g of sugar per litre and the lemon juice, then bring to the boil, skimming.',
      // FR: Cuis à gros bouillons, puis teste sur une assiette froide : une goutte qui se fige est prête.
      'Boil hard, then test on a cold plate: a drop that sets is ready.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars, close them and turn them upside down until cool.',
    ],
  ),
  'vigne/Feuilles de vigne farcies': RecipeText(
    // FR: Feuilles de vigne farcies
    name: 'Stuffed vine leaves',
    // FR: Riz, herbes, citron — les jeunes feuilles du printemps.
    description: 'Rice, herbs, lemon — the young leaves of spring.',
  ),
  'vigne/Raisiné': RecipeText(
    // FR: Raisiné
    name: 'Raisiné (grape syrup)',
    // FR: Du jus de raisin réduit des heures, sans une once de sucre.
    description: 'Grape juice reduced for hours, with no sugar at all.',
  ),
  'vigne/Verjus': RecipeText(
    // FR: Verjus
    name: 'Verjuice',
    // FR: Le jus des raisins verts, acide, qui remplace le vinaigre.
    description: 'The juice of unripe green grapes, sharp, used in place of vinegar.',
  ),

  // ─────────── pak_choi (6 recettes) ───────────
  'pak_choi/Pak choï blanchi congelé': RecipeText(
    // FR: Pak choï blanchi congelé
    name: 'Blanched frozen pak choi',
    // FR: Coupé en quartiers et blanchi juste ce qu'il faut, il garde sa tige croquante pour tes woks d'hiver.
    description: 'Quartered and blanched just enough, it keeps its crunchy stem for your winter stir-fries.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of pak choi', // FR: 1,5 kg de pak choï
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les pieds en deux ou en quatre dans la longueur, en gardant la base pour que les feuilles tiennent.
      'Cut the heads in half or in quarters lengthways, keeping the base so the leaves hold together.',
      // FR: Rince bien entre les tiges, où la terre se loge.
      'Rinse well between the stems, where the soil hides.',
      // FR: Plonge-les dans une grande eau bouillante salée, **2 minutes**, pas plus.
      'Plunge them into a large pan of boiling salted water for **2 minutes**, no longer.',
      // FR: Transfère aussitôt dans l'eau glacée pour fixer le vert.
      'Move them straight into the iced water to set the green.',
      // FR: Égoutte la tête en bas puis sèche sur un torchon en pressant doucement.
      'Drain them head down, then dry on a tea towel, pressing gently.',
      // FR: Congèle 2 heures sur une plaque, puis mets en sacs datés. Fais-le sauter encore gelé, à feu vif.
      'Freeze for 2 hours on a tray, then put into dated bags. Stir-fry it still frozen, over a high heat.',
    ],
  ),
  'pak_choi/Pak choï lacto-fermenté au piment': RecipeText(
    // FR: Pak choï lacto-fermenté au piment
    name: 'Chilli lacto-fermented pak choi',
    // FR: En saumure une petite semaine, il devient acidulé et piquant, un condiment pour tes bols de riz.
    description: 'A little under a week in brine and it turns tangy and hot, a condiment for your rice bowls.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 kg of pak choi', // FR: 1 kg de pak choï
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '1 fresh chilli', // FR: 1 piment frais
      '1 piece of ginger, 3 cm long', // FR: 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Dissolve **30 g of salt in 1 litre of water**: a 3 % brine.',
      // FR: Coupe le pak choï en tronçons de 3 cm, le piment en rondelles, le gingembre en lamelles.
      'Cut the pak choi into 3 cm pieces, the chilli into rounds and the ginger into slivers.',
      // FR: Rince les tronçons et égoutte-les bien.
      'Rinse the pieces and drain them well.',
      // FR: Tasse le tout dans deux bocaux jusqu'à 3 cm du bord, et couvre de saumure.
      'Pack everything into two jars, up to 3 cm from the rim, and cover with brine.',
      // FR: Pose un poids pour garder les feuilles **sous la saumure**, et ferme sans serrer.
      'Put a weight on top to keep the leaves **under the brine**, and close the lid without tightening it.',
      // FR: Laisse fermenter 1 semaine à 18–22 °C, puis goûte : acidulé, c'est prêt. Sinon, quelques jours de plus. Ensuite, au réfrigérateur.
      'Leave to ferment for 1 week at 18–22 °C, then taste: if it is tangy, it is ready. If not, give it a few more days. After that, keep it in the fridge.',
    ],
  ),
  'pak_choi/Tiges de pak choï au vinaigre de riz': RecipeText(
    // FR: Tiges de pak choï au vinaigre de riz
    name: 'Pak choi stems in rice vinegar',
    // FR: Les tiges blanches, croquantes comme du céleri, deviennent un pickle aigre-doux en vingt minutes.
    description: 'The white stems, crunchy as celery, become a sweet-and-sour pickle in twenty minutes.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '500 g of pak choi stems', // FR: 500 g de tiges de pak choï
      '25 cl of white vinegar at 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl of water', // FR: 25 cl d'eau
      '10 g of salt, 40 g of sugar', // FR: 10 g de sel, 40 g de sucre
      '1 garlic clove', // FR: 1 gousse d'ail
    ],
    steps: <String>[
      // FR: Sépare les tiges des feuilles et taille-les en bâtonnets. Les feuilles iront dans une poêlée.
      'Separate the stems from the leaves and cut them into sticks. The leaves can go into a stir-fry.',
      // FR: Range les bâtonnets dans deux bocaux ébouillantés avec l'ail en lamelles.
      'Pack the sticks into two scalded jars with the garlic, sliced.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Boil the vinegar, water, salt and sugar.',
      // FR: Verse bouillant pour **couvrir entièrement** les tiges et ferme.
      'Pour it in boiling to **cover the stems completely**, and close the lid.',
      // FR: Laisse refroidir, puis au réfrigérateur. Bons au bout de 24 heures.
      'Leave to cool, then put in the fridge. Good after 24 hours.',
    ],
  ),
  'pak_choi/Pak choï vapeur sauce soja': RecipeText(
    // FR: Pak choï vapeur sauce soja
    name: 'Steamed pak choi with soy sauce',
    // FR: Fendu en deux, cinq minutes de vapeur, un filet de soja.
    description: 'Split in two, five minutes of steam, a drizzle of soy.',
  ),
  'pak_choi/Pak choï sauté à l\'ail': RecipeText(
    // FR: Pak choï sauté à l'ail
    name: 'Garlic stir-fried pak choi',
    // FR: Les tiges d'abord, les feuilles à la fin.
    description: 'Stems first, leaves at the end.',
  ),
  'pak_choi/Nouilles sautées au pak choï': RecipeText(
    // FR: Nouilles sautées au pak choï
    name: 'Pak choi stir-fried noodles',
    // FR: Un plat complet en un seul wok.
    description: 'A complete meal in one wok.',
  ),

  // ─────────── panais (6 recettes) ───────────
  'panais/Rondelles de panais blanchies': RecipeText(
    // FR: Rondelles de panais blanchies
    name: 'Blanched parsnip rounds',
    // FR: Trois minutes dans l'eau bouillante, et les rondelles vont directement du sac au four ou à la soupe.
    description: 'Three minutes in boiling water, and the rounds go straight from the bag to the oven or the soup.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of parsnips', // FR: 2 kg de panais
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les panais et coupe-les en rondelles de 1 cm. Retire le cœur s'il est dur et ligneux sur les gros.
      'Peel the parsnips and cut them into 1 cm rounds. On the big ones, remove the core if it is hard and woody.',
      // FR: Blanchis-les **3 minutes** dans une grande eau bouillante salée.
      'Blanch them for **3 minutes** in a large pan of boiling salted water.',
      // FR: Plonge-les aussitôt dans l'eau glacée : sinon ils continuent de cuire et deviennent farineux.
      'Plunge them straight into the iced water: otherwise they keep cooking and turn mealy.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Drain and dry well on a tea towel.',
      // FR: Congèle sur plaque 2 heures sans qu'elles se touchent, puis verse en sacs datés.
      'Freeze on a tray for 2 hours without letting them touch, then tip into dated bags.',
    ],
  ),
  'panais/Écrasé de panais en portions': RecipeText(
    // FR: Écrasé de panais en portions
    name: 'Mashed parsnip in portions',
    // FR: Cuit, écrasé au beurre et congelé à plat : un accompagnement prêt en cinq minutes les soirs pressés.
    description: 'Cooked, mashed with butter and frozen flat: a side dish ready in five minutes on rushed evenings.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of parsnips', // FR: 2 kg de panais
      '60 g of butter', // FR: 60 g de beurre
      '1 pinch of nutmeg', // FR: 1 pincée de muscade
      'salt, pepper', // FR: sel, poivre
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les panais et coupe-les en tronçons égaux.
      'Peel the parsnips and cut them into even chunks.',
      // FR: Cuis-les à l'eau salée jusqu'à ce qu'un couteau s'enfonce sans résistance.
      'Cook them in salted water until a knife slides in without resistance.',
      // FR: Égoutte bien puis écrase à la fourchette ou au presse-purée avec le beurre et la muscade. Pas au mixeur : ça devient collant.
      'Drain well, then mash with a fork or a potato masher with the butter and nutmeg. Not with a blender: it turns sticky.',
      // FR: Laisse refroidir complètement, étalé dans un plat : un écrasé tiède fait de gros cristaux au congélateur.
      'Leave to cool completely, spread out in a dish: a warm mash forms big ice crystals in the freezer.',
      // FR: Répartis en sacs d'une portion, aplatis-les pour qu'ils congèlent et décongèlent vite, et date-les.
      'Divide into single-portion bags, flatten them so they freeze and thaw quickly, and date them.',
    ],
  ),
  'panais/Chips de panais séchées': RecipeText(
    // FR: Chips de panais séchées
    name: 'Dried parsnip crisps',
    // FR: Tranchées fines et séchées au four doux, elles se grignotent tout l'hiver.
    description: 'Sliced thin and dried in a low oven, they keep you snacking all winter.',
    // FR: 1 mois en boîte hermétique, au sec
    keeps: '1 month in an airtight tin, in a dry place',
    ingredients: <String>[
      '1 kg of parsnips', // FR: 1 kg de panais
      '1 tablespoon of olive oil', // FR: 1 cuillère à soupe d'huile d'olive
      '1 teaspoon of fine salt', // FR: 1 cuillère à café de sel fin
      'an airtight tin', // FR: une boîte hermétique
    ],
    steps: <String>[
      // FR: Épluche les panais et tranche-les très finement à la mandoline, 2 mm maximum.
      'Peel the parsnips and slice them very thinly on a mandoline, 2 mm at most.',
      // FR: Mélange les tranches avec l'huile et le sel, en les frottant pour bien les enrober.
      'Mix the slices with the oil and salt, rubbing them so they are well coated.',
      // FR: Étale-les en une couche sur des plaques garnies de papier cuisson et enfourne à 100 °C, porte entrouverte.
      'Spread them in a single layer on trays lined with baking paper and put them in the oven at 100 °C, door held ajar.',
      // FR: Retourne-les à mi-cuisson. Elles sont prêtes quand elles sont **cassantes**, pas seulement dorées.
      'Turn them halfway through. They are ready when they are **brittle**, not just golden.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les enfermer : tièdes, elles ramollissent.
      'Let them cool completely on the tray before you put them away: warm, they go soft.',
    ],
  ),
  'panais/Panais rôtis au miel': RecipeText(
    // FR: Panais rôtis au miel
    name: 'Honey-roasted parsnips',
    // FR: Sucré naturellement, le four le confirme.
    description: 'Naturally sweet, and the oven proves it.',
  ),
  'panais/Velouté de panais': RecipeText(
    // FR: Velouté de panais
    name: 'Parsnip velouté',
    // FR: Doux, épais, une pointe de muscade.
    description: 'Soft, thick, with a hint of nutmeg.',
  ),
  'panais/Purée panais-pomme de terre': RecipeText(
    // FR: Purée panais-pomme de terre
    name: 'Parsnip and potato mash',
    // FR: Moitié-moitié, pour ne pas écœurer.
    description: 'Half and half, so it is never too rich.',
  ),

  // ─────────── papayer (6 recettes) ───────────
  'papayer/Cubes de papaye mûre congelés': RecipeText(
    // FR: Cubes de papaye mûre congelés
    name: 'Frozen ripe papaya cubes',
    // FR: Quand toutes les papayes mûrissent en même temps, un quart d'heure suffit pour en garder pour les smoothies.
    description: 'When all the papayas ripen at once, a quarter of an hour is enough to save some for smoothies.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '3 ripe papayas', // FR: 3 papayes mûres
      'the juice of 2 limes', // FR: le jus de 2 citrons verts
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les papayes en deux, retire les graines noires à la cuillère, puis épluche.
      'Cut the papayas in half, scoop out the black seeds with a spoon, then peel.',
      // FR: Coupe la chair en cubes de 3 cm.
      'Cut the flesh into 3 cm cubes.',
      // FR: Arrose de jus de citron vert et mélange : il garde la couleur et réveille le goût.
      'Sprinkle with lime juice and toss: it keeps the colour and brightens the flavour.',
      // FR: Étale sur une plaque sans que les cubes se touchent et congèle 2 heures.
      'Spread on a tray without letting the cubes touch and freeze for 2 hours.',
      // FR: Verse en sac une fois durs. À mixer encore gelés avec du lait ou du yaourt.
      'Tip into a bag once hard. Blend them still frozen with milk or yoghurt.',
    ],
  ),
  'papayer/Atchara de papaye verte': RecipeText(
    // FR: Atchara de papaye verte
    name: 'Green papaya atchara',
    // FR: Le pickle des Philippines : papaye verte râpée, carotte et gingembre dans un vinaigre sucré, croquant pendant des semaines.
    description: 'The Philippine pickle: grated green papaya, carrot and ginger in a sweet vinegar, crunchy for weeks.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 green papaya of about 1.5 kg', // FR: 1 papaye verte d'environ 1,5 kg
      '2 carrots', // FR: 2 carottes
      '30 g of salt', // FR: 30 g de sel
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '30 cl of water and 200 g of sugar', // FR: 30 cl d'eau et 200 g de sucre
      '1 piece of ginger, 4 cm long', // FR: 1 morceau de gingembre de 4 cm
    ],
    steps: <String>[
      // FR: Épluche la papaye verte, ouvre-la, retire les graines blanches, puis râpe-la côté gros trous. Râpe aussi les carottes.
      'Peel the green papaya, cut it open, remove the white seeds, then grate it on the coarse side. Grate the carrots too.',
      // FR: Mélange la râpée avec le sel et laisse une heure : elle rend beaucoup d'eau.
      'Mix the gratings with the salt and leave for an hour: they release a lot of water.',
      // FR: Rince à l'eau froide et presse par poignées dans un torchon, **très fort**.
      'Rinse in cold water and squeeze by handfuls in a tea towel, **really hard**.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sucre, puis laisse refroidir.
      'Bring the vinegar, water and sugar to the boil, then leave to cool.',
      // FR: Tasse papaye, carotte et gingembre en julienne dans des bocaux propres.
      'Pack the papaya, carrot and julienned ginger into clean jars.',
      // FR: Verse le vinaigre pour **tout recouvrir**, ferme et range au réfrigérateur. Prête en 2 jours.
      'Pour in the vinegar to **cover everything**, close the lid and keep in the fridge. Ready in 2 days.',
    ],
  ),
  'papayer/Chutney de papaye au gingembre': RecipeText(
    // FR: Chutney de papaye au gingembre
    name: 'Ginger papaya chutney',
    // FR: Papaye mûre, oignon, piment et vinaigre mijotés longtemps : un chutney sucré-piquant pour les grillades et le fromage.
    description: 'Ripe papaya, onion, chilli and vinegar simmered for a long time: a sweet-and-hot chutney for grills and cheese.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 kg of barely ripe papaya flesh', // FR: 1 kg de chair de papaye à peine mûre
      '2 onions', // FR: 2 oignons
      '30 cl of cider vinegar at 6 %', // FR: 30 cl de vinaigre de cidre à 6 %
      '300 g of brown sugar', // FR: 300 g de sucre roux
      '1 piece of ginger, 4 cm long', // FR: 1 morceau de gingembre de 4 cm
      '1 chilli and 1 teaspoon of salt', // FR: 1 piment et 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Coupe la papaye en petits dés, émince les oignons, râpe le gingembre et hache le piment sans ses graines.
      'Cut the papaya into small dice, slice the onions, grate the ginger and chop the chilli without its seeds.',
      // FR: Mets tout dans une grande casserole avec le vinaigre, le sucre et le sel, et porte à ébullition.
      'Put everything into a large pan with the vinegar, sugar and salt, and bring to the boil.',
      // FR: Laisse mijoter à petit feu en remuant souvent, surtout à la fin : ça accroche vite.
      'Simmer gently, stirring often, especially towards the end: it catches quickly.',
      // FR: C'est prêt quand une cuillère tirée au fond laisse **un sillon qui ne se referme pas**.
      'It is ready when a spoon drawn across the bottom leaves **a trail that does not close up**.',
      // FR: Remplis des pots ébouillantés jusqu'à 1 cm du bord, ferme aussitôt.
      'Fill scalded jars to 1 cm from the rim and close the lids straight away.',
      // FR: Laisse refroidir et range au réfrigérateur : la papaye est peu acide, le froid est ta sécurité. Meilleur après une semaine.
      'Leave to cool and keep in the fridge: papaya is low in acid, so the cold is your safeguard. Better after a week.',
    ],
  ),
  'papayer/Papaye verte mijotée': RecipeText(
    // FR: Papaye verte mijotée
    name: 'Stewed green papaya',
    // FR: Encore ferme, elle se cuisine comme une courge.
    description: 'Still firm, it is cooked like a squash.',
  ),
  'papayer/Salade de papaye verte': RecipeText(
    // FR: Salade de papaye verte
    name: 'Green papaya salad',
    // FR: La papaye encore verte râpée en salade croquante, citronnée et un peu pimentée.
    description: 'Still-green papaya, grated into a crunchy salad, zesty with lime and a little hot.',
  ),
  'papayer/Papaye au citron vert': RecipeText(
    // FR: Papaye au citron vert
    name: 'Papaya with lime',
    // FR: Des tranches de papaye mûre arrosées de citron vert, le dessert le plus simple du monde.
    description: 'Slices of ripe papaya sprinkled with lime juice, the simplest dessert in the world.',
  ),

  // ─────────── pasteque (6 recettes) ───────────
  'pasteque/Cubes de pastèque congelés': RecipeText(
    // FR: Cubes de pastèque congelés
    name: 'Frozen watermelon cubes',
    // FR: Une pastèque entière entamée ne tient pas trois jours : en cubes, elle fait des smoothies et des glaçons tout l'automne.
    description: 'A whole watermelon, once cut, will not last three days: as cubes, it makes smoothies and ice cubes all autumn.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 very ripe watermelon', // FR: 1 pastèque bien mûre
      'freezer bags or boxes', // FR: des sacs ou boîtes de congélation
      'a tray and baking paper', // FR: une plaque et du papier cuisson
    ],
    steps: <String>[
      // FR: Lave l'écorce avant de couper : le couteau entraînerait la terre dans la chair.
      'Wash the rind before cutting: the knife would drag soil into the flesh.',
      // FR: Retire l'écorce et coupe la chair en cubes de 3 cm, en ôtant le plus de pépins possible.
      'Remove the rind and cut the flesh into 3 cm cubes, taking out as many seeds as you can.',
      // FR: Étale les cubes sur une plaque couverte de papier, **sans qu'ils se touchent**, et congèle 3 heures.
      'Spread the cubes on a tray lined with paper, **not touching each other**, and freeze for 3 hours.',
      // FR: Verse-les en sac une fois durs, chasse l'air et ferme.
      'Tip them into a bag once hard, press out the air and close.',
      // FR: À l'usage : décongelée elle devient molle, donc mixe-la encore gelée en smoothie ou sers-la comme glaçon.
      'To use: thawed, it goes soft, so blend it still frozen in a smoothie, or serve it as ice cubes.',
    ],
  ),
  'pasteque/Granité de pastèque au citron vert': RecipeText(
    // FR: Granité de pastèque au citron vert
    name: 'Watermelon and lime granita',
    // FR: Mixée, sucrée à peine et grattée à la fourchette : un dessert glacé qui sent encore l'été en octobre.
    description: 'Blended, barely sweetened and scraped with a fork: a frozen dessert that still tastes of summer in October.',
    // FR: 3 mois au congélateur
    keeps: '3 months in the freezer',
    ingredients: <String>[
      '1.5 kg of seedless watermelon flesh', // FR: 1,5 kg de chair de pastèque sans pépins
      '100 g of sugar', // FR: 100 g de sucre
      'the juice of 2 limes', // FR: le jus de 2 citrons verts
      'a few mint leaves', // FR: quelques feuilles de menthe
    ],
    steps: <String>[
      // FR: Coupe la chair en morceaux et retire les pépins.
      'Cut the flesh into pieces and remove the seeds.',
      // FR: Mixe-la avec le sucre, le citron vert et la menthe, puis passe au tamis pour un granité bien lisse.
      'Blend it with the sugar, lime and mint, then pass through a sieve for a really smooth granita.',
      // FR: Verse dans un plat large et peu profond : plus la couche est fine, plus ça prend vite.
      'Pour into a wide, shallow dish: the thinner the layer, the faster it sets.',
      // FR: Mets au congélateur et gratte à la fourchette **toutes les 30 minutes**, quatre ou cinq fois.
      'Put it in the freezer and scrape with a fork **every 30 minutes**, four or five times.',
      // FR: Quand c'est en paillettes, transvase dans une boîte bien fermée. Gratte encore un coup avant de servir.
      'When it forms flakes, transfer to a well-closed box. Scrape once more before serving.',
    ],
  ),
  'pasteque/Pickles d\'écorce de pastèque': RecipeText(
    // FR: Pickles d'écorce de pastèque
    name: 'Watermelon rind pickles',
    // FR: Le blanc de l'écorce, qu'on jette d'habitude, devient un pickle croquant et épicé du sud des États-Unis.
    description: 'The white of the rind, which usually gets thrown away, becomes a crunchy, spiced pickle from the southern United States.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      'the rind of a 5 kg watermelon (about 1 kg of white)', // FR: l'écorce d'une pastèque de 5 kg (environ 1 kg de blanc)
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '250 g of sugar', // FR: 250 g de sucre
      '1 tablespoon of salt', // FR: 1 cuillère à soupe de sel
      '1 cinnamon stick and 5 cloves', // FR: 1 bâton de cannelle et 5 clous de girofle
    ],
    steps: <String>[
      // FR: Épluche la peau verte dure au couteau éplucheur et garde le blanc, avec un fin liseré rose.
      'Peel off the tough green skin with a vegetable peeler and keep the white, with its thin pink edge.',
      // FR: Coupe ce blanc en cubes de 2 cm.
      'Cut this white part into 2 cm cubes.',
      // FR: Cuis les cubes à l'eau salée frémissante jusqu'à ce qu'ils soient juste tendres, translucides sur les bords.
      'Cook the cubes in gently simmering salted water until just tender, translucent at the edges.',
      // FR: Dans une autre casserole, fais bouillir vinaigre, eau, sucre et épices 5 minutes.
      'In another pan, boil the vinegar, water, sugar and spices for 5 minutes.',
      // FR: Égoutte les cubes, mets-les dans le sirop vinaigré et laisse frémir 10 minutes.
      'Drain the cubes, put them into the vinegar syrup and simmer for 10 minutes.',
      // FR: Remplis des bocaux propres à 2 cm du bord et **couvre entièrement** de liquide chaud. Ferme, laisse refroidir, puis au réfrigérateur.
      'Fill clean jars to 2 cm from the rim and **cover completely** with hot liquid. Close, leave to cool, then put in the fridge.',
    ],
  ),
  'pasteque/Salade pastèque-feta-menthe': RecipeText(
    // FR: Salade pastèque-feta-menthe
    name: 'Watermelon, feta and mint salad',
    // FR: Le salé de la feta contre le sucre du fruit.
    description: 'The saltiness of the feta against the sweetness of the fruit.',
  ),
  'pasteque/Confiture d\'écorces de pastèque': RecipeText(
    // FR: Confiture d'écorces de pastèque
    name: 'Watermelon rind jam',
    // FR: Le blanc de l'écorce, qu'on jette toujours à tort.
    description: 'The white of the rind, which people always wrongly throw away.',
  ),
  'pasteque/Jus de pastèque frais': RecipeText(
    // FR: Jus de pastèque frais
    name: 'Fresh watermelon juice',
    // FR: La pastèque mixée avec un peu de citron vert, la boisson des grandes chaleurs.
    description: 'Watermelon blended with a little lime, the drink for the hottest days.',
  ),

  // ─────────── patate_douce (6 recettes) ───────────
  'patate_douce/Cubes de patate douce rôtis au congélateur': RecipeText(
    // FR: Cubes de patate douce rôtis au congélateur
    name: 'Roasted sweet potato cubes from the freezer',
    // FR: Rôtis d'avance, ils passent du congélateur au four en dix minutes, pour une soirée sans éplucher.
    description: 'Roasted in advance, they go from the freezer to the oven in ten minutes, for an evening with no peeling.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of sweet potatoes', // FR: 2 kg de patates douces
      '3 tablespoons of oil', // FR: 3 cuillères à soupe d'huile
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
      'baking paper', // FR: du papier cuisson
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les patates douces et coupe-les en cubes de 2 cm, tous pareils.
      'Peel the sweet potatoes and cut them into 2 cm cubes, all the same size.',
      // FR: Mélange-les à l'huile et au sel dans un grand saladier, pour que chaque cube soit enrobé.
      'Toss them with the oil and salt in a large bowl so every cube is coated.',
      // FR: Étale-les sur des plaques sans les entasser et rôtis 25 minutes à 200 °C : **tendres mais pas fondants**.
      'Spread them on trays without crowding them and roast for 25 minutes at 200 °C: **tender but not mushy**.',
      // FR: Laisse-les refroidir complètement sur la plaque.
      'Leave them to cool completely on the tray.',
      // FR: Congèle la plaque 2 heures, puis verse les cubes en sac. Réchauffe-les sans décongeler, 10 minutes à 220 °C.
      'Freeze the tray for 2 hours, then tip the cubes into a bag. Reheat them without thawing, 10 minutes at 220 °C.',
    ],
  ),
  'patate_douce/Patates douces blanchies en dés': RecipeText(
    // FR: Patates douces blanchies en dés
    name: 'Blanched sweet potato dice',
    // FR: Trois minutes dans l'eau, et des dés prêts pour les mafés, les currys et les soupes, sans perdre leur couleur.
    description: 'Three minutes in the water, and you have dice ready for mafés, curries and soups, with their colour intact.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1.5 kg of sweet potatoes', // FR: 1,5 kg de patates douces
      'the juice of a lemon', // FR: le jus d'un citron
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche et coupe en dés de 2 cm ; jette-les au fur et à mesure dans l'eau citronnée pour qu'ils ne brunissent pas.
      'Peel and cut into 2 cm dice; drop them into the lemon water as you go so they do not brown.',
      // FR: Plonge-les dans l'eau bouillante et compte **3 minutes** à la reprise de l'ébullition.
      'Plunge them into boiling water and count **3 minutes** from when it returns to the boil.',
      // FR: Transfère-les aussitôt dans l'eau glacée.
      'Move them straight into the iced water.',
      // FR: Égoutte-les et sèche-les sur un torchon.
      'Drain them and dry on a tea towel.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets-les en sac. Cuis-les sans décongeler, ils finissent de cuire dans le plat.
      'Spread them on a tray, freeze for 2 hours, then put them into a bag. Cook them without thawing; they finish cooking in the dish.',
    ],
  ),
  'patate_douce/Rondelles de patate douce déshydratées': RecipeText(
    // FR: Rondelles de patate douce déshydratées
    name: 'Dehydrated sweet potato rounds',
    // FR: Cuites puis séchées, elles se croquent comme des fruits secs ou regonflent dans une soupe.
    description: 'Cooked then dried, they can be crunched like dried fruit or plumped up in a soup.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      '1.5 kg of sweet potatoes', // FR: 1,5 kg de patates douces
      'baking paper', // FR: du papier cuisson
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Épluche et coupe en rondelles de 5 mm, bien régulières.
      'Peel and cut into 5 mm rounds, as even as you can.',
      // FR: Cuis-les à la vapeur jusqu'à ce qu'elles soient tendres mais encore entières.
      'Steam them until tender but still whole.',
      // FR: Laisse-les refroidir et sécher à l'air sur une grille, une seule couche.
      'Leave them to cool and air-dry on a rack, in a single layer.',
      // FR: Sèche-les au four à **60 °C**, porte entrouverte, ou au déshydrateur. Retourne-les à mi-temps.
      'Dry them in the oven at **60 °C**, door held ajar, or in a dehydrator. Turn them halfway.',
      // FR: C'est prêt quand elles sont souples comme du cuir, sans aucune zone humide quand tu les plies.
      'They are ready when they are supple as leather, with no damp spot when you fold them.',
      // FR: Laisse refroidir une heure avant de les mettre en bocal. Secoue le bocal les premiers jours : s'il y a de la buée, remets au four.
      'Leave to cool for an hour before putting them in jars. Shake the jar for the first few days: if you see condensation, back in the oven they go.',
    ],
  ),
  'patate_douce/Frites de patate douce au four': RecipeText(
    // FR: Frites de patate douce au four
    name: 'Oven sweet potato chips',
    // FR: Fécule de maïs avant cuisson : c'est ce qui les rend croustillantes.
    description: 'Cornflour before baking: that is what makes them crisp.',
  ),
  'patate_douce/Frites de patate douce': RecipeText(
    // FR: Frites de patate douce
    name: 'Sweet potato chips',
    // FR: Des frites dorées et sucrées-salées qui plaisent à toute la famille.
    description: 'Golden, sweet-and-salty chips that the whole family will like.',
  ),
  'patate_douce/Purée de patate douce': RecipeText(
    // FR: Purée de patate douce
    name: 'Sweet potato mash',
    // FR: Une purée orange, veloutée et naturellement sucrée, douce comme tout.
    description: 'An orange mash, silky and naturally sweet, as gentle as can be.',
  ),

  // ─────────── pecher (6 recettes) ───────────
  'pecher/Confiture de pêches à la vanille': RecipeText(
    // FR: Confiture de pêches à la vanille
    name: 'Peach and vanilla jam',
    // FR: La pêche ne se garde pas trois jours : en confiture, elle tient jusqu'à l'été suivant.
    description: 'Peaches will not keep for three days: as jam, they last until next summer.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 3 weeks in the fridge once opened',
    ingredients: <String>[
      '1.5 kg of very ripe peaches', // FR: 1,5 kg de pêches bien mûres
      '1 kg of sugar', // FR: 1 kg de sucre
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '1 vanilla pod', // FR: 1 gousse de vanille
      '6 jam jars', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Plonge les pêches **30 secondes** dans l'eau bouillante, puis dans l'eau froide : la peau s'enlève toute seule.
      'Plunge the peaches into boiling water for **30 seconds**, then into cold water: the skin slips off by itself.',
      // FR: Pèle-les, retire le noyau et coupe la chair en dés de 2 cm. Tu dois avoir environ 1,2 kg de chair.
      'Peel them, remove the stone and cut the flesh into 2 cm dice. You should have about 1.2 kg of flesh.',
      // FR: Mélange les dés avec le sucre, le citron et la vanille fendue, et laisse macérer au frais.
      'Mix the dice with the sugar, lemon and the split vanilla pod, and leave to macerate somewhere cool.',
      // FR: Porte à ébullition et cuis à feu vif en remuant et en écumant.
      'Bring to the boil and cook over a high heat, stirring and skimming.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. La pêche manque de pectine, c'est le citron qui fait prendre.
      'Test on a cold plate: a drop that sets is ready. Peaches lack pectin, so it is the lemon that makes it set.',
      // FR: Retire la vanille, mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Remove the vanilla, pour into scalded jars, close and turn upside down until cool.',
    ],
  ),
  'pecher/Quartiers de pêches congelés': RecipeText(
    // FR: Quartiers de pêches congelés
    name: 'Frozen peach wedges',
    // FR: Pelées, citronnées, congelées sur plaque : de la pêche en hiver pour les smoothies et les gâteaux.
    description: 'Peeled, lemony, frozen on a tray: peaches in winter for smoothies and cakes.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of ripe but firm peaches', // FR: 2 kg de pêches mûres mais fermes
      'the juice of a lemon', // FR: le jus d'un citron
      'a bowl of iced water', // FR: un saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Plonge les pêches **30 secondes** dans l'eau bouillante pour décoller la peau.
      'Plunge the peaches into boiling water for **30 seconds** to loosen the skin.',
      // FR: Passe-les aussitôt dans l'eau glacée, puis pèle-les à la main.
      'Put them straight into the iced water, then peel by hand.',
      // FR: Coupe-les en quartiers et retire le noyau.
      'Cut them into wedges and remove the stone.',
      // FR: Arrose de jus de citron et mélange : sans lui, la chair brunit au congélateur.
      'Sprinkle with lemon juice and toss: without it, the flesh browns in the freezer.',
      // FR: Étale sur une plaque sans que les quartiers se touchent, congèle 3 heures, puis mets en sac.
      'Spread on a tray so the wedges do not touch, freeze for 3 hours, then put into a bag.',
    ],
  ),
  'pecher/Lamelles de pêches séchées': RecipeText(
    // FR: Lamelles de pêches séchées
    name: 'Dried peach slices',
    // FR: Séchée, la pêche concentre tout son sucre : un en-cas d'été qui tient dans la poche.
    description: 'Dried, peaches concentrate all their sugar: a summer snack that fits in your pocket.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '2 kg of ripe but firm peaches', // FR: 2 kg de pêches mûres mais fermes
      '1 litre of cold water', // FR: 1 litre d'eau froide
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Pèle les pêches après 30 secondes dans l'eau bouillante et un passage à l'eau froide.
      'Peel the peaches after 30 seconds in boiling water and a dip in cold water.',
      // FR: Retire le noyau et coupe des lamelles de **6 mm**, toutes pareilles pour qu'elles sèchent ensemble.
      'Remove the stone and cut **6 mm** slices, all the same so they dry together.',
      // FR: Trempe-les quelques minutes dans l'eau citronnée, puis éponge-les sur un torchon.
      'Soak them for a few minutes in the lemon water, then pat dry on a tea towel.',
      // FR: Étale-les sur des grilles et sèche au four à **65 °C**, porte entrouverte, en les retournant à mi-temps.
      'Spread them on racks and dry in the oven at **65 °C**, door held ajar, turning them halfway.',
      // FR: Quand elles sont souples comme du cuir et sans jus, laisse refroidir et mets en bocal. Surveille la buée la première semaine.
      'When they are supple as leather and release no juice, leave to cool and put into jars. Watch for condensation during the first week.',
    ],
  ),
  'pecher/Pêches au sirop': RecipeText(
    // FR: Pêches au sirop
    name: 'Peaches in syrup',
    // FR: Pelées après trente secondes d'eau bouillante, mises en bocal.
    description: 'Peeled after thirty seconds in boiling water, then put in jars.',
  ),
  'pecher/Pêches rôties à la verveine': RecipeText(
    // FR: Pêches rôties à la verveine
    name: 'Verbena roasted peaches',
    // FR: Au four avec du miel et des feuilles de verveine du jardin.
    description: 'Baked with honey and lemon verbena leaves from the garden.',
  ),
  'pecher/Pêche Melba': RecipeText(
    // FR: Pêche Melba
    name: 'Peach Melba',
    // FR: Pêche pochée, glace vanille, coulis de framboises.
    description: 'Poached peach, vanilla ice cream, raspberry coulis.',
  ),

  // ─────────── pensee (6 recettes) ───────────
  'pensee/Pensées pressées pour les gâteaux': RecipeText(
    // FR: Pensées pressées pour les gâteaux
    name: 'Pressed pansies for cakes',
    // FR: Séchées à plat dans un livre, elles décorent biscuits et gâteaux toute l'année.
    description: 'Dried flat in a book, they decorate biscuits and cakes all year round.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, away from light',
    ingredients: <String>[
      'about thirty pansy flowers', // FR: une trentaine de fleurs de pensée
      'baking paper or blotting paper', // FR: du papier cuisson ou du papier buvard
      'a big book or a flower press', // FR: un gros livre ou une presse à fleurs
      'an airtight tin', // FR: une boîte hermétique
    ],
    steps: <String>[
      // FR: Cueille des fleurs **sans traitement**, bien sèches, en fin de matinée. Coupe la tige au ras de la fleur.
      'Pick **untreated** flowers, perfectly dry, in late morning. Cut the stem flush with the flower.',
      // FR: Pose-les à plat, face visible, entre deux feuilles de papier, sans qu'elles se touchent.
      'Lay them flat, face up, between two sheets of paper, not touching each other.',
      // FR: Glisse le tout dans un gros livre, charge-le, et laisse dix jours au sec. Change le papier au bout de trois jours s'il est humide.
      'Slip it all into a big book, weigh it down, and leave for ten days in a dry place. Change the paper after three days if it is damp.',
      // FR: Décolle-les délicatement à la pointe d'un couteau quand elles sont fines comme du papier.
      'Gently lift them off with the tip of a knife when they are thin as paper.',
      // FR: Range-les à plat dans la boîte, entre du papier, dans le noir. Pose-les sur un glaçage ou sur des biscuits à peine sortis du four.
      'Store them flat in the tin, between sheets of paper, in the dark. Lay them on icing or on biscuits just out of the oven.',
    ],
  ),
  'pensee/Pensées congelées sur plaque': RecipeText(
    // FR: Pensées congelées sur plaque
    name: 'Pansies frozen on a tray',
    // FR: Un quart d'heure, et des fleurs prêtes à poser sur une glace ou un sorbet en plein hiver.
    description: 'A quarter of an hour, and you have flowers ready to put on an ice cream or sorbet in midwinter.',
    // FR: 3 mois au congélateur
    keeps: '3 months in the freezer',
    ingredients: <String>[
      'about thirty pansy flowers', // FR: une trentaine de fleurs de pensée
      'baking paper', // FR: du papier cuisson
      'a rigid freezer box', // FR: une boîte rigide de congélation
    ],
    steps: <String>[
      // FR: Passe-les rapidement sous un filet d'eau seulement si elles sont sales, et sèche-les en les tamponnant.
      'Rinse them briefly under a trickle of water only if they are dirty, and dab them dry.',
      // FR: Coupe la tige au ras de la fleur.
      'Cut the stem flush with the flower.',
      // FR: Étale-les à plat sur une plaque garnie de papier, sans qu'elles se touchent, et congèle 1 heure.
      'Lay them flat on a tray lined with paper, not touching each other, and freeze for 1 hour.',
      // FR: Range-les dans la boîte rigide en couches séparées de papier : elles sont fragiles.
      'Store them in the rigid box in layers separated by paper: they are fragile.',
      // FR: Pose-les **encore gelées** sur un dessert glacé ou dans un verre. Décongelées, elles s'affaissent.
      'Place them **still frozen** on a frozen dessert or in a glass. Thawed, they collapse.',
    ],
  ),
  'pensee/Vinaigre violet aux pensées': RecipeText(
    // FR: Vinaigre violet aux pensées
    name: 'Purple pansy vinegar',
    // FR: Les pétales teintent le vinaigre d'un violet magnifique et lui donnent une note douce et florale.
    description: 'The petals tint the vinegar a beautiful purple and give it a soft, floral note.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 year in the cupboard, away from light',
    ingredients: <String>[
      '2 good handfuls of dark pansy flowers', // FR: 2 bonnes poignées de fleurs de pensée foncées
      '50 cl of white wine vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'a clean jar', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Cueille des pensées violettes ou bleu foncé, sans traitement : ce sont elles qui colorent le mieux.
      'Pick purple or deep blue pansies, untreated: they give the best colour.',
      // FR: Retire les tiges et mets les fleurs dans le bocal, sans tasser.
      'Remove the stems and put the flowers in the jar, without packing them down.',
      // FR: Couvre de vinaigre pur : les fleurs doivent être **entièrement immergées**.
      'Cover with undiluted vinegar: the flowers must be **fully submerged**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps. La couleur arrive en deux jours.
      'Close and leave to infuse for two weeks in the shade, shaking now and then. The colour appears within two days.',
      // FR: Filtre dans une bouteille propre et garde-la à l'abri de la lumière, qui délave la couleur.
      'Strain into a clean bottle and keep it away from light, which fades the colour.',
    ],
  ),
  'pensee/Fleurs cristallisées': RecipeText(
    // FR: Fleurs cristallisées
    name: 'Crystallised flowers',
    // FR: Passées au blanc d'œuf et au sucre, séchées une nuit.
    description: 'Brushed with egg white and sugar, dried overnight.',
  ),
  'pensee/Salade fleurie': RecipeText(
    // FR: Salade fleurie
    name: 'Flower salad',
    // FR: Posées entières au dernier moment sur les feuilles.
    description: 'Laid whole on the leaves at the last moment.',
  ),
  'pensee/Glaçons fleuris': RecipeText(
    // FR: Glaçons fleuris
    name: 'Flower ice cubes',
    // FR: Une fleur par alvéole, de l'eau, le congélateur.
    description: 'One flower per compartment, some water, the freezer.',
  ),

  // ─────────── persil (6 recettes) ───────────
  'persil/Persil haché en glaçons': RecipeText(
    // FR: Persil haché en glaçons
    name: 'Chopped parsley ice cubes',
    // FR: Le persil sèche mal mais se congèle très bien : haché une fois, il est prêt pour chaque plat de l'hiver.
    description: 'Parsley dries badly but freezes very well: chopped once, it is ready for every dish of the winter.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '4 big bunches of parsley', // FR: 4 gros bouquets de persil
      'water or a drizzle of olive oil', // FR: de l'eau ou un filet d'huile d'olive
      'ice cube trays', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Lave le persil dans une bassine d'eau froide, en le secouant pour faire tomber la terre.
      'Wash the parsley in a bowl of cold water, shaking it to knock off the soil.',
      // FR: Essore-le à la centrifugeuse et sèche-le dans un torchon : du persil mouillé haché fait de la bouillie.
      'Spin it dry in a salad spinner and dry it in a tea towel: wet parsley turns to mush when chopped.',
      // FR: Effeuille et hache finement au couteau. Garde les tiges pour les bouillons, elles se congèlent aussi.
      'Pick off the leaves and chop finely with a knife. Keep the stems for stock; they freeze too.',
      // FR: Tasse le persil dans les bacs et couvre d'un peu d'eau ou d'huile, juste de quoi lier.
      'Pack the parsley into the trays and cover with a little water or oil, just enough to bind it.',
      // FR: Congèle jusqu'à ce qu'ils soient durs, puis démoule en sac. Un cube dans la sauce **en fin de cuisson**.
      'Freeze until hard, then pop them out into a bag. Add one cube to the sauce **at the end of cooking**.',
    ],
  ),
  'persil/Sel au persil': RecipeText(
    // FR: Sel au persil
    name: 'Parsley salt',
    // FR: Mixé avec du gros sel puis séché, le persil devient un sel vert parfumé pour les pommes de terre et les grillades.
    description: 'Blended with coarse salt then dried, parsley becomes a fragrant green salt for potatoes and grills.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      '100 g of parsley leaves', // FR: 100 g de feuilles de persil
      '200 g of coarse grey salt', // FR: 200 g de gros sel gris
      '1 strip of lemon zest (optional)', // FR: 1 zeste de citron (facultatif)
      'small airtight jars', // FR: des petits bocaux hermétiques
    ],
    steps: <String>[
      // FR: Lave le persil et **sèche-le parfaitement**, feuille par feuille s'il le faut.
      'Wash the parsley and **dry it perfectly**, leaf by leaf if need be.',
      // FR: Mixe les feuilles avec le gros sel et le zeste par à-coups, jusqu'à un sable vert et humide.
      'Blitz the leaves with the coarse salt and the zest in short bursts, until you have a damp green sand.',
      // FR: Étale en couche fine sur une plaque couverte de papier et sèche au four à **60 °C**, porte entrouverte.
      'Spread in a thin layer on a tray lined with paper and dry in the oven at **60 °C**, door held ajar.',
      // FR: Émiette avec une fourchette toutes les 30 minutes pour casser les grumeaux.
      'Crumble with a fork every 30 minutes to break up the lumps.',
      // FR: Quand il est sec et sableux, laisse refroidir et mets en petits pots. Mixe-le encore un coup si tu le veux plus fin.
      'When it is dry and sandy, leave to cool and put into small jars. Blitz it once more if you want it finer.',
    ],
  ),
  'persil/Pesto de persil aux noix': RecipeText(
    // FR: Pesto de persil aux noix
    name: 'Parsley and walnut pesto',
    // FR: Plus vert et plus vif que le basilic, il se congèle en petits pots pour les pâtes, les soupes et les poissons.
    description: 'Greener and livelier than basil, it freezes in small pots for pasta, soups and fish.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '150 g of flat-leaf parsley leaves', // FR: 150 g de feuilles de persil plat
      '60 g of walnut halves', // FR: 60 g de cerneaux de noix
      '1 garlic clove', // FR: 1 gousse d'ail
      '15 cl of olive oil', // FR: 15 cl d'huile d'olive
      'the juice of half a lemon, salt', // FR: le jus d'un demi-citron, sel
    ],
    steps: <String>[
      // FR: Fais griller les noix à sec 3 minutes pour enlever l'amertume de la peau.
      'Dry-toast the walnuts for 3 minutes to take away the bitterness of the skin.',
      // FR: Lave le persil et **sèche-le bien** : l'eau fait tourner un pesto.
      'Wash the parsley and **dry it well**: water makes a pesto go off.',
      // FR: Mixe persil, noix, ail et sel par à-coups, en versant l'huile en filet. Ajoute le citron à la fin.
      'Blitz the parsley, walnuts, garlic and salt in short bursts, pouring in the oil in a thin stream. Add the lemon at the end.',
      // FR: Remplis de petits pots ou un bac à glaçons, et couvre d'un filet d'huile pour qu'il ne noircisse pas.
      'Fill small pots or an ice cube tray, and cover with a thin film of oil so it does not blacken.',
      // FR: Congèle aussitôt. Avec son ail cru, il ne se garde **qu'au congélateur** ; décongelé, mange-le dans les 2 jours.
      'Freeze straight away. With its raw garlic, it keeps **only in the freezer**; once thawed, eat it within 2 days.',
    ],
  ),
  'persil/Persillade': RecipeText(
    // FR: Persillade
    name: 'Persillade',
    // FR: Ail et persil hachés ensemble, jetés à la fin sur tout et n'importe quoi.
    description: 'Garlic and parsley chopped together, tossed at the end over just about anything.',
    ingredients: <String>[
      '1 bunch of flat-leaf parsley', // FR: 1 bouquet de persil plat
      '2 garlic cloves', // FR: 2 gousses d'ail
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Effeuille le persil, garde-le bien sec.
      'Pick off the parsley leaves and keep them very dry.',
      // FR: Hache l'ail et le persil **ensemble** : les deux parfums se mêlent au couteau.
      'Chop the garlic and parsley **together**: the two flavours blend under the knife.',
      // FR: Jette-la dans la poêle **hors du feu** ou juste avant de servir. Cuite, elle brunit et amère.
      'Add it to the pan **off the heat** or just before serving. Cooked, it browns and turns bitter.',
    ],
  ),
  'persil/Salsa verde': RecipeText(
    // FR: Salsa verde
    name: 'Salsa verde',
    // FR: Persil, câpres, anchois, citron : la sauce qui réveille un poisson.
    description: 'Parsley, capers, anchovies, lemon: the sauce that wakes up a fish.',
    ingredients: <String>[
      '1 big bunch of flat-leaf parsley', // FR: 1 gros bouquet de persil plat
      '2 tablespoons of capers', // FR: 2 cuillères à soupe de câpres
      '4 anchovy fillets', // FR: 4 filets d'anchois
      '1 lemon', // FR: 1 citron
      '10 cl of olive oil, 1 garlic clove', // FR: 10 cl d'huile d'olive, 1 gousse d'ail
    ],
    steps: <String>[
      // FR: Hache persil, câpres, anchois et ail au couteau, assez gros.
      'Chop the parsley, capers, anchovies and garlic with a knife, fairly coarsely.',
      // FR: Ajoute le zeste et le jus du citron.
      'Add the zest and juice of the lemon.',
      // FR: Détends à l'huile : elle doit napper, pas couler.
      'Loosen with the oil: it should coat the spoon, not run off it.',
      // FR: Goûte avant de saler — anchois et câpres salent beaucoup.
      'Taste before adding salt — anchovies and capers are very salty.',
    ],
  ),
  'persil/Poisson braisé au persil': RecipeText(
    // FR: Poisson braisé au persil
    name: 'Parsley braised fish',
    // FR: Un poisson entier farci d'herbes, braisé avec des tomates.
    description: 'A whole fish stuffed with herbs, braised with tomatoes.',
    ingredients: <String>[
      '1 whole fish of 1 kg', // FR: 1 poisson entier de 1 kg
      '1 bunch of parsley', // FR: 1 bouquet de persil
      '3 tomatoes, 1 onion', // FR: 3 tomates, 1 oignon
      '2 garlic cloves, 1 lemon', // FR: 2 gousses d'ail, 1 citron
      'oil, salt, pepper, chilli', // FR: huile, sel, poivre, piment
    ],
    steps: <String>[
      // FR: Hache persil, ail, sel, piment. Entaille le poisson et farcis les entailles.
      'Chop the parsley, garlic, salt and chilli. Score the fish and stuff the cuts.',
      // FR: Laisse-le prendre le goût 20 minutes au frais.
      'Leave it to take on the flavour for 20 minutes somewhere cool.',
      // FR: Saisis-le 3 minutes de chaque côté dans l'huile.
      'Sear it for 3 minutes on each side in oil.',
      // FR: Ajoute oignon et tomates en morceaux, un verre d'eau, couvre.
      'Add the onion and tomatoes in pieces, a glass of water, and cover.',
      // FR: Braise 15 minutes à feu moyen.
      'Braise for 15 minutes over a medium heat.',
      // FR: Citron pressé dessus au moment de servir.
      'Squeeze lemon over it when serving.',
    ],
  ),

  // ─────────── petit_pois (6 recettes) ───────────
  'petit_pois/Petits pois blanchis en sachets': RecipeText(
    // FR: Petits pois blanchis en sachets
    name: 'Blanched peas in bags',
    // FR: Deux minutes dans l'eau bouillante le jour de la cueillette, et ils restent sucrés jusqu'à Noël.
    description: 'Two minutes in boiling water on the day you pick them, and they stay sweet until Christmas.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of peas in the pod (about 800 g shelled)', // FR: 2 kg de petits pois en cosses (environ 800 g écossés)
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les pois **le jour même** de la cueillette : leur sucre se transforme en amidon en quelques heures.
      'Shell the peas **the same day** you pick them: their sugar turns to starch within a few hours.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante non salée, **2 minutes**.
      'Plunge them into a large pan of unsalted boiling water for **2 minutes**.',
      // FR: Verse-les aussitôt dans l'eau glacée, puis égoutte-les.
      'Tip them straight into the iced water, then drain.',
      // FR: Étale-les sur un torchon et tamponne-les pour les sécher.
      'Spread them on a tea towel and pat them dry.',
      // FR: Congèle-les étalés sur une plaque, puis verse en sacs : ils restent détachés et tu prends juste la dose.
      'Freeze them spread out on a tray, then tip into bags: they stay loose and you take just the amount you need.',
    ],
  ),
  'petit_pois/Purée de petits pois à la menthe': RecipeText(
    // FR: Purée de petits pois à la menthe
    name: 'Pea and mint purée',
    // FR: Pour les pois un peu trop gros et farineux : en purée congelée, ils font un accompagnement prêt en cinq minutes.
    description: 'For peas that are a little too big and floury: as a frozen purée, they make a side dish ready in five minutes.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of shelled peas', // FR: 1 kg de petits pois écossés
      '1 onion', // FR: 1 oignon
      '30 g of butter', // FR: 30 g de beurre
      '10 mint leaves', // FR: 10 feuilles de menthe
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé dans le beurre, sans coloration.
      'Soften the sliced onion in the butter, without letting it colour.',
      // FR: Ajoute les pois, couvre à peine d'eau, sale et laisse cuire jusqu'à ce qu'ils s'écrasent sous le doigt.
      'Add the peas, barely cover with water, add salt and cook until they crush under your finger.',
      // FR: Jette la menthe hors du feu, une minute, pas plus.
      'Add the mint off the heat, for one minute, no more.',
      // FR: Mixe avec un peu d'eau de cuisson, jusqu'à une purée lisse. Poivre et goûte.
      'Blend with a little cooking water to a smooth purée. Add pepper and taste.',
      // FR: Refroidis vite la purée dans un plat posé sur de l'eau glacée : le vert reste vif.
      'Cool the purée quickly in a dish set over iced water: the green stays bright.',
      // FR: Répartis en boîtes d'une portion, à 2 cm du bord, et congèle.
      'Divide into single-portion boxes, to 2 cm from the rim, and freeze.',
    ],
  ),
  'petit_pois/Pois secs de garde': RecipeText(
    // FR: Pois secs de garde
    name: 'Dried peas for storing',
    // FR: Laisse les dernières cosses sécher : les pois durs se gardent des années et finissent en soupe de pois cassés.
    description: 'Leave the last pods to dry: hard peas keep for years and end up as split pea soup.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 years in a dry place, away from light',
    ingredients: <String>[
      'the end-of-season pods, left on the plant', // FR: les cosses de fin de saison, laissées sur pied
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Laisse les dernières cosses sur les pieds jusqu'à ce qu'elles soient **beiges et parcheminées**.
      'Leave the last pods on the plants until they are **beige and papery**.',
      // FR: Cueille-les par temps sec et écosse-les. Jette les pois tachés ou percés.
      'Pick them in dry weather and shell them. Throw away any peas that are spotted or pierced.',
      // FR: Étale les pois sur un plateau à l'abri, à l'air, et laisse-les finir de sécher 2 semaines.
      'Spread the peas on a tray under cover, in the open air, and leave them to finish drying for 2 weeks.',
      // FR: Teste : un pois prêt ne marque plus sous l'ongle et casse net sous un coup de marteau.
      'Test: a ready pea no longer marks under your fingernail and breaks cleanly under a hammer blow.',
      // FR: Passe-les 48 heures au congélateur : ça tue les œufs de bruches qui pourraient éclore dans le bocal.
      'Put them in the freezer for 48 hours: it kills any pea weevil eggs that might hatch in the jar.',
      // FR: Mets en bocaux bien fermés. Avant de les manger, fais-les tremper une nuit puis cuire environ 1 heure.
      'Put into tightly closed jars. Before eating, soak them overnight, then cook for about 1 hour.',
    ],
  ),
  'petit_pois/Petits pois à la française': RecipeText(
    // FR: Petits pois à la française
    name: 'Peas à la française',
    // FR: Avec laitue, oignons nouveaux et beurre — la recette qui ne change pas.
    description: 'With lettuce, spring onions and butter — the recipe that never changes.',
    ingredients: <String>[
      '1 kg of shelled peas', // FR: 1 kg de petits pois écossés
      '1 lettuce heart', // FR: 1 coeur de laitue
      '8 spring onions', // FR: 8 oignons nouveaux
      '40 g of butter', // FR: 40 g de beurre
      '1 teaspoon of sugar, salt', // FR: 1 cuillère à café de sucre, sel
    ],
    steps: <String>[
      // FR: Écosse les pois : compte 1 kg en gousses pour 400 g.
      'Shell the peas: count 1 kg in the pod for 400 g.',
      // FR: Coupe la laitue en lanières, les oignons en deux.
      'Cut the lettuce into strips and the onions in half.',
      // FR: Dans la cocotte : pois, laitue, oignons, beurre, sucre, sel et 10 cl d'eau.
      'In the casserole: peas, lettuce, onions, butter, sugar, salt and 10 cl of water.',
      // FR: Couvre et laisse 20 minutes à feu doux, sans remuer.
      'Cover and leave for 20 minutes over a low heat, without stirring.',
      // FR: Il ne doit presque plus rester d'eau : juste un jus beurré.
      'There should be almost no water left: just a buttery juice.',
    ],
  ),
  'petit_pois/Velouté de petits pois à la menthe': RecipeText(
    // FR: Velouté de petits pois à la menthe
    name: 'Pea and mint velouté',
    // FR: Un vert éclatant, à condition de ne pas trop cuire.
    description: 'A dazzling green, as long as you do not overcook it.',
    ingredients: <String>[
      '800 g of peas', // FR: 800 g de petits pois
      '1 onion', // FR: 1 oignon
      '70 cl of stock', // FR: 70 cl de bouillon
      'about ten mint leaves', // FR: une dizaine de feuilles de menthe
      '10 cl of cream, salt, pepper', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé sans le colorer.
      'Soften the sliced onion without letting it colour.',
      // FR: Ajoute les pois et le bouillon chaud.
      'Add the peas and the hot stock.',
      // FR: 8 minutes seulement : au-delà, le vert tourne au kaki.
      '8 minutes only: any longer and the green turns khaki.',
      // FR: Mixe avec la menthe, hors du feu.
      'Blend with the mint, off the heat.',
      // FR: Crème, sel, poivre. Bon chaud ou glacé.
      'Cream, salt, pepper. Good hot or chilled.',
    ],
  ),
  'petit_pois/Petits pois carottes': RecipeText(
    // FR: Petits pois carottes
    name: 'Peas and carrots',
    // FR: Le duo de l'enfance, en frais ça n'a rien à voir avec la conserve.
    description: 'The childhood duo; fresh, it is nothing like the tinned version.',
    ingredients: <String>[
      '600 g of peas', // FR: 600 g de petits pois
      '4 carrots', // FR: 4 carottes
      '1 onion', // FR: 1 oignon
      '30 g of butter', // FR: 30 g de beurre
      'salt, pepper, parsley', // FR: sel, poivre, persil
    ],
    steps: <String>[
      // FR: Coupe les carottes en rondelles fines.
      'Cut the carrots into thin rounds.',
      // FR: Fais-les suer au beurre avec l'oignon, 10 minutes.
      'Sweat them in the butter with the onion for 10 minutes.',
      // FR: Ajoute les pois et un fond d'eau, sale.
      'Add the peas and a splash of water, and season with salt.',
      // FR: Couvre et cuis 15 minutes.
      'Cover and cook for 15 minutes.',
      // FR: Persil, poivre, une noisette de beurre à la fin.
      'Parsley, pepper, and a knob of butter at the end.',
    ],
  ),

  // ─────────── piment (6 recettes) ───────────
  'piment/Piments séchés en guirlande': RecipeText(
    // FR: Piments séchés en guirlande
    name: 'Dried chilli garland',
    // FR: Enfilés et suspendus, les piments sèchent tout seuls et décorent la cuisine jusqu'à la récolte suivante.
    description: 'Threaded and hung up, chillies dry all by themselves and decorate the kitchen until the next harvest.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      'fully ripe, thin-fleshed chillies', // FR: des piments bien mûrs, à chair fine
      'a large needle and strong thread', // FR: une grosse aiguille et du fil solide
      'gloves', // FR: des gants
    ],
    steps: <String>[
      // FR: Essuie les piments sans les laver : mouillés, ils moisissent au lieu de sécher.
      'Wipe the chillies without washing them: wet, they go mouldy instead of drying.',
      // FR: Mets des gants. Écarte ceux qui ont une tache molle, ils pourriraient la guirlande.
      'Put on gloves. Set aside any with a soft spot; they would rot the whole garland.',
      // FR: Enfile-les par le pédoncule, avec l'aiguille, en les décalant pour qu'ils ne se touchent pas.
      'Thread them through the stalk with the needle, staggering them so they do not touch.',
      // FR: Suspends au sec, au chaud et aéré, 3 à 4 semaines. Les piments charnus sèchent mieux au four à 50 °C.
      'Hang them somewhere dry, warm and airy for 3 to 4 weeks. Fleshy chillies dry better in the oven at 50 °C.',
      // FR: Ils sont secs quand ils sont cassants et sonnent creux en les secouant.
      'They are dry when they are brittle and rattle hollow when shaken.',
      // FR: Laisse-les suspendus ou mets-les en bocal. Émiette-les ou mouds-les au moment de cuisiner.
      'Leave them hanging or put them in a jar. Crumble or grind them as you cook.',
    ],
  ),
  'piment/Piments fermentés en saumure': RecipeText(
    // FR: Piments fermentés en saumure
    name: 'Brine-fermented chillies',
    // FR: La fermentation arrondit le feu et ajoute un goût acidulé : la base de toutes tes sauces piquantes.
    description: 'Fermentation softens the heat and adds a tangy flavour: the base of all your hot sauces.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '500 g of chillies', // FR: 500 g de piments
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      'a 1 litre jar with a weight', // FR: un bocal de 1 litre avec un poids
    ],
    steps: <String>[
      // FR: Mets des gants. Retire les pédoncules et coupe les piments en deux dans la longueur.
      'Put on gloves. Remove the stalks and cut the chillies in half lengthways.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %.
      'Dissolve **30 g of salt in 1 litre of water**: that is the 3 % brine.',
      // FR: Tasse les piments et l'ail pelé dans un bocal ébouillanté, jusqu'à 3 cm du bord.
      'Pack the chillies and the peeled garlic into a scalded jar, up to 3 cm from the rim.',
      // FR: Verse la saumure et pose un poids pour **garder tous les piments sous le liquide**. Ce qui dépasse moisit.
      'Pour in the brine and add a weight to **keep every chilli under the liquid**. Anything poking out goes mouldy.',
      // FR: Ferme sans serrer et laisse à 18–22 °C, à l'ombre, 2 semaines. Ouvre le couvercle chaque jour pour laisser sortir le gaz.
      'Close the lid without tightening it and leave at 18–22 °C, in the shade, for 2 weeks. Open the lid every day to let the gas out.',
      // FR: Quand la saumure est trouble et que ça sent acidulé, c'est prêt. Une mousse blanche se retire, une moisissure colorée et duveteuse veut dire qu'on jette tout.
      'When the brine is cloudy and smells tangy, it is ready. White foam can be skimmed off; a coloured, fuzzy mould means throwing everything away.',
      // FR: Ferme et range au réfrigérateur. Mixe avec un peu de saumure pour en faire une pâte.
      'Close and keep in the fridge. Blend with a little brine to make a paste.',
    ],
  ),
  'piment/Piments entiers congelés': RecipeText(
    // FR: Piments entiers congelés
    name: 'Whole frozen chillies',
    // FR: Dix minutes, et tu as des piments frais toute l'année, à couper encore gelés.
    description: 'Ten minutes, and you have fresh chillies all year, to slice while still frozen.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      'fresh, firm chillies', // FR: des piments frais et fermes
      'freezer bags', // FR: des sacs de congélation
      'gloves', // FR: des gants
    ],
    steps: <String>[
      // FR: Lave les piments et **sèche-les parfaitement**.
      'Wash the chillies and **dry them perfectly**.',
      // FR: Laisse-les entiers avec leur pédoncule, ou coupe-les en rondelles avec des gants.
      'Leave them whole with their stalks, or cut them into rounds, wearing gloves.',
      // FR: Mets-les en sac en chassant l'air, et congèle.
      'Put them in a bag, pressing out the air, and freeze.',
      // FR: Coupe-les encore gelés : ils se tranchent facilement et brûlent moins les doigts. Mous à la décongélation, ils vont dans les plats cuits.
      'Slice them still frozen: they cut easily and burn your fingers less. Soft once thawed, they go into cooked dishes.',
    ],
  ),
  'piment/Sauce piquante maison': RecipeText(
    // FR: Sauce piquante maison
    name: 'Homemade hot sauce',
    // FR: Piments mixés avec ail, sel et vinaigre, fermentés une semaine.
    description: 'Chillies blended with garlic, salt and vinegar, fermented for a week.',
  ),
  'piment/Huile pimentée': RecipeText(
    // FR: Huile pimentée
    name: 'Chilli oil',
    // FR: Piments séchés dans l'huile chaude, jamais bouillante.
    description: 'Dried chillies in hot oil, never boiling.',
  ),
  'piment/Sauce pili-pili': RecipeText(
    // FR: Sauce pili-pili
    name: 'Pili-pili sauce',
    // FR: La petite sauce piquante maison qui accompagne absolument tout, avec modération !
    description: 'The little homemade hot sauce that goes with absolutely everything, in moderation!',
  ),

  // ─────────── pleurote (6 recettes) ───────────
  'pleurote/Pleurotes séchées': RecipeText(
    // FR: Pleurotes séchées
    name: 'Dried oyster mushrooms',
    // FR: Fines et peu charnues, elles sèchent vite et gagnent un goût de sous-bois très concentré.
    description: 'Thin and not very fleshy, they dry quickly and gain a very concentrated woodland flavour.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 year in a dry place, in an airtight jar',
    ingredients: <String>[
      '1 kg of oyster mushrooms', // FR: 1 kg de pleurotes
      'racks or trays', // FR: des grilles ou plaques
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Coupe la base dure de la grappe et sépare les pleurotes. Essuie-les sans les mouiller.
      'Cut off the hard base of the cluster and separate the mushrooms. Wipe them without wetting them.',
      // FR: Déchire les plus grandes en lanières dans le sens des lamelles.
      'Tear the biggest ones into strips, following the gills.',
      // FR: Étale-les en une couche sur des grilles et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Spread them in a single layer on racks and dry at 50 °C, door held ajar, or in a dehydrator.',
      // FR: Elles sont prêtes quand elles se cassent net entre les doigts.
      'They are ready when they snap cleanly between your fingers.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Réhydrate-les 15 minutes dans l'eau tiède avant de les poêler.
      'Leave to cool and put into airtight jars. Rehydrate them for 15 minutes in warm water before frying.',
    ],
  ),
  'pleurote/Pleurotes revenues au congélateur': RecipeText(
    // FR: Pleurotes revenues au congélateur
    name: 'Oyster mushrooms sautéed for the freezer',
    // FR: Saisies à sec puis au beurre, elles gardent leur texture moelleuse et filent tout droit dans une sauce ou une omelette.
    description: 'Seared dry then in butter, they keep their tender texture and go straight into a sauce or an omelette.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of oyster mushrooms', // FR: 1,5 kg de pleurotes
      '30 g of butter', // FR: 30 g de beurre
      '1 shallot', // FR: 1 échalote
      'salt', // FR: sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la base de la grappe, sépare et déchire les pleurotes en lanières. **Pas d'eau** : essuie-les simplement.
      'Cut off the base of the cluster, separate the mushrooms and tear them into strips. **No water**: just wipe them.',
      // FR: Fais-les d'abord sauter **à sec** dans une grande poêle chaude, jusqu'à ce que leur eau soit évaporée.
      'First sauté them **dry** in a large hot pan, until their water has evaporated.',
      // FR: Ajoute le beurre et l'échalote émincée, et fais dorer 4 minutes.
      'Add the butter and the sliced shallot, and brown for 4 minutes.',
      // FR: Sale en fin de cuisson.
      'Add salt at the end of cooking.',
      // FR: Étale-les sur une plaque pour qu'elles refroidissent vite.
      'Spread them on a tray so they cool quickly.',
      // FR: Mets en sacs d'une portion, à plat, et date.
      'Put into single-portion bags, flat, and date them.',
    ],
  ),
  'pleurote/Pickles de pleurotes à l\'ail': RecipeText(
    // FR: Pickles de pleurotes à l'ail
    name: 'Garlic oyster mushroom pickles',
    // FR: Blanchies au vinaigre et à l'ail, elles se servent froides, comme des champignons à la grecque.
    description: 'Blanched in vinegar and garlic, they are served cold, like mushrooms à la grecque.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '800 g of oyster mushrooms', // FR: 800 g de pleurotes
      '40 cl of white vinegar at 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl of water', // FR: 40 cl d'eau
      '15 g of salt, 10 g of sugar', // FR: 15 g de sel, 10 g de sucre
      '3 garlic cloves, 1 teaspoon of coriander seeds', // FR: 3 gousses d'ail, 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Sépare les pleurotes et déchire les grandes en lanières. Essuie-les sans les laver.
      'Separate the mushrooms and tear the big ones into strips. Wipe them without washing.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre avec l'ail en lamelles et la coriandre.
      'Bring the vinegar, water, salt and sugar to the boil with the sliced garlic and the coriander.',
      // FR: Plonge les pleurotes dans le liquide et laisse frémir **5 minutes**.
      'Drop the mushrooms into the liquid and simmer for **5 minutes**.',
      // FR: Répartis-les dans deux bocaux ébouillantés avec l'ail et les graines.
      'Divide them between two scalded jars with the garlic and the seeds.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Pour in the boiling liquid to **cover completely**, close and leave to cool.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'ouvrir.
      'Keep in the fridge and wait 2 days before opening.',
    ],
  ),
  'pleurote/Pleurotes poêlées à l\'ail': RecipeText(
    // FR: Pleurotes poêlées à l'ail
    name: 'Garlic fried oyster mushrooms',
    // FR: Déchirées à la main, saisies sans les tasser.
    description: 'Torn by hand, seared without crowding the pan.',
  ),
  'pleurote/Pleurotes panées façon escalope': RecipeText(
    // FR: Pleurotes panées façon escalope
    name: 'Breaded oyster mushrooms, escalope style',
    // FR: Leur texture fibreuse s'y prête remarquablement.
    description: 'Their fibrous texture suits it remarkably well.',
  ),
  'pleurote/Fricassée de pleurotes à la crème': RecipeText(
    // FR: Fricassée de pleurotes à la crème
    name: 'Creamy oyster mushroom fricassée',
    // FR: Avec de l'estragon et un trait de vin blanc.
    description: 'With tarragon and a splash of white wine.',
  ),

  // ─────────── poireau (6 recettes) ───────────
  'poireau/Poireaux émincés congelés crus': RecipeText(
    // FR: Poireaux émincés congelés crus
    name: 'Sliced leeks frozen raw',
    // FR: Le poireau est un des rares légumes qui se congèlent crus : un quart d'heure et tes soupes d'hiver sont lancées.
    description: 'Leek is one of the few vegetables you can freeze raw: a quarter of an hour and your winter soups are under way.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 kg of leeks', // FR: 2 kg de poireaux
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la racine et le vert trop dur, puis fends chaque poireau en deux dans la longueur.
      'Cut off the root and the toughest green, then split each leek in half lengthways.',
      // FR: Rince-les sous l'eau en écartant les feuilles : la terre se cache **entre les couches**, tout près du blanc.
      'Rinse them under water, spreading the leaves: the soil hides **between the layers**, close to the white.',
      // FR: Émince-les en rondelles d'un demi-centimètre, blanc et vert tendre ensemble.
      'Slice them into rounds half a centimetre thick, white and tender green together.',
      // FR: Égoutte-les et sèche-les bien dans un torchon. L'eau qui reste fait des blocs de glace.
      'Drain them and dry well in a tea towel. Any water left turns into blocks of ice.',
      // FR: Mets-les en sacs à plat, chasse l'air et note la date. Tu les jetteras **sans décongeler** dans la poêle ou la soupe.
      'Put them flat in bags, press out the air and write the date. Toss them **without thawing** into the pan or the soup.',
    ],
  ),
  'poireau/Tronçons de poireaux blanchis': RecipeText(
    // FR: Tronçons de poireaux blanchis
    name: 'Blanched leek chunks',
    // FR: Blanchis deux minutes, les blancs gardent leur tenue pour un gratin ou des poireaux à la crème en plein hiver.
    description: 'Blanched for two minutes, the whites hold their shape for a gratin or creamed leeks in midwinter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of leek whites', // FR: 2 kg de blancs de poireaux
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Garde le blanc et le vert clair, coupe-les en tronçons de 5 cm.
      'Keep the white and the pale green, and cut them into 5 cm chunks.',
      // FR: Rince chaque tronçon en écartant un peu les feuilles pour chasser la terre.
      'Rinse each chunk, spreading the leaves a little to flush out the soil.',
      // FR: Plonge-les dans une grande eau salée à gros bouillons, **2 minutes** chrono.
      'Plunge them into a large pan of salted water at a rolling boil for exactly **2 minutes**.',
      // FR: Transfère-les aussitôt dans l'eau glacée pour stopper la cuisson et garder le vert.
      'Move them straight into the iced water to stop the cooking and keep the green.',
      // FR: Égoutte-les debout dans une passoire, puis presse-les doucement dans un torchon.
      'Drain them standing up in a colander, then press gently in a tea towel.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent, congèle 2 heures, puis passe-les en sac.
      'Spread them on a tray so they do not touch, freeze for 2 hours, then put them into a bag.',
    ],
  ),
  'poireau/Rondelles de poireaux séchées': RecipeText(
    // FR: Rondelles de poireaux séchées
    name: 'Dried leek rounds',
    // FR: Séchées au four doux, elles tiennent dans un bocal et parfument une soupe en trois minutes de cuisson.
    description: 'Dried in a low oven, they fit in a jar and flavour a soup after three minutes of cooking.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      '1.5 kg of leeks', // FR: 1,5 kg de poireaux
      'baking paper', // FR: du papier cuisson
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Fends les poireaux en deux et rince-les à fond entre les feuilles.
      'Split the leeks in half and rinse thoroughly between the leaves.',
      // FR: Émince-les finement, 3 mm environ : plus c'est fin, plus ça sèche vite et régulièrement.
      'Slice them finely, about 3 mm: the thinner they are, the faster and more evenly they dry.',
      // FR: Sèche les rondelles dans un torchon, puis étale-les en couche fine sur les plaques.
      'Dry the rounds in a tea towel, then spread them in a thin layer on the trays.',
      // FR: Enfourne à **60 °C**, porte entrouverte avec une cuillère en bois pour que l'humidité s'échappe.
      'Put them in the oven at **60 °C**, door held ajar with a wooden spoon so the moisture can escape.',
      // FR: Remue toutes les heures. C'est prêt quand les rondelles **cassent net** et ne plient plus.
      'Stir every hour. They are ready when the rounds **snap cleanly** and no longer bend.',
      // FR: Laisse refroidir complètement avant de mettre en bocal : tiède, ça condense et ça moisit.
      'Leave to cool completely before putting them in jars: warm, they condense and go mouldy.',
    ],
  ),
  'poireau/Poireaux vinaigrette': RecipeText(
    // FR: Poireaux vinaigrette
    name: 'Leeks vinaigrette',
    // FR: Tièdes, bien égouttés, avec une vinaigrette à l'échalote.
    description: 'Lukewarm, well drained, with a shallot vinaigrette.',
    ingredients: <String>[
      '8 medium leeks', // FR: 8 poireaux moyens
      '1 shallot', // FR: 1 échalote
      '1 teaspoon of mustard', // FR: 1 cuillère à café de moutarde
      '1 tablespoon of vinegar', // FR: 1 cuillère à soupe de vinaigre
      '3 tablespoons of oil, salt, pepper', // FR: 3 cuillères à soupe d'huile, sel, poivre
    ],
    steps: <String>[
      // FR: Fends le blanc en deux dans la longueur et rince : la terre se cache entre les feuilles.
      'Split the white in half lengthways and rinse: the soil hides between the leaves.',
      // FR: Cuis 15 minutes à l'eau bouillante salée, jusqu'à ce qu'un couteau traverse sans effort.
      'Cook for 15 minutes in boiling salted water, until a knife goes through without effort.',
      // FR: Égoutte-les **debout** dans une passoire, 10 minutes : c'est ce qui évite l'assiette noyée.
      'Drain them **standing up** in a colander for 10 minutes: that is what stops the plate from flooding.',
      // FR: Vinaigrette : échalote hachée, moutarde, vinaigre, puis l'huile en filet.
      'Vinaigrette: chopped shallot, mustard, vinegar, then the oil in a thin stream.',
      // FR: Nappe les poireaux encore tièdes.
      'Spoon it over the leeks while they are still lukewarm.',
    ],
  ),
  'poireau/Flamiche aux poireaux': RecipeText(
    // FR: Flamiche aux poireaux
    name: 'Leek flamiche',
    // FR: La tarte du Nord : des poireaux fondus à la crème, sous une pâte.
    description: 'The tart from the north of France: leeks melted in cream, under a pastry lid.',
    ingredients: <String>[
      '1 shortcrust pastry', // FR: 1 pâte brisée
      '1 kg of leeks', // FR: 1 kg de poireaux
      '20 cl of cream', // FR: 20 cl de crème
      '2 eggs', // FR: 2 oeufs
      '40 g of butter, salt, pepper, nutmeg', // FR: 40 g de beurre, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Émince les blancs de poireaux en fines rondelles.
      'Slice the leek whites into thin rounds.',
      // FR: Fais-les fondre au beurre à couvert, 25 minutes, sans les colorer.
      'Melt them in the butter, covered, for 25 minutes, without letting them colour.',
      // FR: Laisse-les tiédir et égoutte l'eau rendue, sinon la tarte sera molle.
      'Leave them to cool a little and drain off the liquid they release, or the tart will be soggy.',
      // FR: Mélange crème, oeufs, sel, poivre, muscade.
      'Mix the cream, eggs, salt, pepper and nutmeg.',
      // FR: Garnis la pâte des poireaux, verse l'appareil.
      'Fill the pastry with the leeks and pour in the cream mixture.',
      // FR: Four à 190 °C, 35 minutes.
      'Oven at 190 °C, 35 minutes.',
    ],
  ),
  'poireau/Fondue de poireaux': RecipeText(
    // FR: Fondue de poireaux
    name: 'Leek fondue',
    // FR: La base qui accompagne un poisson, garnit une quiche ou se mange seule.
    description: 'The base that goes with a fish, fills a quiche or is eaten on its own.',
    ingredients: <String>[
      '6 leeks', // FR: 6 poireaux
      '30 g of butter', // FR: 30 g de beurre
      '10 cl of cream', // FR: 10 cl de crème
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Émince les blancs finement, rince, égoutte.
      'Slice the whites finely, rinse, drain.',
      // FR: Beurre dans la sauteuse, les poireaux, une pincée de sel, couvercle.
      'Butter in the sauté pan, then the leeks, a pinch of salt, lid on.',
      // FR: Feu très doux 25 minutes. Ils doivent fondre, jamais roussir.
      'Very low heat for 25 minutes. They should melt, never brown.',
      // FR: Crème hors du feu, poivre, et c'est prêt.
      'Cream off the heat, pepper, and it is ready.',
    ],
  ),

  // ─────────── poirier (6 recettes) ───────────
  'poirier/Demi-poires au sirop léger': RecipeText(
    // FR: Demi-poires au sirop léger
    name: 'Pear halves in light syrup',
    // FR: Les poires mûrissent toutes la même semaine : en bocaux, elles attendent sagement jusqu'en hiver.
    description: 'The pears all ripen in the same week: in jars, they wait patiently until winter.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '3 kg of firm, barely ripe pears', // FR: 3 kg de poires fermes, à peine mûres
      '1.5 litres of water', // FR: 1,5 litre d'eau
      '400 g of sugar', // FR: 400 g de sucre
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '1 vanilla pod (optional)', // FR: 1 gousse de vanille (facultatif)
      '4 jars of one litre with new seals', // FR: 4 bocaux d'un litre avec joints neufs
    ],
    steps: <String>[
      // FR: Porte l'eau, le sucre et la vanille fendue à ébullition 2 minutes, puis ajoute le jus d'un citron : il garde les poires claires et assure l'acidité.
      'Bring the water, sugar and split vanilla pod to the boil for 2 minutes, then add the juice of one lemon: it keeps the pears pale and provides the acidity.',
      // FR: Épluche les poires, coupe-les en deux, retire le cœur à la cuillère et plonge-les dans de l'eau additionnée du second citron.
      'Peel the pears, cut them in half, scoop out the core with a spoon and drop them into water with the second lemon added.',
      // FR: Range les demi-poires serrées dans les bocaux et couvre de sirop chaud **jusqu'à 2 cm du bord**. Ferme avec des joints neufs.
      'Pack the pear halves tightly into the jars and cover with hot syrup **to 2 cm from the rim**. Close with new seals.',
      // FR: Stérilise les bocaux **couverts d'eau**, 30 minutes à partir de l'ébullition pour des bocaux d'un litre.
      'Sterilise the jars **completely covered in water**, for 30 minutes from the moment it boils, for jars of one litre.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange dans la semaine.
      'Let them cool in the water, then check the vacuum. A jar that has not sealed goes in the fridge and gets eaten within the week.',
    ],
  ),
  'poirier/Lamelles de poires séchées': RecipeText(
    // FR: Lamelles de poires séchées
    name: 'Dried pear slices',
    // FR: Séchée, la poire devient un bonbon : douce, souple, parfaite dans un muesli ou à côté d'un fromage.
    description: 'Dried, pear becomes a sweet: soft, supple, perfect in muesli or next to a cheese.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '2 kg of ripe but firm pears', // FR: 2 kg de poires mûres mais fermes
      '1 litre of cold water', // FR: 1 litre d'eau froide
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Épluche les poires, retire le cœur et coupe-les en lamelles de **6 mm** dans la hauteur.
      'Peel the pears, remove the core and cut into **6 mm** slices from top to bottom.',
      // FR: Trempe les lamelles quelques minutes dans l'eau citronnée pour qu'elles ne noircissent pas.
      'Soak the slices for a few minutes in the lemon water so they do not turn black.',
      // FR: Égoutte et éponge-les sur un torchon : la poire est juteuse, plus elle part sèche, plus vite elle sèche.
      'Drain and pat them dry on a tea towel: pears are juicy, and the drier they go in, the faster they dry.',
      // FR: Étale-les sur des grilles et sèche au four à **65 °C**, porte entrouverte, en les retournant à mi-temps.
      'Spread them on racks and dry in the oven at **65 °C**, door held ajar, turning them halfway.',
      // FR: Teste une lamelle refroidie : elle doit plier sans casser et sans laisser de jus.
      'Test a cooled slice: it should bend without breaking and release no juice.',
      // FR: Mets en bocal et surveille la buée la première semaine. S'il y en a, remets au four une heure.
      'Put into jars and watch for condensation during the first week. If you see any, back in the oven for an hour.',
    ],
  ),
  'poirier/Quartiers de poires au congélateur': RecipeText(
    // FR: Quartiers de poires au congélateur
    name: 'Pear wedges for the freezer',
    // FR: Un quart d'heure pour sauver les poires qui mûrissent trop vite : elles finiront en compote, en crumble ou en smoothie.
    description: 'A quarter of an hour to save the pears that ripen too fast: they will end up in a compote, a crumble or a smoothie.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 kg of ripe pears', // FR: 2 kg de poires mûres
      'the juice of a lemon', // FR: le jus d'un citron
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les poires, retire le cœur et coupe-les en quartiers.
      'Peel the pears, remove the core and cut into wedges.',
      // FR: Arrose-les aussitôt de jus de citron et mélange : la poire noircit en quelques minutes.
      'Sprinkle with lemon juice straight away and toss: pears turn black within minutes.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Spread on a tray so they do not touch and freeze for 2 hours.',
      // FR: Verse en sac une fois dures. Décongelées, elles sont molles : **pour cuire ou mixer**, pas pour croquer.
      'Tip into a bag once hard. Thawed, they are soft: **for cooking or blending**, not for crunching.',
    ],
  ),
  'poirier/Poires pochées au vin': RecipeText(
    // FR: Poires pochées au vin
    name: 'Pears poached in wine',
    // FR: Vin rouge, cannelle, badiane : elles prennent une robe profonde.
    description: 'Red wine, cinnamon, star anise: they take on a deep colour.',
  ),
  'poirier/Tarte Bourdaloue': RecipeText(
    // FR: Tarte Bourdaloue
    name: 'Pear and almond tart Bourdaloue',
    // FR: Poires et crème d'amandes, le mariage classique.
    description: 'Pears and almond cream, the classic pairing.',
  ),
  'poirier/Poires au chocolat': RecipeText(
    // FR: Poires au chocolat
    name: 'Chocolate pears',
    // FR: Pochées, nappées chaud, avec une glace vanille.
    description: 'Poached, coated in hot chocolate, with vanilla ice cream.',
  ),

  // ─────────── pois_chiche (6 recettes) ───────────
  'pois_chiche/Pois chiches secs à la remise': RecipeText(
    // FR: Pois chiches secs à la remise
    name: 'Dried chickpeas for the store cupboard',
    // FR: Bien secs, ils se gardent des années : c'est comme ça qu'on stocke toute une récolte de pois chiches.
    description: 'Fully dry, they keep for years: that is how you store a whole chickpea harvest.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 years in a dry place, away from light',
    ingredients: <String>[
      'well-yellowed chickpea plants', // FR: les plants de pois chiches bien jaunis
      'crates or an old sheet', // FR: des cagettes ou un vieux drap
      'a cloth bag', // FR: un sac de toile
      'very dry glass jars', // FR: des bocaux en verre bien secs
    ],
    steps: <String>[
      // FR: Arrache les plants quand ils sont jaunes et que les gousses **sonnent** quand tu les secoues.
      'Pull up the plants when they are yellow and the pods **rattle** when you shake them.',
      // FR: Étale-les en couche fine dans un endroit sec et aéré, à l'abri de la pluie, pendant 2 semaines.
      'Spread them in a thin layer somewhere dry and airy, sheltered from rain, for 2 weeks.',
      // FR: Écosse à la main, ou tape les plants dans un sac de toile, puis vanne les débris devant un ventilateur.
      'Shell by hand, or beat the plants in a cloth bag, then winnow out the debris in front of a fan.',
      // FR: Croque un grain : il doit être **dur comme un caillou**, impossible à marquer à l'ongle. Sinon, laisse sécher quelques jours de plus.
      'Bite one: it must be **hard as a stone**, impossible to mark with a fingernail. If not, let them dry a few more days.',
      // FR: Passe les grains 48 heures au congélateur : ça tue les œufs de bruche cachés à l'intérieur.
      'Put the seeds in the freezer for 48 hours: it kills any bruchid beetle eggs hidden inside.',
      // FR: Range-les en bocaux fermés, au sec. Ils se mangent toujours **trempés puis bien cuits**, jamais crus.
      'Store them in closed jars, somewhere dry. They are always eaten **soaked then thoroughly cooked**, never raw.',
    ],
  ),
  'pois_chiche/Pois chiches cuits en portions': RecipeText(
    // FR: Pois chiches cuits en portions
    name: 'Cooked chickpeas in portions',
    // FR: Un seul trempage pour un mois de repas : des sachets prêts à remplacer les boîtes de conserve.
    description: 'One soaking for a month of meals: bags ready to replace tins.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of dried chickpeas', // FR: 1 kg de pois chiches secs
      '1 teaspoon of bicarbonate of soda', // FR: 1 cuillère à café de bicarbonate
      '1 tablespoon of salt', // FR: 1 cuillère à soupe de sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Trie les pois chiches pour retirer cailloux et grains abîmés, puis rince-les.
      'Sort the chickpeas to remove stones and damaged ones, then rinse.',
      // FR: Fais-les tremper **12 heures** dans trois fois leur volume d'eau froide avec le bicarbonate : ils doublent de volume.
      'Soak them for **12 hours** in three times their volume of cold water with the bicarbonate: they double in size.',
      // FR: Jette l'eau de trempage, couvre d'eau neuve et cuis à petit frémissement, sans saler au début.
      'Throw away the soaking water, cover with fresh water and cook at a gentle simmer, without salt at first.',
      // FR: Sale en fin de cuisson et vérifie : un pois chiche cuit s'écrase **sans effort** entre deux doigts. Pas cuit, pas mangé.
      'Add salt at the end and check: a cooked chickpea crushes **effortlessly** between two fingers. If it is not cooked, do not eat it.',
      // FR: Égoutte-les et étale-les sur un plateau pour qu'ils refroidissent vite.
      'Drain them and spread on a tray so they cool quickly.',
      // FR: Répartis en sachets de 250 g, l'équivalent d'une boîte, aplatis et chasse l'air. Ils vont directement dans le plat, sans décongeler.
      'Divide into 250 g bags, the equivalent of a tin, flatten and press out the air. They go straight into the dish, without thawing.',
    ],
  ),
  'pois_chiche/Pois chiches verts blanchis': RecipeText(
    // FR: Pois chiches verts blanchis
    name: 'Blanched green chickpeas',
    // FR: Cueillis encore verts, ils ont un goût de petit pois sucré : deux minutes d'eau bouillante et ils t'attendent au congélateur.
    description: 'Picked while still green, they taste like sweet peas: two minutes in boiling water and they wait for you in the freezer.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '500 g of green chickpea pods', // FR: 500 g de gousses de pois chiches verts
      'coarse salt', // FR: gros sel
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les gousses bien pleines et encore vertes : chacune donne un ou deux grains.
      'Shell the plump, still-green pods: each gives one or two seeds.',
      // FR: Rince les grains dans une passoire sous l'eau froide.
      'Rinse the seeds in a colander under cold water.',
      // FR: Blanchis-les **2 minutes** dans une grande eau bouillante salée.
      'Blanch them for **2 minutes** in a large pan of boiling salted water.',
      // FR: Plonge-les aussitôt dans l'eau glacée : c'est ce qui garde leur vert tendre.
      'Plunge them straight into the iced water: that is what keeps their tender green.',
      // FR: Égoutte-les et sèche-les sur un torchon, chaque goutte restée devient du givre.
      'Drain them and dry on a tea towel; every drop left behind turns to frost.',
      // FR: Mets-les en sachets à plat. Le jour venu, cuis-les encore **10 minutes** avant de les manger, comme des petits pois.
      'Put them flat in bags. When the day comes, cook them for another **10 minutes** before eating, like peas.',
    ],
  ),
  'pois_chiche/Houmous': RecipeText(
    // FR: Houmous
    name: 'Hummus',
    // FR: Tahini, citron, ail, et un filet d'huile par-dessus.
    description: 'Tahini, lemon, garlic, and a drizzle of oil on top.',
  ),
  'pois_chiche/Falafels': RecipeText(
    // FR: Falafels
    name: 'Falafel',
    // FR: Crus et trempés, jamais cuits : c'est le secret.
    description: 'Raw and soaked, never cooked: that is the secret.',
  ),
  'pois_chiche/Pois chiches rôtis épicés': RecipeText(
    // FR: Pois chiches rôtis épicés
    name: 'Spiced roasted chickpeas',
    // FR: À grignoter, croquants, au paprika fumé.
    description: 'For snacking, crunchy, with smoked paprika.',
  ),

  // ─────────── pois_mange_tout (6 recettes) ───────────
  'pois_mange_tout/Mange-tout blanchis congelés': RecipeText(
    // FR: Mange-tout blanchis congelés
    name: 'Blanched frozen mangetout',
    // FR: Deux minutes de blanchiment et ils filent au congélateur, prêts pour le wok sans passer par la planche.
    description: 'Two minutes of blanching and into the freezer they go, ready for the wok with no chopping board needed.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1.5 kg of mangetout', // FR: 1,5 kg de pois mange-tout
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute-les en tirant le fil des deux côtés, d'un seul geste.
      'Top and string them by pulling the thread off both sides in one go.',
      // FR: Plonge-les par fournées dans une grande eau salée bouillante, **2 minutes**.
      'Plunge them in batches into a large pan of boiling salted water for **2 minutes**.',
      // FR: Fais-les tomber dans l'eau glacée : le vert devient éclatant et se fixe.
      'Drop them into the iced water: the green turns vivid and sets.',
      // FR: Égoutte et sèche-les bien dans un torchon.
      'Drain and dry well in a tea towel.',
      // FR: Congèle-les étalés sur une plaque, puis mets-les en sac. Ils iront gelés dans le wok chaud.
      'Freeze them spread out on a tray, then put into a bag. They go into the hot wok still frozen.',
    ],
  ),
  'pois_mange_tout/Pickles de mange-tout au gingembre': RecipeText(
    // FR: Pickles de mange-tout au gingembre
    name: 'Ginger mangetout pickles',
    // FR: Croquants, acidulés, un peu piquants : un pickle à l'asiatique pour accompagner un bol de riz.
    description: 'Crunchy, tangy, a little hot: an Asian-style pickle to go with a bowl of rice.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '500 g of mangetout', // FR: 500 g de pois mange-tout
      '1 piece of ginger, 3 cm long', // FR: 1 morceau de gingembre de 3 cm
      '25 cl of rice or cider vinegar at 6 %', // FR: 25 cl de vinaigre de riz ou de cidre à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '2 tablespoons of sugar', // FR: 2 cuillères à soupe de sucre
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Équeute les mange-tout et retire le fil. Épluche le gingembre et taille-le en fines lamelles.
      'Top the mangetout and remove the string. Peel the ginger and cut it into thin slivers.',
      // FR: Range les cosses debout dans les bocaux, en glissant le gingembre entre elles.
      'Stand the pods upright in the jars, slipping the ginger between them.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Laisse tiédir 5 minutes, puis verse pour **couvrir entièrement** : trop bouillant, il cuirait les cosses.
      'Leave to cool for 5 minutes, then pour in to **cover completely**: too hot, and it would cook the pods.',
      // FR: Ferme et range au réfrigérateur. Ils sont bons dès le surlendemain.
      'Close and keep in the fridge. They are good the day after next.',
    ],
  ),
  'pois_mange_tout/Mange-tout fermentés à l\'aneth': RecipeText(
    // FR: Mange-tout fermentés à l'aneth
    name: 'Dill fermented mangetout',
    // FR: Une semaine en saumure, et ils prennent une acidité vive tout en restant croquants.
    description: 'A week in brine, and they take on a sharp tang while staying crunchy.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '600 g of mangetout', // FR: 600 g de pois mange-tout
      '1 litre of unchlorinated water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '2 garlic cloves', // FR: 2 gousses d'ail
      'a few sprigs of dill', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** pour faire la saumure.
      'Dissolve **30 g of salt in 1 litre of water** to make the brine.',
      // FR: Équeute les mange-tout et retire le fil. Choisis-les jeunes et fermes, les gros deviennent mous.
      'Top the mangetout and remove the string. Choose young, firm ones; the big ones go soft.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et l'aneth, jusqu'à 3 cm du bord.
      'Pack them into a jar with the crushed garlic and the dill, up to 3 cm from the rim.',
      // FR: Verse la saumure pour couvrir et pose un poids : tout doit rester **sous la saumure**.
      'Pour in the brine to cover and add a weight: everything must stay **under the brine**.',
      // FR: Laisse une semaine à 18–22 °C, couvercle posé sans serrer, à l'abri du soleil.
      'Leave for a week at 18–22 °C, lid resting on without being tightened, out of the sun.',
      // FR: Goûte, et dès que l'acidité te plaît, ferme bien et passe au réfrigérateur.
      'Taste, and as soon as the tang suits you, close the lid firmly and move it to the fridge.',
    ],
  ),
  'pois_mange_tout/Pois gourmands sautés au wok': RecipeText(
    // FR: Pois gourmands sautés au wok
    name: 'Wok-fried mangetout',
    // FR: Deux minutes à feu vif, sésame et sauce soja.
    description: 'Two minutes over a high heat, sesame and soy sauce.',
  ),
  'pois_mange_tout/Salade de pois gourmands croquants': RecipeText(
    // FR: Salade de pois gourmands croquants
    name: 'Crunchy mangetout salad',
    // FR: Blanchis trente secondes, glacés à l'eau froide.
    description: 'Blanched for thirty seconds, refreshed in cold water.',
  ),
  'pois_mange_tout/Pois gourmands à la crème de menthe': RecipeText(
    // FR: Pois gourmands à la crème de menthe
    name: 'Mangetout in mint cream',
    // FR: Une crème légère à la menthe fraîche du jardin.
    description: 'A light cream with fresh mint from the garden.',
  ),

  // ─────────── poivron (6 recettes) ───────────
  'poivron/Lanières de poivrons congelées': RecipeText(
    // FR: Lanières de poivrons congelées
    name: 'Frozen pepper strips',
    // FR: Pas besoin de blanchir : coupés crus et congelés à plat, ils filent droit dans les poêlées et les sauces.
    description: 'No need to blanch: cut raw and frozen flat, they go straight into stir-fries and sauces.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of peppers of every colour', // FR: 2 kg de poivrons de toutes les couleurs
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les poivrons et essuie-les bien.
      'Wash the peppers and dry them well.',
      // FR: Ouvre-les, retire le pédoncule, les graines et les côtes blanches, puis taille des lanières.
      'Open them up, remove the stalk, seeds and white ribs, then cut into strips.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent** et congèle 2 heures.
      'Spread them on a tray **so they do not touch** and freeze for 2 hours.',
      // FR: Verse-les en sacs une fois dures, chasse l'air et note la date.
      'Tip them into bags once hard, press out the air and write the date.',
      // FR: À l'usage, jette-les gelées dans la poêle chaude. Décongelés ils sont mous : pour cuire, pas pour une salade.
      'To use, drop them frozen into the hot pan. Thawed, they are soft: for cooking, not for a salad.',
    ],
  ),
  'poivron/Pickles de poivrons aigres-doux': RecipeText(
    // FR: Pickles de poivrons aigres-doux
    name: 'Sweet-and-sour pepper pickles',
    // FR: Rouges, jaunes et verts dans le même bocal : un condiment qui réveille une assiette de riz ou un sandwich.
    description: 'Red, yellow and green in the same jar: a condiment that brightens a plate of rice or a sandwich.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of peppers', // FR: 1 kg de poivrons
      '1 onion', // FR: 1 oignon
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '100 g of sugar', // FR: 100 g de sucre
      '1 tablespoon of fine salt', // FR: 1 cuillère à soupe de sel fin
    ],
    steps: <String>[
      // FR: Épépine les poivrons et coupe-les en lanières d'un doigt. Émince l'oignon finement.
      'Deseed the peppers and cut them into strips as wide as a finger. Slice the onion finely.',
      // FR: Tasse poivrons et oignon dans des bocaux propres, en mélangeant les couleurs.
      'Pack the peppers and onion into clean jars, mixing the colours.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Verse bouillant sur les légumes jusqu'à **les couvrir entièrement**, en laissant 1 cm sous le bord.
      'Pour it boiling over the vegetables until they are **completely covered**, leaving 1 cm below the rim.',
      // FR: Tapote les bocaux pour chasser les bulles d'air, complète si besoin, et ferme.
      'Tap the jars to release air bubbles, top up if needed, and close.',
      // FR: Une fois froids, range-les au réfrigérateur. Attends 3 jours avant d'y goûter.
      'Once cold, keep them in the fridge. Wait 3 days before tasting.',
    ],
  ),
  'poivron/Paprika maison': RecipeText(
    // FR: Paprika maison
    name: 'Homemade paprika',
    // FR: Des poivrons rouges séchés puis moulus : une poudre douce et fruitée qui n'a rien à voir avec celle du commerce.
    description: 'Red peppers dried then ground: a sweet, fruity powder that is nothing like the shop-bought kind.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      '2 kg of very ripe red peppers', // FR: 2 kg de poivrons rouges bien mûrs
      'baking paper', // FR: du papier cuisson
      'a small, very dry glass jar', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Épépine les poivrons, retire les côtes blanches et coupe-les en lanières fines de 1 cm.
      'Deseed the peppers, remove the white ribs and cut into thin 1 cm strips.',
      // FR: Étale-les peau dessous sur les plaques et enfourne à **60 °C**, porte entrouverte.
      'Spread them skin side down on the trays and put them in the oven at **60 °C**, door held ajar.',
      // FR: Retourne-les de temps en temps. Elles doivent être **cassantes**, pas souples : une lanière souple moisira dans le pot.
      'Turn them from time to time. They must be **brittle**, not supple: a supple strip will go mouldy in the jar.',
      // FR: Laisse refroidir, puis mixe en poudre fine au moulin à café, par petites quantités.
      'Leave to cool, then grind to a fine powder in a coffee grinder, in small batches.',
      // FR: Tamise et mets en pot. Il en faut beaucoup : 2 kg donnent à peine un petit pot.
      'Sift and put into a jar. You need a lot: 2 kg gives barely one small jar.',
    ],
  ),
  'poivron/Poivrons marinés à l\'huile': RecipeText(
    // FR: Poivrons marinés à l'huile
    name: 'Peppers marinated in oil',
    // FR: Grillés, pelés, couchés dans l'huile d'olive à l'ail : ils se gardent des semaines.
    description: 'Grilled, peeled, laid in garlic olive oil: they keep for weeks.',
    ingredients: <String>[
      '6 fleshy peppers', // FR: 6 poivrons charnus
      'Olive oil', // FR: Huile d'olive
      '2 garlic cloves', // FR: 2 gousses d'ail
      'Salt, oregano or basil', // FR: Sel, origan ou basilic
    ],
    steps: <String>[
      // FR: Passe les poivrons entiers sous le gril jusqu'à ce que la peau noircisse et cloque, en les retournant.
      'Put the whole peppers under the grill until the skin blackens and blisters, turning them.',
      // FR: Enferme-les chauds dans un sac ou un saladier couvert : la vapeur décolle la peau toute seule.
      'Shut them in while still hot in a bag or a covered bowl: the steam loosens the skin by itself.',
      // FR: Pèle-les, ôte les graines, coupe-les en lanières. Ne les rince pas, tu perdrais le jus.
      'Peel them, remove the seeds and cut into strips. Do not rinse them, or you will lose the juice.',
      // FR: Range les lanières en bocal avec l'ail en lamelles et les herbes, couvre entièrement d'huile.
      'Pack the strips into a jar with the sliced garlic and the herbs, and cover completely with oil.',
      // FR: Au frais. Meilleurs au bout de deux jours.
      'Keep in the fridge. Best after two days.',
    ],
  ),
  'poivron/Poivrons farcis': RecipeText(
    // FR: Poivrons farcis
    name: 'Stuffed peppers',
    // FR: Riz, viande ou lentilles, herbes : un plat complet au four.
    description: 'Rice, meat or lentils, and herbs: a complete meal from the oven.',
  ),
  'poivron/Piperade': RecipeText(
    // FR: Piperade
    name: 'Piperade',
    // FR: Poivrons, tomates et oignons mijotés, liés aux œufs — le Pays basque dans une poêle.
    description: 'Peppers, tomatoes and onions simmered together, bound with eggs — the Basque Country in a pan.',
  ),

  // ─────────── pomme_de_terre (6 recettes) ───────────
  'pomme_de_terre/Frites maison précuites congelées': RecipeText(
    // FR: Frites maison précuites congelées
    name: 'Frozen homemade part-cooked chips',
    // FR: Coupées et blanchies d'avance, elles passent du congélateur à la friteuse ou au four, comme celles du commerce.
    description: 'Cut and blanched in advance, they go from the freezer to the fryer or the oven, like the shop-bought ones.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1.5 kg of floury potatoes (Bintje)', // FR: 1,5 kg de pommes de terre farineuses (bintje)
      'coarse salt', // FR: gros sel
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en frites de 1 cm, toutes pareilles.
      'Peel the potatoes and cut them into 1 cm chips, all the same size.',
      // FR: Rince-les à grande eau jusqu'à ce qu'elle soit claire : l'amidon en surface les fait coller.
      'Rinse them in plenty of water until it runs clear: the starch on the surface makes them stick.',
      // FR: Plonge-les par fournées dans l'eau bouillante salée et compte **3 minutes** : elles doivent rester fermes.
      'Plunge them in batches into boiling salted water and count **3 minutes**: they must stay firm.',
      // FR: Plonge-les dans l'eau glacée, puis égoutte.
      'Put them into the iced water, then drain.',
      // FR: Sèche-les très bien sur un torchon : l'eau qui reste fait des projections à la cuisson.
      'Dry them very well on a tea towel: any water left behind spits when they cook.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets en sac. Cuis-les **sans décongeler**, au four à 220 °C ou à la friteuse.
      'Spread them on a tray, freeze for 2 hours, then put into a bag. Cook them **without thawing**, in the oven at 220 °C or in the fryer.',
    ],
  ),
  'pomme_de_terre/Purée maison en portions': RecipeText(
    // FR: Purée maison en portions
    name: 'Mashed potato in portions',
    // FR: Crue, la pomme de terre devient noire et farineuse au congélateur ; en purée bien beurrée, elle se garde très bien.
    description: 'Raw, potato turns black and mealy in the freezer; as a well-buttered mash, it keeps very well.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      '2 kg of potatoes', // FR: 2 kg de pommes de terre
      '100 g of butter', // FR: 100 g de beurre
      '30 cl of milk', // FR: 30 cl de lait
      'salt, nutmeg', // FR: sel, muscade
      'freezer boxes', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en morceaux réguliers.
      'Peel the potatoes and cut them into even pieces.',
      // FR: Cuis-les à l'eau salée, départ eau froide, jusqu'à ce qu'elles s'écrasent sous la fourchette.
      'Cook them in salted water, starting from cold, until they crush under a fork.',
      // FR: Égoutte et passe-les au moulin à légumes, **jamais au mixeur** : elles deviendraient collantes.
      'Drain and pass them through a food mill, **never a blender**: they would turn sticky.',
      // FR: Incorpore le beurre puis le lait chaud. **Bien beurrée**, elle supporte mieux la congélation.
      'Stir in the butter, then the hot milk. **Well buttered**, it stands up better to freezing.',
      // FR: Laisse refroidir complètement, couvert d'un film au contact.
      'Leave to cool completely, covered with cling film pressed onto the surface.',
      // FR: Répartis en portions d'un repas et congèle. Réchauffe doucement avec un trait de lait en remuant.
      'Divide into one-meal portions and freeze. Reheat gently with a splash of milk, stirring.',
    ],
  ),
  'pomme_de_terre/Lamelles de pomme de terre déshydratées': RecipeText(
    // FR: Lamelles de pomme de terre déshydratées
    name: 'Dehydrated potato slices',
    // FR: Précuites puis séchées, elles se gardent au placard et regonflent en vingt minutes dans un gratin ou une soupe.
    description: 'Part-cooked then dried, they keep in the cupboard and plump up in twenty minutes in a gratin or a soup.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, away from light',
    ingredients: <String>[
      '2 kg of firm potatoes', // FR: 2 kg de pommes de terre fermes
      'baking paper', // FR: du papier cuisson
      'airtight jars', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Épluche et coupe en lamelles de 3 mm, à la mandoline.
      'Peel and slice 3 mm thick, on a mandoline.',
      // FR: Rince-les dans plusieurs eaux jusqu'à ce qu'elle reste claire.
      'Rinse them in several changes of water until it stays clear.',
      // FR: Plonge-les dans l'eau bouillante **5 minutes** : précuites, elles ne noircissent pas en séchant.
      'Plunge them into boiling water for **5 minutes**: part-cooked, they do not blacken as they dry.',
      // FR: Rafraîchis-les à l'eau froide et étale-les sur un torchon pour les sécher.
      'Refresh them in cold water and spread them on a tea towel to dry.',
      // FR: Dispose-les en une seule couche sur des plaques, et sèche au four à **60 °C**, porte entrouverte, ou au déshydrateur.
      'Lay them in a single layer on trays, and dry in the oven at **60 °C**, door held ajar, or in a dehydrator.',
      // FR: Elles sont prêtes quand elles cassent net comme du verre. Laisse refroidir et range en bocal fermé.
      'They are ready when they snap cleanly like glass. Leave to cool and store in a closed jar.',
    ],
  ),
  'pomme_de_terre/Gratin dauphinois': RecipeText(
    // FR: Gratin dauphinois
    name: 'Gratin dauphinois',
    // FR: Des lamelles fines qui fondent dans la crème et l'ail, une heure au four.
    description: 'Thin slices melting into cream and garlic, an hour in the oven.',
    ingredients: <String>[
      '1 kg of firm-fleshed potatoes', // FR: 1 kg de pommes de terre à chair ferme
      '40 cl of cream', // FR: 40 cl de crème liquide
      '20 cl of milk', // FR: 20 cl de lait
      '1 garlic clove', // FR: 1 gousse d'ail
      'Nutmeg, salt, pepper', // FR: Noix de muscade, sel, poivre
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en rondelles de 2 mm. Ne les rince pas : l'amidon fait tenir le gratin.
      'Peel the potatoes and cut them into 2 mm rounds. Do not rinse them: the starch holds the gratin together.',
      // FR: Frotte le plat avec la gousse d'ail coupée en deux, puis beurre-le.
      'Rub the dish with the garlic clove cut in half, then butter it.',
      // FR: Chauffe la crème et le lait avec la muscade, le sel et le poivre, sans faire bouillir.
      'Heat the cream and milk with the nutmeg, salt and pepper, without letting it boil.',
      // FR: Range les rondelles en couches serrées, verse le mélange chaud dessus jusqu'à les couvrir.
      'Arrange the rounds in tight layers and pour the hot mixture over until they are covered.',
      // FR: Four à 160 °C. Le gratin est prêt quand la pointe d'un couteau traverse sans résistance.
      'Oven at 160 °C. The gratin is ready when the tip of a knife goes through without resistance.',
      // FR: Laisse reposer dix minutes avant de servir : il se tient mieux à la découpe.
      'Leave to rest for ten minutes before serving: it holds together better when cut.',
    ],
  ),
  'pomme_de_terre/Pommes de terre sautées à l\'ail': RecipeText(
    // FR: Pommes de terre sautées à l'ail
    name: 'Garlic sautéed potatoes',
    // FR: Croustillantes dehors, fondantes dedans, avec du persil du jardin.
    description: 'Crisp outside, soft inside, with parsley from the garden.',
  ),
  'pomme_de_terre/Soupe poireaux-pommes de terre': RecipeText(
    // FR: Soupe poireaux-pommes de terre
    name: 'Leek and potato soup',
    // FR: La soupe de tous les hivers, celle qu'on refait sans recette.
    description: 'The soup of every winter, the one you make again without a recipe.',
    ingredients: <String>[
      '4 leeks', // FR: 4 poireaux
      '4 potatoes', // FR: 4 pommes de terre
      '1 l of water or stock', // FR: 1 l d'eau ou de bouillon
      'A knob of butter, salt, pepper', // FR: Une noix de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Fends les poireaux en quatre dans la longueur et rince-les bien : la terre se cache entre les feuilles.
      'Split the leeks in four lengthways and rinse them well: the soil hides between the leaves.',
      // FR: Fais-les suer au beurre à feu doux, sans les colorer.
      'Sweat them in the butter over a low heat, without letting them colour.',
      // FR: Ajoute les pommes de terre en gros cubes et l'eau. Sale peu : tu rectifieras à la fin.
      'Add the potatoes in big cubes and the water. Go easy on the salt: you will adjust at the end.',
      // FR: Laisse frémir à couvert jusqu'à ce que les cubes s'écrasent à la fourchette.
      'Simmer covered until the cubes crush with a fork.',
      // FR: Mixe, ou écrase grossièrement si tu aimes les morceaux. Rectifie le sel.
      'Blend, or crush roughly if you like it chunky. Adjust the salt.',
    ],
  ),

  // ─────────── pommier (6 recettes) ───────────
  'pommier/Compote de pommes en bocaux': RecipeText(
    // FR: Compote de pommes en bocaux
    name: 'Apple compote in jars',
    // FR: Les pommes tombées, les tachées, les petites : tout finit en bocaux qui tiennent jusqu'à la récolte suivante.
    description: 'Windfalls, spotted ones, small ones: everything ends up in jars that last until the next harvest.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 5 days in the fridge once opened',
    ingredients: <String>[
      '3 kg of apples', // FR: 3 kg de pommes
      '150 to 300 g of sugar, depending on the acidity', // FR: 150 à 300 g de sucre, selon l'acidité
      '20 cl of water', // FR: 20 cl d'eau
      'the juice of a lemon', // FR: le jus d'un citron
      '6 jars of 50 cl with new seals or lids', // FR: 6 bocaux de 50 cl avec joints ou couvercles neufs
    ],
    steps: <String>[
      // FR: Épluche, épépine et coupe les pommes en morceaux, en les arrosant de citron au fur et à mesure.
      'Peel, core and cut the apples into pieces, sprinkling them with lemon as you go.',
      // FR: Cuis-les à couvert avec l'eau et le sucre, à feu doux, en remuant, jusqu'à ce qu'elles s'écrasent.
      'Cook them covered with the water and sugar over a low heat, stirring, until they break down.',
      // FR: Écrase à la fourchette pour une compote rustique, ou passe au moulin à légumes pour une compote lisse.
      'Mash with a fork for a rustic compote, or pass through a food mill for a smooth one.',
      // FR: Remplis les bocaux propres de compote chaude **jusqu'à 2 cm du bord**, essuie les bords et ferme avec des joints neufs.
      'Fill clean jars with hot compote **to 2 cm from the rim**, wipe the rims and close with new seals.',
      // FR: Pose les bocaux dans une grande marmite, **couverts d'eau**, et stérilise **25 minutes à 100 °C**, à compter de l'ébullition.
      'Stand the jars in a large pot, **covered with water**, and sterilise for **25 minutes at 100 °C**, counting from the moment it boils.',
      // FR: Laisse refroidir dans l'eau, puis vérifie : couvercle creusé ou joint qui tient. Sinon, au frais et à manger dans la semaine.
      'Let them cool in the water, then check: lid dipped inwards or seal holding. If not, into the fridge, and eat within the week.',
    ],
  ),
  'pommier/Rondelles de pommes séchées': RecipeText(
    // FR: Rondelles de pommes séchées
    name: 'Dried apple rings',
    // FR: Quatre heures de four doux, et des chips de pomme souples à grignoter tout l'hiver.
    description: 'Four hours in a low oven, and you have soft apple chips to snack on all winter.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '2 kg of firm apples', // FR: 2 kg de pommes fermes
      '1 litre of cold water', // FR: 1 litre d'eau froide
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Évide les pommes avec un vide-pomme, épluche-les si tu veux, et coupe des rondelles de **5 mm**, toutes pareilles.
      'Core the apples with an apple corer, peel them if you like, and cut **5 mm** rings, all the same.',
      // FR: Plonge-les au fur et à mesure dans l'eau citronnée : c'est ce qui les empêche de brunir.
      'Drop them into the lemon water as you go: that is what stops them browning.',
      // FR: Égoutte et éponge-les sur un torchon propre.
      'Drain and pat them dry on a clean tea towel.',
      // FR: Étale-les sans chevauchement sur des grilles et sèche au four à **70 °C**, porte entrouverte avec une cuillère en bois. Retourne-les à mi-temps.
      'Spread them on racks without overlapping and dry in the oven at **70 °C**, door held ajar with a wooden spoon. Turn them halfway.',
      // FR: Teste une rondelle refroidie : souple comme du cuir, sans aucune humidité quand tu la plies en deux.
      'Test a cooled ring: supple as leather, with no dampness when you fold it in half.',
      // FR: Mets-les en bocal et secoue-le chaque jour pendant une semaine. S'il se forme de la buée, retour au four.
      'Put them in a jar and shake it every day for a week. If condensation forms, back in the oven.',
    ],
  ),
  'pommier/Quartiers de pommes congelés': RecipeText(
    // FR: Quartiers de pommes congelés
    name: 'Frozen apple wedges',
    // FR: Vingt minutes, et tu as des pommes prêtes pour une tarte ou un crumble, sans éplucher le soir venu.
    description: 'Twenty minutes, and you have apples ready for a tart or a crumble, with no peeling when the evening comes.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 kg of apples', // FR: 2 kg de pommes
      'the juice of a lemon', // FR: le jus d'un citron
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche, épépine et coupe les pommes en quartiers ou en lamelles épaisses.
      'Peel, core and cut the apples into wedges or thick slices.',
      // FR: Arrose-les de jus de citron et mélange bien : **sans citron**, elles brunissent au congélateur.
      'Sprinkle with lemon juice and toss well: **without lemon**, they brown in the freezer.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Spread them on a tray so they do not touch and freeze for 2 hours.',
      // FR: Verse-les en sac une fois dures. Elles vont directement dans une tarte, un crumble ou une compote, sans décongeler.
      'Tip them into a bag once hard. They go straight into a tart, a crumble or a compote, without thawing.',
    ],
  ),
  'pommier/Tarte aux pommes': RecipeText(
    // FR: Tarte aux pommes
    name: 'Apple tart',
    // FR: Des quartiers rangés en rosace sur une compote, et du sucre qui caramélise.
    description: 'Wedges arranged in a rosette over a compote, and sugar that caramelises.',
    ingredients: <String>[
      '1 shortcrust pastry', // FR: 1 pâte brisée
      '6 apples (4 for the compote, 2 for the top)', // FR: 6 pommes (4 pour la compote, 2 pour le dessus)
      '50 g of sugar', // FR: 50 g de sucre
      'A knob of butter', // FR: Une noix de beurre
      'Cinnamon (optional)', // FR: Cannelle (facultatif)
    ],
    steps: <String>[
      // FR: Épluche quatre pommes, coupe-les en morceaux et fais-les compoter à couvert avec deux cuillères d'eau.
      'Peel four apples, cut them into pieces and cook them down covered with two spoonfuls of water.',
      // FR: Écrase la compote à la fourchette, sucre-la légèrement. Laisse tiédir.
      'Mash the compote with a fork and sweeten it lightly. Leave to cool a little.',
      // FR: Étale la pâte dans le moule, pique le fond, étale la compote dessus.
      'Roll the pastry into the tin, prick the base and spread the compote over it.',
      // FR: Taille les deux pommes restantes en lamelles fines et range-les en rosace, en les faisant se chevaucher.
      'Cut the two remaining apples into thin slices and arrange them in a rosette, overlapping them.',
      // FR: Parsème de noisettes de beurre et du reste de sucre.
      'Dot with small pieces of butter and sprinkle with the rest of the sugar.',
      // FR: Four à 190 °C jusqu'à ce que les bords des lamelles brunissent.
      'Oven at 190 °C until the edges of the slices turn brown.',
    ],
  ),
  'pommier/Compote maison': RecipeText(
    // FR: Compote maison
    name: 'Homemade compote',
    // FR: Sans sucre ajouté si les pommes sont mûres — elles suffisent.
    description: 'No added sugar if the apples are ripe — they are enough.',
  ),
  'pommier/Pommes au four': RecipeText(
    // FR: Pommes au four
    name: 'Baked apples',
    // FR: Évidées, remplies de beurre, de sucre et d'une noix.
    description: 'Cored, filled with butter, sugar and a walnut.',
  ),

  // ─────────── potimarron (6 recettes) ───────────
  'potimarron/Purée de potimarron en portions': RecipeText(
    // FR: Purée de potimarron en portions
    name: 'Red kuri squash purée in portions',
    // FR: Rôti puis écrasé, il donne une purée dense et sucrée, prête pour un velouté, un gâteau ou un gratin.
    description: 'Roasted then mashed, it gives a dense, sweet purée, ready for a velouté, a cake or a gratin.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 red kuri squashes (about 3 kg)', // FR: 2 potimarrons (environ 3 kg)
      '1 tablespoon of oil', // FR: 1 cuillère à soupe d'huile
      'salt', // FR: sel
      'freezer boxes or bags', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les potimarrons en deux, retire les graines, puis taille en quartiers. Garde la peau : elle fond à la cuisson.
      'Cut the squashes in half, remove the seeds, then cut into wedges. Keep the skin: it melts as it cooks.',
      // FR: Enfourne les quartiers huilés à 200 °C, jusqu'à ce qu'un couteau s'y enfonce tout seul.
      'Put the oiled wedges in the oven at 200 °C, until a knife slips in by itself.',
      // FR: Mixe la chair avec sa peau. Rôtie plutôt que bouillie, la purée est moins aqueuse et plus sucrée.
      'Blend the flesh with its skin. Roasted rather than boiled, the purée is less watery and sweeter.',
      // FR: Laisse refroidir complètement, étalée dans un plat.
      'Leave to cool completely, spread out in a dish.',
      // FR: Répartis en portions de 500 g en laissant 2 cm de vide, ferme et date.
      'Divide into 500 g portions, leaving 2 cm of space at the top, close and date.',
    ],
  ),
  'potimarron/Dés de potimarron crus congelés': RecipeText(
    // FR: Dés de potimarron crus congelés
    name: 'Raw frozen red kuri squash dice',
    // FR: Pas besoin de blanchir : coupé en dés et congelé sur plaque, il file tout droit au four ou dans la soupe.
    description: 'No need to blanch: cut into dice and frozen on a tray, it goes straight into the oven or the soup.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 red kuri squashes (about 3 kg)', // FR: 2 potimarrons (environ 3 kg)
      'a tray', // FR: une plaque
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave et essuie la peau des potimarrons.
      'Wash the squashes and wipe the skin dry.',
      // FR: Coupe-les en quartiers, retire les graines, puis taille en dés de 2 cm, avec la peau.
      'Cut them into wedges, remove the seeds, then cut into 2 cm dice, skin on.',
      // FR: Sèche les dés sur un torchon si la chair est humide.
      'Dry the dice on a tea towel if the flesh is damp.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Spread them on a tray so they do not touch and freeze for 2 hours.',
      // FR: Verse-les en sacs une fois durs, et date. Cuis-les encore gelés : au four, ils rôtissent très bien.
      'Tip them into bags once hard, and date. Cook them still frozen: in the oven, they roast very well.',
    ],
  ),
  'potimarron/Pickles de potimarron épicés': RecipeText(
    // FR: Pickles de potimarron épicés
    name: 'Spiced red kuri squash pickles',
    // FR: En fines lamelles au vinaigre et aux épices, il devient un condiment orange vif pour les fromages et les plats froids.
    description: 'In thin slices in vinegar and spices, it becomes a bright orange condiment for cheeses and cold dishes.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '1 kg of peeled red kuri squash flesh', // FR: 1 kg de chair de potimarron épluchée
      '40 cl of white vinegar at 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl of water', // FR: 40 cl d'eau
      '15 g of salt, 80 g of sugar', // FR: 15 g de sel, 80 g de sucre
      '1 cinnamon stick, 1 piece of ginger, 3 cm long', // FR: 1 bâton de cannelle, 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Épluche le potimarron, retire les graines et taille la chair en fines lamelles de 3 mm.
      'Peel the squash, remove the seeds and cut the flesh into thin 3 mm slices.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel, le sucre, la cannelle et le gingembre en lamelles, 5 minutes.
      'Boil the vinegar, water, salt, sugar, cinnamon and sliced ginger for 5 minutes.',
      // FR: Ajoute les lamelles et laisse frémir **2 minutes** : elles doivent rester fermes.
      'Add the slices and simmer for **2 minutes**: they must stay firm.',
      // FR: Répartis les lamelles dans trois bocaux ébouillantés.
      'Divide the slices between three scalded jars.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Pour in the boiling liquid to **cover completely**, close and leave to cool.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'ouvrir.
      'Keep in the fridge and wait 3 days before opening.',
    ],
  ),
  'potimarron/Velouté de potimarron': RecipeText(
    // FR: Velouté de potimarron
    name: 'Red kuri squash velouté',
    // FR: Sa peau se mange : pas d'épluchage, et un goût de châtaigne.
    description: 'Its skin is edible: no peeling, and a chestnut flavour.',
    ingredients: <String>[
      '1 red kuri squash (1.2 kg)', // FR: 1 potimarron (1,2 kg)
      '1 onion', // FR: 1 oignon
      '70 cl of stock', // FR: 70 cl de bouillon
      '10 cl of cream', // FR: 10 cl de crème
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave le potimarron, coupe-le en cubes **sans l'éplucher** : la peau fond à la cuisson.
      'Wash the squash and cut it into cubes **without peeling it**: the skin melts as it cooks.',
      // FR: Fais fondre l'oignon, ajoute les cubes.
      'Soften the onion, then add the cubes.',
      // FR: Mouille au bouillon, à hauteur.
      'Pour in the stock to just cover.',
      // FR: Cuis 25 minutes à couvert.
      'Cook for 25 minutes, covered.',
      // FR: Mixe, crème hors du feu, muscade.
      'Blend, add the cream off the heat, then nutmeg.',
    ],
  ),
  'potimarron/Potimarron rôti au four': RecipeText(
    // FR: Potimarron rôti au four
    name: 'Oven-roasted red kuri squash',
    // FR: En quartiers, à l'huile et au romarin : le four fait tout le travail.
    description: 'In wedges, with oil and rosemary: the oven does all the work.',
    ingredients: <String>[
      '1 red kuri squash', // FR: 1 potimarron
      '3 tablespoons of olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      '2 garlic cloves, unpeeled', // FR: 2 gousses d'ail
      'rosemary, coarse salt, pepper', // FR: romarin, gros sel, poivre
    ],
    steps: <String>[
      // FR: Coupe le potimarron en quartiers, retire les graines, garde la peau.
      'Cut the squash into wedges, remove the seeds, keep the skin.',
      // FR: Enrobe d'huile, ajoute l'ail en chemise et le romarin.
      'Coat with oil, add the garlic in its skin and the rosemary.',
      // FR: Four à 200 °C, 35 minutes. Retourne les quartiers à mi-cuisson.
      'Oven at 200 °C, 35 minutes. Turn the wedges halfway through.',
      // FR: Gros sel et poivre à la sortie.
      'Coarse salt and pepper when it comes out.',
    ],
  ),
  'potimarron/Tarte au potimarron': RecipeText(
    // FR: Tarte au potimarron
    name: 'Red kuri squash tart',
    // FR: Entre la tarte et le flan, à peine sucrée, très réconfortante.
    description: 'Halfway between a tart and a flan, barely sweet, very comforting.',
    ingredients: <String>[
      '1 shortcrust pastry', // FR: 1 pâte brisée
      '800 g of red kuri squash', // FR: 800 g de potimarron
      '2 eggs, 20 cl of cream', // FR: 2 oeufs, 20 cl de crème
      '60 g of sugar', // FR: 60 g de sucre
      'cinnamon, nutmeg, salt', // FR: cannelle, muscade, sel
    ],
    steps: <String>[
      // FR: Cuis le potimarron en cubes 20 minutes à la vapeur.
      'Steam the squash in cubes for 20 minutes.',
      // FR: Écrase-le et laisse-le refroidir, bien égoutté.
      'Mash it and leave it to cool, well drained.',
      // FR: Mélange avec oeufs, crème, sucre, cannelle, muscade, une pincée de sel.
      'Mix with the eggs, cream, sugar, cinnamon, nutmeg and a pinch of salt.',
      // FR: Verse sur la pâte étalée et piquée.
      'Pour onto the rolled-out, pricked pastry.',
      // FR: Four à 180 °C, 40 minutes : le centre doit être juste pris.
      'Oven at 180 °C, 40 minutes: the centre should be only just set.',
    ],
  ),

  // ─────────── potiron (6 recettes) ───────────
  'potiron/Purée de potiron en portions': RecipeText(
    // FR: Purée de potiron en portions
    name: 'Pumpkin purée in portions',
    // FR: Cuit à la vapeur et écrasé, un potiron entier tient dans quelques boîtes, prêtes pour les soupes, gnocchis et gâteaux.
    description: 'Steamed and mashed, a whole pumpkin fits into a few boxes, ready for soups, gnocchi and cakes.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 pumpkin of about 3 kg', // FR: 1 potiron d'environ 3 kg
      'freezer boxes', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Coupe le potiron en quartiers, retire graines et filaments, puis épluche et coupe en gros cubes.
      'Cut the pumpkin into wedges, remove the seeds and stringy bits, then peel and cut into big cubes.',
      // FR: Cuis à la vapeur jusqu'à ce que la chair s'écrase sous la fourchette.
      'Steam until the flesh crushes under a fork.',
      // FR: Laisse égoutter 10 minutes dans une passoire : une purée trop aqueuse fait des glaçons.
      'Leave to drain for 10 minutes in a colander: a purée that is too watery makes ice blocks.',
      // FR: Écrase ou mixe sans rien ajouter, ni sel ni beurre : tu assaisonneras selon le plat.
      'Mash or blend without adding anything, no salt or butter: you will season it to suit the dish.',
      // FR: Laisse refroidir complètement.
      'Leave to cool completely.',
      // FR: Répartis par portions de 500 g en laissant 2 cm de vide, et note la date.
      'Divide into 500 g portions, leaving 2 cm of space at the top, and write the date.',
    ],
  ),
  'potiron/Cubes de potiron crus congelés': RecipeText(
    // FR: Cubes de potiron crus congelés
    name: 'Raw frozen pumpkin cubes',
    // FR: Un potiron entamé pourrit vite : en cubes crus, il file au congélateur en vingt minutes et va directement dans la soupe.
    description: 'A pumpkin, once cut, rots quickly: as raw cubes, it goes into the freezer in twenty minutes and straight into the soup.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 pumpkin of about 3 kg', // FR: 1 potiron d'environ 3 kg
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le potiron en quartiers, retire graines et filaments à la cuillère.
      'Cut the pumpkin into wedges, scoop out the seeds and stringy bits with a spoon.',
      // FR: Épluche chaque quartier posé à plat et coupe la chair en cubes de 3 cm.
      'Peel each wedge laid flat and cut the flesh into 3 cm cubes.',
      // FR: Étale les cubes sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Spread the cubes on a tray so they do not touch and freeze for 2 hours.',
      // FR: Verse-les en sac, chasse l'air. **Cuis-les sans décongeler** : en soupe, en curry ou rôtis au four.
      'Tip them into a bag, press out the air. **Cook them without thawing**: in soup, in a curry or roasted in the oven.',
    ],
  ),
  'potiron/Potiron aigre-doux au vinaigre': RecipeText(
    // FR: Potiron aigre-doux au vinaigre
    name: 'Sweet-and-sour pickled pumpkin',
    // FR: Une recette danoise : des cubes de potiron confits dans un vinaigre sucré au gingembre, à servir avec la viande froide.
    description: 'A Danish recipe: cubes of pumpkin preserved in a sweet ginger vinegar, to serve with cold meat.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1.5 kg of pumpkin flesh', // FR: 1,5 kg de chair de potiron
      '50 cl of cider vinegar at 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '30 cl of water', // FR: 30 cl d'eau
      '300 g of sugar', // FR: 300 g de sucre
      '1 piece of ginger, 3 cm long', // FR: 1 morceau de gingembre de 3 cm
      '1 cinnamon stick', // FR: 1 bâton de cannelle
    ],
    steps: <String>[
      // FR: Coupe la chair en cubes de 2 cm, bien réguliers pour qu'ils cuisent pareil.
      'Cut the flesh into 2 cm cubes, very even so they cook the same.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le gingembre en lamelles et la cannelle.
      'Bring the vinegar, water, sugar, sliced ginger and cinnamon to the boil.',
      // FR: Plonge les cubes et laisse frémir jusqu'à ce qu'ils deviennent translucides mais **restent entiers**.
      'Drop in the cubes and simmer until they turn translucent but **stay whole**.',
      // FR: Sors-les à l'écumoire et remplis des bocaux propres jusqu'à 2 cm du bord.
      'Lift them out with a slotted spoon and fill clean jars to 2 cm from the rim.',
      // FR: Fais réduire le sirop 5 minutes à feu vif.
      'Reduce the syrup for 5 minutes over a high heat.',
      // FR: Verse-le bouillant pour **couvrir entièrement** le potiron, ferme, laisse refroidir et range au réfrigérateur.
      'Pour it boiling over the pumpkin to **cover it completely**, close, leave to cool and keep in the fridge.',
    ],
  ),
  'potiron/Soupe de potiron au lait de coco': RecipeText(
    // FR: Soupe de potiron au lait de coco
    name: 'Pumpkin and coconut milk soup',
    // FR: Le lait de coco adoucit le potiron et lui donne du corps.
    description: 'Coconut milk softens the pumpkin and gives it body.',
    ingredients: <String>[
      '1 kg of pumpkin', // FR: 1 kg de potiron
      '40 cl of coconut milk', // FR: 40 cl de lait de coco
      '1 onion, 1 garlic clove', // FR: 1 oignon, 1 gousse d'ail
      '1 teaspoon of grated ginger', // FR: 1 cuillère à café de gingembre râpé
      '50 cl of stock, salt, pepper', // FR: 50 cl de bouillon, sel, poivre
    ],
    steps: <String>[
      // FR: Épluche le potiron et coupe-le en gros cubes. Garde les graines : grillées au four, elles font un en-cas.
      'Peel the pumpkin and cut it into big cubes. Keep the seeds: roasted in the oven, they make a snack.',
      // FR: Fais fondre oignon, ail et gingembre dans un peu d'huile.
      'Soften the onion, garlic and ginger in a little oil.',
      // FR: Ajoute le potiron et le bouillon, à hauteur.
      'Add the pumpkin and the stock, to just cover.',
      // FR: Cuis 25 minutes à couvert.
      'Cook for 25 minutes, covered.',
      // FR: Verse le lait de coco, mixe, rectifie. Ne fais plus bouillir après : le coco se sépare.
      'Pour in the coconut milk, blend and adjust the seasoning. Do not boil after that: the coconut splits.',
    ],
  ),
  'potiron/Gratin de potiron': RecipeText(
    // FR: Gratin de potiron
    name: 'Pumpkin gratin',
    // FR: Fondant dessous, gratiné dessus, avec une pointe de muscade.
    description: 'Soft underneath, golden on top, with a hint of nutmeg.',
    ingredients: <String>[
      '1.2 kg of pumpkin', // FR: 1,2 kg de potiron
      '20 cl of cream', // FR: 20 cl de crème
      '2 eggs', // FR: 2 oeufs
      '120 g of grated Comté', // FR: 120 g de comté râpé
      '2 tablespoons of breadcrumbs, salt, pepper, nutmeg', // FR: 2 cuillères à soupe de chapelure, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Coupe le potiron en cubes et cuis-le 15 minutes.
      'Cut the pumpkin into cubes and cook for 15 minutes.',
      // FR: Égoutte-le très soigneusement et écrase-le à la fourchette : le potiron est gorgé d'eau.
      'Drain it very thoroughly and mash with a fork: pumpkin is full of water.',
      // FR: Mélange avec crème, oeufs, la moitié du fromage, muscade, sel, poivre.
      'Mix with the cream, eggs, half the cheese, nutmeg, salt and pepper.',
      // FR: Verse dans le plat, reste de fromage et chapelure par-dessus.
      'Pour into the dish, with the rest of the cheese and the breadcrumbs on top.',
      // FR: Four à 180 °C, 40 minutes.
      'Oven at 180 °C, 40 minutes.',
    ],
  ),
  'potiron/Soupe au potiron': RecipeText(
    // FR: Soupe au potiron
    name: 'Pumpkin soup',
    // FR: La version sans détour : potiron, pomme de terre, un peu de beurre.
    description: 'The no-fuss version: pumpkin, potato, a little butter.',
    ingredients: <String>[
      '800 g of pumpkin', // FR: 800 g de potiron
      '2 potatoes', // FR: 2 pommes de terre
      '1 onion', // FR: 1 oignon
      '80 cl of water or stock', // FR: 80 cl d'eau ou de bouillon
      '30 g of butter, salt, pepper', // FR: 30 g de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Coupe potiron, pommes de terre et oignon en cubes.
      'Cut the pumpkin, potatoes and onion into cubes.',
      // FR: Mets tout dans la casserole, mouille à hauteur, sale.
      'Put everything in the pan, add liquid to just cover, and season with salt.',
      // FR: Cuis 25 minutes, jusqu'à ce que tout s'écrase.
      'Cook for 25 minutes, until everything crushes.',
      // FR: Mixe avec le beurre : c'est lui qui fait le velouté.
      'Blend with the butter: it is what makes it velvety.',
    ],
  ),

  // ─────────── courgette (6 recettes) ───────────
  'courgette/Courgettes râpées en portions': RecipeText(
    // FR: Courgettes râpées en portions
    name: 'Grated courgettes in portions',
    // FR: Râpées, blanchies une minute et pressées : la réponse aux courgettes géantes, prête pour les cakes, galettes et soupes.
    description: 'Grated, blanched for one minute and squeezed dry: the answer to giant courgettes, ready for cakes, fritters and soups.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of courgettes', // FR: 2 kg de courgettes
      'coarse salt', // FR: gros sel
      'a large bowl of iced water', // FR: un grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les extrémités et, sur les très grosses, retire le cœur plein de graines à la cuillère.
      'Trim the ends and, on very big ones, scoop out the seedy core with a spoon.',
      // FR: Râpe-les avec la peau, côté gros trous.
      'Grate them with the skin on, using the coarse side of the grater.',
      // FR: Plonge la râpée dans l'eau bouillante salée, dans un panier ou une passoire, et compte **1 minute**.
      'Tip the grated courgette into boiling salted water, in a basket or colander, and count **1 minute**.',
      // FR: Plonge-la aussitôt dans l'eau glacée, puis égoutte.
      'Plunge it straight into the iced water, then drain.',
      // FR: Presse-la par poignées dans un torchon, **vraiment fort** : une courgette, c'est surtout de l'eau.
      'Squeeze it dry by the handful in a tea towel, **really hard**: a courgette is mostly water.',
      // FR: Mets en sacs plats de 250 g, chasse l'air et congèle. Note la date et le poids sur le sac.
      'Pack into flat 250 g bags, press out the air and freeze. Write the date and weight on the bag.',
    ],
  ),
  'courgette/Pickles de courgettes au curcuma': RecipeText(
    // FR: Pickles de courgettes au curcuma
    name: 'Turmeric courgette pickles',
    // FR: Sucrés-acidulés et jaune soleil, ces « bread and butter » américains font disparaître une brouette de courgettes.
    description: 'Sweet-sour and sunshine yellow, these American "bread and butter" pickles use up a whole wheelbarrow of courgettes.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1.5 kg of courgettes', // FR: 1,5 kg de courgettes
      '2 onions', // FR: 2 oignons
      '40 g of coarse salt', // FR: 40 g de gros sel
      '60 cl of cider vinegar at 6 %', // FR: 60 cl de vinaigre de cidre à 6 %
      '40 cl of water and 200 g of sugar', // FR: 40 cl d'eau et 200 g de sucre
      '1 teaspoon of turmeric and 2 of mustard seeds', // FR: 1 cuillère à café de curcuma et 2 de graines de moutarde
    ],
    steps: <String>[
      // FR: Coupe les courgettes en rondelles de 5 mm et les oignons en fines lamelles.
      'Cut the courgettes into 5 mm slices and the onions into thin slivers.',
      // FR: Mélange-les au gros sel, couvre de glaçons et laisse dégorger une heure.
      'Mix them with the coarse salt, cover with ice cubes and leave to draw out the water for an hour.',
      // FR: Rince deux fois à l'eau froide et égoutte bien, en pressant doucement.
      'Rinse twice in cold water and drain well, pressing gently.',
      // FR: Porte à ébullition vinaigre, eau, sucre, curcuma et moutarde, puis jette les légumes dedans pour **1 minute** seulement.
      'Bring the vinegar, water, sugar, turmeric and mustard seeds to the boil, then tip the vegetables in for just **1 minute**.',
      // FR: Remplis des bocaux propres jusqu'à 2 cm du bord avec les légumes.
      'Fill clean jars with the vegetables, to 2 cm from the rim.',
      // FR: Verse le liquide chaud pour **tout recouvrir**, ferme, laisse refroidir et range au réfrigérateur. Bons dès le lendemain.
      'Pour in the hot liquid to **cover everything**, close, leave to cool and put in the fridge. They are good from the next day.',
    ],
  ),
  'courgette/Courgettes grillées à l\'huile et au citron': RecipeText(
    // FR: Courgettes grillées à l'huile et au citron
    name: 'Grilled courgettes in oil and lemon',
    // FR: Des lamelles grillées marinées au citron, à piocher pour les tartines et les salades de pâtes.
    description: 'Grilled strips marinated in lemon, to dip into for toast and pasta salads.',
    // FR: 2 semaines au réfrigérateur
    keeps: '2 weeks in the fridge',
    ingredients: <String>[
      '1.5 kg of courgettes', // FR: 1,5 kg de courgettes
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
      '40 cl of olive oil', // FR: 40 cl d'huile d'olive
      '1 teaspoon of dried thyme', // FR: 1 cuillère à café de thym séché
    ],
    steps: <String>[
      // FR: Lave les courgettes et coupe-les en lamelles de 5 mm dans la longueur.
      'Wash the courgettes and cut them lengthways into 5 mm strips.',
      // FR: Grille-les à sec sur une poêle-gril bien chaude, 2 à 3 minutes par face, jusqu'à de belles marques.
      'Griddle them dry in a very hot griddle pan, 2 to 3 minutes per side, until nicely marked.',
      // FR: Arrose-les encore chaudes de citron et sale-les : l'acidité aide à les garder.
      'Sprinkle them with lemon while still hot and add salt: the acidity helps them keep.',
      // FR: Range-les à plat dans des bocaux propres avec le thym **séché**, jamais d'herbes fraîches ni d'ail cru.
      'Lay them flat in clean jars with **dried** thyme, never fresh herbs or raw garlic.',
      // FR: Couvre d'huile d'olive jusqu'à 1 cm au-dessus, tasse pour chasser l'air, ferme et mets au réfrigérateur.
      'Cover with olive oil up to 1 cm above, tap the jar to chase out the air, close and put in the fridge.',
      // FR: Sors-les 20 minutes avant de manger pour que l'huile redevienne liquide. Toujours une fourchette propre.
      'Take them out 20 minutes before eating so the oil turns liquid again. Always use a clean fork.',
    ],
  ),
  'courgette/Beignets de fleurs de courgette': RecipeText(
    // FR: Beignets de fleurs de courgette
    name: 'Courgette flower fritters',
    // FR: Les fleurs mâles, en pâte légère, deux minutes dans l'huile.
    description: 'Male flowers in a light batter, two minutes in the oil.',
    ingredients: <String>[
      '12 male courgette flowers', // FR: 12 fleurs de courgette mâles
      '150 g of flour', // FR: 150 g de farine
      '20 cl of iced water or beer', // FR: 20 cl d'eau glacée ou de bière
      '1 pinch of salt', // FR: 1 pincée de sel
      'oil for frying', // FR: huile de friture
    ],
    steps: <String>[
      // FR: Cueille les fleurs mâles le matin, celles au bout d'une tige fine — les femelles portent la courgette.
      'Pick the male flowers in the morning, the ones on a thin stalk — the female ones carry the courgette.',
      // FR: Ouvre-les, retire le pistil, secoue-les sans les laver si elles sont propres.
      'Open them, remove the stamen, and shake them without washing if they are clean.',
      // FR: Mélange farine, eau glacée et sel. La pâte doit napper, pas coller.
      'Mix the flour, iced water and salt. The batter should be thin enough to coat, not clump.',
      // FR: Chauffe l'huile à 180 °C.
      'Heat the oil to 180 °C.',
      // FR: Trempe chaque fleur, plonge-la 2 minutes, retourne à mi-cuisson.
      'Dip each flower, lower it into the oil for 2 minutes, turning halfway through.',
      // FR: Égoutte sur du papier, sale tout de suite, mange tout de suite.
      'Drain on kitchen paper, salt straight away, eat straight away.',
    ],
  ),
  'courgette/Courgettes farcies': RecipeText(
    // FR: Courgettes farcies
    name: 'Stuffed courgettes',
    // FR: Tes courgettes garnies de riz et de viande hachée, gratinées au four.
    description: 'Your courgettes filled with rice and minced meat, baked until golden.',
    ingredients: <String>[
      '4 round or medium courgettes', // FR: 4 courgettes rondes ou moyennes
      '300 g of minced meat', // FR: 300 g de viande hachée
      '100 g of rice', // FR: 100 g de riz
      '1 onion, 1 garlic clove', // FR: 1 oignon, 1 gousse d'ail
      '1 egg, 50 g of parmesan', // FR: 1 oeuf, 50 g de parmesan
      'salt, pepper, herbs', // FR: sel, poivre, herbes
    ],
    steps: <String>[
      // FR: Préchauffe le four à 190 °C.
      'Preheat the oven to 190 °C.',
      // FR: Coupe les courgettes en deux, évide-les à la cuillère. Garde la chair.
      'Cut the courgettes in half and scoop them out with a spoon. Keep the flesh.',
      // FR: Cuis le riz 10 minutes, il finira au four.
      'Cook the rice for 10 minutes; it will finish cooking in the oven.',
      // FR: Fais revenir oignon, ail et la chair hachée, puis la viande.
      'Fry the onion, garlic and chopped courgette flesh, then add the meat.',
      // FR: Hors du feu, mélange avec le riz, l'oeuf, le parmesan, sel et poivre.
      'Off the heat, mix with the rice, egg, parmesan, salt and pepper.',
      // FR: Garnis les demi-courgettes, tasse bien.
      'Fill the courgette halves, packing the stuffing down well.',
      // FR: Au four 40 minutes, à couvert les 20 premières.
      'Bake for 40 minutes, covered for the first 20.',
    ],
  ),
  'courgette/Gratin de courgettes': RecipeText(
    // FR: Gratin de courgettes
    name: 'Courgette gratin',
    // FR: Des tranches fondantes sous une croûte dorée, le plat familial par excellence.
    description: 'Melting slices under a golden crust, the family dish par excellence.',
    ingredients: <String>[
      '1 kg of courgettes', // FR: 1 kg de courgettes
      '20 cl of cream', // FR: 20 cl de crème
      '2 eggs', // FR: 2 oeufs
      '100 g of grated gruyère', // FR: 100 g de gruyère râpé
      '1 garlic clove, salt, pepper, nutmeg', // FR: 1 gousse d'ail, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Coupe les courgettes en rondelles de 5 mm, sans les peler.
      'Cut the courgettes into 5 mm slices, without peeling them.',
      // FR: Sale-les et laisse-les dégorger 20 minutes : c'est ce qui évite le gratin à l'eau.
      'Salt them and leave them to draw out water for 20 minutes: this is what stops the gratin being watery.',
      // FR: Presse-les dans un torchon, puis fais-les suer 10 minutes à la poêle.
      'Squeeze them in a tea towel, then sweat them in a pan for 10 minutes.',
      // FR: Bats crème, oeufs, muscade, l'ail écrasé, sel et poivre.
      'Beat the cream, eggs, nutmeg, crushed garlic, salt and pepper.',
      // FR: Dans le plat : courgettes, appareil, fromage par-dessus.
      'In the dish: courgettes, the cream mixture, cheese on top.',
      // FR: Four à 180 °C, 30 minutes jusqu'à la croûte dorée.
      'Oven at 180 °C, 30 minutes, until the crust is golden.',
    ],
  ),

  // ─────────── cresson (6 recettes) ───────────
  'cresson/Pesto de cresson en glaçons': RecipeText(
    // FR: Pesto de cresson en glaçons
    name: 'Watercress pesto cubes',
    // FR: Poivré et vert vif, il se congèle en cubes à faire fondre sur des pâtes, un poisson ou dans une soupe.
    description: 'Peppery and bright green, it freezes in cubes to melt over pasta or fish, or into a soup.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '250 g of watercress', // FR: 250 g de cresson
      '50 g of walnuts', // FR: 50 g de noix
      '1 garlic clove', // FR: 1 gousse d'ail
      '12 cl of olive oil', // FR: 12 cl d'huile d'olive
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave le cresson dans plusieurs eaux, à l'eau froide, puis **sèche-le très bien** à l'essoreuse.
      'Wash the watercress in several changes of cold water, then **dry it very thoroughly** in a salad spinner.',
      // FR: Retire les plus grosses tiges, qui sont filandreuses.
      'Remove the thickest stalks, which are stringy.',
      // FR: Mixe cresson, noix et ail par à-coups, en versant l'huile en filet, sans faire chauffer le mixeur.
      'Blitz the watercress, walnuts and garlic in short bursts, pouring in the oil in a thin stream, without letting the blender heat up.',
      // FR: Sale et goûte. **Sans fromage** : il devient granuleux au congélateur.
      'Add salt and taste. **No cheese**: it turns grainy in the freezer.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile pour garder le vert.
      'Fill an ice cube tray and top each cell with a film of oil to keep the colour green.',
      // FR: Démoule les cubes une fois durs, au bout de 4 heures, et garde-les en sac daté.
      'Turn out the cubes once hard, after 4 hours, and keep them in a dated bag.',
    ],
  ),
  'cresson/Cresson blanchi en boulettes': RecipeText(
    // FR: Cresson blanchi en boulettes
    name: 'Blanched watercress balls',
    // FR: Trente secondes d'eau bouillante, et une récolte de cresson attend en boulettes vertes la prochaine soupe.
    description: 'Thirty seconds in boiling water, and a harvest of watercress waits as green balls for the next soup.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1 kg of watercress', // FR: 1 kg de cresson
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le cresson dans plusieurs eaux et retire les tiges dures et les feuilles jaunies.
      'Wash the watercress in several changes of water and remove the tough stalks and yellowed leaves.',
      // FR: Plonge-le dans une grande eau bouillante salée **30 secondes**, pas plus : il cuit en un instant.
      'Plunge it into a large pan of boiling salted water for **30 seconds**, no longer: it cooks in an instant.',
      // FR: Transfère-le aussitôt dans l'eau glacée pour fixer le vert.
      'Move it straight to the iced water to fix the green.',
      // FR: Presse-le fort en boule entre tes mains pour chasser toute l'eau.
      'Squeeze it hard into a ball between your hands to get all the water out.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque, puis mets-les en sac.
      'Shape portion-sized balls, freeze them for 2 hours on a tray, then put them in a bag.',
    ],
  ),
  'cresson/Sel vert au cresson': RecipeText(
    // FR: Sel vert au cresson
    name: 'Green watercress salt',
    // FR: Mixé avec du gros sel et séché, le cresson devient un sel poivré à garder dans un pot près des fourneaux.
    description: 'Blitzed with coarse salt and dried, watercress becomes a peppery salt to keep in a jar by the hob.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      '150 g of watercress leaves', // FR: 150 g de feuilles de cresson
      '300 g of grey coarse salt', // FR: 300 g de gros sel gris
      '3 small glass jars', // FR: 3 petits pots en verre
    ],
    steps: <String>[
      // FR: Lave le cresson et **sèche-le parfaitement** au torchon.
      'Wash the watercress and **dry it perfectly** with a tea towel.',
      // FR: Mixe les feuilles avec le gros sel jusqu'à obtenir un sable vert et humide.
      'Blitz the leaves with the coarse salt until you have a damp green sand.',
      // FR: Étale-le en couche fine sur une plaque garnie de papier cuisson et enfourne à 60 °C, porte entrouverte.
      'Spread it in a thin layer on a tray lined with baking paper and put it in the oven at 60 °C, door ajar.',
      // FR: Émiette-le à la fourchette toutes les heures pour casser les grumeaux. Il est prêt quand il coule entre les doigts.
      'Crumble it with a fork every hour to break up any lumps. It is ready when it runs through your fingers.',
      // FR: Laisse refroidir complètement, puis mets en pots fermés, à l'abri de la lumière qui le fait pâlir.
      'Leave it to cool completely, then put it in closed jars, away from the light, which makes it fade.',
    ],
  ),
  'cresson/Potage au cresson': RecipeText(
    // FR: Potage au cresson
    name: 'Watercress soup',
    // FR: Le classique : cresson, pomme de terre, crème.
    description: 'The classic: watercress, potato, cream.',
  ),
  'cresson/Salade de cresson aux agrumes': RecipeText(
    // FR: Salade de cresson aux agrumes
    name: 'Watercress and citrus salad',
    // FR: Le poivré du cresson contre l'acidité de l'orange.
    description: 'The pepperiness of watercress against the sharpness of orange.',
  ),
  'cresson/Beurre de cresson': RecipeText(
    // FR: Beurre de cresson
    name: 'Watercress butter',
    // FR: Haché dans du beurre pommade, sur un poisson chaud.
    description: 'Chopped into softened butter, for hot fish.',
  ),

  // ─────────── echalote (6 recettes) ───────────
  'echalote/Échalotes séchées en filet': RecipeText(
    // FR: Échalotes séchées en filet
    name: 'Dried shallots in a net',
    // FR: Bien ressuyées après la récolte, les échalotes grises tiennent souvent jusqu'au printemps suivant.
    description: 'Well dried after harvest, grey shallots will often last until the following spring.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 months in a dry place, out of the light',
    ingredients: <String>[
      '3 kg of freshly lifted shallots', // FR: 3 kg d'échalotes fraîchement arrachées
      'nets or slatted crates', // FR: des filets ou des cagettes ajourées
    ],
    steps: <String>[
      // FR: Arrache les touffes quand le feuillage jaunit et se couche. Laisse-les sur le sol un jour ou deux s'il fait sec.
      'Lift the clumps when the foliage yellows and flops over. Leave them on the ground for a day or two if it is dry.',
      // FR: Rentre-les dans un abri aéré et laisse-les sécher **2 semaines** en une seule couche, sans les entasser.
      'Bring them into an airy shelter and let them dry for **2 weeks** in a single layer, not piled up.',
      // FR: Sépare les bulbes, coupe les fanes sèches à 2 cm et les racines au ras.
      'Separate the bulbs, cut the dry tops to 2 cm and the roots right back.',
      // FR: Brosse la terre à sec, sans jamais les laver : l'humidité est leur pire ennemie.
      'Brush off the soil dry and never wash them: damp is their worst enemy.',
      // FR: Range-les en filets suspendus ou en cagettes, au frais et au sec. Trie-les tous les mois et utilise vite celles qui germent.
      'Store in hanging nets or in crates, somewhere cool and dry. Sort them every month and use up any that sprout quickly.',
    ],
  ),
  'echalote/Échalotes ciselées congelées': RecipeText(
    // FR: Échalotes ciselées congelées
    name: 'Frozen chopped shallots',
    // FR: Un quart d'heure de larmes une bonne fois, et tu as des échalotes ciselées prêtes pour chaque sauce.
    description: 'A quarter of an hour of tears, once and for all, and you have chopped shallots ready for every sauce.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '500 g of shallots', // FR: 500 g d'échalotes
      'an ice cube tray or small bags', // FR: un bac à glaçons ou des petits sachets
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les échalotes : 5 minutes au réfrigérateur avant, et elles piquent moins les yeux.
      'Peel the shallots: 5 minutes in the fridge first, and they sting your eyes less.',
      // FR: Cisèle-les finement, à la main ou au hachoir par à-coups pour ne pas en faire une purée.
      'Chop them finely, by hand or in a chopper in short bursts so you don\'t end up with a purée.',
      // FR: Répartis en petits tas sur une plaque, une cuillère à soupe par tas, et congèle 2 heures.
      'Spread them in small heaps on a tray, one tablespoon per heap, and freeze for 2 hours.',
      // FR: Passe-les dans un bocal ou un sac double, bien fermé : l'odeur voyage dans le congélateur.
      'Move them to a jar or a double bag, tightly closed: the smell travels in the freezer.',
      // FR: Utilise-les gelées, directement dans la poêle. Pour une vinaigrette crue, prends plutôt de l'échalote fraîche.
      'Use them frozen, straight into the pan. For a raw vinaigrette, use fresh shallot instead.',
    ],
  ),
  'echalote/Chutney d\'échalotes au balsamique': RecipeText(
    // FR: Chutney d'échalotes au balsamique
    name: 'Shallot and balsamic chutney',
    // FR: Cuites longuement avec sucre et vinaigre, elles font un condiment brun et brillant pour les fromages et les terrines.
    description: 'Cooked slowly with sugar and vinegar, they make a glossy brown condiment for cheese and terrines.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '1 kg of shallots', // FR: 1 kg d'échalotes
      '150 g of brown sugar', // FR: 150 g de sucre roux
      '15 cl of balsamic vinegar', // FR: 15 cl de vinaigre balsamique
      '15 cl of red wine vinegar at 6 %', // FR: 15 cl de vinaigre de vin rouge à 6 %
      '2 tablespoons of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      '1 sprig of thyme', // FR: 1 branche de thym
    ],
    steps: <String>[
      // FR: Épluche les échalotes et émince-les en fines lamelles.
      'Peel the shallots and slice them thinly.',
      // FR: Fais-les fondre à feu doux dans l'huile, à couvert, en remuant souvent. Elles doivent devenir translucides, pas brunes.
      'Soften them over a low heat in the oil, covered, stirring often. They should turn translucent, not brown.',
      // FR: Ajoute le sucre, les deux vinaigres et le thym, mélange bien.
      'Add the sugar, both vinegars and the thyme, and stir well.',
      // FR: Laisse cuire à découvert, à petits bouillons, en remuant de plus en plus souvent vers la fin.
      'Cook uncovered at a gentle bubble, stirring more and more often towards the end.',
      // FR: C'est prêt quand la cuillère laisse **un sillon** au fond de la casserole. Retire le thym.
      'It is ready when the spoon leaves **a trail** across the bottom of the pan. Remove the thyme.',
      // FR: Mets en pots ébouillantés, ferme, laisse refroidir et range au réfrigérateur.
      'Spoon into scalded jars, close, leave to cool and put in the fridge.',
    ],
  ),
  'echalote/Sauce échalote au vin rouge': RecipeText(
    // FR: Sauce échalote au vin rouge
    name: 'Shallot and red wine sauce',
    // FR: La sauce des steaks : des échalotes fondues dans le vin réduit.
    description: 'The steak sauce: shallots melted into reduced wine.',
    ingredients: <String>[
      '6 shallots', // FR: 6 échalotes
      '25 cl of red wine', // FR: 25 cl de vin rouge
      '40 g of cold butter', // FR: 40 g de beurre froid
      '1 teaspoon of sugar', // FR: 1 cuillère à café de sucre
      'thyme, salt, pepper', // FR: thym, sel, poivre
    ],
    steps: <String>[
      // FR: Hache les échalotes très finement.
      'Chop the shallots very finely.',
      // FR: Fais-les fondre dans un peu de beurre, 8 minutes, sans colorer.
      'Soften them in a little butter for 8 minutes, without letting them colour.',
      // FR: Verse le vin, le sucre, le thym, et laisse réduire des deux tiers.
      'Add the wine, sugar and thyme, and reduce by two thirds.',
      // FR: Hors du feu, incorpore le beurre **froid** en morceaux, en tournant : c'est ce qui lie et fait briller.
      'Off the heat, whisk in the **cold** butter in pieces: this is what binds the sauce and makes it shine.',
      // FR: Sel, poivre, et sers aussitôt.
      'Salt, pepper, and serve at once.',
    ],
  ),
  'echalote/Échalotes confites': RecipeText(
    // FR: Échalotes confites
    name: 'Confit shallots',
    // FR: Entières, au four, avec du vinaigre balsamique et du thym.
    description: 'Whole, in the oven, with balsamic vinegar and thyme.',
    ingredients: <String>[
      '500 g of shallots', // FR: 500 g d'échalotes
      '2 tablespoons of honey', // FR: 2 cuillères à soupe de miel
      '3 tablespoons of balsamic vinegar', // FR: 3 cuillères à soupe de vinaigre balsamique
      '2 tablespoons of oil', // FR: 2 cuillères à soupe d'huile
      'thyme, coarse salt', // FR: thym, gros sel
    ],
    steps: <String>[
      // FR: Pèle les échalotes en les gardant entières, racine coupée court.
      'Peel the shallots, keeping them whole, with the root cut short.',
      // FR: Mélange-les à l'huile, au miel, au vinaigre.
      'Toss them with the oil, honey and vinegar.',
      // FR: Four à 180 °C, 45 minutes, en remuant deux fois.
      'Oven at 180 °C for 45 minutes, stirring twice.',
      // FR: Elles doivent être tendres au couteau et luisantes. Bon chaud ou froid, avec une viande ou un fromage.
      'They should be tender to a knife and glossy. Good hot or cold, with meat or cheese.',
    ],
  ),
  'echalote/Vinaigrette à l\'échalote': RecipeText(
    // FR: Vinaigrette à l'échalote
    name: 'Shallot vinaigrette',
    // FR: L'échalote hachée adoucie par le vinaigre : la base de tout.
    description: 'Chopped shallot mellowed by vinegar: the base of everything.',
    ingredients: <String>[
      '2 shallots', // FR: 2 échalotes
      '3 tablespoons of wine vinegar', // FR: 3 cuillères à soupe de vinaigre de vin
      '1 teaspoon of mustard', // FR: 1 cuillère à café de moutarde
      '8 tablespoons of oil', // FR: 8 cuillères à soupe d'huile
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Hache les échalotes le plus fin possible.
      'Chop the shallots as finely as you can.',
      // FR: Laisse-les macérer 10 minutes dans le vinaigre salé : elles perdent leur agressivité.
      'Leave them to steep for 10 minutes in the salted vinegar: they lose their harshness.',
      // FR: Ajoute la moutarde, mélange.
      'Add the mustard and stir.',
      // FR: Huile en filet en fouettant. Se garde une semaine au frais.
      'Whisk in the oil in a thin stream. Keeps for a week in the fridge.',
    ],
  ),

  // ─────────── endive (6 recettes) ───────────
  'endive/Pickles d\'endives au cidre': RecipeText(
    // FR: Pickles d'endives au cidre
    name: 'Chicory pickled in cider vinegar',
    // FR: Ses feuilles croquantes et amères adorent le vinaigre doux : un condiment surprenant pour une raclette.
    description: 'Its crunchy, bitter leaves love a gentle vinegar: a surprising condiment for raclette.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 weeks in the fridge',
    ingredients: <String>[
      '6 heads of chicory', // FR: 6 endives
      '25 cl of cider vinegar at 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '2 tablespoons of sugar', // FR: 2 cuillères à soupe de sucre
      '1 teaspoon of fine salt', // FR: 1 cuillère à café de sel fin
      '1 teaspoon of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Retire les feuilles abîmées et creuse le petit cône amer à la base avec la pointe d'un couteau.
      'Remove any damaged leaves and cut out the small bitter cone at the base with the tip of a knife.',
      // FR: Coupe les endives en quartiers dans la longueur, ou en tronçons de 3 cm.
      'Cut the chicory lengthways into quarters, or crossways into 3 cm chunks.',
      // FR: Tasse-les dans les bocaux avec le poivre.
      'Pack them into the jars with the peppercorns.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement**, ferme et laisse refroidir, puis range au réfrigérateur.
      'Pour in boiling hot to **cover completely**, close and leave to cool, then put in the fridge.',
    ],
  ),
  'endive/Endives fondantes au beurre à congeler': RecipeText(
    // FR: Endives fondantes au beurre à congeler
    name: 'Buttery braised chicory for the freezer',
    // FR: Cuites doucement à couvert, elles se congèlent très bien et finissent en gratin ou en tarte en un rien de temps.
    description: 'Cooked gently under a lid, it freezes very well and ends up in a gratin or a tart in no time.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of chicory', // FR: 2 kg d'endives
      '40 g of butter', // FR: 40 g de beurre
      'the juice of half a lemon', // FR: le jus d'un demi-citron
      '1 teaspoon of sugar', // FR: 1 cuillère à café de sucre
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Retire le cône amer à la base et coupe les endives en deux dans la longueur.
      'Remove the bitter cone at the base and halve the chicory lengthways.',
      // FR: Fais fondre le beurre dans une grande cocotte et pose les endives à plat, face coupée dessous.
      'Melt the butter in a large casserole and lay the chicory flat, cut side down.',
      // FR: Arrose du jus de citron, saupoudre de sucre, sale. Le citron les garde blanches.
      'Sprinkle with the lemon juice and sugar, and add salt. The lemon keeps them white.',
      // FR: Couvre et laisse fondre à feu doux, sans ajouter d'eau : elles rendent la leur.
      'Cover and cook gently until soft, without adding water: they release their own.',
      // FR: Laisse refroidir dans leur jus, cocotte posée dans l'eau froide.
      'Leave to cool in their juices, with the casserole standing in cold water.',
      // FR: Répartis en boîtes avec le jus, à 2 cm du bord, et congèle. Elles iront tout droit au four sous une béchamel.
      'Divide into boxes with the juice, to 2 cm from the rim, and freeze. They go straight into the oven under a béchamel.',
    ],
  ),
  'endive/Endives blanchies au citron': RecipeText(
    // FR: Endives blanchies au citron
    name: 'Lemon-blanched chicory',
    // FR: Blanchies dans une eau citronnée, elles restent claires et prêtes à braiser sans repasser par la planche.
    description: 'Blanched in lemony water, it stays pale and ready to braise without going back to the chopping board.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '2 kg of chicory', // FR: 2 kg d'endives
      'the juice of one lemon', // FR: le jus d'un citron
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Retire le cône amer et coupe les endives en deux dans la longueur.
      'Remove the bitter cone and halve the chicory lengthways.',
      // FR: Ajoute le jus de citron et le gros sel à une grande casserole d'eau et porte à gros bouillons.
      'Add the lemon juice and coarse salt to a large pan of water and bring to a rolling boil.',
      // FR: Plonge les demi-endives **3 minutes**.
      'Lower the chicory halves in for **3 minutes**.',
      // FR: Transfère-les dans l'eau glacée, puis égoutte-les tête en bas dans une passoire.
      'Move them straight to the iced water, then drain them head down in a colander.',
      // FR: Presse-les doucement dans un torchon : une endive garde beaucoup d'eau entre ses feuilles.
      'Squeeze them gently in a tea towel: chicory holds a lot of water between its leaves.',
      // FR: Congèle-les à plat sur une plaque, puis mets-les en sacs.
      'Freeze them flat on a tray, then put them in bags.',
    ],
  ),
  'endive/Endives au jambon': RecipeText(
    // FR: Endives au jambon
    name: 'Chicory wrapped in ham',
    // FR: Braisées, roulées dans le jambon, nappées de béchamel.
    description: 'Braised, rolled in ham and covered in béchamel.',
  ),
  'endive/Salade d\'endives aux noix et bleu': RecipeText(
    // FR: Salade d'endives aux noix et bleu
    name: 'Chicory, walnut and blue cheese salad',
    // FR: L'amertume, le gras et le croquant : l'accord fonctionne toujours.
    description: 'Bitterness, richness and crunch: the combination always works.',
  ),
  'endive/Endives braisées au miel': RecipeText(
    // FR: Endives braisées au miel
    name: 'Honey-braised chicory',
    // FR: Le miel contre l'amertume, un filet de citron pour trancher.
    description: 'Honey against the bitterness, a squeeze of lemon to cut through.',
  ),

  // ─────────── epinard (6 recettes) ───────────
  'epinard/Palets d\'épinards blanchis': RecipeText(
    // FR: Palets d'épinards blanchis
    name: 'Blanched spinach pucks',
    // FR: Une minute dans l'eau bouillante, pressés en palets : tes épinards sont prêts pour une omelette ou un gratin.
    description: 'One minute in boiling water, pressed into pucks: your spinach is ready for an omelette or a gratin.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1.5 kg of spinach', // FR: 1,5 kg d'épinards
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les épinards en tirant sur la tige pour enlever la nervure.
      'Remove the stalks by pulling on each stem to strip out the rib.',
      // FR: Lave-les dans plusieurs eaux : le sable reste collé au revers des feuilles.
      'Wash in several changes of water: the grit sticks to the underside of the leaves.',
      // FR: Plonge-les par grosses poignées dans une grande eau bouillante salée.
      'Plunge them in big handfuls into a large pan of boiling salted water.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée : c'est ce qui **fixe le vert**.
      'Drain and plunge straight into the iced water: this is what **fixes the green**.',
      // FR: Presse-les en boule entre tes mains, vraiment fort, pour chasser l'eau.
      'Squeeze them into a ball between your hands, really hard, to get the water out.',
      // FR: Forme des palets d'une portion, congèle 2 heures sur une plaque, puis mets-les en sac.
      'Shape portion-sized pucks, freeze for 2 hours on a tray, then put them in a bag.',
    ],
  ),
  'epinard/Velouté d\'épinards à congeler': RecipeText(
    // FR: Velouté d'épinards à congeler
    name: 'Spinach soup for the freezer',
    // FR: Quand la planche monte en graines, tout finit en velouté vert : six portions prêtes pour l'hiver.
    description: 'When the bed runs to seed, everything ends up as green soup: six portions ready for winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '700 g of spinach', // FR: 700 g d'épinards
      '3 potatoes', // FR: 3 pommes de terre
      '1 onion', // FR: 1 oignon
      '1.2 litres of stock', // FR: 1,2 litre de bouillon
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Équeute et lave les épinards dans plusieurs eaux.
      'Remove the stalks and wash the spinach in several changes of water.',
      // FR: Épluche et coupe en dés pommes de terre et oignon.
      'Peel and dice the potatoes and onion.',
      // FR: Cuis-les dans le bouillon jusqu'à ce que les pommes de terre s'écrasent.
      'Cook them in the stock until the potatoes crush easily.',
      // FR: Ajoute les épinards et compte **2 minutes**, pas plus : au-delà, le vert tourne au kaki.
      'Add the spinach and count **2 minutes**, no more: any longer and the green turns khaki.',
      // FR: Mixe aussitôt hors du feu, sans crème. Tu l'ajouteras dans l'assiette.
      'Blend straight away, off the heat, with no cream. You can add it in the bowl.',
      // FR: Refroidis vite, casserole dans l'eau froide.
      'Cool quickly, with the pan standing in cold water.',
      // FR: Répartis en portions en laissant 2 cm de vide : ça gonfle en gelant. Note la date.
      'Divide into portions leaving 2 cm of space at the top, as it expands when it freezes. Write the date.',
    ],
  ),
  'epinard/Poudre d\'épinards': RecipeText(
    // FR: Poudre d'épinards
    name: 'Spinach powder',
    // FR: Séchés puis moulus, les épinards colorent pâtes fraîches, crêpes et purées tout l'hiver.
    description: 'Dried then ground, spinach colours fresh pasta, pancakes and purées all winter.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, out of the light',
    ingredients: <String>[
      '1 kg of spinach', // FR: 1 kg d'épinards
      'a very dry airtight jar', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Équeute les épinards et garde les feuilles saines.
      'Remove the stalks and keep the healthy leaves.',
      // FR: Lave-les et **sèche-les complètement** à l'essoreuse puis dans un torchon.
      'Wash them and **dry them completely**, first in a salad spinner and then in a tea towel.',
      // FR: Étale-les en une couche et sèche à **50 °C**, porte entrouverte, jusqu'à ce qu'elles s'émiettent.
      'Spread them in a single layer and dry at **50 °C**, door ajar, until they crumble.',
      // FR: Laisse refroidir complètement avant de mixer.
      'Leave to cool completely before blending.',
      // FR: Mixe en poudre fine et passe au tamis.
      'Blend to a fine powder and sift.',
      // FR: Mets en bocal hermétique, à l'abri de la lumière : elle perd sa couleur au jour.
      'Put it in an airtight jar, away from the light: it loses its colour in daylight.',
    ],
  ),
  'epinard/Épinards à la crème': RecipeText(
    // FR: Épinards à la crème
    name: 'Creamed spinach',
    // FR: Fondus en deux minutes, liés à la crème : l'accompagnement de base.
    description: 'Wilted in two minutes and bound with cream: the basic side dish.',
    ingredients: <String>[
      '1 kg of fresh spinach', // FR: 1 kg d'épinards frais
      '20 cl of cream', // FR: 20 cl de crème
      '20 g of butter', // FR: 20 g de beurre
      '1 garlic clove', // FR: 1 gousse d'ail
      'salt, pepper, nutmeg', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave les épinards dans beaucoup d'eau, deux fois, et équeute les grosses tiges.
      'Wash the spinach twice in plenty of water and remove the thick stalks.',
      // FR: Jette-les dans la sauteuse beurrée, par poignées : ils réduisent des trois quarts.
      'Add it by the handful to a buttered sauté pan: it reduces by three quarters.',
      // FR: Quand ils sont tombés, presse-les pour en sortir l'eau — sinon la crème ne tient pas.
      'Once it has wilted, squeeze it to get the water out — otherwise the cream won\'t hold.',
      // FR: Remets-les avec la crème, l'ail écrasé, sel, poivre, muscade.
      'Return it to the pan with the cream, crushed garlic, salt, pepper and nutmeg.',
      // FR: Laisse épaissir 5 minutes à feu doux.
      'Leave to thicken for 5 minutes over a low heat.',
    ],
  ),
  'epinard/Tarte aux épinards et feta': RecipeText(
    // FR: Tarte aux épinards et feta
    name: 'Spinach and feta tart',
    // FR: Le sel de la feta contre le vert des épinards, dans une pâte croustillante.
    description: 'The saltiness of the feta against the green of the spinach, in crisp pastry.',
    ingredients: <String>[
      '1 sheet of puff pastry', // FR: 1 pâte feuilletée
      '800 g of spinach', // FR: 800 g d'épinards
      '200 g of feta', // FR: 200 g de feta
      '2 eggs, 15 cl of cream', // FR: 2 oeufs, 15 cl de crème
      '1 onion, salt, pepper, nutmeg', // FR: 1 oignon, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Fais tomber les épinards à la poêle, puis presse-les.
      'Wilt the spinach in a pan, then squeeze it.',
      // FR: Fais blondir l'oignon émincé et mélange-le dedans.
      'Brown the sliced onion and mix it in.',
      // FR: Bats oeufs et crème, muscade, poivre. Pas de sel : la feta suffit.
      'Beat the eggs and cream with the nutmeg and pepper. No salt: the feta is enough.',
      // FR: Garnis la pâte des épinards, émiette la feta, verse l'appareil.
      'Fill the pastry case with the spinach, crumble the feta over it and pour on the egg mixture.',
      // FR: Four à 190 °C, 30 minutes.
      'Oven at 190 °C, 30 minutes.',
    ],
  ),
  'epinard/Épinards sautés à l\'ail': RecipeText(
    // FR: Épinards sautés à l'ail
    name: 'Garlic sautéed spinach',
    // FR: Trois minutes à feu vif : la cuisson qui garde la couleur.
    description: 'Three minutes over a high heat: the cooking that keeps the colour.',
    ingredients: <String>[
      '800 g of spinach', // FR: 800 g d'épinards
      '2 garlic cloves', // FR: 2 gousses d'ail
      '2 tablespoons of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      'salt, chilli, lemon', // FR: sel, piment, citron
    ],
    steps: <String>[
      // FR: Fais blondir l'ail émincé dans l'huile, sans le brûler.
      'Brown the sliced garlic in the oil, without burning it.',
      // FR: Monte le feu, jette les épinards essorés et remue sans arrêt.
      'Turn up the heat, add the well-drained spinach and stir constantly.',
      // FR: 3 minutes, pas plus : dès qu'ils sont tombés, c'est cuit.
      '3 minutes, no more: as soon as it has wilted, it is done.',
      // FR: Sel, une pointe de piment, un trait de citron.
      'Salt, a pinch of chilli, a squeeze of lemon.',
    ],
  ),

  // ─────────── estragon (6 recettes) ───────────
  'estragon/Beurre d\'estragon en rouleau': RecipeText(
    // FR: Beurre d'estragon en rouleau
    name: 'Tarragon butter log',
    // FR: L'estragon perd son anis au séchage ; enfermé dans le beurre et congelé, il le garde intact.
    description: 'Tarragon loses its aniseed flavour when dried; locked in butter and frozen, it keeps it intact.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '250 g of soft butter', // FR: 250 g de beurre mou
      '1 large bunch of tarragon', // FR: 1 gros bouquet d'estragon
      '1 shallot', // FR: 1 échalote
      '1 pinch of flaky sea salt', // FR: 1 pincée de fleur de sel
      'cling film', // FR: du film alimentaire
    ],
    steps: <String>[
      // FR: Lave et sèche l'estragon, puis effeuille-le : les tiges sont dures et amères.
      'Wash and dry the tarragon, then pick off the leaves: the stalks are tough and bitter.',
      // FR: Hache finement les feuilles et l'échalote.
      'Chop the leaves and the shallot finely.',
      // FR: Écrase le beurre mou à la fourchette avec l'estragon, l'échalote et le sel.
      'Mash the soft butter with a fork together with the tarragon, shallot and salt.',
      // FR: Pose-le sur le film, roule en boudin de 4 cm de diamètre et **serre bien les extrémités**.
      'Place it on the cling film, roll it into a log 4 cm across and **twist the ends tight**.',
      // FR: Congèle à plat. Tu couperas une rondelle encore gelée à poser sur une viande, un poisson ou des légumes vapeur.
      'Freeze flat. You can cut a slice while still frozen to put on meat, fish or steamed vegetables.',
    ],
  ),
  'estragon/Moutarde à l\'estragon': RecipeText(
    // FR: Moutarde à l'estragon
    name: 'Tarragon mustard',
    // FR: Des graines, du vinaigre et ton estragon : une moutarde à l'ancienne qui pique juste ce qu'il faut.
    description: 'Seeds, vinegar and your own tarragon: a wholegrain mustard with just the right kick.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '100 g of yellow and brown mustard seeds', // FR: 100 g de graines de moutarde jaunes et brunes
      '15 cl of cider vinegar at 6 % minimum', // FR: 15 cl de vinaigre de cidre à 6 % minimum
      '5 cl of water', // FR: 5 cl d'eau
      '1 small bunch of tarragon', // FR: 1 petit bouquet d'estragon
      '1 teaspoon of salt, 1 tablespoon of honey', // FR: 1 cuillère à café de sel, 1 cuillère à soupe de miel
    ],
    steps: <String>[
      // FR: Mets les graines dans un bocal et couvre-les du vinaigre et de l'eau. **Pas plus d'eau que de vinaigre.**
      'Put the seeds in a jar and cover them with the vinegar and water. **No more water than vinegar.**',
      // FR: Ferme et laisse gonfler 24 heures au réfrigérateur. Les graines boivent presque tout le liquide.
      'Close and leave to swell for 24 hours in the fridge. The seeds soak up almost all the liquid.',
      // FR: Effeuille et hache finement l'estragon.
      'Pick off and finely chop the tarragon.',
      // FR: Mixe la moitié des graines avec le sel et le miel, garde l'autre moitié entière pour le grain.
      'Blend half the seeds with the salt and honey, keeping the other half whole for texture.',
      // FR: Mélange tout avec l'estragon. Si c'est trop épais, ajoute un trait de vinaigre, jamais d'eau seule.
      'Mix everything with the tarragon. If it is too thick, add a splash of vinegar, never water on its own.',
      // FR: Tasse dans un pot propre, ferme et range au frais. Elle est très forte au début, puis s'adoucit en une semaine.
      'Pack into a clean jar, close and keep in the fridge. It is very strong at first, then mellows within a week.',
    ],
  ),
  'estragon/Estragon séché en bottes': RecipeText(
    // FR: Estragon séché en bottes
    name: 'Dried tarragon bunches',
    // FR: Pour la fin de saison, quand tu en as trop : moins parfumé que frais, mais parfait dans les sauces mijotées.
    description: 'For the end of the season, when you have too much: less fragrant than fresh, but perfect in slow-cooked sauces.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, out of the light',
    ingredients: <String>[
      'tarragon stems cut before flowering', // FR: des tiges d'estragon coupées avant la floraison
      'string', // FR: de la ficelle
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges en fin de matinée, rosée évaporée, juste avant que la plante ne fleurisse.
      'Cut the stems late in the morning, once the dew has dried, just before the plant flowers.',
      // FR: Ne les lave pas si elles sont propres. Lie-les en petites bottes lâches, l'air doit circuler au milieu.
      'Don\'t wash them if they are clean. Tie them in small loose bunches: the air has to circulate through the middle.',
      // FR: Suspends-les tête en bas dans un endroit **sombre, sec et aéré**, une dizaine de jours. Au soleil, elles perdent leur parfum.
      'Hang them upside down somewhere **dark, dry and airy** for about ten days. In the sun they lose their fragrance.',
      // FR: Les feuilles sont prêtes quand elles cassent net sous les doigts.
      'The leaves are ready when they snap cleanly between your fingers.',
      // FR: Égrène-les entières dans un bocal, et émiette-les seulement au moment de cuisiner.
      'Strip them whole into a jar and crumble them only when you cook.',
    ],
  ),
  'estragon/Sauce béarnaise': RecipeText(
    // FR: Sauce béarnaise
    name: 'Béarnaise sauce',
    // FR: Réduction au vinaigre et à l'estragon, montée au beurre.
    description: 'A vinegar and tarragon reduction, whisked up with butter.',
  ),
  'estragon/Poulet à l\'estragon': RecipeText(
    // FR: Poulet à l'estragon
    name: 'Tarragon chicken',
    // FR: Crème et estragon, un classique qui ne vieillit pas.
    description: 'Cream and tarragon, a classic that never ages.',
  ),
  'estragon/Vinaigre à l\'estragon': RecipeText(
    // FR: Vinaigre à l'estragon
    name: 'Tarragon vinegar',
    // FR: Une branche dans la bouteille, trois semaines.
    description: 'A sprig in the bottle, three weeks.',
  ),

  // ─────────── fenouil (6 recettes) ───────────
  'fenouil/Pickles de fenouil à l\'orange': RecipeText(
    // FR: Pickles de fenouil à l'orange
    name: 'Orange fennel pickles',
    // FR: Tranché fin et mariné, le fenouil garde son croquant anisé et devient un condiment frais pour le poisson.
    description: 'Thinly sliced and marinated, fennel keeps its aniseed crunch and becomes a fresh condiment for fish.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      '3 fennel bulbs', // FR: 3 bulbes de fenouil
      'the zest of one orange', // FR: le zeste d'une orange
      '25 cl of cider vinegar at 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '2 tablespoons of sugar', // FR: 2 cuillères à soupe de sucre
      '1 teaspoon of fine salt', // FR: 1 cuillère à café de sel fin
    ],
    steps: <String>[
      // FR: Rince les bulbes, retire la première couche si elle est fibreuse et garde les plumets.
      'Rinse the bulbs, remove the outer layer if it is fibrous and keep the fronds.',
      // FR: Coupe le fenouil en deux et tranche-le très finement, à la mandoline si tu en as une.
      'Halve the fennel and slice it very thinly, with a mandoline if you have one.',
      // FR: Tasse les lamelles dans les bocaux avec le zeste d'orange en rubans et quelques plumets.
      'Pack the slices into the jars with the orange zest in ribbons and a few fronds.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Bring the vinegar, water, sugar and salt to the boil.',
      // FR: Verse bouillant pour **couvrir entièrement** le fenouil, ferme et laisse refroidir avant de mettre au réfrigérateur.
      'Pour in boiling hot to **cover the fennel completely**, close and leave to cool before putting in the fridge.',
    ],
  ),
  'fenouil/Lamelles de fenouil blanchies': RecipeText(
    // FR: Lamelles de fenouil blanchies
    name: 'Blanched fennel slices',
    // FR: Blanchi trois minutes, il est prêt pour un braisé ou un gratin, même hors saison.
    description: 'Blanched for three minutes, it is ready for braising or a gratin, even out of season.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '6 fennel bulbs', // FR: 6 bulbes de fenouil
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les tiges et la base, puis taille les bulbes en lamelles d'un centimètre ou en huit quartiers.
      'Cut off the stalks and the base, then cut the bulbs into slices one centimetre thick, or into eight wedges.',
      // FR: Plonge-les dans une grande eau salée bouillante, **3 minutes**.
      'Plunge them into a large pan of boiling salted water for **3 minutes**.',
      // FR: Transfère-les aussitôt dans l'eau glacée, jusqu'à ce qu'elles soient froides à cœur.
      'Move them straight to the iced water until they are cold right through.',
      // FR: Égoutte et sèche-les dans un torchon, en les tamponnant bien.
      'Drain and dry them in a tea towel, patting them well.',
      // FR: Étale sur une plaque, congèle 2 heures, puis mets en sacs. Décongelé, il est tendre : à cuire, pas à croquer cru.
      'Spread on a tray, freeze for 2 hours, then put in bags. Thawed, it is tender: for cooking, not for eating raw and crunchy.',
    ],
  ),
  'fenouil/Fenouil fermenté au citron': RecipeText(
    // FR: Fenouil fermenté au citron
    name: 'Lemon fermented fennel',
    // FR: En saumure, le fenouil prend une acidité douce qui calme son anis, avec un parfum de citron.
    description: 'In brine, fennel takes on a gentle sourness that calms its aniseed, with a scent of lemon.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '3 fennel bulbs', // FR: 3 bulbes de fenouil
      '1 unwaxed lemon', // FR: 1 citron non traité
      '1 litre of chlorine-free water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '1 teaspoon of peppercorns', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Prépare la saumure : **30 g de sel dans 1 litre d'eau**, remue jusqu'à dissolution.
      'Make the brine: **30 g of salt in 1 litre of water**, stirring until dissolved.',
      // FR: Taille le fenouil en lamelles épaisses de 5 mm et le citron en fines rondelles.
      'Cut the fennel into slices 5 mm thick and the lemon into thin rounds.',
      // FR: Tasse les lamelles dans un bocal en glissant les rondelles de citron et le poivre, jusqu'à 3 cm du bord.
      'Pack the slices into a jar, slipping in the lemon rounds and the peppercorns, up to 3 cm from the rim.',
      // FR: Verse la saumure pour couvrir et pose un poids : **rien ne doit dépasser**, c'est ce qui dépasse qui moisit.
      'Pour in the brine to cover and put a weight on top: **nothing must poke out**, because whatever pokes out goes mouldy.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer. Goûte à partir du dixième jour.
      'Leave to ferment for 2 weeks at 18–22 °C, with the lid resting on without being tightened. Start tasting from the tenth day.',
      // FR: Quand l'acidité te plaît, ferme bien et range au réfrigérateur.
      'When the sourness suits you, close tightly and put in the fridge.',
    ],
  ),
  'fenouil/Fenouil braisé à l\'orange': RecipeText(
    // FR: Fenouil braisé à l'orange
    name: 'Orange-braised fennel',
    // FR: L'orange contre l'anis du fenouil : un accord évident.
    description: 'Orange against the aniseed of fennel: an obvious pairing.',
    ingredients: <String>[
      '4 fennel bulbs', // FR: 4 bulbes de fenouil
      '2 oranges', // FR: 2 oranges
      '2 tablespoons of olive oil', // FR: 2 cuillères à soupe d'huile d'olive
      '1 teaspoon of honey', // FR: 1 cuillère à café de miel
      'salt, pepper, fennel seeds', // FR: sel, poivre, graines de fenouil
    ],
    steps: <String>[
      // FR: Coupe les bulbes en quartiers, garde un peu de coeur pour les tenir.
      'Cut the bulbs into wedges, keeping a little of the core to hold them together.',
      // FR: Fais-les colorer à l'huile sur les deux faces.
      'Brown them in the oil on both sides.',
      // FR: Verse le jus des oranges, le miel, les graines, sale.
      'Pour in the orange juice and honey, add the seeds and salt.',
      // FR: Couvre et braise 30 minutes à feu doux.
      'Cover and braise for 30 minutes over a low heat.',
      // FR: Découvre 5 minutes pour faire réduire le jus en sirop.
      'Uncover for 5 minutes to reduce the juice to a syrup.',
    ],
  ),
  'fenouil/Salade de fenouil cru': RecipeText(
    // FR: Salade de fenouil cru
    name: 'Raw fennel salad',
    // FR: Tranché à la mandoline, citron et huile : croquant et net.
    description: 'Sliced on a mandoline, with lemon and oil: crunchy and clean.',
    ingredients: <String>[
      '2 fennel bulbs', // FR: 2 bulbes de fenouil
      '1 lemon', // FR: 1 citron
      '4 tablespoons of olive oil', // FR: 4 cuillères à soupe d'huile d'olive
      'parmesan shavings', // FR: parmesan en copeaux
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Tranche le fenouil le plus fin possible, en travers du bulbe.
      'Slice the fennel as thinly as you can, across the bulb.',
      // FR: Arrose aussitôt de citron : il noircit sinon, comme une pomme.
      'Sprinkle with lemon at once: otherwise it goes brown, like an apple.',
      // FR: Huile, sel, poivre, mélange.
      'Oil, salt, pepper, and toss.',
      // FR: Copeaux de parmesan dessus, et les petites plumes du fenouil.
      'Parmesan shavings on top, and the little feathery fronds of the fennel.',
    ],
  ),
  'fenouil/Fenouil gratiné': RecipeText(
    // FR: Fenouil gratiné
    name: 'Fennel gratin',
    // FR: Précuit puis gratiné à la crème : il devient tout doux.
    description: 'Par-cooked then baked with cream, it turns meltingly soft.',
    ingredients: <String>[
      '4 fennel bulbs', // FR: 4 bulbes de fenouil
      '20 cl of cream', // FR: 20 cl de crème
      '80 g of parmesan', // FR: 80 g de parmesan
      '2 tablespoons of breadcrumbs', // FR: 2 cuillères à soupe de chapelure
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Cuis les bulbes coupés en deux 20 minutes à l'eau salée.
      'Cook the halved bulbs in salted water for 20 minutes.',
      // FR: Égoutte-les bien, pose-les dans le plat.
      'Drain them well and lay them in the dish.',
      // FR: Nappe de crème, sel, poivre.
      'Pour over the cream, with salt and pepper.',
      // FR: Parmesan et chapelure par-dessus.
      'Parmesan and breadcrumbs on top.',
      // FR: Four à 200 °C, 25 minutes.
      'Oven at 200 °C, 25 minutes.',
    ],
  ),

  // ─────────── feve (6 recettes) ───────────
  'feve/Fèves écossées blanchies': RecipeText(
    // FR: Fèves écossées blanchies
    name: 'Blanched shelled broad beans',
    // FR: Blanchies trois minutes et congelées, elles se dérobent en un geste quand tu les sors en hiver.
    description: 'Blanched for three minutes and frozen, they slip out of their skins in a single move when you take them out in winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '3 kg of broad beans in their pods (about 1 kg shelled)', // FR: 3 kg de fèves en cosses (environ 1 kg écossées)
      'coarse salt', // FR: gros sel
      'a large bowl of water and ice cubes', // FR: un grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les fèves. Garde les petites et les moyennes, les grosses farineuses iront en purée.
      'Shell the beans. Keep the small and medium ones; the big floury ones are for purée.',
      // FR: Plonge-les dans une grande eau salée bouillante, **3 minutes**.
      'Plunge them into a large pan of boiling salted water for **3 minutes**.',
      // FR: Transfère-les dans l'eau glacée, puis égoutte.
      'Move them to the iced water, then drain.',
      // FR: Si tu as le temps, retire la peau maintenant en pinçant le bout. Sinon, congèle-les avec, elle partira encore mieux après.
      'If you have time, remove the skins now by pinching the end. Otherwise freeze them with the skins on, which will come off even more easily afterwards.',
      // FR: Sèche-les, étale-les sur une plaque, congèle, puis mets en sacs.
      'Dry them, spread them on a tray, freeze, then put in bags.',
    ],
  ),
  'feve/Fèves sèches pour l\'hiver': RecipeText(
    // FR: Fèves sèches pour l'hiver
    name: 'Dried broad beans for winter',
    // FR: Laissées mûrir sur pied, elles se gardent au placard et font une soupe épaisse ou des falafels en plein hiver.
    description: 'Left to ripen on the plant, they keep in the cupboard and make a thick soup or falafels in the depths of winter.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 years in a dry place, out of the light',
    ingredients: <String>[
      'late-season pods, blackened on the plant', // FR: les cosses de fin de saison, noircies sur pied
      'very dry jars', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Laisse les dernières cosses sur les pieds jusqu'à ce qu'elles soient **noires et sèches**.
      'Leave the last pods on the plants until they are **black and dry**.',
      // FR: Cueille-les par temps sec et écosse-les. Écarte les graines percées ou moisies.
      'Pick them in dry weather and shell them. Discard any beans with holes or mould.',
      // FR: Étale les fèves en une couche sur un plateau, à l'air et à l'abri, et laisse-les finir de sécher 2 semaines.
      'Spread the beans in a single layer on a tray, in the open air but under cover, and leave them to finish drying for 2 weeks.',
      // FR: Passe-les 48 heures au congélateur pour tuer les éventuels œufs de bruches.
      'Put them in the freezer for 48 hours to kill any bean weevil eggs.',
      // FR: Mets-les en bocaux fermés. Pour les manger : trempage une nuit, puis cuisson 1 h 30 environ, **toujours bien cuites**.
      'Put them in closed jars. To eat them: soak overnight, then cook for about 1 h 30, **always thoroughly cooked**.',
    ],
  ),
  'feve/Falafels de fèves crus à congeler': RecipeText(
    // FR: Falafels de fèves crus à congeler
    name: 'Raw broad bean falafels for the freezer',
    // FR: Les ta'ameya égyptiens : formés crus et congelés, ils vont tout droit du congélateur à la friture.
    description: 'Egyptian ta\'ameya: shaped raw and frozen, they go straight from the freezer to the fryer.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      '500 g of dried broad beans, split and peeled', // FR: 500 g de fèves sèches cassées et pelées
      '1 onion', // FR: 1 oignon
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 bunch of parsley and 1 of coriander', // FR: 1 bouquet de persil et 1 de coriandre
      '1 tablespoon of cumin, 1 teaspoon of salt', // FR: 1 cuillère à soupe de cumin, 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: La veille, fais tremper les fèves sèches dans un grand volume d'eau froide, 12 heures. Égoutte-les bien.
      'The day before, soak the dried beans in a large amount of cold water for 12 hours. Drain them well.',
      // FR: Mixe-les crues avec l'oignon, l'ail, les herbes, le cumin et le sel, jusqu'à une pâte granuleuse qui se tient.
      'Blend them raw with the onion, garlic, herbs, cumin and salt, to a grainy paste that holds together.',
      // FR: Laisse reposer la pâte au réfrigérateur, elle se raffermit.
      'Leave the paste to rest in the fridge, where it firms up.',
      // FR: Forme des boulettes aplaties avec deux cuillères ou les mains mouillées.
      'Shape into flattened balls with two spoons or with wet hands.',
      // FR: Congèle-les sur une plaque sans qu'elles se touchent, puis mets-les en sac.
      'Freeze them on a tray without touching, then put them in a bag.',
      // FR: Fais-les frire **encore gelées** à 170 °C, 5 à 6 minutes, jusqu'à ce qu'elles soient bien brunes et cuites à cœur.
      'Fry them **still frozen** at 170 °C for 5 to 6 minutes, until well browned and cooked through.',
    ],
  ),
  'feve/Fèves à la croque-sel': RecipeText(
    // FR: Fèves à la croque-sel
    name: 'Broad beans with salt',
    // FR: Jeunes et tendres, écossées et croquées crues. Le printemps.
    description: 'Young and tender, shelled and eaten raw. Spring.',
  ),
  'feve/Purée de fèves au cumin': RecipeText(
    // FR: Purée de fèves au cumin
    name: 'Broad bean and cumin purée',
    // FR: Épluchées deux fois, écrasées à l'huile d'olive.
    description: 'Shelled and then skinned, crushed with olive oil.',
  ),
  'feve/Fèves au chorizo': RecipeText(
    // FR: Fèves au chorizo
    name: 'Broad beans with chorizo',
    // FR: Mijotées avec du chorizo et des oignons nouveaux.
    description: 'Simmered with chorizo and spring onions.',
  ),

  // ─────────── figuier (6 recettes) ───────────
  'figuier/Figues séchées au four': RecipeText(
    // FR: Figues séchées au four
    name: 'Oven-dried figs',
    // FR: Un figuier donne tout en trois semaines : séchées, les figues durent jusqu'à Noël et au-delà.
    description: 'A fig tree gives everything in three weeks: dried, the figs last until Christmas and beyond.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '2 kg of very ripe figs that haven\'t split', // FR: 2 kg de figues bien mûres mais pas éclatées
      'oven racks', // FR: des grilles de four
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Rince les figues délicatement et sèche-les sur un torchon.
      'Rinse the figs gently and dry them on a tea towel.',
      // FR: Coupe la queue et ouvre chaque figue en deux dans la hauteur.
      'Cut off the stalk and halve each fig lengthways.',
      // FR: Pose-les côté chair vers le haut sur des grilles et sèche au four à **60 °C**, porte entrouverte.
      'Lay them cut side up on racks and dry in the oven at **60 °C**, door held ajar.',
      // FR: Teste : la figue est souple, un peu collante, et la chair ne rend plus de jus quand tu la presses.
      'Test: the fig is supple, a little sticky, and the flesh no longer gives off juice when you press it.',
      // FR: Laisse refroidir et mets en bocal. Secoue chaque jour une semaine : de la buée, et c'est retour au four.
      'Leave to cool and put in jars. Shake them each day for a week: if you see condensation, back in the oven they go.',
    ],
  ),
  'figuier/Figues entières congelées': RecipeText(
    // FR: Figues entières congelées
    name: 'Whole frozen figs',
    // FR: Dix minutes et c'est fait : elles ressortent parfaites pour une compote, un gâteau ou un chutney.
    description: 'Ten minutes and it\'s done: they come out perfect for a compote, a cake or a chutney.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of ripe figs', // FR: 2 kg de figues mûres
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les figues délicatement et sèche-les bien sur un torchon.
      'Rinse the figs gently and dry them well on a tea towel.',
      // FR: Coupe juste le bout de la queue. Garde-les entières, ou en deux si elles sont grosses.
      'Cut off just the tip of the stalk. Keep them whole, or halved if they are big.',
      // FR: Pose-les sur une plaque sans qu'elles se touchent et congèle 3 heures.
      'Lay them on a tray without touching and freeze for 3 hours.',
      // FR: Verse-les en sac une fois dures. Décongelées elles sont molles : **à cuire**, pas à servir crues.
      'Tip them into a bag once hard. Thawed they are soft: **for cooking**, not for serving raw.',
    ],
  ),
  'figuier/Chutney de figues aux oignons': RecipeText(
    // FR: Chutney de figues aux oignons
    name: 'Fig and onion chutney',
    // FR: Sucré, acidulé, un peu épicé : le pot qui accompagne le fromage et les terrines tout l'hiver.
    description: 'Sweet, tangy, a little spicy: the jar that goes with cheese and terrines all winter.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1 kg of figs', // FR: 1 kg de figues
      '2 onions', // FR: 2 oignons
      '250 g of brown sugar', // FR: 250 g de sucre roux
      '25 cl of cider vinegar', // FR: 25 cl de vinaigre de cidre
      '1 teaspoon of grated ginger, 1 teaspoon of salt', // FR: 1 cuillère à café de gingembre râpé, 1 cuillère à café de sel
      '5 jars with new lids', // FR: 5 pots avec couvercles neufs
    ],
    steps: <String>[
      // FR: Coupe les figues en quatre et émince finement les oignons.
      'Cut the figs into quarters and slice the onions thinly.',
      // FR: Mets tout dans une casserole à fond épais : figues, oignons, sucre, vinaigre, gingembre et sel.
      'Put everything in a heavy-based pan: figs, onions, sugar, vinegar, ginger and salt.',
      // FR: Laisse cuire à petit feu, à découvert, en remuant souvent : le chutney est prêt quand la cuillère laisse un sillon au fond.
      'Cook gently, uncovered, stirring often: the chutney is ready when the spoon leaves a trail across the bottom.',
      // FR: Remplis les pots propres de chutney bouillant **jusqu'à 2 cm du bord** et ferme avec des couvercles neufs.
      'Fill clean jars with boiling chutney **to 2 cm from the rim** and close with new lids.',
      // FR: Stérilise les pots couverts d'eau, 20 minutes à partir de l'ébullition, et vérifie le vide en refroidissant.
      'Sterilise the jars completely covered in water, 20 minutes from the moment it boils, and check the vacuum as they cool.',
      // FR: Attends au moins 3 semaines avant d'ouvrir : le vinaigre s'adoucit et les goûts se marient.
      'Wait at least 3 weeks before opening: the vinegar mellows and the flavours marry.',
    ],
  ),
  'figuier/Figues rôties au miel': RecipeText(
    // FR: Figues rôties au miel
    name: 'Honey-roasted figs',
    // FR: Ouvertes en croix, dix minutes de four, avec du chèvre.
    description: 'Cut open in a cross, ten minutes in the oven, with goat\'s cheese.',
  ),
  'figuier/Confiture de figues': RecipeText(
    // FR: Confiture de figues
    name: 'Fig jam',
    // FR: Avec un citron entier confit dedans.
    description: 'With a whole lemon cooked down into it.',
  ),
  'figuier/Tarte aux figues et romarin': RecipeText(
    // FR: Tarte aux figues et romarin
    name: 'Fig and rosemary tart',
    // FR: Le romarin du jardin, posé entier sur la tarte.
    description: 'Rosemary from the garden, laid whole on the tart.',
  ),

  // ─────────── fonio (6 recettes) ───────────
  'fonio/Fonio séché et battu': RecipeText(
    // FR: Fonio séché et battu
    name: 'Dried and threshed fonio',
    // FR: Ce tout petit grain se garde des années s'il est bien sec : c'est la première chose à faire après la récolte.
    description: 'This tiny grain keeps for years if it is properly dry: it is the first thing to do after the harvest.',
    // FR: 2 ans au sec, à l'abri des insectes
    keeps: '2 years in a dry place, away from insects',
    ingredients: <String>[
      'bundles of fonio cut when ripe', // FR: les bottes de fonio coupées à maturité
      'a tarpaulin or a clean sheet', // FR: une bâche ou un drap propre
      'airtight sacks or drums', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Fauche le fonio quand les épillets sont dorés et que le grain se détache sous le doigt. Fais des bottes.
      'Cut the fonio when the spikelets are golden and the grain comes away under your finger. Make it into bundles.',
      // FR: Laisse sécher les bottes debout ou étalées au soleil une semaine, rentrées le soir.
      'Leave the bundles to dry standing up or spread out in the sun for a week, brought in at night.',
      // FR: Teste : le grain sonne sec et s'égrène facilement entre les doigts.
      'Test: the grain sounds dry and rubs off easily between your fingers.',
      // FR: Bats les bottes sur la bâche ou foule-les au pied pour faire tomber le grain.
      'Beat the bundles on the tarpaulin or tread them underfoot to knock the grain out.',
      // FR: Vanne doucement : le grain est si léger qu'il faut verser de peu haut, par vent faible.
      'Winnow gently: the grain is so light that you must pour from only a little height, in a light wind.',
      // FR: Stocke le grain vêtu dans des sacs hermétiques, au frais et au sec. Tu le décortiqueras au fur et à mesure.
      'Store the grain in its husk in airtight sacks, somewhere cool and dry. You will hull it as you go.',
    ],
  ),
  'fonio/Fonio précuit séché': RecipeText(
    // FR: Fonio précuit séché
    name: 'Dried pre-cooked fonio',
    // FR: Lavé, cuit une fois à la vapeur puis séché : il se prépare ensuite en cinq minutes, comme le fonio du commerce.
    description: 'Washed, steamed once and then dried, it is then ready in five minutes, like shop-bought fonio.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 months in a dry place, out of the light',
    ingredients: <String>[
      '1 kg of hulled fonio', // FR: 1 kg de fonio décortiqué
      'water', // FR: de l'eau
      'a couscous steamer', // FR: un couscoussier
      'an airtight jar', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Lave le fonio dans un grand saladier, au moins **trois eaux**, en le laissant décanter : le sable reste au fond, verse le grain par-dessus.
      'Wash the fonio in a large bowl, in at least **three changes of water**, letting it settle each time: the sand stays at the bottom, so pour the grain off over the top.',
      // FR: Égoutte-le dans un tissu fin et laisse-le gonfler 15 minutes.
      'Drain it in a fine cloth and leave it to swell for 15 minutes.',
      // FR: Cuis-le à la vapeur dans le haut du couscoussier, sans couvercle.
      'Steam it in the top of the couscous steamer, without a lid.',
      // FR: Égrène-le à la fourchette pour casser toutes les mottes.
      'Fluff it with a fork to break up all the lumps.',
      // FR: Étale-le en couche fine et sèche au four à 50 °C, porte entrouverte, en remuant de temps en temps.
      'Spread it in a thin layer and dry in the oven at 50 °C, door ajar, stirring from time to time.',
      // FR: Quand il coule entre les doigts comme du sable sec, mets-le en bocal hermétique.
      'When it runs through your fingers like dry sand, put it in an airtight jar.',
    ],
  ),
  'fonio/Fonio vapeur en portions congelées': RecipeText(
    // FR: Fonio vapeur en portions congelées
    name: 'Steamed fonio in frozen portions',
    // FR: Une grande vapeur le dimanche, et tout le mois des portions qui se réchauffent en trois minutes.
    description: 'One big steaming on Sunday, and all month long you have portions that reheat in three minutes.',
    // FR: 4 mois au congélateur
    keeps: '4 months in the freezer',
    ingredients: <String>[
      '500 g of hulled fonio', // FR: 500 g de fonio décortiqué
      '1 tablespoon of oil', // FR: 1 cuillère à soupe d'huile
      '1 pinch of salt', // FR: 1 pincée de sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le fonio dans au moins trois eaux, en le laissant décanter pour laisser le sable au fond.
      'Wash the fonio in at least three changes of water, letting it settle so the sand stays at the bottom.',
      // FR: Cuis-le à la vapeur dans le couscoussier, sans couvercle.
      'Steam it in the couscous steamer, without a lid.',
      // FR: Verse-le dans un plat, ajoute l'huile et le sel, et égrène à la fourchette.
      'Tip it into a dish, add the oil and salt, and fluff with a fork.',
      // FR: Laisse refroidir complètement à plat, en remuant pour qu'il ne colle pas.
      'Leave to cool completely, spread flat, stirring so it doesn\'t stick.',
      // FR: Répartis en sacs à plat, une portion par sac, et chasse l'air.
      'Divide into flat bags, one portion per bag, and press out the air.',
      // FR: Réchauffe-le encore gelé 3 minutes à la vapeur ou à la poêle avec une cuillère d'eau.
      'Reheat it still frozen for 3 minutes in a steamer, or in a pan with a spoonful of water.',
    ],
  ),
  'fonio/Fonio aux légumes': RecipeText(
    // FR: Fonio aux légumes
    name: 'Fonio with vegetables',
    // FR: Cuit à la vapeur, grains détachés, avec les légumes du jour.
    description: 'Steamed, with separate grains, with the vegetables of the day.',
  ),
  'fonio/Couscous de fonio': RecipeText(
    // FR: Couscous de fonio
    name: 'Fonio couscous',
    // FR: La petite graine dorée cuite vapeur, légère et délicate, fierté du Fouta.
    description: 'The little golden grain, steamed, light and delicate, the pride of the Fouta.',
  ),
  'fonio/Djouka de fonio': RecipeText(
    // FR: Djouka de fonio
    name: 'Fonio djouka',
    // FR: Le fonio à la poudre d'arachide, un délice malien simple et parfumé.
    description: 'Fonio with peanut powder, a simple and fragrant Malian delight.',
  ),

  // ─────────── fraise (5 recettes) ───────────
  'fraise/Confiture de fraises': RecipeText(
    // FR: Confiture de fraises
    name: 'Strawberry jam',
    // FR: Poids pour poids avec le sucre, un citron, et la cuisine sent l'été.
    description: 'Weight for weight with the sugar, a lemon, and the kitchen smells of summer.',
    // FR: 2 ans au placard
    keeps: '2 years in the cupboard',
    ingredients: <String>[
      '1 kg of hulled strawberries', // FR: 1 kg de fraises équeutées
      '700 g of sugar', // FR: 700 g de sucre
      'the juice of one lemon', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Coupe les grosses fraises en deux, laisse les petites entières.
      'Halve the big strawberries and leave the small ones whole.',
      // FR: Mélange-les au sucre et au citron, laisse macérer au frais. Le jus sort tout seul.
      'Mix them with the sugar and lemon and leave to macerate somewhere cool. The juice comes out by itself.',
      // FR: Porte à ébullition et cuis à feu vif en écumant.
      'Bring to the boil and cook over a high heat, skimming.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. Le citron apporte la pectine qui fait prendre.
      'Test on a cold plate: a drop that sets is ready. The lemon provides the pectin that makes it set.',
      // FR: Mets en pots chauds, ferme et retourne jusqu'à refroidissement.
      'Pour into hot jars, close and turn upside down until cool.',
    ],
  ),
  'fraise/Fraises congelées sur plaque': RecipeText(
    // FR: Fraises congelées sur plaque
    name: 'Tray-frozen strawberries',
    // FR: Un quart d'heure, et tu as des fraises qui ne forment pas un bloc.
    description: 'A quarter of an hour, and you have strawberries that don\'t form a block.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      'ripe but firm strawberries', // FR: des fraises bien mûres mais fermes
      'freezer bags or boxes', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Lave les fraises **avant** de les équeuter : par la blessure, elles se gorgent d'eau.
      'Wash the strawberries **before** hulling them: through the cut, they soak up water.',
      // FR: Sèche-les une par une sur un torchon. Toute goutte restée devient du givre.
      'Dry them one by one on a tea towel. Every drop left behind turns to frost.',
      // FR: Équeute-les, laisse-les entières.
      'Hull them and leave them whole.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent**, et congèle 3 heures.
      'Spread them on a tray **without touching** and freeze for 3 hours.',
      // FR: Verse-les en sac une fois dures. C'est la congélation en deux temps qui évite la motte de fraises soudées.
      'Tip them into a bag once hard. Freezing in two stages is what avoids a lump of strawberries welded together.',
      // FR: À l'usage : décongelées elles sont molles, donc pour les smoothies, coulis et gâteaux — pas pour une tarte crue.
      'To use: thawed they are soft, so for smoothies, coulis and cakes — not for a raw tart.',
    ],
  ),
  'fraise/Sirop de fraises': RecipeText(
    // FR: Sirop de fraises
    name: 'Strawberry syrup',
    // FR: Le jus pressé, cuit au sucre et mis en bouteille : tout l'été dans un verre d'eau.
    description: 'The pressed juice, cooked with sugar and bottled: a whole summer in a glass of water.',
    // FR: 1 an au placard, 3 semaines ouvert
    keeps: '1 year in the cupboard, 3 weeks once opened',
    ingredients: <String>[
      '1.5 kg of strawberries', // FR: 1,5 kg de fraises
      '1 kg of sugar', // FR: 1 kg de sucre
      'the juice of 2 lemons', // FR: le jus de 2 citrons
      'a few mint leaves', // FR: quelques feuilles de menthe
    ],
    steps: <String>[
      // FR: Équeute les fraises, écrase-les grossièrement à la fourchette.
      'Hull the strawberries and crush them roughly with a fork.',
      // FR: Laisse-les rendre leur jus 2 heures avec le citron, à température ambiante.
      'Leave them to release their juice for 2 hours with the lemon, at room temperature.',
      // FR: Verse dans un torchon propre et presse. Ne filtre pas au mixeur : le sirop deviendrait trouble.
      'Pour into a clean cloth and press. Don\'t put it through a blender: the syrup would turn cloudy.',
      // FR: Pèse le jus, ajoute autant de sucre que de jus, et porte doucement à ébullition.
      'Weigh the juice, add as much sugar as there is juice, and bring gently to the boil.',
      // FR: Cuis 10 minutes en écumant. Le sirop doit napper légèrement.
      'Cook for 10 minutes, skimming. The syrup should lightly coat the spoon.',
      // FR: Jette la menthe dedans hors du feu, 5 minutes.
      'Drop the mint in off the heat for 5 minutes.',
      // FR: Mets en bouteilles ébouillantées, remplies à ras, et ferme aussitôt. Debout, au frais et à l'ombre.
      'Pour into scalded bottles, filled to the brim, and close at once. Store upright, somewhere cool and shaded.',
    ],
  ),
  'fraise/Tarte aux fraises': RecipeText(
    // FR: Tarte aux fraises
    name: 'Strawberry tart',
    // FR: Pâte sablée, crème pâtissière, fraises crues rangées dessus.
    description: 'Sweet shortcrust, pastry cream, raw strawberries arranged on top.',
    ingredients: <String>[
      '1 sweet shortcrust pastry', // FR: 1 pâte sablée
      '600 g of strawberries', // FR: 600 g de fraises
      '50 cl of milk', // FR: 50 cl de lait
      '4 egg yolks, 100 g of sugar', // FR: 4 jaunes d'oeufs, 100 g de sucre
      '50 g of cornflour, 1 vanilla pod', // FR: 50 g de maïzena, 1 gousse de vanille
      '2 tablespoons of redcurrant jelly', // FR: 2 cuillères à soupe de gelée de groseille
    ],
    steps: <String>[
      // FR: Étale la pâte, pique-la, couvre-la de papier et de légumes secs.
      'Roll out the pastry, prick it, cover it with paper and baking beans.',
      // FR: Cuis-la **à blanc** 25 minutes à 180 °C : une pâte crue sous la crème détrempe en une heure.
      '**Blind bake** it for 25 minutes at 180 °C: raw pastry under the cream goes soggy within the hour.',
      // FR: Fais chauffer le lait avec la vanille fendue.
      'Heat the milk with the split vanilla pod.',
      // FR: Fouette jaunes, sucre et maïzena, puis verse le lait chaud dessus en remuant.
      'Whisk the yolks, sugar and cornflour, then pour the hot milk over, stirring.',
      // FR: Remets sur le feu et fouette **sans arrêt** jusqu'à ce que ça épaississe. Dès les premiers bouillons, c'est prêt.
      'Return to the heat and whisk **constantly** until it thickens. At the first bubbles, it is ready.',
      // FR: Verse la crème sur une assiette, filme au contact, et laisse refroidir complètement.
      'Pour the cream onto a plate, press cling film onto its surface and leave to cool completely.',
      // FR: Garnis le fond de crème lissée, range les fraises coupées en deux, pointe vers le haut.
      'Fill the pastry case with the smoothed cream and arrange the halved strawberries on top, points upwards.',
      // FR: Fais fondre la gelée avec une cuillère d'eau et badigeonne les fraises : c'est ce qui les fait briller.
      'Melt the jelly with a spoonful of water and brush it over the strawberries: this is what makes them shine.',
    ],
  ),
  'fraise/Fraises au sucre et menthe': RecipeText(
    // FR: Fraises au sucre et menthe
    name: 'Strawberries with sugar and mint',
    // FR: Coupées une heure avant, elles rendent un sirop qu'on sauce au pain.
    description: 'Cut an hour ahead, they release a syrup you mop up with bread.',
    ingredients: <String>[
      '500 g of strawberries', // FR: 500 g de fraises
      '2 tablespoons of sugar', // FR: 2 cuillères à soupe de sucre
      'about ten mint leaves', // FR: une dizaine de feuilles de menthe
      '1/2 lemon', // FR: 1/2 citron
    ],
    steps: <String>[
      // FR: Lave les fraises **avant** de les équeuter, sinon elles se gorgent d'eau par la blessure.
      'Wash the strawberries **before** hulling them, otherwise they soak up water through the cut.',
      // FR: Équeute-les et coupe-les en deux ou en quatre.
      'Hull them and cut them in half or in quarters.',
      // FR: Sucre-les, ajoute un trait de citron, mélange une fois.
      'Sprinkle with sugar, add a splash of lemon and stir once.',
      // FR: Laisse-les une heure à température ambiante : le sucre tire le jus et fait le sirop. Au réfrigérateur, ça ne marche qu'à moitié.
      'Leave them for an hour at room temperature: the sugar draws out the juice and makes the syrup. In the fridge, it only half works.',
      // FR: Déchire la menthe à la main juste avant de servir.
      'Tear the mint by hand just before serving.',
    ],
  ),

  // ─────────── framboisier (6 recettes) ───────────
  'framboisier/Framboises congelées une à une': RecipeText(
    // FR: Framboises congelées une à une
    name: 'Raspberries frozen one by one',
    // FR: Fragiles comme tout, les framboises tiennent un an au froid si on les congèle sans les laver.
    description: 'Fragile as can be, raspberries keep for a year in the cold if you freeze them without washing.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg of raspberries', // FR: 1 kg de framboises
      'freezer bags or boxes', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie les framboises et écarte celles qui sont moisies ou écrasées.
      'Sort the raspberries and discard any that are mouldy or crushed.',
      // FR: **Ne les lave pas** : elles boivent l'eau comme une éponge et deviennent de la bouillie au dégel.
      '**Don\'t wash them**: they drink up water like a sponge and turn to mush when thawed.',
      // FR: Étale-les sur une plaque, sans qu'elles se touchent, et congèle 2 heures.
      'Spread them on a tray, not touching, and freeze for 2 hours.',
      // FR: Verse-les délicatement en boîte une fois dures, elles se cassent moins qu'en sac.
      'Tip them gently into a box once hard; they break less than in a bag.',
    ],
  ),
  'framboisier/Gelée de framboises sans pépins': RecipeText(
    // FR: Gelée de framboises sans pépins
    name: 'Seedless raspberry jelly',
    // FR: Tout le goût de la framboise, sans un seul pépin sous la dent : la reine des tartines.
    description: 'All the taste of raspberry, without a single seed between your teeth: the queen of toast spreads.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 3 weeks in the fridge once opened',
    ingredients: <String>[
      '1.5 kg of raspberries', // FR: 1,5 kg de framboises
      '800 g of sugar per kilo of purée', // FR: 800 g de sucre par kilo de purée
      'the juice of one lemon', // FR: le jus d'un citron
      '5 jam jars', // FR: 5 pots de confiture
    ],
    steps: <String>[
      // FR: Fais éclater les framboises à feu doux, à couvert, en remuant.
      'Burst the raspberries over a low heat, covered, stirring.',
      // FR: Passe-les au moulin à légumes grille fine, ou presse-les à travers un tamis : les pépins restent dedans.
      'Pass them through a food mill with a fine disc, or press them through a sieve: the seeds stay behind.',
      // FR: Pèse la purée, ajoute 800 g de sucre par kilo et le jus de citron, puis porte à ébullition.
      'Weigh the purée, add 800 g of sugar per kilo and the lemon juice, then bring to the boil.',
      // FR: Cuis à gros bouillons en écumant. La framboise manque de pectine, c'est le **citron** qui fait prendre.
      'Boil hard, skimming. Raspberry lacks pectin: it is the **lemon** that makes it set.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête.
      'Test on a cold plate: a drop that sets is ready.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars, close and turn upside down until cool.',
    ],
  ),
  'framboisier/Vinaigre de framboise': RecipeText(
    // FR: Vinaigre de framboise
    name: 'Raspberry vinegar',
    // FR: Les framboises un peu fatiguées font le meilleur vinaigre : un trait suffit à réveiller une salade.
    description: 'Slightly tired raspberries make the best vinegar: a splash is enough to wake up a salad.',
    // FR: 1 an au placard
    keeps: '1 year in the cupboard',
    ingredients: <String>[
      '300 g of raspberries', // FR: 300 g de framboises
      '50 cl of white wine or cider vinegar at 6 % minimum', // FR: 50 cl de vinaigre de vin blanc ou de cidre à 6 % minimum
      '1 clean jar', // FR: 1 bocal propre
      '2 bottles of 25 cl', // FR: 2 bouteilles de 25 cl
    ],
    steps: <String>[
      // FR: Trie les framboises et écarte celles qui sont moisies. Celles qui sont abîmées mais saines font très bien l'affaire.
      'Sort the raspberries and discard any that are mouldy. Ones that are bruised but sound will do very well.',
      // FR: Mets-les dans le bocal et écrase-les légèrement à la fourchette.
      'Put them in the jar and crush them lightly with a fork.',
      // FR: Verse le vinaigre dessus : les fruits doivent être **entièrement couverts**. Ferme.
      'Pour the vinegar over: the fruit must be **completely covered**. Close.',
      // FR: Laisse macérer 2 semaines à l'abri de la lumière, en secouant le bocal tous les deux jours.
      'Leave to macerate for 2 weeks away from the light, shaking the jar every other day.',
      // FR: Filtre à travers un linge fin, sans presser trop fort pour garder un vinaigre clair.
      'Strain through a fine cloth, without pressing too hard so the vinegar stays clear.',
      // FR: Mets en bouteilles propres, bouche et garde à l'abri de la lumière : elle fait passer la couleur.
      'Pour into clean bottles, seal them and keep away from the light: it fades the colour.',
    ],
  ),
  'framboisier/Coulis de framboises': RecipeText(
    // FR: Coulis de framboises
    name: 'Raspberry coulis',
    // FR: Mixées crues, passées au tamis. Rien ne se perd du parfum.
    description: 'Blended raw and sieved. None of the fragrance is lost.',
  ),
  'framboisier/Confiture de framboises': RecipeText(
    // FR: Confiture de framboises
    name: 'Raspberry jam',
    // FR: Cuisson courte, pour garder le goût de la cueillette.
    description: 'A short cooking time, to keep the taste of the picking.',
  ),
  'framboisier/Framboisier': RecipeText(
    // FR: Framboisier
    name: 'Framboisier (raspberry cake)',
    // FR: Génoise, crème mousseline, framboises debout sur le pourtour.
    description: 'Sponge, mousseline cream, raspberries standing up around the edge.',
  ),

  // ─────────── gingembre (6 recettes) ───────────
  'gingembre/Gingembre entier au congélateur': RecipeText(
    // FR: Gingembre entier au congélateur
    name: 'Whole ginger in the freezer',
    // FR: Dix minutes, et tu râpes ton gingembre gelé sans même l'éplucher : plus fin, plus parfumé, plus de fibres.
    description: 'Ten minutes, and you grate your frozen ginger without even peeling it: finer, more fragrant, no fibres.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      'very firm ginger roots', // FR: des racines de gingembre bien fermes
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les racines sous l'eau pour enlever la terre entre les doigts du rhizome.
      'Scrub the roots under water to get rid of the soil between the fingers of the rhizome.',
      // FR: Sèche-les parfaitement dans un torchon.
      'Dry them perfectly in a tea towel.',
      // FR: Coupe en morceaux de 4 cm, la taille d'une utilisation.
      'Cut into 4 cm pieces, the size of one use.',
      // FR: Mets-les en sac, chasse l'air et congèle. Râpe-les **encore gelés** avec la peau, à la râpe fine.
      'Put them in a bag, press out the air and freeze. Grate them **still frozen**, skin on, on a fine grater.',
    ],
  ),
  'gingembre/Gingembre mariné au vinaigre': RecipeText(
    // FR: Gingembre mariné au vinaigre
    name: 'Ginger pickled in vinegar',
    // FR: Tranché très fin et mariné, le jeune gingembre devient rose pâle et croquant, comme celui des sushis.
    description: 'Sliced very thinly and marinated, young ginger turns pale pink and crunchy, like the ginger served with sushi.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 months in the fridge',
    ingredients: <String>[
      '250 g of young ginger with thin skin', // FR: 250 g de gingembre jeune, à peau fine
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
      '20 cl of white vinegar or cider vinegar at 6 %', // FR: 20 cl de vinaigre blanc ou de cidre à 6 %
      '60 g of sugar', // FR: 60 g de sucre
    ],
    steps: <String>[
      // FR: Gratte la peau avec une cuillère et coupe le gingembre en lamelles très fines, à l'économe ou à la mandoline.
      'Scrape off the skin with a spoon and cut the ginger into very thin slices, with a peeler or a mandoline.',
      // FR: Mélange avec le sel et laisse dégorger.
      'Mix with the salt and leave to draw out water.',
      // FR: Blanchis les lamelles 30 secondes dans l'eau bouillante, puis égoutte bien en pressant.
      'Blanch the slices for 30 seconds in boiling water, then drain well, pressing.',
      // FR: Fais chauffer le vinaigre et le sucre jusqu'à ce que le sucre fonde.
      'Heat the vinegar and sugar until the sugar dissolves.',
      // FR: Tasse le gingembre dans un bocal ébouillanté et verse le vinaigre chaud jusqu'à **le couvrir entièrement**.
      'Pack the ginger into a scalded jar and pour in the hot vinegar to **cover it completely**.',
      // FR: Ferme, laisse refroidir, puis au réfrigérateur. Il est prêt au bout de 3 jours.
      'Close, leave to cool, then put in the fridge. It is ready after 3 days.',
    ],
  ),
  'gingembre/Gingembre séché en poudre': RecipeText(
    // FR: Gingembre séché en poudre
    name: 'Dried ginger powder',
    // FR: Séché puis moulu, il se garde un an au placard et parfume biscuits, épices et boissons chaudes.
    description: 'Dried then ground, it keeps for a year in the cupboard and flavours biscuits, spice mixes and hot drinks.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      '500 g of ginger', // FR: 500 g de gingembre
      'a very dry airtight jar', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Brosse le gingembre sous l'eau et sèche-le.
      'Scrub the ginger under water and dry it.',
      // FR: Gratte la peau à la cuillère et coupe en tranches de 2 mm, toutes de la même épaisseur.
      'Scrape off the skin with a spoon and cut into 2 mm slices, all the same thickness.',
      // FR: Étale en une couche et sèche à **50 °C**, porte entrouverte, jusqu'à ce que les tranches cassent net.
      'Spread in a single layer and dry at **50 °C**, door ajar, until the slices snap cleanly.',
      // FR: Laisse refroidir complètement : chaudes, elles reprennent l'humidité et collent au mixeur.
      'Leave to cool completely: warm, they take the moisture back and stick in the blender.',
      // FR: Mixe en poudre fine et passe au tamis.
      'Blend to a fine powder and sift.',
      // FR: Mets en bocal hermétique, à l'abri de la lumière.
      'Put in an airtight jar, away from the light.',
    ],
  ),
  'gingembre/Gingembre confit': RecipeText(
    // FR: Gingembre confit
    name: 'Candied ginger',
    // FR: En lamelles, cuites dans un sirop, puis roulées au sucre.
    description: 'In slices, cooked in a syrup, then rolled in sugar.',
  ),
  'gingembre/Gnamakoudji': RecipeText(
    // FR: Gnamakoudji
    name: 'Gnamakoudji',
    // FR: Le jus de gingembre frais qui pique et réveille, incontournable des marchés.
    description: 'Fresh ginger juice that stings and wakes you up, a market-stall essential.',
  ),
  'gingembre/Tisane gingembre-citron': RecipeText(
    // FR: Tisane gingembre-citron
    name: 'Ginger and lemon tea',
    // FR: Une infusion chaude et tonique, parfaite quand la gorge gratte un peu.
    description: 'A hot, invigorating infusion, perfect when your throat feels a little scratchy.',
  ),

  // ─────────── gombo (6 recettes) ───────────
  'gombo/Gombos blanchis entiers au congélateur': RecipeText(
    // FR: Gombos blanchis entiers au congélateur
    name: 'Whole blanched okra for the freezer',
    // FR: Blanchis entiers, ils gardent leur bave à l'intérieur : tu retrouves en hiver le gombo de la sauce, pas une purée.
    description: 'Blanched whole, they keep their slime inside: in winter you get back the okra of the sauce, not a mush.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '1 kg of young okra, no longer than a finger', // FR: 1 kg de gombos jeunes, pas plus longs qu'un doigt
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'coarse salt', // FR: gros sel
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les gombos et frotte-les doucement entre tes mains pour enlever le duvet.
      'Wash the okra and rub them gently between your hands to remove the fuzz.',
      // FR: Coupe juste le bout du pédoncule **sans ouvrir la capsule** : fermée, elle garde la bave dedans.
      'Cut off just the tip of the stalk **without opening the pod**: closed, it keeps the slime inside.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante salée. 3 minutes pour les petits, 4 pour les gros.
      'Plunge them into a large pan of boiling salted water. 3 minutes for the small ones, 4 for the big ones.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le même temps que la cuisson. C'est ce qui fixe le vert.
      'Move them straight to the iced water for the same length of time as the cooking. This is what fixes the green.',
      // FR: Égoutte-les et sèche-les sur un torchon. Chaque goutte qui reste devient du givre.
      'Drain them and dry them on a tea towel. Every drop left behind turns to frost.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures, puis verse-les en sac.
      'Spread them on a tray without touching and freeze for 2 hours, then tip them into a bag.',
      // FR: À l'usage, coupe-les encore gelés en rondelles et jette-les directement dans la sauce chaude.
      'To use, slice them while still frozen and drop them straight into the hot sauce.',
    ],
  ),
  'gombo/Gombos séchés en rondelles': RecipeText(
    // FR: Gombos séchés en rondelles
    name: 'Dried okra rounds',
    // FR: La façon sahélienne de garder le gombo toute l'année : séché, il se pile et épaissit les sauces comme du frais.
    description: 'The Sahelian way of keeping okra all year round: dried, it is pounded and thickens sauces just like fresh.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 year in a dry place, out of the light',
    ingredients: <String>[
      '1 kg of young, tender okra', // FR: 1 kg de gombos jeunes et tendres
      'a very dry airtight jar', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Lave les gombos et **sèche-les complètement** avant de les couper, sinon ils collent au couteau.
      'Wash the okra and **dry it completely** before cutting, or it sticks to the knife.',
      // FR: Coupe-les en rondelles de 5 mm, pas plus épaisses : le centre doit sécher aussi vite que le bord.
      'Cut into 5 mm rounds, no thicker: the centre has to dry as fast as the edge.',
      // FR: Étale-les en une seule couche sur des plaques et sèche à **60 °C**, porte du four entrouverte d'une cuillère en bois.
      'Spread them in a single layer on trays and dry at **60 °C**, with the oven door held ajar with a wooden spoon.',
      // FR: Retourne-les à mi-séchage. Au soleil, compte 3 à 4 jours sous un voile, rentrés chaque soir.
      'Turn them halfway through drying. In the sun, count 3 to 4 days under a thin cloth, brought in each evening.',
      // FR: Teste : une rondelle refroidie doit casser net. Si elle plie, remets 1 heure.
      'Test: a cooled round should snap cleanly. If it bends, put it back for 1 hour.',
      // FR: Laisse refroidir et mets en bocal hermétique. Pile ou mixe une poignée au moment de faire la sauce.
      'Leave to cool and put in an airtight jar. Pound or blend a handful when you make the sauce.',
    ],
  ),
  'gombo/Petits gombos au vinaigre': RecipeText(
    // FR: Petits gombos au vinaigre
    name: 'Pickled baby okra',
    // FR: Croquants et pas du tout baveux : le vinaigre les tient. Un pickle surprenant pour l'apéro.
    description: 'Crunchy and not slimy at all: the vinegar holds them. A surprising pickle to nibble with drinks.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '500 g of tiny okra', // FR: 500 g de tout petits gombos
      '25 cl of white vinegar at 6 %', // FR: 25 cl de vinaigre blanc à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '15 g of salt and 1 teaspoon of sugar', // FR: 15 g de sel et 1 cuillère à café de sucre
      '2 garlic cloves and 1 chilli', // FR: 2 gousses d'ail et 1 piment
    ],
    steps: <String>[
      // FR: Lave et sèche les gombos, garde seulement les plus petits et les plus fermes.
      'Wash and dry the okra, keeping only the smallest and firmest.',
      // FR: Recoupe le pédoncule **sans percer la capsule**. Pèle l'ail, fends le piment en deux.
      'Trim the stalk again **without piercing the pod**. Peel the garlic and split the chilli in half.',
      // FR: Range les gombos debout et serrés dans deux bocaux ébouillantés, avec l'ail et le piment.
      'Stand the okra upright and tightly packed in two scalded jars, with the garlic and chilli.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre.
      'Bring the vinegar, water, salt and sugar to the boil.',
      // FR: Verse la saumure bouillante jusqu'à **couvrir entièrement** les gombos, à 1 cm du bord. Ferme aussitôt.
      'Pour the boiling brine over to **cover the okra completely**, to 1 cm from the rim. Close at once.',
      // FR: Laisse refroidir, puis au réfrigérateur. Attends une semaine avant d'ouvrir, c'est là qu'ils prennent le goût.
      'Leave to cool, then put in the fridge. Wait a week before opening, which is when they take on the flavour.',
    ],
  ),
  'gombo/Gombos sautés à l\'ail': RecipeText(
    // FR: Gombos sautés à l'ail
    name: 'Garlic sautéed okra',
    // FR: À feu vif et peu de temps : c'est ce qui évite le filant.
    description: 'Over a high heat and for a short time: that is what stops them going slimy.',
  ),
  'gombo/Soupou kandia': RecipeText(
    // FR: Soupou kandia
    name: 'Soupou kandia',
    // FR: La sauce gombo sénégalaise onctueuse, à l'huile de palme et au poisson.
    description: 'The rich, smooth Senegalese okra sauce, made with palm oil and fish.',
  ),
  'gombo/Sauce gombo': RecipeText(
    // FR: Sauce gombo
    name: 'Okra sauce',
    // FR: La grande sauce sahélienne qui accompagne le tô, mijotée avec viande ou poisson.
    description: 'The great Sahelian sauce that goes with tô, simmered with meat or fish.',
  ),

  // ─────────── groseillier (6 recettes) ───────────
  'groseillier/Grappes de groseilles congelées': RecipeText(
    // FR: Grappes de groseilles congelées
    name: 'Frozen redcurrant bunches',
    // FR: L'astuce : congeler les grappes entières, et égrapper quand c'est dur. Fini l'égrappage grain par grain.
    description: 'The trick: freeze the whole bunches, and strip them when hard. No more picking berries off one by one.',
    // FR: 1 an au congélateur
    keeps: '1 year in the freezer',
    ingredients: <String>[
      '1 kg of redcurrants on the stalk', // FR: 1 kg de groseilles en grappes
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince rapidement les grappes, seulement si elles sont sales.
      'Rinse the bunches quickly, only if they are dirty.',
      // FR: Sèche-les à plat sur un torchon, sans les écraser.
      'Dry them flat on a tea towel, without crushing them.',
      // FR: Étale les grappes entières sur une plaque et congèle 2 heures.
      'Spread the whole bunches on a tray and freeze for 2 hours.',
      // FR: Frotte les grappes congelées entre tes doigts ou passe une fourchette : **les grains tombent tout seuls**.
      'Rub the frozen bunches between your fingers or run a fork through them: **the berries fall off by themselves**.',
      // FR: Verse les grains en sac et remets aussitôt au congélateur, avant qu'ils ne dégèlent.
      'Tip the berries into a bag and put them back in the freezer straight away, before they thaw.',
    ],
  ),
  'groseillier/Sirop de groseille en bouteilles': RecipeText(
    // FR: Sirop de groseille en bouteilles
    name: 'Bottled redcurrant syrup',
    // FR: Le sirop rouge de l'enfance, fait avec tes groseilles : un été entier dans quelques bouteilles.
    description: 'The red syrup of childhood, made with your own redcurrants: a whole summer in a few bottles.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 3 weeks in the fridge once opened',
    ingredients: <String>[
      '1.5 kg of stripped redcurrants', // FR: 1,5 kg de groseilles égrappées
      '10 cl of water', // FR: 10 cl d'eau
      '1 kg of sugar per litre of juice', // FR: 1 kg de sucre par litre de jus
      '4 bottles of 50 cl with swing-top stoppers and new seals', // FR: 4 bouteilles de 50 cl à bouchon mécanique avec joints neufs
    ],
    steps: <String>[
      // FR: Fais éclater les groseilles avec l'eau à feu doux, en écrasant à la cuillère.
      'Burst the redcurrants with the water over a low heat, crushing them with a spoon.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse un peu.
      'Pour into a clean cloth set over a colander and leave to drip, then press a little.',
      // FR: Mesure le jus, ajoute **1 kg de sucre par litre** et porte doucement à ébullition en écumant.
      'Measure the juice, add **1 kg of sugar per litre** and bring gently to the boil, skimming.',
      // FR: Laisse bouillir 3 minutes : le sirop doit napper légèrement la cuillère.
      'Boil for 3 minutes: the syrup should lightly coat the spoon.',
      // FR: Verse le sirop chaud dans les bouteilles propres, à 2 cm du bord, et ferme avec des joints neufs.
      'Pour the hot syrup into clean bottles, to 2 cm from the top, and close with new seals.',
      // FR: Stérilise les bouteilles couchées et couvertes d'eau, 20 minutes à partir de l'ébullition, puis laisse refroidir dans l'eau.
      'Sterilise the bottles lying down and covered with water, 20 minutes from the moment it boils, then leave to cool in the water.',
    ],
  ),
  'groseillier/Confiture groseilles-framboises': RecipeText(
    // FR: Confiture groseilles-framboises
    name: 'Redcurrant and raspberry jam',
    // FR: La groseille apporte la pectine et l'acidité, la framboise le parfum : le duo qui prend à coup sûr.
    description: 'Redcurrant brings the pectin and the tartness, raspberry the fragrance: the pair that sets every time.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 3 weeks in the fridge once opened',
    ingredients: <String>[
      '1 kg of stripped redcurrants', // FR: 1 kg de groseilles égrappées
      '500 g of raspberries', // FR: 500 g de framboises
      '800 g of sugar per kilo of purée', // FR: 800 g de sucre par kilo de purée
      '5 jam jars', // FR: 5 pots de confiture
    ],
    steps: <String>[
      // FR: Fais éclater groseilles et framboises à feu doux, à couvert, en remuant.
      'Burst the redcurrants and raspberries over a low heat, covered, stirring.',
      // FR: Passe au moulin à légumes grille fine pour retirer **les pépins** : la confiture sera lisse.
      'Pass through a food mill with a fine disc to remove **the seeds**: the jam will be smooth.',
      // FR: Pèse la purée, ajoute 800 g de sucre par kilo et porte à ébullition en remuant.
      'Weigh the purée, add 800 g of sugar per kilo and bring to the boil, stirring.',
      // FR: Cuis à gros bouillons en écumant. Ça prend vite, la groseille est pleine de pectine.
      'Boil hard, skimming. It sets quickly, as redcurrant is full of pectin.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête.
      'Test on a cold plate: a drop that sets is ready.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pour into scalded jars, close and turn upside down until cool.',
    ],
  ),
  'groseillier/Gelée de groseilles': RecipeText(
    // FR: Gelée de groseilles
    name: 'Redcurrant jelly',
    // FR: Le jus seul, filtré sans presser, pour qu'elle reste claire.
    description: 'The juice alone, strained without pressing, so that it stays clear.',
  ),
  'groseillier/Groseilles au sucre': RecipeText(
    // FR: Groseilles au sucre
    name: 'Sugared redcurrants',
    // FR: En grappes, trempées dans le blanc d'œuf puis le sucre.
    description: 'In bunches, dipped in egg white and then in sugar.',
  ),
  'groseillier/Bavarois aux groseilles': RecipeText(
    // FR: Bavarois aux groseilles
    name: 'Redcurrant bavarois',
    // FR: Leur acidité réveille une crème sucrée.
    description: 'Their tartness wakes up a sweet cream.',
  ),

  // ─────────── haricot (6 recettes) ───────────
  'haricot/Haricots verts blanchis au congélateur': RecipeText(
    // FR: Haricots verts blanchis au congélateur
    name: 'Blanched green beans for the freezer',
    // FR: Trois minutes dans l'eau bouillante, et ils gardent leur croquant tout l'hiver.
    description: 'Three minutes in boiling water, and they keep their crunch all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of green beans', // FR: 2 kg de haricots verts
      'coarse salt', // FR: gros sel
      '1 large bowl of iced water', // FR: 1 grand saladier d'eau glacée
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les haricots des deux côtés. Garde-les entiers, ils se tiennent mieux.
      'Top and tail the beans. Keep them whole; they hold up better.',
      // FR: Plonge-les par poignées dans une grande casserole d'eau bouillante salée et compte **3 minutes**.
      'Plunge them by the handful into a large pan of boiling salted water and count **3 minutes**.',
      // FR: Transfère-les aussitôt dans l'eau glacée : c'est ce qui **fixe la couleur**.
      'Move them straight to the iced water: this is what **fixes the colour**.',
      // FR: Égoutte et sèche-les dans un torchon, en les roulant doucement.
      'Drain and dry them in a tea towel, rolling them gently.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets-les en sac : ils restent séparés et se prennent à la poignée.
      'Spread on a tray, freeze for 2 hours, then put in a bag: they stay separate and you can take them by the handful.',
    ],
  ),
  'haricot/Haricots verts à l\'aneth au vinaigre': RecipeText(
    // FR: Haricots verts à l'aneth au vinaigre
    name: 'Dill pickled green beans',
    // FR: Les « dilly beans » : debout dans le bocal, croquants et piquants, à grignoter comme des cornichons.
    description: 'The "dilly beans": standing up in the jar, crunchy and tangy, to nibble like gherkins.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 months in the fridge',
    ingredients: <String>[
      '1 kg of slim green beans', // FR: 1 kg de haricots verts fins
      '50 cl of white vinegar at 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl of water', // FR: 50 cl d'eau
      '25 g of salt', // FR: 25 g de sel
      '4 garlic cloves and a few heads of dill', // FR: 4 gousses d'ail et quelques têtes d'aneth
      '1 teaspoon of chilli flakes', // FR: 1 cuillère à café de piment en flocons
    ],
    steps: <String>[
      // FR: Équeute les haricots et coupe-les à la hauteur des bocaux, moins 2 cm.
      'Top and tail the beans and cut them to the height of the jars, minus 2 cm.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante : ils restent croquants mais ne sont plus crus.
      'Blanch them for **2 minutes** in boiling water: they stay crunchy but are no longer raw.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte.
      'Refresh them in iced water and drain.',
      // FR: Range-les debout, bien serrés, dans des bocaux propres avec l'ail, l'aneth et le piment.
      'Stand them upright, packed tightly, in clean jars with the garlic, dill and chilli.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sel.
      'Bring the vinegar, water and salt to the boil.',
      // FR: Verse bouillant jusqu'à **couvrir les haricots** de 1 cm, ferme, laisse refroidir et range au réfrigérateur. Prêts en une semaine.
      'Pour in boiling hot to **cover the beans** by 1 cm, close, leave to cool and put in the fridge. Ready in a week.',
    ],
  ),
  'haricot/Haricots verts mijotés à l\'oignon pour le congélateur': RecipeText(
    // FR: Haricots verts mijotés à l'oignon pour le congélateur
    name: 'Green beans stewed with onion for the freezer',
    // FR: Déjà cuisinés avec oignons et lardons, ils passent du congélateur à l'assiette les soirs pressés.
    description: 'Already cooked with onions and bacon, they go from the freezer to the plate on busy evenings.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of green beans', // FR: 1,5 kg de haricots verts
      '3 onions', // FR: 3 oignons
      '150 g of bacon lardons (optional)', // FR: 150 g de lardons (facultatif)
      '2 tablespoons of oil', // FR: 2 cuillères à soupe d'huile
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Équeute les haricots et coupe-les en deux. Émince les oignons.
      'Top and tail the beans and cut them in half. Slice the onions.',
      // FR: Cuis les haricots 5 minutes à l'eau bouillante salée, puis égoutte-les.
      'Cook the beans for 5 minutes in boiling salted water, then drain them.',
      // FR: Fais dorer les oignons et les lardons dans l'huile, à feu moyen.
      'Brown the onions and lardons in the oil over a medium heat.',
      // FR: Ajoute les haricots, sale, poivre et fais sauter 5 minutes. **Garde-les un peu fermes** : ils finiront de cuire au réchauffage.
      'Add the beans, salt, pepper and sauté for 5 minutes. **Keep them a little firm**: they will finish cooking when reheated.',
      // FR: Étale sur un plat pour refroidir vite.
      'Spread on a dish to cool quickly.',
      // FR: Mets en boîtes d'un repas et congèle. Réchauffe-les à la poêle sans décongeler.
      'Put into single-meal boxes and freeze. Reheat in a pan without thawing.',
    ],
  ),
  'haricot/Haricots verts à la tomate': RecipeText(
    // FR: Haricots verts à la tomate
    name: 'Green beans in tomato sauce',
    // FR: Mijotés dans une sauce tomate à l'ail, à l'huile d'olive.
    description: 'Simmered in a garlicky tomato sauce, with olive oil.',
    ingredients: <String>[
      '800 g of green beans', // FR: 800 g de haricots verts
      '4 tomatoes', // FR: 4 tomates
      '1 onion, 2 garlic cloves', // FR: 1 oignon, 2 gousses d'ail
      '3 tablespoons of olive oil', // FR: 3 cuillères à soupe d'huile d'olive
      'salt, pepper, thyme', // FR: sel, poivre, thym
    ],
    steps: <String>[
      // FR: Équeute les haricots, garde-les entiers.
      'Top and tail the beans and keep them whole.',
      // FR: Fais fondre oignon et ail à l'huile, ajoute les tomates concassées.
      'Soften the onion and garlic in the oil, then add the chopped tomatoes.',
      // FR: Laisse réduire 10 minutes.
      'Leave to reduce for 10 minutes.',
      // FR: Ajoute les haricots, sale, couvre, et laisse 25 minutes à feu doux.
      'Add the beans, salt, cover, and cook for 25 minutes over a low heat.',
      // FR: Encore meilleurs tièdes, ou le lendemain.
      'Even better lukewarm, or the next day.',
    ],
  ),
  'haricot/Salade de haricots verts aux amandes': RecipeText(
    // FR: Salade de haricots verts aux amandes
    name: 'Green bean and almond salad',
    // FR: Cuits croquants, refroidis net, avec des amandes grillées.
    description: 'Cooked crisp, chilled fast, with toasted almonds.',
    ingredients: <String>[
      '600 g of green beans', // FR: 600 g de haricots verts
      '60 g of flaked almonds', // FR: 60 g d'amandes effilées
      '1 shallot', // FR: 1 échalote
      'mustard, vinegar, oil', // FR: moutarde, vinaigre, huile
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Plonge les haricots dans une grande eau bouillante très salée.
      'Plunge the beans into a large pan of very salty boiling water.',
      // FR: 8 minutes : ils doivent plier sans casser.
      '8 minutes: they should bend without breaking.',
      // FR: Égoutte et plonge-les aussitôt dans l'eau glacée. C'est ce qui fixe le vert.
      'Drain and plunge them straight into the iced water. This is what fixes the green.',
      // FR: Fais dorer les amandes à sec, 2 minutes.
      'Toast the almonds in a dry pan for 2 minutes.',
      // FR: Vinaigrette à l'échalote, amandes par-dessus au dernier moment.
      'Shallot vinaigrette, with the almonds on top at the last moment.',
    ],
  ),
  'haricot/Haricots verts sautés': RecipeText(
    // FR: Haricots verts sautés
    name: 'Sautéed green beans',
    // FR: Blanchis puis jetés à la poêle avec de l'ail et du beurre.
    description: 'Blanched then tossed in a pan with garlic and butter.',
    ingredients: <String>[
      '600 g of green beans', // FR: 600 g de haricots verts
      '2 garlic cloves', // FR: 2 gousses d'ail
      '30 g of butter', // FR: 30 g de beurre
      'salt, pepper, parsley', // FR: sel, poivre, persil
    ],
    steps: <String>[
      // FR: Blanchis les haricots 7 minutes à l'eau salée.
      'Blanch the beans for 7 minutes in salted water.',
      // FR: Égoutte-les et sèche-les bien.
      'Drain them and dry them well.',
      // FR: Beurre dans la poêle, l'ail émincé, puis les haricots.
      'Butter in the pan, the sliced garlic, then the beans.',
      // FR: 5 minutes à feu vif en remuant : quelques marques dorées, c'est parfait.
      '5 minutes over a high heat, stirring: a few golden marks are perfect.',
      // FR: Persil, poivre.
      'Parsley, pepper.',
    ],
  ),

  // ─────────── haricot_beurre (6 recettes) ───────────
  'haricot_beurre/Haricots beurre blanchis congelés': RecipeText(
    // FR: Haricots beurre blanchis congelés
    name: 'Blanched frozen wax beans',
    // FR: Trois minutes dans l'eau bouillante, et leur jaune tendre reste intact tout l'hiver.
    description: 'Three minutes in boiling water, and their tender yellow stays intact all winter.',
    // FR: 10 mois au congélateur
    keeps: '10 months in the freezer',
    ingredients: <String>[
      '2 kg of wax beans', // FR: 2 kg de haricots beurre
      'coarse salt', // FR: gros sel
      '1 large bowl of water and ice cubes', // FR: 1 grand saladier d'eau et de glaçons
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les haricots des deux côtés et retire le fil s'il y en a. Garde-les entiers.
      'Top and tail the beans and remove the string if there is one. Keep them whole.',
      // FR: Rince-les à l'eau froide.
      'Rinse them in cold water.',
      // FR: Plonge-les par poignées dans une grande eau bouillante salée, **3 minutes** à la reprise de l'ébullition.
      'Plunge them by the handful into a large pan of boiling salted water, **3 minutes** from the moment it returns to the boil.',
      // FR: Transfère-les aussitôt dans l'eau glacée : c'est ce qui garde leur couleur et leur croquant.
      'Move them straight to the iced water: this is what keeps their colour and crunch.',
      // FR: Égoutte et sèche-les bien sur un torchon.
      'Drain and dry them well on a tea towel.',
      // FR: Congèle-les étalés sur une plaque 2 heures, puis verse en sacs datés.
      'Freeze them spread on a tray for 2 hours, then tip into dated bags.',
    ],
  ),
  'haricot_beurre/Haricots beurre au vinaigre et à l\'aneth': RecipeText(
    // FR: Haricots beurre au vinaigre et à l'aneth
    name: 'Wax beans in vinegar and dill',
    // FR: Rangés debout dans un bocal, croquants et acidulés : ils se croquent comme des cornichons.
    description: 'Stood upright in a jar, crunchy and tangy: you can crunch them like gherkins.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 months in the fridge',
    ingredients: <String>[
      '800 g of wax beans', // FR: 800 g de haricots beurre
      '40 cl of white vinegar at 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl of water', // FR: 40 cl d'eau
      '15 g of salt', // FR: 15 g de sel
      '3 garlic cloves, 3 heads of dill', // FR: 3 gousses d'ail, 3 têtes d'aneth
    ],
    steps: <String>[
      // FR: Équeute les haricots et recoupe-les à la hauteur de tes bocaux, moins 2 cm.
      'Top and tail the beans and cut them to the height of your jars, minus 2 cm.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante salée : crus, le vinaigre a du mal à les pénétrer.
      'Blanch them for **2 minutes** in boiling salted water: raw, the vinegar struggles to get into them.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte.
      'Refresh them in iced water and drain.',
      // FR: Range-les debout et serrés dans trois bocaux ébouillantés, avec une gousse d'ail et une tête d'aneth par bocal.
      'Stand them upright and tightly packed in three scalded jars, with one garlic clove and one head of dill per jar.',
      // FR: Fais bouillir le vinaigre, l'eau et le sel.
      'Boil the vinegar, water and salt.',
      // FR: Verse bouillant pour **couvrir entièrement** les haricots, ferme, laisse refroidir et range au réfrigérateur. Attends une semaine.
      'Pour in boiling hot to **cover the beans completely**, close, leave to cool and put in the fridge. Wait a week.',
    ],
  ),
  'haricot_beurre/Haricots beurre lacto-fermentés': RecipeText(
    // FR: Haricots beurre lacto-fermentés
    name: 'Lacto-fermented wax beans',
    // FR: En saumure, ils deviennent acidulés tout en restant croquants : la façon la plus simple d'en garder des bocaux.
    description: 'In brine, they turn tangy while staying crunchy: the simplest way to keep jars of them.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 months in the fridge',
    ingredients: <String>[
      '1 kg of wax beans', // FR: 1 kg de haricots beurre
      '1 litre of chlorine-free water', // FR: 1 litre d'eau non chlorée
      '30 g of non-iodised salt', // FR: 30 g de sel non iodé
      '2 garlic cloves', // FR: 2 gousses d'ail
      '1 teaspoon of mustard seeds', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Dissolve **30 g of salt in 1 litre of water**: a 3 % brine.',
      // FR: Équeute les haricots et garde-les entiers. Ici, **pas de blanchiment** : ce sont les bactéries du légume cru qui font la fermentation.
      'Top and tail the beans and keep them whole. Here, **no blanching**: it is the bacteria on the raw vegetable that do the fermenting.',
      // FR: Range-les debout et serrés dans deux bocaux avec l'ail et la moutarde, jusqu'à 3 cm du bord.
      'Stand them upright and tightly packed in two jars with the garlic and mustard seeds, up to 3 cm from the rim.',
      // FR: Couvre de saumure et cale un poids pour qu'ils restent **sous la saumure**.
      'Cover with brine and add a weight so that they stay **under the brine**.',
      // FR: Ferme sans serrer et laisse fermenter 1 à 2 semaines à 18–22 °C, sur une assiette.
      'Close without tightening and leave to ferment for 1 to 2 weeks at 18–22 °C, standing on a plate.',
      // FR: Quand ils sont acidulés, serre les couvercles et range au réfrigérateur. Ils se mangent tels quels, froids.
      'When they are tangy, tighten the lids and put in the fridge. They are eaten as they are, cold.',
    ],
  ),
  'haricot_beurre/Haricots beurre persillade': RecipeText(
    // FR: Haricots beurre persillade
    name: 'Wax beans with garlic and parsley',
    // FR: Cuits croquants, sautés au beurre et à l'ail.
    description: 'Cooked crisp, sautéed in butter and garlic.',
  ),
  'haricot_beurre/Salade de haricots beurre': RecipeText(
    // FR: Salade de haricots beurre
    name: 'Wax bean salad',
    // FR: Tièdes, échalote et vinaigrette à l'ancienne.
    description: 'Lukewarm, with shallot and an old-fashioned vinaigrette.',
  ),
  'haricot_beurre/Haricots beurre à la tomate': RecipeText(
    // FR: Haricots beurre à la tomate
    name: 'Wax beans in tomato sauce',
    // FR: Mijotés dans un coulis à l'ail et au thym.
    description: 'Simmered in a garlic and thyme coulis.',
  ),

  // ─────────── igname (6 recettes) ───────────
  'igname/Igname bouillie en portions': RecipeText(
    // FR: Igname bouillie en portions
    name: 'Boiled yam in portions',
    // FR: Épluchée, cuite, congelée : tu sors une portion, tu la réchauffes ou tu la piles, et le repas est là.
    description: 'Peeled, cooked, frozen: you take out a portion, reheat it or pound it, and the meal is ready.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 kg of yam', // FR: 2 kg d'igname
      'coarse salt', // FR: gros sel
      'gloves', // FR: des gants
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Mets des gants : la peau d'igname gratte les mains. Coupe en rondelles de 4 cm, puis épluche chaque rondelle.
      'Put on gloves: yam skin makes your hands itch. Cut into 4 cm rounds, then peel each round.',
      // FR: Rince les morceaux pour enlever la sève gluante.
      'Rinse the pieces to remove the sticky sap.',
      // FR: Cuis-les dans l'eau bouillante salée jusqu'à ce que la pointe du couteau entre sans forcer.
      'Cook them in boiling salted water until the tip of a knife goes in without effort.',
      // FR: Égoutte et laisse refroidir étalé sur un plateau. Chaud, il fait de la buée et du givre dans le sac.
      'Drain and leave to cool, spread out on a tray. Hot, it makes steam and frost inside the bag.',
      // FR: Répartis en portions d'un repas, chasse l'air, note la date.
      'Divide into single-meal portions, press out the air, write the date.',
      // FR: À l'usage, réchauffe 10 minutes à la vapeur ou dans l'eau frémissante, ou pile directement chaud.
      'To use, reheat for 10 minutes in a steamer or in simmering water, or pound it directly, hot.',
    ],
  ),
  'igname/Cubes d\'igname crus congelés': RecipeText(
    // FR: Cubes d'igname crus congelés
    name: 'Raw frozen yam cubes',
    // FR: Vingt minutes de préparation, et des cubes prêts à jeter dans un ragoût. On les cuit toujours ensuite : l'igname ne se mange jamais crue.
    description: 'Twenty minutes of preparation, and cubes ready to drop into a stew. Always cook them afterwards: yam is never eaten raw.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '1.5 kg of yam', // FR: 1,5 kg d'igname
      'gloves', // FR: des gants
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Avec des gants, épluche l'igname bien épais pour enlever la couche rosée sous la peau.
      'With gloves on, peel the yam thickly to remove the pinkish layer under the skin.',
      // FR: Coupe en cubes de 3 cm, tous pareils pour qu'ils cuisent en même temps.
      'Cut into 3 cm cubes, all the same size so they cook at the same time.',
      // FR: Rince-les et **sèche-les bien** dans un torchon.
      'Rinse them and **dry them well** in a tea towel.',
      // FR: Étale sur une plaque et congèle 2 heures, puis mets-les en sac.
      'Spread on a tray and freeze for 2 hours, then put in a bag.',
      // FR: Plonge-les **sans décongeler** dans l'eau bouillante salée ou la sauce, et cuis 20 à 25 minutes jusqu'à ce qu'ils soient tendres.
      'Drop them **without thawing** into boiling salted water or the sauce, and cook for 20 to 25 minutes until tender.',
    ],
  ),
  'igname/Cossettes d\'igname séchées (élubo)': RecipeText(
    // FR: Cossettes d'igname séchées (élubo)
    name: 'Dried yam slices (elubo)',
    // FR: Précuites puis séchées, les cossettes se gardent des mois et se moulent en farine pour l'amala.
    description: 'Pre-cooked and then dried, the slices keep for months and can be milled into flour for amala.',
    // FR: 1 an au sec, à l'abri de l'humidité
    keeps: '1 year in a dry place, away from damp',
    ingredients: <String>[
      '3 kg of yam', // FR: 3 kg d'igname
      'gloves', // FR: des gants
      'drying racks or oven trays', // FR: des claies ou plaques de four
      'an airtight jar or bucket', // FR: un bocal ou seau hermétique
    ],
    steps: <String>[
      // FR: Avec des gants, épluche l'igname et coupe-la en tranches de 1 cm.
      'With gloves on, peel the yam and cut it into 1 cm slices.',
      // FR: Plonge les tranches dans une eau frémissante : elles doivent cuire en surface mais rester fermes au cœur.
      'Drop the slices into simmering water: they should cook on the surface but stay firm in the middle.',
      // FR: Égoutte et laisse reposer une nuit à couvert : c'est ce qui donne la couleur brune de l'élubo.
      'Drain and leave to rest overnight under a cover: this is what gives elubo its brown colour.',
      // FR: Sèche à **60 °C** jusqu'à ce que les tranches soient dures comme du bois, ou 4 à 5 jours au grand soleil.
      'Dry at **60 °C** until the slices are hard as wood, or 4 to 5 days in full sun.',
      // FR: Stocke les cossettes entières, elles se gardent mieux que la farine.
      'Store the slices whole; they keep better than flour.',
      // FR: Mouds-en une partie au moulin ou au blender puissant. La farine se verse toujours en pluie dans l'eau bouillante et se cuit en remuant.
      'Mill some of them in a mill or a powerful blender. Always sprinkle the flour into boiling water and cook it, stirring.',
    ],
  ),
  'igname/Foufou d\'igname': RecipeText(
    // FR: Foufou d'igname
    name: 'Yam fufu',
    // FR: L'igname pilée en boule moelleuse, indispensable avec une sauce bien relevée.
    description: 'Yam pounded into a soft ball, essential with a well-spiced sauce.',
  ),
  'igname/Ragoût d\'igname': RecipeText(
    // FR: Ragoût d'igname
    name: 'Yam stew',
    // FR: Des morceaux d'igname mijotés dans une sauce tomate qui embaume la cuisine.
    description: 'Chunks of yam simmered in a tomato sauce that perfumes the whole kitchen.',
  ),
  'igname/Igname frite': RecipeText(
    // FR: Igname frite
    name: 'Fried yam',
    // FR: Des frites d'igname dorées, à tremper dans une petite sauce pimentée.
    description: 'Golden yam fries, to dip in a little spicy sauce.',
  ),

  // ─────────── kiwi (6 recettes) ───────────
  'kiwi/Chutney de kiwis au gingembre': RecipeText(
    // FR: Chutney de kiwis au gingembre
    name: 'Kiwi and ginger chutney',
    // FR: Quand l'actinidia croule sous les fruits, un chutney acidulé en absorbe un kilo d'un coup.
    description: 'When the kiwi vine is weighed down with fruit, a tangy chutney takes a kilo of them in one go.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 year in the cupboard, 1 month in the fridge once opened',
    ingredients: <String>[
      '1 kg of ripe kiwis', // FR: 1 kg de kiwis mûrs
      '1 onion', // FR: 1 oignon
      '250 g of brown sugar', // FR: 250 g de sucre roux
      '20 cl of cider vinegar', // FR: 20 cl de vinaigre de cidre
      '20 g of fresh ginger, 1 teaspoon of salt', // FR: 20 g de gingembre frais, 1 cuillère à café de sel
      '5 jars with new lids', // FR: 5 pots avec couvercles neufs
    ],
    steps: <String>[
      // FR: Épluche les kiwis et coupe-les en dés. Émince l'oignon et râpe le gingembre.
      'Peel the kiwis and dice them. Slice the onion and grate the ginger.',
      // FR: Mets tout dans une casserole à fond épais avec le sucre, le vinaigre et le sel, et porte à ébullition.
      'Put everything in a heavy-based pan with the sugar, vinegar and salt, and bring to the boil.',
      // FR: Laisse cuire à petit feu, à découvert, en remuant souvent, jusqu'à ce que ça épaississe et que la cuillère laisse un sillon.
      'Cook gently, uncovered, stirring often, until it thickens and the spoon leaves a trail.',
      // FR: Remplis les pots propres de chutney bouillant **jusqu'à 2 cm du bord** et ferme avec des couvercles neufs.
      'Fill clean jars with boiling chutney **to 2 cm from the rim** and close with new lids.',
      // FR: Stérilise les pots couverts d'eau, 20 minutes à partir de l'ébullition, puis vérifie le vide en refroidissant.
      'Sterilise the jars completely covered in water, 20 minutes from the moment it boils, then check the vacuum as they cool.',
    ],
  ),
  'kiwi/Rondelles de kiwi séchées': RecipeText(
    // FR: Rondelles de kiwi séchées
    name: 'Dried kiwi rounds',
    // FR: Séchées, les rondelles gardent leur vert vif et leurs petits grains noirs : jolies et acidulées.
    description: 'Dried, the rounds keep their bright green and their little black seeds: pretty and tangy.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 months in a jar, in a dry place',
    ingredients: <String>[
      '1.5 kg of ripe but firm kiwis', // FR: 1,5 kg de kiwis mûrs mais fermes
      'baking paper', // FR: du papier cuisson
      'glass jars', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Prends des kiwis mûrs mais encore fermes : cueillis durs en novembre, ils mûrissent en quelques jours à côté d'une pomme.
      'Choose kiwis that are ripe but still firm: picked hard in November, they ripen in a few days next to an apple.',
      // FR: Épluche-les et coupe des rondelles de **6 mm**, toutes pareilles.
      'Peel them and cut **6 mm** rounds, all the same thickness.',
      // FR: Étale-les sur des grilles couvertes de papier cuisson et sèche au four à **60 °C**, porte entrouverte. Retourne-les à mi-temps.
      'Spread on racks covered with baking paper and dry in the oven at **60 °C**, door held ajar. Turn them halfway through.',
      // FR: Teste : la rondelle refroidie est souple, sans jus, et se décolle du papier toute seule.
      'Test: the cooled round is supple, with no juice, and comes away from the paper by itself.',
      // FR: Mets en bocal et surveille la buée la première semaine. S'il y en a, remets au four une heure.
      'Put in a jar and watch for condensation in the first week. If there is any, put back in the oven for an hour.',
    ],
  ),
  'kiwi/Rondelles de kiwi congelées': RecipeText(
    // FR: Rondelles de kiwi congelées
    name: 'Frozen kiwi rounds',
    // FR: Épluchées et congelées sur plaque, elles filent directement dans un smoothie ou un sorbet.
    description: 'Peeled and frozen on a tray, they go straight into a smoothie or a sorbet.',
    // FR: 8 mois au congélateur
    keeps: '8 months in the freezer',
    ingredients: <String>[
      '1 kg of very ripe kiwis', // FR: 1 kg de kiwis bien mûrs
      'freezer bags', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les kiwis et coupe-les en rondelles d'un centimètre.
      'Peel the kiwis and cut them into rounds one centimetre thick.',
      // FR: Étale-les sur une plaque couverte de papier cuisson, sans qu'elles se touchent, et congèle 2 heures.
      'Spread on a tray lined with baking paper, not touching, and freeze for 2 hours.',
      // FR: Décolle-les et verse-les en sac. Décongelées elles sont molles : **à mixer**, pas pour une salade de fruits.
      'Peel them off the paper and tip into a bag. Thawed they are soft: **for blending**, not for a fruit salad.',
      // FR: Mixées encore congelées avec un peu de sucre, elles donnent un sorbet minute.
      'Blended still frozen with a little sugar, they make an instant sorbet.',
    ],
  ),
  'kiwi/Salade de kiwis à la menthe': RecipeText(
    // FR: Salade de kiwis à la menthe
    name: 'Kiwi and mint salad',
    // FR: Avec de l'orange, c'est le dessert d'hiver le plus simple.
    description: 'With orange, it is the simplest winter dessert.',
  ),
  'kiwi/Confiture de kiwis': RecipeText(
    // FR: Confiture de kiwis
    name: 'Kiwi jam',
    // FR: Verte et acidulée, avec de la vanille.
    description: 'Green and tangy, with vanilla.',
  ),
  'kiwi/Smoothie kiwi-pomme': RecipeText(
    // FR: Smoothie kiwi-pomme
    name: 'Kiwi and apple smoothie',
    // FR: Attention : le kiwi fait tourner les laitages après une heure.
    description: 'Careful: kiwi curdles dairy after an hour.',
  ),

  // ─────────── laitue (6 recettes) ───────────
  'laitue/Potage de laitue aux petits pois à congeler': RecipeText(
    // FR: Potage de laitue aux petits pois à congeler
    name: 'Lettuce and pea soup for the freezer',
    // FR: Quand toutes les laitues montent en même temps, la soupe est la seule façon de les garder.
    description: 'When all the lettuces bolt at once, soup is the only way to keep them.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '2 big lettuces', // FR: 2 grosses laitues
      '300 g of shelled peas', // FR: 300 g de petits pois écossés
      '1 onion', // FR: 1 oignon
      '2 potatoes', // FR: 2 pommes de terre
      '1.2 litres of stock', // FR: 1,2 litre de bouillon
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave les laitues feuille à feuille, même un peu montées : coupe juste les côtes trop dures et amères.
      'Wash the lettuces leaf by leaf, even if they have bolted a little: just cut out the ribs that are too tough and bitter.',
      // FR: Fais suer l'oignon émincé, ajoute les pommes de terre en dés et le bouillon, cuis 15 minutes.
      'Sweat the sliced onion, add the diced potatoes and the stock, and cook for 15 minutes.',
      // FR: Ajoute les petits pois et la laitue grossièrement coupée, et compte **5 minutes**, pas plus, pour garder le vert.
      'Add the peas and the roughly chopped lettuce, and count **5 minutes**, no more, to keep the green.',
      // FR: Mixe aussitôt, hors du feu. Sans crème : tu l'ajouteras à table, elle tranche au congélateur.
      'Blend straight away, off the heat. No cream: add it at the table, as it splits in the freezer.',
      // FR: Refroidis vite en posant la casserole dans l'eau froide, en remuant de temps en temps.
      'Cool quickly by standing the pan in cold water, stirring from time to time.',
      // FR: Mets en boîtes d'un repas en laissant 2 cm de vide, ça gonfle en gelant. Note la date.
      'Put into single-meal boxes leaving 2 cm of space, as it expands when it freezes. Write the date.',
    ],
  ),
  'laitue/Laitue fondue au beurre en portions': RecipeText(
    // FR: Laitue fondue au beurre en portions
    name: 'Buttery wilted lettuce in portions',
    // FR: Un saladier de feuilles qui fond en une poignée : de quoi glisser du vert dans une quiche ou une omelette tout l'hiver.
    description: 'A bowlful of leaves that melts down to a handful: enough to slip some green into a quiche or an omelette all winter.',
    // FR: 6 mois au congélateur
    keeps: '6 months in the freezer',
    ingredients: <String>[
      '3 lettuces', // FR: 3 laitues
      '30 g of butter', // FR: 30 g de beurre
      '1 shallot', // FR: 1 échalote
      'salt', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles et essore-les bien : trop d'eau, et elles bouillent au lieu de fondre.
      'Wash the leaves and spin them dry: too much water, and they boil instead of melting.',
      // FR: Roule-les en cigare et coupe-les en lanières d'un centimètre.
      'Roll them up like a cigar and cut into strips one centimetre wide.',
      // FR: Fais fondre l'échalote hachée dans le beurre, ajoute la laitue par poignées et remue jusqu'à ce qu'elle tombe.
      'Soften the chopped shallot in the butter, add the lettuce by the handful and stir until it wilts.',
      // FR: Sale légèrement et laisse évaporer le jus à feu vif 2 minutes : c'est ce qui évite les glaçons.
      'Salt lightly and let the juice evaporate over a high heat for 2 minutes: this is what avoids ice crystals.',
      // FR: Étale sur une assiette pour refroidir vite, puis répartis en petits tas ou en bac à muffins.
      'Spread on a plate to cool quickly, then divide into small heaps or into a muffin tray.',
      // FR: Congèle 2 heures, démoule les palets et garde-les en sac. Un palet se jette directement dans la poêle.
      'Freeze for 2 hours, turn out the pucks and keep them in a bag. A puck goes straight into the pan.',
    ],
  ),
  'laitue/Côtes de laitue en pickles croquants': RecipeText(
    // FR: Côtes de laitue en pickles croquants
    name: 'Crunchy lettuce rib pickles',
    // FR: Les côtes épaisses d'une romaine ou d'une batavia montée gardent un croquant étonnant dans le vinaigre.
    description: 'The thick ribs of a bolted cos or batavia lettuce stay surprisingly crunchy in vinegar.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 month in the fridge',
    ingredients: <String>[
      'the ribs and stalks of 4 lettuces', // FR: les côtes et trognons de 4 laitues
      '25 cl of cider vinegar at 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl of water', // FR: 25 cl d'eau
      '1 tablespoon of sugar', // FR: 1 cuillère à soupe de sucre
      '1 teaspoon of salt', // FR: 1 cuillère à café de sel
      '1 teaspoon of mustard seeds', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Garde les grosses côtes blanches et les trognons des laitues montées, épluche les trognons au couteau.
      'Keep the big white ribs and the stalks of the bolted lettuces, and peel the stalks with a knife.',
      // FR: Coupe le tout en bâtonnets de 5 cm, assez épais pour rester croquants.
      'Cut everything into 5 cm sticks, thick enough to stay crunchy.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le sel et la moutarde, et laisse bouillir 2 minutes.
      'Bring the vinegar, water, sugar, salt and mustard seeds to the boil, and boil for 2 minutes.',
      // FR: Tasse les bâtonnets debout dans un bocal propre.
      'Pack the sticks upright in a clean jar.',
      // FR: Verse le vinaigre chaud jusqu'à **couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur.
      'Pour the hot vinegar over to **cover completely**, close, leave to cool and put in the fridge.',
      // FR: Attends 2 jours avant d'y goûter. À servir avec une viande froide ou haché dans une salade de riz.
      'Wait 2 days before tasting. Serve with cold meat or chopped into a rice salad.',
    ],
  ),
  'laitue/Salade verte vinaigrette maison': RecipeText(
    // FR: Salade verte vinaigrette maison
    name: 'Green salad with homemade vinaigrette',
    // FR: Une laitue cueillie à l'instant ne demande presque rien.
    description: 'A lettuce picked this very moment needs almost nothing.',
    ingredients: <String>[
      '1 fine lettuce', // FR: 1 belle laitue
      '1 teaspoon of mustard', // FR: 1 cuillère à café de moutarde
      '1 tablespoon of vinegar', // FR: 1 cuillère à soupe de vinaigre
      '3 tablespoons of oil', // FR: 3 cuillères à soupe d'huile
      'salt, pepper', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave les feuilles à l'eau froide, sèche-les bien : l'eau empêche la vinaigrette de tenir.
      'Wash the leaves in cold water and dry them well: water stops the vinaigrette clinging.',
      // FR: Dans le fond du saladier, délaye moutarde, sel et vinaigre.
      'In the bottom of the salad bowl, mix the mustard, salt and vinegar.',
      // FR: Verse l'huile en filet en fouettant : la sauce doit épaissir.
      'Pour in the oil in a thin stream, whisking: the dressing should thicken.',
      // FR: Ajoute les feuilles et mélange **juste avant** de servir.
      'Add the leaves and toss **just before** serving.',
    ],
  ),
  'laitue/Laitue braisée aux petits pois': RecipeText(
    // FR: Laitue braisée aux petits pois
    name: 'Braised lettuce with peas',
    // FR: Oui, la laitue se cuit — fondante, avec des petits pois et un peu de lard.
    description: 'Yes, lettuce can be cooked — soft, with peas and a little bacon.',
    ingredients: <String>[
      '2 lettuces', // FR: 2 laitues
      '300 g of shelled peas', // FR: 300 g de petits pois écossés
      '100 g of bacon lardons', // FR: 100 g de lardons
      '1 spring onion', // FR: 1 oignon nouveau
      '20 g of butter, salt, pepper', // FR: 20 g de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Coupe les laitues en quatre, garde-les attachées au trognon.
      'Cut the lettuces into quarters, keeping them joined at the stalk.',
      // FR: Fais dorer les lardons avec l'oignon émincé.
      'Brown the lardons with the sliced onion.',
      // FR: Ajoute les petits pois, les quartiers de laitue, le beurre et un fond d'eau.
      'Add the peas, the lettuce quarters, the butter and a splash of water.',
      // FR: Couvre et laisse fondre 20 minutes à feu doux.
      'Cover and cook gently for 20 minutes.',
      // FR: Poivre généreusement, sale peu : les lardons salent.
      'Pepper generously, salt little: the lardons are salty.',
    ],
  ),
  'laitue/Velouté de laitue': RecipeText(
    // FR: Velouté de laitue
    name: 'Lettuce soup',
    // FR: La solution quand la laitue monte toute en même temps au potager.
    description: 'The solution when all the lettuce bolts at once in the vegetable garden.',
    ingredients: <String>[
      '2 lettuces (even slightly bolted)', // FR: 2 laitues (même un peu montées)
      '2 potatoes', // FR: 2 pommes de terre
      '1 onion', // FR: 1 oignon
      '80 cl of stock', // FR: 80 cl de bouillon
      '10 cl of cream, salt, pepper', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Lave les laitues et hache-les grossièrement, côtes comprises.
      'Wash the lettuces and chop them roughly, ribs included.',
      // FR: Fais fondre l'oignon, ajoute les pommes de terre.
      'Soften the onion, add the potatoes.',
      // FR: Mouille au bouillon et cuis 15 minutes.
      'Add the stock and cook for 15 minutes.',
      // FR: Ajoute la laitue seulement **5 minutes** à la fin : au-delà elle perd sa couleur.
      'Add the lettuce for only **5 minutes** at the end: any longer and it loses its colour.',
      // FR: Mixe, ajoute la crème hors du feu, rectifie.
      'Blend, add the cream off the heat, and adjust the seasoning.',
    ],
  ),
};
