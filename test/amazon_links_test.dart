import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Les liens partenaires Amazon.
///
/// Ils ont déjà été perdus une fois : le compte `kultiva-21` fermé le
/// 18 octobre 2026, les 159 liens supprimés le 20, puis remis le
/// 30 avec le tag `kultiva1-21`. Le tag vit maintenant dans une seule
/// constante, et ces tests vérifient qu'aucune URL ne le contourne.
void main() {
  group('liens partenaires', () {
    test('le catalogue porte bien 159 requêtes', () {
      final avec = vegetablesBase.where((v) => v.amazonQuery != null).length;
      expect(avec, 159);
    });

    test('chaque lien pointe sur amazon.fr avec le bon tag', () {
      for (final v in vegetablesBase.where((v) => v.amazonQuery != null)) {
        final url = amazonUrlFor(v);
        expect(url, isNotNull, reason: v.id);
        final uri = Uri.parse(url!);
        expect(uri.host, 'www.amazon.fr', reason: v.id);
        expect(uri.path, '/s', reason: v.id);
        expect(uri.queryParameters['tag'], kAmazonAffiliateTag, reason: v.id);
        expect(uri.queryParameters['k'], isNotEmpty, reason: v.id);
      }
    });

    test('la recherche est rendue telle quelle dans l\'URL', () {
      final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');
      final uri = Uri.parse(amazonUrlFor(tomate)!);
      expect(uri.queryParameters['k'], tomate.amazonQuery);
    });

    test('un légume sans requête n\'a pas de lien', () {
      const sansLien = Vegetable(
        id: 'test',
        name: 'Test',
        emoji: '🧪',
        category: VegetableCategory.leaves,
      );
      expect(amazonUrlFor(sansLien), isNull);
    });

    test('aucune URL Amazon n\'est écrite en dur ailleurs', () {
      // Le tag doit rester dans une seule constante : c'est ce qui a
      // rendu le changement de compte coûteux la première fois.
      for (final v in vegetablesBase) {
        expect(v.amazonQuery, isNot(contains('amazon.')), reason: v.id);
        expect(v.amazonQuery, isNot(contains('tag=')), reason: v.id);
      }
    });
  });

  group('légume du jour', () {
    test('ce n\'est jamais un accessoire, aucun jour de l\'année', () {
      final fautifs = <String>[];
      for (int j = 0; j < 366; j++) {
        final jour = DateTime(2026, 1, 1).add(Duration(days: j));
        final v = vegetableOfTheDay(jour);
        if (v.category == VegetableCategory.accessories) {
          fautifs.add('${jour.toIso8601String().substring(0, 10)} → ${v.name}');
        }
      }
      expect(fautifs, isEmpty,
          reason: 'Jours où le « légume du jour » est un accessoire :\n'
              '${fautifs.join('\n')}');
    });

    test('le même jour donne toujours le même légume', () {
      final a = vegetableOfTheDay(DateTime(2026, 6, 14, 8));
      final b = vegetableOfTheDay(DateTime(2026, 6, 14, 23));
      expect(a.id, b.id);
    });

    test('les cultures excluent les 39 accessoires', () {
      expect(cultures.length, vegetablesBase.length - 39);
      expect(
        cultures.any((v) => v.category == VegetableCategory.accessories),
        isFalse,
      );
    });
  });
}
