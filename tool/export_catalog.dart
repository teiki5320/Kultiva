// Script one-shot d'export du catalogue complet (espèces + accessoires)
// vers `kultiva-catalog.json` à la racine du repo, format défini par
// Kultivaprix.
//
// Utilisation depuis la racine du projet :
//   dart run tool/export_catalog.dart
//
// Sortie :
//   - kultiva-catalog.json (98 entrées : ~59 species + ~39 accessory)
//   - logs sur stdout : compte par kind + chemin du fichier.

import 'dart:convert';
import 'dart:io';

import '../lib/data/regions/france.dart';
import '../lib/data/regions/west_africa.dart';
import '../lib/data/vegetables_base.dart';
import '../lib/models/region_data.dart';
import '../lib/models/vegetable.dart';

void main() {
  final fr = <String, RegionData>{
    for (final r in franceData) r.vegetableId: r,
  };
  final wa = <String, RegionData>{
    for (final r in westAfricaData) r.vegetableId: r,
  };

  final list = <Map<String, dynamic>>[];
  var speciesCount = 0;
  var accessoryCount = 0;

  for (final v in vegetablesBase) {
    final isAccessory = v.category == VegetableCategory.accessories;
    final kind = isAccessory ? 'accessory' : 'species';
    if (isAccessory) {
      accessoryCount++;
    } else {
      speciesCount++;
    }

    Map<String, dynamic>? regions;
    if (!isAccessory) {
      regions = <String, dynamic>{};
      final f = fr[v.id];
      if (f != null) {
        regions['france'] = <String, dynamic>{
          'sowing_months': f.sowingMonths,
          'harvest_months': f.harvestMonths,
          'regional_note': f.regionalNote,
        };
      }
      final w = wa[v.id];
      if (w != null) {
        regions['west_africa'] = <String, dynamic>{
          'sowing_months': w.sowingMonths,
          'harvest_months': w.harvestMonths,
          'regional_note': w.regionalNote,
        };
      }
    }

    list.add(<String, dynamic>{
      'id': v.id,
      'kind': kind,
      'name': v.name,
      'emoji': v.emoji,
      'category': v.category.name,
      'accessory_sub': v.accessorySub?.name,
      'image_asset': v.imageAsset,
      'description': isAccessory ? null : v.description,
      'note': v.note,
      'sowing_technique': isAccessory ? null : v.sowingTechnique,
      'sowing_depth': isAccessory ? null : v.sowingDepth,
      'germination_temp': isAccessory ? null : v.germinationTemp,
      'germination_days': isAccessory ? null : v.germinationDays,
      'exposure': isAccessory ? null : v.exposure,
      'spacing': isAccessory ? null : v.spacing,
      'watering': isAccessory ? null : v.watering,
      'soil': isAccessory ? null : v.soil,
      'watering_days_max': isAccessory ? null : v.wateringDaysMax,
      'yield_estimate': isAccessory ? null : v.yieldEstimate,
      'harvest_time_by_season':
          isAccessory ? null : v.harvestTimeBySeason,
      'amazon_url': v.amazonUrl,
      'regions': regions,
    });
  }

  final out = File('kultiva-catalog.json');
  const encoder = JsonEncoder.withIndent('  ');
  out.writeAsStringSync('${encoder.convert(list)}\n');

  // ignore: avoid_print
  print('Total : ${list.length} entrées');
  // ignore: avoid_print
  print('  • species   : $speciesCount');
  // ignore: avoid_print
  print('  • accessory : $accessoryCount');
  // ignore: avoid_print
  print('Fichier : ${out.absolute.path}');
}
