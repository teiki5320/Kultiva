import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/recipes.dart';
import '../../../theme/app_theme.dart';

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
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) => RecipePlayerScreen(recipe: recipe),
    ),
  );
}

class RecipePlayerScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipePlayerScreen({super.key, required this.recipe});

  @override
  State<RecipePlayerScreen> createState() => _RecipePlayerScreenState();
}

class _RecipePlayerScreenState extends State<RecipePlayerScreen> {
  WebViewController? _controller;
  bool _loading = true;
  String? _erreur;

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

  Future<void> _charger(WebViewController c, {required bool sombre}) async {
    try {
      final template =
          await rootBundle.loadString('assets/recipes/recipe_player.html');
      final r = widget.recipe;
      final json = jsonEncode(<String, dynamic>{
        'name': r.name,
        'emoji': r.emoji,
        'subtitle': r.subtitle ?? r.description,
        'theme': sombre ? 'dark' : 'light',
        'ingredients': r.ingredients,
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

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
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
          : Stack(
              children: <Widget>[
                if (c != null) WebViewWidget(controller: c),
                if (_loading) const Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}
