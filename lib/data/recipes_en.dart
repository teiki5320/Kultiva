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
};
