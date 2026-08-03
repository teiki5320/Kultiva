import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/local_names.dart';
import 'package:kultiva/data/vegetables_base.dart';

void main() {
  group('localNames', () {
    test('chaque clé correspond à un id du catalogue', () {
      final validIds = vegetablesBase.map((v) => v.id).toSet();
      for (final id in localNames.keys) {
        expect(validIds, contains(id),
            reason: "'$id' n'existe pas dans vegetablesBase");
      }
    });

    test('aucune liste de noms locaux n\'est vide', () {
      for (final entry in localNames.entries) {
        expect(entry.value, isNotEmpty,
            reason: "'${entry.key}' a une liste de noms vide");
      }
    });

    test('aucun nom ni aucune langue n\'est une chaîne vide', () {
      for (final entry in localNames.entries) {
        for (final localName in entry.value) {
          expect(localName.name.trim(), isNotEmpty,
              reason: "'${entry.key}' contient un nom vide");
          expect(localName.language.trim(), isNotEmpty,
              reason: "'${entry.key}' contient une langue vide");
        }
      }
    });
  });
}
