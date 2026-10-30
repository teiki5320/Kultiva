import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/services/photo_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Garde-fou contre une perte de photos silencieuse.
///
/// `PhotoService.purgeOrphans` supprime au démarrage tout fichier de
/// `plant_photos/` absent de l'inventaire des photos encore référencées.
/// Cet inventaire se construisait avec `Plantation.decodeAll`, qui renvoie
/// une liste **vide** dès que le JSON est illisible : des préférences
/// corrompues donnaient donc un inventaire vide, et la purge effaçait
/// toutes les photos du jardin — irrécupérables pour un utilisateur sans
/// compte.
///
/// `referencedLocalPaths` doit désormais distinguer « rien à garder » (un
/// ensemble vide, la purge peut travailler) de « je ne sais pas quoi
/// garder » (`null`, la purge doit s'abstenir).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = PrefsService.instance;

  Future<void> withPrefs(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    await prefs.load();
  }

  const plantationAvecPhoto = '[{'
      '"id":"p1","vegetableId":"tomate",'
      '"plantedAt":"2026-05-01T10:00:00.000Z",'
      '"photoPaths":["/docs/plant_photos/plant_1.jpg"]'
      '}]';

  group('inventaire complet', () {
    test('aucune donnée : ensemble vide, pas null', () async {
      await withPrefs(<String, Object>{});
      final keep = PhotoService.referencedLocalPaths();
      // Un utilisateur neuf n'a rien à garder, et la purge doit pouvoir
      // nettoyer d'éventuels restes.
      expect(keep, isNotNull);
      expect(keep, isEmpty);
    });

    test('photos de plantations et de défis réunies', () async {
      await withPrefs(<String, Object>{
        'kultiva.plantations.v1': plantationAvecPhoto,
        'kultiva.challenges.v1':
            '{"defi_1":"/docs/plant_photos/challenge_1.jpg"}',
      });
      expect(
        PhotoService.referencedLocalPaths(),
        <String>{
          '/docs/plant_photos/plant_1.jpg',
          '/docs/plant_photos/challenge_1.jpg',
        },
      );
    });

    test('les URL cloud sont exclues : ce ne sont pas des fichiers locaux',
        () async {
      await withPrefs(<String, Object>{
        'kultiva.challenges.v1': '{'
            '"defi_1":"https://example.supabase.co/storage/photo.jpg",'
            '"defi_2":"/docs/plant_photos/challenge_2.jpg"'
            '}',
      });
      expect(
        PhotoService.referencedLocalPaths(),
        <String>{'/docs/plant_photos/challenge_2.jpg'},
      );
    });
  });

  group('inventaire incomplet → null (la purge doit s\'abstenir)', () {
    test('JSON des plantations illisible', () async {
      await withPrefs(<String, Object>{
        'kultiva.plantations.v1': 'ceci n\'est pas du JSON',
      });
      expect(PhotoService.referencedLocalPaths(), isNull);
    });

    test('une seule plantation malformée suffit', () async {
      // `plantedAt` manquant : `fromJson` lève, et tout le lot devient
      // indécodable. C'est précisément le scénario qui effaçait les
      // photos.
      await withPrefs(<String, Object>{
        'kultiva.plantations.v1':
            '[{"id":"p1","vegetableId":"tomate","plantedAt":"2026-05-01T10:00:00.000Z"},'
            '{"id":"p2","vegetableId":"radis"}]',
      });
      expect(PhotoService.referencedLocalPaths(), isNull);
    });

    test('JSON des défis illisible', () async {
      await withPrefs(<String, Object>{
        'kultiva.plantations.v1': plantationAvecPhoto,
        'kultiva.challenges.v1': '{tronqué',
      });
      expect(PhotoService.referencedLocalPaths(), isNull);
    });

    test('défis au mauvais type racine (liste au lieu d\'objet)', () async {
      await withPrefs(<String, Object>{
        'kultiva.challenges.v1': '["/docs/plant_photos/x.jpg"]',
      });
      expect(PhotoService.referencedLocalPaths(), isNull);
    });
  });
}
