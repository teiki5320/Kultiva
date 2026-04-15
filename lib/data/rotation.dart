/// Données de rotation des cultures.
///
/// Chaque clé est un vegetableId. Les valeurs indiquent quels légumes
/// peuvent succéder dans la même parcelle la saison suivante (goodAfter)
/// et combien d'années attendre avant de remettre le même légume (waitYears).
const Map<String, RotationData> rotationMap = {
  'tomate': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'feve', 'petit_pois', 'laitue', 'epinard', 'mache'],
    family: 'Solanacées',
  ),
  'aubergine': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'feve', 'laitue', 'carotte'],
    family: 'Solanacées',
  ),
  'poivron': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'laitue', 'epinard'],
    family: 'Solanacées',
  ),
  'piment': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'laitue'],
    family: 'Solanacées',
  ),
  'pomme_de_terre': RotationData(
    waitYears: 3,
    goodAfter: ['feve', 'haricot', 'epinard', 'laitue'],
    family: 'Solanacées',
  ),
  'carotte': RotationData(
    waitYears: 3,
    goodAfter: ['chou_pomme', 'chou_fleur', 'tomate', 'poireau'],
    family: 'Apiacées',
  ),
  'celeri': RotationData(
    waitYears: 3,
    goodAfter: ['tomate', 'haricot', 'laitue'],
    family: 'Apiacées',
  ),
  'fenouil': RotationData(
    waitYears: 3,
    goodAfter: ['laitue', 'haricot'],
    family: 'Apiacées',
  ),
  'chou_pomme': RotationData(
    waitYears: 4,
    goodAfter: ['tomate', 'haricot', 'carotte', 'laitue'],
    family: 'Brassicacées',
  ),
  'chou_fleur': RotationData(
    waitYears: 4,
    goodAfter: ['tomate', 'haricot', 'carotte'],
    family: 'Brassicacées',
  ),
  'brocoli': RotationData(
    waitYears: 4,
    goodAfter: ['tomate', 'haricot', 'pomme_de_terre'],
    family: 'Brassicacées',
  ),
  'chou_kale': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'carotte', 'tomate'],
    family: 'Brassicacées',
  ),
  'chou_bruxelles': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'tomate', 'carotte'],
    family: 'Brassicacées',
  ),
  'navet': RotationData(
    waitYears: 3,
    goodAfter: ['tomate', 'haricot', 'laitue'],
    family: 'Brassicacées',
  ),
  'radis': RotationData(
    waitYears: 2,
    goodAfter: ['tomate', 'laitue', 'haricot'],
    family: 'Brassicacées',
  ),
  'roquette': RotationData(
    waitYears: 2,
    goodAfter: ['tomate', 'carotte'],
    family: 'Brassicacées',
  ),
  'haricot': RotationData(
    waitYears: 2,
    goodAfter: ['chou_pomme', 'tomate', 'carotte', 'pomme_de_terre'],
    family: 'Fabacées',
  ),
  'petit_pois': RotationData(
    waitYears: 2,
    goodAfter: ['chou_pomme', 'tomate', 'carotte'],
    family: 'Fabacées',
  ),
  'feve': RotationData(
    waitYears: 2,
    goodAfter: ['chou_pomme', 'tomate', 'pomme_de_terre'],
    family: 'Fabacées',
  ),
  'oignon': RotationData(
    waitYears: 3,
    goodAfter: ['carotte', 'tomate', 'laitue'],
    family: 'Alliacées',
  ),
  'ail': RotationData(
    waitYears: 4,
    goodAfter: ['carotte', 'tomate', 'laitue'],
    family: 'Alliacées',
  ),
  'poireau': RotationData(
    waitYears: 3,
    goodAfter: ['carotte', 'tomate', 'haricot'],
    family: 'Alliacées',
  ),
  'echalote': RotationData(
    waitYears: 3,
    goodAfter: ['carotte', 'tomate'],
    family: 'Alliacées',
  ),
  'courgette': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'oignon', 'laitue', 'epinard'],
    family: 'Cucurbitacées',
  ),
  'concombre': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'oignon', 'carotte'],
    family: 'Cucurbitacées',
  ),
  'melon': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'oignon'],
    family: 'Cucurbitacées',
  ),
  'courge_butternut': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'oignon', 'laitue'],
    family: 'Cucurbitacées',
  ),
  'potiron': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'oignon'],
    family: 'Cucurbitacées',
  ),
  'potimarron': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'oignon', 'laitue'],
    family: 'Cucurbitacées',
  ),
  'pasteque': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'mais'],
    family: 'Cucurbitacées',
  ),
  'laitue': RotationData(
    waitYears: 2,
    goodAfter: ['tomate', 'carotte', 'haricot', 'chou_pomme'],
    family: 'Astéracées',
  ),
  'epinard': RotationData(
    waitYears: 2,
    goodAfter: ['tomate', 'chou_pomme', 'carotte'],
    family: 'Chénopodiacées',
  ),
  'betterave': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'laitue', 'tomate'],
    family: 'Chénopodiacées',
  ),
  'blette': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'carotte', 'tomate'],
    family: 'Chénopodiacées',
  ),
  'amarante': RotationData(
    waitYears: 2,
    goodAfter: ['haricot', 'niebe', 'mais', 'arachide'],
    family: 'Amarantacées',
  ),
  'arachide': RotationData(
    waitYears: 3,
    goodAfter: ['mais', 'sorgho', 'manioc', 'igname'],
    family: 'Fabacées',
  ),
  'artichaut': RotationData(
    waitYears: 5,
    goodAfter: ['haricot', 'feve', 'pomme_de_terre', 'laitue'],
    family: 'Astéracées',
  ),
  'asperge': RotationData(
    waitYears: 8,
    goodAfter: ['haricot', 'feve', 'pomme_de_terre', 'tomate'],
    family: 'Asparagacées',
  ),
  'basilic': RotationData(
    waitYears: 2,
    goodAfter: ['haricot', 'laitue', 'carotte', 'epinard'],
    family: 'Lamiacées',
  ),
  'bissap': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'arachide', 'mais', 'sorgho'],
    family: 'Malvacées',
  ),
  'ciboulette': RotationData(
    waitYears: 3,
    goodAfter: ['carotte', 'tomate', 'laitue', 'fraise'],
    family: 'Alliacées',
  ),
  'coriandre': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'tomate', 'laitue', 'chou_pomme'],
    family: 'Apiacées',
  ),
  'endive': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'pomme_de_terre', 'tomate', 'carotte'],
    family: 'Astéracées',
  ),
  'fraise': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'feve', 'epinard', 'laitue'],
    family: 'Rosacées',
  ),
  'gingembre': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'niebe', 'arachide', 'patate_douce'],
    family: 'Zingibéracées',
  ),
  'gombo': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'arachide', 'mais', 'sorgho'],
    family: 'Malvacées',
  ),
  'igname': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'arachide', 'mais', 'haricot'],
    family: 'Dioscoréacées',
  ),
  'mache': RotationData(
    waitYears: 2,
    goodAfter: ['tomate', 'haricot', 'pomme_de_terre', 'courgette'],
    family: 'Valérianacées',
  ),
  'mais': RotationData(
    waitYears: 2,
    goodAfter: ['haricot', 'niebe', 'arachide', 'feve'],
    family: 'Poacées',
  ),
  'manioc': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'arachide', 'haricot', 'mais'],
    family: 'Euphorbiacées',
  ),
  'menthe': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'tomate', 'laitue'],
    family: 'Lamiacées',
  ),
  'niebe': RotationData(
    waitYears: 2,
    goodAfter: ['mais', 'sorgho', 'manioc', 'igname'],
    family: 'Fabacées',
  ),
  'oseille': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'laitue', 'carotte', 'tomate'],
    family: 'Polygonacées',
  ),
  'patate_douce': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'niebe', 'mais', 'arachide'],
    family: 'Convolvulacées',
  ),
  'persil': RotationData(
    waitYears: 3,
    goodAfter: ['haricot', 'tomate', 'chou_pomme', 'laitue'],
    family: 'Apiacées',
  ),
  'sesame': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'arachide', 'mais', 'sorgho'],
    family: 'Pédaliacées',
  ),
  'sorgho': RotationData(
    waitYears: 2,
    goodAfter: ['niebe', 'arachide', 'haricot', 'feve'],
    family: 'Poacées',
  ),
  'taro': RotationData(
    waitYears: 3,
    goodAfter: ['niebe', 'haricot', 'mais', 'arachide'],
    family: 'Aracées',
  ),
  'thym': RotationData(
    waitYears: 4,
    goodAfter: ['haricot', 'laitue', 'tomate', 'carotte'],
    family: 'Lamiacées',
  ),
};

/// Données de rotation pour un légume.
class RotationData {
  final int waitYears;
  final List<String> goodAfter;
  final String family;
  const RotationData({
    required this.waitYears,
    required this.goodAfter,
    required this.family,
  });
}
