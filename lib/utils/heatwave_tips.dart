import '../models/vegetable.dart';

/// Conseil canicule adapté à une catégorie de légume.
String heatwaveTipFor(VegetableCategory category) {
  switch (category) {
    case VegetableCategory.fruits:
      return "Tomates, courgettes, aubergines : paille épais, "
          "arrose au pied le matin, ombre les fruits exposés.";
    case VegetableCategory.leaves:
      return "Salades et épinards montent vite à la chaleur. Ombre "
          "avec un voile et arrose le soir.";
    case VegetableCategory.aromatics:
      return "Basilic, persil, ciboulette : un coup d'eau par jour "
          "à la fraîche suffit. Coupe les fleurs pour préserver les feuilles.";
    case VegetableCategory.bulbs:
      return "Oignons et ail tolèrent bien la chaleur, mais évite "
          "d'arroser les jours de canicule (favorise les maladies).";
    case VegetableCategory.tubers:
      return "Pommes de terre : paille pour garder le sol frais, "
          "n'arrose pas le feuillage en plein soleil (brûlures).";
    case VegetableCategory.roots:
      return "Carottes, radis, betteraves : arrose en profondeur "
          "tous les 2 jours pour éviter qu'ils se fendent.";
    case VegetableCategory.stems:
    case VegetableCategory.flowers:
    case VegetableCategory.seeds:
    case VegetableCategory.accessories:
      return "Arrose tôt le matin ou en soirée, jamais en plein "
          "soleil. Paille pour conserver la fraîcheur du sol.";
  }
}
