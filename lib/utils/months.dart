import '../data/ui_i18n.dart';
import '../services/prefs_service.dart';

/// Les noms de mois et de jours, dans la langue affichée.
///
/// Index 0 = janvier, 11 = décembre. Pour convertir depuis un
/// [DateTime], utiliser `monthNamesShort[date.month - 1]` ;
/// pour un jour, `weekdayNamesShort[date.weekday - 1]`.
///
/// Ce sont des getters et non des `const` : la liste dépend de la
/// langue. À lire à l'usage, jamais à garder dans un champ.
///
/// ⚠️ **Ils ne passent pas par le dictionnaire de phrases**, et
/// `ui_i18n.dart` dit pourquoi : « juin » est à la fois le mois court
/// et le mois long, et « Mar » est à la fois mardi et mars. Une clé ne
/// peut pas rendre deux valeurs. Ce sont des tables indexées.
String get _langue => PrefsService.instance.effectiveLanguage;

/// « jan », « fév »… pour les grilles étroites.
List<String> get monthNamesShort => monthNamesShortIn(_langue);

/// « Jan », « Fév »… pour les calendriers à grille.
List<String> get monthNamesShortCap =>
    monthNamesShortIn(_langue).map(capitaliser).toList(growable: false);

/// « janvier », « février »… pour le texte narratif.
List<String> get monthNamesLong => monthNamesLongIn(_langue);

/// « Janvier », « Février »… pour les titres de section.
List<String> get monthNamesLongCap =>
    monthNamesLongIn(_langue).map(capitaliser).toList(growable: false);

/// « Lun », « Mar »… lundi en premier, comme `DateTime.weekday`.
List<String> get weekdayNamesShort => weekdayNamesShortIn(_langue);

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
  if (set.length == 12) return trUi("toute l'année");
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
        : trUiArgs('de {0} à {1}',
            <Object?>[monthNamesLong[debut - 1], monthNamesLong[fin - 1]]));
  }
  if (morceaux.length == 1) return morceaux.first;
  final tete = morceaux.sublist(0, morceaux.length - 1).join(', ');
  return trUiArgs('{0} et {1}', <Object?>[tete, morceaux.last]);
}
