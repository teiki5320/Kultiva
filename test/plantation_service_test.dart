import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Couvre le service qui manquait.
///
/// Avant, aucun écran ne créait, n'arrosait ni ne récoltait une
/// `Plantation` : seules une migration unique depuis l'ancienne grille et
/// la synchro cloud écrivaient le magasin. Le Poussidex promis par la
/// fiche App Store restait donc vide à vie.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final service = PlantationService.instance;
  final prefs = PrefsService.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await prefs.load();
    service.load();
  });

  group('ajout', () {
    test('un plant ajouté est en cours, sans arrosage ni récolte', () async {
      final p = await service.add('tomate');
      expect(service.all, hasLength(1));
      expect(p.vegetableId, 'tomate');
      expect(p.isActive, isTrue);
      expect(p.wateredAt, isEmpty);
      expect(p.harvestCount, 0);
    });

    test('deux plants de la même espèce comptent deux fois', () async {
      // C'est ce décompte qui débloque les médailles bronze/argent/or :
      // il doit cumuler les cultures, pas dédoublonner les espèces.
      await service.add('tomate');
      await service.add('tomate');
      await service.add('radis');
      expect(service.countFor('tomate'), 2);
      expect(service.countFor('radis'), 1);
      expect(service.countFor('courgette'), 0);
    });

    test('la collection est persistée, pas seulement en mémoire', () async {
      await service.add('basilic');
      // Relecture depuis le magasin, comme au prochain démarrage.
      final stored = Plantation.decodeAll(prefs.plantationsJson);
      expect(stored, hasLength(1));
      expect(stored.first.vegetableId, 'basilic');
    });

    test('du plus récent au plus ancien, même avec une date passée',
        () async {
      await service.add('tomate');
      await service.add(
        'radis',
        plantedAt: DateTime.now().subtract(const Duration(days: 30)),
      );
      await service.add('basilic');
      expect(
        service.all.map((p) => p.vegetableId).toList(),
        <String>['basilic', 'tomate', 'radis'],
      );
    });
  });

  group('arrosage', () {
    test('chaque arrosage laisse une trace', () async {
      // Le geste le plus fréquent de l'app : sans trace, l'historique du
      // plant et les statistiques du Poussidex sont faux.
      final p = await service.add('tomate');
      await service.water(p.id);
      await service.water(p.id);
      expect(service.byId(p.id)!.wateredAt, hasLength(2));
    });

    test('arroser un plant inconnu ne casse rien', () async {
      await service.add('tomate');
      await service.water('identifiant-qui-nexiste-pas');
      expect(service.all, hasLength(1));
      expect(service.byId(service.all.first.id)!.wateredAt, isEmpty);
    });
  });

  group('récolte et clôture', () {
    test('récolter incrémente sans clore : une tomate donne plusieurs fois',
        () async {
      final p = await service.add('tomate');
      await service.harvest(p.id);
      await service.harvest(p.id);
      final fresh = service.byId(p.id)!;
      expect(fresh.harvestCount, 2);
      expect(fresh.isActive, isTrue);
    });

    test('clore sort le plant des cultures en cours, sans le supprimer',
        () async {
      final p = await service.add('tomate');
      await service.terminate(p.id);
      expect(service.byId(p.id)!.isActive, isFalse);
      expect(service.active, isEmpty);
      // Il compte toujours pour les médailles.
      expect(service.countFor('tomate'), 1);
    });

    test('rouvrir annule une clôture faite par erreur', () async {
      final p = await service.add('tomate');
      await service.terminate(p.id);
      await service.reopen(p.id);
      expect(service.byId(p.id)!.isActive, isTrue);
      expect(service.active, hasLength(1));
    });
  });

  group('note', () {
    test('une note vide efface la note au lieu de la laisser', () async {
      // `copyWith(note: null)` voulait dire « ne change rien » : sans le
      // drapeau clearNote, la note était ineffaçable.
      final p = await service.add('tomate');
      await service.setNote(p.id, 'semée côté sud');
      expect(service.byId(p.id)!.note, 'semée côté sud');
      await service.setNote(p.id, '   ');
      expect(service.byId(p.id)!.note, isNull);
    });
  });

  group('suppression', () {
    test('retirer un plant le sort de la collection', () async {
      final a = await service.add('tomate');
      await service.add('radis');
      await service.remove(a.id);
      expect(service.all, hasLength(1));
      expect(service.byId(a.id), isNull);
      expect(Plantation.decodeAll(prefs.plantationsJson), hasLength(1));
    });
  });

  group('recalage sur le magasin', () {
    test('une réécriture externe (fusion cloud) est reprise', () async {
      await service.add('tomate');
      // La synchro cloud réécrit le magasin sans passer par le service.
      await prefs.setPlantationsJson(
        '[{"id":"cloud-1","vegetableId":"courgette",'
        '"plantedAt":"2026-05-01T10:00:00.000Z"}]',
      );
      expect(service.all, hasLength(1));
      expect(service.all.first.vegetableId, 'courgette');
    });

    test('nos propres écritures ne déclenchent pas de rechargement en boucle',
        () async {
      var notifications = 0;
      void count() => notifications++;
      service.addListener(count);
      await service.add('tomate');
      service.removeListener(count);
      // Une seule notification par mutation : le listener sur
      // plantationsVersion ne doit pas en rajouter une deuxième.
      expect(notifications, 1);
    });
  });
}
