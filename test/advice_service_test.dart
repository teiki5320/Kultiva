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

    test('une observation fraîche l\'emporte sur la déduction', () {
      // Le point de toute la fiche : un plant semé il y a trois jours
      // ne fleurit pas, mais si l'utilisateur dit qu'il fleurit, c'est
      // lui qui a le plant sous les yeux.
      final p = planteIlYA(3).copyWith(
        observedPhase: GrowthPhase.flowering,
        observedPhaseAt: DateTime.now(),
      );
      expect(AdviceService.phaseOf(p, vegetableById('tomate')),
          GrowthPhase.flowering);
    });

    test('une observation périmée rend la main à la déduction', () {
      // Un plant pousse. « Il fleurit », dit il y a deux mois, en sait
      // moins que le calendrier d'aujourd'hui.
      final p = planteIlYA(120).copyWith(
        observedPhase: GrowthPhase.seedling,
        observedPhaseAt: DateTime.now()
            .subtract(const Duration(days: AdviceService.observationValidDays + 1)),
      );
      expect(AdviceService.phaseOf(p, vegetableById('tomate')),
          isNot(GrowthPhase.seedling));
    });

    test('une observation du jour est marquée comme observée', () async {
      final p = await service.add('tomate');
      await service.setObservedPhase(p.id, GrowthPhase.fruiting);
      final advice = AdviceService.build(
        plantation: service.byId(p.id)!,
        vegetable: vegetableById('tomate'),
      );
      expect(advice.phase, GrowthPhase.fruiting);
      expect(advice.phaseObserved, isTrue);
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

  test('le stade observé survit à la sérialisation', () {
    final p = planteIlYA(10).copyWith(
      observedPhase: GrowthPhase.flowering,
      observedPhaseAt: DateTime(2026, 11, 1, 9),
    );
    final relu = Plantation.fromJson(p.toJson());
    expect(relu.observedPhase, GrowthPhase.flowering);
    expect(relu.observedPhaseAt, DateTime(2026, 11, 1, 9));
  });

  test('à la fusion, l\'observation la plus récente gagne', () {
    final vieille = planteIlYA(30).copyWith(
      observedPhase: GrowthPhase.seedling,
      observedPhaseAt: DateTime(2026, 9, 1),
    );
    final recente = planteIlYA(30).copyWith(
      observedPhase: GrowthPhase.fruiting,
      observedPhaseAt: DateTime(2026, 10, 25),
    );
    expect(Plantation.merge(vieille, recente).observedPhase,
        GrowthPhase.fruiting);
    expect(Plantation.merge(recente, vieille).observedPhase,
        GrowthPhase.fruiting);
  });
}
