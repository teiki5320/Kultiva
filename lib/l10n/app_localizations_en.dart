// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabCahier => 'Journal';

  @override
  String get tabEtal => 'Catalog';

  @override
  String get tabTutos => 'Guides';

  @override
  String get tabRecettes => 'Recipes';

  @override
  String get commonAll => 'All';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonClose => 'Close';

  @override
  String get commonBack => 'Back';

  @override
  String get commonNext => 'Next';

  @override
  String get commonDone => 'Done';

  @override
  String get commonSearch => 'Search';

  @override
  String get photosTitle => 'Photos';

  @override
  String get photosFilm => 'Roll';

  @override
  String get photosEvolution => 'Growth';

  @override
  String get photosTake => 'Take a photo';

  @override
  String get photosNoMemories => 'Your garden has no memories yet';

  @override
  String photosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garden photos',
      one: '1 garden photo',
    );
    return '$_temp0';
  }

  @override
  String get photosEmptyTitle => 'No photos yet';

  @override
  String get photosEmptyBody =>
      'Photograph a plant today, then the same one a week later: seeing them side by side is how you notice it growing.';

  @override
  String get photosEmptyPlantsTitle => 'No plant photographed yet';

  @override
  String get photosEmptyPlantsBody =>
      'As soon as a plant has two photos, Kultiva puts them side by side and counts the days between them.';

  @override
  String get photosWhichPlant => 'Which plant are you photographing?';

  @override
  String get photosPlantFirst =>
      'Plant something first: a photo belongs to a plant.';

  @override
  String get photosDeleteTitle => 'Delete this photo?';

  @override
  String get photosDeleteBody =>
      'It will be erased from your device. Kultiva keeps no copy anywhere else, so this is permanent.';

  @override
  String get photosGone => 'This photo is no longer on your device.';

  @override
  String photosAgeDay(int days) {
    return 'D+$days';
  }

  @override
  String get recipesTitle => 'Recipes';

  @override
  String recipesSubtitle(int recipes, int crops) {
    return '$recipes recipes for $crops crops';
  }

  @override
  String get recipesSearchHint => 'A vegetable, or a dish…';

  @override
  String get recipesInYourGarden => 'In your garden';

  @override
  String get recipesNoStepsYet =>
      'The step-by-step version of this recipe isn\'t written yet — it\'s coming.';

  @override
  String get recipesIngredients => 'What you need';

  @override
  String recipesStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get recipesBonAppetit => 'Enjoy your meal!';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'Your phone\'s language';

  @override
  String get settingsLanguagePartial =>
      'English is complete: interface, catalogue, the 736 recipes, the 33 guides and the advice. French is the source language. Spanish has the interface and the crop names so far.';
}
