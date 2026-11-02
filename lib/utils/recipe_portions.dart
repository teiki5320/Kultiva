/// Adapter les quantités d'une recette au nombre de convives.
///
/// Les ingrédients sont des chaînes écrites à la main (« 4 tomates
/// mûres », « 1/2 botte de persil », « 200 g de farine ») : il n'y a
/// pas de modèle structuré derrière, et en inventer un aurait voulu
/// dire réécrire les 369 recettes. On met donc à l'échelle **le nombre
/// de tête**, s'il y en a un, et on laisse le reste intact.
///
/// Ce choix a une conséquence assumée : « sel, poivre » ne bouge pas,
/// ce qui est juste, et « 1 gousse d'ail » pour 8 personnes donnera
/// « 2 gousses », ce qui est à peu près juste. Une ligne sans nombre
/// n'est jamais touchée — mieux vaut ne rien dire que multiplier une
/// pincée par trois.
library;

import '../data/ui_i18n.dart';
import 'months.dart';

/// Met à l'échelle une liste d'ingrédients écrite pour [from] personnes
/// afin de nourrir [to] personnes.
List<String> scaleIngredients(
  List<String> ingredients,
  int from,
  int to,
) {
  if (from <= 0 || to <= 0 || from == to) return ingredients;
  final facteur = to / from;
  return ingredients
      .map((i) => _scaleLigne(i, facteur))
      .toList(growable: false);
}

/// Nombre entier, décimal (`1,5` ou `1.5`) ou fraction (`1/2`) en tête
/// de ligne, éventuellement après une puce.
final RegExp _tete = RegExp(r'^(\s*)(\d+)\s*/\s*(\d+)|^(\s*)(\d+(?:[.,]\d+)?)');

String _scaleLigne(String ligne, double facteur) {
  final m = _tete.firstMatch(ligne);
  if (m == null) return ligne;

  // Cas fraction : « 1/2 botte ».
  if (m.group(2) != null && m.group(3) != null) {
    final num = int.parse(m.group(2)!);
    final den = int.parse(m.group(3)!);
    if (den == 0) return ligne;
    final valeur = (num / den) * facteur;
    return '${m.group(1)}${_joli(valeur)}${ligne.substring(m.end)}';
  }

  final brut = m.group(5)!.replaceAll(',', '.');
  final valeur = (double.tryParse(brut) ?? 0) * facteur;
  if (valeur <= 0) return ligne;
  return '${m.group(4)}${_joli(valeur)}${ligne.substring(m.end)}';
}

/// Écrit un nombre comme on l'écrirait à la main : pas de `2.0`, pas de
/// `1.3333333`, et les demis en fraction parce qu'une cuisine
/// française compte en demis.
String _joli(double v) {
  final arrondi = (v * 2).round() / 2;
  if (arrondi >= 1 && arrondi == arrondi.roundToDouble()) {
    return arrondi.round().toString();
  }
  if (arrondi == 0.5) return '1/2';
  if (arrondi > 1 && (arrondi - arrondi.floor()) == 0.5) {
    return '${arrondi.floor()} 1/2';
  }
  // En dessous du demi, on ne prétend pas à la précision.
  if (arrondi < 0.5) return '1/2';
  return arrondi.toStringAsFixed(1).replaceAll('.', ',');
}

/// « le 3 nov. », ou « aujourd'hui » / « hier » quand c'est tout frais.
String dateCourte(DateTime quand) {
  final today = DateTime.now();
  final jours = DateTime(today.year, today.month, today.day)
      .difference(DateTime(quand.year, quand.month, quand.day))
      .inDays;
  if (jours == 0) return trUi('aujourd\'hui');
  if (jours == 1) return trUi('hier');
  // Le mois **long**, et pas l'abrégé : la table abrégée est sans
  // point final, parce qu'elle sert la barre de douze mois de la fiche
  // légume, où chaque cellule fait 24 px. « le 3 nov » n'est pas du
  // français ; « le 3 novembre » l'est, et la place ne manque pas ici.
  return trUiArgs('le {0} {1}',
      <Object?>[quand.day, monthNamesLong[quand.month - 1]]);
}
