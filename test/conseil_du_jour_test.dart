import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/west_africa.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/utils/conseil_du_jour.dart';

/// Le conseil du jour ne parle que de cultures qui poussent ici.
///
/// ⚠️ Le défaut qu'il attrape, vu à l'écran le 03/11/2026 sur une
/// installation française : « 🍌 Bananier plantain adore pousser à côté
/// de 🟤 Taro ! ». Les trois sources du conseil — compagnonnage,
/// rotation, maladies — couvrent les 130 cultures, et rien ne demandait
/// si celle du jour se cultive sous le calendrier de l'utilisateur.
///
/// ⚠️ Il est arrivé **une heure après** la même correction sur le
/// légume du jour, et sur le même écran. La leçon tient en une ligne :
/// une règle écrite dans une fonction se corrige une fois, une règle
/// nommée se corrige partout. D'où `cultivablesEnPleineTerre()`.
void main() {
  for (final cas in <List<Object>>[
    <Object>['France', franceData],
    <Object>['Afrique de l\'Ouest', westAfricaData],
  ]) {
    final nom = cas[0] as String;
    final calendrier = cas[1] as List<RegionData>;

    group('$nom', () {
      test('aucun conseil ne cite une culture qui ne pousse pas ici', () {
        final ici = cultivablesEnPleineTerre(calendrier);
        final citees = culturesCiteesParLesConseils(calendrier);
        final intrus = citees.difference(ici).toList()..sort();
        expect(intrus, isEmpty,
            reason: 'Cultures citées sans pousser en $nom : $intrus');
      });

      test('il reste de quoi conseiller tous les jours de l\'année', () {
        // Filtrer ne doit pas vider la liste : un conseil répété
        // quatre fois par semaine ne serait plus un conseil du jour.
        expect(conseilsPossibles(calendrier).length, greaterThan(120),
            reason: 'Trop peu de conseils en $nom : la liste tournerait '
                'plus vite que l\'année.');
      });

      test('le même jour donne toujours le même conseil', () {
        expect(conseilDuJour(DateTime(2026, 6, 14, 8), calendrier),
            conseilDuJour(DateTime(2026, 6, 14, 23), calendrier));
      });
    });
  }

  test('le compagnonnage exige que les deux poussent ici', () {
    // Le piège du 03/11 : le bananier plantain et le taro poussent
    // tous deux en Afrique de l'Ouest, aucun des deux en France. Un
    // filtre posé sur la seule culture de gauche aurait laissé passer
    // « tomate adore pousser à côté de taro ».
    final enFrance = cultivablesEnPleineTerre(franceData);
    expect(enFrance.contains('bananier_plantain'), isFalse);
    expect(enFrance.contains('taro'), isFalse,
        reason: 'le taro est marqué sous serre en France');

    final conseils = conseilsPossibles(franceData);
    for (final interdit in <String>['Bananier plantain', 'Taro', 'Manioc']) {
      expect(conseils.where((c) => c.contains(interdit)), isEmpty,
          reason: '« $interdit » apparaît dans un conseil français.');
    }
  });

  test('changer de calendrier change les conseils', () {
    // Sans ça, un calendrier ignoré passerait les groupes ci-dessus,
    // puisque chacun ne vérifie que le sien.
    final fr = conseilsPossibles(franceData).toSet();
    final ao = conseilsPossibles(westAfricaData).toSet();
    expect(fr.difference(ao), isNotEmpty);
    expect(ao.difference(fr), isNotEmpty);
  });

  test('un calendrier vide ne fait pas planter l\'accueil', () {
    expect(() => conseilDuJour(DateTime(2026, 6, 14), <RegionData>[]),
        returnsNormally);
  });
}
