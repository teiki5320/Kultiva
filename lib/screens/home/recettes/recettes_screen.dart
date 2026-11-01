import '../../../data/names_en.dart';
import 'package:flutter/material.dart';

import '../../../data/recipes.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/vegetable.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/text_normalize.dart';
import '../../../widgets/pastel_chip.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/season_header.dart';
import '../../../widgets/vegetable_image.dart';
import 'recipe_player_screen.dart';

/// L'onglet Recettes : que faire de la récolte.
///
/// Trois idées par légume. Celles qui ont été écrites pas à pas
/// s'ouvrent en animation ; les autres restent des idées de plat. Les
/// deux cohabitent volontairement — attendre d'avoir rédigé quatre
/// cents recettes complètes aurait retardé une liste déjà utile seule.
///
/// Les légumes **présents dans ton jardin** passent devant : c'est la
/// différence entre un livre de cuisine et la cuisine de ton potager.
class RecettesScreen extends StatefulWidget {
  const RecettesScreen({super.key});

  @override
  State<RecettesScreen> createState() => _RecettesScreenState();
}

class _RecettesScreenState extends State<RecettesScreen> {
  final TextEditingController _recherche = TextEditingController();
  String _query = '';
  VegetableCategory? _categorie;

  @override
  void dispose() {
    _recherche.dispose();
    super.dispose();
  }

  /// Les catégories réellement représentées — inutile d'afficher une
  /// pastille qui ne filtrerait rien.
  List<VegetableCategory> get _categories {
    final vues = <VegetableCategory>{};
    for (final id in recipesByVegetable.keys) {
      final v = vegetablesBase.where((x) => x.id == id).firstOrNull;
      if (v != null) vues.add(v.category);
    }
    final ordre = VegetableCategory.values
        .where((c) => c != VegetableCategory.accessories && vues.contains(c))
        .toList();
    return ordre;
  }

  List<_Entree> get _entrees {
    final auJardin =
        PlantationService.instance.active.map((p) => p.vegetableId).toSet();
    final q = foldAccents(_query);

    final out = <_Entree>[];
    recipesByVegetable.forEach((id, recettes) {
      final veg = vegetablesBase.where((v) => v.id == id).firstOrNull;
      if (veg == null) return;
      if (_categorie != null && veg.category != _categorie) return;
      if (q.isNotEmpty) {
        final dansLeNom = foldAccents(veg.displayName).contains(q);
        final dansUneRecette =
            recettes.any((r) => foldAccents(r.name).contains(q));
        if (!dansLeNom && !dansUneRecette) return;
      }
      out.add(_Entree(veg, recettes, auJardin.contains(id)));
    });

    out.sort((a, b) {
      // Ce qui pousse chez toi d'abord, puis l'ordre alphabétique.
      if (a.auJardin != b.auJardin) return a.auJardin ? -1 : 1;
      return a.vegetable.displayName.compareTo(b.vegetable.displayName);
    });
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    final entrees = _entrees;
    final total =
        recipesByVegetable.values.fold<int>(0, (n, l) => n + l.length);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SeasonHeader(
                  season: Season.current(mois),
                  month: mois,
                  height: kPageHeaderHeight,
                  hideLabel: true,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '🍽  Recettes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 6, color: Colors.black38),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$total recettes pour '
                          '${recipesByVegetable.length} récoltes',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 5, color: Colors.black38),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: TextField(
                controller: _recherche,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Un légume, ou un plat…',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _recherche.clear();
                            setState(() => _query = '');
                          },
                        ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                children: <Widget>[
                  PastelChip(
                    label: 'Tout',
                    emoji: '🍽',
                    color: KultivaColors.primaryGreen,
                    selected: _categorie == null,
                    onTap: () => setState(() => _categorie = null),
                  ),
                  for (final c in _categories)
                    PastelChip(
                      label: c.label,
                      emoji: c.emoji,
                      color: c.familyColor,
                      selected: _categorie == c,
                      onTap: () => setState(
                        () => _categorie = _categorie == c ? null : c,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: entrees.isEmpty
                  ? _RienTrouve(query: _query, categorie: _categorie)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: entrees.length,
                      itemBuilder: (_, i) => _CarteLegume(entree: entrees[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Entree {
  final Vegetable vegetable;
  final List<Recipe> recettes;
  final bool auJardin;
  const _Entree(this.vegetable, this.recettes, this.auJardin);
}

class _CarteLegume extends StatelessWidget {
  final _Entree entree;

  const _CarteLegume({required this.entree});

  @override
  Widget build(BuildContext context) {
    final veg = entree.vegetable;
    final sombre = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: sombre ? KultivaColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: entree.auJardin
              ? KultivaColors.primaryGreen.withValues(alpha: 0.55)
              : KultivaColors.lightGreen.withValues(alpha: 0.45),
          width: entree.auJardin ? 1.6 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 14, 6),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 38,
                  height: 38,
                  child: veg.imageAsset != null
                      ? VegetableImage(
                          asset: veg.imageAsset!,
                          emoji: veg.emoji,
                          radius: 10,
                          emojiSize: 24,
                        )
                      : Center(
                          child: Text(veg.emoji,
                              style: const TextStyle(fontSize: 24)),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    veg.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (entree.auJardin)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: KultivaColors.primaryGreen.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Dans ton jardin',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: KultivaColors.primaryGreen,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          for (final r in entree.recettes) _LigneRecette(recipe: r),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _LigneRecette extends StatelessWidget {
  final Recipe recipe;

  const _LigneRecette({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _ouvrir(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
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
                          recipe.name,
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
                    recipe.description,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  if (recipe.subtitle != null) ...<Widget>[
                    const SizedBox(height: 3),
                    Text(
                      recipe.subtitle!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: KultivaColors.terracotta,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _ouvrir(BuildContext context) {
    if (recipe.isAnimated) {
      showRecipePlayer(context, recipe: recipe);
      return;
    }
    // Pas encore écrite pas à pas : on dit la vérité plutôt que
    // d'ouvrir un lecteur vide.
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(recipe.emoji, style: const TextStyle(fontSize: 34)),
              const SizedBox(height: 8),
              Text(
                recipe.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (recipe.subtitle != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  recipe.subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: KultivaColors.terracotta,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                recipe.description,
                style: const TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 16),
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
      ),
    );
  }
}

class _RienTrouve extends StatelessWidget {
  final String query;
  final VegetableCategory? categorie;

  const _RienTrouve({required this.query, required this.categorie});

  String get _message {
    if (query.isNotEmpty) {
      return 'Aucune recette ne parle de « $query ».';
    }
    if (categorie != null) {
      return 'Aucune recette dans la famille '
          '« ${categorie!.label.toLowerCase()} » pour l\'instant.';
    }
    return 'Aucune recette.';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('🍳', style: TextStyle(fontSize: 44)),
            const SizedBox(height: 12),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
