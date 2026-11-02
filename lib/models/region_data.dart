import '../data/ui_i18n.dart';
/// Région active pour l'affichage des calendriers de semis / récolte.
///
/// Extensible — pour ajouter une nouvelle région, ajoute une valeur d'enum
/// et crée le fichier correspondant dans `lib/data/regions/`.
enum Region {
  /// Base **tempérée** : le calendrier européen des quatre saisons.
  /// Les zones méditerranéenne, continentale et subtropicale en
  /// dérivent par décalage (voir `zone_shift.dart`).
  france('france', 'France', '🇫🇷'),

  /// Base **tropicale** + contenu culturel ouest-africain : noms
  /// locaux, maraîchage en FCFA, conseils d'achat au marché, recettes.
  westAfrica('west_africa', "Afrique de l'Ouest", '🌍'),

  /// Base tropicale **sans** le contenu ouest-africain.
  ///
  /// Ajoutée le 01/11/2026 avec la couverture mondiale. Sans elle, un
  /// jardinier brésilien ou vietnamien aurait hérité des prix en FCFA
  /// et des noms en wolof, parce que le calendrier tropical et le
  /// contenu ouest-africain tenaient dans la même valeur d'enum.
  tropical('tropical', 'Zone tropicale', '🌴');

  final String id;
  final String label;
  final String emoji;

  const Region(this.id, this.label, this.emoji);

  /// Le nom de la région dans la langue affichée.
  ///
  /// ⚠️ [label] est un champ d'un enum `const` : il ne peut pas
  /// appeler de fonction, donc il reste le français. C'est **ce
  /// getter** qu'il faut afficher, jamais [label] — même règle que
  /// `Vegetable.displayName`.
  String get displayLabel => trUi(label);

  /// Vrai si le calendrier suit les pluies plutôt que les saisons
  /// thermiques. À préférer à `== Region.westAfrica` partout où la
  /// question est climatique et non culturelle.
  bool get isTropicalBase =>
      this == Region.westAfrica || this == Region.tropical;

  static Region fromId(String? id) {
    if (id == null) return Region.france;
    for (final r in Region.values) {
      if (r.id == id) return r;
    }
    return Region.france;
  }
}

/// Données de semis et récolte pour un légume dans une région donnée.
///
/// Les listes [sowingMonths] et [harvestMonths] contiennent des numéros de
/// mois entre 1 (janvier) et 12 (décembre).
///
/// [regionalNote] permet d'indiquer une adaptation propre à la région (ex :
/// "Cultiver sous serre chauffée en France", "Préférer la saison sèche").
/// Ce champ est optionnel et ne s'affiche que s'il est renseigné.
class RegionData {
  final String regionId;
  final String vegetableId;
  final List<int> sowingMonths;
  final List<int> harvestMonths;
  final String? regionalNote;

  const RegionData({
    required this.regionId,
    required this.vegetableId,
    required this.sowingMonths,
    required this.harvestMonths,
    this.regionalNote,
  });
}
