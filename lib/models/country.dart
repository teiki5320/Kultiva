import 'region_data.dart';

/// Zone climatique, pour affiner saisons et conseils.
///
/// Un même pays chevauche souvent plusieurs zones (le nord de la Côte
/// d'Ivoire est soudanien, Abidjan guinéen ; la Casamance est plus
/// humide que Dakar). La zone se raffine par latitude quand le GPS est
/// disponible ([Country.zoneAt]) ou par choix manuel de sous-zone.
enum ClimateZone {
  /// Climat tempéré à quatre saisons (France métropolitaine).
  temperate,

  /// Sahel : saison des pluies courte (juin-septembre), harmattan marqué.
  sahel,

  /// Zone soudanienne : saison des pluies de mai à octobre.
  sudan,

  /// Côte guinéenne : climat humide, deux pics de pluies.
  guinean;

  /// Libellé court de la sous-zone (sélecteur manuel).
  String get label {
    switch (this) {
      case ClimateZone.temperate:
        return 'Tempéré';
      case ClimateZone.sahel:
        return 'Sahel (plus sec)';
      case ClimateZone.sudan:
        return 'Soudanien (centre)';
      case ClimateZone.guinean:
        return 'Guinéen (plus humide)';
    }
  }

  /// Description courte de la sous-zone.
  String get description {
    switch (this) {
      case ClimateZone.temperate:
        return 'Quatre saisons européennes.';
      case ClimateZone.sahel:
        return 'Saison des pluies courte (juin-sept), harmattan marqué.';
      case ClimateZone.sudan:
        return 'Saison des pluies de mai/juin à octobre.';
      case ClimateZone.guinean:
        return 'Climat humide, deux saisons des pluies.';
    }
  }

  /// Sous-zones proposées au choix manuel en Afrique de l'Ouest, du plus
  /// sec au plus humide.
  static const List<ClimateZone> westAfricanZones = <ClimateZone>[
    ClimateZone.sahel,
    ClimateZone.sudan,
    ClimateZone.guinean,
  ];

  /// Retrouve une zone par son nom d'enum (persistance/sync).
  static ClimateZone? fromName(String? name) {
    if (name == null) return null;
    for (final z in values) {
      if (z.name == name) return z;
    }
    return null;
  }
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

  /// Liste des pays pour les sélecteurs : le pays suggéré (détecté ou
  /// déduit de la langue du téléphone) en premier, puis tous les autres
  /// par ordre alphabétique — la France n'est PAS privilégiée : un
  /// utilisateur sénégalais doit arriver sur une appli sénégalaise.
  static List<Country> ordered({Country? first}) {
    String key(Country c) => c.label
        .toLowerCase()
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ô', 'o');
    final rest = List<Country>.from(values)
      ..sort((a, b) => key(a).compareTo(key(b)));
    if (first == null) return rest;
    return <Country>[first, ...rest.where((c) => c != first)];
  }

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

  /// Affine la zone climatique du pays selon la latitude (Nord = plus
  /// sec, Sud = plus humide). Retourne la zone par défaut du pays si la
  /// latitude est nulle. Les bandes suivent la géographie réelle de
  /// chaque pays (le gradient AO va du sahélien au nord au guinéen sur
  /// la côte).
  ClimateZone zoneAt(double? latitude) {
    if (latitude == null || !isWestAfrica) return zone;
    switch (this) {
      case Country.senegal:
        // Casamance (sud, < 13,3°N) nettement plus humide que Dakar.
        return latitude < 13.3 ? ClimateZone.sudan : ClimateZone.sahel;
      case Country.mali:
        // Sud (Bamako 12,6°N, Sikasso) soudanien ; nord sahélo-saharien.
        return latitude < 14.0 ? ClimateZone.sudan : ClimateZone.sahel;
      case Country.niger:
        // Extrême sud-ouest (Gaya) un peu soudanien, reste sahélien.
        return latitude < 12.5 ? ClimateZone.sudan : ClimateZone.sahel;
      case Country.burkinaFaso:
        // Nord (Dori, > 13,5°N) sahélien ; centre-sud soudanien.
        return latitude > 13.5 ? ClimateZone.sahel : ClimateZone.sudan;
      case Country.coteDivoire:
        // Nord (Korhogo, > 8°N) soudanien ; sud forestier guinéen.
        return latitude > 8.0 ? ClimateZone.sudan : ClimateZone.guinean;
      case Country.benin:
        // Nord (Natitingou, > 9°N) soudanien ; sud côtier guinéen.
        return latitude > 9.0 ? ClimateZone.sudan : ClimateZone.guinean;
      case Country.togo:
        // Nord (Dapaong, > 9°N) soudanien ; sud côtier guinéen.
        return latitude > 9.0 ? ClimateZone.sudan : ClimateZone.guinean;
      case Country.guinee:
        // Haute-Guinée (est/nord, > 10,5°N) soudanienne ; reste guinéen.
        return latitude > 10.5 ? ClimateZone.sudan : ClimateZone.guinean;
      case Country.france:
        return ClimateZone.temperate;
    }
  }
}
