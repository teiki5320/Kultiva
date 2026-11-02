// Sort les textes des recettes, pour les faire traduire.
//
// `lib/data/recipes.dart` fait 11 821 lignes de Dart, avec des
// apostrophes et des dollars échappés. Faire éditer ce fichier par
// quelqu'un d'autre — un agent de traduction, par exemple — c'est
// risquer de casser la compilation sur un `\'` oublié.
//
// Cet outil importe le catalogue au lieu de le lire : pas d'expression
// régulière, donc pas de mauvaise surprise sur un nom contenant une
// apostrophe. Il produit soit du JSON, soit un squelette Dart déjà
// valide où il ne reste qu'à remplir des chaînes vides.
//
// Usage :
//   dart run tool/exporter_recettes.dart --json
//   dart run tool/exporter_recettes.dart --squelette --langue=en --lot=1
//   dart run tool/exporter_recettes.dart --lots            (le découpage)
//
// Un lot = 20 légumes. Sept lots couvrent les 123 cultures
// comestibles, et chacun se traduit indépendamment des autres.

import 'dart:convert';
import 'dart:io';

import '../lib/data/recipes.dart';

/// Combien de légumes par lot. Vingt légumes font environ 60
/// conservations : assez pour valoir un aller-retour, assez peu pour
/// qu'une relecture reste possible.
const int legumesParLot = 20;

void main(List<String> args) {
  final json = args.contains('--json');
  final lots = args.contains('--lots');
  final squelette = args.contains('--squelette');
  final langue = _arg(args, '--langue') ?? 'en';
  final lot = int.tryParse(_arg(args, '--lot') ?? '1') ?? 1;

  final ids = recipesByVegetable.keys.toList()..sort();
  final decoupage = <List<String>>[
    for (var i = 0; i < ids.length; i += legumesParLot)
      ids.sublist(i, i + legumesParLot > ids.length ? ids.length : i + legumesParLot),
  ];

  if (lots) {
    stdout.writeln('${ids.length} légumes, ${decoupage.length} lots '
        'de $legumesParLot :');
    for (var i = 0; i < decoupage.length; i++) {
      final l = decoupage[i];
      final recettes = l.fold<int>(
          0, (n, id) => n + (recipesByVegetable[id]?.length ?? 0));
      stdout.writeln('  lot ${i + 1} — ${l.length} légumes, '
          '$recettes recettes — ${l.first} … ${l.last}');
    }
    return;
  }

  if (json) {
    stdout.writeln(const JsonEncoder.withIndent('  ').convert(<String, dynamic>{
      for (final id in ids)
        id: <Map<String, dynamic>>[
          for (final r in recipesByVegetable[id]!) _enJson(r),
        ],
    }));
    return;
  }

  if (squelette) {
    if (lot < 1 || lot > decoupage.length) {
      stderr.writeln('Lot $lot inconnu : il y en a ${decoupage.length}.');
      exitCode = 2;
      return;
    }
    stdout.write(_squelette(decoupage[lot - 1], langue, lot, decoupage.length));
    return;
  }

  stderr.writeln('Rien demandé. --json, --lots ou --squelette.');
  exitCode = 2;
}

String? _arg(List<String> args, String nom) {
  for (final a in args) {
    if (a.startsWith('$nom=')) return a.substring(nom.length + 1);
  }
  return null;
}

Map<String, dynamic> _enJson(Recipe r) => <String, dynamic>{
      'name': r.name,
      'emoji': r.emoji,
      'description': r.description,
      if (r.keeps != null) 'keeps': r.keeps,
      if (r.method != null) 'method': r.method!.name,
      'ingredients': r.ingredients,
      'steps': <Map<String, dynamic>>[
        for (final s in r.steps)
          <String, dynamic>{
            'emoji': s.emoji,
            'text': s.text,
            if (s.minutes != null) 'minutes': s.minutes,
          },
      ],
    };

/// Le squelette d'un lot : du Dart déjà valide, à remplir.
///
/// Le texte français est en commentaire au-dessus de chaque chaîne
/// vide. Un traducteur voit donc la phrase à traduire sans avoir à
/// ouvrir le catalogue, et il n'édite que des chaînes.
String _squelette(List<String> ids, String langue, int lot, int total) {
  final out = StringBuffer();
  final recettes =
      ids.fold<int>(0, (n, id) => n + (recipesByVegetable[id]?.length ?? 0));

  out.writeln('// LOT $lot sur $total — ${ids.length} légumes, '
      '$recettes recettes — à traduire en « $langue ».');
  out.writeln('//');
  out.writeln('// Remplace chaque \'\' par la traduction. Le français est en');
  out.writeln('// commentaire juste au-dessus.');
  out.writeln('//');
  out.writeln('// ⚠️ Ne change RIEN d\'autre : ni les clés (à gauche du');
  out.writeln('//    `:`), ni l\'ordre des étapes, ni les nombres. Les grammes');
  out.writeln('//    de sel, les degrés et les pourcentages de vinaigre sont');
  out.writeln('//    des règles de sécurité alimentaire — un 3 % devenu 2 %');
  out.writeln('//    rend malade. Un test refuse le fichier si un nombre a');
  out.writeln('//    bougé.');
  out.writeln('//');
  out.writeln('// Les unités, elles, se traduisent : « 30 g de sel » devient');
  out.writeln('// « 30 g of salt », pas « 1 oz of salt » — le nombre reste.');
  out.writeln();

  for (final id in ids) {
    final liste = recipesByVegetable[id]!;
    out.writeln('  // ─────────── $id (${liste.length} recettes) ───────────');
    for (final r in liste) {
      out.writeln('  \'$id/${_esc(r.name)}\': RecipeText(');
      out.writeln('    // FR: ${r.name}');
      out.writeln('    name: \'\',');
      out.writeln('    // FR: ${r.description}');
      out.writeln('    description: \'\',');
      if (r.keeps != null) {
        out.writeln('    // FR: ${r.keeps}');
        out.writeln('    keeps: \'\',');
      }
      if (r.ingredients.isNotEmpty) {
        out.writeln('    ingredients: <String>[');
        for (final i in r.ingredients) {
          out.writeln('      \'\', // FR: $i');
        }
        out.writeln('    ],');
      }
      if (r.steps.isNotEmpty) {
        out.writeln('    steps: <String>[');
        for (final s in r.steps) {
          out.writeln('      // FR: ${s.text}');
          out.writeln('      \'\',');
        }
        out.writeln('    ],');
      }
      out.writeln('  ),');
    }
    out.writeln();
  }
  return out.toString();
}

/// Échappe ce qui doit l'être dans une chaîne Dart entre apostrophes.
String _esc(String s) =>
    s.replaceAll('\\', '\\\\').replaceAll('\'', '\\\'').replaceAll('\$', '\\\$');
