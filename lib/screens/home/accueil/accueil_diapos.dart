/// Le carrousel du tableau de bord : légume du jour, météo, astuce et saison, posés sur une diapo commune.
///
/// ⚠️ Ces widgets vivaient dans `sow_screen.dart`,
/// 1 051 lignes dont 570 de décor. L'écran ne garde que ce qui
/// calcule.
library;

import '../../../../data/content_i18n.dart';
import '../../../../data/names_en.dart';

import 'accueil_cartes.dart';
import 'package:flutter/material.dart';
import '../../../../data/ui_i18n.dart';
import '../../../../models/vegetable.dart';
import '../../../../models/weather_data.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/months.dart';
import '../../../../utils/text_scale.dart';
import '../../../../widgets/petal_animation.dart';
import '../settings_screen.dart';

/// Base décorative commune à tous les slides.
class SlideBase extends StatelessWidget {
  final List<Color> gradientColors;
  final Color bubbleColor;
  final Widget child;

  const SlideBase({
    super.key,
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
            color: gradientColors.last.withValues(alpha: 0.25),
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
            child: Bubble(size: 50, color: bubbleColor.withValues(alpha: 0.12)),
          ),
          Positioned(
            bottom: 14,
            right: 20,
            child: Bubble(size: 28, color: bubbleColor.withValues(alpha: 0.10)),
          ),
          Positioned(
            top: 30,
            right: 50,
            child: Bubble(size: 16, color: bubbleColor.withValues(alpha: 0.08)),
          ),
          Positioned(
            bottom: 40,
            left: -10,
            child: Bubble(size: 32, color: bubbleColor.withValues(alpha: 0.06)),
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

/// Slide 1 — Légume du jour.
class SlideVegOfDay extends StatelessWidget {
  final Vegetable vegetable;
  const SlideVegOfDay({super.key, required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return SlideBase(
      gradientColors: [
        KultivaColors.lightGreen.withValues(alpha: 0.35),
        KultivaColors.springA.withValues(alpha: 0.45),
      ],
      bubbleColor: KultivaColors.primaryGreen,
      child: Row(
        children: [
          Container(
            width: scaledHeight(context, 60),
            height: scaledHeight(context, 60),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: KultivaColors.primaryGreen.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(vegetable.emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trUi('✨ Légume du jour'),
                  style: TextStyle(
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  vegetable.displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                if (vegetable.displayNote != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    vegetable.displayNote!,
                    style: TextStyle(
                      color: KultivaColors.textPrimary.withValues(alpha: 0.55),
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

/// Slide 2 — Météo.
class SlideWeather extends StatelessWidget {
  final WeatherData? weather;
  final bool loading;
  const SlideWeather({super.key, required this.weather, required this.loading});

  @override
  Widget build(BuildContext context) {
    return SlideBase(
      gradientColors: [
        KultivaColors.winterA.withValues(alpha: 0.5),
        const Color(0xFFD6ECFA),
      ],
      bubbleColor: const Color(0xFF7BAFD4),
      child: weather != null
          ? Row(
              children: [
                Container(
                  width: scaledHeight(context, 60),
                  height: scaledHeight(context, 60),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.75),
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
                        trUi('🌤 Météo du jour'),
                        style: TextStyle(
                          color: const Color(0xFF5A8FB8).withValues(alpha: 0.8),
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
                            ? trUiArgs(
                                '{0} mm de pluie prévus sous 3 jours',
                                <Object?>[
                                    weather!.rainNext3Days.toStringAsFixed(1)
                                  ])
                            : trUi('Pas de pluie prévue sur 3 jours'),
                        style: TextStyle(
                          color:
                              KultivaColors.textPrimary.withValues(alpha: 0.55),
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
                            color:
                                const Color(0xFF7BAFD4).withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          trUi('Chargement météo...'),
                          style: TextStyle(
                            color: KultivaColors.textPrimary
                                .withValues(alpha: 0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      trUi(
                          'Météo indisponible\nActive la localisation pour les prévisions'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: KultivaColors.textPrimary.withValues(alpha: 0.5),
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

/// Slide 3 — Conseil du jour.
class SlideTip extends StatelessWidget {
  final String tip;
  const SlideTip({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return SlideBase(
      gradientColors: [
        KultivaColors.summerA.withValues(alpha: 0.35),
        KultivaColors.terracotta.withValues(alpha: 0.2),
      ],
      bubbleColor: KultivaColors.terracotta,
      child: Row(
        children: [
          Container(
            width: scaledHeight(context, 52),
            height: scaledHeight(context, 52),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
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
                  trUi('Conseil du jour'),
                  style: TextStyle(
                    color: KultivaColors.terracotta.withValues(alpha: 0.8),
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

/// Slide 4 — En saison (résumé semis/récoltes).
class SettingsProxy extends StatelessWidget {
  const SettingsProxy({super.key});

  @override
  Widget build(BuildContext context) => const SettingsScreen();
}

class SlideSeason extends StatelessWidget {
  final Season season;
  final int month;
  final int sowCount;
  final int harvestCount;
  const SlideSeason({
    super.key,
    required this.season,
    required this.month,
    required this.sowCount,
    required this.harvestCount,
  });

  @override
  Widget build(BuildContext context) {
    return SlideBase(
      gradientColors: [
        KultivaColors.autumnA.withValues(alpha: 0.35),
        KultivaColors.springB.withValues(alpha: 0.3),
      ],
      bubbleColor: KultivaColors.primaryGreen,
      child: Row(
        children: [
          Container(
            width: scaledHeight(context, 60),
            height: scaledHeight(context, 60),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
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
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  trUiArgs('En {0}', <Object?>[monthNamesLong[month - 1]]),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  trUiArgs('🌱 {0} à semer  ·  🧺 {1} à récolter',
                      <Object?>[sowCount, harvestCount]),
                  style: TextStyle(
                    color: KultivaColors.textPrimary.withValues(alpha: 0.55),
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
