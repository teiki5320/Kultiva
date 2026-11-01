import '../models/culture_entry.dart';
import '../models/stage_hypothesis.dart';

/// Traduit les étiquettes d'un modèle d'images **générique** en
/// hypothèse de stade.
///
/// Tout est ici, et rien du plugin : cette classe ne connaît que des
/// `ImageLabel`. C'est ce qui permet de la tester entièrement sans
/// téléphone — et de remplacer ML Kit par un modèle entraîné sans rien
/// réécrire de la logique de décision.
///
/// ## Ce que le modèle générique sait, et ce qu'il ne sait pas
///
/// Un étiqueteur générique reconnaît quelques centaines de concepts
/// larges : « fleur », « fruit », « plante », « feuille ». Comme
/// l'espèce est déjà connue — c'est l'utilisateur qui l'a choisie — ces
/// étiquettes grossières suffisent à trancher **une partie** du stade :
/// voir un fruit, c'est la fructification ; voir une fleur, la
/// floraison.
///
/// En revanche il ne distingue **pas** une plantule d'un plant adulte :
/// les deux sont « une feuille », « une plante ». La classe le dit en
/// rendant deux stades compatibles plutôt qu'un seul.
class StageVision {
  StageVision._();

  /// ## État du vocabulaire ci-dessous
  ///
  /// Google documente « Flower », « Fruit », « Vegetable » et
  /// « Plant » ; le reste de la liste des 400 étiquettes n'est pas
  /// publié, et les ensembles ci-dessous sont donc volontairement
  /// **larges** : une étiquette qui n'existe pas ne coûte rien, elle ne
  /// sera jamais rendue. En revanche une étiquette qui existe et qui
  /// manque ici fait retomber la lecture sur le cran du dessous, ce qui
  /// est le bon sens de l'erreur.
  ///
  /// `StageHypothesis.labels` garde les étiquettes retenues : c'est par
  /// là qu'on complétera ces listes à partir de vraies photos, au lieu
  /// de les deviner.

  /// En dessous, on considère que le modèle n'a rien vu de sûr.
  static const double seuilStade = 0.6;

  /// Un contexte de jardin se contente de moins : il ne décide de rien.
  static const double seuilContexte = 0.5;

  /// Les étiquettes qui disent « il y a un fruit ou un légume formé ».
  static const Set<String> _fruit = <String>{
    'fruit',
    'vegetable',
    'food',
    'produce',
    'berry',
    'tomato',
    'strawberry',
    'pumpkin',
    'squash',
    'melon',
    'citrus',
    'apple',
    'grape',
    'pepper',
    'cucumber',
  };

  /// Les étiquettes qui disent « ça fleurit ».
  static const Set<String> _fleur = <String>{
    'flower',
    'petal',
    'blossom',
    'bud',
  };

  /// Les étiquettes qui disent « du feuillage », sans dire son âge.
  static const Set<String> _feuillage = <String>{
    'plant',
    'leaf',
    'leaves',
    'foliage',
    'herb',
    'grass',
    'tree',
    'shrub',
    'houseplant',
    'vegetation',
    'branch',
    'lawn',
    'forest',
  };

  /// Les étiquettes qui disent « on est bien au jardin », sans rien
  /// dire de la plante elle-même.
  static const Set<String> _contexte = <String>{
    'garden',
    'flowerpot',
    'soil',
    'dirt',
    'greenhouse',
    'gardening',
    'yard',
    'farm',
    'field',
  };

