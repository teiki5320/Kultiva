import '../services/prefs_service.dart';
import 'ui_en.dart';
import 'ui_es.dart';

/// **L'interface de l'app, traduite.** Les libellés, titres, boutons,
/// messages vides, textes de notification et conseils composés — tout
/// ce qui n'est ni une recette, ni un tuto, ni une fiche de contenu.
///
/// ## Pourquoi un dictionnaire et pas les ARB
///
/// Le réflexe serait `flutter gen-l10n`. Trois raisons l'écartent ici :
///
/// 1. **La moitié de ces chaînes vit hors d'un widget.**
///    `phenology.dart`, `country.dart`, `notification_service.dart`,
///    `advice_service.dart` et `watering_advisor.dart` en portent plus
///    de 150 à eux seuls, et n'ont aucun `BuildContext`. Un ARB se lit
///    par `AppLocalizations.of(context)` ; il aurait fallu faire
///    descendre un contexte dans des services, c'est-à-dire mélanger
///    présentation et logique métier — ce que les règles du projet
///    interdisent explicitement.
/// 2. **Il aurait fallu nommer 541 clés.** `sowScreenEmptyTitle`,
///    `plannerAdviceHeatwaveBody`… À la première retouche de style, le
///    nom ne décrit plus le texte. La clé est donc **la phrase
///    française elle-même**, comme pour les tutos et le contenu : elle
///    ne ment jamais sur ce qu'elle désigne.
/// 3. **C'est le patron des trois autres surcouches.** Un seul modèle
///    mental pour toute la traduction du projet, au lieu de deux.
///
/// Les ARB restent pour ce qu'ils font mieux : les cinq libellés
/// d'onglets (ils ont un contexte, et `RootTabs` les lit une fois) et
/// la note du réglage « Langue ». Voir `lib/l10n/`.
///
/// ## Les conséquences, les mêmes que partout
///
/// - une phrase française corrigée perd sa traduction et **reste en
///   français**. Pas de traduction fantôme qui survit à une
///   correction ;
/// - une clé absente ou vide retombe sur le français ;
/// - les nombres ne se traduisent pas, et `test/ui_i18n_test.dart` le
///   vérifie.
const Map<String, Map<String, String>> uiTextsByLanguage =
    <String, Map<String, String>>{
  'en': uiTextsEn,
  'es': uiTextsEs,
};

/// Une chaîne d'interface, dans la langue demandée, le français sinon.
///
/// Prend la langue en paramètre : les tests tournent en `en-US`, donc
/// un test qui appellerait [trUi] lirait de l'anglais en croyant lire
/// du français.
String trUiIn(String fr, String languageCode) {
  final dico = uiTextsByLanguage[languageCode];
  if (dico == null) return fr;
  final t = dico[fr];
  return (t == null || t.isEmpty) ? fr : t;
}

/// Une chaîne d'interface, dans la langue affichée.
String trUi(String fr) => trUiIn(fr, PrefsService.instance.effectiveLanguage);

/// Une chaîne à trous, dans la langue demandée.
///
/// Les 107 chaînes composées de l'app étaient écrites par
/// interpolation : `'$n ans avant de replanter'`. Une valeur
/// interpolée change à chaque appel, donc ne peut pas servir de clé.
/// Le modèle garde donc des trous numérotés :
///
/// ```dart
/// trUiArgs('{0} ans avant de replanter au même endroit', <Object?>[3])
/// ```
///
/// ⚠️ **Les trous se renumérotent dans la traduction, pas les
/// valeurs.** Une langue qui met le nombre à la fin écrit
/// `'wait {0} years before replanting'`. C'est tout l'intérêt d'un
/// trou plutôt que d'une concaténation : l'ordre des mots est libre.
///
/// Un trou absent de la traduction ferait disparaître la valeur en
/// silence ; `test/ui_i18n_test.dart` le refuse.
String trUiArgsIn(String fr, List<Object?> args, String languageCode) {
  var out = trUiIn(fr, languageCode);
  for (var i = 0; i < args.length; i++) {
    out = out.replaceAll('{$i}', '${args[i]}');
  }
  return out;
}

/// Une chaîne à trous, dans la langue affichée.
String trUiArgs(String fr, List<Object?> args) =>
    trUiArgsIn(fr, args, PrefsService.instance.effectiveLanguage);

// ─────────────────────────────────────────────────────────────────────
// Les mois et les jours : une table par langue, pas des clés
// ─────────────────────────────────────────────────────────────────────

/// ⚠️ **Pourquoi ceux-là échappent au dictionnaire.**
///
/// Les mois et les jours sont le seul endroit où la clé « phrase
/// française » ne marche pas, et le branchement du 02/11/2026 s'y est
/// cogné deux fois :
///
/// - « juin » est à la fois le mois court et le mois long. En anglais
///   ils diffèrent (« jun » / « june »), donc **une clé devrait rendre
///   deux valeurs**. Pareil pour « août », « Juin », « Août » ;
/// - « Mar » est à la fois **mardi** et **mars**. Une seule clé pour
///   deux sens sans rapport : le jeudi de la météo serait devenu un
///   mois.
///
/// Ce sont des ensembles **fermés et ordonnés** de douze et de sept
/// valeurs, pas du texte libre. Une table indexée dit donc la chose
/// juste, là où un dictionnaire de phrases ment. Même raisonnement que
/// `names_en.dart` pour les 130 cultures.
///
/// Une langue absente retombe sur le français, comme partout.
const Map<String, List<String>> _moisLongs = <String, List<String>>{
  'fr': <String>['janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'],
  'en': <String>['january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december'],
  'es': <String>['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'],
};

const Map<String, List<String>> _moisCourts = <String, List<String>>{
  'fr': <String>['jan', 'fév', 'mar', 'avr', 'mai', 'juin',
      'juil', 'août', 'sep', 'oct', 'nov', 'déc'],
  'en': <String>['jan', 'feb', 'mar', 'apr', 'may', 'jun',
      'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
  'es': <String>['ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'],
};

/// Lundi en premier, comme la semaine française et espagnole.
/// `DateTime.weekday` vaut 1 pour lundi : l'index est `weekday - 1`.
const Map<String, List<String>> _joursCourts = <String, List<String>>{
  'fr': <String>['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
  'en': <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  'es': <String>['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
};

List<String> _table(Map<String, List<String>> t, String langue) =>
    t[langue] ?? t['fr']!;

/// La première lettre en capitale, pour un titre de section.
///
/// L'espagnol écrit ses mois en minuscule dans une phrase, mais un
/// titre les capitalise comme ailleurs : « Noviembre ».
String capitaliser(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// Les douze mois, forme longue, dans la langue demandée.
List<String> monthNamesLongIn(String langue) => _table(_moisLongs, langue);

/// Les douze mois, forme abrégée, dans la langue demandée.
List<String> monthNamesShortIn(String langue) => _table(_moisCourts, langue);

/// Les sept jours, forme abrégée, lundi en premier.
List<String> weekdayNamesShortIn(String langue) =>
    _table(_joursCourts, langue);
