import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Résultat d'un appel à [PhotoService.pick].
enum PhotoPickStatus {
  /// Photo capturée ou importée avec succès ; [PhotoPickResult.path] renseigné.
  success,

  /// L'utilisateur a explicitement annulé dans le picker.
  cancelled,

  /// La permission caméra est refusée (l'utilisateur doit aller dans
  /// les réglages OS pour l'autoriser).
  permissionDenied,

  /// Toute autre erreur (IO, picker qui crashe, etc.).
  error,
}

/// Résultat structuré d'un pick photo. Permet à l'appelant de distinguer
/// une annulation d'un refus de permission pour afficher le bon message.
class PhotoPickResult {
  final PhotoPickStatus status;
  final String? path;

  const PhotoPickResult(this.status, {this.path});
}

/// Service pour capturer ou importer une photo et la sauvegarder
/// dans le dossier permanent de l'application.
class PhotoService {
  PhotoService._();

  static final ImagePicker _picker = ImagePicker();

  /// Demande une photo à l'utilisateur (caméra ou galerie selon [fromCamera])
  /// puis copie le fichier retourné dans `Documents/plant_photos/` avec un
  /// nom unique basé sur le timestamp.
  ///
  /// Retourne un [PhotoPickResult] permettant de distinguer les cas
  /// succès / annulation / permission refusée / erreur.
  static Future<PhotoPickResult> pickDetailed({
    required bool fromCamera,
  }) async {
    // Pré-check permission caméra : si déjà refusée définitivement, on
    // court-circuite le picker pour afficher notre dialog.
    if (fromCamera) {
      final status = await Permission.camera.status;
      if (status.isPermanentlyDenied || status.isRestricted) {
        return const PhotoPickResult(PhotoPickStatus.permissionDenied);
      }
      if (status.isDenied) {
        final result = await Permission.camera.request();
        if (!result.isGranted) {
          return const PhotoPickResult(PhotoPickStatus.permissionDenied);
        }
      }
    }

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
      return PhotoPickResult(PhotoPickStatus.success, path: dest);
    } catch (e) {
      // image_picker lance une PlatformException avec code
      // 'camera_access_denied' si l'utilisateur refuse au moment du prompt.
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

  static String _extension(String path) {
    final i = path.lastIndexOf('.');
    if (i < 0 || i == path.length - 1) return '.jpg';
    return path.substring(i).toLowerCase();
  }
}
