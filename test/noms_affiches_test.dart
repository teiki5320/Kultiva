import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Un garde-fou contre le défaut qui est revenu treize fois.
///
/// `Vegetable.name` est le nom **français** : la clé des données, de la
/// recherche sans accent et des tests. Ce qui s'affiche, c'est
/// `displayName`. Onze endroits confondaient les deux le 01/11/2026,
/// un douzième le 02/11 (la vignette du catalogue, qui disait « Chou
/// kale » à un anglophone) et un treizième le même jour (les pastilles
/// de compagnonnage et de rotation, vues en espagnol à l'écran).
///
/// `flutter analyze` ne peut rien dire : les deux sont des `String`.
void main() {
  test('aucun écran n\'affiche Vegetable.name', () {
    final fautes = <String>[];
    // Les expressions qui **affichent** un nom. On ne cherche pas
    // `v.name` partout : la recherche et les clés s'en servent à bon
    // droit, et c'est pour ça que le défaut est passé treize fois.
    final motifs = <RegExp>[
      RegExp(r'Text\(\s*(\w+)\.name\b'),
      RegExp(r'label:\s*Text\(\s*(\w+)\.name\b'),
      RegExp(r'title:\s*Text\(\s*(\w+)\.name\b'),
      RegExp(r'<Object\?>\[\s*(\w+)\.name\s*\]'),
    ];
    for (final f in Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))) {
      final lignes = f.readAsLinesSync();
      for (var i = 0; i < lignes.length; i++) {
        // Une ligne de données ou un commentaire ne compte pas.
        final l = lignes[i];
        if (l.trimLeft().startsWith('//')) continue;
        for (final m in motifs) {
          final hit = m.firstMatch(l);
          if (hit == null) continue;
          final v = hit.group(1)!;
          // `region.name`, `zone.name`… sont des enums, pas un légume.
          if (<String>['region', 'zone', 'category', 'phase', 'season',
                  'hemisphere', 'tier', 'method', 'c', 'e', 'd', 'b']
              .contains(v)) {
            continue;
          }
          fautes.add('${f.path}:${i + 1}  ${l.trim()}');
        }
      }
    }
    expect(fautes, isEmpty,
        reason: 'Ces lignes affichent le nom français d\'un légume. '
            'Utilise `displayName` :\n  ${fautes.join("\n  ")}');
  });
}
