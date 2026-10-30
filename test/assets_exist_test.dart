import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Vérifie que chaque image annoncée par le catalogue existe vraiment.
///
/// Un `imageAsset` qui pointe vers un fichier absent ne fait pas échouer
/// la compilation : l'app affiche simplement l'emoji de secours, et on
/// ne s'en aperçoit qu'en parcourant les 130 fiches à la main. C'est
/// précisément le risque de la bascule des PNG vers les WebP kawaii.
void main() {
  group('images du catalogue', () {
    test('chaque imageAsset de légume pointe vers un fichier présent', () {
      final manquants = <String>[];
      for (final v in vegetablesBase) {
        final path = v.imageAsset;
        if (path == null) continue;
        if (!File(path).existsSync()) manquants.add('${v.id} → $path');
      }
      expect(manquants, isEmpty,
          reason: 'Images déclarées mais absentes :\n${manquants.join('\n')}');
    });

    test('toutes les cultures ont une image', () {
      // Les accessoires peuvent s'en passer (emoji), pas les cultures :
      // ce sont elles qu'on voit dans le calendrier et le Poussidex.
      final sans = vegetablesBase
          .where((v) => v.category != VegetableCategory.accessories)
          .where((v) => v.imageAsset == null)
          .map((v) => v.id)
          .toList();
      expect(sans, isEmpty, reason: 'Cultures sans image : $sans');
    });
  });

  group('images des badges', () {
    test('chaque badge a son médaillon', () {
      final manquants = <String>[];
      for (final b in allBadges) {
        final path = 'assets/images/badges/${b.id}.png';
        if (!File(path).existsSync()) manquants.add(b.id);
      }
      expect(manquants, isEmpty, reason: 'Badges sans image : $manquants');
    });
  });
}
