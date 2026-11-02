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
  /// thermiques.
  ///
  /// ⚠️ **Ce n'est plus la bonne question depuis le 02/11/2026.** Le
  /// climat est une propriété de la **zone** (`ClimateZone.isTropical`),
  /// pas de la région : l'Australie est en région tempérée et Darwin
  /// est tropical, le Brésil est en région tropicale et São Paulo
  /// gèle. Une région ne dit plus que le **contenu** — ouest-africain
  /// ou non.
  ///
  /// Il ne reste de légitime qu'un usage : **choisir une zone par
  /// défaut** quand aucune n'est connue, faute de mieux. Trois
  /// endroits le font, et ils le disent.
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

  /// Vrai quand la culture ne tient pas dehors ici : serre chauffée,
  /// pot rentré l'hiver, ou sud méditerranéen seulement.
  ///
  /// ⚠️ **Cette information existait déjà, mais en prose.** Vingt-six
  /// notes régionales disaient « non adapté au climat français » ou
  /// « besoin de froid hivernal », et le code n'en savait rien : en
  /// mai, l'écran Semer d'un jardinier lyonnais comptait le manioc,
  /// le taro et l'igname parmi les légumes à semer. Signalé par Jean
  /// le 02/11/2026 — « certains produits ne devraient pas être en
  /// Europe ».
  ///
  /// Le choix retenu est de **les montrer quand même**, avec une
  /// pastille « sous serre » : un jardinier qui a une serre les
  /// cherche, et cacher une culture est une décision qu'on prend à sa
  /// place.
  ///
  /// ⚠️ C'est une propriété du **couple culture + zone**, pas de la
  /// culture. La pastèque est sous serre à Lille et en pleine terre à
  /// Séville : la surcharge méditerranéenne la perd, et c'est voulu
  /// (voir `deriveTemperate`).
  final bool shelterOnly;

  const RegionData({
    required this.regionId,
    required this.vegetableId,
    required this.sowingMonths,
    required this.harvestMonths,
    this.regionalNote,
    this.shelterOnly = false,
  });
}
