import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/services/advice_service.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// La fiche conseil n'invente rien : elle assemble ce que l'app sait
/// déjà. Ces tests verrouillent les deux règles qui la rendent juste —
/// le stade observé l'emporte sur la déduction, mais il se périme.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final service = PlantationService.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await PrefsService.instance.load();
    service.load();
  });

  Plantation planteIlYA(int jours, {String id = 'tomate'}) => Plantation(
        id: 'p1',
        vegetableId: id,
        plantedAt: DateTime.now().subtract(Duration(days: jours)),
      );

  group('stade retenu', () {
    test('sans observation, il est déduit de la date', () {
      final jeune = planteIlYA(3);
      expect(AdviceService.phaseOf(jeune, vegetableById('tomate')),
          GrowthPhase.seedling);
    });

    test('un plant mûr est déduit plus avancé qu\'un semis du jour', () {
      // Le stade ne vient plus que de la date : l'écran qui permettait
      // de le corriger était la fiche conseil de l'onglet Photo,
      // retiré le 01/11/2026. Ce test garde au moins la monotonie de
      // la déduction, qui seule reste.
      final tomate = vegetableById('tomate');
      final jeune = AdviceService.phaseOf(planteIlYA(3), tomate);
      final vieux = AdviceService.phaseOf(planteIlYA(120), tomate);
      expect(jeune, GrowthPhase.seedling);
      expect(vieux.index, greaterThan(jeune.index));
    });
  });

  group('contenu de la fiche', () {
    test('elle se construit sans météo', () {
      // Hors ligne ou localisation refusée : la fiche doit sortir
      // quand même, sans sa section arrosage.
      final advice = AdviceService.build(
        plantation: planteIlYA(40),
        vegetable: vegetableById('tomate'),
      );
      expect(advice.sections, isNotEmpty);
      expect(advice.sections.map((s) => s.title), contains('À faire maintenant'));
    });

    test('elle parle des maladies de cette espèce', () {
      final advice = AdviceService.build(
        plantation: planteIlYA(40),
        vegetable: vegetableById('tomate'),
      );
      final surveiller =
          advice.sections.where((s) => s.title == 'À surveiller');
      expect(surveiller, hasLength(1));
      expect(surveiller.first.body, contains('Mildiou'));
    });

    test('aucune section vide', () {
      for (final id in <String>['tomate', 'radis', 'basilic', 'pommier']) {
        final advice = AdviceService.build(
          plantation: planteIlYA(30, id: id),
          vegetable: vegetableById(id),
        );
        for (final s in advice.sections) {
          expect(s.title.trim(), isNotEmpty, reason: id);
          expect(s.body.trim(), isNotEmpty, reason: '$id / ${s.title}');
        }
      }
    });

    test('chaque stade a un conseil, pour toutes les familles', () {
      for (final veg in vegetablesBase.take(40)) {
        for (final phase in GrowthPhase.values) {
          expect(AdviceService.phaseAdvice(veg, phase).trim(), isNotEmpty,
              reason: '${veg.id} / ${phase.name}');
        }
      }
    });
  });

}
