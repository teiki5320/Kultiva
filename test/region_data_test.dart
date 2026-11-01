import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/models/region_data.dart';

void main() {
  group('Region enum', () {
    test('trois bases : tempérée, ouest-africaine, tropicale', () {
      expect(Region.values.length, equals(3));
      expect(Region.values, contains(Region.france));
      expect(Region.values, contains(Region.westAfrica));
      expect(Region.values, contains(Region.tropical));
    });

    test('les deux bases tropicales se reconnaissent comme telles', () {
      expect(Region.westAfrica.isTropicalBase, isTrue);
      expect(Region.tropical.isTropicalBase, isTrue);
      expect(Region.france.isTropicalBase, isFalse);
    });

    test('les identifiants persistés ne changent pas', () {
      // Ils sont écrits dans les préférences des installations
      // existantes : les renommer ferait perdre sa région à chacun.
      expect(Region.france.id, 'france');
      expect(Region.westAfrica.id, 'west_africa');
    });

    test('chaque région a un label non vide', () {
      for (final r in Region.values) {
        expect(r.label, isNotEmpty, reason: '${r.id} a un label vide');
      }
    });

    test('chaque région a un emoji non vide', () {
      for (final r in Region.values) {
        expect(r.emoji, isNotEmpty, reason: '${r.id} a un emoji vide');
      }
    });

    test('chaque région a un id non vide', () {
      for (final r in Region.values) {
        expect(r.id, isNotEmpty, reason: '${r.name} a un id vide');
      }
    });

    test('fromId renvoie la bonne région', () {
      expect(Region.fromId('france'), equals(Region.france));
      expect(Region.fromId('west_africa'), equals(Region.westAfrica));
    });

    test('fromId retombe sur france pour null ou inconnu', () {
      expect(Region.fromId(null), equals(Region.france));
      expect(Region.fromId('mars'), equals(Region.france));
      expect(Region.fromId(''), equals(Region.france));
    });
  });

  group('Données de semis — France', () {
    test('la liste contient des entrées', () {
      expect(franceData, isNotEmpty,
          reason: 'franceData ne devrait pas etre vide');
    });

    test('tous les mois de semis sont entre 1 et 12', () {
      for (final rd in franceData) {
        for (final m in rd.sowingMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} mois de semis hors plage : $m');
        }
      }
    });

    test('tous les mois de récolte sont entre 1 et 12', () {
      for (final rd in franceData) {
        for (final m in rd.harvestMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} mois de récolte hors plage : $m');
        }
      }
    });

    test('chaque entrée a un vegetableId non vide', () {
      for (final rd in franceData) {
        expect(rd.vegetableId, isNotEmpty);
      }
    });

    test('chaque entrée a le bon regionId', () {
      for (final rd in franceData) {
        expect(rd.regionId, equals('france'));
      }
    });

    test('pas de vegetableId en doublon', () {
      final ids = franceData.map((rd) => rd.vegetableId).toList();
      expect(ids.toSet().length, equals(ids.length),
          reason: 'Doublons dans franceData');
    });
  });

  group("Données de semis — Afrique de l'Ouest", () {
    test('la liste contient des entrées', () {
      expect(westAfricaData, isNotEmpty,
          reason: 'westAfricaData ne devrait pas etre vide');
    });

    test('tous les mois de semis sont entre 1 et 12', () {
      for (final rd in westAfricaData) {
        for (final m in rd.sowingMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} mois de semis hors plage : $m');
        }
      }
    });

    test('tous les mois de récolte sont entre 1 et 12', () {
      for (final rd in westAfricaData) {
        for (final m in rd.harvestMonths) {
          expect(m, inInclusiveRange(1, 12),
              reason: '${rd.vegetableId} mois de récolte hors plage : $m');
        }
      }
    });

    test('chaque entrée a un vegetableId non vide', () {
      for (final rd in westAfricaData) {
        expect(rd.vegetableId, isNotEmpty);
      }
    });

    test('chaque entrée a le bon regionId', () {
      for (final rd in westAfricaData) {
        expect(rd.regionId, equals('west_africa'));
      }
    });

    test('pas de vegetableId en doublon', () {
      final ids = westAfricaData.map((rd) => rd.vegetableId).toList();
      expect(ids.toSet().length, equals(ids.length),
          reason: 'Doublons dans westAfricaData');
    });
  });

  group('RegionData construction', () {
    test('RegionData accepte une note régionale optionnelle', () {
      const rd = RegionData(
        regionId: 'france',
        vegetableId: 'tomate',
        sowingMonths: [3, 4],
        harvestMonths: [8, 9],
        regionalNote: 'Sous abri en mars',
      );
      expect(rd.regionalNote, equals('Sous abri en mars'));
    });

    test('RegionData sans note régionale a null par défaut', () {
      const rd = RegionData(
        regionId: 'france',
        vegetableId: 'tomate',
        sowingMonths: [3, 4],
        harvestMonths: [8, 9],
      );
      expect(rd.regionalNote, isNull);
    });
  });
}
