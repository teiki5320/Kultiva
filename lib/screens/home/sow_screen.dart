import '../../data/names_en.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/regions/regional_calendar.dart';
import '../../data/ui_i18n.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../models/weather_data.dart';
import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/conseil_du_jour.dart';
import '../../utils/text_scale.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import '../vegetable_detail_screen.dart';
import '../../services/audio_service.dart';
import 'calendar_grid_screen.dart';
import 'monthly_calendar_screen.dart';
import 'defis/defis_badges_screen.dart';
import 'weather_screen.dart';
import 'accueil/accueil_cartes.dart';
import 'accueil/accueil_diapos.dart';
import '../../widgets/grille_adaptative.dart';
import '../../widgets/readable_width.dart';

/// URL Instagram Kultiva — ouverte au tap sur la carte « Actualités ».
/// Le compte sert d'actualités (publications + stories) plutôt que de
/// gérer un feed maison côté app.
const String _kInstagramUrl = 'https://www.instagram.com/toa.kultiva/';

/// Dashboard principal — Hero saisonnier + 6 cartes kawaii 3×2
/// (Semer, Récolter, Calendrier, Légume du jour, Cahier de culture,
/// Actualités) + carrousel de slides (légume, météo, conseil, saison).
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

  /// Le calendrier est passé, pas lu ici : c'est lui qui dit si une
  /// culture pousse chez cet utilisateur.
  Vegetable _vegetableOfTheDay(List<RegionData> calendar) =>
      vegetableOfTheDay(DateTime.now(), calendar: calendar);


  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = now.month;

    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final season = Season.current(month);
        final data = currentCalendar();

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

        final vegOfDay = _vegetableOfTheDay(data);
        final tip = conseilDuJour(DateTime.now(), data);

        // ── Build slides ──
        final slides = <Widget>[
          SlideVegOfDay(vegetable: vegOfDay),
          SlideWeather(weather: _weather, loading: _loadingWeather),
          SlideTip(tip: tip),
          SlideSeason(
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
                  SeasonHeader(
                      season: season, month: month, height: kPageHeaderHeight),
                  Positioned(
                    top: 8,
                    right: 12,
                    child: Semantics(
                      label: trUi('Paramètres'),
                      button: true,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const SettingsProxy(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.settings,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                  // Bulle météo sous l'icône paramètres.
                  if (_weather != null)
                    Positioned(
                      top: 48,
                      right: 12,
                      child: Semantics(
                        label: trUiArgs('Météo : {0} degrés, {1}', <Object?>[
                          _weather!.currentTemp.toStringAsFixed(0),
                          _weather!.weatherLabel
                        ]),
                        button: true,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (_) => const WeatherScreen()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(_weather!.weatherEmoji,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 4),
                                Text(
                                  '${_weather!.currentTemp.toStringAsFixed(0)}°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Les six cartes, en grille qui suit la largeur ──
              //
              // Deux colonnes sur un téléphone, trois sur un iPad : la
              // grille les compte elle-même d'après la place. Avant le
              // 03/11/2026 c'était trois `Row` de deux `Expanded`,
              // donc deux colonnes quelle que soit la largeur — et sur
              // 1 032 points, des tuiles deux fois et demie plus larges
              // que hautes.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GrilleAdaptative(
                  // ⚠️ 160 et non 200 : sur un téléphone de 375 points
                  // il reste 343 après les marges, et une cible de 200
                  // n'y fait tenir **qu'une** colonne. Le tableau de
                  // bord serait passé à une carte par ligne sur
                  // iPhone — l'inverse du défaut qu'on corrige.
                  largeurCible: 160,
                  colonnesMax: 3,
                  enfants: <Widget>[
                    KawaiiCard(
                      emoji: '🌱',
                      imagePath: 'assets/images/card_semer.png',
                      label: trUi('Semer'),
                      subtitle:
                          trUiArgs('{0} légumes', <Object?>[toSow.length]),
                      gradientColors: const [
                        KultivaColors.springA,
                        KultivaColors.springB,
                      ],
                      bubbleColor: KultivaColors.primaryGreen,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const MonthlyCalendarScreen(
                                mode: CalendarMode.sow)),
                      ),
                    ),
                    KawaiiCard(
                      emoji: '🧺',
                      imagePath: 'assets/images/card_recolter.png',
                      label: trUi('Récolter'),
                      subtitle:
                          trUiArgs('{0} légumes', <Object?>[toHarvest.length]),
                      gradientColors: const [
                        KultivaColors.summerA,
                        KultivaColors.summerB,
                      ],
                      bubbleColor: KultivaColors.terracotta,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const MonthlyCalendarScreen(
                                mode: CalendarMode.harvest)),
                      ),
                    ),
                    KawaiiCard(
                      emoji: '📅',
                      imagePath: 'assets/images/card_calendrier.png',
                      label: trUi('Calendrier'),
                      subtitle: trUi('Vue annuelle'),
                      gradientColors: const [
                        KultivaColors.winterA,
                        KultivaColors.winterB,
                      ],
                      bubbleColor: const Color(0xFF7BAFD4),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const CalendarGridScreen()),
                      ),
                    ),
                    KawaiiCard(
                      emoji: '🌻',
                      imagePath: 'assets/images/card_dujour.png',
                      label: trUi('Légume du jour'),
                      subtitle: vegOfDay.displayName,
                      gradientColors: const [
                        KultivaColors.autumnA,
                        KultivaColors.autumnB,
                      ],
                      bubbleColor: KultivaColors.terracotta,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              VegetableDetailScreen(vegetable: vegOfDay),
                        ),
                      ),
                    ),
                    KawaiiCard(
                      emoji: '📸',
                      imagePath: null,
                      label: trUi('Défis & badges'),
                      subtitle: trUi('50 défis, 50 badges'),
                      gradientColors: const [
                        KultivaColors.springA,
                        KultivaColors.springB,
                      ],
                      bubbleColor: KultivaColors.primaryGreen,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const DefisBadgesScreen(),
                        ),
                      ),
                    ),
                    KawaiiCard(
                      emoji: '📸',
                      imagePath: null,
                      label: trUi('Actualités'),
                      subtitle: trUi('Suis-nous sur Instagram'),
                      gradientColors: const [
                        KultivaColors.summerA,
                        KultivaColors.summerB,
                      ],
                      bubbleColor: KultivaColors.terracotta,
                      onTap: () => _openInstagram(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Carrousel de slides ──
              //
              // ⚠️ Borné, contrairement à la grille au-dessus. Une
              // diapositive porte une phrase — « Bananier plantain
              // adore pousser à côté de Taro ! ». À 88 % de 1 032
              // points, elle s'étalait sur 908 points pour cette seule
              // ligne. Une grille gagne à s'élargir, une phrase non.
              ReadableWidth(
                maxWidth: 620,
                child: SizedBox(
                height: scaledHeight(context, 160),
                child: PageView.builder(
                  controller: _slideController,
                  itemCount: slides.length,
                  onPageChanged: (i) => setState(() => _currentSlide = i),
                  itemBuilder: (_, i) {
                    VoidCallback? onTap;
                    if (i == 0) {
                      // Légume du jour → fiche détail.
                      onTap = () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  VegetableDetailScreen(vegetable: vegOfDay),
                            ),
                          );
                    } else if (i == 1) {
                      // Météo → page météo.
                      onTap = () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (_) => const WeatherScreen()),
                          );
                    } else if (i == 3) {
                      // Saison → calendrier mensuel.
                      onTap = () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (_) => const MonthlyCalendarScreen()),
                          );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Semantics(
                        button: onTap != null,
                        child: GestureDetector(
                          onTap: onTap,
                          child: slides[i],
                        ),
                      ),
                    );
                  },
                ),
              )),
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
                          : KultivaColors.lightGreen.withValues(alpha: 0.5),
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

  /// Ouvre le compte Instagram Kultiva dans le navigateur ou l'app
  /// Instagram. Affiche un snackbar discret si l'URL ne peut pas
  /// être ouverte (rare, mais évite un crash silencieux).
  Future<void> _openInstagram(BuildContext context) async {
    AudioService.instance.play(Sfx.tap);
    final uri = Uri.parse(_kInstagramUrl);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(trUi('Impossible d\'ouvrir Instagram pour le moment.')),
        ),
      );
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Kawaii Cards (grille 2×2)
// ═══════════════════════════════════════════════════════════════════════════════
