import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Remontée des erreurs qu'on rattrape volontairement.
///
/// Le contrat local-only impose d'avaler beaucoup d'échecs : une photo
/// qu'on ne peut pas enregistrer, une notification qu'on n'arrive pas à
/// planifier ou un fichier qu'on ne peut pas supprimer ne doivent jamais casser
/// l'app. Mais les avaler **sans rien dire** rend un échec systématique
/// — bucket mal configuré, permission révoquée, quota dépassé —
/// indétectable en production.
///
/// D'où ce passage obligé : le comportement utilisateur ne change pas,
/// la visibilité oui.
///
/// À n'utiliser que pour des échecs **rares et porteurs d'information**.
/// Les échecs fréquents et sans conséquence (un son qui ne part pas, une
/// géolocalisation refusée) restent silencieux : les noyer dans Sentry
/// masquerait les vrais problèmes.
class ErrorReporter {
  const ErrorReporter._();

  /// Signale une erreur rattrapée, en la rattachant à une opération
  /// nommée (`photo_purge`, `notif_monthly`…) pour pouvoir la retrouver
  /// et la regrouper dans Sentry.
  static Future<void> report(
    String operation,
    Object error,
    StackTrace stackTrace,
  ) async {
    if (kDebugMode) {
      debugPrint('[$operation] $error');
    }
    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) => scope.setTag('operation', operation),
    );
  }
}
