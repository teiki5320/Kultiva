import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @tabHome.
  ///
  /// In fr, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabCahier.
  ///
  /// In fr, this message translates to:
  /// **'Cahier'**
  String get tabCahier;

  /// No description provided for @tabEtal.
  ///
  /// In fr, this message translates to:
  /// **'Étal'**
  String get tabEtal;

  /// No description provided for @tabTutos.
  ///
  /// In fr, this message translates to:
  /// **'Tutos'**
  String get tabTutos;

  /// No description provided for @tabRecettes.
  ///
  /// In fr, this message translates to:
  /// **'Recettes'**
  String get tabRecettes;

  /// No description provided for @commonAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get commonAll;

  /// No description provided for @commonCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get commonDelete;

  /// No description provided for @commonClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get commonClose;

  /// No description provided for @commonBack.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get commonBack;

  /// No description provided for @commonNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get commonNext;

  /// No description provided for @commonDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get commonDone;

  /// No description provided for @commonSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get commonSearch;

  /// No description provided for @photosTitle.
  ///
  /// In fr, this message translates to:
  /// **'Photos'**
  String get photosTitle;

  /// No description provided for @photosFilm.
  ///
  /// In fr, this message translates to:
  /// **'Pellicule'**
  String get photosFilm;

  /// No description provided for @photosEvolution.
  ///
  /// In fr, this message translates to:
  /// **'Évolution'**
  String get photosEvolution;

  /// No description provided for @photosTake.
  ///
  /// In fr, this message translates to:
  /// **'Photographier'**
  String get photosTake;

  /// No description provided for @photosNoMemories.
  ///
  /// In fr, this message translates to:
  /// **'Le jardin n\'a pas encore de souvenirs'**
  String get photosNoMemories;

  /// No description provided for @photosCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 photo du jardin} other{{count} photos du jardin}}'**
  String photosCount(int count);

  /// No description provided for @photosEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune photo pour l\'instant'**
  String get photosEmptyTitle;

  /// No description provided for @photosEmptyBody.
  ///
  /// In fr, this message translates to:
  /// **'Photographie un plant aujourd\'hui, puis le même dans une semaine : c\'est en les voyant côte à côte qu\'on se rend compte que ça pousse.'**
  String get photosEmptyBody;

  /// No description provided for @photosEmptyPlantsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun plant photographié'**
  String get photosEmptyPlantsTitle;

  /// No description provided for @photosEmptyPlantsBody.
  ///
  /// In fr, this message translates to:
  /// **'Dès qu\'un plant a deux photos, Kultiva les met côte à côte et compte les jours entre les deux.'**
  String get photosEmptyPlantsBody;

  /// No description provided for @photosWhichPlant.
  ///
  /// In fr, this message translates to:
  /// **'Quel plant photographies-tu ?'**
  String get photosWhichPlant;

  /// No description provided for @photosPlantFirst.
  ///
  /// In fr, this message translates to:
  /// **'Plante d\'abord quelque chose : une photo s\'accroche à un plant.'**
  String get photosPlantFirst;

  /// No description provided for @photosDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cette photo ?'**
  String get photosDeleteTitle;

  /// No description provided for @photosDeleteBody.
  ///
  /// In fr, this message translates to:
  /// **'Elle sera effacée de l\'appareil. Kultiva ne garde aucune copie ailleurs, donc c\'est définitif.'**
  String get photosDeleteBody;

  /// No description provided for @photosGone.
  ///
  /// In fr, this message translates to:
  /// **'Cette photo n\'est plus sur l\'appareil.'**
  String get photosGone;

  /// No description provided for @photosAgeDay.
  ///
  /// In fr, this message translates to:
  /// **'J+{days}'**
  String photosAgeDay(int days);

  /// No description provided for @recipesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recettes'**
  String get recipesTitle;

  /// No description provided for @recipesSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'{recipes} recettes pour {crops} récoltes'**
  String recipesSubtitle(int recipes, int crops);

  /// No description provided for @recipesSearchHint.
  ///
  /// In fr, this message translates to:
  /// **'Un légume, ou un plat…'**
  String get recipesSearchHint;

  /// No description provided for @recipesInYourGarden.
  ///
  /// In fr, this message translates to:
  /// **'Dans ton jardin'**
  String get recipesInYourGarden;

  /// No description provided for @recipesNoStepsYet.
  ///
  /// In fr, this message translates to:
  /// **'Le pas-à-pas animé de cette recette n\'est pas encore écrit — il arrive.'**
  String get recipesNoStepsYet;

  /// No description provided for @recipesIngredients.
  ///
  /// In fr, this message translates to:
  /// **'Ce qu\'il te faut'**
  String get recipesIngredients;

  /// No description provided for @recipesStep.
  ///
  /// In fr, this message translates to:
  /// **'Étape {current} sur {total}'**
  String recipesStep(int current, int total);

  /// No description provided for @recipesBonAppetit.
  ///
  /// In fr, this message translates to:
  /// **'Bon appétit !'**
  String get recipesBonAppetit;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In fr, this message translates to:
  /// **'Celle du téléphone'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguagePartial.
  ///
  /// In fr, this message translates to:
  /// **'L\'interface est traduite. Le catalogue, les tutos et les recettes restent en français pour l\'instant.'**
  String get settingsLanguagePartial;
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return LEn();
    case 'fr':
      return LFr();
  }

  throw FlutterError(
      'L.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
