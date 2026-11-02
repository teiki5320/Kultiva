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
};
