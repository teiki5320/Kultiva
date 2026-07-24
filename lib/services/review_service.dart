import 'package:in_app_review/in_app_review.dart';

import 'prefs_service.dart';

/// Demande une note sur le store après un moment positif.
///
/// Conditions : l'utilisateur a débloqué >= 3 badges et n'a pas encore
/// été sollicité. Apple/Google limitent l'affichage à ~3 fois/an, mais
/// on n'appelle qu'une seule fois pour ne pas être intrusif.
class ReviewService {
  ReviewService._();
  static final ReviewService instance = ReviewService._();

  static const _prefsKey = 'review_requested';

  Future<void> maybeRequestReview({required int unlockedBadgeCount}) async {
    if (unlockedBadgeCount < 3) return;
    final already = PrefsService.instance.getString(_prefsKey) == 'true';
    if (already) return;
    try {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        // On marque AVANT d'ouvrir le dialogue : si l'app est tuée
        // pendant, on ne re-sollicitera pas l'utilisateur au prochain
        // lancement (demande unique, non intrusive).
        await PrefsService.instance.setString(_prefsKey, 'true');
        await inAppReview.requestReview();
      }
    } catch (_) {
      // PlatformException possible (store indisponible) : silencieux.
    }
  }
}
