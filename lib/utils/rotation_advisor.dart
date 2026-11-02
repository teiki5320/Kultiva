import '../data/rotation.dart';
import '../data/ui_i18n.dart';
import '../data/vegetables_base.dart';
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

  /// « 1 an » / « 3 ans » : le singulier et le pluriel sont deux clés
  /// du dictionnaire, parce qu'une autre langue n'accorde pas pareil.
  static String _duree(int n) => n > 1
      ? trUiArgs('{0} ans', <Object?>[n])
      : trUiArgs('{0} an', <Object?>[n]);

  String get message {
    final yearsAgoText = yearsAgo == 0
        ? trUi('cette saison')
        : trUiArgs('il y a {0}', <Object?>[_duree(yearsAgo)]);
    if (kind == RotationWarningKind.sameVegetable) {
      return trUiArgs(
          'Tu as déjà cultivé ce légume {0}. La rotation recommande {1} '
          "d'attente.",
          <Object?>[yearsAgoText, _duree(waitYears)]);
    }
    final nom = vegetablesBase
            .where((v) => v.id == previousVegetableId)
            .firstOrNull
            ?.name
            .toLowerCase() ??
        previousVegetableId;
    return trUiArgs(
        'Tu as déjà cultivé un {0} ici ({1}) {2}. '
        'Évite la même famille avant {3}.',
        <Object?>[family, nom, yearsAgoText, _duree(waitYears)]);
  }
}

/// Cherche un avertissement de rotation pour un légume donné, basé
/// sur les cultures pleine terre passées de l'utilisateur.
///
/// ⚠️ [previousCultures] doit ne contenir que des cultures **closes**.
/// La rotation parle de ce qui a occupé la terre avant, pas de ce qui
/// y pousse en ce moment : sur la liste complète, un plant se serait
/// signalé lui-même, et trois pieds de tomate plantés le même jour
/// auraient déclenché l'alerte les uns pour les autres.
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
