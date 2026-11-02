import '../../models/country.dart';
import '../../models/region_data.dart';
import '../../services/prefs_service.dart';
import 'france.dart';
import 'west_africa.dart';
import 'west_africa_zones.dart';
import 'zone_shift.dart';

/// Les calendriers déjà calculés, par (zone, hémisphère).
///
/// Chaque dérivation parcourt 130 cultures : sans ce cache, le
/// calendrier annuel la refaisait à chaque image.
final Map<String, List<RegionData>> _cache = <String, List<RegionData>>{};

/// Le calendrier de semis et de récolte de l'endroit où l'on jardine.
///
/// Deux bases seulement — tempérée (`franceData`) et tropicale
/// (`westAfricaData`) — que la **zone climatique** affine et que
/// l'**hémisphère** retourne. C'est ce qui permet de couvrir une
/// soixantaine de pays sans écrire soixante calendriers :
///
/// - tempéré, méditerranéen, continental, subtropical → base tempérée,
///   décalée par `zone_shift.dart` ;
/// - sahélien, soudanien, guinéen → base tropicale, affinée par
///   `west_africa_zones.dart` ;
/// - tropical d'altitude → base tropicale sans surcharge : les pluies
///   y commandent, comme en zone soudanienne.
///
/// Les calendriers dérivés portent une note qui dit qu'ils le sont.
/// Les affiner culture par culture reste à faire.
List<RegionData> regionalCalendar(
  Region region, {
  ClimateZone? zone,
  Hemisphere hemisphere = Hemisphere.north,
}) {
  final z = zone ??
      (region.isTropicalBase ? ClimateZone.sudan : ClimateZone.temperate);
  final cle = '${region.id}|${z.name}|${hemisphere.name}';
  final dejaVu = _cache[cle];
  if (dejaVu != null) return dejaVu;

  // ⚠️ La base suit la **zone**, pas la région. Elle suivait la région
  // jusqu'au 02/11/2026, et `zoneAt()` pouvait rendre une zone de
  // l'autre base : le répartiteur retombait alors sur la base brute,
  // sans note, sans erreur. Quatre pays le subissaient —
  //
  //   Brésil au sud de 23° S (São Paulo, Curitiba, Porto Alegre) :
  //     zone subtropicale demandée, calendrier tropical non élargi ;
  //   Australie au nord de 24° S (Darwin, Cairns) : zone soudanienne
  //     demandée, calendrier français retourné de six mois ;
  //   Maroc et Algérie au sud de 31° N : zone sahélienne demandée,
  //     calendrier français brut.
  //
  // Le climat est une propriété de la zone, pas du pays : une région
  // ne dit plus que le **contenu** (ouest-africain ou non).
  final List<RegionData> calcule;
  if (z.isTropical) {
    calcule = _tropical(z, hemisphere);
  } else {
    calcule = franceData
        .map((r) => deriveTemperate(r, z, hemisphere: hemisphere))
        .toList();
  }
  _cache[cle] = calcule;
  return calcule;
}

/// L'entrée d'une culture dans un calendrier, ou `null` si elle n'y est
/// pas.
///
/// ⚠️ Cette boucle de quatre lignes était recopiée **quatre fois** —
/// dans la fiche légume, le calendrier mensuel, le catalogue et le
/// service PDF — dont une version qui passait par `firstWhere` et un
/// `try/catch` pour rattraper l'exception. Une recherche dans une
/// liste n'a pas à être réinventée par chaque écran, et c'est le
/// genre de copie qui diverge à la première correction.
RegionData? calendarEntryFor(List<RegionData> calendrier, String vegetableId) {
  for (final d in calendrier) {
    if (d.vegetableId == vegetableId) return d;
  }
  return null;
}

/// Le calendrier de l'utilisateur, lu dans ses préférences.
///
/// Trois écrans portaient chacun leur copie d'une méthode `_dataFor`
/// qui recomposait région + zone à la main. Une quatrième aurait fini
/// par diverger, et l'hémisphère n'y serait jamais arrivé.
List<RegionData> currentCalendar() {
  final prefs = PrefsService.instance;
  return regionalCalendar(
    prefs.region.value,
    zone: prefs.effectiveZone,
    hemisphere: prefs.country.value?.hemisphere ?? Hemisphere.north,
  );
}

List<RegionData> _tropical(ClimateZone zone, Hemisphere hemisphere) {
  final base = (zone == ClimateZone.sudan ||
          zone == ClimateZone.highland ||
          zone == ClimateZone.temperate)
      ? westAfricaData
      : westAfricaData.map((r) {
          final o = zoneOverride(zone, r.vegetableId);
          if (o == null) return r;
          return RegionData(
            regionId: r.regionId,
            vegetableId: r.vegetableId,
            sowingMonths: o.sowingMonths,
            harvestMonths: o.harvestMonths,
            regionalNote: r.regionalNote,
          );
        }).toList();

  if (hemisphere == Hemisphere.north) return base;
  // Sous l'équateur, la saison des pluies tombe à l'opposé : un
  // calendrier sahélien décalé de six mois décrit la saison humide de
  // Madagascar ou du Brésil central.
  return base
      .map((r) => RegionData(
            regionId: r.regionId,
            vegetableId: r.vegetableId,
            sowingMonths: shiftMonths(r.sowingMonths, 6),
            harvestMonths: shiftMonths(r.harvestMonths, 6),
            regionalNote: <String>[
              if (r.regionalNote != null) r.regionalNote!,
              'Décalé de six mois : au sud de l\'équateur, la saison des '
                  'pluies tombe à l\'opposé.',
            ].join(' '),
          ))
      .toList();
}
