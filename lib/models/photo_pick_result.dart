/// Résultat d'un appel à [PhotoService.pick].
enum PhotoPickStatus {
  /// Photo capturée ou importée avec succès ; [PhotoPickResult.path] renseigné.
  success,

  /// L'utilisateur a explicitement annulé dans le picker.
  cancelled,

  /// La permission caméra / galerie est refusée (l'utilisateur doit
  /// aller dans les réglages OS pour l'autoriser).
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
