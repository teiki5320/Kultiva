import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/tamassi_visitor.dart';

/// Type d'effet déclenché depuis les boutons Arroser/Engrais.
enum TamassiEffect { water, fertilize }

/// Style de trajectoire d'un animal qui traverse l'écran.
enum CrossingStyle { flyHigh, zigzag, groundSlow, hop }

/// Animal qui traverse l'écran. L'emoji et la trajectoire dépendent
/// de l'heure (pool dans `_animalPoolForHour`).
class CrossingAnimal {
  final String emoji;
  final CrossingStyle style;
  final int durationMs;

  const CrossingAnimal({
    required this.emoji,
    required this.style,
    this.durationMs = 6000,
  });
}

/// Seuils d'évolution de la créature (11 stades).
const List<int> kEvolutionThresholds = <int>[
  1, 5, 10, 15, 20, 30, 40, 50, 60, 75, 100,
];

/// Barre de progression XP vers la prochaine évolution.
class XpBar extends StatelessWidget {
  final int level;
  const XpBar({super.key, required this.level});

  (int, int) get _bounds {
    int cur = kEvolutionThresholds.first;
    int next = kEvolutionThresholds.last;
    for (int i = 0; i < kEvolutionThresholds.length; i++) {
      final t = kEvolutionThresholds[i];
      if (t <= level) {
        cur = t;
        next = i + 1 < kEvolutionThresholds.length
            ? kEvolutionThresholds[i + 1]
            : t;
      }
    }
    return (cur, next);
  }

