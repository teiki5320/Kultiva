import '../services/prefs_service.dart';
import 'badges.dart';
import 'challenges.dart';
import 'content_en.dart';
import 'diseases.dart';
import 'lexicon.dart';

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
  String get displayTerm => tr(term);
  String get displayDefinition => tr(definition);
}

/// Un badge, dans la langue de l'interface.
///
/// ⚠️ `id` ne bouge jamais : les 50 médaillons sont des fichiers nommés
/// d'après lui (`assets/images/badges/<id>.webp`).
extension BadgeLocalized on PoussidexBadge {
  String get displayName => tr(name);
  String get displayDescription => tr(description);
}

/// Un défi photo, dans la langue de l'interface.
///
/// La variante ouest-africaine (`waName`, `waDescription`) se traduit
/// comme le reste : un anglophone au Ghana ou au Nigeria voit le défi
/// local, en anglais.
extension ChallengeLocalized on PhotoChallenge {
  String get displayName => tr(name);
  String get displayDescription => tr(description);
  String? get displayWaName => waName == null ? null : tr(waName!);
  String? get displayWaDescription =>
      waDescription == null ? null : tr(waDescription!);
}
