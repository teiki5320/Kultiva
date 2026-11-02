import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/widgets/petal_animation.dart';

/// Tout ce qui est climatique lit la **zone**, plus la région.
///
/// La région lisait le climat jusqu'au 02/11/2026. Depuis l'ouverture
/// mondiale elle ne dit plus que le contenu — ouest-africain ou non —
/// et s'en servir pour une question de climat donnait deux réponses
/// contradictoires dans la même app : le calendrier disait mousson,
/// les saisons disaient hiver.
void main() {
  group('les saisons suivent la zone', () {
    test('Darwin a des saisons tropicales, bien qu\'en région tempérée', () {
      // Australie : `Region.france`, donc base tempérée — mais au nord
      // de 24° S la zone est soudanienne.
      final z = Country.australie.zoneAt(-12.5);
      expect(Country.australie.region.isTropicalBase, isFalse);
      final s = Season.of(1, Country.australie.region,
          zone: z, hemisphere: Hemisphere.south);
      expect(s, isIn(<Season>[
        Season.rainySeason,
        Season.drySeason,
        Season.harmattan,
      ]));
    });

    test('São Paulo a des saisons thermiques, bien qu\'en région tropicale',
        () {
      final z = Country.bresil.zoneAt(-23.5);
      expect(Country.bresil.region.isTropicalBase, isTrue);
      final s = Season.of(1, Country.bresil.region,
          zone: z, hemisphere: Hemisphere.south);
      // Janvier au sud = juillet au nord = été austral.
      expect(s, Season.summer);
    });

    test('Delhi a une saison fraîche, et c\'est la seule des tropiques', () {
      for (final mois in <int>[11, 12, 1, 2]) {
        expect(Season.of(mois, Country.inde.region, zone: Country.inde.zone),
            Season.coolDry,
            reason: 'mois $mois');
      }
      for (final mois in <int>[6, 7, 8, 9]) {
        expect(Season.of(mois, Country.inde.region, zone: Country.inde.zone),
            Season.rainySeason,
            reason: 'mois $mois');
      }
    });

    test('la saison fraîche ne fait pas tomber de flocons', () {
      // Elle ne pouvait être ni `harmattan` (un vent sahélien, que
      // personne ne connaît à Delhi) ni `winter` (dont les particules
      // sont des flocons, et il ne neige pas à Hanoï).
      expect(Season.coolDry.particles, isNot(contains('❄️')));
      expect(Season.coolDry.label, isNot(contains('Harmattan')));
    });

    test('sans zone, la région sert encore de repli', () {
      expect(Season.of(7, Region.france), Season.summer);
      expect(Season.of(7, Region.westAfrica), Season.rainySeason);
    });
  });

  group('Country.isTropical', () {
    test('suit la zone déclarée, pas la région', () {
      // Nouvelle-Calédonie et Égypte ont changé de base le 02/11.
      expect(Country.nouvelleCaledonie.isTropical, isTrue);
      expect(Country.egypte.isTropical, isFalse);
      for (final c in Country.values) {
        expect(c.isTropical, c.zone.isTropical, reason: c.label);
      }
    });
  });
}
