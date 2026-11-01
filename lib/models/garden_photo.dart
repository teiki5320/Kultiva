/// D'où vient une photo du jardin.
enum PhotoSource {
  /// Prise sur un plant du cahier de culture.
  plant,

  /// Prise pour valider un défi photo.
  challenge,
}

/// Une photo du jardin, rattachée à ce qu'elle montre et datée.
///
/// ⚠️ Ce n'est **pas** un nouveau magasin. Les photos appartiennent
/// toujours à leur propriétaire d'origine — la `Plantation` pour les
/// plants, la préférence `kultiva.challenges.v1` pour les défis — et
/// `GardenPhoto` n'est qu'une vue construite à la volée par
/// `PhotoLibraryService` pour pouvoir les afficher ensemble. Rien ici
/// n'est persisté : le jour où on recréerait un registre parallèle, on
/// referait l'erreur des quatre registres d'arrosage dont trois étaient
/// morts.
class GardenPhoto {
  /// Chemin absolu du fichier local.
  final String path;

  /// Quand la photo a été prise, lue dans le nom du fichier.
  final DateTime takenAt;

  final PhotoSource source;

  /// Le plant photographié, pour [PhotoSource.plant].
  final String? plantationId;

  /// L'espèce photographiée, pour [PhotoSource.plant].
  final String? vegetableId;

  /// Depuis quand ce plant était en terre le jour de la photo.
  /// Null pour une photo de défi, qui ne suit aucun plant.
  final int? dayAfterPlanting;

  /// Le défi validé, pour [PhotoSource.challenge].
  final String? challengeId;

  const GardenPhoto({
    required this.path,
    required this.takenAt,
    required this.source,
    this.plantationId,
    this.vegetableId,
    this.dayAfterPlanting,
    this.challengeId,
  });

  /// « J+12 » — l'âge du plant au moment de la photo.
  ///
  /// Court exprès : l'étiquette se pose sur une vignette de 70 px, où
  /// « Jour de la plantation » couvrait toute la photo. La version
  /// longue est le travail de [ageSentence], qui a la place de
  /// s'exprimer.
  String? get ageLabel {
    final j = dayAfterPlanting;
    if (j == null) return null;
    return j <= 0 ? 'J+0' : 'J+$j';
  }

  /// La même chose en toutes lettres, pour le plein écran.
  String? get ageSentence {
    final j = dayAfterPlanting;
    if (j == null) return null;
    if (j <= 0) return 'le jour de la plantation';
    return '$j jour${j > 1 ? 's' : ''} après la plantation';
  }
}
