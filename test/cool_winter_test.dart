import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/regional_calendar.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/regions/west_africa_zones.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

/// La neuvième zone, ajoutée le 02/11/2026 : tropical à hiver frais.
///
/// Les huit autres n'avaient pas d'hiver. Hanoï cultive chou et carotte
/// en décembre à 16 °C, et le maraîchage de Delhi est le *rabi*, de
/// novembre à mars — une saison entière que les calendriers guinéen et
/// soudanien passaient sous silence.
void main() {
  final baseParId = <String, RegionData>{
    for (final r in westAfricaData) r.vegetableId: r,
  };

  test('aucune culture inventée', () {
    for (final cle in coolWinterCalendar.keys) {
      expect(baseParId.containsKey(cle), isTrue,
          reason: '« $cle » n\'est pas dans le calendrier tropical.');
    }
  });

  test('les mois sont des mois', () {
    coolWinterCalendar.forEach((id, m) {
      for (final liste in <List<int>>[m.sowingMonths, m.harvestMonths]) {
        expect(liste, isNotEmpty, reason: id);
        for (final mois in liste) {
          expect(mois, inInclusiveRange(1, 12), reason: id);
        }
        expect(liste.toSet().length, liste.length,
            reason: '$id : un mois en double');
      }
    });
  });

  test('aucune surcharge ne répète la base soudanienne', () {
    // Une surcharge identique à la base est du bruit : elle laisse
    // croire que la zone a été pensée pour cette culture.
    coolWinterCalendar.forEach((id, m) {
      final base = baseParId[id]!;
      final pareil = m.sowingMonths.join(',') == base.sowingMonths.join(',') &&
          m.harvestMonths.join(',') == base.harvestMonths.join(',');
      expect(pareil, isFalse, reason: '$id répète la base, retire-la.');
    });
  });

  test('aucun légume tempéré n\'est semé au cœur de la mousson', () {
    // Le point de toute la zone. Un chou semé en juin, sous 35 °C et
    // la pluie, pourrit avant de pommer.
    //
    // ⚠️ Le seuil n'est pas « après septembre » : la pépinière de
    // chou-fleur part en août, fin de mousson, et c'est la pratique
    // réelle du nord de l'Inde. Ce qui est interdit, c'est avril à
    // juillet — la chaleur sèche puis le cœur des pluies.
    const interdits = <int>{4, 5, 6, 7};
    for (final id in <String>[
      'chou_pomme',
      'chou_fleur',
      'chou_bruxelles',
      'carotte',
      'petit_pois',
      'pomme_de_terre',
      'epinard',
      'navet',
      'laitue',
    ]) {
      final m = coolWinterCalendar[id];
      expect(m, isNotNull, reason: '$id devrait avoir un calendrier rabi');
      expect(m!.sowingMonths.any(interdits.contains), isFalse,
          reason: '$id semé en ${m.sowingMonths}, dont la mousson');
    }
  });

  test('et récoltés en hiver ou au début du printemps', () {
    const hiver = <int>{11, 12, 1, 2, 3, 4, 5};
    for (final id in <String>['chou_pomme', 'carotte', 'petit_pois', 'oignon']) {
      final m = coolWinterCalendar[id]!;
      expect(m.harvestMonths.every(hiver.contains), isTrue,
          reason: '$id récolté en ${m.harvestMonths}');
    }
  });

  test('la zone est tropicale et tire la base tropicale', () {
    expect(ClimateZone.coolWinter.isTropical, isTrue);
    final cal = regionalCalendar(Region.tropical,
        zone: ClimateZone.coolWinter);
    expect(cal, hasLength(westAfricaData.length));
  });

  test('elle diffère vraiment du soudanien et du guinéen', () {
    String sig(List<RegionData> c) => c
        .map((r) => '${r.vegetableId}:${r.sowingMonths}:${r.harvestMonths}')
        .join('|');
    final frais = sig(regionalCalendar(Region.tropical,
        zone: ClimateZone.coolWinter));
    expect(frais,
        isNot(sig(regionalCalendar(Region.tropical, zone: ClimateZone.sudan))));
    expect(
        frais,
        isNot(sig(
            regionalCalendar(Region.tropical, zone: ClimateZone.guinean))));
  });

  group('les deux pays qui la portent', () {
    test('Delhi et Hanoï l\'ont, leur sud ne l\'a pas', () {
      expect(Country.inde.zoneAt(28.6), ClimateZone.coolWinter);
      expect(Country.inde.zoneAt(13.0), ClimateZone.guinean);
      expect(Country.vietnam.zoneAt(21.0), ClimateZone.coolWinter);
      expect(Country.vietnam.zoneAt(10.8), ClimateZone.guinean);
    });

    test('sans latitude, la capitale décide', () {
      expect(Country.inde.zone, ClimateZone.coolWinter);
      expect(Country.vietnam.zone, ClimateZone.coolWinter);
    });
  });
}
