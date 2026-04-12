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
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return _regionFromCoordinates(position.latitude, position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// Détermine la région à partir des coordonnées.
  ///
  /// Heuristique simple :
  /// - Latitude 0–25°N, Longitude -20°W à 20°E → Afrique de l'Ouest
  /// - Sinon → France (défaut européen)
  static Region _regionFromCoordinates(double lat, double lng) {
    if (lat >= 0 && lat <= 25 && lng >= -20 && lng <= 20) {
      return Region.westAfrica;
    }
    return Region.france;
  }
}
