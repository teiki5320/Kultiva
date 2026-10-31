import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/garden_plan.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/screens/home/mes_jardins_screen.dart';
import 'package:kultiva/services/culture_service.dart';
import 'package:kultiva/services/garden_plan_service.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/utils/phenology.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Le cahier de culture est devenu le deuxième onglet le 30/10/2026,
/// puis a été repris le 31 : bandeau de saison, « à faire
/// aujourd'hui », aperçu de chaque grille, et la liste des plants en
/// terre — qui n'étaient atteignables qu'en tapotant une case.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  List<String> labels(WidgetTester tester) => tester
      .widgetList<Semantics>(find.byType(Semantics))
      .map((s) => s.properties.label)
      .whereType<String>()
      .where((l) => l.isNotEmpty)
      .toList();

  Future<void> monte(
    WidgetTester tester, {
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
        child: const MesJardinsScreen(),
      ),
    ));
    await tester.pump();
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await PrefsService.instance.load();
    // Sinon le sheet de bienvenue s'ouvre par-dessus l'écran testé.
    await PrefsService.instance.setJardinsTutorialDone(true);
    await GardenPlanService.instance.resetForTesting();
    PlantationService.instance.load();
  });

  group('cahier vide', () {
    for (final cas in <(String, Size)>[
      ('petit téléphone', const Size(320, 568)),
      ('téléphone', const Size(393, 852)),
      ('tablette', const Size(834, 1194)),
    ]) {
      testWidgets('se construit sans déborder — ${cas.$1}', (tester) async {
        await monte(tester, taille: cas.$2);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('se construit sans déborder à 1,3 de police', (tester) async {
      await monte(tester, taille: const Size(320, 568), police: 1.3);
      expect(tester.takeException(), isNull);
    });

    testWidgets('invite à créer un premier jardin', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('Aucun jardin pour l\'instant'), findsOneWidget);
      expect(find.text('+ Nouveau jardin'), findsOneWidget);
    });

    testWidgets('ne montre pas « à faire » sans un seul plant',
        (tester) async {
      // Une carte de tâches vide sur un jardin inexistant, c'est du
      // bruit : l'écran doit d'abord dire comment commencer.
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('À faire aujourd\'hui'), findsNothing);
    });
  });

  group('cahier rempli', () {
    setUp(() async {
      final plan = await GardenPlanService.instance.create(
        name: 'Carré nord',
        cols: 4,
        rows: 3,
      );
      var garni = plan;
      for (final p in const <(int, int, String)>[
        (0, 0, 'tomate'),
        (1, 0, 'basilic'),
        (2, 2, 'radis'),
      ]) {
        garni = garni.withCell(
          p.$1,
          p.$2,
          PlannedCell(
            col: p.$1,
            row: p.$2,
            vegetableId: p.$3,
            count: 1,
            plantedAt: DateTime.now().subtract(const Duration(days: 50)),
          ),
        );
      }
      await GardenPlanService.instance.save(garni);
      await PlantationService.instance.add(
        'laitue',
        plantedAt: DateTime.now().subtract(const Duration(days: 50)),
      );
    });

    for (final cas in <(String, Size)>[
      ('petit téléphone', const Size(320, 568)),
      ('tablette', const Size(834, 1194)),
    ]) {
      testWidgets('se construit sans déborder — ${cas.$1}', (tester) async {
        await monte(tester, taille: cas.$2);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('annonce le remplissage de chaque jardin', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      expect(
        labels(tester).any((l) =>
            l.contains('Carré nord') && l.contains('3 cases occupées sur 12')),
        isTrue,
      );
    });

    testWidgets('liste les plants en terre avec leur âge', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('Au jardin en ce moment  ·  1'), findsOneWidget);
      expect(
        labels(tester).any((l) =>
            l.startsWith('Laitue,') &&
            l.contains('planté il y a 50 j') &&
            l.contains('jamais arrosé')),
        isTrue,
        reason: 'le lecteur d\'écran doit entendre l\'âge et la soif',
      );
    });

    testWidgets('montre la carte des tâches dès qu\'un plant existe',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('À faire aujourd\'hui'), findsOneWidget);
    });

    testWidgets('pas de récap de saison sans culture cette année',
        (tester) async {
      // `PdfService.printSeasonRecap` faisait 170 lignes et n'était
      // appelée de nulle part. Branchée le 31/10/2026, mais un récap
      // de saison vide n'apprend rien.
      await monte(tester, taille: const Size(393, 852));
      final annee = DateTime.now().year;
      expect(find.text('Récap de la saison $annee'), findsNothing);
    });

    testWidgets('propose le récap dès qu\'une culture a démarré',
        (tester) async {
      final annee = DateTime.now().year;
      await CultureService.instance.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now().subtract(const Duration(days: 30)),
      );
      await monte(tester, taille: const Size(393, 852));
      await tester.scrollUntilVisible(
        find.text('Récap de la saison $annee'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Récap de la saison $annee'), findsOneWidget);
    });
  });

  group('phénologie', () {
    test('la fenêtre de récolte est un booléen, pas un libellé', () {
      final laitue = expectedStage(
        // Une feuille : récolte à partir de 35 jours.
        _legume('laitue'),
        50,
      );
      expect(laitue?.harvestReady, isTrue);
      expect(expectedStage(_legume('laitue'), 5)?.harvestReady, isFalse);
    });
  });
}

Vegetable _legume(String id) => vegetablesBase.firstWhere((v) => v.id == id);
