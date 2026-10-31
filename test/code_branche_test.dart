import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// « Brancher ce qu'on écrit » — la règle 10 de CLAUDE.md, vérifiée.
///
/// Ce projet a livré cinq fois une fonctionnalité qu'aucun chemin de
/// l'app n'atteignait : les quatre écrans du Poussidex (2 168 lignes
/// injoignables, découvertes le 30/10/2026) et l'avertissement de
/// rotation, promis par la fiche App Store et la landing alors que
/// `rotation_advisor.dart` n'était importé par aucun fichier
/// (31/10/2026). À chaque fois, `flutter analyze` était vert : un
/// fichier que personne n'importe ne produit aucun avertissement.
///
/// Le test part de `main.dart` et suit les `import` et les `export`.
/// Tout fichier de `lib/` qu'on n'atteint pas est du code mort, ou
/// une fonctionnalité oubliée en chemin.
void main() {
  test('tout fichier de lib/ est atteignable depuis main.dart', () {
    final tous = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .map((f) => p.normalize(f.path))
        .where((f) => f.endsWith('.dart'))
        .toSet();

    final directive =
        RegExp(r"^\s*(?:import|export)\s+'([^']+)'", multiLine: true);

    String? resoudre(String depuis, String cible) {
      if (cible.startsWith('dart:')) return null;
      if (cible.startsWith('package:kultiva/')) {
        return p.normalize('lib/${cible.substring('package:kultiva/'.length)}');
      }
      if (cible.startsWith('package:')) return null;
      return p.normalize(p.join(p.dirname(depuis), cible));
    }

    final atteints = <String>{};
    final aVisiter = <String>['lib/main.dart'];
    while (aVisiter.isNotEmpty) {
      final f = aVisiter.removeLast();
      if (!atteints.add(f)) continue;
      if (!File(f).existsSync()) continue;
      for (final m in directive.allMatches(File(f).readAsStringSync())) {
        final cible = resoudre(f, m.group(1)!);
        if (cible != null && !atteints.contains(cible)) aVisiter.add(cible);
      }
    }

    final orphelins = tous.difference(atteints).toList()..sort();
    expect(
      orphelins,
      isEmpty,
      reason: 'Ces fichiers ne sont atteints par aucun chemin de l\'app.\n'
          'Soit ils doivent être branchés, soit supprimés — les garder '
          'donne l\'illusion que la fonctionnalité existe :\n'
          '  ${orphelins.join("\n  ")}',
    );
  });
}
