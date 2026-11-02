/// Les calendriers écrits culture par culture pour les zones
/// méditerranéenne et continentale.
///
/// **Pourquoi ils existent.** `zone_shift.dart` dérive ces deux zones
/// de la base française par un décalage uniforme : un mois plus tôt au
/// sud, un mois plus tard à l'est. Pour un pommier ou une courgette,
/// c'est une bonne approximation. Pour une laitue, c'est faux de six
/// mois.
///
/// En climat méditerranéen, **l'été est la saison morte** des
/// légumes-feuilles, pas leur pic : une laitue semée en juillet à
/// Séville ou à Palerme monte en graine avant de pommer. Les salades,
/// les choux, les radis et les légumineuses s'y sèment à l'**automne**
/// et se récoltent en **hiver et au printemps** — l'inverse du rythme
/// français. Un décalage d'un mois ne pouvait pas décrire ça.
///
/// En climat continental, le problème est à l'autre bout : le sol gèle
/// de novembre à mars. Les cultures que la France récolte tout l'hiver
/// — poireau, mâche, chou pommé, panais — doivent y être **arrachées
/// avant les gelées**. Le décalage les laissait récolter en janvier,
/// sous la neige.
///
/// **Ce fichier ne remplace pas la dérivation, il la corrige là où
/// elle se trompe.** Une culture absente d'ici garde son calendrier
/// dérivé, et sa note qui dit qu'il l'est. C'est le même principe que
/// les surcouches de traduction : on recouvre ce qu'on sait, le reste
/// retombe sur la base.
///
/// ⚠️ **Ces calendriers restent des moyennes de zone.** Le climat
/// méditerranéen de Marrakech n'est pas celui de Zagreb, et un
/// continental suédois n'est pas un continental roumain. Chaque entrée
/// corrigée porte une note qui invite à ajuster sur les gelées
/// locales. Les affiner pays par pays reste à faire.
library;

import '../../models/country.dart';

/// Un calendrier écrit à la main pour une zone et une culture.
class ZoneCalendar {
  final List<int> sowing;
  final List<int> harvest;

  /// Ce qui change par rapport au rythme français, en une phrase.
  /// Affichée sous le calendrier : sans elle, un jardinier français
  /// installé en Espagne croit à une erreur.
  final String note;

  const ZoneCalendar(this.sowing, this.harvest, this.note);
}

// ───────────────────────── Méditerranéen ─────────────────────────
//
// Espagne, Portugal, Italie, Grèce, Croatie, Turquie, Maroc, Algérie,
// Tunisie, Égypte, Liban, et le sud de la France métropolitaine.
//
// Deux règles portent presque tout :
//   1. ce qui craint la chaleur se sème en automne et se récolte en
//      hiver ou au printemps ;
//   2. ce qui aime la chaleur démarre un à deux mois plus tôt et
//      produit un à deux mois plus longtemps.

const String _noteFraicheur =
    'Sous ce climat, cette culture se sème à l\'automne et se récolte '
    'en hiver : l\'été est trop chaud, elle monterait en graine. '
    'C\'est l\'inverse du calendrier français.';

const String _noteChaleur =
    'La saison chaude est longue ici : tu sèmes plus tôt et tu '
    'récoltes plus longtemps qu\'en climat tempéré. Pense à l\'ombrage '
    'et à l\'arrosage au cœur de l\'été.';

const String _noteHiver =
    'Semé à l\'automne, récolté au printemps : l\'hiver doux le permet, '
    'et la plante échappe à la sécheresse d\'été.';

