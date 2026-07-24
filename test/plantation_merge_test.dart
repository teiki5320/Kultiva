import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';

/// Tests de la fusion champ par champ utilisée par CloudSyncService lors
/// du merge multi-appareils. Le contrat clé : aucune donnée ne doit être
/// perdue quand deux versions d'une même plantation sont fusionnées.
void main() {
  group('Plantation.merge', () {
    test('union des arrosages, dédupliqués et triés', () {
      final a = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        wateredAt: [DateTime(2026, 4, 5), DateTime(2026, 4, 10)],
      );
      final b = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        wateredAt: [DateTime(2026, 4, 10), DateTime(2026, 4, 12)],
      );
      final m = Plantation.merge(a, b);
      expect(m.wateredAt, <DateTime>[
        DateTime(2026, 4, 5),
        DateTime(2026, 4, 10),
        DateTime(2026, 4, 12),
      ]);
    });

    test('union des photos (locale + cloud), sans doublon, ordre a puis b', () {
      final a = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        photoPaths: const ['/local/photo1.jpg', 'https://cdn/x.jpg'],
      );
      final b = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        photoPaths: const ['https://cdn/x.jpg', 'https://cdn/y.jpg'],
      );
      final m = Plantation.merge(a, b);
      expect(m.photoPaths, const [
        '/local/photo1.jpg',
        'https://cdn/x.jpg',
        'https://cdn/y.jpg',
      ]);
    });

    test('harvestCount pris au maximum', () {
      final a = _base(harvestCount: 3);
      final b = _base(harvestCount: 5);
      expect(Plantation.merge(a, b).harvestCount, 5);
      expect(Plantation.merge(b, a).harvestCount, 5);
    });

    test('note non-vide conservée face à une note vide (peu importe le sens)',
        () {
      final withNote = _base(note: 'Belle récolte');
      final without = _base(note: null);
      expect(Plantation.merge(withNote, without).note, 'Belle récolte');
      expect(Plantation.merge(without, withNote).note, 'Belle récolte');
    });

    test('deux notes non-vides : on garde la plus longue', () {
      final a = _base(note: 'court');
      final b = _base(note: 'une note bien plus longue et détaillée');
      expect(Plantation.merge(a, b).note,
          'une note bien plus longue et détaillée');
    });

    test('harvestedAt : l\'unique non-nulle est conservée', () {
      final active = _base(); // harvestedAt null
      final harvested = _base(harvestedAt: DateTime(2026, 7, 1));
      expect(Plantation.merge(active, harvested).harvestedAt,
          DateTime(2026, 7, 1));
      expect(Plantation.merge(harvested, active).harvestedAt,
          DateTime(2026, 7, 1));
    });

    test('harvestedAt : la plus tardive gagne si les deux sont présentes', () {
      final a = _base(harvestedAt: DateTime(2026, 7, 1));
      final b = _base(harvestedAt: DateTime(2026, 7, 15));
      expect(Plantation.merge(a, b).harvestedAt, DateTime(2026, 7, 15));
    });

    test('plantedAt : la date la plus ancienne est conservée', () {
      final a = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 10),
      );
      final b = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
      );
      expect(Plantation.merge(a, b).plantedAt, DateTime(2026, 4, 1));
    });

    test('scénario audit : photos+note offline vs arrosages sur autre appareil',
        () {
      // Device A : 3 photos + une note, aucun arrosage cloud.
      final deviceA = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        note: 'Semis maison',
        photoPaths: const ['/a/1.jpg', '/a/2.jpg', '/a/3.jpg'],
      );
      // Device B (cloud) : 2 arrosages, pas de photo, pas de note.
      final deviceB = Plantation(
        id: 'p1',
        vegetableId: 'tomate',
        plantedAt: DateTime(2026, 4, 1),
        wateredAt: [DateTime(2026, 4, 6), DateTime(2026, 4, 9)],
      );
      final m = Plantation.merge(deviceA, deviceB);
      // Rien n'est perdu : les 3 photos, la note ET les 2 arrosages.
      expect(m.photoPaths.length, 3);
      expect(m.note, 'Semis maison');
      expect(m.wateredAt.length, 2);
    });
  });
}

Plantation _base({
  int harvestCount = 0,
  String? note,
  DateTime? harvestedAt,
}) {
  return Plantation(
    id: 'p1',
    vegetableId: 'tomate',
    plantedAt: DateTime(2026, 4, 1),
    harvestCount: harvestCount,
    note: note,
    harvestedAt: harvestedAt,
  );
}
