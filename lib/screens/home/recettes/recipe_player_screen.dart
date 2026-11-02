import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/names_en.dart';
import '../../../data/recipes.dart';
import '../../../data/recipes_i18n.dart';
import '../../../data/ui_i18n.dart';
import '../../../data/vegetables_base.dart';
import '../../../services/prefs_service.dart';
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

  /// Images déjà lues, par légume : recharger la page pour changer le
  /// nombre de convives ne relit pas l'asset.
  static final Map<String, String?> _images = <String, String?>{};

  /// Le légume peint et détouré, en data:URI. La WebView n'a pas accès
  /// aux assets Flutter, et le lecteur doit rester un seul document
  /// hors ligne : l'image voyage donc dans le JSON (7 Ko en moyenne).
  Future<String?> _imageDuLegume(String id) async {
    if (_images.containsKey(id)) return _images[id];
    String? uri;
    try {
      final data = await rootBundle
          .load('assets/images/vegetables_kawaii/detoure/$id.webp');
      uri = 'data:image/webp;base64,'
          '${base64Encode(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes))}';
    } catch (_) {
      uri = null;
    }
    return _images[id] = uri;
  }

  Future<void> _charger(WebViewController c, {required bool sombre}) async {
    try {
      final template =
          await rootBundle.loadString('assets/recipes/recipe_player.html');
      final r = widget.recipe;
      final ingredients =
          scaleIngredients(r.displayIngredients, _partsEcrites, _parts);
      final legume = vegetableById(widget.vegetableId);
      final image = await _imageDuLegume(widget.vegetableId);
      final json = jsonEncode(<String, dynamic>{
        'name': r.displayName,
        'emoji': r.emoji,
        'subtitle': _sousTitre(r),
        'theme': sombre ? 'dark' : 'light',
        // Les libellés du lecteur lui-même : il est hors ligne et ne
        // peut pas lire les ARB, ils voyagent donc avec la recette.
        if (playerUiFor(PrefsService.instance.effectiveLanguage) != null)
          'ui': playerUiFor(PrefsService.instance.effectiveLanguage),
        // Le légume joue dans les scènes animées du lecteur. Sans
        // image (légume inconnu, fichier absent), c'est son emoji.
        'vegetable': <String, dynamic>{
          'name': legume.name,
          'emoji': legume.emoji,
          if (image != null) 'image': image,
        },
        'ingredients': ingredients,
        'steps': r.displaySteps
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
    final langue = PrefsService.instance.effectiveLanguage;
    final bouts = <String>[
      if (r.minutes != null) dureeLisibleIn(r.minutes!, langue),
      trUiArgsIn('{0} pers.', <Object?>[_parts], langue),
      // Pour une conservation, la durée de garde compte plus que le
      // temps de préparation : c'est elle qu'on vient chercher.
      if (r.displayKeeps != null) r.displayKeeps!,
    ];
    return bouts.join('  ·  ');
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.displayName),
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
                        ? trUiArgs('Cuisinée {0}',
                            <Object?>[dateCourte(svc.cookedOn(_cle)!)])
                        : trUi("Je l'ai cuisinée"),
                    icon: Icon(cuisine
                        ? Icons.check_circle
                        : Icons.check_circle_outline),
                    color: cuisine ? KultivaColors.primaryGreen : null,
                    onPressed: () => cuisine
                        ? svc.unmarkCooked(_cle)
                        : svc.markCooked(_cle),
                  ),
                  IconButton(
                    tooltip: favori
                        ? trUi('Retirer des favoris')
                        : trUi('Mettre de côté'),
                    icon: Icon(favori ? Icons.bookmark : Icons.bookmark_border),
                    color: favori ? KultivaColors.primaryGreen : null,
                    onPressed: () => svc.toggleFavorite(_cle),
                  ),
                  IconButton(
                    tooltip: trUi('Partager'),
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
                  trUiArgs("Impossible d'ouvrir la recette.\n{0}",
                      <Object?>[_erreur]),
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
              <String>[
                parts > 1
                    ? trUiArgs('Pour {0} personnes', <Object?>[parts])
                    : trUiArgs('Pour {0} personne', <Object?>[parts]),
                if (parts != ecritPour)
                  trUiArgs('écrite pour {0}', <Object?>[ecritPour]),
              ].join('  ·  '),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: trUi('Moins'),
            icon: const Icon(Icons.remove_circle_outline, size: 21),
            onPressed: parts <= 1 ? null : () => onChanged(parts - 1),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: trUi('Plus'),
            icon: const Icon(Icons.add_circle_outline, size: 21),
            onPressed: parts >= 20 ? null : () => onChanged(parts + 1),
          ),
        ],
      ),
    );
  }
}
