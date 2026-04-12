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
