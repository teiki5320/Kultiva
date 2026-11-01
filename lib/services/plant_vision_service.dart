import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart'
    as mlkit;

import '../models/stage_hypothesis.dart';
import 'error_reporter.dart';
import 'stage_vision.dart';

/// L'étiqueteur d'images embarqué, et lui seul.
///
/// Tout ce que cette classe fait, c'est transformer un fichier en liste
/// d'étiquettes. La décision — quel stade, quelle phrase — est dans
/// [StageVision], qui ne connaît pas ML Kit et se teste sans lui.
///
/// ## Pourquoi ML Kit, et ce que ça coûte
///
/// Le modèle de base est embarqué dans l'app, tourne hors ligne, ne
/// demande aucune clé et ne facture rien. Il reconnaît quelques
/// centaines de concepts larges, dont « fleur », « fruit » et
/// « plante » — assez pour trancher une partie du stade, puisque
/// l'espèce est déjà connue par ailleurs.
///
/// Il ne reconnaît **pas** les espèces, ni les maladies, ni l'âge d'un
/// plant. Si un jour on entraîne un modèle pour ça, il se branche ici :
/// ML Kit sait charger un `.tflite` maison, et [StageVision] ne changera
/// pas.
///
/// ## Contrat local-only
///
/// Aucun appel réseau : le modèle est dans le binaire. Rien de la photo
/// ne sort du téléphone.
class PlantVisionService {
  PlantVisionService._();

  static final PlantVisionService instance = PlantVisionService._();

  /// Au-delà, on abandonne : une fiche conseil qui attend est pire
  /// qu'une fiche sans lecture de photo.
  static const Duration _delaiMax = Duration(seconds: 8);

  mlkit.ImageLabeler? _labeler;

  mlkit.ImageLabeler get _etiqueteur {
    return _labeler ??= mlkit.ImageLabeler(
      options: mlkit.ImageLabelerOptions(
        // On filtre de nouveau dans StageVision, avec un seuil plus
        // haut pour les étiquettes qui décident d'un stade.
        confidenceThreshold: StageVision.seuilContexte,
      ),
    );
  }

  /// Lit une photo et rend les stades qu'elle n'exclut pas.
  ///
  /// Ne lève jamais : une photo illisible, un modèle absent ou un appel
  /// trop long rendent [StageHypothesis.rien], et la fiche conseil
  /// retombe sur l'estimation par date en le disant.
  Future<StageHypothesis> read(String imagePath) async {
    try {
      if (!await File(imagePath).exists()) return StageHypothesis.rien;
      final brutes = await _etiqueteur
          .processImage(mlkit.InputImage.fromFilePath(imagePath))
          .timeout(_delaiMax);
      return StageVision.read(
        brutes
            .map((l) => ImageLabel(l.label, l.confidence))
            .toList(growable: false),
      );
    } catch (e, s) {
      await ErrorReporter.report('vision_stade', e, s);
      return StageHypothesis.rien;
    }
  }

  /// Libère le modèle natif. Appelé par les tests ; l'app garde
  /// l'étiqueteur ouvert, le rouvrir à chaque photo coûte plus cher.
  Future<void> close() async {
    await _labeler?.close();
    _labeler = null;
  }
}
