/// Constantes de noms de mois en français — centralisées pour éviter
/// la duplication (précédemment définies dans 6+ fichiers).
///
/// Index 0 = janvier, 11 = décembre. Pour convertir depuis un
/// [DateTime], utiliser `monthNamesShort[date.month - 1]`.
const List<String> monthNamesShort = <String>[
  'jan',
  'fév',
  'mar',
  'avr',
  'mai',
  'juin',
  'juil',
  'août',
  'sep',
  'oct',
  'nov',
  'déc',
];

/// Version "Jan/Fév/..." pour calendriers à grille.
const List<String> monthNamesShortCap = <String>[
  'Jan',
  'Fév',
  'Mar',
  'Avr',
  'Mai',
  'Juin',
  'Juil',
  'Août',
  'Sep',
  'Oct',
  'Nov',
  'Déc',
];

/// Version longue en minuscule pour texte narratif.
const List<String> monthNamesLong = <String>[
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
];

/// Version longue capitalisée pour titres de section.
const List<String> monthNamesLongCap = <String>[
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];

/// Transforme une liste de mois en phrase lisible.
///
/// `[3, 4, 5]` → « de mars à mai », `[3, 5]` → « mars et mai »,
/// `[11, 12, 1]` → « de novembre à janvier » : les séries qui
/// enjambent le nouvel an comptent pour une, ce qui arrive tout le
/// temps en Afrique de l'Ouest où la saison sèche traverse décembre.
///
/// Sert aux lecteurs d'écran, qui ne voient pas les segments colorés
/// du calendrier annuel, et aux fiches qui résument un cycle.
String monthRangesLabel(Iterable<int> months) {
  final set = months.where((m) => m >= 1 && m <= 12).toSet();
  if (set.isEmpty) return '';
  if (set.length == 12) return "toute l'année";
  int precedent(int m) => m == 1 ? 12 : m - 1;
  int suivant(int m) => m == 12 ? 1 : m + 1;
  // Un début de série est un mois dont le précédent manque.
  final debuts = set.where((m) => !set.contains(precedent(m))).toList()..sort();
  final morceaux = <String>[];
  for (final debut in debuts) {
    var fin = debut;
    while (set.contains(suivant(fin))) {
      fin = suivant(fin);
    }
    morceaux.add(debut == fin
        ? monthNamesLong[debut - 1]
        : 'de ${monthNamesLong[debut - 1]} à ${monthNamesLong[fin - 1]}');
  }
  if (morceaux.length == 1) return morceaux.first;
  final tete = morceaux.sublist(0, morceaux.length - 1).join(', ');
  return '$tete et ${morceaux.last}';
}
