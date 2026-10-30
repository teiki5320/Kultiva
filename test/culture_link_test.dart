import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/services/culture_service.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Couvre le rattachement du cahier de culture au dossier du plant.
///
/// Avant, un même plant vivait dans deux registres qui ne se parlaient
/// pas : arroser depuis le potager carré n'apparaissait ni dans les
/// statistiques du Poussidex, ni dans les médailles, ni dans l'alerte
/// d'arrosage — qui lit les plantations.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final cultures = CultureService.instance;
  final plants = PlantationService.instance;
  final prefs = PrefsService.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await prefs.load();
    plants.load();
  });

  group('création', () {
    test('démarrer une culture crée le dossier de plant correspondant',
        () async {
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime(2026, 5, 1),
      );
      expect(c.linkedPlantationId, isNotNull);
      final p = plants.byId(c.linkedPlantationId!);
      expect(p, isNotNull);
      expect(p!.vegetableId, 'tomate');
      expect(p.plantedAt, DateTime(2026, 5, 1));
    });

    test('la culture compte pour les médailles de son espèce', () async {
      // Le décompte par espèce est ce qui débloque bronze/argent/or.
      await cultures.add(vegetableId: 'radis', startedAt: DateTime.now());
      await cultures.add(vegetableId: 'radis', startedAt: DateTime.now());
      expect(plants.countFor('radis'), 2);
    });
  });

  group('arrosage', () {
    test('arroser depuis le cahier écrit dans le dossier du plant',
        () async {
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      await cultures.markWatered(c.id, at: DateTime(2026, 6, 10));

      final p = plants.byId(c.linkedPlantationId!)!;
      expect(p.wateredAt, <DateTime>[DateTime(2026, 6, 10)]);
      // Et la lecture côté cahier voit la même chose.
      expect(cultures.lastWateringFor(cultures.byId(c.id)!),
          DateTime(2026, 6, 10));
    });

    test('arroser depuis le Poussidex est visible depuis le cahier',
        () async {
      // Le sens inverse : c'est ce qui prouve qu'il n'y a plus qu'un
      // seul registre.
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      await plants.water(c.linkedPlantationId!, at: DateTime(2026, 6, 11));
      expect(cultures.lastWateringFor(cultures.byId(c.id)!),
          DateTime(2026, 6, 11));
    });

    test('« arroser tout » enregistre un arrosage par culture', () async {
      final a = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      final b = await cultures.add(
        vegetableId: 'radis',
        startedAt: DateTime.now(),
      );
      final n = await cultures
          .markManyWatered(<String>[a.id, b.id], at: DateTime(2026, 7, 1));
      expect(n, 2);
      expect(plants.byId(a.linkedPlantationId!)!.wateredAt, hasLength(1));
      expect(plants.byId(b.linkedPlantationId!)!.wateredAt, hasLength(1));
    });

    test('arroser une culture inconnue ne crée rien', () async {
      await cultures.markWatered('cul_inexistante');
      expect(plants.all, isEmpty);
    });
  });

  group('cycle de vie', () {
    test('clore la culture clôt le plant, le rouvrir le rouvre', () async {
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      await cultures.endCulture(c.id, at: DateTime(2026, 9, 1));
      expect(plants.byId(c.linkedPlantationId!)!.isActive, isFalse);

      await cultures.reopen(c.id);
      expect(plants.byId(c.linkedPlantationId!)!.isActive, isTrue);
    });

    test('retirer une culture vierge retire le plant', () async {
      // Reposer une case qu'on vient de placer ne doit pas laisser un
      // plant fantôme qui gonflerait les médailles.
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      await cultures.remove(c.id);
      expect(plants.all, isEmpty);
    });

    test('retirer une culture soignée garde le plant dans la collection',
        () async {
      // À l'inverse, un plant arrosé est un vrai souvenir : réorganiser
      // sa grille ne doit pas l'effacer.
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      await cultures.markWatered(c.id);
      await cultures.remove(c.id);
      expect(plants.all, hasLength(1));
      expect(plants.countFor('tomate'), 1);
    });
  });

  group('rattachement des anciennes sauvegardes', () {
    test('une culture sans lien reçoit un plant qui reprend ses arrosages',
        () async {
      final legacy = CultureEntry(
        id: 'cul_legacy',
        vegetableId: 'courgette',
        startedAt: DateTime(2026, 4, 2),
        wateredAt: <DateTime>[DateTime(2026, 4, 5), DateTime(2026, 4, 9)],
      );
      await prefs.setCulturesJson(
          CultureEntry.encodeAll(<CultureEntry>[legacy]));
      plants.load();

      await cultures.linkLegacyEntries();

      final migrated = cultures.byId('cul_legacy')!;
      expect(migrated.linkedPlantationId, isNotNull);
      final p = plants.byId(migrated.linkedPlantationId!)!;
      expect(p.vegetableId, 'courgette');
      expect(p.plantedAt, DateTime(2026, 4, 2));
      expect(p.wateredAt, hasLength(2));
    });

    test('une culture terminée est rattachée à un plant clos', () async {
      final legacy = CultureEntry(
        id: 'cul_fini',
        vegetableId: 'radis',
        startedAt: DateTime(2026, 3, 1),
        endedAt: DateTime(2026, 5, 1),
      );
      await prefs.setCulturesJson(
          CultureEntry.encodeAll(<CultureEntry>[legacy]));
      plants.load();

      await cultures.linkLegacyEntries();
      final p =
          plants.byId(cultures.byId('cul_fini')!.linkedPlantationId!)!;
      expect(p.isActive, isFalse);
      expect(p.harvestedAt, DateTime(2026, 5, 1));
    });

    test('le rattachement est idempotent : relancé, il ne duplique rien',
        () async {
      await cultures.add(vegetableId: 'tomate', startedAt: DateTime.now());
      await cultures.linkLegacyEntries();
      await cultures.linkLegacyEntries();
      expect(plants.all, hasLength(1));
    });

    test('les arrosages restent lisibles si le plant a été supprimé',
        () async {
      // L'utilisateur peut retirer un plant depuis le Poussidex : son
      // historique dans le cahier ne doit pas disparaître de l'écran.
      final c = await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime.now(),
      );
      final updated = cultures.byId(c.id)!.copyWith(
        wateredAt: <DateTime>[DateTime(2026, 6, 1)],
      );
      await cultures.update(updated);
      await plants.remove(c.linkedPlantationId!);

      expect(cultures.wateringsFor(cultures.byId(c.id)!),
          <DateTime>[DateTime(2026, 6, 1)]);
    });
  });
}
