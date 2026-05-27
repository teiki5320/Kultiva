import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/weather_data.dart';
import '../../../services/weather_service.dart';
import '../my_garden_screen.dart';

/// Fond kawaii dynamique : gradient selon l'heure du jour, particules
/// selon la météo réelle (Open-Meteo) ou la saison en fallback.
class KawaiiBackground extends StatefulWidget {
  const KawaiiBackground({super.key});

  @override
  State<KawaiiBackground> createState() => KawaiiBackgroundState();
}

class KawaiiBackgroundState extends State<KawaiiBackground>
    with SingleTickerProviderStateMixin {
  WeatherData? _weather;
  late final AnimationController _particleCtrl;

  @override
  void initState() {
    super.initState();
    _particleCtrl = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _loadWeather();
    debugHourOverride.addListener(_onHourChanged);
  }

  void _onHourChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    debugHourOverride.removeListener(_onHourChanged);
    _particleCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadWeather() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weather = w);
  }

  @override
  Widget build(BuildContext context) {
    final hour = effectiveHour();
    final isNight = hour >= 21 || hour < 6;
    final gradient = _gradientForHour(hour);
    final assetPath = _backgroundAssetForHour(hour);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Fond : image PNG si dispo, sinon gradient procédural.
        Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
              ..._staticDecorations(hour),
            ],
          ),
        ),
        // Particules météo / saison (toujours par-dessus).
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _particleCtrl,
            builder: (_, __) => CustomPaint(
              painter: WeatherParticlePainter(
                weatherCode: _weather?.currentWeatherCode,
                progress: _particleCtrl.value,
                isNight: isNight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _backgroundAssetForHour(int hour) {
    if (hour >= 6 && hour < 12) {
      return 'assets/images/backgrounds/morning.png';
    }
    if (hour >= 12 && hour < 18) {
      return 'assets/images/backgrounds/afternoon.png';
    }
    if (hour >= 18 && hour < 21) {
      return 'assets/images/backgrounds/evening.png';
    }
    return 'assets/images/backgrounds/night.png';
  }

  LinearGradient _gradientForHour(int hour) {
    if (hour >= 6 && hour < 12) {
      // Matin.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFFFF0E0), // orange rosé clair
          Color(0xFFE9F6FF), // bleu ciel
          Color(0xFFDCF2D4), // herbe
        ],
      );
    } else if (hour >= 12 && hour < 18) {
      // Après-midi.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFE9F6FF),
          Color(0xFFFFE9F1),
          Color(0xFFDCF2D4),
        ],
      );
    } else if (hour >= 18 && hour < 21) {
      // Soir.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFFFD6A5), // coucher de soleil
          Color(0xFFFFB4C2), // rose chaud
          Color(0xFFC8DFBB), // herbe sombre
        ],
      );
    } else {
      // Nuit.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFF1A1A3E), // bleu nuit profond
          Color(0xFF2D2B55), // violet nuit
          Color(0xFF1C3A2A), // herbe nuit
        ],
      );
    }
  }

  List<Widget> _staticDecorations(int hour) {
    final isNight = hour >= 21 || hour < 6;
    if (isNight) {
      return <Widget>[
        // Lune.
        const Positioned(
          top: 20, right: 30,
          child: Text('🌙', style: TextStyle(fontSize: 42)),
        ),
        // Étoiles.
        const Positioned(top: 30, left: 40,
          child: Text('⭐', style: TextStyle(fontSize: 14))),
        const Positioned(top: 60, left: 140,
          child: Text('⭐', style: TextStyle(fontSize: 10))),
        const Positioned(top: 80, right: 80,
          child: Text('⭐', style: TextStyle(fontSize: 12))),
        const Positioned(top: 120, left: 60,
          child: Text('⭐', style: TextStyle(fontSize: 8))),
        const Positioned(top: 50, right: 150,
          child: Text('⭐', style: TextStyle(fontSize: 11))),
        const Positioned(top: 160, right: 50,
          child: Text('⭐', style: TextStyle(fontSize: 9))),
      ];
    }
    // Jour.
    final isSunny = _weather == null ||
        (_weather!.currentWeatherCode <= 2);
    return <Widget>[
      if (isSunny)
        const Positioned(top: 15, right: 25,
          child: Text('☀️', style: TextStyle(fontSize: 36)))
      else ...<Widget>[
        Positioned(top: 20, left: 30,
          child: Text('☁️', style: TextStyle(
            fontSize: 44, color: Colors.white.withValues(alpha: 0.9)))),
        Positioned(top: 60, right: 40,
          child: Text('☁️', style: TextStyle(
            fontSize: 32, color: Colors.white.withValues(alpha: 0.8)))),
        Positioned(top: 140, left: 20,
          child: Text('☁️', style: TextStyle(
            fontSize: 28, color: Colors.white.withValues(alpha: 0.7)))),
      ],
      const Positioned(bottom: 20, left: 20,
        child: Text('🌸', style: TextStyle(fontSize: 26))),
      const Positioned(bottom: 40, right: 30,
        child: Text('🌼', style: TextStyle(fontSize: 22))),
      const Positioned(bottom: 12, left: 160,
        child: Text('🌿', style: TextStyle(fontSize: 20))),
    ];
  }
}

/// Painter de particules selon la météo ou la saison.
class WeatherParticlePainter extends CustomPainter {
  final int? weatherCode;
  final double progress;
  final bool isNight;

