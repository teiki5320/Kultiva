import '../services/prefs_service.dart';
import 'badges.dart';
import 'challenges.dart';
import 'content_en.dart';
import 'content_es.dart';
import 'accessory_guide.dart';
import 'diseases.dart';
import 'lexicon.dart';
import '../models/vegetable.dart';

/// Le reste du contenu de l'app, traduit : maladies, badges, défis,
/// lexique, familles botaniques, conseils canicule, achat au marché.
///
/// Environ 8 600 mots — le dernier tiers après les recettes (58 000) et
/// les tutos (11 000). C'est peu, mais c'est ce qui restait entre
/// « l'app est traduisible » et « l'app est traduite ».
///
/// **Un seul dictionnaire pour tout**, là où les recettes ont leur
/// propre surcouche. La différence tient à la forme des données : une
/// recette est un objet à cinq champs, qu'on recouvre champ par champ ;
/// ici ce sont des phrases isolées, chacune unique. La clé peut donc
/// être **la phrase française elle-même**, comme pour les tutos.
///
/// Conséquences, les mêmes que partout :
///
/// - une phrase française corrigée perd sa traduction et **reste en
///   français**. Pas de traduction fantôme qui survit à une
///   correction ;
/// - une clé absente ou vide retombe sur le français. On traduit par
///   morceaux ;
/// - les nombres ne se traduisent pas, et `test/content_i18n_test.dart`
///   le vérifie : « 3-4 ans », « 10% de lait », « tous les 2 jours »
///   sont des conseils, pas du style.
///
/// ⚠️ **Le compagnonnage n'est pas ici**, et n'en a pas besoin :
/// `companions.dart` ne contient que des identifiants de légumes, déjà
/// traduits par `Vegetable.displayName`.
const Map<String, Map<String, String>> contentTextsByLanguage =
    <String, Map<String, String>>{
  'en': contentTextsEn,
  'es': contentTextsEs,
};

/// Une phrase du contenu, dans la langue demandée, le français sinon.
String trIn(String fr, String languageCode) {
  final dico = contentTextsByLanguage[languageCode];
  if (dico == null) return fr;
  final t = dico[fr];
  return (t == null || t.isEmpty) ? fr : t;
}

/// Une phrase du contenu, dans la langue de l'interface.
///
/// Sans contexte, comme `Vegetable.displayName` : la langue vit dans
/// les préférences. Les call-sites sont nombreux, et leur faire porter
/// un `BuildContext` aurait surtout produit des oublis.
String tr(String fr) => trIn(fr, PrefsService.instance.effectiveLanguage);

/// Le mode d'emploi d'un accessoire, dans la langue de l'interface.
extension AccessoryGuideLocalized on AccessoryGuide {
  String get displayWhen => tr(when);
  String get displayHow => tr(how);
  String get displayHowMuch => tr(howMuch);
  String get displayCare => tr(care);
  String? get displayDiy => diy == null ? null : tr(diy!);
}

/// Les textes libres d'une fiche du catalogue, dans la langue de
/// l'interface.
///
/// ⚠️ **Rien de tout cela n'était traduit avant le 02/11/2026.** Seul
/// le *nom* des 130 cultures passait par `names_{en,es}.dart` ; la
/// note, la description et les neuf champs techniques de la fiche
/// restaient en français, dans une interface par ailleurs traduite.
/// Trouvé en regardant le catalogue espagnol à l'écran : les chips de
/// sous-catégorie disaient « Herramientas » au-dessus de vignettes
/// nommées « Binette / serfouette ».
///
/// Le nom d'un **accessoire** reste la seule exception : il vit dans
/// `names_{en,es}.dart` avec les cultures, keyé par l'identifiant, et
/// `displayName` le lit déjà. Les 39 y ont été ajoutés le même jour.
extension VegetableTextsLocalized on Vegetable {
  /// La ligne d'accroche, sous le nom.
  String? get displayNote => note == null ? null : tr(note!);

  /// Le paragraphe de présentation.
  String? get displayDescription =>
      description == null ? null : tr(description!);

  String? get displaySowingTechnique =>
      sowingTechnique == null ? null : tr(sowingTechnique!);
  String? get displaySowingDepth =>
      sowingDepth == null ? null : tr(sowingDepth!);
  String? get displayGerminationTemp =>
      germinationTemp == null ? null : tr(germinationTemp!);
  String? get displayGerminationDays =>
      germinationDays == null ? null : tr(germinationDays!);
  String? get displayExposure => exposure == null ? null : tr(exposure!);
  String? get displaySpacing => spacing == null ? null : tr(spacing!);
  String? get displayWatering => watering == null ? null : tr(watering!);
  String? get displaySoil => soil == null ? null : tr(soil!);
  String? get displayYieldEstimate =>
      yieldEstimate == null ? null : tr(yieldEstimate!);

  /// Les durées de récolte par saison. ⚠️ La **clé** est le nom
  /// français de la saison et sert d'identifiant : elle ne se traduit
  /// pas, seule la valeur le fait.
  Map<String, String>? get displayHarvestTimeBySeason =>
      harvestTimeBySeason?.map((k, v) => MapEntry(k, tr(v)));
}

/// Une maladie, dans la langue de l'interface.
extension DiseaseLocalized on Disease {
  String get displayName => tr(name);
  String get displayRemedy => tr(remedy);
}

/// Une entrée du lexique, dans la langue de l'interface.
///
/// ⚠️ `term` reste la clé de détection : `LexiconText` souligne les
/// mots d'un texte en cherchant les termes **français**. Traduire le
/// terme affiché sans traduire le texte qui le contient ne soulignerait
/// plus rien — c'est pour ça que les deux se traduisent ensemble, ou
/// pas du tout.
extension LexiconLocalized on LexiconEntry {
  String get displayDefinition => tr(definition);
}

/// Un badge, dans la langue de l'interface.
///
/// ⚠️ `id` ne bouge jamais : les 50 médaillons sont des fichiers nommés
/// d'après lui (`assets/images/badges/<id>.webp`).
extension BadgeLocalized on GardenBadge {
  String get displayName => tr(name);
  String get displayDescription => tr(description);
}

/// Un défi photo, dans la langue de l'interface.
///
/// ⚠️ La variante ouest-africaine n'a **pas** de getter à elle, et
/// c'est volontaire : `PhotoChallenge.forRegion()` remplace déjà
/// `name` et `description` par `waName` et `waDescription` avant que
/// l'écran les lise. Un `displayWaName` serait un second chemin vers
/// la même phrase — personne ne l'appelait, et les deux auraient
/// divergé.
extension ChallengeLocalized on PhotoChallenge {
  String get displayName => tr(name);
  String get displayDescription => tr(description);
}
