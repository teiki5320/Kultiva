/// Dérive les calendriers des zones tempérées à partir de la base
/// française, et retourne les saisons pour l'hémisphère sud.
///
/// Pourquoi dériver plutôt qu'écrire : la base française tient 806
/// lignes pour 130 cultures. En recopier une par zone, c'est quatre
/// fichiers qui divergent à la première correction. Un décalage
/// explicite se lit, se teste, et se corrige en un endroit.
///
/// ⚠️ **Ce sont des approximations, et l'app le dit.** Chaque
/// calendrier dérivé porte une note qui invite à ajuster sur le
/// terrain. Un décalage d'un mois décrit correctement l'écart entre
/// Paris et Varsovie ; il ne remplace pas un calendrier écrit par un
/// maraîcher polonais. Les affiner culture par culture, zone par zone,
/// est le travail qui reste.
library;

import '../../models/country.dart';
import '../../models/region_data.dart';
import 'temperate_zones.dart';



/// Décale une liste de mois en restant dans 1..12.
List<int> shiftMonths(Iterable<int> months, int offset) {
  if (offset == 0) return months.toList();
  final out = months.map((m) {
    final v = (m - 1 + offset) % 12;
    return (v < 0 ? v + 12 : v) + 1;
  }).toList()
    ..sort();
  return out;
}

/// Réunit deux listes de mois sans doublon.
List<int> _union(Iterable<int> a, Iterable<int> b) =>
    (<int>{...a, ...b}.toList()..sort());

/// Les mois où il gèle trop pour semer en pleine terre en climat
/// continental.
const Set<int> _moisGeles = <int>{11, 12, 1, 2};

/// Note affichée sous le calendrier d'une zone dérivée.
String? _noteFor(ClimateZone zone) {
  switch (zone) {
    case ClimateZone.mediterranean:
      return 'Calendrier adapté du calendrier tempéré : un mois plus '
          'tôt au printemps. En été, l\'ombrage et l\'arrosage comptent '
          'plus que la date. Ajuste selon tes gelées locales.';
    case ClimateZone.continental:
      return 'Calendrier adapté du calendrier tempéré : un mois plus '
          'tard, saison plus courte. Vérifie la date de ta dernière '
          'gelée, elle commande tout.';
    case ClimateZone.subtropical:
      return 'Calendrier adapté du calendrier tempéré : saison élargie '
          'd\'un mois de chaque côté. Les étés lourds favorisent les '
          'maladies — espace tes plants.';
    case ClimateZone.temperate:
    case ClimateZone.sahel:
    case ClimateZone.sudan:
    case ClimateZone.guinean:
    case ClimateZone.highland:
      return null;
  }
}

/// Applique à une entrée du calendrier tempéré le décalage de sa zone,
/// puis celui de son hémisphère.
RegionData deriveTemperate(
  RegionData base,
  ClimateZone zone, {
  Hemisphere hemisphere = Hemisphere.north,
}) {
  // Un calendrier écrit à la main pour cette zone l'emporte sur le
  // décalage. C'est tout l'intérêt de `temperate_zones.dart` : en
  // méditerranéen, une laitue ne se sème pas « un mois plus tôt »,
  // elle se sème six mois plus tard, à l'automne.
  final ecrit = zoneCalendarFor(zone, base.vegetableId);
  if (ecrit != null) {
    final o = hemisphere.monthOffset;
    return RegionData(
      regionId: base.regionId,
      vegetableId: base.vegetableId,
      sowingMonths: shiftMonths(ecrit.sowing, o),
      harvestMonths: shiftMonths(ecrit.harvest, o),
      regionalNote: <String>[
        ecrit.note,
        if (o != 0)
          'Décalé de six mois : tu es dans l\'hémisphère sud, où les '
              'saisons sont inversées.',
      ].join(' '),
    );
  }

  List<int> semis = base.sowingMonths;
  List<int> recolte = base.harvestMonths;

  switch (zone) {
    case ClimateZone.mediterranean:
      semis = shiftMonths(semis, -1);
      recolte = shiftMonths(recolte, -1);
      break;
    case ClimateZone.continental:
      final tardif = shiftMonths(semis, 1);
      // Rien ne se sème dehors sous la neige. On ne vide jamais la
      // liste pour autant : un semis mal placé se corrige, un légume
      // qui disparaît du calendrier ne se devine pas.
      final horsGel = tardif.where((m) => !_moisGeles.contains(m)).toList();
      semis = horsGel.isEmpty ? tardif : horsGel;
      recolte = shiftMonths(recolte, 1);
      break;
    case ClimateZone.subtropical:
      semis = _union(semis, shiftMonths(semis, -1));
      recolte = _union(recolte, shiftMonths(recolte, 1));
      break;
    case ClimateZone.temperate:
    case ClimateZone.sahel:
    case ClimateZone.sudan:
    case ClimateZone.guinean:
    case ClimateZone.highland:
      break;
  }

  final o = hemisphere.monthOffset;
  final note = _noteFor(zone);

  // Rien à faire : on rend l'entrée d'origine plutôt qu'une copie.
  if (o == 0 && note == null && identical(semis, base.sowingMonths)) {
    return base;
  }

  final morceaux = <String>[
    if (base.regionalNote != null) base.regionalNote!,
    if (note != null) note,
    if (o != 0)
      'Décalé de six mois : tu es dans l\'hémisphère sud, où les '
          'saisons sont inversées.',
  ];

  return RegionData(
    regionId: base.regionId,
    vegetableId: base.vegetableId,
    sowingMonths: shiftMonths(semis, o),
    harvestMonths: shiftMonths(recolte, o),
    regionalNote: morceaux.isEmpty ? null : morceaux.join(' '),
  );
}
