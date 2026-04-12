/// Maladies et ravageurs courants par légume, avec remèdes bio.
///
/// Clé = vegetableId, valeur = liste de (maladie, remède).
const Map<String, List<Disease>> diseaseMap = {
  'tomate': [
    Disease('Mildiou', 'Bouillie bordelaise préventive, éviter de mouiller le feuillage, tailler les gourmands'),
    Disease('Pucerons', 'Pulvériser du savon noir dilué, favoriser les coccinelles'),
    Disease('Cul noir (nécrose apicale)', "Pas une maladie — manque de calcium lié à l'arrosage irrégulier. Pailler et arroser régulièrement"),
  ],
  'carotte': [
    Disease('Mouche de la carotte', 'Filet anti-insectes, associer avec oignon/poireau, semer après mi-juin'),
    Disease('Alternariose', 'Rotation des cultures (3 ans), détruire les feuilles atteintes'),
  ],
  'courgette': [
    Disease('Oïdium', 'Pulvériser du lait dilué (10%), couper les feuilles atteintes'),
    Disease('Pucerons', 'Savon noir, coccinelles'),
  ],
  'laitue': [
    Disease('Limaces', 'Pièges à bière, cendres, coquilles d'œufs broyées'),
    Disease('Pourriture grise (Botrytis)', 'Aérer, espacement suffisant, ne pas arroser le feuillage'),
  ],
  'haricot': [
    Disease('Anthracnose', 'Ne pas toucher les plants mouillés, rotation des cultures'),
    Disease('Pucerons noirs', 'Pincer les extrémités, savon noir'),
  ],
  'aubergine': [
    Disease('Doryphore', 'Ramassage manuel, purin de tanaisie'),
    Disease('Mildiou', 'Bouillie bordelaise, aérer entre les plants'),
  ],
  'poivron': [
    Disease('Pucerons', 'Savon noir, coccinelles'),
    Disease('Pourriture apicale', "Arrosage régulier, paillage"),
  ],
  'epinard': [
    Disease('Mildiou', 'Aérer, ne pas arroser le feuillage, rotation'),
    Disease('Mineuse', 'Filet anti-insectes, supprimer les feuilles atteintes'),
  ],
  'oignon': [
    Disease('Mildiou', 'Bouillie bordelaise, rotation (4 ans minimum)'),
    Disease('Mouche de l'oignon', 'Filet anti-insectes, associer avec la carotte'),
  ],
  'pomme_de_terre': [
    Disease('Mildiou', 'Bouillie bordelaise préventive, butter les plants, variétés résistantes'),
    Disease('Doryphore', 'Ramassage manuel des larves et adultes, Bacillus thuringiensis'),
  ],
  'chou_pomme': [
    Disease('Piéride du chou', 'Filet anti-insectes, Bacillus thuringiensis, ramasser les chenilles'),
    Disease('Hernie du chou', 'Rotation longue (7 ans), chauler le sol si trop acide'),
  ],
  'concombre': [
    Disease('Oïdium', 'Lait dilué, bicarbonate de soude, variétés résistantes'),
    Disease('Pucerons', 'Savon noir, pyrèthre naturel'),
  ],
  'radis': [
    Disease('Altise', 'Filet anti-insectes, arrosage fréquent (les altises détestent l'humidité)'),
  ],
  'piment': [
    Disease('Pucerons', 'Savon noir, jet d'eau puissant'),
    Disease('Mouche blanche', 'Plaquettes jaunes engluées, savon noir'),
  ],
  'fraise': [
    Disease('Botrytis (pourriture grise)', 'Pailler, aérer, ne pas mouiller les fruits'),
    Disease('Pucerons', 'Savon noir, coccinelles'),
  ],
  'melon': [
    Disease('Oïdium', 'Soufre, lait dilué'),
    Disease('Pucerons', 'Savon noir'),
  ],
  'gombo': [
    Disease('Jassides (cicadelles)', 'Neem (huile ou purin), savon noir'),
    Disease('Fusariose', 'Rotation des cultures, variétés résistantes'),
  ],
  'patate_douce': [
    Disease('Charançon de la patate douce', 'Rotation, boutures saines, récolte rapide'),
  ],
  'manioc': [
    Disease('Mosaïque du manioc', 'Boutures certifiées saines, arracher les plants infectés'),
    Disease('Cochenilles', 'Insectes auxiliaires, huile de neem'),
  ],
  'igname': [
    Disease('Anthracnose', 'Rotation, semenceaux sains, bouillie bordelaise'),
  ],
  'niebe': [
    Disease('Bruche du niébé', 'Séchage rapide des graines, stockage hermétique, cendres'),
    Disease('Thrips', 'Huile de neem, plaquettes bleues collantes'),
  ],
  'mais': [
    Disease('Pyrale du maïs', 'Trichogrammes (guêpes parasitoïdes), Bacillus thuringiensis'),
    Disease('Charbon du maïs', 'Rotation, détruire les galles avant éclatement'),
  ],
  'courge_butternut': [
    Disease('Oïdium', 'Lait dilué, bicarbonate de soude'),
  ],
  'potiron': [
    Disease('Oïdium', 'Lait dilué, soufre'),
  ],
};

/// Représente une maladie ou un ravageur avec son remède bio.
class Disease {
  final String name;
  final String remedy;
  const Disease(this.name, this.remedy);
}
