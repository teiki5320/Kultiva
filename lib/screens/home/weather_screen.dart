import 'package:flutter/material.dart';

import '../../data/ui_i18n.dart';
import '../../utils/months.dart';
import '../../services/photo_service.dart';
import '../../services/prefs_service.dart';
import '../../models/weather_data.dart';
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

  /// Recharge la météo en invalidant le cache. Utile si l'utilisateur
  /// vient d'activer la géoloc dans les réglages.
  Future<void> _refreshWeather() async {
    WeatherService.invalidateCache();
    setState(() => _loading = true);
    await _load();
  }

  /// Pill "📍 `<ville>`" affichée sous "🌤 Météo". Cliquable seulement si
  /// on est en fallback Paris (propose d'ouvrir les Réglages pour la
  /// géolocalisation).
  Widget _buildLocationPill() {
    final isFallback = _weather?.isFallbackLocation ?? false;
    final String text;
    if (_weather == null) {
      text = '📍 …';
    } else if (isFallback) {
      text = trUiArgs('📍 {0} · localisation désactivée',
          <Object?>[_weather!.locationName ?? 'Paris']);
    } else {
      text = '📍 ${_weather!.locationName ?? trUi('Ma position')}';
    }

    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );

    if (isFallback) {
      return GestureDetector(onTap: _showFallbackInfo, child: pill);
    }
    return pill;
  }

  Future<void> _showFallbackInfo() async {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: <Widget>[
            const Text('📍', style: TextStyle(fontSize: 26)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(trUi('Localisation désactivée'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 17)),
            ),
          ],
        ),
        content: Text(
          trUi('Pour te montrer la météo de ton jardin, Kultiva a besoin '
              'd\'accéder à ta position.\n\n'
              'En attendant, on affiche la météo de Paris par défaut. '
              'Tu peux autoriser la localisation dans les réglages.'),
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(trUi('Plus tard')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: KultivaColors.primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await PhotoService.openSettings();
            },
            child: Text(trUi('Ouvrir les Réglages'),
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  String _dayLabel(int offset) {
    if (offset == 0) return trUi("Aujourd'hui");
    if (offset == -1) return trUi('Hier');
    if (offset == 1) return trUi('Demain');
    final date = DateTime.now().add(Duration(days: offset));
    // ⚠️ Pas `trUi('Mar')` : « Mar » est aussi mars, et une clé ne
    // peut pas rendre mardi d'un côté et March de l'autre.
    return '${weekdayNamesShort[date.weekday - 1]} ${date.day}';
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

  /// Formate une température, ou « — » si Open-Meteo n'a pas fourni la
  /// valeur du jour (marquée NaN à la lecture).
  String _temp(double t) => t.isNaN ? '—' : '${t.toStringAsFixed(0)}°';

  String _adviceForDay(double rain, double tmax, double tmin) {
    if (rain > 5) return trUi('🌧️ Pluie prévue — pas besoin d\'arroser !');
    if (rain > 1) return trUi('💧 Légère pluie — arrosage léger suffit');
    // Sans température, on ne se prononce pas sur la chaleur, le gel
    // ni l'amplitude : les tests ci-dessous seraient tous faux avec
    // NaN et l'app annoncerait « belle journée » sans rien en savoir.
    if (tmax.isNaN || tmin.isNaN) {
      return trUi('🌱 Température du jour indisponible');
    }
    if (tmax > 28) {
      return trUi('☀️ Très chaud — arrose tôt le matin ou le soir');
    }
    if (tmin < 2) {
      return trUi('❄️ Risque de gel — protège tes plants sensibles');
    }
    if (tmax - tmin > 15) {
      return trUi('🌡️ Grosse amplitude — surveille tes semis');
    }
    return trUi('🌱 Belle journée pour jardiner !');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header saisonnier — mois masqué, on injecte notre propre
          // titre "🌤 Météo" + localisation à la place.
          Stack(
            children: [
              SeasonHeader(
                season: Season.of(
                    DateTime.now().month, PrefsService.instance.region.value,
                    zone: PrefsService.instance.effectiveZone),
                month: DateTime.now().month,
                height: kPageHeaderHeight,
                hideLabel: true,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: SafeArea(
                  child: Semantics(
                    label: trUi('Retour'),
                    button: true,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: SafeArea(
                  child: Semantics(
                    label: trUi('Rafraîchir la météo'),
                    button: true,
                    child: GestureDetector(
                      onTap: _refreshWeather,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.refresh,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(trUi('🌤 Météo'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          shadows: [
                            Shadow(color: Colors.black45, blurRadius: 8),
                          ],
                        )),
                    const SizedBox(height: 6),
                    _buildLocationPill(),
                  ],
                ),
              ),
            ],
          ),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_weather == null)
            Expanded(child: Center(child: Text(trUi('Météo indisponible'))))
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
                          tooltip: trUi('Jour précédent'),
                          onPressed: _currentIndex > 0
                              ? () => _pageCtrl.previousPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut)
                              : null,
                        ),
                        Row(
                          children:
                              List.generate(_weather!.dailyDates.length, (i) {
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
                                        .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          tooltip: trUi('Jour suivant'),
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

    final String daySemanticLabel = offset == 0
        ? trUiArgs('{0}, {1} degrés, {2}', <Object?>[
            _dayLabel(offset),
            w.currentTemp.toStringAsFixed(0),
            w.weatherLabel,
          ])
        : trUiArgs('{0}, max {1}', <Object?>[_dayLabel(offset), _temp(tmax)]);

    return Semantics(
      label: daySemanticLabel,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(_dayLabel(offset),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.textPrimary,
                )),
            const SizedBox(height: 8),
            ExcludeSemantics(
              child: Text(emoji, style: const TextStyle(fontSize: 80)),
            ),
            const SizedBox(height: 8),
            if (offset == 0) ...[
              Semantics(
                label: trUiArgs(
                    '{0} degrés', <Object?>[w.currentTemp.toStringAsFixed(0)]),
                child: Text('${w.currentTemp.toStringAsFixed(0)}°C',
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w800)),
              ),
              Text(w.weatherLabel,
                  style: const TextStyle(
                      fontSize: 14, color: KultivaColors.textSecondary)),
            ] else
              Semantics(
                label: tmax.isNaN
                    ? trUi('température indisponible')
                    : trUiArgs(
                        '{0} degrés', <Object?>[tmax.toStringAsFixed(0)]),
                child: Text(_temp(tmax),
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w800)),
              ),
            const SizedBox(height: 16),
            // Température min/max.
            Semantics(
              label:
                  trUiArgs('Minimum {0} degrés, maximum {1} degrés', <Object?>[
                tmin.toStringAsFixed(0),
                tmax.toStringAsFixed(0),
              ]),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: KultivaColors.lightGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ExcludeSemantics(
                        child: Text('🌡', style: TextStyle(fontSize: 18))),
                    const SizedBox(width: 8),
                    Text(trUiArgs('Min {0}', <Object?>[_temp(tmin)]),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(width: 16),
                    Text(trUiArgs('Max {0}', <Object?>[_temp(tmax)]),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Précipitations.
            Semantics(
              label: trUiArgs('{0} millimètres de pluie',
                  <Object?>[rain.toStringAsFixed(1)]),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: KultivaColors.waterBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ExcludeSemantics(
                        child: Text('💧', style: TextStyle(fontSize: 18))),
                    const SizedBox(width: 8),
                    Text(
                        trUiArgs('{0} mm de pluie',
                            <Object?>[rain.toStringAsFixed(1)]),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Conseil jardinage.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  KultivaColors.summerA.withValues(alpha: 0.3),
                  KultivaColors.terracotta.withValues(alpha: 0.15),
                ]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: KultivaColors.terracotta.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trUi('💡 Conseil jardinage'),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: KultivaColors.terracotta.withValues(alpha: 0.8),
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
      ),
    );
  }
}
