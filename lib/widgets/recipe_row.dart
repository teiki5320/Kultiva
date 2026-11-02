import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../data/names_en.dart';
import '../data/recipes.dart';
import '../data/recipes_i18n.dart';
import '../data/vegetables_base.dart';
import '../screens/home/recettes/recipe_player_screen.dart';
import '../screens/vegetable_detail_screen.dart';
import '../services/error_reporter.dart';
import '../services/recipe_service.dart';
import '../theme/app_theme.dart';
import '../utils/recipe_portions.dart';

/// Une recette dans une liste, partout pareil.
///
/// Ce widget existe parce que la fiche légume affichait ses recettes
/// **sans pouvoir les ouvrir** : le lecteur animé n'était atteignable
/// que depuis l'onglet Recettes, alors que c'est sur la fiche d'un
/// légume qu'on se demande quoi en faire. Deux listes, deux rendus,
/// l'un cliquable et l'autre pas — c'est le genre d'écart qu'un widget
/// commun empêche de recréer.
class RecipeRow extends StatelessWidget {
  /// Le légume auquel la recette appartient, nécessaire pour la clé des
  /// favoris et du « déjà cuisiné ».
  final String vegetableId;
  final Recipe recipe;

  /// Affiche le nom du légume sous la recette. Utile dans une liste qui
  /// mélange les légumes (les favoris), inutile sous une fiche.
  final bool showVegetable;

  const RecipeRow({
    super.key,
    required this.vegetableId,
    required this.recipe,
    this.showVegetable = false,
  });

