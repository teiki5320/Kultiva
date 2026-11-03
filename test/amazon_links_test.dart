import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/region_data.dart';
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
        final v = vegetableOfTheDay(jour, calendar: franceData);
        if (v.category == VegetableCategory.accessories) {
          fautifs.add('${jour.toIso8601String().substring(0, 10)} → ${v.name}');
        }
      }
      expect(fautifs, isEmpty,
          reason: 'Jours où le « légume du jour » est un accessoire :\n'
              '${fautifs.join('\n')}');
    });

    test('le même jour donne toujours le même légume', () {
      final a = vegetableOfTheDay(DateTime(2026, 6, 14, 8), calendar: franceData);
      final b =
          vegetableOfTheDay(DateTime(2026, 6, 14, 23), calendar: franceData);
      expect(a.id, b.id);
    });

    /// Vu à l'écran le 03/11/2026 sur une installation française :
    /// « Légume du jour · Arachide ». Le tirage piochait dans les 130
    /// cultures sans regarder le calendrier.
    ///
    /// Une culture est impossible ici de deux façons : elle n'a aucune
    /// entrée au calendrier d'ici, ou elle y a des mois mais la mention
    /// `shelterOnly` — « culture expérimentale », « résultats
    /// aléatoires en plein air ». Elle reste au catalogue avec sa
    /// pastille ; elle n'est pas mise en avant.
    for (final cas in <List<Object>>[
      <Object>['France', franceData],
      <Object>['Afrique de l\'Ouest', westAfricaData],
    ]) {
      final nom = cas[0] as String;
      final calendrier = cas[1] as List<RegionData>;

      test('$nom : le légume du jour pousse là où on jardine', () {
        final cultivables = <String>{};
        final sousAbri = <String>{};
        for (final rd in calendrier) {
          if (rd.shelterOnly) sousAbri.add(rd.vegetableId);
          if (rd.sowingMonths.isEmpty && rd.harvestMonths.isEmpty) continue;
          cultivables.add(rd.vegetableId);
        }

        final fautifs = <String>[];
        for (int j = 0; j < 366; j++) {
          final jour = DateTime(2026, 1, 1).add(Duration(days: j));
          final v = vegetableOfTheDay(jour, calendar: calendrier);
          final date = jour.toIso8601String().substring(0, 10);
          if (!cultivables.contains(v.id)) {
            fautifs.add('$date → ${v.id} (aucun mois au calendrier)');
          } else if (sousAbri.contains(v.id)) {
            fautifs.add('$date → ${v.id} (sous serre)');
          }
        }
        expect(fautifs, isEmpty,
            reason: 'Mis en avant alors qu\'ils ne poussent pas en $nom :\n'
                '${fautifs.take(12).join('\n')}');
      });
    }

    test('changer de calendrier change ce qui est mis en avant', () {
      // Sans ça, un paramètre ignoré passerait les tests ci-dessus :
      // ils vérifient chacun leur propre calendrier.
      var differents = 0;
      for (int j = 0; j < 366; j++) {
        final jour = DateTime(2026, 1, 1).add(Duration(days: j));
        if (vegetableOfTheDay(jour, calendar: franceData).id !=
            vegetableOfTheDay(jour, calendar: westAfricaData).id) {
          differents++;
        }
      }
      expect(differents, greaterThan(100),
          reason: 'France et Afrique de l\'Ouest n\'excluent pas les mêmes '
              'cultures : leurs listes ne peuvent pas coïncider.');
    });

    test('un calendrier vide ne vide pas l\'écran d\'accueil', () {
      final v =
          vegetableOfTheDay(DateTime(2026, 6, 14), calendar: <RegionData>[]);
      expect(v.category, isNot(VegetableCategory.accessories));
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
