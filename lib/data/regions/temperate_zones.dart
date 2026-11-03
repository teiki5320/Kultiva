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

// ──────────────────────── Subtropical humide ────────────────────────
//
// Sud-est des États-Unis, Argentine, Uruguay, sud du Brésil, Japon,
// est de l'Australie, haut plateau sud-africain.
//
// ⚠️ **Ce n'est pas un méditerranéen un peu plus chaud.** Les deux ont
// un hiver doux, mais le méditerranéen a un été **sec** et celui-ci un
// été **lourd** : 30 à 35 °C avec de l'humidité et des orages. Une
// tomate n'y souffre pas de la soif, elle attrape le mildiou ; une
// laitue n'y grille pas, elle pourrit du collet. D'où un rythme à
// **deux saisons de culture** — printemps puis fin d'été — avec un
// creux au cœur de l'été, là où le méditerranéen n'en a qu'une.
//
// Trois règles portent presque tout :
//   1. ce qui craint la chaleur passe à la saison fraîche, d'octobre à
//      avril, comme en méditerranéen ;
//   2. ce qui la supporte profite de neuf mois sans gel ;
//   3. entre les deux, les cultures de plein été se sèment **deux
//      fois**, en encadrant le creux humide de juillet-août.

const String _noteEteLourd =
    'Ici l\'été est chaud **et** humide : cette culture monte en graine '
    'ou pourrit avant d\'être bonne. Elle se sème en fin d\'été et se '
    'récolte de l\'automne au printemps, sur la saison fraîche.';

const String _noteDeuxSemis =
    'Deux semis plutôt qu\'un : au printemps pour récolter avant les '
    'grosses chaleurs, puis en fin d\'été pour une récolte d\'automne. '
    'Au cœur de l\'été, l\'humidité amène les maladies.';

const String _noteLongueSaison =
    'Neuf mois sans gel : tu démarres tôt et tu récoltes tard. Cette '
    'culture, serrée en climat tempéré, a ici tout son temps — et '
    'l\'humidité de l\'été lui va bien.';

const String _noteHiverDoux =
    'L\'hiver est doux, avec au pire quelques gelées légères : semé à '
    'l\'automne, récolté en hiver ou au début du printemps.';

