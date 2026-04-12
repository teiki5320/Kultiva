import 'package:flutter/material.dart';

import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/vegetable_card.dart';
import '../vegetable_detail_screen.dart';

/// Écran calendrier mensuel — sélecteur de mois + liste des légumes
/// semables, filtré par la région active.
class MonthlyCalendarScreen extends StatefulWidget {
  const MonthlyCalendarScreen({super.key});

  @override
  State<MonthlyCalendarScreen> createState() => _MonthlyCalendarScreenState();
}

class _MonthlyCalendarScreenState extends State<MonthlyCalendarScreen> {
  late final PageController _monthController;
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now().month;
    _monthController = PageController(
      initialPage: _selectedMonth - 1,
      viewportFraction: 0.32,
    );
  }

  @override
  void dispose() {
    _monthController.dispose();
    super.dispose();
  }

  List<RegionData> _dataFor(Region region) {
    switch (region) {
      case Region.france:
        return franceData;
      case Region.westAfrica:
        return westAfricaData;
    }
  }

  RegionData? _findRegionData(List<RegionData> list, String vegetableId) {
    for (final d in list) {
      if (d.vegetableId == vegetableId) return d;
    }
    return null;
  }

  static const List<String> _monthLabels = [
    'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
    'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc',
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final data = _dataFor(region);
        final sowNow = <Vegetable>[];
        final later = <Vegetable>[];
        for (final veg in vegetablesBase) {
          final entry = _findRegionData(data, veg.id);
          if (entry != null && entry.sowingMonths.contains(_selectedMonth)) {
            sowNow.add(veg);
          } else {
            later.add(veg);
          }
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Calendrier mensuel')),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Month selector.
              SizedBox(
                height: 72,
                child: PageView.builder(
                  controller: _monthController,
                  itemCount: 12,
                  onPageChanged: (i) => setState(() => _selectedMonth = i + 1),
                  itemBuilder: (context, index) {
                    final m = index + 1;
                    final active = m == _selectedMonth;
                    return GestureDetector(
                      onTap: () => _monthController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        margin: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: active ? 2 : 14,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? KultivaColors.primaryGreen
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  KultivaColors.primaryGreen.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _monthLabels[index],
                          style: TextStyle(
                            color: active
                                ? Colors.white
                                : KultivaColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: active ? 18 : 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (sowNow.isNotEmpty) ...[
                _SectionHeader(icon: '✅', title: 'À semer en ${_monthLabels[_selectedMonth - 1]}'),
                for (final v in sowNow)
                  VegetableCard(
                    vegetable: v,
                    canSowNow: true,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => VegetableDetailScreen(vegetable: v),
                      ),
                    ),
                  ),
              ] else
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          const Text('🌱', style: TextStyle(fontSize: 32)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Rien à semer ce mois-ci. Patience, jardinier !",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (later.isNotEmpty) ...[
                const SizedBox(height: 16),
                const _SectionHeader(icon: '⏳', title: 'Pas encore la saison'),
                for (final v in later)
                  VegetableCard(
                    vegetable: v,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => VegetableDetailScreen(vegetable: v),
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Text(
        '$icon  $title',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
