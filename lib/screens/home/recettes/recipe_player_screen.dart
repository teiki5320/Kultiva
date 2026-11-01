import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/names_en.dart';
import '../../../data/recipes.dart';
import '../../../data/vegetables_base.dart';
import '../../../services/recipe_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/recipe_portions.dart';
import '../../../widgets/recipe_row.dart';

/// Déroule une recette pas à pas, en animation.
///
/// Un seul template HTML (`assets/recipes/recipe_player.html`) sert
/// toutes les recettes : on y injecte le JSON de celle qu'on ouvre.
/// Écrire une page par recette aurait voulu dire quatre cents fichiers
/// à maintenir, et autant d'occasions de les laisser diverger.
///
/// Comme les 33 tutos, la page ne fait **aucun appel réseau** : ni CDN,
/// ni Google Fonts. Un avion sans wifi est précisément le moment où on
/// lit une recette.
Future<void> showRecipePlayer(
  BuildContext context, {
  required Recipe recipe,
  required String vegetableId,
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) =>
          RecipePlayerScreen(recipe: recipe, vegetableId: vegetableId),
    ),
  );
}

class RecipePlayerScreen extends StatefulWidget {
  final Recipe recipe;
  final String vegetableId;

  const RecipePlayerScreen({
    super.key,
    required this.recipe,
    required this.vegetableId,
  });

  @override
  State<RecipePlayerScreen> createState() => _RecipePlayerScreenState();
}

class _RecipePlayerScreenState extends State<RecipePlayerScreen> {
  WebViewController? _controller;
  bool _loading = true;
  String? _erreur;

  /// Pour combien de personnes on veut cuisiner, maintenant.
  late int _parts;

  String get _cle =>
      RecipeService.keyFor(widget.vegetableId, widget.recipe);

  /// Le nombre de parts pour lequel la recette a été écrite.
  int get _partsEcrites => widget.recipe.serves ?? 4;

  @override
  void initState() {
    super.initState();
    _parts = _partsEcrites;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Le thème du téléphone est lu ici et pas dans `initState` :
    // `Theme.of` a besoin du contexte monté.
    _controller ??= _construire();
  }

  WebViewController _construire() {
    final sombre = Theme.of(context).brightness == Brightness.dark;
    final c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        sombre ? KultivaColors.darkBackground : KultivaColors.lightBackground,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          // La recette est un document fermé : rien ne doit emmener
          // l'utilisateur ailleurs, et surtout pas sur le réseau.
          onNavigationRequest: (_) => NavigationDecision.prevent,
        ),
      );
    _charger(c, sombre: sombre);
    return c;
  }

  /// Change le nombre de convives et recharge la page.
  ///
  /// Recharger plutôt que de parler à la page en JavaScript : le
  /// template n'a alors **aucune** interface à exposer, et il reste un
  /// document que Dart remplit. Une recette tient dans un écran, le
  /// rechargement ne se voit pas.
  Future<void> _changerParts(int parts) async {
    if (parts < 1 || parts > 20 || parts == _parts) return;
    final c = _controller;
    if (c == null) return;
    setState(() {
      _parts = parts;
      _loading = true;
    });
    await _charger(c, sombre: Theme.of(context).brightness == Brightness.dark);
  }

  Future<void> _charger(WebViewController c, {required bool sombre}) async {
    try {
      final template =
          await rootBundle.loadString('assets/recipes/recipe_player.html');
      final r = widget.recipe;
      final ingredients =
          scaleIngredients(r.ingredients, _partsEcrites, _parts);
      final json = jsonEncode(<String, dynamic>{
        'name': r.name,
        'emoji': r.emoji,
        'subtitle': _sousTitre(r),
        'theme': sombre ? 'dark' : 'light',
        'ingredients': ingredients,
        'steps': r.steps
            .map((s) => <String, dynamic>{
                  'emoji': s.emoji,
                  'text': s.text,
                  if (s.minutes != null) 'minutes': s.minutes,
                })
            .toList(),
      });
      await c.loadHtmlString(template.replaceFirst('__RECIPE__', json));
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _erreur = '$e';
        });
      }
    }
  }

  /// Le sous-titre suit le nombre de parts choisi, sinon il
  /// contredirait les quantités affichées juste en dessous.
  String _sousTitre(Recipe r) {
    final bouts = <String>[
      if (r.minutes != null) '${r.minutes} min',
      '$_parts pers.',
      // Pour une conservation, la durée de garde compte plus que le
      // temps de préparation : c'est elle qu'on vient chercher.
      if (r.keeps != null) r.keeps!,
    ];
    return bouts.join('  ·  ');
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
        actions: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: RecipeService.instance.version,
            builder: (context, _, __) {
              final svc = RecipeService.instance;
              final favori = svc.isFavorite(_cle);
              final cuisine = svc.hasCooked(_cle);
              return Row(
                children: <Widget>[
                  IconButton(
                    tooltip: cuisine
                        ? 'Cuisinée ${dateCourte(svc.cookedOn(_cle)!)}'
                        : 'Je l\'ai cuisinée',
                    icon: Icon(cuisine
                        ? Icons.check_circle
                        : Icons.check_circle_outline),
                    color: cuisine ? KultivaColors.primaryGreen : null,
                    onPressed: () => cuisine
                        ? svc.unmarkCooked(_cle)
                        : svc.markCooked(_cle),
                  ),
                  IconButton(
                    tooltip:
                        favori ? 'Retirer des favoris' : 'Mettre de côté',
                    icon: Icon(favori ? Icons.bookmark : Icons.bookmark_border),
                    color: favori ? KultivaColors.primaryGreen : null,
                    onPressed: () => svc.toggleFavorite(_cle),
                  ),
                  IconButton(
                    tooltip: 'Partager',
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () => partagerRecette(
                      vegetableById(widget.vegetableId).displayName,
                      widget.recipe,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: _erreur != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Text(
                  'Impossible d\'ouvrir la recette.\n$_erreur',
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.4),
                ),
              ),
            )
          : Column(
              children: <Widget>[
                if (widget.recipe.ingredients.isNotEmpty)
                  _ChoixDesParts(
                    parts: _parts,
                    ecritPour: _partsEcrites,
                    onChanged: _changerParts,
                  ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      if (c != null) WebViewWidget(controller: c),
                      if (_loading)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

/// « Pour 4 personnes », avec deux boutons.
///
/// Ne s'affiche que si la recette a des ingrédients : sans quantités à
/// recalculer, le réglage ne changerait qu'un chiffre décoratif.
class _ChoixDesParts extends StatelessWidget {
  final int parts;
  final int ecritPour;
  final ValueChanged<int> onChanged;

  const _ChoixDesParts({
    required this.parts,
    required this.ecritPour,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 10, 2),
      child: Row(
        children: <Widget>[
          const Text('👥', style: TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pour $parts personne${parts > 1 ? 's' : ''}'
              '${parts == ecritPour ? '' : '  ·  écrite pour $ecritPour'}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Moins',
            icon: const Icon(Icons.remove_circle_outline, size: 21),
            onPressed: parts <= 1 ? null : () => onChanged(parts - 1),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Plus',
            icon: const Icon(Icons.add_circle_outline, size: 21),
            onPressed: parts >= 20 ? null : () => onChanged(parts + 1),
          ),
        ],
      ),
    );
  }
}
