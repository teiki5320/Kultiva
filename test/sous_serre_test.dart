import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/regional_calendar.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

/// « Certains produits ne devraient pas être en Europe » — Jean, le
/// 02/11/2026. En mai, l'écran Semer d'un jardinier lyonnais comptait
/// le manioc, le taro et l'igname parmi les légumes à semer, alors que
/// leur propre fiche disait « non adapté au climat français ».
///
/// L'information existait, mais en prose, dans `regionalNote` : le code
/// n'en savait rien. Elle est maintenant dans `shelterOnly`, et la
/// vignette porte une pastille. ⚠️ Choix de Jean : on **montre** la
/// culture avec son avertissement plutôt que de la cacher.
void main() {
  RegionData? dans(List<RegionData> l, String id) {
    for (final r in l) {
      if (r.vegetableId == id) return r;
    }
    return null;
  }

  test('les cultures tropicales sont marquées en France', () {
    for (final id in <String>[
      'manioc', 'taro', 'igname', 'bissap', 'arachide', 'sesame',
      'gombo', 'pasteque', 'patate_douce',
    ]) {
      final r = dans(franceData, id);
      expect(r, isNotNull, reason: id);
      expect(r!.shelterOnly, isTrue, reason: id);
    }
  });

  test('et les cultures ordinaires ne le sont pas', () {
    for (final id in <String>['tomate', 'carotte', 'laitue', 'poireau']) {
      expect(dans(franceData, id)!.shelterOnly, isFalse, reason: id);
    }
  });

  test('une note qui dit « non adapté » va avec le drapeau', () {
    // Le drapeau et la prose ne doivent pas se contredire : c'est la
    // contradiction qui a laissé passer le manioc pendant des mois.
    const mots = <String>[
      'Non adapté', 'non adapté', 'expérimental', 'serre chauffée',
      'réservé au sud', 'réservée au sud',
    ];
    for (final r in franceData) {
      final note = r.regionalNote ?? '';
      final dit = mots.any(note.contains);
      if (dit) {
        expect(r.shelterOnly, isTrue,
            reason: '${r.vegetableId} : la note dit que ça ne tient pas '
                'dehors, le drapeau dit que si.\n  $note');
      }
    }
  });

  test('la base tropicale n\'a pas besoin du drapeau', () {
    // Elle règle le même problème autrement, et depuis le début : un
    // pommier y a des mois **vides**, donc il n'apparaît jamais dans
    // Semer à Dakar.
    for (final id in <String>['pommier', 'cassissier', 'kiwi', 'framboisier']) {
      final r = dans(westAfricaData, id)!;
      expect(r.sowingMonths, isEmpty, reason: id);
      expect(r.harvestMonths, isEmpty, reason: id);
    }
  });

  group('la zone peut lever le drapeau', () {
    test('la pastèque est sous serre à Lille, pas à Séville', () {
      final lille = regionalCalendar(Region.france,
          zone: ClimateZone.temperate);
      final seville = regionalCalendar(Region.france,
          zone: ClimateZone.mediterranean);
      expect(dans(lille, 'pasteque')!.shelterOnly, isTrue);
      // Le méditerranéen a son calendrier écrit à la main : il a déjà
      // tranché, et il l'emporte.
      expect(dans(seville, 'pasteque')!.shelterOnly, isFalse);
    });

    test('mais le manioc reste sous serre partout en zone tempérée', () {
      for (final z in <ClimateZone>[
        ClimateZone.temperate,
        ClimateZone.mediterranean,
        ClimateZone.continental,
        ClimateZone.subtropical,
      ]) {
        final cal = regionalCalendar(Region.france, zone: z);
        expect(dans(cal, 'manioc')!.shelterOnly, isTrue, reason: z.name);
      }
    });
  });
}
