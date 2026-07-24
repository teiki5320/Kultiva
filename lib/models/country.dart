import 'region_data.dart';

/// Zone climatique d'un pays, pour affiner saisons et conseils.
enum ClimateZone {
  /// Climat tempéré à quatre saisons (France métropolitaine).
  temperate,

  /// Sahel : saison des pluies courte (juin-septembre), harmattan marqué.
  sahel,

  /// Zone soudanienne : saison des pluies de mai à octobre.
  sudan,

  /// Côte guinéenne : climat humide, deux pics de pluies.
  guinean,
}

/// Pays couverts par Kultiva.
///
/// La France conserve l'expérience historique ; les huit pays francophones
/// d'Afrique de l'Ouest partagent le calendrier tropical [Region.westAfrica]
/// et portent chacun leur zone climatique et leur capitale (utilisée comme
/// position météo de secours quand la géolocalisation est refusée).
enum Country {
  france('FR', 'France', '🇫🇷', Region.france, ClimateZone.temperate, 48.8566,
      2.3522, 'Paris'),
  senegal('SN', 'Sénégal', '🇸🇳', Region.westAfrica, ClimateZone.sahel,
      14.6928, -17.4467, 'Dakar'),
  coteDivoire('CI', "Côte d'Ivoire", '🇨🇮', Region.westAfrica,
      ClimateZone.guinean, 5.3600, -4.0083, 'Abidjan'),
  mali('ML', 'Mali', '🇲🇱', Region.westAfrica, ClimateZone.sahel, 12.6392,
      -8.0029, 'Bamako'),
  burkinaFaso('BF', 'Burkina Faso', '🇧🇫', Region.westAfrica,
      ClimateZone.sudan, 12.3714, -1.5197, 'Ouagadougou'),
  benin('BJ', 'Bénin', '🇧🇯', Region.westAfrica, ClimateZone.guinean, 6.3703,
      2.3912, 'Cotonou'),
  togo('TG', 'Togo', '🇹🇬', Region.westAfrica, ClimateZone.guinean, 6.1256,
      1.2254, 'Lomé'),
  niger('NE', 'Niger', '🇳🇪', Region.westAfrica, ClimateZone.sahel, 13.5137,
      2.1098, 'Niamey'),
  guinee('GN', 'Guinée', '🇬🇳', Region.westAfrica, ClimateZone.guinean, 9.6412,
      -13.5784, 'Conakry');

  final String isoCode;
  final String label;
  final String flag;
  final Region region;
  final ClimateZone zone;
  final double capitalLat;
  final double capitalLon;
  final String capitalName;

  const Country(this.isoCode, this.label, this.flag, this.region, this.zone,
      this.capitalLat, this.capitalLon, this.capitalName);

  bool get isWestAfrica => region == Region.westAfrica;

  /// Pays francophones d'Afrique de l'Ouest proposés dans les sélecteurs.
  static List<Country> get westAfricanCountries =>
      values.where((c) => c.isWestAfrica).toList();

  /// Retrouve un pays depuis son code ISO 3166-1 alpha-2 (ex. 'SN').
  /// Retourne null si le code est inconnu ou absent.
  static Country? fromIso(String? code) {
    if (code == null) return null;
    final upper = code.toUpperCase();
    for (final c in values) {
      if (c.isoCode == upper) return c;
    }
    return null;
  }

  /// Vrai si les coordonnées tombent dans la grande boîte englobante de
  /// l'Afrique de l'Ouest (secours quand le géocodage inverse échoue).
  static bool coordsInWestAfrica(double lat, double lng) {
    return lat >= 3.5 && lat <= 25.0 && lng >= -18.0 && lng <= 5.0;
  }
}
