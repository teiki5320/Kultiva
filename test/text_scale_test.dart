import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/screens/home/garden_planner/planner_plants.dart';
import 'package:kultiva/screens/home/my_garden/garden_header.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_badges.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_journal.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_podium.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_stats.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/widgets/petal_animation.dart';
import 'package:kultiva/widgets/season_header.dart';

/// Les écrans de Kultiva sont posés dans des boîtes à hauteur fixe.
/// Tant que le texte garde sa taille par défaut, tout tient. Dès que
/// l'utilisateur agrandit la police dans les réglages de son
/// téléphone — ce que fait toute personne qui voit mal — le contenu
/// déborde de la boîte, et Flutter peint la bande jaune et noire.
///
/// Ces tests montent les mêmes widgets deux fois : à la taille
/// normale, puis au plafond de 1,3 que l'app s'impose, sur l'écran le
/// plus petit qu'elle vise (un iPhone SE de première génération).
/// Flutter lève sur un débordement de mise en page, et
/// `takeException` le récupère.
///
/// ⚠️ Un test voit qu'une boîte ne déborde pas. Il ne voit pas qu'elle
/// est devenue laide. Rien ne remplace un coup d'œil, police agrandie,
/// sur un vrai téléphone.
void main() {
  final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');

  // iPhone SE 1re génération, en points : le plus petit écran visé.
  const petitEcran = Size(320, 568);

  final plants = <Plantation>[
    Plantation(
      id: 'p1',
      vegetableId: 'tomate',
      plantedAt: DateTime.now().subtract(const Duration(days: 40)),
      wateredAt: <DateTime>[
        DateTime.now().subtract(const Duration(days: 2)),
        DateTime.now(),
      ],
      harvestCount: 3,
    ),
    Plantation(
      id: 'p2',
      vegetableId: 'courgette',
      plantedAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
  ];

  Future<void> monte(
    WidgetTester tester,
    Widget child, {
    required double police,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = petitEcran;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: MediaQuery(
          data: MediaQueryData(
            size: petitEcran,
            textScaler: TextScaler.linear(police),
          ),
          child: Scaffold(body: child),
        ),
      ),
    );
    await tester.pump();
  }

  final cas = <String, Widget>{
    'en-tête du Poussidex': const GardenHeader(
      plantationsCount: 2,
      speciesCount: 2,
      totalSpecies: 130,
      unlockedCount: 7,
      totalBadges: 50,
    ),
    'barre de filtres': GardenFilterBar(
      filter: AlbumFilter.collection,
      plantsCount: 2,
      challengesCount: 5,
      totalChallenges: 50,
      badgesCount: 7,
      totalBadges: 50,
      onChanged: (_) {},
    ),
    'statistiques': PoussidexStatsView(plantations: plants),
    'statistiques sans plant': const PoussidexStatsView(
      plantations: <Plantation>[],
    ),
    'podium': PoussidexPodiumView(plantations: plants),
    'journal': PoussidexJournalView(plantations: plants),
    'grille des badges': PoussidexBadgesGrid(
      unlocked: <String>{allBadges.first.id},
    ),
    // Le planificateur pose cette carte dans une boîte de 78 au
    // moment du glisser : c'est le cas le plus serré.
    'carte de plant du planificateur': Center(
      child: SizedBox(
        width: 78,
        height: 78,
        child: PlannerPlantCard(plant: tomate),
      ),
    ),
    'feuille de conseils': const PlannerTipsSheet(),
    'bandeau de saison': const SeasonHeader(season: Season.spring, month: 4),
  };

  for (final entry in cas.entries) {
    testWidgets('${entry.key} tient à police normale', (tester) async {
      await monte(tester, entry.value, police: 1.0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('${entry.key} tient à police 1,3', (tester) async {
      await monte(tester, entry.value, police: 1.3);
      expect(tester.takeException(), isNull);
    });
  }
}
