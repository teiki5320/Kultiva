import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

void main() {
  _zoneTests();
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

    test('ordered : pays suggéré en premier, pas de privilège France', () {
      // Sans suggestion : ordre alphabétique, Bénin d'abord — la France
      // est dans le lot comme les autres.
      final neutral = Country.ordered();
      expect(neutral.length, equals(9));
      expect(neutral.first, equals(Country.benin));
      expect(neutral, containsAll(Country.values));

      // Avec suggestion : le pays détecté passe en tête, sans doublon.
      final sn = Country.ordered(first: Country.senegal);
      expect(sn.first, equals(Country.senegal));
      expect(sn.length, equals(9));
      expect(sn.toSet().length, equals(9));
    });
  });
}

void _zoneTests() {
  group('Country.zoneAt — affinage par latitude', () {
    test('latitude nulle → zone par défaut du pays', () {
      expect(Country.mali.zoneAt(null), equals(Country.mali.zone));
      expect(Country.senegal.zoneAt(null), equals(ClimateZone.sahel));
    });

    test('Mali : Bamako (12,6°N) est soudanien, le nord reste sahélien', () {
      expect(Country.mali.zoneAt(12.6), equals(ClimateZone.sudan));
      expect(Country.mali.zoneAt(16.3), equals(ClimateZone.sahel)); // Tombouctou
    });

    test('Côte d\'Ivoire : Abidjan guinéen, Korhogo soudanien', () {
      expect(Country.coteDivoire.zoneAt(5.3), equals(ClimateZone.guinean));
      expect(Country.coteDivoire.zoneAt(9.4), equals(ClimateZone.sudan));
    });

    test('Sénégal : Dakar sahélien, Casamance (Ziguinchor 12,5°N) plus humide',
        () {
      expect(Country.senegal.zoneAt(14.7), equals(ClimateZone.sahel));
      expect(Country.senegal.zoneAt(12.5), equals(ClimateZone.sudan));
    });

    test('France reste tempérée quelle que soit la latitude', () {
      expect(Country.france.zoneAt(48.8), equals(ClimateZone.temperate));
      expect(Country.france.zoneAt(5.0), equals(ClimateZone.temperate));
    });

    test('la capitale de chaque pays retombe sur une zone AO cohérente', () {
      for (final c in Country.westAfricanCountries) {
        final z = c.zoneAt(c.capitalLat);
        expect(ClimateZone.westAfricanZones, contains(z),
            reason: '${c.label} : $z');
      }
    });
  });

  group('ClimateZone', () {
    test('fromName roundtrip', () {
      for (final z in ClimateZone.values) {
        expect(ClimateZone.fromName(z.name), equals(z));
      }
      expect(ClimateZone.fromName(null), isNull);
      expect(ClimateZone.fromName('xxx'), isNull);
    });

    test('chaque zone a un label et une description', () {
      for (final z in ClimateZone.values) {
        expect(z.label, isNotEmpty);
        expect(z.description, isNotEmpty);
      }
    });
  });
}
