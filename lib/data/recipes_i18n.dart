import '../services/prefs_service.dart';
import 'recipes.dart';
import 'recipes_en.dart';

/// Les textes d'une recette dans une autre langue.
///
/// **Une surcouche, pas un second catalogue.** Même choix que
/// `names_en.dart` pour les noms de légumes, et pour la même raison :
/// `lib/data/recipes.dart` reste la source de vérité. Il porte les
/// nombres, les méthodes, les durées de garde, l'ordre du top 3 — tout
/// ce qui n'est pas de la langue. Une traduction ne fait que recouvrir
/// du texte.
///
/// Ce qui ne voyage **pas** dans cette classe, exprès :
///
/// - l'emoji d'une étape et son minuteur. Un emoji n'a pas de langue,
///   et un minuteur est un nombre : les laisser dans le français
///   garantit qu'une traduction ne peut pas les perdre ;
/// - les minutes, les parts, la méthode de conservation. Idem ;
/// - les nombres **dans** le texte. Ils doivent être recopiés tels
///   quels, et `test/recipes_i18n_test.dart` refuse le contraire. Un
///   « 3 % » devenu « 2 % » dans une saumure, ce n'est pas une faute de
///   traduction, c'est un risque sanitaire.
///
/// Chaque champ retombe sur le français **séparément** : un lot où le
/// nom est traduit mais pas les étapes donne un nom anglais et des
/// étapes françaises, pas un écran vide. C'est ce qui permet de
/// traduire par morceaux sans jamais casser l'app.
class RecipeText {
  final String name;
  final String description;
  final String? keeps;

  /// Les ingrédients, dans l'ordre du français. Les unités se
  /// traduisent (« 30 g de sel » → « 30 g of salt »), les nombres non.
  final List<String> ingredients;

  /// Le texte des étapes, dans l'ordre du français, et **autant
  /// d'entrées**. Une liste de longueur différente est ignorée en
  /// entier : mieux vaut une recette française qu'une recette dont
  /// l'étape 4 répond à l'étape 5.
  final List<String> steps;

  const RecipeText({
    required this.name,
    required this.description,
    this.keeps,
    this.ingredients = const <String>[],
    this.steps = const <String>[],
  });
}

/// Les surcouches disponibles, par code de langue.
///
/// Ajouter une langue, c'est écrire un fichier et une ligne ici. Rien
/// d'autre ne bouge : ni le catalogue, ni les écrans, ni les tests de
/// comptage.
const Map<String, Map<String, RecipeText>> recipeTextsByLanguage =
    <String, Map<String, RecipeText>>{
  'en': recipeTextsEn,
};

/// La clé d'une recette dans les surcouches.
///
/// `légume/nom français`, exactement la clé des favoris
/// (`RecipeService.keyFor`). Le nom **français** sert de clé même dans
/// un fichier anglais : il ne change pas quand on traduit, alors qu'une
/// clé anglaise aurait obligé à renommer les sept lots à la première
/// retouche de style.
String recipeTextKey(String vegetableId, Recipe recipe) =>
    '$vegetableId/${recipe.name}';

/// Le légume propriétaire de chaque recette, calculé une fois.
///
/// `ownerOf()` parcourt les 736 recettes à chaque appel : acceptable
/// pour un favori, pas pour un getter appelé à chaque image. L'index
/// est construit à la première lecture et gardé.
///
/// ⚠️ Deux recettes `const` aux champs rigoureusement identiques sont
/// le **même** objet en Dart, et tomberaient donc sur un seul
/// propriétaire. `ownerOf()` a déjà ce comportement ; aucune paire de
/// ce genre n'existe dans le catalogue, et un test le vérifie.
Map<Recipe, String>? _proprietaires;

String? _proprietaireDe(Recipe recipe) {
  final index = _proprietaires ??= <Recipe, String>{
    for (final entree in recipesByVegetable.entries)
      for (final r in entree.value) r: entree.key,
  };
  return index[recipe];
}

/// La traduction d'une recette dans la langue demandée, ou null.
RecipeText? recipeTextFor(Recipe recipe, String languageCode) {
  if (languageCode == 'fr') return null;
  final surcouche = recipeTextsByLanguage[languageCode];
  if (surcouche == null) return null;
  final legume = _proprietaireDe(recipe);
  if (legume == null) return null;
  return surcouche[recipeTextKey(legume, recipe)];
}

