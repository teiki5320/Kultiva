import 'package:flutter/foundation.dart';

import '../data/recipes.dart';
import 'prefs_service.dart';

/// Ce que l'utilisateur fait de ses recettes : celles qu'il met de
/// côté, et celles qu'il a déjà cuisinées.
///
/// Propriétaire **unique** de ces deux registres, comme
/// `PlantationService` l'est des plants. Les écrans ne touchent pas
/// `SharedPreferences` directement, et ne tiennent aucun compteur
/// parallèle : ils écoutent [version] et relisent.
class RecipeService {
  RecipeService._();

  static final RecipeService instance = RecipeService._();

  /// Incrémenté à chaque écriture. Les listes s'y abonnent.
  final ValueNotifier<int> version = ValueNotifier<int>(0);

  /// La clé d'une recette.
  ///
  /// Le nom seul ne suffit pas : deux légumes différents peuvent
  /// nommer pareil (« Soupe », « Gratin »), et seul l'unicité **par
  /// légume** est garantie par les tests. On préfixe donc par le
  /// légume.
  static String keyFor(String vegetableId, Recipe recipe) =>
      '$vegetableId/${recipe.name}';

  // ─────────────────────────── Favoris ───────────────────────────

  Set<String> get favorites => PrefsService.instance.recipeFavorites;

  bool isFavorite(String key) => favorites.contains(key);

  Future<void> toggleFavorite(String key) async {
    final next = favorites;
    if (!next.remove(key)) next.add(key);
    await PrefsService.instance.setRecipeFavorites(next);
    version.value++;
  }

  // ────────────────────────── Déjà cuisiné ──────────────────────────

  /// Dernière fois que chaque recette a été cuisinée.
  ///
  /// Décodage tolérant : une ligne illisible est ignorée plutôt que de
  /// faire perdre tout l'historique. C'est la leçon du décodage de
  /// `garden_plan`.
  Map<String, DateTime> get cookedAt {
    final out = <String, DateTime>{};
    for (final ligne in PrefsService.instance.recipeCookedRaw) {
      final sep = ligne.lastIndexOf('|');
      if (sep <= 0) continue;
      final quand = DateTime.tryParse(ligne.substring(sep + 1));
      if (quand == null) continue;
      final cle = ligne.substring(0, sep);
      // Si la même recette apparaît deux fois, on garde la plus récente.
      final deja = out[cle];
      if (deja == null || quand.isAfter(deja)) out[cle] = quand;
    }
    return out;
  }

  DateTime? cookedOn(String key) => cookedAt[key];

  bool hasCooked(String key) => cookedAt.containsKey(key);

  /// Combien de recettes différentes ont été cuisinées au moins une
  /// fois. De quoi nourrir un badge un jour, sans stocker de compteur.
  int get cookedCount => cookedAt.length;

  Future<void> markCooked(String key, {DateTime? when}) async {
    final tout = cookedAt..[key] = when ?? DateTime.now();
    await _ecrire(tout);
  }

  Future<void> unmarkCooked(String key) async {
    final tout = cookedAt..remove(key);
    await _ecrire(tout);
  }

  Future<void> _ecrire(Map<String, DateTime> tout) async {
    await PrefsService.instance.setRecipeCookedRaw(
      tout.entries
          .map((e) => '${e.key}|${e.value.toIso8601String()}')
          .toList(growable: false),
    );
    version.value++;
  }
}
