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
    Disease('Limaces', "Pièges à bière, cendres, coquilles d'œufs broyées"),
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
    Disease("Mouche de l'oignon", "Filet anti-insectes, associer avec la carotte"),
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
    Disease('Altise', "Filet anti-insectes, arrosage fréquent (les altises détestent l'humidité)"),
  ],
  'piment': [
    Disease('Pucerons', "Savon noir, jet d'eau puissant"),
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
  'ail': [
    Disease('Rouille', 'Décoction de prêle préventive, supprimer et brûler les feuilles atteintes'),
    Disease('Pourriture blanche (sclérotinia)', 'Rotation longue (5 ans), éviter sols trop humides, paillage léger'),
    Disease('Mouche de l\'ail', 'Filet anti-insectes au printemps, biner souvent autour des plants'),
  ],
  'amarante': [
    Disease('Pucerons', 'Savon noir dilué, jet d\'eau, favoriser les coccinelles'),
    Disease('Chenilles défoliatrices', 'Bacillus thuringiensis, ramassage manuel le soir'),
    Disease('Cercosporiose (taches foliaires)', 'Rotation, supprimer les feuilles atteintes, éviter l\'arrosage du feuillage'),
  ],
  'arachide': [
    Disease('Cercosporiose', 'Rotation 3-4 ans, variétés résistantes, éviter excès d\'humidité'),
    Disease('Rosette de l\'arachide', 'Lutter contre les pucerons vecteurs au savon noir, semis précoce'),
    Disease('Iules et termites', 'Cendres au sol, paillage léger, ne pas planter sur sols infestés'),
  ],
  'artichaut': [
    Disease('Pucerons noirs', 'Pulvériser du savon noir, attirer les coccinelles'),
    Disease('Oïdium', 'Décoction de prêle, lait dilué (10%), espacement suffisant'),
    Disease('Vers blancs (hannetons)', 'Travail du sol au printemps, ramassage des larves'),
  ],
  'asperge': [
    Disease('Criocère de l\'asperge', 'Ramassage manuel des adultes et larves, pyrèthre naturel en dernier recours'),
    Disease('Rouille de l\'asperge', 'Couper et brûler les tiges en automne, éviter excès d\'azote'),
    Disease('Mouche de l\'asperge', 'Filet anti-insectes au moment de la pousse, rotation des planches'),
  ],
  'basilic': [
    Disease('Fusariose', 'Rotation, ne pas replanter sur même emplacement, semis sain'),
    Disease('Pucerons', 'Savon noir dilué, jet d\'eau'),
    Disease('Limaces', 'Pièges à bière, cendres autour des plants'),
  ],
  'betterave': [
    Disease('Cercosporiose', 'Rotation 3-4 ans, supprimer les feuilles atteintes, décoction de prêle'),
    Disease('Pucerons noirs', 'Savon noir, favoriser les coccinelles'),
    Disease('Mouche de la betterave', 'Filet anti-insectes, supprimer les feuilles minées'),
  ],
  'bissap': [
    Disease('Pucerons', 'Savon noir, purin d\'ortie en pulvérisation'),
    Disease('Cochenilles', 'Huile de neem, alcool à brûler dilué sur tige'),
    Disease('Nématodes à galles', 'Rotation avec œillets d\'Inde (Tagetes), apports de compost mûr'),
  ],
  'blette': [
    Disease('Cercosporiose', 'Rotation, ne pas mouiller le feuillage, supprimer les feuilles atteintes'),
    Disease('Mineuse de la betterave/blette', 'Filet anti-insectes, retirer les feuilles minées'),
    Disease('Limaces', 'Pièges à bière, cendres, coquilles d\'œufs broyées'),
  ],
  'brocoli': [
    Disease('Piéride du chou', 'Filet anti-insectes, Bacillus thuringiensis, ramassage des chenilles'),
    Disease('Altise', 'Filet anti-insectes, arrosage fréquent, paillage'),
    Disease('Hernie du chou', 'Rotation longue (7 ans), chauler le sol si trop acide'),
  ],
  'celeri': [
    Disease('Septoriose', 'Rotation 3 ans, éviter d\'arroser le feuillage, bouillie bordelaise préventive'),
    Disease('Mouche du céleri', 'Filet anti-insectes, supprimer les feuilles minées'),
    Disease('Limaces', 'Pièges à bière, cendres autour des plants'),
  ],
  'chou_bruxelles': [
    Disease('Piéride du chou', 'Filet anti-insectes, Bacillus thuringiensis, ramassage des chenilles'),
    Disease('Pucerons cendrés', 'Savon noir, jet d\'eau, attirer les coccinelles'),
    Disease('Hernie du chou', 'Rotation longue (7 ans), chaulage si sol acide'),
  ],
  'chou_fleur': [
    Disease('Piéride du chou', 'Filet anti-insectes, Bacillus thuringiensis'),
    Disease('Hernie du chou', 'Rotation longue (7 ans), chaulage si sol acide'),
    Disease('Altise', 'Filet, arrosage fréquent, paillage'),
  ],
  'chou_kale': [
    Disease('Piéride du chou', 'Filet anti-insectes, Bacillus thuringiensis, ramassage manuel'),
    Disease('Pucerons cendrés', 'Savon noir, jet d\'eau puissant'),
    Disease('Altise', 'Filet anti-insectes, paillage et arrosage fréquent'),
  ],
  'ciboulette': [
    Disease('Rouille', 'Couper les feuilles atteintes, décoction de prêle, éviter excès d\'azote'),
    Disease('Mildiou', 'Rotation, espacement suffisant, ne pas mouiller le feuillage'),
    Disease('Thrips', 'Plaquettes bleues collantes, jet d\'eau régulier'),
  ],
  'coriandre': [
    Disease('Pucerons', 'Savon noir dilué, jet d\'eau'),
    Disease('Oïdium', 'Lait dilué, espacement entre plants, aération'),
    Disease('Fonte des semis', 'Semis clair, terre saine, éviter excès d\'humidité'),
  ],
  'echalote': [
    Disease('Mildiou', 'Bouillie bordelaise préventive, rotation 4 ans minimum'),
    Disease('Mouche de l\'oignon', 'Filet anti-insectes, association avec carotte'),
    Disease('Pourriture blanche', 'Rotation longue, éviter sols trop humides'),
  ],
  'endive': [
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
    Disease('Pourriture grise (Botrytis)', 'Aérer, éviter humidité stagnante au forçage, retirer feuilles atteintes'),
    Disease('Limaces', 'Pièges à bière, cendres'),
  ],
  'fenouil': [
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
    Disease('Mouche de la carotte', 'Filet anti-insectes (même famille Apiacées)'),
    Disease('Sclérotinia', 'Rotation, espacement, éviter excès d\'arrosage'),
  ],
  'feve': [
    Disease('Pucerons noirs', 'Pincer les extrémités fleuries, savon noir, attirer coccinelles'),
    Disease('Rouille de la fève', 'Décoction de prêle, supprimer les feuilles atteintes, rotation'),
    Disease('Bruche de la fève', 'Récolte rapide, séchage et stockage hermétique au congélateur 48h'),
  ],
  'gingembre': [
    Disease('Pourriture du rhizome (Pythium)', 'Drainage soigné, rhizomes sains, éviter excès d\'eau'),
    Disease('Cochenilles', 'Huile de neem, savon noir'),
    Disease('Nématodes', 'Rotation, apports de matière organique, plantation d\'œillets d\'Inde'),
  ],
  'mache': [
    Disease('Mildiou', 'Aérer, semis clair, éviter d\'arroser le feuillage'),
    Disease('Pourriture grise (Botrytis)', 'Espacement, ne pas pailler trop près du collet'),
    Disease('Limaces', 'Pièges à bière, cendres autour des planches'),
  ],
  'menthe': [
    Disease('Rouille de la menthe', 'Couper et brûler les tiges atteintes, décoction de prêle, diviser les touffes'),
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
    Disease('Oïdium', 'Aérer, lait dilué, éviter excès d\'azote'),
  ],
  'navet': [
    Disease('Altise', 'Filet anti-insectes, arrosage fréquent, paillage'),
    Disease('Mouche du navet/chou', 'Filet anti-insectes, collerette en carton autour du collet'),
    Disease('Hernie du chou', 'Rotation longue (5-7 ans), chaulage si sol acide'),
  ],
  'oseille': [
    Disease('Rouille', 'Couper et brûler les feuilles atteintes, décoction de prêle'),
    Disease('Limaces et escargots', 'Pièges à bière, cendres autour des touffes'),
    Disease('Pucerons', 'Savon noir dilué'),
  ],
  'pasteque': [
    Disease('Oïdium', 'Lait dilué (10%), soufre, bicarbonate de soude en pulvérisation'),
    Disease('Fusariose', 'Rotation 4 ans minimum, variétés résistantes, greffage'),
    Disease('Pucerons', 'Savon noir, attirer les coccinelles'),
  ],
  'persil': [
    Disease('Mouche de la carotte', 'Filet anti-insectes, association avec poireau/oignon'),
    Disease('Septoriose', 'Rotation, espacement suffisant, éviter d\'arroser le feuillage'),
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
  ],
  'petit_pois': [
    Disease('Oïdium', 'Lait dilué, semer tôt, variétés résistantes'),
    Disease('Tordeuse du pois', 'Filet anti-insectes à la floraison, rotation'),
    Disease('Pucerons verts', 'Savon noir, coccinelles'),
  ],
  'poireau': [
    Disease('Teigne du poireau', 'Filet anti-insectes (mailles fines), couper les feuilles atteintes'),
    Disease('Mouche mineuse du poireau', 'Filet anti-insectes en avril-mai et septembre-octobre'),
    Disease('Rouille du poireau', 'Décoction de prêle, supprimer les feuilles atteintes, rotation'),
  ],
  'potimarron': [
    Disease('Oïdium', 'Lait dilué (10%), bicarbonate de soude, soufre'),
    Disease('Mildiou', 'Bouillie bordelaise préventive, ne pas mouiller le feuillage'),
    Disease('Pucerons', 'Savon noir, attirer les coccinelles'),
  ],
  'roquette': [
    Disease('Altise', 'Filet anti-insectes, arrosage régulier, paillage'),
    Disease('Limaces', 'Pièges à bière, cendres'),
    Disease('Mildiou', 'Aérer, ne pas arroser le feuillage'),
  ],
  'sesame': [
    Disease('Flétrissement bactérien', 'Rotation 3 ans, semences saines, drainage du sol'),
    Disease('Cercosporiose', 'Espacement, supprimer les feuilles atteintes, éviter excès d\'humidité'),
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
  ],
  'sorgho': [
    Disease('Charbon couvert du sorgho', 'Semences traitées à l\'eau chaude, rotation 3 ans'),
    Disease('Pucerons des panicules', 'Savon noir au stade épiaison, attirer les auxiliaires'),
    Disease('Foreuse des tiges', 'Détruire les chaumes après récolte, Bacillus thuringiensis'),
  ],
  'taro': [
    Disease('Mildiou du taro (Phytophthora)', 'Drainage du sol, rotation 3 ans, plants sains'),
    Disease('Pourriture du corme', 'Éviter blessures à la plantation, sol bien drainé'),
    Disease('Pucerons', 'Savon noir, jet d\'eau'),
  ],
  'thym': [
    Disease('Pourriture racinaire', 'Sol très drainant, éviter arrosage excessif, butter légèrement'),
    Disease('Cochenilles', 'Huile de neem, alcool à brûler dilué au coton-tige'),
    Disease('Araignées rouges', 'Brumisations régulières (préfèrent l\'air sec)'),
  ],
};

/// Représente une maladie ou un ravageur avec son remède bio.
class Disease {
  final String name;
  final String remedy;
  const Disease(this.name, this.remedy);
}
