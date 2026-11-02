import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/recipes.dart';
import 'package:kultiva/data/recipes_i18n.dart';

/// Ce qui garde les traductions honnêtes.
///
/// Les 736 recettes vont être traduites par lots, par des agents, dans
/// plusieurs langues. Trois choses peuvent mal tourner, et ce fichier
/// les refuse toutes les trois :
///
/// 1. **une clé inventée** — un `légume/nom` qui n'existe pas dans le
///    catalogue. La traduction ne s'afficherait jamais, sans que rien
///    n'échoue : exactement le genre de travail perdu en silence que ce
///    projet a déjà connu quatre fois ;
/// 2. **un décalage d'étapes** — neuf étapes françaises traduites en
///    huit. L'étape 4 répondrait à l'étape 5 ;
/// 3. **un nombre qui bouge** — et c'est le vrai danger. Les grammes de
///    sel, les degrés, les pourcentages de vinaigre et les temps de
///    stérilisation sont des règles de sécurité alimentaire. Une
///    saumure à 3 % devenue 2 % ne conserve plus, elle fait pousser
///    autre chose. Une traduction a le droit de changer tous les mots,
///    aucun chiffre.
///
/// ⚠️ Ces tests n'appellent **jamais** `PrefsService` : en test
/// l'environnement tourne en `en-US`, donc `effectiveLanguage` répond
/// « en » et un test écrit sur les getters `display*` lirait de
/// l'anglais en croyant lire du français. Ils passent par les
/// fonctions pures, qui prennent la langue en paramètre.
void main() {
  /// Les nombres d'un texte, dans l'ordre, virgule décimale
  /// normalisée : « 1,5 kg » et « 1.5 kg » donnent la même liste.
  List<String> nombres(String texte) => RegExp(r'\d+(?:[.,]\d+)?')
      .allMatches(texte)
      .map((m) => m.group(0)!.replaceAll(',', '.'))
      .toList(growable: false);

  /// Toutes les recettes du catalogue, avec leur clé de surcouche.
  final parCle = <String, Recipe>{
    for (final entree in recipesByVegetable.entries)
      for (final r in entree.value) recipeTextKey(entree.key, r): r,
  };

  test('aucune surcouche n\'invente de clé', () {
    recipeTextsByLanguage.forEach((langue, surcouche) {
      for (final cle in surcouche.keys) {
        expect(
          parCle.containsKey(cle),
          isTrue,
          reason: 'La surcouche « $langue » traduit « $cle », '
              'qui n\'existe pas dans le catalogue. Faute de frappe, ou '
              'recette renommée depuis ?',
        );
      }
    });
  });

  test('les listes traduites ont la longueur du français', () {
    recipeTextsByLanguage.forEach((langue, surcouche) {
      surcouche.forEach((cle, t) {
        final fr = parCle[cle];
        if (fr == null) return; // déjà signalé par le test précédent
        if (t.steps.isNotEmpty) {
          expect(t.steps.length, fr.steps.length,
              reason: '$langue · $cle : ${t.steps.length} étapes '
                  'traduites pour ${fr.steps.length} en français. La '
                  'traduction serait ignorée en entier.');
        }
        if (t.ingredients.isNotEmpty) {
          expect(t.ingredients.length, fr.ingredients.length,
              reason: '$langue · $cle : ${t.ingredients.length} '
                  'ingrédients traduits pour ${fr.ingredients.length}.');
        }
      });
    });
  });

  test('les nombres d\'une traduction sont ceux du français', () {
    // Le test qui compte. Un « 30 g de sel » devenu « 1 oz of salt »
    // échoue ici, et c'est voulu : on traduit l'unité, pas la valeur.
    // Convertir en Fahrenheit échoue aussi, pour la même raison.
    recipeTextsByLanguage.forEach((langue, surcouche) {
      surcouche.forEach((cle, t) {
        final fr = parCle[cle];
        if (fr == null) return;

        void compare(String champ, String source, String traduit) {
          if (traduit.isEmpty) return;
          expect(nombres(traduit), nombres(source),
              reason: '$langue · $cle · $champ\n'
                  '  FR : $source\n'
                  '  $langue : $traduit\n'
                  '  Les nombres ont bougé. Sel, degrés, vinaigre et '
                  'temps de stérilisation sont des règles de sécurité '
                  'alimentaire : ils se recopient tels quels.');
        }

        compare('name', fr.name, t.name);
        compare('description', fr.description, t.description);
        if (fr.keeps != null && t.keeps != null) {
          compare('keeps', fr.keeps!, t.keeps!);
        }
        if (t.ingredients.length == fr.ingredients.length) {
          for (var i = 0; i < t.ingredients.length; i++) {
            compare('ingredients[$i]', fr.ingredients[i], t.ingredients[i]);
          }
        }
        if (t.steps.length == fr.steps.length) {
          for (var i = 0; i < t.steps.length; i++) {
            compare('steps[$i]', fr.steps[i].text, t.steps[i]);
          }
        }
      });
    });
  });

  test('une recette non traduite retombe sur le français', () {
    // ⚠️ Mis à jour le 02/11/2026 : les 736 recettes du catalogue sont
    // traduites, donc aucune ne sert plus de cas de repli. On en
    // fabrique une hors catalogue — elle n'a pas de propriétaire,
    // donc pas de traduction possible.
    const inconnue = Recipe(
      name: 'Gratin de rutabagas oubliés',
      emoji: '🥣',
      description: 'Une recette qui n\'est dans aucun catalogue.',
      ingredients: <String>['2 rutabagas'],
      steps: <RecipeStep>[RecipeStep('🔪', 'Épluche et coupe en rondelles.')],
    );
    expect(recipeNameIn(inconnue, 'en'), inconnue.name);
    expect(recipeStepsIn(inconnue, 'en'), inconnue.steps);
    expect(recipeIngredientsIn(inconnue, 'en'), inconnue.ingredients);
  });

  test('les 736 recettes sont traduites en anglais', () {
    // Verrou de couverture : si une recette est ajoutée au catalogue
    // sans sa traduction, elle sortira en français sous une interface
    // anglaise — et ce test le dira tout de suite.
    final manquantes = <String>[
      for (final e in recipesByVegetable.entries)
        for (final r in e.value)
          if (recipeTextFor(r, 'en') == null) '${e.key}/${r.name}',
    ];
    expect(manquantes, isEmpty,
        reason: '${manquantes.length} recettes sans traduction anglaise. '
            'Génère son lot : dart run tool/exporter_recettes.dart '
            '--squelette --langue=en --lot=N');
  });

  test('une langue inconnue retombe sur le français', () {
    final tomate = recipesByVegetable['tomate']!.first;
    expect(recipeNameIn(tomate, 'de'), tomate.name);
    expect(recipeNameIn(tomate, 'fr'), tomate.name);
  });

  group('tomate, le légume de référence', () {
    final top3 = top3For('tomate');

    test('ses trois conservations sont traduites en entier', () {
      // Le modèle que les 122 autres légumes copient. S'il se dégrade,
      // les lots suivants copieront un modèle dégradé.
      for (final r in top3) {
        final t = recipeTextFor(r, 'en');
        expect(t, isNotNull, reason: '« ${r.name} » n\'est pas traduite.');
        expect(t!.name, isNotEmpty);
        expect(t.description, isNotEmpty);
        expect(t.keeps, isNotNull);
        expect(t.keeps, isNotEmpty);
        expect(t.ingredients.length, r.ingredients.length);
        expect(t.steps.length, r.steps.length);
        for (final s in t.steps) {
          expect(s.length, greaterThan(20),
              reason: 'Étape trop courte pour dire quoi faire : « $s »');
        }
      }
    });

    test('la traduction garde emoji et minuteurs du catalogue', () {
      // Ce qui n'a pas de langue ne doit pas pouvoir se perdre en
      // route : un emoji choisit la scène animée du lecteur, un
      // minuteur fait sonner le téléphone.
      for (final r in top3) {
        final en = recipeStepsIn(r, 'en');
        expect(en.length, r.steps.length);
        for (var i = 0; i < en.length; i++) {
          expect(en[i].emoji, r.steps[i].emoji);
          expect(en[i].minutes, r.steps[i].minutes);
          expect(en[i].text, isNot(r.steps[i].text));
        }
      }
    });
  });

  test('les neuf méthodes sont traduites dans chaque langue', () {
    // Une langue déclarée dans `recipeTextsByLanguage` doit aussi
    // avoir ses neuf méthodes et ses unités de durée : sinon la
    // pastille de garde et le sous-titre restent en français sous un
    // titre traduit. C'est le genre de demi-traduction qu'on veut
    // voir échouer tout de suite.
    for (final langue in recipeTextsByLanguage.keys) {
      for (final m in PreservationMethod.values) {
        final t = methodLabelIn(m, langue);
        expect(t, isNotEmpty, reason: '$langue · ${m.label}');
        expect(t, isNot(m.label),
            reason: '$langue : « ${m.label} » n\'a pas d\'équivalent, '
                'la pastille de garde afficherait du français.');
      }
      expect(dureeLisibleIn(21 * 24 * 60, langue),
          isNot(dureeLisible(21 * 24 * 60)),
          reason: '$langue n\'a pas ses unités de durée : une '
              'conservation afficherait « 3 semaines ».');
      expect(playerUiFor(langue), isNotNull,
          reason: '$langue n\'a pas les libellés du lecteur : une '
              'recette traduite s\'ouvrirait dans une boîte '
              'française.');
    }
    for (final m in PreservationMethod.values) {
      expect(methodLabelIn(m, 'fr'), m.label);
    }
  });

  test('l\'espagnol a commencé et couvre un lot', () {
    // Verrou d'avancement : il dit où on en est, et il échouera quand
    // un lot de plus arrivera — c'est voulu, les chiffres des fiches
    // doivent suivre.
    final traduites = <String>[
      for (final e in recipesByVegetable.entries)
        for (final r in e.value)
          if (recipeTextFor(r, 'es') != null) '${e.key}/${r.name}',
    ];
    expect(traduites, hasLength(120),
        reason: '${traduites.length} recettes en espagnol. Si un lot '
            'vient d\'arriver, corrige ce chiffre, le README et '
            'docs/traduction-recettes.md.');
  });

  test('les durées se lisent dans la langue affichée', () {
    expect(dureeLisibleIn(45, 'en'), '45 min');
    expect(dureeLisibleIn(90, 'en'), '1 h 30');
    expect(dureeLisibleIn(24 * 60, 'en'), '1 day');
    expect(dureeLisibleIn(12 * 24 * 60, 'en'), '12 days');
    expect(dureeLisibleIn(21 * 24 * 60, 'en'), '3 weeks');
    expect(dureeLisibleIn(90 * 24 * 60, 'en'), '3 months');
    // Une langue sans table d'unités reste en français.
    expect(dureeLisibleIn(21 * 24 * 60, 'de'), dureeLisible(21 * 24 * 60));
  });

  test('deux recettes ne partagent pas le même objet', () {
    // Deux `const Recipe` aux champs rigoureusement identiques sont le
    // **même** objet en Dart, et tomberaient donc sur un seul
    // propriétaire — donc une seule traduction pour deux légumes.
    // `ownerOf()` a déjà ce défaut ; ce test garantit que le cas
    // n'existe pas dans le catalogue.
    final vues = <Recipe>{};
    var total = 0;
    for (final liste in recipesByVegetable.values) {
      for (final r in liste) {
        total++;
        vues.add(r);
      }
    }
    expect(vues.length, total,
        reason: 'Deux recettes identiques ont été fusionnées par Dart. '
            'Change une virgule dans l\'une des deux.');
  });
}
