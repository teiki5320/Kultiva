import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/photo_pick_result.dart';
import '../models/plantation.dart';
import 'error_reporter.dart';
import 'prefs_service.dart';

/// Service pour capturer ou importer une photo et la sauvegarder
/// dans le dossier permanent de l'application.
class PhotoService {
  PhotoService._();

  static final ImagePicker _picker = ImagePicker();

  /// Demande une photo à l'utilisateur (caméra ou galerie selon [fromCamera])
  /// puis copie le fichier retourné dans `Documents/plant_photos/` avec un
  /// nom unique basé sur le timestamp.
  ///
  /// On laisse `image_picker` gérer lui-même la demande de permission
  /// (natif iOS/Android) et on détecte le refus via l'exception qu'il
  /// lance (`PlatformException('camera_access_denied')` etc.).
  /// Ça évite les faux refus liés à la configuration du Podfile de
  /// permission_handler.
  static Future<PhotoPickResult> pickDetailed({
    required bool fromCamera,
  }) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null) {
        return const PhotoPickResult(PhotoPickStatus.cancelled);
      }

      final docsDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${docsDir.path}/plant_photos');
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }
      final ts = DateTime.now().millisecondsSinceEpoch;
      final ext = _extension(picked.path);
      final dest = '${photosDir.path}/plant_$ts$ext';
      await File(picked.path).copy(dest);
      // Le fichier temporaire d'image_picker (cache) est désormais inutile :
      // on le supprime pour ne pas doubler chaque photo sur le disque.
      try {
        await File(picked.path).delete();
      } catch (_) {}
      return PhotoPickResult(PhotoPickStatus.success, path: dest);
    } on PlatformException catch (e) {
      final code = e.code.toLowerCase();
      if (code.contains('denied') || code.contains('permission')) {
        return const PhotoPickResult(PhotoPickStatus.permissionDenied);
      }
      return const PhotoPickResult(PhotoPickStatus.error);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('denied') || msg.contains('permission')) {
        return const PhotoPickResult(PhotoPickStatus.permissionDenied);
      }
      return const PhotoPickResult(PhotoPickStatus.error);
    }
  }

  /// Variante legacy qui retourne juste le chemin (ou null). Conservée
  /// pour les callsites qui n'ont pas besoin de distinguer permission
  /// refusée vs annulation.
  static Future<String?> pick({required bool fromCamera}) async {
    final r = await pickDetailed(fromCamera: fromCamera);
    return r.path;
  }

  /// Ouvre les réglages OS sur la fiche de l'app (fiche permissions).
  /// À utiliser depuis un dialog quand la caméra est refusée.
  static Future<bool> openSettings() => openAppSettings();

  /// Supprime silencieusement un fichier photo (typiquement quand on
  /// retire une photo d'un plant).
  static Future<void> deleteFile(String path) async {
    try {
      final f = File(path);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  /// Purge best-effort les fichiers photo locaux qui ne sont plus
  /// référencés par aucune plantation ni aucun défi complété (ex. photos
  /// de défi dont le chemin local a été remplacé par l'URL cloud après
  /// upload). Évite que `Documents/plant_photos/` grossisse sans borne.
  /// À appeler au boot.
  static Future<void> purgeOrphans() async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${docsDir.path}/plant_photos');
      if (!await photosDir.exists()) return;
      final keep = _referencedLocalPaths();
      // Garde-fou : `null` signifie que l'inventaire des photos encore
      // référencées n'a pas pu être reconstitué entièrement. On ne
      // supprime alors RIEN. Sans ce test, des préférences corrompues
      // donnaient un inventaire vide — et la purge effaçait toutes les
      // photos du jardin, irrécupérables pour un utilisateur sans
      // compte.
      if (keep == null) return;
      await for (final entity in photosDir.list()) {
        if (entity is File && !keep.contains(entity.path)) {
          try {
            await entity.delete();
          } catch (_) {}
        }
      }
    } catch (e, s) {
      await ErrorReporter.report('photo_purge', e, s);
    }
  }

  /// Chemins locaux encore référencés (plantations + défis complétés).
  ///
  /// Renvoie `null` si l'inventaire est incomplet — c'est-à-dire si l'un
  /// des deux magasins n'a pas pu être décodé. L'appelant doit alors
  /// s'abstenir de supprimer quoi que ce soit.
  ///
  /// Le décodage est fait ici et volontairement **strict**, au lieu de
  /// passer par `Plantation.decodeAll`, qui renvoie une liste vide en cas
  /// d'échec : cette tolérance est la bonne pour l'affichage, mais ici
  /// « rien à garder » et « je ne sais pas quoi garder » ne doivent
  /// surtout pas se confondre.
  static Set<String>? _referencedLocalPaths() {
    final keep = <String>{};
    final plantationsRaw = PrefsService.instance.plantationsJson;
    if (plantationsRaw != null && plantationsRaw.isNotEmpty) {
      try {
        final list = jsonDecode(plantationsRaw) as List<dynamic>;
        for (final e in list) {
          final p = Plantation.fromJson(e as Map<String, dynamic>);
          keep.addAll(p.photoPaths.where((s) => !s.startsWith('http')));
        }
      } catch (e, s) {
        ErrorReporter.report('photo_keepset_plantations', e, s);
        return null;
      }
    }
    final raw = PrefsService.instance.getString('kultiva.challenges.v1');
    if (raw != null && raw.isNotEmpty) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        for (final v in map.values) {
          if (v is String && v.isNotEmpty && !v.startsWith('http')) {
            keep.add(v);
          }
        }
      } catch (e, s) {
        ErrorReporter.report('photo_keepset_challenges', e, s);
        return null;
      }
    }
    return keep;
  }

  static String _extension(String path) {
    final i = path.lastIndexOf('.');
    if (i < 0 || i == path.length - 1) return '.jpg';
    return path.substring(i).toLowerCase();
  }
}
