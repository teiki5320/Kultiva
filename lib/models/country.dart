import '../data/ui_i18n.dart';
import 'region_data.dart';

/// Le lieu à afficher au-dessus d'un calendrier : le pays choisi,
/// sinon la zone de calcul.
///
/// ⚠️ Ces titres affichaient `Region.label`, qui vaut « France » pour
/// la base tempérée : un jardinier allemand lisait « Semis — France »,
/// et le PDF s'intitulait « Calendrier — France ». Le pays est ce
/// qu'il a choisi à l'installation, donc ce qu'il reconnaît. Le repli
/// sur la région sert à qui n'a jamais passé l'onboarding.
String placeLabelFor(Region region, Country? country) =>
    country?.displayLabel ?? region.displayLabel;

/// Le drapeau du pays choisi, sinon l'emoji de la région.
String placeEmojiFor(Region region, Country? country) =>
    country?.flag ?? region.emoji;

/// Zone climatique, pour affiner saisons et conseils.
///
/// Un même pays chevauche souvent plusieurs zones (le nord de la Côte
/// d'Ivoire est soudanien, Abidjan guinéen ; la Casamance est plus
/// humide que Dakar). La zone se raffine par latitude quand le GPS est
/// disponible ([Country.zoneAt]) ou par choix manuel de sous-zone.
enum ClimateZone {
  /// Climat océanique tempéré, quatre saisons douces (France
  /// métropolitaine, Belgique, Royaume-Uni, Nouvelle-Zélande).
  /// C'est la **base tempérée** dont les autres zones dérivent.
  temperate,

  /// Sahel : saison des pluies courte (juin-septembre), harmattan
  /// marqué. Couvre aussi les climats arides et semi-arides du reste du
  /// monde.
  sahel,

  /// Zone soudanienne : saison des pluies de mai à octobre. Couvre les
  /// climats tropicaux à saison sèche marquée, partout.
  sudan,

  /// Côte guinéenne : climat humide, deux pics de pluies. Couvre les
  /// climats tropicaux humides et équatoriaux.
  guinean,

  // ─── Ajoutées le 01/11/2026 pour la couverture mondiale ───
  //
  // Les quatre premières valeurs gardent leur nom ouest-africain : il
  // est écrit dans les préférences des utilisateurs existants, et le
  // renommer leur ferait perdre leur zone. Leur sens, lui, s'élargit —
  // `sudan` veut dire « tropical à saison sèche », pas « Soudan ».

  /// Climat méditerranéen : été chaud et sec, hiver doux et pluvieux.
  /// Espagne, Italie, Grèce, Maghreb, Californie, Chili central, Cap.
  mediterranean,

  /// Climat continental : hiver froid, été chaud, saison de culture
  /// courte. Europe centrale et de l'Est, Canada, nord des États-Unis.
  continental,

  /// Climat subtropical humide : saison longue, étés lourds. Sud-est
  /// des États-Unis, Japon, sud du Brésil, nord de l'Argentine.
  subtropical,

  /// Tropical d'altitude : doux toute l'année, rythmé par les pluies.
  /// Andes, hauts plateaux éthiopiens, Rwanda, Kenya, Mexique central.
  highland,

  // ─── Ajoutée le 02/11/2026 ───

  /// Tropical à hiver frais : mousson d'été, puis une saison sèche et
  /// fraîche où l'on cultive les légumes tempérés. Plaine du Gange,
  /// nord du Viêt Nam, nord de la Birmanie, nord de la Thaïlande.
  ///
  /// ⚠️ **C'est la seule zone tropicale où le chou et la carotte
  /// poussent**, et c'est pour ça qu'elle existe. Les huit autres
  /// n'avaient pas d'hiver : Hanoï cultive chou et carotte en décembre
  /// à 16 °C, et le maraîchage de Delhi est le *rabi*, de novembre à
  /// mars. Le calendrier guinéen comme le soudanien ignoraient cette
  /// saison entière — la moitié de l'année agricole de deux pays qui
  /// pèsent un milliard et demi d'habitants.
  coolWinter;

  /// Vrai pour les zones dont le calendrier suit les pluies plutôt que
  /// les saisons thermiques.
  bool get isTropical =>
      this == ClimateZone.sahel ||
      this == ClimateZone.sudan ||
      this == ClimateZone.guinean ||
      this == ClimateZone.highland ||
      this == ClimateZone.coolWinter;

