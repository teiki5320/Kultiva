/// Données de rendement et de prix marché pour le mode maraîchage
/// (Afrique de l'Ouest). Ordres de grandeur réalistes marchés urbains
/// (Dakar, Abidjan, Bamako, 2025) — à titre indicatif seulement.
class MarketInfo {
  /// Rendement moyen par plant/pied sur un cycle, en kg (prudent).
  final double yieldPerPlantKg;

  /// Prix de détail moyen au kg en francs CFA.
  final int priceFcfaPerKg;

  const MarketInfo({
    required this.yieldPerPlantKg,
    required this.priceFcfaPerKg,
  });
}

/// Clé = `Vegetable.id` du catalogue (`vegetables_base.dart`).
///
/// Rendements volontairement prudents (conditions de petit maraîchage,
/// pas de station expérimentale). Prix de détail moyens observés sur les
/// marchés urbains — ils varient fortement selon la saison et la ville.
const Map<String, MarketInfo> marketData = <String, MarketInfo>{
  // — Légumes-fruits ————————————————————————————————————————————————
  'tomate': MarketInfo(yieldPerPlantKg: 2.5, priceFcfaPerKg: 700),
  'gombo': MarketInfo(yieldPerPlantKg: 0.8, priceFcfaPerKg: 1200),
  'piment': MarketInfo(yieldPerPlantKg: 1.0, priceFcfaPerKg: 2000),
  'aubergine': MarketInfo(yieldPerPlantKg: 2.0, priceFcfaPerKg: 600),
  // Aubergine africaine (djakhatou / n'goyo).
  'aubergine_africaine': MarketInfo(yieldPerPlantKg: 1.5, priceFcfaPerKg: 800),
  'concombre': MarketInfo(yieldPerPlantKg: 3.0, priceFcfaPerKg: 500),
  'courgette': MarketInfo(yieldPerPlantKg: 3.0, priceFcfaPerKg: 800),
  // 1 à 2 fruits par pied.
  'pasteque': MarketInfo(yieldPerPlantKg: 6.0, priceFcfaPerKg: 300),
  'melon': MarketInfo(yieldPerPlantKg: 2.5, priceFcfaPerKg: 600),
  'potiron': MarketInfo(yieldPerPlantKg: 5.0, priceFcfaPerKg: 400),
  'courge_butternut': MarketInfo(yieldPerPlantKg: 4.0, priceFcfaPerKg: 600),

  // — Bulbes, racines et tubercules —————————————————————————————————
  // Par bulbe.
  'oignon': MarketInfo(yieldPerPlantKg: 0.15, priceFcfaPerKg: 500),
  // Par racine.
  'carotte': MarketInfo(yieldPerPlantKg: 0.1, priceFcfaPerKg: 600),
  'betterave': MarketInfo(yieldPerPlantKg: 0.2, priceFcfaPerKg: 700),
  'navet': MarketInfo(yieldPerPlantKg: 0.15, priceFcfaPerKg: 500),
  'radis': MarketInfo(yieldPerPlantKg: 0.03, priceFcfaPerKg: 1000),
  // Racines fraîches par pied (cycle 8-12 mois).
  'manioc': MarketInfo(yieldPerPlantKg: 3.0, priceFcfaPerKg: 300),
  // Par butte (cycle 8-10 mois).
  'igname': MarketInfo(yieldPerPlantKg: 3.0, priceFcfaPerKg: 500),
  'taro': MarketInfo(yieldPerPlantKg: 1.5, priceFcfaPerKg: 600),
  'patate_douce': MarketInfo(yieldPerPlantKg: 1.0, priceFcfaPerKg: 400),
  // Rhizomes frais par pied.
  'gingembre': MarketInfo(yieldPerPlantKg: 0.8, priceFcfaPerKg: 1500),

  // — Feuilles et salades ————————————————————————————————————————————
  // Par pomme.
  'laitue': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 1000),
  'chou_pomme': MarketInfo(yieldPerPlantKg: 1.5, priceFcfaPerKg: 500),
  // Feuilles en coupes répétées sur le cycle.
  'baselle': MarketInfo(yieldPerPlantKg: 0.8, priceFcfaPerKg: 800),
  'celosie': MarketInfo(yieldPerPlantKg: 0.5, priceFcfaPerKg: 800),
  'corete': MarketInfo(yieldPerPlantKg: 0.4, priceFcfaPerKg: 800),
  'amarante': MarketInfo(yieldPerPlantKg: 0.5, priceFcfaPerKg: 700),
  'epinard': MarketInfo(yieldPerPlantKg: 0.4, priceFcfaPerKg: 800),
  'oseille': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 800),
  // Feuilles fraîches par arbre et par an (coupes répétées).
  'moringa': MarketInfo(yieldPerPlantKg: 2.0, priceFcfaPerKg: 1500),

  // — Céréales et légumineuses ———————————————————————————————————————
  // Grain sec par pied (épis frais : compter environ le double).
  'mais': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 350),
  // Grain sec par poquet.
  'mil': MarketInfo(yieldPerPlantKg: 0.05, priceFcfaPerKg: 400),
  'sorgho': MarketInfo(yieldPerPlantKg: 0.08, priceFcfaPerKg: 350),
  // Grain décortiqué par touffe (culture très dense, valeur par plant faible).
  'fonio': MarketInfo(yieldPerPlantKg: 0.01, priceFcfaPerKg: 1200),
  // Graines sèches par plant.
  'niebe': MarketInfo(yieldPerPlantKg: 0.1, priceFcfaPerKg: 600),
  // Gousses en coque par plant.
  'arachide': MarketInfo(yieldPerPlantKg: 0.05, priceFcfaPerKg: 800),
  // Gousses fraîches par plant.
  'haricot': MarketInfo(yieldPerPlantKg: 0.5, priceFcfaPerKg: 1000),
  // Graines sèches par plant.
  'sesame': MarketInfo(yieldPerPlantKg: 0.02, priceFcfaPerKg: 1000),

  // — Aromates et boissons ———————————————————————————————————————————
  // Calices séchés par pied et par saison.
  'bissap': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 2000),
  // Tiges et feuilles par touffe et par an.
  'citronnelle': MarketInfo(yieldPerPlantKg: 0.5, priceFcfaPerKg: 1500),
  // Coupes répétées sur l'année ; vendus en bottes, prix au kg élevé.
  'menthe': MarketInfo(yieldPerPlantKg: 0.4, priceFcfaPerKg: 2000),
  'persil': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 2000),
  'basilic': MarketInfo(yieldPerPlantKg: 0.3, priceFcfaPerKg: 2000),

  // — Arbres fruitiers ———————————————————————————————————————————————
  // Fruits par arbre et par an (arbre adulte, conduite familiale).
  'papayer': MarketInfo(yieldPerPlantKg: 30.0, priceFcfaPerKg: 500),
  // Par régime (un régime par pied et par cycle).
  'bananier_plantain': MarketInfo(yieldPerPlantKg: 15.0, priceFcfaPerKg: 400),
};
