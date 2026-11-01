import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Le catalogue de recettes est écrit à la main : ces tests attrapent
/// les fautes de frappe qu'aucun compilateur ne voit — une clé qui ne
/// correspond à aucun légume, une recette vide, un accessoire à qui on
/// prêterait une recette.
void main() {
  test('chaque clé correspond à un id du catalogue', () {
    final ids = vegetablesBase.map((v) => v.id).toSet();
    final inconnues =
        recipesByVegetable.keys.where((k) => !ids.contains(k)).toList();
    expect(inconnues, isEmpty,
        reason: 'ces clés ne désignent aucun légume : $inconnues');
  });

  test('aucun accessoire n\'a de recette', () {
    final accessoires = vegetablesBase
        .where((v) => v.category == VegetableCategory.accessories)
        .map((v) => v.id)
        .toSet();
    final fautifs =
        recipesByVegetable.keys.where(accessoires.contains).toList();
    expect(fautifs, isEmpty);
  });

  test('chaque légume a au moins deux recettes', () {
    final maigres = recipesByVegetable.entries
        .where((e) => e.value.length < 2)
        .map((e) => e.key)
        .toList();
    expect(maigres, isEmpty);
  });

  test('aucun nom ni aucune description n\'est vide', () {
    for (final entry in recipesByVegetable.entries) {
      for (final r in entry.value) {
        expect(r.name.trim(), isNotEmpty, reason: entry.key);
        expect(r.description.trim(), isNotEmpty,
            reason: '${entry.key}/${r.name}');
        expect(r.emoji.trim(), isNotEmpty, reason: '${entry.key}/${r.name}');
      }
    }
  });

  test('deux recettes du même légume ne portent pas le même nom', () {
    for (final entry in recipesByVegetable.entries) {
      final noms = entry.value.map((r) => r.name).toList();
      expect(noms.toSet(), hasLength(noms.length), reason: entry.key);
    }
  });

  group('recettes animées', () {
    final animees = recipesByVegetable.values
        .expand((l) => l)
        .where((r) => r.isAnimated)
        .toList();

    test('il y en a, sinon le lecteur ne sert à rien', () {
      expect(animees, isNotEmpty);
    });

    test('une recette animée liste aussi ses ingrédients', () {
      // Dérouler des étapes sans dire quoi sortir du placard laisse
      // l'utilisateur à court au milieu de la recette.
      for (final r in animees) {
        expect(r.ingredients, isNotEmpty, reason: r.name);
      }
    });

    test('une recette animée dit son temps et pour combien', () {
      for (final r in animees) {
        expect(r.minutes, isNotNull, reason: r.name);
        expect(r.serves, isNotNull, reason: r.name);
        expect(r.subtitle, isNotNull, reason: r.name);
      }
    });

    test('aucune étape vide', () {
      for (final r in animees) {
        for (final s in r.steps) {
          expect(s.text.trim(), isNotEmpty, reason: r.name);
          expect(s.emoji.trim(), isNotEmpty, reason: r.name);
        }
      }
    });
  });

  group('la durée affichée', () {
    test('se lit en minutes, heures, jours ou semaines', () {
      // Les séchages et fermentations comptent leur attente : un mois
      // affiché « 30240 min » ne se lit pas.
      expect(dureeLisible(45), '45 min');
      expect(dureeLisible(60), '1 h');
      expect(dureeLisible(90), '1 h 30');
      expect(dureeLisible(605), '10 h 05');
      expect(dureeLisible(4320), '3 jours');
      expect(dureeLisible(20160), '2 semaines');
      expect(dureeLisible(30240), '3 semaines');
      expect(dureeLisible(129600), '3 mois');
    });
  });

  group('les chiffres annoncés dans les fiches', () {
    // Les fiches ont annoncé « 340 recettes, dont huit animées »
    // pendant une journée alors qu'il y en avait 369 et 7. Ce test
    // échoue si quelqu'un ajoute des recettes sans corriger README,
    // MARKETING et CLAUDE.md.
    test('le compte total est bien celui des fiches', () {
      final total =
          recipesByVegetable.values.fold<int>(0, (n, l) => n + l.length);
      expect(total, 736,
          reason: 'Si tu ajoutes des recettes, mets à jour README.md, '
              'docs/MARKETING.md et CLAUDE.md, puis ce chiffre.');
    });

    test('le compte des recettes animées est bien celui des fiches', () {
      final animees = recipesByVegetable.values
          .expand((l) => l)
          .where((r) => r.isAnimated)
          .length;
      expect(animees, 448,
          reason: 'Si tu écris de nouveaux pas-à-pas, mets à jour README.md, '
              'docs/MARKETING.md et CLAUDE.md, puis ce chiffre.');
    });
  });

  group('top 3 par légume', () {
    test('chaque légume en rend exactement trois', () {
      // Contrainte de Jean : trois, jamais plus. Vingt idées de plat ne
      // se choisissent pas.
      for (final id in recipesByVegetable.keys) {
        expect(top3For(id).length, 3, reason: id);
      }
    });

    test('ce sont les trois premières du catalogue, dans l\'ordre', () {
      final top = top3For('tomate');
      expect(top.first.name, 'Coulis de tomates en bocaux');
      expect(top.map((r) => r.name),
          recipesByVegetable['tomate']!.take(3).map((r) => r.name));
    });

    test('un légume inconnu rend une liste vide, sans lever', () {
      expect(top3For('nawak'), isEmpty);
      expect(otherRecipesFor('nawak'), isEmpty);
    });
  });

  group('recettes hors du top 3', () {
    test('ce qui dépasse de sa propre liste y figure', () {
      // La tomate a quatre recettes : la thiéboudienne sort du top 3.
      final autres = otherRecipesFor('tomate');
      expect(autres.map((r) => r.name), contains('Thiéboudienne'));
    });

    test('une recette qui emprunte un légume est trouvable depuis lui', () {
      // Le coulis de tomates déclare `uses: oignon` : on doit le voir
      // depuis l'oignon, sans qu'il quitte le top 3 de la tomate.
      final depuisOignon = otherRecipesFor('oignon');
      expect(depuisOignon.map((r) => r.name),
          contains('Coulis de tomates en bocaux'));
      expect(top3For('tomate').map((r) => r.name),
          contains('Coulis de tomates en bocaux'));
    });

    test('aucune recette n\'est injoignable', () {
      // Règle 10 : une recette qu'aucun chemin n'atteint est un bug.
      final joignables = <String>{};
      for (final id in recipesByVegetable.keys) {
        joignables.addAll(top3For(id).map((r) => r.name));
        joignables.addAll(otherRecipesFor(id).map((r) => r.name));
      }
      final toutes = recipesByVegetable.values
          .expand((l) => l)
          .map((r) => r.name)
          .toSet();
      expect(toutes.difference(joignables), isEmpty);
    });

    test('un légume ne se cite pas lui-même dans `uses`', () {
      recipesByVegetable.forEach((id, recettes) {
        for (final r in recettes) {
          expect(r.uses, isNot(contains(id)), reason: '${r.name} / $id');
        }
      });
    });

    test('tout `uses` pointe un légume qui existe', () {
      final ids = recipesByVegetable.keys.toSet();
      final absents = <String>[];
      for (final r in recipesByVegetable.values.expand((l) => l)) {
        for (final u in r.uses) {
          if (!ids.contains(u)) absents.add('${r.name} → $u');
        }
      }
      expect(absents, isEmpty);
    });
  });

  group('le top 3 de chaque légume est fait de conservations', () {
    // Décision de Jean (01/11/2026) : le top 3 est fait de
    // **conservations**. Un jardinier n'a pas un légume, il en a quinze
    // d'un coup, et c'est le seul problème qu'un livre de cuisine ne
    // résout pas. Tomate, fraise et mâche ont servi de modèle ; depuis
    // le 01/11/2026 les 123 légumes suivent la même règle.
    const reference = <String>['tomate', 'fraise', 'mache'];

    for (final id in recipesByVegetable.keys) {
      test('$id : les trois du top sont des conservations', () {
        for (final r in top3For(id)) {
          expect(r.isPreservation, isTrue,
              reason: '${r.name} n\'est pas une conservation');
          expect(r.keeps, isNotNull,
              reason: '${r.name} ne dit pas combien de temps ça se garde');
        }
      });

      test('$id : chacune a ses étapes, ses ingrédients, son temps', () {
        for (final r in top3For(id)) {
          expect(r.isAnimated, isTrue, reason: '${r.name} sans étapes');
          expect(r.ingredients, isNotEmpty, reason: '${r.name} sans liste');
          expect(r.minutes, isNotNull, reason: '${r.name} sans temps');
          expect(r.serves, isNotNull, reason: '${r.name} sans parts');
        }
      });

      test('$id : chaque étape est une phrase, pas un mot', () {
        for (final r in top3For(id)) {
          for (final s in r.steps) {
            expect(s.text.length, greaterThan(20),
                reason: '${r.name}: ${s.text}');
            expect(s.emoji, isNotEmpty);
          }
        }
      });

      test('$id : au moins deux méthodes différentes dans le top 3', () {
        // Trois fois la même méthode, c'est une seule réponse déguisée
        // en trois. La mâche est le plancher : une feuille tendre ne
        // survit que cuite puis congelée, d'où deux méthodes et pas
        // trois — c'est la limite honnête, pas un oubli.
        final methodes = top3For(id).map((r) => r.method).toSet();
        expect(methodes.length, greaterThanOrEqualTo(2), reason: id);
      });

      test('$id : une conservation rapide existe dans le top 3', () {
        // Sans elle, la seule réponse à un surplus demande deux heures,
        // et la récolte pourrit pendant qu'on hésite.
        final mini = top3For(id).map((r) => r.minutes!).reduce(
            (a, b) => a < b ? a : b);
        expect(mini, lessThanOrEqualTo(25), reason: id);
      });
    }

    test('la mâche prouve que les feuilles à salade sont couvertes', () {
      // Je m'étais trompé en disant qu'une salade ne se conservait pas.
      // Jean a eu raison : transformée, elle se congèle.
      final top = top3For('mache');
      expect(top.length, 3);
      expect(
        top.map((r) => r.method),
        everyElement(isIn(<PreservationMethod>[
          PreservationMethod.transformeCongele,
          PreservationMethod.blanchiCongele,
          PreservationMethod.congelation,
        ])),
      );
    });

    test('les recettes à manger le jour même restent joignables', () {
      // Elles quittent le top 3 mais pas l'app : la tarte à la tomate
      // et la salade de mâche doivent rester trouvables.
      for (final id in reference) {
        final autres = otherRecipesFor(id);
        expect(autres.any((r) => !r.isPreservation), isTrue, reason: id);
      }
    });
  });
}
