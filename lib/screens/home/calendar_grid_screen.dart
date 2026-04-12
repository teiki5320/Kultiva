import 'package:flutter/material.dart';

import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';

/// Vue calendrier annuel — grille 12 mois × tous les légumes de la région.
/// Vert = mois de semis, orange = mois de récolte.
class CalendarGridScreen extends StatelessWidget {
  const CalendarGridScreen({super.key});

  static const List<String> _shortMonths = [
    'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D',
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().month;
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final regionData =
            region == Region.france ? franceData : westAfricaData;
        // Only show vegetables that have data in this region, sorted by name.
        final entries = regionData.toList()
          ..sort((a, b) {
            final va = vegetablesBase
                .where((v) => v.id == a.vegetableId)
                .firstOrNull;
            final vb = vegetablesBase
                .where((v) => v.id == b.vegetableId)
                .firstOrNull;
            return (va?.name ?? '').compareTo(vb?.name ?? '');
          });

        return Scaffold(
          appBar: AppBar(
            title: Text('Calendrier ${region.label}'),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowHeight: 40,
                dataRowMinHeight: 36,
                dataRowMaxHeight: 36,
                columnSpacing: 0,
                horizontalMargin: 8,
                columns: [
                  const DataColumn(
                    label: SizedBox(
                      width: 120,
                      child: Text('Légume',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ),
                  for (int m = 0; m < 12; m++)
                    DataColumn(
                      label: Container(
                        width: 32,
                        alignment: Alignment.center,
                        child: Text(
                          _shortMonths[m],
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: m + 1 == now
                                ? KultivaColors.primaryGreen
                                : null,
                          ),
                        ),
                      ),
                    ),
                ],
                rows: entries.map((rd) {
                  final veg = vegetablesBase
                      .where((v) => v.id == rd.vegetableId)
                      .firstOrNull;
                  if (veg == null) return const DataRow(cells: []);
                  return DataRow(
                    cells: [
                      DataCell(SizedBox(
                        width: 120,
                        child: Text(
                          '${veg.emoji} ${veg.name}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      for (int m = 1; m <= 12; m++)
                        DataCell(
                          Center(
                            child: _MonthCell(
                              isSow: rd.sowingMonths.contains(m),
                              isHarvest: rd.harvestMonths.contains(m),
                              isCurrentMonth: m == now,
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MonthCell extends StatelessWidget {
  final bool isSow;
  final bool isHarvest;
  final bool isCurrentMonth;
  const _MonthCell({
    required this.isSow,
    required this.isHarvest,
    required this.isCurrentMonth,
  });

  @override
  Widget build(BuildContext context) {
    if (!isSow && !isHarvest) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isCurrentMonth
              ? KultivaColors.lightGreen.withOpacity(0.1)
              : null,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }
    // Both sow and harvest → split cell
    if (isSow && isHarvest) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: isCurrentMonth
              ? Border.all(color: KultivaColors.primaryGreen, width: 2)
              : null,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              KultivaColors.primaryGreen,
              KultivaColors.terracotta,
            ],
          ),
        ),
      );
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isSow ? KultivaColors.primaryGreen : KultivaColors.terracotta,
        borderRadius: BorderRadius.circular(4),
        border: isCurrentMonth
            ? Border.all(color: Colors.white, width: 2)
            : null,
      ),
    );
  }
}
