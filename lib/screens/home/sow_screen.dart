import 'dart:async';

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
import 'settings_screen.dart';

/// Dashboard principal — Hero saisonnier + 4 cartes kawaii +
/// carrousel de slides (légume, météo, conseil, saison).
class SowScreen extends StatefulWidget {
  const SowScreen({super.key});

  @override
  State<SowScreen> createState() => _SowScreenState();
}

class _SowScreenState extends State<SowScreen> {
  WeatherData? _weather;
  bool _loadingWeather = false;

  // Carrousel.
  late final PageController _slideController;
  int _currentSlide = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _slideController = PageController(viewportFraction: 0.88);
    _loadWeather();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _slideController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!_slideController.hasClients) return;
      final next = (_currentSlide + 1) % 4;
      _slideController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
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
            '${veg.emoji} ${veg.name} : attendre ${entry.value.waitYears} ans avant de replanter au même endroit.');
      }
    }

    for (final entry in diseaseMap.entries) {
      final veg = vegetablesBase.where((v) => v.id == entry.key).firstOrNull;
      if (veg != null && entry.value.isNotEmpty) {
        final d = entry.value.first;
        tips.add(
            '${veg.emoji} ${veg.name} : attention au ${d.name}. ${d.remedy}.');
      }
    }

    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return tips[dayOfYear % tips.length];
  }

  static const List<String> _monthNames = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = now.month;
    final season = Season.fromMonth(month);

    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final data = _dataFor(region);

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

        // ── Build slides ──
        final slides = <Widget>[
          _SlideVegOfDay(vegetable: vegOfDay),
          _SlideWeather(weather: _weather, loading: _loadingWeather),
          _SlideTip(tip: tip),
          _SlideSeason(
            season: season,
            month: month,
            sowCount: toSow.length,
            harvestCount: toHarvest.length,
          ),
        ];

        return SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ── Hero saisonnier + engrenage paramètres ──
              Stack(
                children: [
                  SeasonHeader(season: season, month: month, height: 170),
                  Positioned(
                    top: 8,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => _SettingsProxy(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.settings,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── 4 cartes kawaii 2×2 ──
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
                            subtitle: '${toSow.length} légumes',
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
                            subtitle: '${toHarvest.length} légumes',
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

              // ── Carrousel de slides ──
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _slideController,
                  itemCount: slides.length,
                  onPageChanged: (i) => setState(() => _currentSlide = i),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: slides[i],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Dots.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(slides.length, (i) {
                  final active = i == _currentSlide;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: active ? 22 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: active
                          ? KultivaColors.primaryGreen
                          : KultivaColors.lightGreen.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Kawaii Cards (grille 2×2)
// ═══════════════════════════════════════════════════════════════════════════════

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
          clipBehavior: Clip.hardEdge,
          children: [
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

// ═══════════════════════════════════════════════════════════════════════════════
// Slides du carrousel
// ═══════════════════════════════════════════════════════════════════════════════

/// Base décorative commune à tous les slides.
class _SlideBase extends StatelessWidget {
  final List<Color> gradientColors;
  final Color bubbleColor;
  final Widget child;

  const _SlideBase({
    required this.gradientColors,
    required this.bubbleColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Bulles kawaii décoratives.
          Positioned(
            top: -12,
            right: -12,
            child: _Bubble(size: 50, color: bubbleColor.withOpacity(0.12)),
          ),
          Positioned(
            bottom: 14,
            right: 20,
            child: _Bubble(size: 28, color: bubbleColor.withOpacity(0.10)),
          ),
          Positioned(
            top: 30,
            right: 50,
            child: _Bubble(size: 16, color: bubbleColor.withOpacity(0.08)),
          ),
          Positioned(
            bottom: 40,
            left: -10,
            child: _Bubble(size: 32, color: bubbleColor.withOpacity(0.06)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Slide 1 — Légume du jour.
class _SlideVegOfDay extends StatelessWidget {
  final Vegetable vegetable;
  const _SlideVegOfDay({required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return _SlideBase(
      gradientColors: [
        KultivaColors.lightGreen.withOpacity(0.35),
        KultivaColors.springA.withOpacity(0.45),
      ],
      bubbleColor: KultivaColors.primaryGreen,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
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
            child: Text(vegetable.emoji,
                style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 6),
                Text(
                  vegetable.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                if (vegetable.note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    vegetable.note!,
                    style: TextStyle(
                      color: KultivaColors.textPrimary.withOpacity(0.55),
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
        ],
      ),
    );
  }
}

/// Slide 2 — Météo.
class _SlideWeather extends StatelessWidget {
  final WeatherData? weather;
  final bool loading;
  const _SlideWeather({required this.weather, required this.loading});

  @override
  Widget build(BuildContext context) {
    return _SlideBase(
      gradientColors: [
        KultivaColors.winterA.withOpacity(0.5),
        const Color(0xFFD6ECFA),
      ],
      bubbleColor: const Color(0xFF7BAFD4),
      child: weather != null
          ? Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(weather!.weatherEmoji,
                      style: const TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '🌤 Météo du jour',
                        style: TextStyle(
                          color: const Color(0xFF5A8FB8).withOpacity(0.8),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${weather!.currentTemp.toStringAsFixed(0)}°C — ${weather!.weatherLabel}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        weather!.rainNext3Days > 0
                            ? '${weather!.rainNext3Days.toStringAsFixed(1)} mm de pluie prévus sous 3 jours'
                            : 'Pas de pluie prévue sur 3 jours',
                        style: TextStyle(
                          color: KultivaColors.textPrimary.withOpacity(0.55),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: loading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: const Color(0xFF7BAFD4).withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Chargement météo...',
                          style: TextStyle(
                            color: KultivaColors.textPrimary.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Météo indisponible\nActive la localisation pour les prévisions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: KultivaColors.textPrimary.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
            ),
    );
  }
}

/// Slide 3 — Conseil du jour.
class _SlideTip extends StatelessWidget {
  final String tip;
  const _SlideTip({required this.tip});

  @override
  Widget build(BuildContext context) {
    return _SlideBase(
      gradientColors: [
        KultivaColors.summerA.withOpacity(0.35),
        KultivaColors.terracotta.withOpacity(0.2),
      ],
      bubbleColor: KultivaColors.terracotta,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text('💡', style: TextStyle(fontSize: 26)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Slide 4 — En saison (résumé semis/récoltes).
/// Proxy pour ouvrir les paramètres sans connaître onSignOut.
class _SettingsProxy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(onSignOut: () => Navigator.of(context).pop());
  }
}

class _SlideSeason extends StatelessWidget {
  final Season season;
  final int month;
  final int sowCount;
  final int harvestCount;
  const _SlideSeason({
    required this.season,
    required this.month,
    required this.sowCount,
    required this.harvestCount,
  });

  static const List<String> _monthNames = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  @override
  Widget build(BuildContext context) {
    return _SlideBase(
      gradientColors: [
        KultivaColors.autumnA.withOpacity(0.35),
        KultivaColors.springB.withOpacity(0.3),
      ],
      bubbleColor: KultivaColors.primaryGreen,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(season.emoji, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${season.emoji} ${season.label}',
                  style: TextStyle(
                    color: KultivaColors.primaryGreen.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'En ${_monthNames[month - 1]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '🌱 $sowCount à semer  ·  🧺 $harvestCount à récolter',
                  style: TextStyle(
                    color: KultivaColors.textPrimary.withOpacity(0.55),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
