import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

void main() {
  group('Country', () {
    test('9 pays : France + 8 pays francophones AO', () {
      expect(Country.values.length, equals(9));
      expect(Country.westAfricanCountries.length, equals(8));
      for (final c in Country.westAfricanCountries) {
        expect(c.region, equals(Region.westAfrica),
            reason: '${c.label} doit être en région Afrique de l\'Ouest');
      }
      expect(Country.france.region, equals(Region.france));
    });

    test('fromIso retrouve un pays, insensible à la casse', () {
      expect(Country.fromIso('SN'), equals(Country.senegal));
      expect(Country.fromIso('sn'), equals(Country.senegal));
      expect(Country.fromIso('CI'), equals(Country.coteDivoire));
      expect(Country.fromIso('FR'), equals(Country.france));
      expect(Country.fromIso('US'), isNull);
      expect(Country.fromIso(null), isNull);
    });

    test('chaque pays a un drapeau, un label et une capitale', () {
      for (final c in Country.values) {
        expect(c.flag, isNotEmpty);
        expect(c.label, isNotEmpty);
        expect(c.capitalName, isNotEmpty);
        expect(c.capitalLat, inInclusiveRange(-90, 90));
        expect(c.capitalLon, inInclusiveRange(-180, 180));
      }
    });

    test('coordsInWestAfrica : capitales AO dedans, Paris dehors', () {
      for (final c in Country.westAfricanCountries) {
        expect(
          Country.coordsInWestAfrica(c.capitalLat, c.capitalLon),
          isTrue,
          reason: '${c.capitalName} doit être dans la boîte AO',
        );
      }
      expect(
        Country.coordsInWestAfrica(
            Country.france.capitalLat, Country.france.capitalLon),
        isFalse,
      );
    });

    test('les capitales AO sont sous les tropiques (lat < 25°N)', () {
      for (final c in Country.westAfricanCountries) {
        expect(c.capitalLat, lessThan(25));
        expect(c.capitalLat, greaterThan(0));
      }
    });
  });
}
