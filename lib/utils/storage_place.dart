import '../data/recipes.dart';
import '../data/ui_i18n.dart';

/// Où se range une conservation : congélateur, placard ou réfrigérateur.
///
/// Ajouté le 06/11/2026 pour l'onglet Conservation (maquette « F · Les
/// portes qui s'ouvrent », validée par Jean) : on choisit d'abord le
/// meuble, puis ce qu'on peut y mettre. C'est la question qu'on se pose
/// devant un congélateur plein — ou vide.
///
/// ⚠️ **Aucune donnée nouvelle.** Le meuble se lit dans `Recipe.keeps`,
/// la durée de garde déjà écrite en toutes lettres pour les 369
/// conservations (« 8 mois au congélateur », « 1 an au sec, à l'abri de
/// la lumière »). Un second champ aurait pu dire autre chose que la
/// phrase affichée juste à côté. On lit le **français** : c'est la
/// source, et les traductions ne touchent pas au sens.
enum StoragePlace {
  freezer,
  cupboard,
  fridge;

  String get label {
    switch (this) {
      case StoragePlace.freezer:
        return trUi('Congélateur');
      case StoragePlace.cupboard:
        return trUi('Placard');
      case StoragePlace.fridge:
        return trUi('Réfrigérateur');
    }
  }

  /// Le titre de l'étagère, une fois la porte ouverte.
  String get insideLabel {
    switch (this) {
      case StoragePlace.freezer:
        return trUi('Dans le congélateur');
      case StoragePlace.cupboard:
        return trUi('Dans le placard');
      case StoragePlace.fridge:
        return trUi('Dans le réfrigérateur');
    }
  }

  /// Pour un écran vide : « Aucune recette pour le placard. »
  String get forLabel {
    switch (this) {
      case StoragePlace.freezer:
        return trUi('pour le congélateur');
      case StoragePlace.cupboard:
        return trUi('pour le placard');
      case StoragePlace.fridge:
        return trUi('pour le réfrigérateur');
    }
  }
}

/// Le meuble d'une recette, ou `null` pour un plat du jour même.
///
/// L'ordre des tests compte : une phrase qui cite le congélateur est
/// une conservation de congélateur, même si elle parle aussi du
/// réfrigérateur après décongélation. Ce qui n'est ni froid ni frais —
/// « au sec », « au placard », « à l'abri de la lumière », « en
/// bocal » — va au placard. Mesuré le 06/11/2026 sur les 369
/// conservations : 167 au congélateur, 96 au réfrigérateur, 106 au
/// placard.
StoragePlace? storagePlaceOf(Recipe recipe) {
  if (recipe.method == null) return null;
  final keeps = recipe.keeps?.toLowerCase();
  if (keeps == null || keeps.isEmpty) return null;
  if (keeps.contains('congél')) return StoragePlace.freezer;
  if (keeps.contains('réfrigérateur') || keeps.contains('frigo')) {
    return StoragePlace.fridge;
  }
  // « au sec, au frais et à l'ombre », « en coque, au sec et au
  // frais » : un cellier, pas un réfrigérateur. Le sec l'emporte.
  if (keeps.contains('au sec')) return StoragePlace.cupboard;
  // « 6 mois au frais, dans l'huile » : tout ce qui est dans l'huile
  // se garde au réfrigérateur (règle de sécurité de CLAUDE.md).
  if (keeps.contains('frais')) return StoragePlace.fridge;
  return StoragePlace.cupboard;
}

/// « 8 mois », « 1 an », « 3 semaines » : le début de la durée de garde,
/// assez court pour l'étiquette d'un bocal.
String shortKeeps(String keeps) {
  final mots = keeps.trim().split(RegExp(r'\s+'));
  return mots.take(2).join(' ');
}