const Map<String, ZoneCalendar> mediterraneanCalendar =
    <String, ZoneCalendar>{
  // ─── Légumes-feuilles : tout bascule en saison fraîche ───
  'laitue': ZoneCalendar(
      <int>[9, 10, 11, 1, 2, 3], <int>[11, 12, 1, 2, 3, 4, 5],
      _noteFraicheur),
  'epinard': ZoneCalendar(
      <int>[9, 10, 11], <int>[11, 12, 1, 2, 3], _noteFraicheur),
  'mache': ZoneCalendar(
      <int>[9, 10, 11], <int>[11, 12, 1, 2, 3], _noteFraicheur),
  'roquette': ZoneCalendar(<int>[9, 10, 11, 2, 3],
      <int>[10, 11, 12, 1, 2, 3, 4], _noteFraicheur),
  'cresson': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 1, 2, 3, 4], _noteFraicheur),
  'oseille': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[10, 11, 12, 1, 2, 3, 4, 5],
      _noteFraicheur),
  'blette': ZoneCalendar(<int>[9, 10, 2, 3],
      <int>[11, 12, 1, 2, 3, 4, 5, 6], _noteFraicheur),
  'pak_choi': ZoneCalendar(
      <int>[9, 10, 2], <int>[11, 12, 1, 2, 3, 4], _noteFraicheur),
  'chou_chinois':
      ZoneCalendar(<int>[9, 10], <int>[11, 12, 1, 2], _noteFraicheur),

  // ─── Choux : semés fin d'été, récoltés tout l'hiver ───
  'chou_pomme': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3, 4], _noteFraicheur),
  'chou_fleur':
      ZoneCalendar(<int>[8, 9], <int>[11, 12, 1, 2, 3], _noteFraicheur),
  'brocoli':
      ZoneCalendar(<int>[8, 9], <int>[11, 12, 1, 2, 3], _noteFraicheur),
  'chou_kale': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3], _noteFraicheur),
  'chou_rave': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 1, 2, 3, 4, 5], _noteFraicheur),
  'chou_bruxelles':
      ZoneCalendar(<int>[7, 8], <int>[11, 12, 1, 2], _noteFraicheur),

  // ─── Racines : la chaleur les fait fourcher et monter ───
  'radis': ZoneCalendar(<int>[9, 10, 11, 1, 2, 3],
      <int>[10, 11, 12, 1, 2, 3, 4], _noteFraicheur),
  'carotte': ZoneCalendar(<int>[9, 10, 11, 1, 2],
      <int>[12, 1, 2, 3, 4, 5], _noteFraicheur),
  'navet':
      ZoneCalendar(<int>[9, 10, 11], <int>[12, 1, 2, 3], _noteFraicheur),
  'betterave': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[12, 1, 2, 3, 5, 6], _noteFraicheur),
  'panais':
      ZoneCalendar(<int>[9, 10], <int>[1, 2, 3, 4], _noteFraicheur),
  'radis_noir':
      ZoneCalendar(<int>[9, 10], <int>[12, 1, 2, 3], _noteFraicheur),

  // ─── Légumineuses : semées à l'automne, récoltées au printemps ───
  'feve': ZoneCalendar(
      <int>[10, 11, 12], <int>[3, 4, 5], _noteHiver),
  'petit_pois':
      ZoneCalendar(<int>[10, 11, 12], <int>[3, 4, 5], _noteHiver),
  'pois_mange_tout':
      ZoneCalendar(<int>[10, 11, 12], <int>[3, 4, 5], _noteHiver),
  'lentille': ZoneCalendar(<int>[11, 12, 1], <int>[6, 7], _noteHiver),
  'pois_chiche': ZoneCalendar(<int>[12, 1, 2], <int>[6, 7], _noteHiver),

  // ─── Bulbes : plantés à l'automne ───
  'ail': ZoneCalendar(<int>[10, 11, 12], <int>[5, 6, 7], _noteHiver),
  'oignon': ZoneCalendar(
      <int>[9, 10, 11, 1], <int>[4, 5, 6, 7], _noteHiver),
  'echalote':
      ZoneCalendar(<int>[10, 11, 12], <int>[5, 6], _noteHiver),
  'poireau': ZoneCalendar(
      <int>[8, 9, 10], <int>[12, 1, 2, 3, 4, 5], _noteFraicheur),

  // ─── Aromatiques fraîches ───
  'persil': ZoneCalendar(<int>[9, 10, 2, 3],
      <int>[11, 12, 1, 2, 3, 4, 5, 6], _noteFraicheur),
  'coriandre': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 1, 2, 3, 4, 5], _noteFraicheur),
  'cerfeuil': ZoneCalendar(
      <int>[9, 10, 2], <int>[11, 12, 1, 2, 3, 4], _noteFraicheur),
  'aneth': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 3, 4, 5, 6], _noteFraicheur),

  // ─── Qui aiment la chaleur : plus tôt, plus longtemps ───
  'tomate': ZoneCalendar(
      <int>[1, 2, 3], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'aubergine': ZoneCalendar(
      <int>[1, 2, 3], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'poivron': ZoneCalendar(
      <int>[1, 2, 3], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'piment': ZoneCalendar(
      <int>[1, 2, 3], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'courgette': ZoneCalendar(
      <int>[2, 3, 4, 8], <int>[5, 6, 7, 8, 9, 10, 11], _noteChaleur),
  'concombre': ZoneCalendar(
      <int>[2, 3, 4, 8], <int>[5, 6, 7, 8, 9, 10], _noteChaleur),
  'cornichon': ZoneCalendar(
      <int>[3, 4, 8], <int>[6, 7, 8, 9, 10], _noteChaleur),
  'melon':
      ZoneCalendar(<int>[2, 3, 4], <int>[6, 7, 8, 9], _noteChaleur),
  'pasteque':
      ZoneCalendar(<int>[3, 4], <int>[7, 8, 9], _noteChaleur),
  'basilic': ZoneCalendar(
      <int>[2, 3, 4, 5], <int>[5, 6, 7, 8, 9, 10], _noteChaleur),
  'haricot': ZoneCalendar(
      <int>[3, 4, 8], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'haricot_beurre': ZoneCalendar(
      <int>[3, 4, 8], <int>[6, 7, 8, 9, 10, 11], _noteChaleur),
  'gombo': ZoneCalendar(<int>[3, 4, 5], <int>[7, 8, 9, 10],
      _noteChaleur),
  'patate_douce':
      ZoneCalendar(<int>[3, 4], <int>[8, 9, 10], _noteChaleur),
  'artichaut': ZoneCalendar(<int>[8, 9, 10],
      <int>[3, 4, 5, 6, 10, 11], _noteHiver),
  'fenouil': ZoneCalendar(
      <int>[8, 9, 2, 3], <int>[11, 12, 1, 5, 6], _noteFraicheur),

  // ─── Pomme de terre : deux cultures, jamais en plein été ───
  'pomme_de_terre': ZoneCalendar(<int>[1, 2, 8], <int>[5, 6, 11, 12],
      'Deux plantations : une en fin d\'hiver pour récolter avant les '
      'grosses chaleurs, une en août pour l\'automne. Rien en plein '
      'été, le tubercule ne grossit pas au-dessus de 30 °C.'),

  // ─── Fraise : plantée à l'automne ───
  'fraise': ZoneCalendar(<int>[9, 10, 11], <int>[3, 4, 5, 6],
      'Plantée à l\'automne, elle s\'enracine pendant l\'hiver doux et '
      'produit dès mars — avant que la chaleur ne grille les fruits.'),
};

// ───────────────────────── Continental ─────────────────────────
//
// Pologne, Tchéquie, Roumanie, Suède, Norvège, Danemark, Autriche,
// Canada, nord des États-Unis, nord de la Chine.
//
// Une seule contrainte commande tout : **le sol gèle de novembre à
// mars**. La saison est courte, elle démarre tard, et ce que la France
// laisse en terre tout l'hiver doit ici être arraché avant les gelées.

const String _noteCourte =
    'Saison courte : rien ne se sème dehors avant le dégel, et la '
    'récolte doit être finie avant les premières gelées. La date de ta '
    'dernière gelée de printemps commande tout.';

const String _noteAbri =
    'À démarrer à l\'abri — en godet sur un rebord de fenêtre ou sous '
    'châssis — puis à planter dehors une fois tout risque de gelée '
    'passé, vers la mi-mai.';

const String _noteArracher =
    'En climat tempéré, cette culture passe l\'hiver en terre. Ici, le '
    'sol gèle : arrache avant les premières grosses gelées et conserve '
    'en cave, dans du sable.';

const Map<String, ZoneCalendar> continentalCalendar =
    <String, ZoneCalendar>{
  // ─── Qui craignent le gel : semis à l'abri, récolte avant l'automne ───
  'tomate': ZoneCalendar(<int>[3, 4], <int>[7, 8, 9], _noteAbri),
  'aubergine': ZoneCalendar(<int>[2, 3], <int>[8, 9], _noteAbri),
  'poivron': ZoneCalendar(<int>[2, 3], <int>[8, 9], _noteAbri),
  'piment': ZoneCalendar(<int>[2, 3], <int>[8, 9], _noteAbri),
  'courgette': ZoneCalendar(<int>[5, 6], <int>[7, 8, 9], _noteCourte),
  'concombre': ZoneCalendar(<int>[5, 6], <int>[7, 8, 9], _noteCourte),
  'cornichon': ZoneCalendar(<int>[5, 6], <int>[7, 8, 9], _noteCourte),
  'melon': ZoneCalendar(<int>[4, 5], <int>[8, 9], _noteAbri),
  'basilic': ZoneCalendar(<int>[4, 5], <int>[7, 8, 9], _noteAbri),
  'haricot': ZoneCalendar(<int>[5, 6], <int>[8, 9], _noteCourte),
  'haricot_beurre':
      ZoneCalendar(<int>[5, 6], <int>[8, 9], _noteCourte),
  'mais': ZoneCalendar(<int>[5, 6], <int>[9], _noteCourte),
  'potiron': ZoneCalendar(<int>[5], <int>[9], _noteCourte),
  'courge_butternut': ZoneCalendar(<int>[5], <int>[9], _noteCourte),
  'potimarron': ZoneCalendar(<int>[5], <int>[9], _noteCourte),
  'patate_douce': ZoneCalendar(<int>[5], <int>[9], _noteAbri),
  'tournesol': ZoneCalendar(<int>[5], <int>[8, 9], _noteCourte),

  // ─── Qui passent l'hiver en France mais pas ici ───
  'poireau': ZoneCalendar(
      <int>[3, 4], <int>[8, 9, 10, 11], _noteArracher),
  'chou_pomme':
      ZoneCalendar(<int>[4, 5], <int>[8, 9, 10], _noteArracher),
  'chou_fleur': ZoneCalendar(<int>[4, 5], <int>[8, 9, 10],
      _noteArracher),
  'brocoli': ZoneCalendar(<int>[4, 5], <int>[8, 9, 10], _noteArracher),
  'chou_kale': ZoneCalendar(<int>[5, 6], <int>[9, 10, 11],
      'Le kale supporte le gel et s\'adoucit même après une gelée, '
      'mais sous la neige tu ne le récolteras plus : prends-le avant '
      'que le sol ne durcisse.'),
  'chou_bruxelles':
      ZoneCalendar(<int>[4, 5], <int>[9, 10, 11], _noteArracher),
  'panais': ZoneCalendar(<int>[4, 5], <int>[9, 10], _noteArracher),
  'salsifis': ZoneCalendar(<int>[5], <int>[9, 10], _noteArracher),
  'topinambour':
      ZoneCalendar(<int>[4], <int>[9, 10, 11], _noteArracher),
  'rutabaga': ZoneCalendar(<int>[5, 6], <int>[9, 10], _noteArracher),
  'radis_noir': ZoneCalendar(<int>[7], <int>[9, 10], _noteArracher),
  'mache': ZoneCalendar(<int>[8], <int>[10, 11],
      'Sous châssis ou sous voile, la mâche tient l\'automne ; en '
      'pleine terre découverte, la neige y met fin.'),
  'endive': ZoneCalendar(<int>[5], <int>[10, 11],
      'Arrache les racines en octobre et force-les en cave : c\'est là '
      'que l\'endive se fait, pas au jardin.'),

  // ─── Saison fraîche, mais sans deuxième semis d'automne ───
  'laitue':
      ZoneCalendar(<int>[4, 5, 6, 7], <int>[6, 7, 8, 9], _noteCourte),
  'epinard': ZoneCalendar(<int>[4, 8], <int>[6, 9, 10], _noteCourte),
  'radis': ZoneCalendar(
      <int>[4, 5, 6, 7, 8], <int>[5, 6, 7, 8, 9], _noteCourte),
  'carotte':
      ZoneCalendar(<int>[4, 5, 6], <int>[7, 8, 9, 10], _noteCourte),
  'navet': ZoneCalendar(<int>[4, 5, 7], <int>[6, 7, 9, 10],
      _noteCourte),
  'betterave': ZoneCalendar(<int>[5, 6], <int>[8, 9, 10], _noteCourte),
  'roquette': ZoneCalendar(<int>[4, 5, 8], <int>[6, 7, 9, 10],
      _noteCourte),
  'blette': ZoneCalendar(<int>[5, 6], <int>[7, 8, 9, 10], _noteCourte),
  'pois_mange_tout':
      ZoneCalendar(<int>[4, 5], <int>[6, 7, 8], _noteCourte),
  'petit_pois': ZoneCalendar(<int>[4, 5], <int>[6, 7, 8], _noteCourte),
  'feve': ZoneCalendar(<int>[4], <int>[7, 8], _noteCourte),

  // ─── L'ail reste d'automne : c'est le froid qui le fait diviser ───
  'ail': ZoneCalendar(<int>[9, 10], <int>[7, 8],
      'L\'ail se plante avant l\'hiver même ici : c\'est le froid qui '
      'déclenche la formation des gousses. Paille épais pour le '
      'protéger du gel nu.'),
  'echalote': ZoneCalendar(<int>[3, 4], <int>[7, 8], _noteCourte),
  'oignon': ZoneCalendar(<int>[3, 4], <int>[8, 9], _noteCourte),

  // ─── Fruits : floraison tardive, récolte comprimée ───
  'pommier': ZoneCalendar(<int>[4, 10], <int>[9, 10], _noteCourte),
  'poirier': ZoneCalendar(<int>[4, 10], <int>[9, 10], _noteCourte),
  'prunier': ZoneCalendar(<int>[4, 10], <int>[8, 9], _noteCourte),
  'cerisier': ZoneCalendar(<int>[4, 10], <int>[7, 8], _noteCourte),
  'fraise': ZoneCalendar(<int>[5, 8], <int>[6, 7, 8], _noteCourte),
  'framboisier': ZoneCalendar(<int>[4, 10], <int>[7, 8, 9],
      _noteCourte),
  'cassissier': ZoneCalendar(<int>[4, 10], <int>[7, 8], _noteCourte),
  'groseillier': ZoneCalendar(<int>[4, 10], <int>[7, 8], _noteCourte),
  'rhubarbe': ZoneCalendar(<int>[4, 9], <int>[5, 6, 7], _noteCourte),
};

/// Le calendrier écrit d'une culture pour une zone, ou null si elle
/// garde le calendrier dérivé.
ZoneCalendar? zoneCalendarFor(ClimateZone zone, String vegetableId) {
  switch (zone) {
    case ClimateZone.mediterranean:
      return mediterraneanCalendar[vegetableId];
    case ClimateZone.continental:
      return continentalCalendar[vegetableId];
    case ClimateZone.temperate:
    case ClimateZone.subtropical:
    case ClimateZone.sahel:
    case ClimateZone.sudan:
    case ClimateZone.guinean:
    case ClimateZone.coolWinter:
    case ClimateZone.highland:
      return null;
  }
}