  /// Libellé court de la sous-zone (sélecteur manuel).
  String get label {
    switch (this) {
      case ClimateZone.temperate:
        return trUi('Tempéré');
      case ClimateZone.sahel:
        return trUi('Sahel (plus sec)');
      case ClimateZone.sudan:
        return trUi('Soudanien (centre)');
      case ClimateZone.guinean:
        return trUi('Guinéen (plus humide)');
      case ClimateZone.mediterranean:
        return trUi('Méditerranéen');
      case ClimateZone.continental:
        return trUi('Continental');
      case ClimateZone.subtropical:
        return trUi('Subtropical humide');
      case ClimateZone.highland:
        return trUi('Tropical d\'altitude');
      case ClimateZone.coolWinter:
        return trUi('Tropical à hiver frais');
    }
  }

  /// Description courte de la sous-zone.
  String get description {
    switch (this) {
      case ClimateZone.temperate:
        return trUi('Quatre saisons européennes.');
      case ClimateZone.sahel:
        return trUi(
            'Saison des pluies courte (juin-sept), harmattan marqué.');
      case ClimateZone.sudan:
        return trUi('Saison des pluies de mai/juin à octobre.');
      case ClimateZone.guinean:
        return trUi('Climat humide, deux saisons des pluies.');
      case ClimateZone.mediterranean:
        return trUi('Été chaud et sec, hiver doux : on sème tôt, et aussi à '
            'l\'automne.');
      case ClimateZone.continental:
        return trUi(
            'Hiver froid, saison de culture courte : on sème plus tard.');
      case ClimateZone.subtropical:
        return trUi('Saison longue et humide, étés lourds.');
      case ClimateZone.highland:
        return trUi('Doux toute l\'année, rythmé par les pluies.');
      case ClimateZone.coolWinter:
        return trUi('Mousson d\'été, hiver sec et frais : les légumes '
            'tempérés poussent de novembre à mars.');
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

/// De quel côté de l'équateur, donc dans quel sens tournent les
/// saisons.
///
/// C'est le levier le plus rentable de la couverture mondiale : un
/// calendrier tempéré décalé de six mois décrit correctement
/// l'Australie, l'Afrique du Sud, l'Argentine, le Chili et la
/// Nouvelle-Zélande, sans une ligne de données nouvelle.
enum Hemisphere {
  north,
  south;

  /// Décalage à appliquer aux mois d'un calendrier écrit pour le nord.
  int get monthOffset => this == Hemisphere.south ? 6 : 0;
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
      -13.5784, 'Conakry'),
  // ─────────────────────────────────────────────────────────────
  //  Couverture mondiale — ajoutée le 01/11/2026.
  //
  //  `region` choisit la BASE de calendrier (tempérée ou tropicale),
  //  `zone` l'affine, `hemisphere` la retourne pour le sud. Le contenu
  //  ouest-africain (noms locaux, FCFA, achat au marché) reste réservé
  //  à Region.westAfrica : aucun de ces pays ne le reçoit.
  //
  //  Les coordonnées sont celles de la capitale, utilisées comme
  //  position météo de secours quand la géolocalisation est refusée.
  // ─────────────────────────────────────────────────────────────

  // ─── Europe francophone et voisine ───
  belgique('BE', 'Belgique', '🇧🇪', Region.france, ClimateZone.temperate,
      50.8503, 4.3517, 'Bruxelles'),
  suisse('CH', 'Suisse', '🇨🇭', Region.france, ClimateZone.continental,
      46.9480, 7.4474, 'Berne'),
  luxembourg('LU', 'Luxembourg', '🇱🇺', Region.france, ClimateZone.temperate,
      49.6116, 6.1319, 'Luxembourg'),
  royaumeUni('GB', 'Royaume-Uni', '🇬🇧', Region.france, ClimateZone.temperate,
      51.5072, -0.1276, 'Londres'),
  irlande('IE', 'Irlande', '🇮🇪', Region.france, ClimateZone.temperate,
      53.3498, -6.2603, 'Dublin'),
  paysBas('NL', 'Pays-Bas', '🇳🇱', Region.france, ClimateZone.temperate,
      52.3676, 4.9041, 'Amsterdam'),
  allemagne('DE', 'Allemagne', '🇩🇪', Region.france, ClimateZone.continental,
      52.5200, 13.4050, 'Berlin'),
  autriche('AT', 'Autriche', '🇦🇹', Region.france, ClimateZone.continental,
      48.2082, 16.3738, 'Vienne'),
  pologne('PL', 'Pologne', '🇵🇱', Region.france, ClimateZone.continental,
      52.2297, 21.0122, 'Varsovie'),
  tchequie('CZ', 'Tchéquie', '🇨🇿', Region.france, ClimateZone.continental,
      50.0755, 14.4378, 'Prague'),
  roumanie('RO', 'Roumanie', '🇷🇴', Region.france, ClimateZone.continental,
      44.4268, 26.1025, 'Bucarest'),
  suede('SE', 'Suède', '🇸🇪', Region.france, ClimateZone.continental,
      59.3293, 18.0686, 'Stockholm'),
  norvege('NO', 'Norvège', '🇳🇴', Region.france, ClimateZone.continental,
      59.9139, 10.7522, 'Oslo'),
  danemark('DK', 'Danemark', '🇩🇰', Region.france, ClimateZone.temperate,
      55.6761, 12.5683, 'Copenhague'),
  espagne('ES', 'Espagne', '🇪🇸', Region.france, ClimateZone.mediterranean,
      40.4168, -3.7038, 'Madrid'),
  portugal('PT', 'Portugal', '🇵🇹', Region.france, ClimateZone.mediterranean,
      38.7223, -9.1393, 'Lisbonne'),
  italie('IT', 'Italie', '🇮🇹', Region.france, ClimateZone.mediterranean,
      41.9028, 12.4964, 'Rome'),
  grece('GR', 'Grèce', '🇬🇷', Region.france, ClimateZone.mediterranean,
      37.9838, 23.7275, 'Athènes'),
  // ⚠️ Zagreb n'est pas méditerranéenne : ses pluies sont maximales en
  // juin et janvier tourne autour de 1 °C. C'est la côte dalmate qui
  // est méditerranéenne, pas l'intérieur, où vit la capitale.
  croatie('HR', 'Croatie', '🇭🇷', Region.france, ClimateZone.continental,
      45.8150, 15.9819, 'Zagreb'),
  turquie('TR', 'Turquie', '🇹🇷', Region.france, ClimateZone.mediterranean,
      39.9334, 32.8597, 'Ankara'),

  // ─── Maghreb et Proche-Orient ───
  maroc('MA', 'Maroc', '🇲🇦', Region.france, ClimateZone.mediterranean,
      34.0209, -6.8416, 'Rabat'),
  algerie('DZ', 'Algérie', '🇩🇿', Region.france, ClimateZone.mediterranean,
      36.7538, 3.0588, 'Alger'),
  tunisie('TN', 'Tunisie', '🇹🇳', Region.france, ClimateZone.mediterranean,
      36.8065, 10.1815, 'Tunis'),
  // ⚠️ L'Égypte était sahélienne, donc sur un calendrier bâti sur des
  // pluies de juin à septembre. Le Caire reçoit **25 mm par an** : il
  // n'y a pas de saison des pluies. Le maraîchage y est irrigué et
  // d'hiver (novembre-avril), ce que décrit le calendrier
  // méditerranéen — salades et choux semés à l'automne, récoltés en
  // hiver et au printemps.
  egypte('EG', 'Égypte', '🇪🇬', Region.france, ClimateZone.mediterranean,
      30.0444, 31.2357, 'Le Caire'),
  liban('LB', 'Liban', '🇱🇧', Region.france, ClimateZone.mediterranean,
      33.8938, 35.5018, 'Beyrouth'),

  // ─── Afrique hors Afrique de l'Ouest ───
  mauritanie('MR', 'Mauritanie', '🇲🇷', Region.tropical, ClimateZone.sahel,
      18.0735, -15.9582, 'Nouakchott'),
  tchad('TD', 'Tchad', '🇹🇩', Region.tropical, ClimateZone.sahel, 12.1348,
      15.0557, "N'Djaména"),
  ghana('GH', 'Ghana', '🇬🇭', Region.tropical, ClimateZone.guinean, 5.6037,
      -0.1870, 'Accra'),
  nigeria('NG', 'Nigéria', '🇳🇬', Region.tropical, ClimateZone.guinean,
      9.0765, 7.3986, 'Abuja'),
  cameroun('CM', 'Cameroun', '🇨🇲', Region.tropical, ClimateZone.guinean,
      3.8480, 11.5021, 'Yaoundé'),
  gabon('GA', 'Gabon', '🇬🇦', Region.tropical, ClimateZone.guinean, 0.4162,
      9.4673, 'Libreville'),
  congo('CG', 'Congo', '🇨🇬', Region.tropical, ClimateZone.guinean, -4.2634,
      15.2429, 'Brazzaville', Hemisphere.south),
  rdCongo('CD', 'République démocratique du Congo', '🇨🇩', Region.tropical,
      ClimateZone.guinean, -4.4419, 15.2663, 'Kinshasa', Hemisphere.south),
  rwanda('RW', 'Rwanda', '🇷🇼', Region.tropical, ClimateZone.highland,
      -1.9441, 30.0619, 'Kigali', Hemisphere.south),
  kenya('KE', 'Kenya', '🇰🇪', Region.tropical, ClimateZone.highland, -1.2921,
      36.8219, 'Nairobi', Hemisphere.south),
  ethiopie('ET', 'Éthiopie', '🇪🇹', Region.tropical, ClimateZone.highland,
      9.0320, 38.7469, 'Addis-Abeba'),
  madagascar('MG', 'Madagascar', '🇲🇬', Region.tropical, ClimateZone.sudan,
      -18.8792, 47.5079, 'Antananarivo', Hemisphere.south),
  // ⚠️ Seul le Cap est méditerranéen. Pretoria, Johannesburg et le
  // Gauteng — où vit la majorité — reçoivent leurs pluies d'octobre à
  // mars, l'inverse exact d'un été sec, avec des gelées en juin.
  afriqueDuSud('ZA', 'Afrique du Sud', '🇿🇦', Region.france,
      ClimateZone.subtropical, -25.7479, 28.2293, 'Pretoria',
      Hemisphere.south),

  // ─── Outre-mer français ───
  reunion('RE', 'La Réunion', '🇷🇪', Region.tropical, ClimateZone.sudan,
      -20.8789, 55.4481, 'Saint-Denis', Hemisphere.south),
  guadeloupe('GP', 'Guadeloupe', '🇬🇵', Region.tropical, ClimateZone.guinean,
      16.2650, -61.5510, 'Basse-Terre'),
  martinique('MQ', 'Martinique', '🇲🇶', Region.tropical, ClimateZone.guinean,
      14.6042, -61.0667, 'Fort-de-France'),
  guyane('GF', 'Guyane', '🇬🇫', Region.tropical, ClimateZone.guinean, 4.9224,
      -52.3135, 'Cayenne'),
  mayotte('YT', 'Mayotte', '🇾🇹', Region.tropical, ClimateZone.sudan,
      -12.7806, 45.2278, 'Mamoudzou', Hemisphere.south),
  // ⚠️ La Nouvelle-Calédonie était sur la base tempérée : un
  // calendrier européen retourné de six mois, pour une île à 22° sud
  // dont la saison des pluies va de décembre à mars. Base tropicale,
  // zone soudanienne (une seule saison des pluies, pas deux).
  nouvelleCaledonie('NC', 'Nouvelle-Calédonie', '🇳🇨', Region.tropical,
      ClimateZone.sudan, -22.2758, 166.4580, 'Nouméa', Hemisphere.south),
  polynesieFrancaise('PF', 'Polynésie française', '🇵🇫', Region.tropical,
      ClimateZone.guinean, -17.5516, -149.5585, 'Papeete', Hemisphere.south),

  // ─── Amériques ───
  canada('CA', 'Canada', '🇨🇦', Region.france, ClimateZone.continental,
      45.4215, -75.6972, 'Ottawa'),
  etatsUnis('US', 'États-Unis', '🇺🇸', Region.france, ClimateZone.subtropical,
      38.9072, -77.0369, 'Washington'),
  mexique('MX', 'Mexique', '🇲🇽', Region.tropical, ClimateZone.highland,
      19.4326, -99.1332, 'Mexico'),
  bresil('BR', 'Brésil', '🇧🇷', Region.tropical, ClimateZone.sudan, -15.7939,
      -47.8828, 'Brasilia', Hemisphere.south),
  argentine('AR', 'Argentine', '🇦🇷', Region.france, ClimateZone.subtropical,
      -34.6037, -58.3816, 'Buenos Aires', Hemisphere.south),
  chili('CL', 'Chili', '🇨🇱', Region.france, ClimateZone.mediterranean,
      -33.4489, -70.6693, 'Santiago', Hemisphere.south),
  perou('PE', 'Pérou', '🇵🇪', Region.tropical, ClimateZone.highland, -12.0464,
      -77.0428, 'Lima', Hemisphere.south),
  colombie('CO', 'Colombie', '🇨🇴', Region.tropical, ClimateZone.highland,
      4.7110, -74.0721, 'Bogota'),
  uruguay('UY', 'Uruguay', '🇺🇾', Region.france, ClimateZone.subtropical,
      -34.9011, -56.1645, 'Montevideo', Hemisphere.south),
  haiti('HT', 'Haïti', '🇭🇹', Region.tropical, ClimateZone.guinean, 18.5944,
      -72.3074, 'Port-au-Prince'),

  // ─── Asie ───
  japon('JP', 'Japon', '🇯🇵', Region.france, ClimateZone.subtropical,
      35.6762, 139.6503, 'Tokyo'),
  chine('CN', 'Chine', '🇨🇳', Region.france, ClimateZone.continental,
      39.9042, 116.4074, 'Pékin'),
  // ⚠️ Delhi était soudanienne, donc sur un calendrier sans hiver — le
  // *rabi*, de novembre à mars, est pourtant la saison maraîchère
  // principale du nord de l'Inde. `zoneAt` rend le soudanien au centre
  // et le guinéen au sud.
  inde('IN', 'Inde', '🇮🇳', Region.tropical, ClimateZone.coolWinter, 28.6139,
      77.2090, 'New Delhi'),
  // ⚠️ Hanoï était guinéenne, donc sans hiver — or il y fait 16 °C en
  // décembre, et on y cultive chou et carotte. Le sud (Hô Chi Minh)
  // reste guinéen, par `zoneAt`.
  vietnam('VN', 'Viêt Nam', '🇻🇳', Region.tropical, ClimateZone.coolWinter,
      21.0278, 105.8342, 'Hanoï'),
  thailande('TH', 'Thaïlande', '🇹🇭', Region.tropical, ClimateZone.sudan,
      13.7563, 100.5018, 'Bangkok'),
  indonesie('ID', 'Indonésie', '🇮🇩', Region.tropical, ClimateZone.guinean,
      -6.2088, 106.8456, 'Jakarta', Hemisphere.south),
  philippines('PH', 'Philippines', '🇵🇭', Region.tropical,
      ClimateZone.guinean, 14.5995, 120.9842, 'Manille'),

  // ─── Océanie ───
  // ⚠️ Perth et Adélaïde sont méditerranéennes, mais le sud-est —
  // Canberra, Sydney, Melbourne, où vivent les trois quarts du pays —
  // reçoit de la pluie toute l'année et gèle en juillet. `zoneAt`
  // rend le soudanien au nord de 24° S pour Darwin.
  australie('AU', 'Australie', '🇦🇺', Region.france,
      ClimateZone.subtropical, -35.2809, 149.1300, 'Canberra',
      Hemisphere.south),
  nouvelleZelande('NZ', 'Nouvelle-Zélande', '🇳🇿', Region.france,
      ClimateZone.temperate, -41.2866, 174.7756, 'Wellington',
      Hemisphere.south);

  final String isoCode;
  final String label;
  final String flag;
  final Region region;
  final ClimateZone zone;
  final double capitalLat;
  final double capitalLon;
  final String capitalName;

  /// Au nord par défaut : les neuf premiers pays y sont tous, et un
  /// paramètre optionnel évite de réécrire leurs déclarations.
  final Hemisphere hemisphere;

  const Country(this.isoCode, this.label, this.flag, this.region, this.zone,
      this.capitalLat, this.capitalLon, this.capitalName,
      [this.hemisphere = Hemisphere.north]);

  /// Le nom du pays dans la langue affichée.
  ///
  /// ⚠️ [label] est un champ d'un enum `const` : il ne peut pas
  /// appeler de fonction, donc il reste le français. C'est **ce
  /// getter** qu'il faut afficher, jamais [label]. Le tri de
  /// [ordered] et la recherche de l'onboarding passent par lui aussi,
  /// sinon un Allemand chercherait « Allemagne » pour trouver
  /// « Germany ».
  String get displayLabel => trUi(label);

  /// Le nom de la capitale dans la langue affichée — « Londres » ou
  /// « London ». Sert de nom de ville quand la géolocalisation est
  /// refusée.
  String get displayCapital => trUi(capitalName);

  /// ⚠️ Les huit pays d'Afrique de l'Ouest, et eux seuls. Depuis
  /// l'ouverture mondiale, `region == Region.westAfrica` ne suffit
  /// plus : la base tropicale est partagée, le contenu ouest-africain
  /// ne l'est pas.
  bool get isWestAfrica => region == Region.westAfrica;

  /// Vrai quand le calendrier suit les pluies. À préférer à
  /// [isWestAfrica] dès que la question est climatique.
  ///
  /// ⚠️ C'est la **zone déclarée** du pays qui tranche, pas sa région.
  /// Depuis l'ouverture mondiale, une région ne dit que le contenu
  /// (ouest-africain ou non) ; le climat est une propriété de la zone.
  /// Pour un pays qui chevauche les deux bases — Brésil, Australie —
  /// cette réponse vaut pour sa capitale : affiner demande
  /// [zoneAt] et une latitude.
  bool get isTropical => zone.isTropical;

  /// Pays francophones d'Afrique de l'Ouest proposés dans les sélecteurs.
  static List<Country> get westAfricanCountries =>
      values.where((c) => c.isWestAfrica).toList();

  /// Liste des pays pour les sélecteurs : le pays suggéré (détecté ou
  /// déduit de la langue du téléphone) en premier, puis tous les autres
  /// par ordre alphabétique — la France n'est PAS privilégiée : un
  /// utilisateur sénégalais doit arriver sur une appli sénégalaise.
  static List<Country> ordered({Country? first}) {
    String key(Country c) => c.displayLabel
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
    if (latitude == null) return zone;
    // Les grands pays étalés sur plusieurs climats, ajoutés le
    // 01/11/2026. Ailleurs, la zone du pays suffit : la Belgique n'a
    // pas de gradient qui change un calendrier de semis.
    switch (this) {
      case Country.etatsUnis:
        // Du Minnesota continental à la Floride subtropicale, en
        // passant par la Californie méditerranéenne — qu'on ne peut
        // pas distinguer par la seule latitude, d'où le choix du
        // subtropical au sud.
        if (latitude > 42.0) return ClimateZone.continental;
        return ClimateZone.subtropical;
      case Country.chine:
        if (latitude > 34.0) return ClimateZone.continental;
        return ClimateZone.subtropical;
      case Country.australie:
        // Le nord est tropical (Darwin, Cairns) : au sud de
        // l'équateur, « plus au nord » veut dire plus chaud.
        //
        // ⚠️ Le reste rendait `mediterranean`, ce qui ne vaut que pour
        // Perth et Adélaïde. Sydney, Melbourne, Canberra et Brisbane —
        // les trois quarts du pays — reçoivent de la pluie toute
        // l'année. On laisse donc retomber sur la zone déclarée
        // (subtropicale) : distinguer Perth de Sydney demanderait la
        // longitude, que `zoneAt` n'a pas.
        if (latitude > -24.0) return ClimateZone.sudan;
        break;
      case Country.bresil:
        // Amazonie humide au nord, savane au centre, sud subtropical.
        if (latitude < -22.0) return ClimateZone.subtropical;
        if (latitude > -5.0) return ClimateZone.guinean;
        return ClimateZone.sudan;
      case Country.argentine:
        if (latitude < -38.0) return ClimateZone.temperate;
        return ClimateZone.subtropical;
      case Country.chili:
        if (latitude < -38.0) return ClimateZone.temperate;
        return ClimateZone.mediterranean;
      case Country.inde:
        // La plaine indo-gangétique (Delhi, Pendjab, Uttar Pradesh) a
        // un hiver frais où poussent les légumes tempérés ; le Deccan
        // est soudanien ; le Kerala et le Tamil Nadu sont guinéens.
        if (latitude > 24.0) return ClimateZone.coolWinter;
        if (latitude > 15.0) return ClimateZone.sudan;
        return ClimateZone.guinean;
      case Country.vietnam:
        // Le nord (Hanoï, Sapa) a un hiver frais ; le sud (Hô Chi
        // Minh, delta du Mékong) n'en a pas.
        if (latitude > 16.0) return ClimateZone.coolWinter;
        return ClimateZone.guinean;
      case Country.mexique:
        if (latitude < 19.0) return ClimateZone.guinean;
        return ClimateZone.highland;
      // ⚠️ Le Maroc et l'Algérie rendaient `sahel` au sud de 31° N,
      // « parce qu'au sud de l'Atlas c'est le désert ». Vrai pour le
      // climat, faux pour le calendrier : le calendrier sahélien est
      // bâti sur des pluies de juin à septembre, et il n'en tombe pas
      // au sud de l'Atlas. Le maraîchage y est irrigué et d'hiver,
      // comme en Égypte — c'est ce que décrit le méditerranéen. Donc
      // plus d'affinage : la zone du pays suffit.
      default:
        break;
    }
    if (!isWestAfrica) return zone;
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
      default:
        return zone;
    }
  }
}
