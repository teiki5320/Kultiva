import 'package:flutter/material.dart';

import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../utils/months.dart';
import '../../theme/app_theme.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import '../vegetable_detail_screen.dart';

/// Vue calendrier annuel — grille 12 mois × tous les légumes de la région.
/// Vert = mois de semis, orange = mois de récolte.
class CalendarGridScreen extends StatefulWidget {
  const CalendarGridScreen({super.key});

  @override
  State<CalendarGridScreen> createState() => _CalendarGridScreenState();
}

class _CalendarGridScreenState extends State<CalendarGridScreen> {
  static const List<String> _shortMonths = monthNamesShortCap;
  static const List<String> _fullMonths = monthNamesLongCap;

  /// Filtre actif — null = tout afficher, sinon ne montre que les légumes
  /// avec une activité (semis ou récolte) durant ce mois.
  int? _filterMonth;

  void _openVegetable(Vegetable v) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VegetableDetailScreen(vegetable: v),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().month;
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final regionData =
            region == Region.france ? franceData : westAfricaData;
        var entries = regionData.toList()
          ..sort((a, b) {
            final va = vegetablesBase
                .where((v) => v.id == a.vegetableId)
                .firstOrNull;
            final vb = vegetablesBase
                .where((v) => v.id == b.vegetableId)
                .firstOrNull;
            return (va?.name ?? '').compareTo(vb?.name ?? '');
          });

        // Filtre par mois actif.
        if (_filterMonth != null) {
          entries = entries.where((rd) =>
              rd.sowingMonths.contains(_filterMonth) ||
              rd.harvestMonths.contains(_filterMonth)).toList();
        }

        return Scaffold(
          body: Column(
            children: [
              // Header saisonnier avec flèche retour + bouton filtre off.
              Stack(
                children: [
                  SeasonHeader(
                    season: Season.fromMonth(_filterMonth ?? now),
                    month: _filterMonth ?? now,
                    height: 150,
                  ),
                  Positioned(
                    top: 8, left: 8,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                  if (_filterMonth != null)
                    Positioned(
                      top: 8, right: 8,
                      child: SafeArea(
                        child: GestureDetector(
                          onTap: () => setState(() => _filterMonth = null),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.filter_alt_off,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Légende.
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: KultivaColors.lightGreen.withOpacity(0.1),
                child: Row(
                  children: [
                    _LegendItem(color: KultivaColors.primaryGreen, label: 'Semis'),
                    const SizedBox(width: 16),
                    _LegendItem(color: KultivaColors.terracotta, label: 'Récolte'),
                    const Spacer(),
                    if (_filterMonth != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: KultivaColors.primaryGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_fullMonths[_filterMonth! - 1]} (${entries.length})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: KultivaColors.primaryGreen,
                          ),
                        ),
                      )
                    else
                      Text(
                        '💡 Tap mois = filtre · Tap case = fiche',
                        style: TextStyle(
                          fontSize: 10,
                          color: KultivaColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              // Grille.
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingRowHeight: 44,
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
                            label: GestureDetector(
                              onTap: () => setState(() {
                                _filterMonth = _filterMonth == m + 1 ? null : m + 1;
                              }),
                              child: Container(
                                width: 42,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _filterMonth == m + 1
                                      ? KultivaColors.primaryGreen.withOpacity(0.2)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _shortMonths[m],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: m + 1 == now
                                        ? KultivaColors.primaryGreen
                                        : null,
                                  ),
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
                            DataCell(
                              GestureDetector(
                                onTap: () => _openVegetable(veg),
                                child: SizedBox(
                                  width: 120,
                                  child: Text(
                                    '${veg.emoji} ${veg.name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: KultivaColors.primaryGreen,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          KultivaColors.primaryGreen.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            for (int m = 1; m <= 12; m++)
                              DataCell(
                                Center(
                                  child: GestureDetector(
                                    onTap: () => _openVegetable(veg),
                                    child: _MonthCell(
                                      isSow: rd.sowingMonths.contains(m),
                                      isHarvest: rd.harvestMonths.contains(m),
                                      isCurrentMonth: m == now,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14, height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700)),
      ],
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
