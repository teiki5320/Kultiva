import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/companions.dart';
import '../../data/diseases.dart';
import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/rotation.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import '../vegetable_detail_screen.dart';
import 'calendar_grid_screen.dart';
import 'monthly_calendar_screen.dart';

/// Dashboard principal — Hero saisonnier + météo + actions rapides +
/// à faire + légume du jour + conseil du jour.
class SowScreen extends StatefulWidget {
  const SowScreen({super.key});

  @override
  State<SowScreen> createState() => _SowScreenState();
}

class _SowScreenState extends State<SowScreen> {
  WeatherData? _weather;
  bool _loadingWeather = false;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() => _loadingWeather = true);
    try {
      _weather = await WeatherService.getWeather();
    } catch (_) {}
    if (mounted) setState(() => _loadingWeather = false);
  }

  List<RegionData> _dataFor(Region region) {
    switch (region) {
      case Region.france:
        return franceData;
      case Region.westAfrica:
        return westAfricaData;
    }
  }

  /// Légume du jour — déterministe par date (pas aléatoire à chaque build).
  Vegetable get _vegetableOfTheDay {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return vegetablesBase[dayOfYear % vegetablesBase.length];
  }

  /// Conseil du jour — tiré des données de compagnonnage, rotation, maladies.
  String get _tipOfTheDay {
    final tips = <String>[];

    // Tips compagnonnage.
    for (final entry in companionMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      final comp = entry.value.isNotEmpty
          ? vegetablesBase.where((v) => v.id == entry.value.first).firstOrNull
          : null;
      if (veg != null && comp != null) {
        tips.add(
            '${veg.emoji} ${veg.name} adore pousser à côté de ${comp.emoji} ${comp.name} !');
      }
    }

    // Tips rotation.
    for (final entry in rotationMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      if (veg != null) {
        tips.add(
            '${veg.emoji} ${veg.name} : attendre ${entry.value.waitYears} ans avant de replanter au même endroit (${entry.value.family}).');
      }
    }

    // Tips maladies.
    for (final entry in diseaseMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      if (veg != null && entry.value.isNotEmpty) {
        final d = entry.value.first;
        tips.add('${veg.emoji} ${veg.name} : attention au ${d.name}. Remède bio : ${d.remedy}.');
      }
    }

    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return tips[dayOfYear % tips.length];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = now.month;
    final season = Season.fromMonth(month);

    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final data = _dataFor(region);

        // Légumes à semer ce mois (max 5).
        final toSow = <Vegetable>[];
        final toHarvest = <Vegetable>[];
        for (final veg in vegetablesBase) {
          for (final rd in data) {
            if (rd.vegetableId == veg.id) {
              if (rd.sowingMonths.contains(month)) toSow.add(veg);
              if (rd.harvestMonths.contains(month)) toHarvest.add(veg);
            }
          }
        }

        final vegOfDay = _vegetableOfTheDay;
        final tip = _tipOfTheDay;
        final daysSinceWater = PrefsService.instance.daysSinceLastWatering;

        return SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ── Hero saisonnier + météo overlay ──
              Stack(
                children: [
                  SeasonHeader(season: season, month: month, height: 200),
                  if (_weather != null)
                    Positioned(
                      top: 12,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_weather!.weatherEmoji,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 6),
                            Text(
                              '${_weather!.currentTemp.toStringAsFixed(0)}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_loadingWeather && _weather == null)
                    const Positioned(
                      top: 12,
                      right: 16,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      ),
                    ),
                ],
              ),

              // ── Actions rapides ──
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    _QuickAction(
                      emoji: '📅',
                      label: 'Calendrier',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const MonthlyCalendarScreen()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _QuickAction(
                      emoji: '📊',
                      label: 'Vue annuelle',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const CalendarGridScreen()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _QuickAction(
                      emoji: '💧',
                      label: daysSinceWater != null
                          ? 'Arrosé il y a ${daysSinceWater}j'
                          : 'Arrosage',
                      onTap: () async {
                        await PrefsService.instance.recordWatering();
                        if (mounted) {
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Arrosage enregistré !')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              // ── À semer ce mois (top 5) ──
              if (toSow.isNotEmpty) ...[
                _DashSection(title: '🌱 À semer en ${_monthName(month)}'),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: toSow.length > 8 ? 8 : toSow.length,
                    itemBuilder: (ctx, i) {
                      final v = toSow[i];
                      return _VegChip(
                        vegetable: v,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                VegetableDetailScreen(vegetable: v),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // ── Bientôt la récolte ──
              if (toHarvest.isNotEmpty) ...[
                _DashSection(title: '🧺 À récolter ce mois'),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: toHarvest.length > 8 ? 8 : toHarvest.length,
                    itemBuilder: (ctx, i) {
                      final v = toHarvest[i];
                      return _VegChip(
                        vegetable: v,
                        color: KultivaColors.terracotta,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                VegetableDetailScreen(vegetable: v),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // ── Légume du jour ──
              _DashSection(title: '✨ Légume du jour'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: ListTile(
                    leading:
                        Text(vegOfDay.emoji, style: const TextStyle(fontSize: 36)),
                    title: Text(vegOfDay.name,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text(
                      vegOfDay.description ?? vegOfDay.note ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            VegetableDetailScreen(vegetable: vegOfDay),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Conseil du jour ──
              _DashSection(title: '💡 Conseil du jour'),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Card(
                  color: KultivaColors.summerA.withOpacity(0.25),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
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

  String _monthName(int m) {
    const names = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
    ];
    return names[m - 1];
  }
}

/// Bouton d'action rapide (chips arrondis).
class _QuickAction extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;
  const _QuickAction(
      {required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: KultivaColors.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 4),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section title dans le dashboard.
class _DashSection extends StatelessWidget {
  final String title;
  const _DashSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

/// Chip légume horizontal scrollable.
class _VegChip extends StatelessWidget {
  final Vegetable vegetable;
  final VoidCallback onTap;
  final Color? color;
  const _VegChip({required this.vegetable, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: (color ?? KultivaColors.primaryGreen).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (color ?? KultivaColors.primaryGreen).withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(vegetable.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                vegetable.name,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
