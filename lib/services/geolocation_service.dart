import 'package:geolocator/geolocator.dart';

import '../models/region_data.dart';

/// Service de géolocalisation pour détecter automatiquement la région.
///
/// Logique simplifiée : si latitude < 25°N → Afrique de l'Ouest,
/// sinon → France (par défaut). Extensible pour d'autres régions.
class GeolocationService {
  GeolocationService._();

  /// Tente de déterminer la région à partir de la position GPS.
  /// Retourne null si la localisation est indisponible ou refusée.
  static Future<Region?> detectRegion() async {
    try {
      // Vérifier si la localisation est activée.
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Vérifier/demander les permissions.
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) return null;

      // Récupérer la position.
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      return _regionFromCoordinates(position.latitude, position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// Détermine la région à partir des coordonnées.
  ///
  /// Refonte avril 2026 : on retourne toujours Region.france (le
  /// catalogue Afrique de l'Ouest a été retiré du picker mais reste
  /// dans l'enum pour compat). On garde la fonction au cas où on
  /// rouvrirait le marché plus tard.
  static Region _regionFromCoordinates(double lat, double lng) {
    return Region.france;
  }
}