const Map<String, ZoneCalendar> subtropicalCalendar =
    <String, ZoneCalendar>{
  // ─── Légumes-feuilles : toute la saison fraîche ───
  'laitue': ZoneCalendar(
      <int>[9, 10, 11, 1, 2], <int>[11, 12, 1, 2, 3, 4, 5], _noteEteLourd),
  'epinard': ZoneCalendar(
      <int>[9, 10, 11], <int>[11, 12, 1, 2, 3], _noteEteLourd),
  'mache': ZoneCalendar(<int>[10, 11], <int>[12, 1, 2, 3], _noteEteLourd),
  'roquette': ZoneCalendar(
      <int>[9, 10, 11, 2], <int>[10, 11, 12, 1, 2, 3, 4], _noteEteLourd),
  'cresson': ZoneCalendar(
      <int>[10, 11, 2], <int>[12, 1, 2, 3, 4], _noteEteLourd),
  'oseille': ZoneCalendar(<int>[9, 10, 2, 3],
      <int>[10, 11, 12, 1, 2, 3, 4, 5], _noteEteLourd),
  'blette': ZoneCalendar(<int>[9, 10, 2, 3],
      <int>[11, 12, 1, 2, 3, 4, 5, 6], _noteEteLourd),
  'pak_choi': ZoneCalendar(
      <int>[9, 10, 1, 2], <int>[11, 12, 1, 2, 3, 4], _noteEteLourd),
  'chou_chinois':
      ZoneCalendar(<int>[9, 10], <int>[11, 12, 1, 2], _noteEteLourd),
  'celeri': ZoneCalendar(<int>[8, 9], <int>[12, 1, 2, 3], _noteEteLourd),

  // ─── Choux : semés en fin d'été, récoltés tout l'hiver ───
  'chou_pomme': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3], _noteEteLourd),
  'chou_fleur':
      ZoneCalendar(<int>[8, 9], <int>[11, 12, 1, 2], _noteEteLourd),
  'brocoli': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3], _noteEteLourd),
  'chou_kale': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3, 4], _noteEteLourd),
  'chou_rave': ZoneCalendar(
      <int>[9, 10, 1, 2], <int>[11, 12, 1, 2, 3, 4], _noteEteLourd),
  // ⚠️ Le chou de Bruxelles demande des semaines franchement froides
  // pour que les pommes se serrent. Il reste possible, il n'est pas
  // confortable : la fenêtre est étroite et le résultat inégal.
  'chou_bruxelles': ZoneCalendar(<int>[7, 8], <int>[12, 1, 2],
      'Les pommes ne se serrent qu\'au froid, et l\'hiver est doux '
      'ici : sème tôt, vise les semaines les plus fraîches, et '
      'attends-toi à des pommes plus lâches qu\'en climat tempéré.'),

  // ─── Racines : la saison fraîche, jamais le plein été ───
  'radis': ZoneCalendar(<int>[9, 10, 11, 1, 2, 3],
      <int>[10, 11, 12, 1, 2, 3, 4], _noteEteLourd),
  'carotte': ZoneCalendar(<int>[8, 9, 10, 1, 2],
      <int>[11, 12, 1, 2, 3, 4, 5], _noteEteLourd),
  'navet': ZoneCalendar(
      <int>[8, 9, 10, 1], <int>[10, 11, 12, 1, 2, 3], _noteEteLourd),
  'betterave': ZoneCalendar(
      <int>[9, 10, 1, 2], <int>[12, 1, 2, 3, 4, 5], _noteEteLourd),
  'panais': ZoneCalendar(<int>[8, 9], <int>[12, 1, 2, 3], _noteEteLourd),
  'radis_noir':
      ZoneCalendar(<int>[8, 9], <int>[11, 12, 1, 2], _noteEteLourd),

  // ─── Légumineuses d'hiver ───
  'feve': ZoneCalendar(<int>[10, 11, 12], <int>[2, 3, 4], _noteHiverDoux),
  'petit_pois':
      ZoneCalendar(<int>[9, 10, 11], <int>[12, 1, 2, 3], _noteHiverDoux),
  'pois_mange_tout':
      ZoneCalendar(<int>[9, 10, 11], <int>[12, 1, 2, 3], _noteHiverDoux),
  'lentille': ZoneCalendar(<int>[10, 11], <int>[4, 5], _noteHiverDoux),
  'pois_chiche': ZoneCalendar(<int>[11, 12], <int>[4, 5], _noteHiverDoux),

  // ─── Légumineuses d'été : deux semis, ou la chaleur en entier ───
  'haricot': ZoneCalendar(
      <int>[3, 4, 8], <int>[5, 6, 7, 10, 11], _noteDeuxSemis),
  'haricot_beurre': ZoneCalendar(
      <int>[3, 4, 8], <int>[5, 6, 7, 10, 11], _noteDeuxSemis),
  'niebe':
      ZoneCalendar(<int>[4, 5, 6], <int>[7, 8, 9, 10], _noteLongueSaison),

  // ─── Bulbes : plantés à l'automne, levés avant l'été ───
  'ail': ZoneCalendar(<int>[10, 11], <int>[5, 6], _noteHiverDoux),
  'oignon': ZoneCalendar(<int>[9, 10, 11], <int>[4, 5, 6], _noteHiverDoux),
  'echalote': ZoneCalendar(<int>[10, 11], <int>[5, 6], _noteHiverDoux),
  'poireau':
      ZoneCalendar(<int>[8, 9], <int>[12, 1, 2, 3, 4], _noteEteLourd),

  // ─── Aromatiques ───
  'persil': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 1, 2, 3, 4, 5], _noteEteLourd),
  'coriandre': ZoneCalendar(
      <int>[9, 10, 11, 2], <int>[11, 12, 1, 2, 3, 4], _noteEteLourd),
  'cerfeuil': ZoneCalendar(
      <int>[9, 10, 2], <int>[11, 12, 1, 2, 3], _noteEteLourd),
  'aneth': ZoneCalendar(
      <int>[9, 10, 2, 3], <int>[11, 12, 1, 2, 3, 4], _noteEteLourd),
  'basilic': ZoneCalendar(<int>[3, 4, 5, 6],
      <int>[5, 6, 7, 8, 9, 10], _noteLongueSaison),

  // ─── Légumes-fruits : deux récoltes autour du creux humide ───
  'tomate': ZoneCalendar(
      <int>[1, 2, 6, 7], <int>[5, 6, 7, 10, 11], _noteDeuxSemis),
  'aubergine': ZoneCalendar(
      <int>[1, 2], <int>[5, 6, 7, 8, 9, 10], _noteLongueSaison),
  'poivron': ZoneCalendar(
      <int>[1, 2], <int>[5, 6, 7, 8, 9, 10], _noteLongueSaison),
  'piment': ZoneCalendar(
      <int>[1, 2], <int>[5, 6, 7, 8, 9, 10], _noteLongueSaison),
  'courgette': ZoneCalendar(
      <int>[2, 3, 7, 8], <int>[4, 5, 6, 9, 10, 11], _noteDeuxSemis),
  'concombre': ZoneCalendar(
      <int>[2, 3, 7, 8], <int>[4, 5, 6, 9, 10], _noteDeuxSemis),
  'cornichon': ZoneCalendar(
      <int>[2, 3, 7, 8], <int>[4, 5, 6, 9, 10], _noteDeuxSemis),
  'mais': ZoneCalendar(
      <int>[2, 3, 4, 7], <int>[5, 6, 7, 10], _noteDeuxSemis),
  'melon':
      ZoneCalendar(<int>[2, 3, 4], <int>[6, 7, 8, 9], _noteLongueSaison),
  'pasteque':
      ZoneCalendar(<int>[2, 3, 4], <int>[6, 7, 8, 9], _noteLongueSaison),
  'gombo': ZoneCalendar(
      <int>[3, 4, 5], <int>[6, 7, 8, 9, 10], _noteLongueSaison),
  'courge_butternut':
      ZoneCalendar(<int>[2, 3, 4], <int>[7, 8, 9, 10], _noteLongueSaison),
  'potiron':
      ZoneCalendar(<int>[2, 3, 4], <int>[7, 8, 9, 10], _noteLongueSaison),

  // ─── Tubercules et racines de chaleur ───
  'patate_douce': ZoneCalendar(
      <int>[3, 4, 5], <int>[8, 9, 10, 11], _noteLongueSaison),
  'arachide':
      ZoneCalendar(<int>[3, 4, 5], <int>[8, 9, 10], _noteLongueSaison),
  'gingembre':
      ZoneCalendar(<int>[2, 3], <int>[9, 10, 11], _noteLongueSaison),
  // ⚠️ Deux récoltes de pomme de terre, et c'est la pratique courante
  // du sud-est américain comme de la pampa : une de printemps plantée
  // en fin d'hiver, une d'automne plantée en août.
  'pomme_de_terre': ZoneCalendar(
      <int>[1, 2, 8], <int>[4, 5, 6, 11, 12], _noteDeuxSemis),

  // ─── Le reste ───
  'artichaut':
      ZoneCalendar(<int>[9, 10], <int>[2, 3, 4, 5], _noteHiverDoux),
  'fenouil': ZoneCalendar(
      <int>[8, 9, 10], <int>[11, 12, 1, 2, 3], _noteEteLourd),
  // ⚠️ La fraise se cultive ici en **annuelle** : plants mis en terre
  // à l'automne, récolte d'hiver et de printemps, puis on arrache.
  // Un pied laissé en place passe l'été humide et meurt.
  'fraise': ZoneCalendar(<int>[9, 10], <int>[12, 1, 2, 3, 4],
      'Ici la fraise se mène en annuelle : plants en terre à '
      'l\'automne, récolte de l\'hiver au printemps, puis on arrache. '
      'Un pied laissé en place ne survit pas à l\'été humide.'),
};

/// Le calendrier écrit d'une culture pour une zone, ou null si elle
/// garde le calendrier dérivé.
ZoneCalendar? zoneCalendarFor(ClimateZone zone, String vegetableId) {
  switch (zone) {
    case ClimateZone.mediterranean:
      return mediterraneanCalendar[vegetableId];
    case ClimateZone.continental:
      return continentalCalendar[vegetableId];
    case ClimateZone.subtropical:
      return subtropicalCalendar[vegetableId];
    case ClimateZone.temperate:
    case ClimateZone.sahel:
    case ClimateZone.sudan:
    case ClimateZone.guinean:
    case ClimateZone.coolWinter:
    case ClimateZone.highland:
      return null;
  }
}
