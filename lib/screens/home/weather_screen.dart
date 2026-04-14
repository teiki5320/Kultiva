import 'package:flutter/material.dart';

import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';

/// Page météo détaillée avec slides par jour.
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final PageController _pageCtrl;
  WeatherData? _weather;
  bool _loading = true;
  int _currentIndex = 7; // aujourd'hui

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(initialPage: 7);
    _load();
  }

  Future<void> _load() async {
    try {
      _weather = await WeatherService.getWeather();
    } catch (_) {}
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  String _dayLabel(int offset) {
    if (offset == 0) return "Aujourd'hui";
    if (offset == -1) return 'Hier';
    if (offset == 1) return 'Demain';
    final date = DateTime.now().add(Duration(days: offset));
    const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return '${days[date.weekday - 1]} ${date.day}';
  }

  String _weatherEmojiForCode(int code) {
    if (code == 0) return '☀️';
    if (code <= 2) return '⛅';
    if (code == 3) return '☁️';
    if (code >= 45 && code <= 48) return '🌫️';
    if (code >= 51 && code <= 67) return '🌧️';
    if (code >= 71 && code <= 77) return '❄️';
    if (code >= 80 && code <= 82) return '🌦️';
    if (code >= 95) return '⛈️';
    return '🌤️';
  }

  String _adviceForDay(double rain, double tmax, double tmin) {
    if (rain > 5) return '🌧️ Pluie prévue — pas besoin d\'arroser !';
    if (rain > 1) return '💧 Légère pluie — arrosage léger suffit';
    if (tmax > 28) return '☀️ Très chaud — arrose tôt le matin ou le soir';
    if (tmin < 2) return '❄️ Risque de gel — protège tes plants sensibles';
    if (tmax - tmin > 15) return '🌡️ Grosse amplitude — surveille tes semis';
    return '🌱 Belle journée pour jardiner !';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header saisonnier.
          Stack(
            children: [
              SeasonHeader(
                season: Season.fromMonth(DateTime.now().month),
                month: DateTime.now().month,
                height: 160,
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
              const Positioned(
                bottom: 16, left: 20,
                child: Text('🌤 Météo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      shadows: [Shadow(color: Colors.black45, blurRadius: 8)],
                    )),
              ),
            ],
          ),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_weather == null)
            const Expanded(child: Center(child: Text('Météo indisponible')))
          else
            Expanded(
              child: Column(
                children: [
                  // Slides jour par jour.
                  Expanded(
                    child: PageView.builder(
                      controller: _pageCtrl,
                      itemCount: _weather!.dailyDates.length,
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      itemBuilder: (_, i) => _buildDaySlide(i),
                    ),
                  ),
                  // Dots + flèches.
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _currentIndex > 0
                              ? () => _pageCtrl.previousPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut)
                              : null,
                        ),
                        Row(
                          children: List.generate(_weather!.dailyDates.length,
                              (i) {
                            final active = i == _currentIndex;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: active ? 20 : 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: active
                                    ? KultivaColors.primaryGreen
                                    : KultivaColors.lightGreen
                                        .withOpacity(0.4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _currentIndex <
                                  _weather!.dailyDates.length - 1
                              ? () => _pageCtrl.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDaySlide(int dayIndex) {
    final w = _weather!;
    final offset = dayIndex - 7; // 7 = today
    final tmax = w.dailyTempMax[dayIndex];
    final tmin = w.dailyTempMin[dayIndex];
    final rain = w.dailyPrecipitation[dayIndex];
    // Pour aujourd'hui utiliser le code météo actuel.
    final emoji = offset == 0 ? w.weatherEmoji : _weatherEmojiForCode(0);
    final advice = _adviceForDay(rain, tmax, tmin);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(_dayLabel(offset),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: KultivaColors.textPrimary,
              )),
          const SizedBox(height: 8),
          Text(emoji, style: const TextStyle(fontSize: 80)),
          const SizedBox(height: 8),
          if (offset == 0) ...[
            Text('${w.currentTemp.toStringAsFixed(0)}°C',
                style: const TextStyle(
                    fontSize: 48, fontWeight: FontWeight.w800)),
            Text(w.weatherLabel,
                style: TextStyle(
                    fontSize: 14, color: KultivaColors.textSecondary)),
          ] else
            Text('${tmax.toStringAsFixed(0)}°C',
                style: const TextStyle(
                    fontSize: 48, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          // Température min/max.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: KultivaColors.lightGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🌡', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text('Min ${tmin.toStringAsFixed(0)}°',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(width: 16),
                Text('Max ${tmax.toStringAsFixed(0)}°',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Précipitations.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7).withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('💧', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text('${rain.toStringAsFixed(1)} mm de pluie',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Conseil jardinage.
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                KultivaColors.summerA.withOpacity(0.3),
                KultivaColors.terracotta.withOpacity(0.15),
              ]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: KultivaColors.terracotta.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💡 Conseil jardinage',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: KultivaColors.terracotta.withOpacity(0.8),
                    )),
                const SizedBox(height: 6),
                Text(advice,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