  String get _cle => RecipeService.keyFor(vegetableId, recipe);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: RecipeService.instance.version,
      builder: (context, _, __) {
        final svc = RecipeService.instance;
        final favori = svc.isFavorite(_cle);
        final cuisineLe = svc.cookedOn(_cle);
        return InkWell(
          onTap: () => openRecipe(context,
              vegetableId: vegetableId, recipe: recipe),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(recipe.emoji, style: const TextStyle(fontSize: 17)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              recipe.displayName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (recipe.isAnimated) ...<Widget>[
                            const SizedBox(width: 6),
                            const Icon(Icons.play_circle_outline,
                                size: 15, color: KultivaColors.primaryGreen),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        recipe.displayDescription,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: KultivaColors.textSecondary,
                        ),
                      ),
                      if (showVegetable) ...<Widget>[
                        const SizedBox(height: 2),
                        Text(
                          vegetableById(vegetableId).displayName,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.primaryGreen,
                          ),
                        ),
                      ],
                      if (recipe.keeps != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: _Garde(recipe: recipe),
                        ),
                      if (recipe.displaySubtitle != null || cuisineLe != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            <String>[
                              if (recipe.displaySubtitle != null)
                                recipe.displaySubtitle!,
                              if (cuisineLe != null)
                                'déjà cuisiné ${dateCourte(cuisineLe)}',
                            ].join('  ·  '),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: KultivaColors.terracotta,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 19,
                  tooltip: favori ? 'Retirer des favoris' : 'Mettre de côté',
                  icon: Icon(
                    favori ? Icons.bookmark : Icons.bookmark_border,
                    color: favori ? KultivaColors.primaryGreen : null,
                  ),
                  onPressed: () => svc.toggleFavorite(_cle),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Ouvre une recette : le lecteur animé si elle a ses étapes, sinon sa
/// fiche courte.
///
/// Point d'entrée unique, pour que l'onglet Recettes, la fiche légume
/// et les favoris ne divergent pas.
Future<void> openRecipe(
  BuildContext context, {
  required String vegetableId,
  required Recipe recipe,
}) {
  if (recipe.isAnimated) {
    return showRecipePlayer(context,
        recipe: recipe, vegetableId: vegetableId);
  }
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _FicheCourte(vegetableId: vegetableId, recipe: recipe),
  );
}

/// La fiche d'une recette dont le pas-à-pas n'est pas encore écrit.
///
/// Avant, elle disait « il arrive » et s'arrêtait là : un cul-de-sac,
/// pour 98 % des recettes du catalogue. Elle propose maintenant ce
/// qu'on peut faire d'elle — la mettre de côté, dire qu'on l'a
/// cuisinée, la partager, ou aller voir le légume.
class _FicheCourte extends StatelessWidget {
  final String vegetableId;
  final Recipe recipe;

  const _FicheCourte({required this.vegetableId, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cle = RecipeService.keyFor(vegetableId, recipe);
    final veg = vegetableById(vegetableId);
    return ValueListenableBuilder<int>(
      valueListenable: RecipeService.instance.version,
      builder: (context, _, __) {
        final svc = RecipeService.instance;
        final cuisineLe = svc.cookedOn(cle);
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(recipe.emoji, style: const TextStyle(fontSize: 34)),
                const SizedBox(height: 8),
                Text(
                  recipe.displayName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (recipe.displaySubtitle != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    recipe.displaySubtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.terracotta,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  recipe.displayDescription,
                  style: const TextStyle(fontSize: 14, height: 1.45),
                ),
                if (recipe.ingredients.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 16),
                  const Text(
                    'Il te faut',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  for (final ing in recipe.displayIngredients)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text('·  $ing',
                          style: const TextStyle(fontSize: 13, height: 1.35)),
                    ),
                ],
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    FilledButton.tonalIcon(
                      onPressed: () => cuisineLe == null
                          ? svc.markCooked(cle)
                          : svc.unmarkCooked(cle),
                      icon: Icon(
                        cuisineLe == null
                            ? Icons.check_circle_outline
                            : Icons.check_circle,
                        size: 18,
                      ),
                      label: Text(cuisineLe == null
                          ? 'Je l\'ai cuisinée'
                          : 'Cuisinée ${dateCourte(cuisineLe)}'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => partagerRecette(veg.displayName, recipe),
                      icon: const Icon(Icons.share_outlined, size: 18),
                      label: const Text('Partager'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                VegetableDetailScreen(vegetable: veg),
                          ),
                        );
                      },
                      icon: Text(veg.emoji,
                          style: const TextStyle(fontSize: 15)),
                      label: Text(veg.displayName),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Le pas-à-pas animé de cette recette n\'est pas encore '
                  'écrit — il arrive.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Partage une recette en texte.
///
/// Du texte et pas une image : une liste d'ingrédients se recopie et se
/// colle dans une liste de courses, une capture non.
Future<void> partagerRecette(String vegetableName, Recipe recipe) async {
  final lignes = <String>[
    '${recipe.emoji}  ${recipe.displayName}',
    if (recipe.displaySubtitle != null) recipe.displaySubtitle!,
    '',
    recipe.displayDescription,
    if (recipe.ingredients.isNotEmpty) ...<String>[
      '',
      'Il te faut :',
      ...recipe.displayIngredients.map((i) => '· $i'),
    ],
    if (recipe.steps.isNotEmpty) ...<String>[
      '',
      for (final (i, s) in recipe.displaySteps.indexed) '${i + 1}. ${s.text}',
    ],
    '',
    'Une idée pour ta récolte de $vegetableName — Kultiva 🌱',
  ];
  try {
    await Share.share(lignes.join('\n'), subject: recipe.displayName);
  } catch (e, s) {
    await ErrorReporter.report('partage_recette', e, s);
  }
}

/// « ❄️ Congélation · 8 mois au congélateur ».
///
/// Entre deux conservations, c'est **cette ligne** qui décide : un
/// congélateur plein rend la stérilisation préférable, et inversement.
/// Elle est donc visible dans la liste, sans avoir à ouvrir la recette.
class _Garde extends StatelessWidget {
  final Recipe recipe;

  const _Garde({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final m = recipe.method;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: KultivaColors.primaryGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        <String>[
          if (m != null) '${m.emoji} ${recipe.displayMethodLabel}',
          recipe.displayKeeps!,
        ].join('  ·  '),
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: KultivaColors.primaryGreen,
        ),
      ),
    );
  }
}
