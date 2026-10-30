import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_badges.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_card.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/widgets/petal_animation.dart';
import 'package:kultiva/widgets/season_header.dart';
import 'package:kultiva/widgets/vegetable_card.dart';

/// L'iPad tourne depuis le 30/10/2026 : l'app n'est plus verrouillée en
/// portrait sur tablette. Or son interface n'a jamais été dessinée pour
/// le paysage.
///
/// Faute de runtime iOS installé sur cette machine, on ne peut pas voir
/// le rendu dans un simulateur. On vérifie donc ce qui est vérifiable
/// sans lui : qu'aux dimensions d'un iPad, en portrait comme en
/// paysage, et jusqu'au plafond de police de 1,3, les écrans se
/// construisent sans déborder. Flutter lève sur un débordement, que
/// `takeException` récupère.
///
/// ⚠️ Cela ne remplace pas un coup d'œil sur un vrai iPad : un test ne
/// voit pas qu'une grille de deux colonnes sur 1 366 px de large est
/// laide, seulement qu'elle ne casse pas.
void main() {
  final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');

  // iPad Pro 11" en points.
  const portrait = Size(834, 1194);
  const paysage = Size(1194, 834);

  Future<void> monte(
    WidgetTester tester,
    Widget child, {
    required Size taille,
    double police = 1.0,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = taille;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: taille,
          textScaler: TextScaler.linear(police),
        ),
        child: Scaffold(body: child),
      ),
    ));
    await tester.pump();
  }

  group('iPad', () {
    for (final cas in <(String, Size)>[
      ('portrait', portrait),
      ('paysage', paysage),
    ]) {
      final (nom, taille) = cas;

      testWidgets('le bandeau de saison tient en $nom', (tester) async {
        await monte(
          tester,
          const SeasonHeader(season: Season.spring, month: 4),
          taille: taille,
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('la grille des badges tient en $nom', (tester) async {
        await monte(
          tester,
          PoussidexBadgesGrid(unlocked: <String>{allBadges.first.id}),
          taille: taille,
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('une carte de légume tient en $nom, police à 1,3',
          (tester) async {
        await monte(
          tester,
          Center(
            child:
                SizedBox(width: 200, child: VegetableCard(vegetable: tomate)),
          ),
          taille: taille,
          police: 1.3,
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('une carte de plant tient en $nom, police à 1,3',
          (tester) async {
        await monte(
          tester,
          Center(
            child: SizedBox(
              width: 200,
              child: PlantationCard(
                plantation: Plantation(
                  id: 'p1',
                  vegetableId: 'tomate',
                  plantedAt: DateTime.now().subtract(const Duration(days: 20)),
                  wateredAt: <DateTime>[DateTime.now()],
                ),
                vegetable: tomate,
                tier: MedalTier.bronze,
              ),
            ),
          ),
          taille: taille,
          police: 1.3,
        );
        expect(tester.takeException(), isNull);
      });
    }
  });
}