  WeatherParticlePainter({
    required this.weatherCode,
    required this.progress,
    required this.isNight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final type = _resolveType();
    switch (type) {
      case WeatherType.rain:
        _paintRain(canvas, size, heavy: false);
        break;
      case WeatherType.heavyRain:
        _paintRain(canvas, size, heavy: true);
        break;
      case WeatherType.snow:
        _paintSnow(canvas, size);
        break;
      case WeatherType.storm:
        _paintRain(canvas, size, heavy: true);
        _paintLightning(canvas, size);
        break;
      case WeatherType.clear:
        if (isNight) {
          _paintFireflies(canvas, size);
        } else {
          _paintSunSparkles(canvas, size);
        }
        break;
      case WeatherType.cloudy:
        break; // les nuages sont déjà en emoji statique
      case WeatherType.petals:
        _paintFallingPetals(canvas, size);
        break;
      case WeatherType.leaves:
        _paintFallingLeaves(canvas, size);
        break;
    }
  }

  WeatherType _resolveType() {
    if (weatherCode != null) {
      final c = weatherCode!;
      if (c >= 95) return WeatherType.storm;
      if (c >= 71 && c <= 77) return WeatherType.snow;
      if (c >= 61 && c <= 67 || c >= 80 && c <= 82) {
        return WeatherType.heavyRain;
      }
      if (c >= 51 && c <= 57) return WeatherType.rain;
      if (c >= 1 && c <= 3) return WeatherType.cloudy;
      return WeatherType.clear;
    }
    // Fallback saisonnier.
    final month = DateTime.now().month;
    if (month >= 3 && month <= 5) return WeatherType.petals;
    if (month >= 6 && month <= 8) return WeatherType.clear;
    if (month >= 9 && month <= 11) return WeatherType.leaves;
    return WeatherType.snow;
  }

  void _paintRain(Canvas canvas, Size size, {required bool heavy}) {
    final rng = Random(77);
    final count = heavy ? 30 : 14;
    final paint = Paint()
      ..strokeWidth = heavy ? 2.0 : 1.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final speed = 0.6 + rng.nextDouble() * 0.4;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height * 1.1 - size.height * 0.05;
      final len = size.height * (heavy ? 0.04 : 0.025);
      paint.color = const Color(0xFF6BAADC).withValues(alpha: 0.6);
      canvas.drawLine(Offset(x, y), Offset(x - 2, y + len), paint);
    }
  }

  void _paintSnow(Canvas canvas, Size size) {
    final rng = Random(55);
    const count = 20;
    for (int i = 0; i < count; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.3 + rng.nextDouble() * 0.3;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 4 + i) * 15;
      final x = baseX + drift;
      final r = 2.0 + rng.nextDouble() * 3;
      canvas.drawCircle(
        Offset(x, y), r,
        Paint()..color = Colors.white.withValues(alpha: 0.8),
      );
    }
  }

  void _paintLightning(Canvas canvas, Size size) {
    // Flash toutes les ~3 secondes (basé sur progress cycle de 8s).
    final flash = (progress * 3 % 1.0);
    if (flash < 0.03) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = Colors.white.withValues(alpha: 0.3 * (1 - flash / 0.03)),
      );
    }
  }

  void _paintSunSparkles(Canvas canvas, Size size) {
    final rng = Random(33);
    for (int i = 0; i < 6; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.5;
      final phase = (progress * 2 + i * 0.17) % 1.0;
      final opacity = (sin(phase * pi * 2) * 0.5 + 0.5) * 0.5;
      final r = 2.0 + rng.nextDouble() * 2;
      canvas.drawCircle(
        Offset(x, y), r,
        Paint()..color = const Color(0xFFFFE066).withValues(alpha: opacity),
      );
    }
  }

  void _paintFireflies(Canvas canvas, Size size) {
    final rng = Random(88);
    for (int i = 0; i < 8; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final phase = (progress * 1.5 + i * 0.125) % 1.0;
      final opacity = (sin(phase * pi * 2) * 0.5 + 0.5) * 0.7;
      final driftX = sin(progress * pi * 3 + i) * 8;
      final driftY = cos(progress * pi * 2 + i * 1.3) * 6;
      canvas.drawCircle(
        Offset(baseX + driftX, baseY + driftY),
        2.5,
        Paint()..color = const Color(0xFFE8FF6B).withValues(alpha: opacity),
      );
    }
  }

  void _paintFallingPetals(Canvas canvas, Size size) {
    final rng = Random(44);
    for (int i = 0; i < 10; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.2 + rng.nextDouble() * 0.25;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 3 + i * 0.8) * 20;
      final x = baseX + drift;
      final r = 3.0 + rng.nextDouble() * 2;
      final rotation = progress * pi * 2 + i;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2.5, height: r),
        Paint()..color = const Color(0xFFFFB7D5).withValues(alpha: 0.7),
      );
      canvas.restore();
    }
  }

  void _paintFallingLeaves(Canvas canvas, Size size) {
    final rng = Random(66);
    for (int i = 0; i < 8; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.15 + rng.nextDouble() * 0.2;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 2 + i * 1.2) * 25;
      final x = baseX + drift;
      final r = 4.0 + rng.nextDouble() * 3;
      final rotation = progress * pi * 3 + i * 0.7;
      final colors = <Color>[
        const Color(0xFFD4832E),
        const Color(0xFFC85A25),
        const Color(0xFFE8A83E),
      ];
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2.2, height: r),
        Paint()..color = colors[i % colors.length].withValues(alpha: 0.65),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant WeatherParticlePainter old) =>
      old.progress != progress || old.weatherCode != weatherCode;
}

enum WeatherType {
  clear, cloudy, rain, heavyRain, snow, storm, petals, leaves,
}
