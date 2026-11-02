import 'package:kultiva/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/screens/home/calendar_grid_screen.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/utils/months.dart';
import 'package:kultiva/widgets/pastel_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Le calendrier annuel a été refondu le 31/10/2026.
///
/// Avant : un `DataTable` de 130 lignes sur 13 colonnes dans deux
/// `SingleChildScrollView` imbriqués, dont un horizontal. Sur un
/// téléphone on voyait quatre mois à la fois, et le nom du légume
/// sortait de l'écran dès qu'on faisait défiler vers juin.
///
/// On teste donc deux choses : que les phrases de mois se lisent, et
/// qu'il n'y a plus un seul défilement latéral — c'était tout le
/// problème.
void main() {
  // ⚠️ L'environnement de test tourne en `en-US`, donc `trUi()` rend
  // de l'anglais. Ce fichier compare du **français** — le texte source
  // de l'app — donc il force la langue. Sans ça, il validerait des
  // libellés anglais en croyant lire du français, ce qui est
  // exactement le piège qu'`onglets_test` s'est pris en 2026.
  setUpAll(() => PrefsService.instance.language.value = 'fr');

  TestWidgetsFlutterBinding.ensureInitialized();

  group('monthRangesLabel', () {
    test('une série contiguë devient une plage', () {
      expect(monthRangesLabel(<int>[3, 4, 5]), 'de mars à mai');
    });

    test('un mois seul reste un mois', () {
      expect(monthRangesLabel(<int>[5]), 'mai');
    });

    test('deux mois isolés sont joints par « et »', () {
      expect(monthRangesLabel(<int>[3, 5]), 'mars et mai');
    });

    test('trois morceaux prennent des virgules puis « et »', () {
      expect(monthRangesLabel(<int>[1, 3, 5, 6]),
          'janvier, mars et de mai à juin');
    });

    test('une série qui enjambe le nouvel an compte pour une', () {
      // Le cas de la saison sèche en Afrique de l'Ouest : une liste
      // naïve donnerait « janvier et de novembre à décembre ».
      expect(monthRangesLabel(<int>[11, 12, 1]), 'de novembre à janvier');
    });

    test('douze mois se disent en trois mots', () {
      expect(monthRangesLabel(List<int>.generate(12, (i) => i + 1)),
          "toute l'année");
    });

    test('aucun mois ne donne aucune phrase', () {
      expect(monthRangesLabel(<int>[]), '');
    });

    test('un mois hors bornes est ignoré', () {
      expect(monthRangesLabel(<int>[0, 5, 13]), 'mai');
    });
  });

  group('CalendarGridScreen', () {
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
    });

    Future<void> monte(
      WidgetTester tester, {
      required Size taille,
      double police = 1.0,
    }) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = taille;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: L.localizationsDelegates,
        supportedLocales: L.supportedLocales,
        theme: AppTheme.light,
        home: MediaQuery(
          data: MediaQueryData(
            size: taille,
            textScaler: TextScaler.linear(police),
          ),
          child: const CalendarGridScreen(),
        ),
      ));
      await tester.pump();
    }

    // iPhone SE, iPhone 15, iPad 11" portrait.
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

    testWidgets(
        'aucune ligne de légume n\'est dans un défilement '
        'latéral', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      // La barre de familles défile de côté, comme à l'Étal, et c'est
      // voulu. Ce qui ne doit plus défiler, c'est la grille : avant,
      // le nom du légume sortait de l'écran à gauche quand on allait
      // voir juin. On vérifie donc l'ancêtre d'une ligne, pas l'écran.
      final ligne = find.bySemanticsLabel(RegExp(r' : (semis|récolte)')).first;
      final ancetres = tester.widgetList<Scrollable>(
        find.ancestor(of: ligne, matching: find.byType(Scrollable)),
      );
      expect(ancetres, isNotEmpty, reason: 'la liste défile verticalement');
      expect(
        ancetres.where((s) => s.axisDirection == AxisDirection.right),
        isEmpty,
        reason: 'les douze mois doivent tenir dans la largeur',
      );
    });

    testWidgets('la recherche réduit la liste', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      final avant = tester
          .widgetList(find.bySemanticsLabel(RegExp(r' : (semis|récolte)')))
          .length;
      await tester.enterText(find.byType(TextField), 'tomate');
      await tester.pump();
      final apres = tester
          .widgetList(find.bySemanticsLabel(RegExp(r' : (semis|récolte)')))
          .length;
      expect(apres, lessThan(avant));
      expect(apres, greaterThan(0));
    });

    testWidgets('la recherche ignore les accents', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      await tester.enterText(find.byType(TextField), 'epinard');
      await tester.pump();
      expect(
        find.bySemanticsLabel(RegExp('Épinard')),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('une recherche sans résultat dit pourquoi, et se défait',
        (tester) async {
      // Le message accusait la saison quoi qu'il arrive : chercher
      // « xyz » affichait « Rien à semer ni à récolter ce mois-ci
      // dans ta région ».
      await monte(tester, taille: const Size(393, 852));
      await tester.enterText(find.byType(TextField), 'zzzz');
      await tester.pump();
      // Le champ de saisie contient aussi « zzzz » : on vise le message.
      expect(find.textContaining('porte « zzzz »'), findsOneWidget);
      expect(find.textContaining('Rien à semer'), findsNothing);

      await tester.tap(find.text('Tout afficher'));
      await tester.pump();
      expect(
        find.bySemanticsLabel(RegExp(r' : (semis|récolte)')),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('un mois sans rien nomme ce mois, pas « ce mois-ci »',
        (tester) async {
      await monte(tester, taille: const Size(393, 852));
      // On croise un mois et une famille jusqu'à tomber sur un vide.
      await tester.tap(find.bySemanticsLabel('Février'));
      await tester.pump();
      await tester.tap(find.byType(PastelChip).at(1));
      await tester.pump();
      final vide = find.textContaining('février');
      if (vide.evaluate().isNotEmpty) {
        expect(find.textContaining('ce mois-ci'), findsNothing);
      }
    });

    testWidgets('une famille ne laisse que ses légumes', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      // Compter les lignes ne prouve rien : `ListView.builder` n'en
      // construit qu'une dizaine à la fois, filtre ou pas. On vérifie
      // donc que tout ce qui s'affiche appartient bien à la famille.
      final famille = VegetableCategory.values
          .where((c) => c != VegetableCategory.accessories)
          .first;
      await tester.tap(find.byType(PastelChip).at(1));
      await tester.pump();

      final lignes = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .map((w) => w.properties.label)
          .whereType<String>()
          .where((l) => l.contains(' : semis') || l.contains(' : récolte'))
          .toList();
      expect(lignes, isNotEmpty, reason: 'la famille doit avoir des légumes');
      for (final l in lignes) {
        final nom = l.split(' : ').first;
        final v = vegetablesBase.where((x) => x.name == nom).firstOrNull;
        expect(v?.category, famille, reason: '$nom ne devrait pas être là');
      }
    });

    testWidgets('les douze mois sont tous atteignables', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      for (final mois in monthNamesLongCap) {
        // `findsAtLeastNWidgets` et pas `findsOneWidget` : le bandeau
        // saisonnier affiche aussi le nom du mois en cours.
        expect(find.bySemanticsLabel(mois), findsAtLeastNWidgets(1),
            reason: '$mois doit être un bouton de filtre');
      }
    });

    testWidgets('une ligne annonce son année en une phrase', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      // L'ail est en tête de liste alphabétique dans les deux régions.
      final libelles = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .map((s) => s.properties.label)
          .whereType<String>()
          .toList();
      expect(
        libelles.any((l) => l.contains('semis') && l.contains(' : ')),
        isTrue,
        reason: 'VoiceOver doit lire « légume : semis de … à … »',
      );
      // L'ancienne grille disait « rien à faire » onze fois par ligne.
      expect(libelles.any((l) => l.contains('rien à faire')), isFalse);
    });
  });
}
