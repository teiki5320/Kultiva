import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/country.dart';
import 'package:kultiva/models/region_data.dart';

/// Le lien partenaire pointe sur amazon.fr avec un tag français. Il
/// était conditionné à `Region.france`, qui veut dire « base tempérée »
/// depuis l'ouverture mondiale du 01/11/2026 : trente-six pays, dont le
/// Japon et le Chili, recevaient le bouton. Les quatre fiches du dépôt
/// annonçaient « France seulement ».
void main() {
  test('la France voit le lien', () {
    expect(amazonLinkVisible(Region.france, Country.france), isTrue);
  });

  test('aucun autre pays de la base tempérée ne le voit', () {
    for (final pays in Country.values) {
      if (pays == Country.france) continue;
      expect(amazonLinkVisible(pays.region, pays), isFalse, reason: pays.name);
    }
  });

  test('les trente-cinq autres pays tempérés sont bien là', () {
    // Sans ce décompte, le test précédent passerait aussi si la base
    // tempérée ne comptait qu'un pays.
    final temperes = Country.values
        .where((c) => c.region == Region.france && c != Country.france);
    expect(temperes, hasLength(35));
  });

  test('sans pays choisi, Region.france veut encore dire la France', () {
    // Qui n'a jamais passé l'onboarding n'a pas de pays : on ne lui
    // retire pas un bouton qu'il avait.
    expect(amazonLinkVisible(Region.france, null), isTrue);
    expect(amazonLinkVisible(Region.westAfrica, null), isFalse);
    expect(amazonLinkVisible(Region.tropical, null), isFalse);
  });
}
