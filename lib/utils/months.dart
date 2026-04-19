/// Constantes de noms de mois en français — centralisées pour éviter
/// la duplication (précédemment définies dans 6+ fichiers).
///
/// Index 0 = janvier, 11 = décembre. Pour convertir depuis un
/// [DateTime], utiliser `monthNamesShort[date.month - 1]`.
const List<String> monthNamesShort = <String>[
  'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
  'juil', 'août', 'sep', 'oct', 'nov', 'déc',
];

/// Version "Jan/Fév/..." pour calendriers à grille.
const List<String> monthNamesShortCap = <String>[
  'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
  'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc',
];

/// Version longue en minuscule pour texte narratif.
const List<String> monthNamesLong = <String>[
  'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
  'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
];

/// Version longue capitalisée pour titres de section.
const List<String> monthNamesLongCap = <String>[
  'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
  'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre',
];
