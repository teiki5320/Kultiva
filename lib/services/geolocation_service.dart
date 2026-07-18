import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/country.dart';
import '../models/region_data.dart';

/// Service de géolocalisation pour détecter automatiquement le pays
/// (et donc la région) de l'utilisateur.
///
/// Chaîne de détection :
/// 1. position GPS (précision faible suffit) ;
/// 2. géocodage inverse → code pays ISO → [Country] ;
/// 3. en secours (géocodage indisponible), boîte englobante de
///    l'Afrique de l'Ouest → région AO sans pays précis.
class GeolocationService {
  GeolocationService._();

  /// Tente de déterminer le pays à partir de la position GPS.
  /// Retourne null si la localisation est indisponible, refusée, ou si
  /// le pays détecté n'est pas couvert par Kultiva.
  static Future<Country?> detectCountry() async {
    final position = await _currentPosition();
    if (position == null) return null;

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 8));
      if (placemarks.isNotEmpty) {
        final iso = placemarks.first.isoCountryCode;
        final country = Country.fromIso(iso);
        if (country != null) return country;
      }
    } catch (_) {
      // Géocodage indisponible (offline, quota…) → secours ci-dessous.
    }
    return null;
  }

  /// Tente de déterminer la région à partir de la position GPS.
  /// Retourne null si la localisation est indisponible ou refusée.
  static Future<Region?> detectRegion() async {
    final country = await detectCountry();
    if (country != null) return country.region;

    // Secours sans géocodage : boîte englobante Afrique de l'Ouest.
    final position = await _currentPosition();
    if (position == null) return null;
    if (Country.coordsInWestAfrica(position.latitude, position.longitude)) {
      return Region.westAfrica;
    }
    return Region.france;
  }

  static Position? _lastPosition;
  static DateTime? _lastPositionAt;

  static Future<Position?> _currentPosition() async {
    try {
      // Réutilise la position obtenue il y a moins d'une minute pour ne
      // pas relancer deux acquisitions GPS dans le même parcours.
      if (_lastPosition != null &&
          _lastPositionAt != null &&
          DateTime.now().difference(_lastPositionAt!) <
              const Duration(minutes: 1)) {
        return _lastPosition;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) return null;

      _lastPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 15),
      );
      _lastPositionAt = DateTime.now();
      return _lastPosition;
    } catch (_) {
      return null;
    }
  }
}
