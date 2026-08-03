import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/utils/water_calendar.dart';

void main() {
  group('rainyMonths par zone', () {
    test('sahel : pluies courtes juin-septembre', () {
      expect(rainyMonths(ClimateZone.sahel), equals(<int>{6, 7, 8, 9}));
    });
    test('guinéenne : deux saisons des pluies', () {
      final g = rainyMonths(ClimateZone.guinean);
      expect(g.contains(5), isTrue); // grande saison
      expect(g.contains(10), isTrue); // seconde saison
      expect(g.contains(8), isFalse); // petite saison sèche
    });
    test('soudanienne / défaut : juin-octobre', () {
      expect(rainyMonths(null), equals(<int>{6, 7, 8, 9, 10}));
      expect(rainyMonths(ClimateZone.sudan), equals(<int>{6, 7, 8, 9, 10}));
    });
  });

  group('waterAdvisory', () {
    test('sahel en pleine saison sèche → compte les jours vers les pluies',
        () {
      // 1er mars : saison sèche, pluies sahéliennes en juin.
      final a = waterAdvisory(DateTime(2026, 3, 1), ClimateZone.sahel);
      expect(a.raining, isFalse);
      expect(a.daysToRain, greaterThan(80)); // ~ jusqu'au 1er juin
      expect(a.daysToRain, lessThan(100));
      expect(a.daysToDry, equals(-1));
      expect(a.message, contains('goutte'));
    });

    test('sahel en août → en pleine saison des pluies, fin approchant', () {
      final a = waterAdvisory(DateTime(2026, 8, 15), ClimateZone.sahel);
      expect(a.raining, isTrue);
      expect(a.daysToDry, greaterThan(0)); // fin des pluies fin sept
      expect(a.daysToDry, lessThan(60));
      expect(a.daysToRain, equals(-1));
    });

    test('sahel en juin → première quinzaine de pluies, pas de fin proche',
        () {
      final a = waterAdvisory(DateTime(2026, 6, 5), ClimateZone.sahel);
      expect(a.raining, isTrue);
      // La fin (fin septembre) est loin → message hivernage, pas « fin ».
      expect(a.daysToDry, greaterThan(35));
    });

    test('guinéenne : la petite saison sèche d\'août est bien détectée', () {
      final a = waterAdvisory(DateTime(2026, 8, 10), ClimateZone.guinean);
      expect(a.raining, isFalse); // août = petite saison sèche côtière
      expect(a.daysToRain, greaterThan(0));
      expect(a.daysToRain, lessThan(40)); // reprise des pluies en septembre
    });

    test('humanizeDays : jours puis semaines', () {
      expect(WaterAdvisory.humanizeDays(5), equals('~5 jours'));
      expect(WaterAdvisory.humanizeDays(21), equals('~3 semaines'));
      expect(WaterAdvisory.humanizeDays(-1), equals(''));
    });
  });

  group('waterTechniques', () {
    test('chaque technique a un titre, une description et un emoji', () {
      expect(waterTechniques, isNotEmpty);
      for (final t in waterTechniques) {
        expect(t.title, isNotEmpty);
        expect(t.description, isNotEmpty);
        expect(t.emoji, isNotEmpty);
      }
    });
  });
}
