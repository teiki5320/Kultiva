import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/watering_alert.dart';

/// Couvre le bug qui faisait partir la notification « ta tomate a besoin
/// d'eau » alors que l'utilisateur venait de l'arroser dans l'app.
///
/// L'alerte ne comptait que les jours **sans pluie**. Elle compte
/// maintenant les jours sans **eau**, pluie ou arrosoir.
void main() {
  final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');
  final seuil = tomate.effectiveWateringDays;

  WateringAlert alerte({
    required int joursSansPluie,
    int? joursDepuisArrosage,
    double pluiePrevue = 0,
  }) =>
      WateringAlert(
        vegetable: tomate,
        dryDays: joursSansPluie,
        threshold: seuil,
        rainForecast: pluiePrevue,
        daysSinceWatering: joursDepuisArrosage,
      );

  group('jours sans eau', () {
    test('sans arrosage enregistré, on retombe sur les jours sans pluie', () {
      expect(alerte(joursSansPluie: 6).daysSinceWater, 6);
    });

    test('un arrosage récent fait foi malgré la sécheresse', () {
      // Le cas qui comptait : 10 jours sans pluie, mais arrosé hier.
      expect(
        alerte(joursSansPluie: 10, joursDepuisArrosage: 1).daysSinceWater,
        1,
      );
    });

    test('une pluie récente fait foi malgré un arrosage ancien', () {
      // Le symétrique : arrosé il y a 12 jours, mais il a plu hier.
      expect(
        alerte(joursSansPluie: 1, joursDepuisArrosage: 12).daysSinceWater,
        1,
      );
    });
  });

  group('déclenchement', () {
    test("un plant arrosé ce matin ne réclame pas d'eau", () {
      final a = alerte(joursSansPluie: seuil + 5, joursDepuisArrosage: 0);
      expect(a.needsWatering, isFalse);
      expect(a.urgency, 0);
      expect(a.message, 'Arrosage OK');
    });

    test("un plant jamais arrosé en pleine sécheresse réclame de l'eau", () {
      final a = alerte(joursSansPluie: seuil + 2);
      expect(a.needsWatering, isTrue);
      expect(a.urgency, 2);
    });

    test('le message parle de jours sans eau, pas de jours sans pluie', () {
      final a = alerte(joursSansPluie: 30, joursDepuisArrosage: seuil);
      expect(a.message, contains('$seuil jours sans eau'));
      expect(a.message, isNot(contains('30')));
    });

    test('de la pluie annoncée tempère l\'urgence sans l\'annuler', () {
      final a = alerte(
        joursSansPluie: seuil + 4,
        pluiePrevue: 8,
      );
      expect(a.needsWatering, isTrue);
      expect(a.rainExpected, isTrue);
      expect(a.urgency, 1);
    });
  });
}
