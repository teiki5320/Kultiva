import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';

/// `vegetableById` est passé d'un balayage linéaire à un index le
/// 01/11/2026. Ces tests verrouillent le contrat qui existait avant,
/// pour que l'optimisation n'ait rien changé au comportement.
void main() {
  test('chaque légume du catalogue se retrouve par son id', () {
    for (final v in vegetablesBase) {
      expect(vegetableById(v.id).id, v.id, reason: v.id);
    }
  });

  test('un id inconnu rend le légume inconnu, et ne lève pas', () {
    expect(vegetableById('nawak').id, unknownVegetable.id);
    expect(vegetableById('').id, unknownVegetable.id);
  });

  test('le catalogue n\'a pas deux fois le même id', () {
    // L'index le masquerait en silence : le dernier gagnerait.
    final vus = <String>{};
    final doublons = <String>[];
    for (final v in vegetablesBase) {
      if (!vus.add(v.id)) doublons.add(v.id);
    }
    expect(doublons, isEmpty);
  });
}