  @override
  Widget build(BuildContext context) {
    final (cur, next) = _bounds;
    final maxed = cur == next;
    final progress = maxed
        ? 1.0
        : ((level - cur) / (next - cur)).clamp(0.0, 1.0);
    const accent = Color(0xFFE8808E); // rose-rouge du contour
    const fill = Color(0xFFE8A8B0); // rose rempli
    const track = Color(0xFFFFF5F5); // blanc rosé (fond de barre)
    const barHeight = 22.0;
    const peachSize = 42.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            return SizedBox(
              height: peachSize + 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  // Barre (fond + remplissage + contour).
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: track,
                        borderRadius: BorderRadius.circular(barHeight / 2),
                        border: Border.all(color: accent, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(barHeight / 2),
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          tween: Tween<double>(begin: 0, end: progress),
                          builder: (context, value, _) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: value.clamp(0.0, 1.0),
                                heightFactor: 1.0,
                                child: Container(color: fill),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Texte "Prochain niveau : N" à droite dans la barre.
                  Positioned(
                    right: 12,
                    bottom: 0,
                    height: barHeight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        maxed ? 'Niveau max' : 'Prochain niveau : $next',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                  // 🍑 Pêche qui se déplace avec la progression.
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    tween: Tween<double>(begin: 0, end: progress),
                    builder: (context, value, _) {
                      final x = (barWidth * value.clamp(0.0, 1.0)) -
                          peachSize / 2;
                      return Positioned(
                        left: x.clamp(-peachSize / 2,
                            barWidth - peachSize / 2),
                        top: 0,
                        child: const Text(
                          '🍑',
                          style: TextStyle(fontSize: peachSize),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Painter qui dessine 8 lucioles tournant lentement autour de la
/// créature pendant la nuit. Chaque luciole a sa propre orbite, phase
/// et clignotement indépendant.
class FireflyOrbitPainter extends CustomPainter {
  final double progress;
  FireflyOrbitPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final baseRadius = size.width * 0.42;
    const count = 8;
    for (int i = 0; i < count; i++) {
      final speed = 0.5 + (i % 3) * 0.15;
      final angle = (progress * speed + i / count) * 2 * pi;
      // Rayon variable sur chaque luciole.
      final radiusVariation =
          1.0 + 0.15 * sin(progress * 2 * pi + i * 1.1);
      final r = baseRadius * (0.85 + (i % 2) * 0.1) * radiusVariation;
      // Léger bob vertical.
      final yBob = sin(progress * 4 * pi + i * 0.8) * size.height * 0.02;
      final p = center + Offset(cos(angle) * r, sin(angle) * r * 0.6 + yBob);
      // Clignotement : sinusoïde décalée pour chaque luciole.
      final blink = (sin(progress * 4 * pi + i * 1.6) * 0.5 + 0.5);
      final opacity = (0.3 + blink * 0.7).clamp(0.0, 1.0);
      // Halo doux autour du point lumineux.
      canvas.drawCircle(
        p, 10,
        Paint()
          ..color = const Color(0xFFFFF3A0).withValues(alpha: opacity * 0.22)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
      // Point lumineux.
      canvas.drawCircle(
        p, 3.2,
        Paint()..color = const Color(0xFFFFE37A).withValues(alpha: opacity),
      );
      // Reflet blanc central.
      canvas.drawCircle(
        p, 1.4,
        Paint()..color = Colors.white.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FireflyOrbitPainter old) =>
      old.progress != progress;
}

/// Rayons lumineux qui tournent pendant l'animation d'évolution.
class EvolutionRaysPainter extends CustomPainter {
  final double progress;
  final double opacity;
  EvolutionRaysPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.45);
    final maxRadius = size.longestSide;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(progress * pi * 2);
    const rayCount = 14;
    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 2 * pi / rayCount);
      final rayPath = Path()
        ..moveTo(0, 0)
        ..lineTo(cos(angle - 0.04) * maxRadius,
            sin(angle - 0.04) * maxRadius)
        ..lineTo(
            cos(angle + 0.04) * maxRadius, sin(angle + 0.04) * maxRadius)
        ..close();
      canvas.drawPath(
        rayPath,
        Paint()
          ..shader = RadialGradient(
            colors: <Color>[
              Color.lerp(
                      const Color(0xFFFFE066),
                      const Color(0xFFFFB04C),
                      (i % 2).toDouble())!
                  .withValues(alpha: opacity * 0.7),
              Colors.transparent,
            ],
          ).createShader(
              Rect.fromCircle(center: Offset.zero, radius: maxRadius)),
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant EvolutionRaysPainter old) =>
      old.progress != progress || old.opacity != opacity;
}

/// Confetti painter for the "Bravo !" celebration when a challenge is
/// completed.
class ConfettiPainter extends CustomPainter {
  final double progress;
  ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(314);
    const count = 28;
    final colors = <Color>[
      const Color(0xFFFF8FAB),
      const Color(0xFFFFE066),
      const Color(0xFF6FB87A),
      const Color(0xFF7BAFD4),
      const Color(0xFFC77DFF),
    ];
    for (int i = 0; i < count; i++) {
      final angle = rng.nextDouble() * pi * 2;
      final speed = 0.8 + rng.nextDouble() * 0.6;
      final dist = progress * size.width * 0.55 * speed;
      final x = size.width / 2 + cos(angle) * dist;
      final y = size.height / 2 +
          sin(angle) * dist +
          progress * progress * size.height * 0.25; // gravity
      final c = colors[i % colors.length];
      final rot = rng.nextDouble() * pi * 2 + progress * pi * 4;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 9, height: 4),
        Paint()..color = c.withValues(alpha: (1 - progress).clamp(0.0, 1.0)),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter old) =>
      old.progress != progress;
}

/// Mini-Tamassi d'un autre joueur qui passe en visite, avec son nom.
class VisitorBubble extends StatelessWidget {
  final TamassiVisitor visitor;
  const VisitorBubble({super.key, required this.visitor});

  String _assetPath() {
    final folder = switch (visitor.starter) {
      'soleia' => 'Soleia',
      'spira' => 'Spira',
      _ => 'Poussia',
    };
    final prefix = switch (visitor.starter) {
      'soleia' => 'S',
      'spira' => 'SP',
      _ => 'P',
    };
    final lv = visitor.xp;
    final int n;
    if (lv >= 100) {
      n = 11;
    } else if (lv >= 75) {
      n = 10;
    } else if (lv >= 60) {
      n = 9;
    } else if (lv >= 50) {
      n = 8;
    } else if (lv >= 40) {
      n = 7;
    } else if (lv >= 30) {
      n = 6;
    } else if (lv >= 20) {
      n = 5;
    } else if (lv >= 15) {
      n = 4;
    } else if (lv >= 10) {
      n = 3;
    } else if (lv >= 5) {
      n = 2;
    } else {
      n = 1;
    }
    return 'assets/images/creatures/$folder/$prefix$n.png';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '👋 ${visitor.name}',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          height: 90,
          child: Image.asset(
            _assetPath(),
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Text('🌱', style: TextStyle(fontSize: 50)),
          ),
        ),
      ],
    );
  }
}

/// Petite bulle de dialogue kawaii pour les salutations.
class SpeechBubble extends StatelessWidget {
  final String text;
  const SpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// Peintre d'effet particules pour Arroser (gouttes d'eau) et Engrais
/// (étincelles vertes/dorées). L'animation est pilotée par [progress]
/// qui va de 0 à 1.
class EffectPainter extends CustomPainter {
  final TamassiEffect effect;
  final double progress;

  EffectPainter({required this.effect, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (effect == TamassiEffect.water) {
      _paintWater(canvas, size);
    } else {
      _paintFertilize(canvas, size);
    }
  }

  void _paintWater(Canvas canvas, Size size) {
    // 10 gouttes qui tombent du haut vers le milieu de la créature.
    final rng = Random(42);
    const dropCount = 10;
    for (int i = 0; i < dropCount; i++) {
      final startX = size.width * (0.15 + 0.70 * rng.nextDouble());
      final delay = i * 0.06;
      final localP = ((progress - delay) / 0.55).clamp(0.0, 1.0);
      if (localP <= 0) continue;
      // Gouttes tombent de y=-10% à y=55% (centre de la créature).
      final startY = -size.height * 0.1;
      final endY = size.height * 0.55;
      final y = startY + (endY - startY) * _easeInQuad(localP);
      final dropSize = size.width * 0.018;
      // Goutte : forme d'œuf inversé.
      final dropPath = Path()
        ..moveTo(startX, y - dropSize * 2)
        ..quadraticBezierTo(
          startX + dropSize, y - dropSize,
          startX + dropSize * 0.6, y + dropSize * 0.8,
        )
        ..quadraticBezierTo(
          startX, y + dropSize,
          startX - dropSize * 0.6, y + dropSize * 0.8,
        )
        ..quadraticBezierTo(
          startX - dropSize, y - dropSize,
          startX, y - dropSize * 2,
        )
        ..close();
      canvas.drawPath(
        dropPath,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFF9BD4FF).withValues(alpha: 0.9),
              const Color(0xFF3A9BE8).withValues(alpha: 0.95),
            ],
          ).createShader(Rect.fromCircle(
              center: Offset(startX, y), radius: dropSize * 2)),
      );
      // Splash quand la goutte atteint le bas (dernier 25% du localP).
      if (localP > 0.75) {
        final splashP = (localP - 0.75) / 0.25;
        final splashRadius = dropSize * 3 * splashP;
        canvas.drawCircle(
          Offset(startX, endY),
          splashRadius,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color =
                const Color(0xFF3A9BE8).withValues(alpha: 0.5 * (1 - splashP)),
        );
      }
    }
  }

  void _paintFertilize(Canvas canvas, Size size) {
    // 14 étincelles qui montent depuis le bas de la créature en fade.
    final rng = Random(123);
    const sparkCount = 14;
    for (int i = 0; i < sparkCount; i++) {
      final xBase = size.width * (0.12 + 0.76 * rng.nextDouble());
      final xDrift = (rng.nextDouble() - 0.5) * size.width * 0.08;
      final delay = i * 0.045;
      final localP = ((progress - delay) / 0.65).clamp(0.0, 1.0);
      if (localP <= 0) continue;
      // Monte de y=85% à y=15%.
      final startY = size.height * 0.85;
      final endY = size.height * 0.15;
      final y = startY + (endY - startY) * _easeOutCubic(localP);
      final x = xBase + xDrift * localP;
      final opacity = (1 - localP).clamp(0.0, 1.0);
      final sparkSize = size.width * 0.018 * (1 + 0.5 * (1 - localP));
      final color = i.isEven
          ? const Color(0xFFB2E371) // vert tendre
          : const Color(0xFFFFD86B); // jaune doré
      _drawSpark(canvas, Offset(x, y), sparkSize, color, opacity);
    }
  }

  void _drawSpark(
      Canvas canvas, Offset center, double size, Color color, double opacity) {
    final paint = Paint()..color = color.withValues(alpha: opacity);
    // 4-branch star.
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4;
      final r = i.isEven ? size : size * 0.35;
      final p = center + Offset(cos(angle) * r, sin(angle) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _easeInQuad(double t) => t * t;
  double _easeOutCubic(double t) {
    final x = 1 - t;
    return 1 - x * x * x;
  }

  @override
  bool shouldRepaint(covariant EffectPainter old) =>
      old.progress != progress || old.effect != effect;
}
