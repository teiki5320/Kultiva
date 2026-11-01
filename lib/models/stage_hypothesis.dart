import 'culture_entry.dart';

/// Une étiquette rendue par un modèle d'étiquetage d'images.
///
/// Volontairement détachée du paquet qui la produit : la logique qui
/// traduit les étiquettes en stade se teste alors sans téléphone, sans
/// modèle et sans plugin.
class ImageLabel {
  /// Le libellé brut, en anglais — ML Kit répond en anglais quelle que
  /// soit la langue de l'appareil.
  final String label;

  /// Entre 0 et 1.
  final double confidence;

  const ImageLabel(this.label, this.confidence);

  @override
  String toString() => '$label (${(confidence * 100).round()} %)';
}

/// Ce que l'app croit lire sur une photo de plant.
///
/// `compatible` porte **plusieurs** stades, et c'est le cœur de
/// l'honnêteté de cette brique : un modèle générique qui reconnaît
/// « feuille » ne sait pas distinguer une plantule d'un plant en pleine
/// croissance. Prétendre le contraire serait inventer une précision que
/// le modèle n'a pas.
class StageHypothesis {
  /// Les stades que la photo n'exclut pas. Vide quand rien de végétal
  /// n'a été reconnu ; les quatre quand une plante est là sans que son
  /// stade se lise.
  final Set<GrowthPhase> compatible;

  /// La confiance de l'étiquette qui a tranché, entre 0 et 1.
  final double confidence;

  /// Ce qui a été vu, dit en français, pour pouvoir l'afficher :
  /// « un fruit », « une fleur », « du feuillage ».
  final String? seen;

  /// Les étiquettes retenues, pour le débogage et pour expliquer.
  final List<ImageLabel> labels;

  const StageHypothesis({
    required this.compatible,
    this.confidence = 0,
    this.seen,
    this.labels = const <ImageLabel>[],
  });

  /// Rien de végétal sur la photo.
  static const StageHypothesis rien =
      StageHypothesis(compatible: <GrowthPhase>{});

  bool get plantSeen => compatible.isNotEmpty;

  /// Vrai quand la photo ne réduit pas le champ : une plante, mais pas
  /// de stade lisible.
  bool get indecis => compatible.length >= GrowthPhase.values.length;
}

/// Comment la lecture de la photo se compare à l'estimation par date.
enum VisionVerdict {
  /// La photo confirme ce que la date annonçait.
  accord,

  /// La photo propose le stade voisin : il y a quelque chose à dire.
  suggestion,

  /// La photo lit tout autre chose, trop loin pour un décalage de
  /// quelques jours. Souvent le signe d'une photo de légume acheté, ou
  /// du mauvais plant choisi.
  desaccord,

  /// Une plante, mais aucun stade lisible.
  indecis,

  /// Aucune plante reconnue.
  pasDePlante,
}

/// La lecture d'une photo, prête à être affichée.
class VisionReading {
  final VisionVerdict verdict;

  /// Le stade proposé, ou null quand il n'y a rien à proposer.
  final GrowthPhase? suggere;

  /// Une phrase en français, à montrer tel quel.
  final String phrase;

  final StageHypothesis hypothesis;

  const VisionReading({
    required this.verdict,
    required this.phrase,
    required this.hypothesis,
    this.suggere,
  });

  /// Vrai quand la fiche a quelque chose à proposer à l'utilisateur.
  bool get actionnable =>
      suggere != null &&
      (verdict == VisionVerdict.suggestion ||
          verdict == VisionVerdict.desaccord);
}
