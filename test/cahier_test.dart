import 'package:kultiva/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/garden_plan.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/screens/home/cahier/cahier_today_card.dart';
import 'package:kultiva/screens/home/mes_jardins_screen.dart';
import 'package:kultiva/screens/root_tabs.dart';
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
    bool sombre = false,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = taille;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      theme: sombre ? AppTheme.dark : AppTheme.light,
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

  /// Descend jusqu'au bas du cahier, par petits pas.
  ///
  /// `scrollUntilVisible` ne convient pas : il s'arrête à un widget
  /// nommé, et on veut simplement que la fin de la liste soit
  /// construite.
  Future<void> descendre(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.drag(find.byType(ListView).first, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{
        // ⚠️ `load()` relit les préférences et écraserait une
        // langue posée dans `setUpAll`. Elle se sème donc ici.
        'flutter.kultiva.language': 'fr',
      });
    await PrefsService.instance.load();
    // `load()` relit les préférences et remet la langue à null ;
    // on la repose après, sinon l'environnement de test (en-US)
    // fait lire « Tomato » là où le test attend « Tomate ».
    PrefsService.instance.language.value = 'fr';
    // Sinon le sheet de bienvenue s'ouvre par-dessus l'écran testé.
    await PrefsService.instance.setJardinsTutorialDone(true);
    await GardenPlanService.instance.resetForTesting();
    PlantationService.instance.load();
    // La pile du jour se souvient de ce qu'on y a réglé, dans des
    // ensembles statiques voulus. Sans ce ménage, un test qui glisse
    // un post-it vide la pile du test suivant.
    CahierTodayCard.resetForTesting();
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

    // ⚠️ `RootTabs` empile ses cinq pages dans un `IndexedStack`, qui
    // les construit **toutes** au premier affichage. `initState` du
    // cahier n'est donc pas « quand on ouvre l'onglet » : la
    // présentation s'ouvrait par-dessus le tableau de bord, juste
    // après l'onboarding, pour un onglet où personne n'était allé.
    testWidgets('la présentation attend qu\'on ouvre vraiment le cahier',
        (tester) async {
      await PrefsService.instance.setJardinsTutorialDone(false);
      RootTabs.tabIndex.value = 0;
      addTearDown(() => RootTabs.tabIndex.value = 0);

      // ⚠️ Pas de `pumpAndSettle` : le bandeau de saison fait tomber
      // des pétales en boucle, donc l'arbre ne se stabilise jamais.
      await monte(tester, taille: const Size(393, 852));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Bienvenue dans Mes jardins'), findsNothing,
          reason: 'on est sur le tableau de bord, pas sur le cahier');

      RootTabs.tabIndex.value = 1;
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Bienvenue dans Mes jardins'), findsOneWidget);
    });

    testWidgets('ne montre pas « à faire » sans un seul plant', (tester) async {
      // Une carte de tâches vide sur un jardin inexistant, c'est du
      // bruit : l'écran doit d'abord dire comment commencer.
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('Ma pile du jour'), findsNothing);
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
      await descendre(tester);
      expect(
        labels(tester).any((l) =>
            l.contains('Carré nord') && l.contains('3 cases occupées sur 12')),
        isTrue,
      );
    });

    testWidgets('liste les plants en terre avec leur âge', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      expect(find.text('Mes plants, étape par étape  ·  1'), findsOneWidget);
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
      expect(find.text('Ma pile du jour'), findsOneWidget);
    });

    // ⚠️ Le point qui casse : un `Dismissible` glissé doit quitter
    // l'arbre **dans la même image**, sinon Flutter lève « A dismissed
    // Dismissible widget is still part of the tree ». C'est pour ça
    // que `_regler` est synchrone, et c'est une propriété qu'on ne
    // voit ni à `analyze` ni à la lecture : il faut glisser.
    testWidgets('un post-it glissé à droite quitte la pile sans erreur',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      final pile = find.byType(Dismissible);
      expect(pile, findsOneWidget,
          reason: 'la laitue de 50 jours donne au moins une tâche');
      final avant = tester.widget<Dismissible>(pile).key;

      await tester.fling(pile, const Offset(400, 0), 1200);
      // ⚠️ Pas de `pumpAndSettle` ici : les pétales du bandeau de
      // saison tournent en boucle, il expirerait toujours. On laisse
      // passer le temps du glissement, pas celui de l'écran.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.takeException(), isNull);
      // La pile peut porter plusieurs tâches : ce qui compte n'est pas
      // qu'elle soit vide, c'est que **celle-là** soit partie.
      final restant = find.byType(Dismissible);
      if (restant.evaluate().isNotEmpty) {
        expect(tester.widget<Dismissible>(restant).key, isNot(avant),
            reason: 'la tâche réglée a cédé la place à la suivante');
      }
    });

    testWidgets('un post-it remis à demain part aussi proprement',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      await tester.fling(
          find.byType(Dismissible), const Offset(-400, 0), 1200);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('le journal s\'ouvre en éventail de trois post-it',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      // ⚠️ Le cahier est une `ListView` : ce qui est sous la ligne de
      // flottaison n'est pas construit. Il faut descendre pour que le
      // journal existe, sinon le test dit « absent » d'un widget qui
      // n'a simplement pas encore été demandé.
      await descendre(tester);
      expect(find.text('Journal'), findsOneWidget);
      expect(find.text('Tout le journal'), findsOneWidget);
      // Quatre plants posés il y a 50 jours : au moins trois gestes.
      expect(
        labels(tester).where((l) => l.contains('·') && l.contains('Planté')),
        isNotEmpty,
        reason: 'chaque papier annonce son jour et son geste',
      );
    });

    // Les deux réglages qui cassent une boîte figée : un texte plus
    // grand, et un fond qui change. L'éventail et les post-it de
    // jardin sont dessinés à la main, donc ni l'un ni l'autre n'est
    // garanti par le thème.
    for (final cas in <(String, double, bool)>[
      ('police 1,3', 1.3, false),
      ('thème sombre', 1.0, true),
      ('police 1,3 en sombre', 1.3, true),
    ]) {
      testWidgets('le cahier entier tient — ${cas.$1}', (tester) async {
        await monte(tester,
            taille: const Size(393, 852), police: cas.$2, sombre: cas.$3);
        await descendre(tester);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('les jardins sont des post-it qui disent leurs cases',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      await descendre(tester);
      expect(find.text('Mes jardins'), findsOneWidget);
      expect(find.text('3 / 12 cases'), findsOneWidget);
      expect(find.text('Carré nord'), findsOneWidget);
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
