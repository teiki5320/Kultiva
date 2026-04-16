import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Service pour capturer ou importer une photo et la sauvegarder
/// dans le dossier permanent de l'application.
///
/// Retourne le chemin absolu du fichier sauvegardé, ou null si l'utilisateur
/// a annulé / en cas d'erreur.
class PhotoService {
  PhotoService._();

  static final ImagePicker _picker = ImagePicker();

  /// Demande une photo à l'utilisateur (caméra ou galerie selon [fromCamera])
  /// puis copie le fichier retourné dans `Documents/plant_photos/` avec un
  /// nom unique basé sur le timestamp.
  static Future<String?> pick({required bool fromCamera}) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null) return null;

      final docsDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${docsDir.path}/plant_photos');
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }
      final ts = DateTime.now().millisecondsSinceEpoch;
      final ext = _extension(picked.path);
      final dest = '${photosDir.path}/plant_$ts$ext';
      await File(picked.path).copy(dest);
      return dest;
    } catch (_) {
      return null;
    }
  }

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
