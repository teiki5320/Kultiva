// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabCahier => 'Cahier';

  @override
  String get tabEtal => 'Étal';

  @override
  String get tabTutos => 'Tutos';

  @override
  String get tabRecettes => 'Recettes';

  @override
  String get commonAll => 'Tout';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get photosTitle => 'Photos';

  @override
  String get photosFilm => 'Pellicule';

  @override
  String get photosEvolution => 'Évolution';

  @override
  String get photosTake => 'Photographier';

  @override
  String get photosNoMemories => 'Le jardin n\'a pas encore de souvenirs';

  @override
  String photosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos du jardin',
      one: '1 photo du jardin',
    );
    return '$_temp0';
  }

  @override
  String get photosEmptyTitle => 'Aucune photo pour l\'instant';

  @override
  String get photosEmptyBody =>
      'Photographie un plant aujourd\'hui, puis le même dans une semaine : c\'est en les voyant côte à côte qu\'on se rend compte que ça pousse.';

  @override
  String get photosEmptyPlantsTitle => 'Aucun plant photographié';

  @override
  String get photosEmptyPlantsBody =>
      'Dès qu\'un plant a deux photos, Kultiva les met côte à côte et compte les jours entre les deux.';

  @override
  String get photosWhichPlant => 'Quel plant photographies-tu ?';

  @override
  String get photosPlantFirst =>
      'Plante d\'abord quelque chose : une photo s\'accroche à un plant.';

  @override
  String get photosDeleteTitle => 'Supprimer cette photo ?';

  @override
  String get photosDeleteBody =>
      'Elle sera effacée de l\'appareil. Kultiva ne garde aucune copie ailleurs, donc c\'est définitif.';

  @override
  String get photosGone => 'Cette photo n\'est plus sur l\'appareil.';

  @override
  String photosAgeDay(int days) {
    return 'J+$days';
  }

  @override
  String get recipesTitle => 'Recettes';

  @override
  String recipesSubtitle(int recipes, int crops) {
    return '$recipes recettes pour $crops récoltes';
  }

  @override
  String get recipesSearchHint => 'Un légume, ou un plat…';

  @override
  String get recipesInYourGarden => 'Dans ton jardin';

  @override
  String get recipesNoStepsYet =>
      'Le pas-à-pas animé de cette recette n\'est pas encore écrit — il arrive.';

  @override
  String get recipesIngredients => 'Ce qu\'il te faut';

  @override
  String recipesStep(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get recipesBonAppetit => 'Bon appétit !';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Celle du téléphone';

  @override
  String get settingsLanguagePartial =>
      'Le français est la langue source : tout y est. L\'anglais est complet lui aussi — interface, catalogue, recettes, tutos et conseils. L\'espagnol n\'a pour l\'instant que l\'interface et les noms de légumes.';
}