/// Les neuf méthodes de conservation, traduites.
///
/// Ces libellés sont de la donnée, pas de l'interface : ils décrivent
/// un procédé du catalogue. Ils vivent donc ici et pas dans les ARB,
/// à côté des recettes qu'ils étiquettent.
const Map<String, Map<PreservationMethod, String>> _methodLabels =
    <String, Map<PreservationMethod, String>>{
  'en': <PreservationMethod, String>{
    PreservationMethod.congelation: 'Freezing',
    PreservationMethod.blanchiCongele: 'Blanched then frozen',
    PreservationMethod.transformeCongele: 'Cooked then frozen',
    PreservationMethod.bocalSterilise: 'Canned',
    PreservationMethod.lactoFermentation: 'Lacto-fermented',
    PreservationMethod.sechage: 'Dried',
    PreservationMethod.confiture: 'Jam',
    PreservationMethod.dansHuile: 'In oil',
    PreservationMethod.auVinaigre: 'Pickled',
  },
};

/// Le nom d'une méthode de conservation dans la langue de l'interface.
String methodLabelIn(PreservationMethod method, String languageCode) =>
    _methodLabels[languageCode]?[method] ?? method.label;

/// Les unités de durée, par langue.
///
/// `dureeLisible()` vit dans `recipes.dart` et parle français : « 45
/// min », « 1 h 30 », « 3 semaines ». Traduire les étapes en laissant
/// « 3 semaines » sous un titre anglais, c'est exactement le travail à
/// moitié fait dont on veut sortir.
const Map<String, List<String>> _unitesDuree = <String, List<String>>{
  // [min, h, jour, jours, semaines, mois]
  'en': <String>['min', 'h', 'day', 'days', 'weeks', 'months'],
};

/// « 45 min », « 1 h 30 », « 3 weeks » — la durée dans la langue de
/// l'interface.
///
/// Même découpage que `dureeLisible()`, dont ce sont les seuils : en
/// dessous d'une heure les minutes, puis les heures, puis les jours à
/// partir d'un jour, les semaines à partir de deux, les mois à partir
/// de neuf semaines.
String dureeLisibleIn(int minutes, String languageCode) {
  final u = _unitesDuree[languageCode];
  if (u == null) return dureeLisible(minutes);
  if (minutes < 60) return '$minutes ${u[0]}';
  if (minutes < 24 * 60) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0
        ? '$h ${u[1]}'
        : '$h ${u[1]} ${m.toString().padLeft(2, '0')}';
  }
  final jours = (minutes / (24 * 60)).round();
  if (jours < 14) return jours == 1 ? '1 ${u[2]}' : '$jours ${u[3]}';
  final semaines = (jours / 7).round();
  if (semaines < 9) return '$semaines ${u[4]}';
  return '${(jours / 30).round()} ${u[5]}';
}

/// « 4 pers. » — le nombre de parts, dans la langue de l'interface.
const Map<String, String> _libellePartsCourt = <String, String>{
  'en': 'servings',
};

/// Les libellés du lecteur de recettes, par langue.
///
/// `assets/recipes/recipe_player.html` est **un seul document hors
/// ligne** : il ne peut pas lire les ARB de Flutter. Ses propres
/// libellés voyagent donc dans le JSON, à côté de la recette.
///
/// Sans ça, une recette traduite s'ouvrait dans un lecteur qui disait
/// encore « Ce qu'il te faut » et « étape 1 » : du texte anglais dans
/// une boîte française. Vérifié à l'écran le 02/11/2026, c'était le
/// cas.
///
/// Une clé manquante retombe sur le français, côté JavaScript.
const Map<String, Map<String, dynamic>> _playerUi =
    <String, Map<String, dynamic>>{
  'en': <String, dynamic>{
    'intro': 'Here we go!',
    'depart': 'Let\'s go 🌱',
    'suivant': 'Next',
    'termine': 'Done',
    'revoir': 'See the recipe again',
    'etape': 'step',
    'etapePrec': 'Previous step',
    'ilTeFaut': 'What you need',
    'rien': 'It all happens in the steps 🌱',
    'etiquette': 'Write this on the label',
    'prepareLe': 'Made on',
    'pret': 'Ready!',
    'pretCourt': '⏰ Ready',
    'tourne': 'Running… I ring when it is done',
    'pause': 'Paused',
    'quandPret': ', whenever you are ready',
    'relancer': '↺ Restart',
    'enPause': '❚❚ Pause',
    'reprendre': '▶ Resume',
    'lancer': '▶ Start',
    'premier': '1st',
    'uMin': 'min',
    'uH': 'h',
    'mois': <String>[
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ],
  },
};

