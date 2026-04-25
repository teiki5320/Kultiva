import '../data/rotation.dart';
import '../models/culture_entry.dart';

/// Type d'avertissement de rotation détecté.
enum RotationWarningKind {
  /// Le même légume a été cultivé récemment (waitYears > 0).
  sameVegetable,

  /// Un légume de la même famille a été cultivé récemment.
  sameFamily,
}

class RotationWarning {
  final RotationWarningKind kind;
  final String family;
  final String previousVegetableId;
  final int yearsAgo;
  final int waitYears;

  const RotationWarning({
    required this.kind,
    required this.family,
    required this.previousVegetableId,
    required this.yearsAgo,
    required this.waitYears,
  });

  String get message {
    final yearsAgoText = yearsAgo == 0
        ? "cette saison"
        : "il y a $yearsAgo an${yearsAgo > 1 ? 's' : ''}";
    if (kind == RotationWarningKind.sameVegetable) {
      return "Tu as déjà cultivé ce légume $yearsAgoText. La rotation "
          "recommande $waitYears an${waitYears > 1 ? 's' : ''} d'attente.";
    }
    return "Tu as déjà cultivé un $family ($previousVegetableId) "
        "$yearsAgoText. Évite la même famille avant $waitYears "
        "an${waitYears > 1 ? 's' : ''}.";
  }
}

/// Cherche un avertissement de rotation pour un légume donné, basé
/// sur les cultures pleine terre passées de l'utilisateur.
RotationWarning? checkRotation({
  required String vegetableId,
  required List<CultureEntry> previousCultures,
}) {
  final data = rotationMap[vegetableId];
  if (data == null) return null;

  final now = DateTime.now();

  // Cherche d'abord exactement le même légume.
  for (final c in previousCultures) {
    if (c.vegetableId != vegetableId) continue;
    if (c.method != CultivationMethod.soil) continue;
    final years = now.year - c.startedAt.year;
    if (years < data.waitYears) {
      return RotationWarning(
        kind: RotationWarningKind.sameVegetable,
        family: data.family,
        previousVegetableId: vegetableId,
        yearsAgo: years,
        waitYears: data.waitYears,
      );
    }
  }

  // Puis un légume de la même famille.
  for (final c in previousCultures) {
    if (c.method != CultivationMethod.soil) continue;
    final prev = rotationMap[c.vegetableId];
    if (prev == null) continue;
    if (prev.family != data.family) continue;
    final years = now.year - c.startedAt.year;
    if (years < data.waitYears) {
      return RotationWarning(
        kind: RotationWarningKind.sameFamily,
        family: data.family,
        previousVegetableId: c.vegetableId,
        yearsAgo: years,
        waitYears: data.waitYears,
      );
    }
  }
  return null;
}
