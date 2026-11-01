import 'culture_entry.dart';
import 'vegetable.dart';

/// Une section de la fiche conseil.
class AdviceSection {
  final String emoji;
  final String title;
  final String body;

  /// Met la section en avant : arrosage urgent, canicule, maladie
  /// probable. Le reste se lit, ça s'agit.
  final bool urgent;

  const AdviceSection({
    required this.emoji,
    required this.title,
    required this.body,
    this.urgent = false,
  });
}

/// La fiche conseil d'un plant, construite pour **ce plant, ce jour-là**.
///
/// Tout le contenu existait déjà dans l'app — phénologie, conseiller
/// d'arrosage, maladies, canicule, compagnonnage — mais éparpillé sur
/// cinq écrans, et une partie enfermée dans un widget. Personne ne
/// pouvait lire d'un coup ce qu'il fallait faire de son plant
/// aujourd'hui.
class PlantAdvice {
  final Vegetable vegetable;

  /// Le stade retenu, déduit de la date de plantation.
  final GrowthPhase phase;

  final int daysSincePlanted;

  /// Fenêtre de récolte attendue, en jours après la plantation. Null
  /// pour les espèces dont on ne sait pas l'estimer.
  final int? harvestInDays;

  final bool harvestReady;

  final List<AdviceSection> sections;

  const PlantAdvice({
    required this.vegetable,
    required this.phase,
    required this.daysSincePlanted,
    required this.sections,
    this.harvestInDays,
    this.harvestReady = false,
  });
}
