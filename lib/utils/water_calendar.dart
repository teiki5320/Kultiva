import '../models/country.dart';

/// Mois de saison des pluies (1-12) selon la zone climatique.
///
/// Reflète le découpage utilisé par `Season.of` :
/// - sahélienne : pluies courtes juin-septembre ;
/// - guinéenne côtière : deux saisons des pluies (avril-juillet et
///   septembre-novembre) ;
/// - soudanienne (défaut AO) : pluies juin-octobre.
Set<int> rainyMonths(ClimateZone? zone) {
  switch (zone) {
    case ClimateZone.sahel:
      return const <int>{6, 7, 8, 9};
    case ClimateZone.guinean:
      return const <int>{4, 5, 6, 7, 9, 10, 11};
    case ClimateZone.sudan:
    case ClimateZone.temperate:
    case null:
      return const <int>{6, 7, 8, 9, 10};
  }
}

/// Conseil « eau » contextuel pour l'Afrique de l'Ouest.
class WaterAdvisory {
  /// Vrai si on est actuellement en saison des pluies.
  final bool raining;

  /// Jours (approx.) avant la prochaine saison des pluies. -1 si on y
  /// est déjà.
  final int daysToRain;

  /// Jours (approx.) avant la fin de la saison des pluies en cours.
  /// -1 si on est en saison sèche.
  final int daysToDry;

  const WaterAdvisory({
    required this.raining,
    required this.daysToRain,
    required this.daysToDry,
  });

  /// Emoji d'entête.
  String get emoji => raining ? '🌧️' : '☀️';

  /// Titre court de la phase.
  String get headline => raining ? 'Saison des pluies' : 'Saison sèche';

  /// Nombre de jours pertinent à afficher (fin des pluies, ou arrivée
  /// des prochaines pluies).
  int get relevantDays => raining ? daysToDry : daysToRain;

  /// Formate un délai en semaines/jours (« ~3 semaines », « ~5 jours »).
  static String humanizeDays(int days) {
    if (days < 0) return '';
    if (days <= 10) return '~$days jours';
    final weeks = (days / 7).round();
    return '~$weeks semaines';
  }

  /// Message principal à afficher.
  String get message {
    final d = relevantDays;
    if (raining) {
      if (d >= 0 && d <= 35) {
        return 'Les pluies touchent à leur fin (dans ${humanizeDays(d)}). '
            'Récolte ce qui doit l\'être et prépare la contre-saison '
            'irriguée près d\'un point d\'eau.';
      }
      return "C'est l'hivernage : profite de l'eau du ciel. Bine "
          "régulièrement (un binage vaut deux arrosages) et surveille "
          "les maladies fongiques.";
    }
    // Saison sèche.
    if (d >= 0 && d <= 35) {
      return 'Les premières pluies approchent (dans ${humanizeDays(d)}). '
          'Prépare tes billons et tes semences de niébé, maïs, gombo et '
          'arachide.';
    }
    return 'Saison sèche : chaque goutte compte. Arrose au pied tôt le '
        'matin ou en soirée, paille épais et pense à l\'ombrière.';
  }
}

/// Calcule le conseil « eau » pour une date donnée et une zone.
///
/// Parcourt l'année à venir jour par jour pour trouver les prochaines
/// bascules pluies↔sec (gère les deux saisons des pluies de la côte).
/// [now] est injectable pour les tests.
WaterAdvisory waterAdvisory(DateTime now, ClimateZone? zone) {
  final rainy = rainyMonths(zone);
  final today = DateTime(now.year, now.month, now.day);
  final nowRaining = rainy.contains(today.month);

  int toRain = -1;
  int toDry = -1;
  for (int d = 1; d <= 366; d++) {
    final day = today.add(Duration(days: d));
    final r = rainy.contains(day.month);
    if (!nowRaining && r && toRain == -1) {
      toRain = d;
      break;
    }
    if (nowRaining && !r && toDry == -1) {
      toDry = d;
      break;
    }
  }

  return WaterAdvisory(
    raining: nowRaining,
    daysToRain: toRain,
    daysToDry: toDry,
  );
}

/// Une technique d'économie ou de gestion de l'eau, avec le tuto lié.
class WaterTechnique {
  final String emoji;
  final String title;
  final String description;

  /// Fichier tuto associé (dans assets/tutos/), sans extension. Null si
  /// aucun tuto dédié.
  final String? tutoFile;

  const WaterTechnique({
    required this.emoji,
    required this.title,
    required this.description,
    this.tutoFile,
  });
}

/// Techniques d'économie d'eau mises en avant en Afrique de l'Ouest.
const List<WaterTechnique> waterTechniques = <WaterTechnique>[
  WaterTechnique(
    emoji: '🌾',
    title: 'Paillage épais',
    description:
        'Couvre le sol de paille, de feuilles ou de coques : la terre '
        'garde son humidité et tu arroses deux fois moins.',
    tutoFile: 'paillage',
  ),
  WaterTechnique(
    emoji: '🕳️',
    title: 'Zaï et demi-lunes',
    description:
        'Des cuvettes ou croissants qui captent et concentrent l\'eau '
        'de pluie au pied des plants, même sur sol pauvre.',
    tutoFile: 'jardiner_saison_seche',
  ),
  WaterTechnique(
    emoji: '🏺',
    title: 'Canari / oya enterré',
    description:
        'Une jarre en terre poreuse enterrée près des racines diffuse '
        'l\'eau lentement : zéro gaspillage, zéro évaporation.',
    tutoFile: 'jardiner_saison_seche',
  ),
  WaterTechnique(
    emoji: '⛱️',
    title: 'Ombrière',
    description:
        'Un filet d\'ombrage 30-50 % réduit la chaleur et l\'évaporation '
        'sur les cultures sensibles (laitue, chou, tomate).',
    tutoFile: 'fabriquer_ombriere',
  ),
  WaterTechnique(
    emoji: '💧',
    title: 'Arroser au pied, aux bonnes heures',
    description:
        'Arrose au pied (pas sur les feuilles) tôt le matin ou en '
        'soirée : l\'eau descend aux racines au lieu de s\'évaporer.',
    tutoFile: 'bien_arroser',
  ),
];
