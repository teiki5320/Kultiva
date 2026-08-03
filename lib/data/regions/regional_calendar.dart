import '../../models/country.dart';
import '../../models/region_data.dart';
import 'france.dart';
import 'west_africa.dart';
import 'west_africa_zones.dart';

final Map<ClimateZone, List<RegionData>> _zoneCache =
    <ClimateZone, List<RegionData>>{};

/// Calendrier de semis/récolte pour la région active, affiné par la
/// zone climatique du pays quand elle est connue.
///
/// La base ouest-africaine (`westAfricaData`) correspond à la zone
/// soudanienne ; les zones sahélienne et guinéenne côtière appliquent
/// leurs surcharges par culture (`west_africa_zones.dart`), les
/// cultures non surchargées gardant le calendrier de base.
List<RegionData> regionalCalendar(Region region, {ClimateZone? zone}) {
  if (region != Region.westAfrica) return franceData;
  final z = zone ?? ClimateZone.sudan;
  if (z == ClimateZone.sudan || z == ClimateZone.temperate) {
    return westAfricaData;
  }
  return _zoneCache.putIfAbsent(z, () {
    return westAfricaData.map((r) {
      final o = zoneOverride(z, r.vegetableId);
      if (o == null) return r;
      return RegionData(
        regionId: r.regionId,
        vegetableId: r.vegetableId,
        sowingMonths: o.sowingMonths,
        harvestMonths: o.harvestMonths,
        regionalNote: r.regionalNote,
      );
    }).toList();
  });
}
