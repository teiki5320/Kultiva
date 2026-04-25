import '../models/culture_entry.dart';

/// Quantité de nutriments à doser pour préparer une solution
/// hydroponique. Approximation à destination des cultures amateurs ;
/// les engrais commerciaux (style GHE Flora 3 parts, Canna A/B,
/// Hydro Nutri A/B) ont tous une dose recommandée autour de
/// 1–4 mL/L selon la phase. On reste sur ce socle simple : à
/// l'utilisateur d'ajuster à son matériel.
class NutrientDose {
  final double partAmL;
  final double partBmL;
  final double partCmL; // bloom / 3rd part — null si non utilisé
  final double calMagmL;
  final String regimeNote;

  const NutrientDose({
    required this.partAmL,
    required this.partBmL,
    required this.partCmL,
    required this.calMagmL,
    required this.regimeNote,
  });
}

/// Calcule les doses pour [volumeLiters] litres d'eau, selon la phase.
/// Retourne les volumes d'engrais en millilitres.
NutrientDose computeNutrientDose({
  required double volumeLiters,
  required GrowthPhase phase,
  bool useThirdPart = true,
  bool useCalMag = true,
}) {
  // Doses indicatives mL/L par phase, équilibrées sur un engrais
  // 2-parts ou 3-parts type FloraGro / FloraMicro / FloraBloom.
  late final double a;
  late final double b;
  late final double c;
  late final String note;
  switch (phase) {
    case GrowthPhase.seedling:
      a = 0.5;
      b = 0.5;
      c = 0.0;
      note = "Solution douce (EC ~0.6–1.2). N'oublie pas de rincer "
          "le substrat avant le premier remplissage.";
      break;
    case GrowthPhase.vegetative:
      a = 2.0;
      b = 1.5;
      c = 0.5;
      note = "Régime végétation (EC ~1.2–2.0). Augmente d'abord la "
          "partie A (azote) pour soutenir la croissance des feuilles.";
      break;
    case GrowthPhase.flowering:
      a = 1.5;
      b = 2.0;
      c = 1.5;
      note = "Régime floraison (EC ~1.4–2.2). Bascule sur la "
          "partie B/C (P + K) au démarrage des boutons floraux.";
      break;
    case GrowthPhase.fruiting:
      a = 1.0;
      b = 2.0;
      c = 2.5;
      note = "Régime fructification (EC ~1.8–2.6). Booste C "
          "(Bloom/PK) ; surveille le calcium pour éviter le cul noir.";
      break;
  }
  return NutrientDose(
    partAmL: a * volumeLiters,
    partBmL: b * volumeLiters,
    partCmL: useThirdPart ? c * volumeLiters : 0,
    calMagmL: useCalMag ? 0.5 * volumeLiters : 0,
    regimeNote: note,
  );
}
