import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/accessory_guide.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Les 39 fiches d'accessoires ne portaient qu'un nom, un emoji, une
/// ligne de note et deux phrases de description : ni calendrier, ni
/// maladies, ni recettes. C'étaient les plus vides de l'app, remarque
/// de Jean le 02/11/2026.
void main() {
  final accessoires = vegetablesBase
      .where((v) => v.category == VegetableCategory.accessories)
      .toList();

  test('chaque accessoire du catalogue a son mode d\'emploi', () {
    for (final a in accessoires) {
      expect(accessoryGuides.containsKey(a.id), isTrue,
          reason: '${a.id} (${a.name}) n\'a pas de mode d\'emploi : '
              'une fiche vide, c\'est ce qu\'on vient de corriger.');
    }
  });

  test('aucun mode d\'emploi n\'est orphelin', () {
    final ids = accessoires.map((v) => v.id).toSet();
    for (final cle in accessoryGuides.keys) {
      expect(ids.contains(cle), isTrue,
          reason: '« $cle » n\'est pas un accessoire du catalogue : '
              'faute de frappe, ou accessoire retiré depuis ?');
    }
  });

  test('aucun champ n\'est vide, ni trop court pour servir', () {
    accessoryGuides.forEach((id, g) {
      for (final paire in <List<String>>[
        <String>['when', g.when],
        <String>['how', g.how],
        <String>['howMuch', g.howMuch],
        <String>['care', g.care],
        if (g.diy != null) <String>['diy', g.diy!],
      ]) {
        expect(paire[1].trim(), isNotEmpty, reason: '$id / ${paire[0]}');
        // Une phrase de cinq mots ne dit pas un geste. Le seuil est
        // bas exprès : il attrape le remplissage, pas le style.
        expect(paire[1].trim().length, greaterThan(25),
            reason: '$id / ${paire[0]} : « ${paire[1]} »');
      }
    });
  });

  test('aucun gras Markdown : LexiconText ne le rend pas', () {
    // Les astérisques s'afficheraient en clair dans la fiche. Trouvé
    // en relisant, après les avoir écrites.
    accessoryGuides.forEach((id, g) {
      for (final t in <String>[g.when, g.how, g.howMuch, g.care, g.diy ?? '']) {
        expect(t, isNot(contains('**')), reason: id);
      }
    });
  });

  test('un accessoire sur deux au moins propose une version maison', () {
    // Ce n'est pas du remplissage : une app qui ne sait que renvoyer
    // vers Amazon ne tient pas sa promesse de potager débrouillard.
    // Et on ne forge pas un sécateur, d'où le champ nullable.
    final avec = accessoryGuides.values.where((g) => g.diy != null).length;
    expect(avec, greaterThanOrEqualTo(accessoryGuides.length ~/ 2),
        reason: '$avec sur ${accessoryGuides.length}');
  });

  test('le mode d\'emploi ne concerne que les accessoires', () {
    for (final v in vegetablesBase) {
      if (v.category == VegetableCategory.accessories) continue;
      expect(accessoryGuideFor(v.id), isNull, reason: v.id);
    }
  });
}