  /// Lit une liste d'étiquettes et en tire les stades compatibles.
  ///
  /// L'ordre des tests n'est pas arbitraire : un plant qui fructifie
  /// porte encore des feuilles, et souvent des fleurs. Le signal le
  /// plus avancé gagne donc, parce qu'il n'apparaît que si la plante
  /// l'a atteint.
  static StageHypothesis read(List<ImageLabel> labels) {
    if (labels.isEmpty) return StageHypothesis.rien;

    ImageLabel? meilleure(Set<String> vocabulaire, double seuil) {
      ImageLabel? best;
      for (final l in labels) {
        if (l.confidence < seuil) continue;
        if (!vocabulaire.contains(l.label.trim().toLowerCase())) continue;
        if (best == null || l.confidence > best.confidence) best = l;
      }
      return best;
    }

    final retenues = labels
        .where((l) => l.confidence >= seuilContexte)
        .toList(growable: false);

    final fruit = meilleure(_fruit, seuilStade);
    if (fruit != null) {
      return StageHypothesis(
        compatible: const <GrowthPhase>{GrowthPhase.fruiting},
        confidence: fruit.confidence,
        seen: 'un fruit',
        labels: retenues,
      );
    }

    final fleur = meilleure(_fleur, seuilStade);
    if (fleur != null) {
      return StageHypothesis(
        compatible: const <GrowthPhase>{GrowthPhase.flowering},
        confidence: fleur.confidence,
        seen: 'une fleur',
        labels: retenues,
      );
    }

    final feuille = meilleure(_feuillage, seuilStade);
    if (feuille != null) {
      // Deux stades, parce que le modèle ne sait pas choisir entre
      // eux. C'est la réponse honnête, pas une approximation.
      return StageHypothesis(
        compatible: const <GrowthPhase>{
          GrowthPhase.seedling,
          GrowthPhase.vegetative,
        },
        confidence: feuille.confidence,
        seen: 'du feuillage',
        labels: retenues,
      );
    }

    final contexte = meilleure(_contexte, seuilContexte);
    if (contexte != null) {
      return StageHypothesis(
        compatible: GrowthPhase.values.toSet(),
        confidence: contexte.confidence,
        seen: 'un coin de jardin',
        labels: retenues,
      );
    }

    return StageHypothesis(compatible: const <GrowthPhase>{}, labels: retenues);
  }

  /// Confronte la photo à l'estimation par date, et rend une phrase.
  ///
  /// Les deux sources sont faibles chacune de son côté : la date ignore
  /// la météo et les accidents, la photo ignore l'espèce et l'âge. Les
  /// croiser est ce qui a de la valeur — et le désaccord est
  /// l'information la plus utile des deux, parce qu'il attrape la photo
  /// de tomate achetée au marché.
  static VisionReading reconcile({
    required StageHypothesis hypothesis,
    required GrowthPhase attendu,
  }) {
    if (!hypothesis.plantSeen) {
      return VisionReading(
        verdict: VisionVerdict.pasDePlante,
        phrase: 'Je n\'ai pas reconnu de plante sur cette photo. '
            'Le stade ci-dessous reste estimé d\'après la date.',
        hypothesis: hypothesis,
      );
    }

    if (hypothesis.indecis) {
      return VisionReading(
        verdict: VisionVerdict.indecis,
        phrase: 'Je vois ${hypothesis.seen}, mais rien qui me dise où en '
            'est le plant. Stade estimé d\'après la date.',
        hypothesis: hypothesis,
      );
    }

    if (hypothesis.compatible.contains(attendu)) {
      return VisionReading(
        verdict: VisionVerdict.accord,
        phrase: 'Je vois ${hypothesis.seen} : ça colle avec le stade '
            'attendu à cette date.',
        hypothesis: hypothesis,
        suggere: attendu,
      );
    }

    // Le stade lu le plus proche de l'attendu, et sa distance.
    final attenduIndex = attendu.index;
    var proche = hypothesis.compatible.first;
    var distance = (proche.index - attenduIndex).abs();
    for (final p in hypothesis.compatible) {
      final d = (p.index - attenduIndex).abs();
      if (d < distance) {
        distance = d;
        proche = p;
      }
    }

    if (distance >= 2) {
      return VisionReading(
        verdict: VisionVerdict.desaccord,
        phrase: 'Je vois ${hypothesis.seen}, alors que la date annonce '
            '« ${attendu.label.toLowerCase()} ». Si la photo est bien '
            'celle de ton plant, dis-moi où il en est — sinon c\'est '
            'peut-être une photo d\'un autre sujet.',
        hypothesis: hypothesis,
        suggere: proche,
      );
    }

    return VisionReading(
      verdict: VisionVerdict.suggestion,
      phrase: 'Je vois ${hypothesis.seen} : ton plant est peut-être déjà '
          'en « ${proche.label.toLowerCase()} ». À toi de confirmer.',
      hypothesis: hypothesis,
      suggere: proche,
    );
  }
}
