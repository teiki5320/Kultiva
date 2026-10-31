import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/screens/home/calendar_grid_screen.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/utils/months.dart';
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
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await PrefsService.instance.load();
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

    testWidgets('ne défile plus latéralement', (tester) async {
      await monte(tester, taille: const Size(393, 852));
      final horizontaux = tester
          .widgetList<Scrollable>(find.byType(Scrollable))
          .where((s) => s.axisDirection == AxisDirection.right)
          .toList();
      expect(horizontaux, isEmpty,
          reason: 'les douze mois doivent tenir dans la largeur');
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
