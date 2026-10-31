import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/screens/home/garden_planner/planner_advice.dart';
import 'package:kultiva/services/culture_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/utils/rotation_advisor.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// L'avertissement de rotation était promis par la fiche App Store, la
/// landing et CLAUDE.md, et `rotation_advisor.dart` n'était importé par
/// aucun fichier : la fonction existait, personne ne l'appelait.
/// Branchée le 31/10/2026 sur la fiche d'une case du potager carré.
CultureEntry _culture(String vegetableId, {required int ansAvant}) {
  final debut = DateTime(DateTime.now().year - ansAvant, 5, 1);
  return CultureEntry(
    id: '$vegetableId-$ansAvant',
    vegetableId: vegetableId,
    startedAt: debut,
    endedAt: debut.add(const Duration(days: 120)),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('checkRotation', () {
    test('le même légume l\'an dernier déclenche l\'alerte', () {
      final w = checkRotation(
        vegetableId: 'tomate',
        previousCultures: <CultureEntry>[_culture('tomate', ansAvant: 1)],
      );
      expect(w, isNotNull);
      expect(w!.kind, RotationWarningKind.sameVegetable);
    });

    test('un légume de la même famille aussi', () {
      // Aubergine et tomate sont deux solanacées.
      final w = checkRotation(
        vegetableId: 'tomate',
        previousCultures: <CultureEntry>[_culture('aubergine', ansAvant: 1)],
      );
      expect(w, isNotNull);
      expect(w!.kind, RotationWarningKind.sameFamily);
    });

    test('le message nomme le légume, pas son identifiant', () {
      final w = checkRotation(
        vegetableId: 'tomate',
        previousCultures: <CultureEntry>[
          _culture('pomme_de_terre', ansAvant: 1)
        ],
      );
      // Le message affichait « (pomme_de_terre) » à l'utilisateur.
      expect(w?.message ?? '', isNot(contains('_')));
    });

    test('rien à signaler après le délai d\'attente', () {
      final w = checkRotation(
        vegetableId: 'tomate',
        previousCultures: <CultureEntry>[_culture('tomate', ansAvant: 9)],
      );
      expect(w, isNull);
    });

    test('un jardin vierge ne dit rien', () {
      expect(
        checkRotation(vegetableId: 'tomate', previousCultures: const []),
        isNull,
      );
    });
  });

  group('PlannerRotationWarning', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await PrefsService.instance.load();
    });

    Future<void> monte(WidgetTester tester, Widget child) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(body: child),
      ));
      await tester.pump();
    }

    testWidgets('silencieux quand il n\'y a rien à dire', (tester) async {
      await monte(tester, const PlannerRotationWarning(vegetableId: 'tomate'));
      expect(find.text('Attention à la rotation'), findsNothing);
    });

    testWidgets('alerte sur une culture close de la même famille',
        (tester) async {
      await PrefsService.instance.setCulturesJson(
        CultureEntry.encodeAll(<CultureEntry>[_culture('aubergine',
            ansAvant: 1)]),
      );
      await monte(tester, const PlannerRotationWarning(vegetableId: 'tomate'));
      expect(find.text('Attention à la rotation'), findsOneWidget);
    });

    testWidgets('une culture encore en cours ne compte pas', (tester) async {
      // Trois pieds de tomate plantés le même jour se seraient
      // signalés les uns les autres, et un plant se serait signalé
      // lui-même : la rotation parle de ce qui a occupé la terre
      // avant, pas de ce qui y pousse.
      final enCours = CultureEntry(
        id: 'en-cours',
        vegetableId: 'tomate',
        startedAt: DateTime.now().subtract(const Duration(days: 10)),
      );
      await PrefsService.instance
          .setCulturesJson(CultureEntry.encodeAll(<CultureEntry>[enCours]));
      expect(CultureService.instance.ended(), isEmpty);
      await monte(tester, const PlannerRotationWarning(vegetableId: 'tomate'));
      expect(find.text('Attention à la rotation'), findsNothing);
    });

    testWidgets('une case n\'alerte pas sur sa propre culture',
        (tester) async {
      await PrefsService.instance.setCulturesJson(
        CultureEntry.encodeAll(<CultureEntry>[_culture('tomate', ansAvant: 1)]),
      );
      await monte(
        tester,
        const PlannerRotationWarning(
          vegetableId: 'tomate',
          currentCultureId: 'tomate-1',
        ),
      );
      expect(find.text('Attention à la rotation'), findsNothing);
    });
  });
}
