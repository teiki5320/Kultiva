import '../../../data/names_en.dart';
import 'package:flutter/material.dart';

import '../../../data/recipes.dart';
import '../../../data/regions/regional_calendar.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/vegetable.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/text_normalize.dart';
import '../../../widgets/pastel_chip.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/season_header.dart';
import '../../../services/recipe_service.dart';
import '../../../widgets/recipe_row.dart';
import '../../../widgets/vegetable_image.dart';

/// L'onglet Recettes : que faire de la récolte.
///
/// Trois idées par légume. Celles qui ont été écrites pas à pas
/// s'ouvrent en animation ; les autres restent des idées de plat. Les
/// deux cohabitent volontairement — attendre d'avoir rédigé quatre
/// cents recettes complètes aurait retardé une liste déjà utile seule.
///
/// Les légumes **présents dans ton jardin** passent devant : c'est la
/// différence entre un livre de cuisine et la cuisine de ton potager.
///
/// Trois filtres s'ajoutent à la recherche, cumulables :
///
/// - **C'est la saison** lit le calendrier de récolte de la région et
///   ne garde que ce qui se récolte ce mois-ci. Sans lui, un jardinier
///   voyait la même liste en novembre et en juillet.
/// - **Mes favoris** montre ce qui a été mis de côté, tous légumes
///   confondus — c'est la seule vue où le nom du légume s'affiche sous
///   la recette, puisqu'elle les mélange.
/// - les **familles** (feuilles, fruits…), comme ailleurs dans l'app.
class RecettesScreen extends StatefulWidget {
  const RecettesScreen({super.key});

  @override
  State<RecettesScreen> createState() => _RecettesScreenState();
}

class _RecettesScreenState extends State<RecettesScreen> {
  final TextEditingController _recherche = TextEditingController();
  String _query = '';
  VegetableCategory? _categorie;
  bool _saison = false;
  bool _favoris = false;

  /// Les légumes récoltables ce mois-ci, d'après le calendrier de la
  /// région et de la zone climatique de l'utilisateur. Calculé une
  /// fois : le calendrier ne change pas pendant qu'on cherche.
  late final Set<String> _recoltablesCeMois = _calculerSaison();

  static Set<String> _calculerSaison() {
    final mois = DateTime.now().month;
    return currentCalendar()
        .where((r) => r.harvestMonths.contains(mois))
        .map((r) => r.vegetableId)
        .toSet();
  }

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
      vues.add(vegetableById(id).category);
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
    final favoris = RecipeService.instance.favorites;

    final out = <_Entree>[];
    recipesByVegetable.forEach((id, toutes) {
      final veg = vegetableById(id);
      if (veg.id == unknownVegetable.id) return;
      if (_categorie != null && veg.category != _categorie) return;
      if (_saison && !_recoltablesCeMois.contains(id)) return;

      // Les favoris filtrent les **recettes**, pas les légumes : on ne
      // montre pas les deux autres recettes d'un légume parce que la
      // troisième est en favori.
      var recettes = toutes;
      if (_favoris) {
        recettes = toutes
            .where((r) => favoris.contains(RecipeService.keyFor(id, r)))
            .toList(growable: false);
        if (recettes.isEmpty) return;
      }

      if (q.isNotEmpty) {
        final dansLeNom = foldAccents(veg.displayName).contains(q);
        // La recherche couvre le nom du plat, sa description et ses
        // ingrédients : « gratin » trouvait, « crème » ne trouvait rien.
        final dansUneRecette = recettes.any((r) =>
            foldAccents(r.name).contains(q) ||
            foldAccents(r.description).contains(q) ||
            r.ingredients.any((i) => foldAccents(i).contains(q)));
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
    final total = entrees.fold<int>(0, (n, e) => n + e.recettes.length);

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
                          '$total recette${total > 1 ? 's' : ''} pour '
                          '${entrees.length} récolte'
                          '${entrees.length > 1 ? 's' : ''}',
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
                    selected: _categorie == null && !_saison && !_favoris,
                    onTap: () => setState(() {
                      _categorie = null;
                      _saison = false;
                      _favoris = false;
                    }),
                  ),
                  PastelChip(
                    label: 'C\'est la saison',
                    emoji: '📅',
                    color: KultivaColors.terracotta,
                    selected: _saison,
                    onTap: () => setState(() => _saison = !_saison),
                  ),
                  PastelChip(
                    label: 'Mes favoris',
                    emoji: '🔖',
                    color: KultivaColors.primaryGreen,
                    selected: _favoris,
                    onTap: () => setState(() => _favoris = !_favoris),
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
                  ? _RienTrouve(
                      query: _query,
                      categorie: _categorie,
                      saison: _saison,
                      favoris: _favoris,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: entrees.length,
                      itemBuilder: (_, i) => _CarteLegume(
                        entree: entrees[i],
                        montrerLeLegume: _favoris,
                      ),
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
  final bool montrerLeLegume;

  const _CarteLegume({required this.entree, this.montrerLeLegume = false});

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
          for (final r in entree.recettes)
            RecipeRow(
              vegetableId: entree.vegetable.id,
              recipe: r,
              showVegetable: montrerLeLegume,
            ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _RienTrouve extends StatelessWidget {
  final String query;
  final VegetableCategory? categorie;
  final bool saison;
  final bool favoris;

  const _RienTrouve({
    required this.query,
    required this.categorie,
    this.saison = false,
    this.favoris = false,
  });

  /// Un écran vide doit dire **lequel** des filtres a tout mangé,
  /// sinon on croit que l'app n'a pas de recettes.
  String get _message {
    if (favoris && query.isEmpty && !saison && categorie == null) {
      return 'Tu n\'as encore mis aucune recette de côté.\n'
          'Touche le marque-page sur celles qui te tentent.';
    }
    final bouts = <String>[
      if (query.isNotEmpty) 'qui parle de « $query »',
      if (categorie != null)
        'dans la famille « ${categorie!.label.toLowerCase()} »',
      if (saison) 'à récolter ce mois-ci',
      if (favoris) 'parmi tes favoris',
    ];
    if (bouts.isEmpty) return 'Aucune recette.';
    return 'Aucune recette ${bouts.join(', ')}.';
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
