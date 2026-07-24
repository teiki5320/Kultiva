import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/utils/text_normalize.dart';

void main() {
  group('foldAccents', () {
    test('replie les diacritiques et met en minuscules', () {
      expect(foldAccents('Échalote'), 'echalote');
      expect(foldAccents('Épinard'), 'epinard');
      expect(foldAccents('Cœur'), 'coeur');
      expect(foldAccents('Piment doux'), 'piment doux');
    });
  });

  group('compareFolded', () {
    test('Échalote et Épinard ne sont plus relégués après le Z', () {
      final list = <String>[
        'Zucchini',
        'Échalote',
        'Épinard',
        'Ail',
        'Basilic'
      ];
      list.sort(compareFolded);
      expect(
          list, <String>['Ail', 'Basilic', 'Échalote', 'Épinard', 'Zucchini']);
    });

    test('recherche insensible aux accents', () {
      expect(foldAccents('Échalote').contains(foldAccents('echalote')), isTrue);
    });
  });
}
