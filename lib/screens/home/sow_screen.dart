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

/// Dashboard principal — Hero saisonnier + 4 cartes kawaii +
/// légume du jour + conseil du jour.
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

  Vegetable get _vegetableOfTheDay {
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return vegetablesBase[dayOfYear % vegetablesBase.length];
  }

  String get _tipOfTheDay {
    final tips = <String>[];

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

    for (final entry in rotationMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      if (veg != null) {
        tips.add(
            '${veg.emoji} ${veg.name} : attendre ${entry.value.waitYears} ans avant de replanter au même endroit (${entry.value.family}).');
      }
    }

    for (final entry in diseaseMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      if (veg != null && entry.value.isNotEmpty) {
        final d = entry.value.first;
        tips.add(
            '${veg.emoji} ${veg.name} : attention au ${d.name}. Remède bio : ${d.remedy}.');
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

        int sowCount = 0;
        int harvestCount = 0;
        for (final veg in vegetablesBase) {
          for (final rd in data) {
            if (rd.vegetableId == veg.id) {
              if (rd.sowingMonths.contains(month)) sowCount++;
              if (rd.harvestMonths.contains(month)) harvestCount++;
            }
          }
        }

        final vegOfDay = _vegetableOfTheDay;
        final tip = _tipOfTheDay;

        return SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ── Hero saisonnier + météo ──
              Stack(
                children: [
                  SeasonHeader(season: season, month: month, height: 180),
                  if (_weather != null)
                    Positioned(
                      top: 12,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_weather!.weatherEmoji,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
                            Text(
                              '${_weather!.currentTemp.toStringAsFixed(0)}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_loadingWeather && _weather == null)
                    const Positioned(
                      top: 16,
                      right: 20,
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              // ── 4 cartes kawaii en grille 2×2 ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _KawaiiCard(
                            emoji: '🌱',
                            label: 'Semer',
                            subtitle: '$sowCount légumes',
                            gradientColors: const [
                              KultivaColors.springA,
                              KultivaColors.springB,
                            ],
                            bubbleColor: KultivaColors.primaryGreen,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) =>
                                      const MonthlyCalendarScreen()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _KawaiiCard(
                            emoji: '🧺',
                            label: 'Récolter',
                            subtitle: '$harvestCount légumes',
                            gradientColors: const [
                              KultivaColors.summerA,
                              KultivaColors.summerB,
                            ],
                            bubbleColor: KultivaColors.terracotta,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) =>
                                      const MonthlyCalendarScreen()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _KawaiiCard(
                            emoji: '📅',
                            label: 'Calendrier',
                            subtitle: 'Vue annuelle',
                            gradientColors: const [
                              KultivaColors.winterA,
                              KultivaColors.winterB,
                            ],
                            bubbleColor: const Color(0xFF7BAFD4),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) =>
                                      const CalendarGridScreen()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _KawaiiCard(
                            emoji: '🌻',
                            label: 'Du jour',
                            subtitle: vegOfDay.name,
                            gradientColors: const [
                              KultivaColors.autumnA,
                              KultivaColors.autumnB,
                            ],
                            bubbleColor: KultivaColors.terracotta,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => VegetableDetailScreen(
                                    vegetable: vegOfDay),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Légume du jour — carte mise en avant ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _VegOfDayCard(
                  vegetable: vegOfDay,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          VegetableDetailScreen(vegetable: vegOfDay),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Conseil du jour ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TipCard(tip: tip),
              ),

              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kawaii Card — carte carrée avec dégradé pastel, bulles décoratives, emoji
// ─────────────────────────────────────────────────────────────────────────────

class _KawaiiCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String subtitle;
  final List<Color> gradientColors;
  final Color bubbleColor;
  final VoidCallback onTap;

  const _KawaiiCard({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.gradientColors,
    required this.bubbleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Bulles décoratives kawaii.
            Positioned(
              top: -8,
              right: -8,
              child: _Bubble(size: 40, color: bubbleColor.withOpacity(0.15)),
            ),
            Positioned(
              bottom: 10,
              right: 12,
              child: _Bubble(size: 24, color: bubbleColor.withOpacity(0.12)),
            ),
            Positioned(
              top: 20,
              right: 30,
              child: _Bubble(size: 14, color: bubbleColor.withOpacity(0.10)),
            ),
            // Contenu.
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji dans un cercle blanc doux.
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: bubbleColor.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const Spacer(),
                  Text(
                    label,
                    style: TextStyle(
                      color: KultivaColors.textPrimary.withOpacity(0.9),
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: KultivaColors.textPrimary.withOpacity(0.55),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bulle décorative ronde semi-transparente (style kawaii).
class _Bubble extends StatelessWidget {
  final double size;
  final Color color;
  const _Bubble({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Légume du jour — carte illustrée
// ─────────────────────────────────────────────────────────────────────────────

class _VegOfDayCard extends StatelessWidget {
  final Vegetable vegetable;
  final VoidCallback onTap;
  const _VegOfDayCard({required this.vegetable, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KultivaColors.lightGreen.withOpacity(0.25),
              KultivaColors.springA.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: KultivaColors.primaryGreen.withOpacity(0.15),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Emoji dans un cercle pastel.
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: KultivaColors.primaryGreen.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child:
                  Text(vegetable.emoji, style: const TextStyle(fontSize: 30)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✨ Légume du jour',
                    style: TextStyle(
                      color: KultivaColors.primaryGreen.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vegetable.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  if (vegetable.note != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      vegetable.note!,
                      style: TextStyle(
                        color: KultivaColors.textPrimary.withOpacity(0.6),
                        fontSize: 12,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: KultivaColors.primaryGreen.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Conseil du jour — carte avec fond saisonnier doux
// ─────────────────────────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  final String tip;
  const _TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            KultivaColors.summerA.withOpacity(0.2),
            KultivaColors.terracotta.withOpacity(0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: KultivaColors.terracotta.withOpacity(0.15),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text('💡', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conseil du jour',
                  style: TextStyle(
                    color: KultivaColors.terracotta.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
