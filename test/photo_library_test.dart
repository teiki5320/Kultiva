import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/garden_photo.dart';
import 'package:kultiva/services/photo_library_service.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// La pellicule rassemble des photos qui appartiennent à deux magasins
/// différents sans en créer un troisième. Ces tests verrouillent les
/// deux choses qui peuvent silencieusement casser : la date lue dans le
/// nom du fichier, et le fait qu'aucune photo ne se perde en route.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final service = PlantationService.instance;
  final prefs = PrefsService.instance;

  /// Un chemin de photo tel que `PhotoService` les nomme.
  String chemin(DateTime quand) =>
      '/docs/plant_photos/plant_${quand.millisecondsSinceEpoch}.jpg';

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await prefs.load();
    service.load();
  });

  group('date lue dans le nom du fichier', () {
    test('un nom de PhotoService donne la date de prise de vue', () {
      final quand = DateTime(2026, 7, 14, 9, 30);
      expect(PhotoLibraryService.takenAtFromPath(chemin(quand)), quand);
    });

    test('un nom sans horodatage ne donne pas de date', () {
      expect(
        PhotoLibraryService.takenAtFromPath('/docs/plant_photos/vieux.jpg'),
        isNull,
      );
    });

    test('une date aberrante est ignorée plutôt que placée en 1970', () {
      // Sans ce garde-fou, un nom bricolé rangeait la photo tout au
      // fond de la pellicule, des décennies avant les autres.
      expect(
        PhotoLibraryService.takenAtFromPath(
            '/docs/plant_photos/plant_1234567890.jpg'),
        isNull,
      );
    });
  });

  group('agrégation', () {
    test('une photo de plant porte son espèce et son âge', () async {
      final p = await service.add('tomate');
      final quand = p.plantedAt.add(const Duration(days: 12));
      await service.addPhoto(p.id, chemin(quand));

      final photos = PhotoLibraryService.plantPhotos();
      expect(photos, hasLength(1));
      expect(photos.first.source, PhotoSource.plant);
      expect(photos.first.vegetableId, 'tomate');
      expect(photos.first.dayAfterPlanting, 12);
      expect(photos.first.ageLabel, 'J+12');
    });

    test('les photos de défis entrent aussi dans la pellicule', () async {
      final p = await service.add('radis');
      await service.addPhoto(p.id, chemin(DateTime(2026, 5, 1)));
      await prefs.setString(
        'kultiva.challenges.v1',
        jsonEncode(<String, String>{
          'premiere_recolte': chemin(DateTime(2026, 6, 1)),
        }),
      );

      final tout = PhotoLibraryService.all();
      expect(tout, hasLength(2));
      expect(
        tout.map((e) => e.source),
        containsAll(<PhotoSource>[PhotoSource.plant, PhotoSource.challenge]),
      );
    });

    test('la pellicule va du plus récent au plus ancien', () async {
      final p = await service.add('laitue');
      await service.addPhoto(p.id, chemin(DateTime(2026, 3, 1)));
      await service.addPhoto(p.id, chemin(DateTime(2026, 8, 1)));
      await service.addPhoto(p.id, chemin(DateTime(2026, 5, 1)));

      final dates = PhotoLibraryService.all().map((e) => e.takenAt).toList();
      expect(dates.first.month, 8);
      expect(dates.last.month, 3);
    });

    test('l\'évolution d\'un plant va du plus ancien au plus récent', () async {
      final p = await service.add('courgette');
      await service.addPhoto(p.id, chemin(DateTime(2026, 8, 1)));
      await service.addPhoto(p.id, chemin(DateTime(2026, 3, 1)));

      final dates = PhotoLibraryService.forPlantation(p.id)
          .map((e) => e.takenAt.month)
          .toList();
      expect(dates, <int>[3, 8]);
    });

    test('une photo distante est ignorée : plus aucune couche réseau',
        () async {
      // Reliquat du temps des comptes, retirés le 30/10/2026.
      final p = await service.add('basilic');
      await service.addPhoto(p.id, 'https://exemple.test/vieille.jpg');
      expect(PhotoLibraryService.all(), isEmpty);
      expect(PhotoLibraryService.plantsWithPhotos(), isEmpty);
    });

    test('un magasin de défis illisible ne vide pas la pellicule', () async {
      final p = await service.add('carotte');
      await service.addPhoto(p.id, chemin(DateTime(2026, 4, 2)));
      await prefs.setString('kultiva.challenges.v1', '{ceci n\'est pas du json');

      expect(PhotoLibraryService.all(), hasLength(1));
    });

    test('les plants les mieux fournis passent devant', () async {
      final a = await service.add('tomate');
      final b = await service.add('radis');
      await service.addPhoto(a.id, chemin(DateTime(2026, 4, 1)));
      await service.addPhoto(b.id, chemin(DateTime(2026, 4, 2)));
      await service.addPhoto(b.id, chemin(DateTime(2026, 4, 3)));

      expect(
        PhotoLibraryService.plantsWithPhotos().first.vegetableId,
        'radis',
      );
    });
  });
}
