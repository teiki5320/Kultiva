import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';

/// Le lecteur de recette est un template HTML que Dart remplit.
///
/// ⚠️ **Ces tests existent parce que ça a cassé.** Le template écrivait
/// le marqueur `__RECIPE__` deux fois : une fois dans son commentaire
/// d'en-tête, une fois dans son script. Dart appelle `replaceFirst`,
/// donc c'est le **commentaire** qui recevait le JSON ; la ligne
/// `var R = __RECIPE__;` restait intacte, le script mourait sur une
/// variable inconnue, et les 88 recettes animées ouvraient une page
/// **blanche** avec les seuls boutons.
///
/// Rien ne l'attrapait : `flutter analyze` ne lit pas le HTML, et aucun
/// test ne remplissait le template. Découvert le 01/11/2026 en voulant
/// simplement montrer l'animation à Jean.
void main() {
  late String template;

  setUpAll(() {
    template = File('assets/recipes/recipe_player.html').readAsStringSync();
  });

  /// Reproduit exactement ce que fait `recipe_player_screen.dart`.
  String remplir(Recipe r) {
    final json = jsonEncode(<String, dynamic>{
      'name': r.name,
      'emoji': r.emoji,
      'subtitle': r.subtitle ?? r.description,
      'theme': 'light',
      'ingredients': r.ingredients,
      'steps': r.steps
          .map((s) => <String, dynamic>{
                'emoji': s.emoji,
                'text': s.text,
                if (s.minutes != null) 'minutes': s.minutes,
              })
          .toList(),
    });
    return template.replaceFirst('__RECIPE__', json);
  }

  group('le marqueur du template', () {
    test('n\'apparaît qu\'une seule fois dans le fichier', () {
      // Le test qui manquait. Deux occurrences et `replaceFirst`
      // remplace la mauvaise.
      final n = '__RECIPE__'.allMatches(template).length;
      expect(n, 1,
          reason: 'Le marqueur doit être unique : Dart utilise '
              'replaceFirst. Ne l\'écris pas dans un commentaire.');
    });

    test('il est bien dans le script, pas ailleurs', () {
      expect(template, contains('var R = __RECIPE__;'));
    });
  });

  group('une page remplie', () {
    test('ne garde aucun marqueur', () {
      for (final id in <String>['tomate', 'fraise', 'mache']) {
        for (final r in top3For(id)) {
          expect(remplir(r), isNot(contains('__RECIPE__')),
              reason: '${r.name} : le marqueur survit au remplissage');
        }
      }
    });

    test('contient vraiment le nom et les étapes de la recette', () {
      final r = top3For('tomate').first;
      final page = remplir(r);
      expect(page, contains(r.name));
      expect(page, contains(r.steps.first.text.substring(0, 20)));
      expect(page, contains(r.ingredients.first));
    });

    test('le JSON injecté se relit comme du JSON', () {
      // Une apostrophe ou un guillemet mal échappé tuerait le script
      // aussi sûrement que le marqueur manquant.
      for (final id in <String>['tomate', 'fraise', 'mache']) {
        for (final r in top3For(id)) {
          final page = remplir(r);
          final debut = page.indexOf('var R = ') + 'var R = '.length;
          final fin = page.indexOf(';\n', debut);
          final brut = page.substring(debut, fin);
          final relu = jsonDecode(brut) as Map<String, dynamic>;
          expect(relu['name'], r.name);
          expect((relu['steps'] as List).length, r.steps.length);
        }
      }
    });
  });

  group('le contrat hors ligne', () {
    test('aucun appel réseau dans le template', () {
      // Les 33 tutos n'en ont aucun ; une recette se lit dans un avion.
      for (final interdit in <String>[
        'cdnjs',
        'jsdelivr',
        'unpkg',
        'fonts.googleapis',
        'fonts.gstatic',
        'http://',
        'https://',
      ]) {
        expect(template.toLowerCase(), isNot(contains(interdit)),
            reason: 'appel réseau « $interdit » dans le lecteur');
      }
    });
  });
}
