/// Lexique des termes de jardinage utilisés dans Kultiva.
///
/// Ajoute un mot à `lexicon` pour qu'il apparaisse automatiquement souligné
/// dans les textes wrappés avec `LexiconText`. Les clés sont en minuscules,
/// sans accent pour faciliter la correspondance.
class LexiconEntry {
  final String term;
  final String definition;
  const LexiconEntry(this.term, this.definition);
}

const List<LexiconEntry> lexicon = <LexiconEntry>[
  LexiconEntry(
    'solanacées',
    "Famille botanique qui regroupe tomate, aubergine, poivron, piment, pomme de terre. Tous ces légumes sont sensibles au mildiou et partagent souvent les mêmes maladies — d'où la règle de rotation qui déconseille de les replanter au même endroit avant 3-4 ans.",
  ),
  LexiconEntry(
    'rotation',
    "Changer chaque année l'emplacement des familles de légumes pour éviter que le sol ne s'épuise et que les maladies ne s'installent. Règle générale : attendre 3 à 4 ans avant de replanter la même famille au même endroit.",
  ),
  LexiconEntry(
    'compagnonnage',
    "Associer des plantes qui s'entraident : certaines repoussent les parasites de leurs voisines, d'autres enrichissent le sol ou attirent les pollinisateurs. Exemple classique : carotte + poireau.",
  ),
  LexiconEntry(
    'mildiou',
    "Maladie fongique qui apparaît par temps humide et tiède. Provoque des taches brunes sur les feuilles et pourrit les fruits. Touche surtout tomates, pommes de terre, vignes. Traitement bio : bouillie bordelaise ou purin de prêle.",
  ),
  LexiconEntry(
    'bouillie bordelaise',
    "Fongicide à base de sulfate de cuivre et de chaux, autorisé en agriculture biologique. Utilisée contre le mildiou et d'autres maladies cryptogamiques. À doser avec modération — le cuivre s'accumule dans le sol.",
  ),
  LexiconEntry(
    'paillage',
    "Couvrir le sol au pied des plants avec de la matière organique (paille, feuilles mortes, tontes séchées). Garde l'humidité, limite les mauvaises herbes et nourrit le sol en se décomposant.",
  ),
  LexiconEntry(
    'compost',
    "Terreau obtenu par décomposition naturelle des déchets de cuisine et du jardin. Améliore la structure du sol, nourrit les plantes, et se produit en 6 à 12 mois.",
  ),
  LexiconEntry(
    'repiquage',
    "Transplanter un jeune plant de l'endroit où il a germé vers sa place définitive au potager. À faire quand le plant a 4-6 vraies feuilles, de préférence en soirée pour limiter le stress hydrique.",
  ),
  LexiconEntry(
    'levée',
    "Moment où la graine sort de terre et développe ses premières feuilles (cotylédons). Durée variable selon l'espèce (radis : 3-5 jours, carotte : 15-20 jours).",
  ),
  LexiconEntry(
    'éclaircissage',
    "Supprimer les jeunes plants en surnombre pour laisser aux restants l'espace, la lumière et les nutriments nécessaires. À faire dès que les plants ont 2-3 vraies feuilles.",
  ),
  LexiconEntry(
    'buttage',
    "Ramener de la terre au pied des plants pour former une petite butte. Favorise l'enracinement (tomates), protège les tubercules de la lumière (pommes de terre) ou améliore le drainage.",
  ),
  LexiconEntry(
    'vivace',
    "Plante qui vit plusieurs années, au contraire d'une annuelle (cycle complet en une saison). Exemples au potager : rhubarbe, artichaut, asperge, ciboulette.",
  ),
  LexiconEntry(
    'annuelle',
    "Plante qui accomplit tout son cycle (germination, floraison, production de graines, mort) en une seule année. La plupart des légumes sont annuels : tomate, courgette, laitue.",
  ),
  LexiconEntry(
    'bisannuelle',
    "Plante dont le cycle s'étale sur deux ans : la première année, elle développe ses feuilles et racines, la seconde elle fleurit et produit des graines. Exemples : carotte, betterave, oignon porte-graine.",
  ),
  LexiconEntry(
    'godet',
    "Petit pot individuel (souvent en plastique ou tourbe) pour faire germer et élever un jeune plant avant de le repiquer en pleine terre. Taille typique : 7 à 10 cm.",
  ),
  LexiconEntry(
    'terreau',
    "Substrat cultivé prêt à l'emploi, mélange de matière organique décomposée, de fibres et parfois de minéraux. À distinguer de la terre du jardin : il est plus léger, plus riche et plus stérile.",
  ),
  LexiconEntry(
    'hors-gel',
    "Période sans risque de gelée nocturne. En France, on parle souvent de \"saints de glace\" (mi-mai) comme repère pour planter les légumes fragiles (tomate, courgette) dehors.",
  ),
  LexiconEntry(
    'semis direct',
    "Semer directement les graines en pleine terre, sans passer par un semis en godet. Idéal pour radis, carottes, haricots et toutes les plantes qui n'aiment pas être repiquées.",
  ),
  LexiconEntry(
    'drainage',
    "Capacité du sol à évacuer l'excès d'eau. Un bon drainage évite que les racines pourrissent. On l'améliore avec du sable grossier, des billes d'argile ou en travaillant la terre en profondeur.",
  ),
  LexiconEntry(
    'pollinisateurs',
    "Insectes (abeilles, bourdons, papillons, syrphes) qui transportent le pollen d'une fleur à l'autre et permettent aux plantes de produire des fruits et graines. Essentiels au potager — à protéger absolument.",
  ),
];

/// Normalise un mot pour la recherche dans le lexique : minuscules et sans
/// accents simples. Permet d'ignorer la casse et les variations diacritiques.
String _normalize(String s) {
  return s
      .toLowerCase()
      .replaceAll(RegExp(r'[àâä]'), 'a')
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[îï]'), 'i')
      .replaceAll(RegExp(r'[ôö]'), 'o')
      .replaceAll(RegExp(r'[ûüù]'), 'u')
      .replaceAll('ç', 'c');
}

/// Cherche une entrée par terme (matching insensible à la casse / aux accents).
LexiconEntry? lookupLexicon(String term) {
  final needle = _normalize(term);
  for (final e in lexicon) {
    if (_normalize(e.term) == needle) return e;
  }
  return null;
}