/// Les libellés à injecter dans le lecteur, ou null en français.
Map<String, dynamic>? playerUiFor(String languageCode) =>
    _playerUi[languageCode];

/// Le nom d'une recette dans la langue demandée, le français sinon.
String recipeNameIn(Recipe recipe, String languageCode) {
  final t = recipeTextFor(recipe, languageCode)?.name;
  return (t == null || t.isEmpty) ? recipe.name : t;
}

/// La phrase d'accroche d'une recette, traduite ou française.
String recipeDescriptionIn(Recipe recipe, String languageCode) {
  final t = recipeTextFor(recipe, languageCode)?.description;
  return (t == null || t.isEmpty) ? recipe.description : t;
}

/// « 1 an au placard », traduit ou français.
String? recipeKeepsIn(Recipe recipe, String languageCode) {
  final t = recipeTextFor(recipe, languageCode)?.keeps;
  return (t == null || t.isEmpty) ? recipe.keeps : t;
}

/// Les ingrédients traduits, ou les français.
///
/// Une liste de longueur différente est refusée **en entier** : les
/// quantités seraient attribuées au mauvais ingrédient.
List<String> recipeIngredientsIn(Recipe recipe, String languageCode) {
  final t = recipeTextFor(recipe, languageCode)?.ingredients;
  if (t == null || t.length != recipe.ingredients.length) {
    return recipe.ingredients;
  }
  return <String>[
    for (var i = 0; i < t.length; i++)
      t[i].isEmpty ? recipe.ingredients[i] : t[i],
  ];
}

/// Les étapes traduites : le texte change, l'emoji et le minuteur
/// restent ceux du catalogue.
///
/// Une liste de longueur différente est refusée en entier — mieux vaut
/// une recette française qu'une recette dont l'étape 4 répond à
/// l'étape 5.
List<RecipeStep> recipeStepsIn(Recipe recipe, String languageCode) {
  final t = recipeTextFor(recipe, languageCode)?.steps;
  if (t == null || t.length != recipe.steps.length) return recipe.steps;
  return <RecipeStep>[
    for (var i = 0; i < t.length; i++)
      if (t[i].isEmpty)
        recipe.steps[i]
      else
        RecipeStep(recipe.steps[i].emoji, t[i],
            minutes: recipe.steps[i].minutes),
  ];
}

/// Ce qu'une recette montre à l'écran, dans la langue de l'interface.
///
/// Sans contexte, comme `Vegetable.displayName` : la langue vit dans
/// les préférences. Faire porter un `BuildContext` à chaque appel
/// aurait surtout produit des oublis.
///
/// `recipe.name` reste le nom français — source des clés de favoris, de
/// la recherche sans accent et des tests. `recipe.displayName` est ce
/// qu'on affiche. Les deux coexistent exprès.
extension RecipeLocalized on Recipe {
  String get _langue => PrefsService.instance.effectiveLanguage;

  String get displayName => recipeNameIn(this, _langue);

  String get displayDescription => recipeDescriptionIn(this, _langue);

  String? get displayKeeps => recipeKeepsIn(this, _langue);

  List<String> get displayIngredients => recipeIngredientsIn(this, _langue);

  List<RecipeStep> get displaySteps => recipeStepsIn(this, _langue);

  /// Le libellé de la méthode de conservation, traduit.
  String? get displayMethodLabel {
    final m = method;
    if (m == null) return null;
    return methodLabelIn(m, PrefsService.instance.effectiveLanguage);
  }

  /// « 35 min · 4 pers. », dans la langue de l'interface.
  String? get displaySubtitle {
    final langue = PrefsService.instance.effectiveLanguage;
    final parts = _libellePartsCourt[langue] ?? 'pers.';
    final bouts = <String>[
      if (minutes != null) dureeLisibleIn(minutes!, langue),
      if (serves != null) '$serves $parts',
    ];
    return bouts.isEmpty ? null : bouts.join('  ·  ');
  }
}
