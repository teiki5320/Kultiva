import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Les 3 starters jouables (style Pokémon).
enum CreatureStarter { poussia, soleia, racia }

/// La créature-plante du Poussidex. Rendue 100% en CustomPainter —
/// son apparence évolue avec le niveau.
class PlantCreature extends StatefulWidget {
  final int level;
  final CreatureStarter starter;
  final double size;

  const PlantCreature({
    super.key,
    required this.level,
    this.starter = CreatureStarter.poussia,
    this.size = 220,
  });

  @override
  State<PlantCreature> createState() => _PlantCreatureState();
}

class _PlantCreatureState extends State<PlantCreature>
    with TickerProviderStateMixin {
  late final AnimationController _breathCtrl;
  late final AnimationController _blinkCtrl;
  late final AnimationController _swayCtrl;
  late final AnimationController _tapCtrl;
  Timer? _blinkTimer;
  final math.Random _rng = math.Random();
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _breathCtrl = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);
    _blinkCtrl = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _swayCtrl = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    )..repeat(reverse: true);
    _tapCtrl = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scheduleBlink();
  }

  void _scheduleBlink() {
    _blinkTimer = Timer(
      Duration(milliseconds: 2500 + _rng.nextInt(3000)),
      () {
        if (!mounted) return;
        _blinkCtrl.forward().then((_) {
          if (mounted) _blinkCtrl.reverse();
        });
        _scheduleBlink();
      },
    );
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _breathCtrl.dispose();
    _blinkCtrl.dispose();
    _swayCtrl.dispose();
    _tapCtrl.dispose();
    super.dispose();
  }

  void _onTap() {
    HapticFeedback.lightImpact();
    _tapCtrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _showHeart = false);
    });
    setState(() => _showHeart = true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.square(
        dimension: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: Listenable.merge(
                  <Listenable>[_breathCtrl, _blinkCtrl, _swayCtrl, _tapCtrl]),
              builder: (context, _) {
                final t = _breathCtrl.value;
                final breathScale = 1.0 + 0.03 * math.sin(t * math.pi);
                final sway =
                    0.03 * math.sin(_swayCtrl.value * math.pi * 2 - math.pi);
                final tap = _tapCtrl.value;
                final squash = tap < 0.3
                    ? 1.0 - 0.12 * (tap / 0.3)
                    : 1.0 - 0.12 * (1.0 - (tap - 0.3) / 0.7);
                final stretch = tap < 0.3
                    ? 1.0 + 0.08 * (tap / 0.3)
                    : 1.0 + 0.08 * (1.0 - (tap - 0.3) / 0.7);
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..rotateZ(sway)
                    ..scale(squash * breathScale, stretch * breathScale),
                  child: CustomPaint(
                    size: Size.square(widget.size),
                    painter: _CreaturePainter(
                      level: widget.level,
                      starter: widget.starter,
                      blink: _blinkCtrl.value,
                    ),
                  ),
                );
              },
            ),
            if (_showHeart)
              AnimatedBuilder(
                animation: _tapCtrl,
                builder: (context, child) {
                  final p = _tapCtrl.value;
                  return Positioned(
                    top: widget.size * 0.05 - p * widget.size * 0.15,
                    child: Opacity(
                      opacity: (1.0 - p).clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: 0.5 + p * 0.8,
                        child: const Text('❤️',
                            style: TextStyle(fontSize: 28)),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _CreaturePainter extends CustomPainter {
  final int level;
  final CreatureStarter starter;
  final double blink; // 0 = yeux ouverts, 1 = fermés

  _CreaturePainter({
    required this.level,
    required this.starter,
    this.blink = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintGroundShadow(canvas, size);
    if (level < 5) {
      _paintPoussiaSeed(canvas, size);
    } else if (level < 15) {
      _paintPoussiaSprout(canvas, size);
    } else if (level < 30) {
      _paintPoussiaFlower(canvas, size);
    } else {
      _paintPoussiaTree(canvas, size);
    }
  }

  // Ombre douce au sol pour ancrer la créature dans l'espace.
  void _paintGroundShadow(Canvas canvas, Size size) {
    final shadowRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.92),
      width: size.width * 0.55,
      height: size.height * 0.06,
    );
    final paint = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          Colors.black.withOpacity(0.25),
          Colors.black.withOpacity(0.0),
        ],
      ).createShader(shadowRect);
    canvas.drawOval(shadowRect, paint);
  }

  /// Poussia au stade "graine" (niveau 1-4) :
  /// grosse graine brune ovoïde avec yeux qui piquent à travers
  /// une craquelure, petite pousse qui sort du dessus.
  void _paintPoussiaSeed(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // Corps de la graine (gros ovale brun).
    final bodyCenter = Offset(cx, h * 0.58);
    final bodyRect = Rect.fromCenter(
      center: bodyCenter,
      width: w * 0.50,
      height: h * 0.48,
    );
    canvas.drawOval(
      bodyRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.5),
          radius: 0.9,
          colors: const <Color>[
            Color(0xFFD4A96A),
            Color(0xFFAA7B42),
            Color(0xFF6F4A2A),
          ],
          stops: const <double>[0.0, 0.5, 1.0],
        ).createShader(bodyRect),
    );

    // Craquelure en haut de la graine.
    final crackPath = Path()
      ..moveTo(cx - w * 0.06, h * 0.38)
      ..lineTo(cx - w * 0.02, h * 0.35)
      ..lineTo(cx + w * 0.03, h * 0.37)
      ..lineTo(cx + w * 0.06, h * 0.34);
    canvas.drawPath(
      crackPath,
      Paint()
        ..color = const Color(0xFF3E7A48)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.012
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Minuscule pousse sortant de la craquelure.
    final sproutPath = Path()
      ..moveTo(cx, h * 0.36)
      ..quadraticBezierTo(cx + w * 0.04, h * 0.28, cx + w * 0.02, h * 0.22);
    canvas.drawPath(
      sproutPath,
      Paint()
        ..color = const Color(0xFF5CAF5C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.018
        ..strokeCap = StrokeCap.round,
    );
    // Petite feuille au bout.
    final tinyLeaf = Path()
      ..moveTo(cx + w * 0.02, h * 0.22)
      ..quadraticBezierTo(cx + w * 0.10, h * 0.18, cx + w * 0.08, h * 0.24)
      ..quadraticBezierTo(cx + w * 0.05, h * 0.23, cx + w * 0.02, h * 0.22);
    canvas.drawPath(tinyLeaf, Paint()..color = const Color(0xFF5CAF5C));

    // Highlight.
    final hlRect = Rect.fromCenter(
      center: Offset(cx - w * 0.08, h * 0.50),
      width: w * 0.14,
      height: h * 0.10,
    );
    canvas.drawOval(
      hlRect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            Colors.white.withOpacity(0.45),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(hlRect),
    );

    // Yeux kawaii sur la graine.
    _paintEye(canvas, size,
        center: Offset(cx - w * 0.08, h * 0.56), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.08, h * 0.56), blink: blink);

    // Bouche.
    final mouth = Path()
      ..moveTo(cx - w * 0.03, h * 0.66)
      ..quadraticBezierTo(cx, h * 0.69, cx + w * 0.03, h * 0.66);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF5A3A1A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.010
        ..strokeCap = StrokeCap.round,
    );

    // Blush.
    _paintBlush(canvas, size, center: Offset(cx - w * 0.14, h * 0.62));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.14, h * 0.62));
  }

  /// Poussia au stade "pousse" (niveau 5) :
  /// - graine brune au sol (un tout petit peu visible)
  /// - tige verte courbée
  /// - 2 petites feuilles latérales
  /// - bulbe ovale au sommet (la "tête") avec 2 grands yeux kawaii
  ///   et une mini bouche souriante
  void _paintPoussiaSprout(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // --- 1. Petite graine brune à moitié enterrée ---
    final seedCenter = Offset(cx, h * 0.88);
    final seedRect = Rect.fromCenter(
      center: seedCenter,
      width: w * 0.18,
      height: h * 0.09,
    );
    final seedPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.4),
        colors: <Color>[
          const Color(0xFFB48A63),
          const Color(0xFF6F4A2A),
        ],
      ).createShader(seedRect);
    canvas.drawOval(seedRect, seedPaint);

    // --- 2. Tige verte courbée (double courbe pour un peu de vie) ---
    final stemStart = Offset(cx, h * 0.84);
    final stemEnd = Offset(cx, h * 0.42);
    final stemPath = Path()
      ..moveTo(stemStart.dx - w * 0.02, stemStart.dy)
      ..cubicTo(
        cx - w * 0.08, h * 0.72, // control 1 : courbe à gauche
        cx + w * 0.08, h * 0.58, // control 2 : courbe à droite
        stemEnd.dx - w * 0.015, stemEnd.dy,
      )
      ..lineTo(stemEnd.dx + w * 0.015, stemEnd.dy)
      ..cubicTo(
        cx + w * 0.11, h * 0.58,
        cx - w * 0.05, h * 0.72,
        stemStart.dx + w * 0.02, stemStart.dy,
      )
      ..close();
    final stemPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          const Color(0xFF4F9F5A),
          const Color(0xFF7DC887),
          const Color(0xFF4F9F5A),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(stemPath, stemPaint);

    // --- 3. Deux petites feuilles latérales ---
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.03, h * 0.68),
        tip: Offset(cx - w * 0.22, h * 0.60),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.03, h * 0.64),
        tip: Offset(cx + w * 0.24, h * 0.54),
        mirror: true);

    // --- 4. Bulbe (la "tête" de Poussia) ---
    final headCenter = Offset(cx, h * 0.36);
    final headRect = Rect.fromCenter(
      center: headCenter,
      width: w * 0.48,
      height: h * 0.42,
    );
    // Corps principal avec dégradé radial (lumière en haut-gauche).
    final headPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.5),
        radius: 0.95,
        colors: <Color>[
          const Color(0xFFB8E6B8),
          const Color(0xFF6FB87A),
          const Color(0xFF3E8A4B),
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(headRect);
    canvas.drawOval(headRect, headPaint);

    // Petite feuille au sommet du bulbe (façon tige-cheveu).
    final topLeafPath = Path();
    final topLeafBase = Offset(cx + w * 0.02, h * 0.18);
    topLeafPath.moveTo(topLeafBase.dx - w * 0.01, topLeafBase.dy);
    topLeafPath.quadraticBezierTo(
      cx + w * 0.10, h * 0.10,
      cx + w * 0.14, h * 0.06,
    );
    topLeafPath.quadraticBezierTo(
      cx + w * 0.08, h * 0.12,
      cx + w * 0.06, h * 0.18,
    );
    topLeafPath.close();
    canvas.drawPath(
      topLeafPath,
      Paint()..color = const Color(0xFF4F9F5A),
    );

    // --- 5. Highlight brillant sur le bulbe ---
    final highlightRect = Rect.fromCenter(
      center: Offset(cx - w * 0.09, h * 0.28),
      width: w * 0.14,
      height: h * 0.09,
    );
    canvas.drawOval(
      highlightRect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            Colors.white.withOpacity(0.55),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(highlightRect),
    );

    // --- 6. Yeux kawaii (fermés si blink > 0) ---
    _paintEye(canvas, size,
        center: Offset(cx - w * 0.09, h * 0.36), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.09, h * 0.36), blink: blink);

    // --- 7. Mini bouche souriante ---
    final mouthPath = Path()
      ..moveTo(cx - w * 0.04, h * 0.46)
      ..quadraticBezierTo(cx, h * 0.495, cx + w * 0.04, h * 0.46);
    canvas.drawPath(
      mouthPath,
      Paint()
        ..color = const Color(0xFF2A4A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.012
        ..strokeCap = StrokeCap.round,
    );

    // --- 8. Blush joues (touche kawaii) ---
    _paintBlush(canvas, size, center: Offset(cx - w * 0.14, h * 0.42));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.14, h * 0.42));
  }

  /// Poussia au stade "fleur" (niveau 15-29) :
  /// tige plus haute, 4 feuilles, fleur ouverte au sommet (pétales),
  /// yeux au centre de la fleur.
  void _paintPoussiaFlower(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // Petit monticule de terre.
    final earthPath = Path()
      ..moveTo(cx - w * 0.25, h * 0.90)
      ..quadraticBezierTo(cx, h * 0.82, cx + w * 0.25, h * 0.90)
      ..lineTo(cx + w * 0.25, h * 0.94)
      ..lineTo(cx - w * 0.25, h * 0.94)
      ..close();
    canvas.drawPath(
      earthPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.5),
          colors: const <Color>[Color(0xFF8B6B4A), Color(0xFF5A3A1A)],
        ).createShader(Rect.fromLTWH(cx - w * 0.25, h * 0.82, w * 0.5, h * 0.12)),
    );

    // Tige.
    final stemPath = Path()
      ..moveTo(cx - w * 0.018, h * 0.84)
      ..cubicTo(cx - w * 0.06, h * 0.65, cx + w * 0.06, h * 0.50,
          cx - w * 0.01, h * 0.32)
      ..lineTo(cx + w * 0.01, h * 0.32)
      ..cubicTo(cx + w * 0.08, h * 0.50, cx - w * 0.04, h * 0.65,
          cx + w * 0.018, h * 0.84)
      ..close();
    canvas.drawPath(
      stemPath,
      Paint()..color = const Color(0xFF4F9F5A),
    );

    // 4 feuilles.
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.02, h * 0.72),
        tip: Offset(cx - w * 0.24, h * 0.64),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.02, h * 0.68),
        tip: Offset(cx + w * 0.26, h * 0.58),
        mirror: true);
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.02, h * 0.56),
        tip: Offset(cx - w * 0.20, h * 0.46),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.02, h * 0.50),
        tip: Offset(cx + w * 0.22, h * 0.40),
        mirror: true);

    // Centre de la fleur (gros rond jaune).
    final flowerCenter = Offset(cx, h * 0.26);
    final petalLen = w * 0.12;
    const petalCount = 6;
    // Pétales.
    for (int i = 0; i < petalCount; i++) {
      final angle = (i * math.pi * 2 / petalCount) - math.pi / 2;
      final petalTip = flowerCenter +
          Offset(math.cos(angle) * petalLen, math.sin(angle) * petalLen);
      final perpAngle = angle + math.pi / 2;
      final perpOff =
          Offset(math.cos(perpAngle) * w * 0.04, math.sin(perpAngle) * w * 0.04);
      final petal = Path()
        ..moveTo(flowerCenter.dx, flowerCenter.dy)
        ..quadraticBezierTo(
          petalTip.dx + perpOff.dx, petalTip.dy + perpOff.dy,
          petalTip.dx, petalTip.dy,
        )
        ..quadraticBezierTo(
          petalTip.dx - perpOff.dx, petalTip.dy - perpOff.dy,
          flowerCenter.dx, flowerCenter.dy,
        );
      canvas.drawPath(
        petal,
        Paint()
          ..color = Color.lerp(
            const Color(0xFFFFB7D5),
            const Color(0xFFFF8AB0),
            i / petalCount,
          )!,
      );
    }

    // Centre jaune.
    final centerRect = Rect.fromCenter(
      center: flowerCenter,
      width: w * 0.18,
      height: w * 0.18,
    );
    canvas.drawOval(
      centerRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          colors: const <Color>[Color(0xFFFFE68A), Color(0xFFEABF30)],
        ).createShader(centerRect),
    );

    // Highlight.
    final hlRect = Rect.fromCenter(
      center: flowerCenter.translate(-w * 0.03, -w * 0.03),
      width: w * 0.06,
      height: w * 0.04,
    );
    canvas.drawOval(
      hlRect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            Colors.white.withOpacity(0.55),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(hlRect),
    );

    // Yeux.
    _paintEye(canvas, size,
        center: flowerCenter.translate(-w * 0.03, w * 0.01), blink: blink);
    _paintEye(canvas, size,
        center: flowerCenter.translate(w * 0.03, w * 0.01), blink: blink);

    // Bouche.
    final mouth = Path()
      ..moveTo(flowerCenter.dx - w * 0.02, flowerCenter.dy + w * 0.05)
      ..quadraticBezierTo(
        flowerCenter.dx, flowerCenter.dy + w * 0.065,
        flowerCenter.dx + w * 0.02, flowerCenter.dy + w * 0.05,
      );
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF8A6A00)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.008
        ..strokeCap = StrokeCap.round,
    );

    // Blush.
    _paintBlush(canvas, size,
        center: flowerCenter.translate(-w * 0.06, w * 0.04));
    _paintBlush(canvas, size,
        center: flowerCenter.translate(w * 0.06, w * 0.04));
  }

  /// Poussia au stade "arbre" (niveau 30+) :
  /// tronc solide, couronne feuillue ronde avec yeux.
  void _paintPoussiaTree(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // Petit monticule de terre.
    final earthPath = Path()
      ..moveTo(cx - w * 0.30, h * 0.92)
      ..quadraticBezierTo(cx, h * 0.84, cx + w * 0.30, h * 0.92)
      ..lineTo(cx + w * 0.30, h * 0.96)
      ..lineTo(cx - w * 0.30, h * 0.96)
      ..close();
    canvas.drawPath(
      earthPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.5),
          colors: const <Color>[Color(0xFF8B6B4A), Color(0xFF5A3A1A)],
        ).createShader(
            Rect.fromLTWH(cx - w * 0.30, h * 0.84, w * 0.60, h * 0.12)),
    );

    // Tronc.
    final trunkPath = Path()
      ..moveTo(cx - w * 0.04, h * 0.86)
      ..lineTo(cx - w * 0.035, h * 0.48)
      ..lineTo(cx + w * 0.035, h * 0.48)
      ..lineTo(cx + w * 0.04, h * 0.86)
      ..close();
    canvas.drawPath(
      trunkPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[
            Color(0xFF7A5530),
            Color(0xFFA07240),
            Color(0xFF7A5530),
          ],
        ).createShader(Rect.fromLTWH(cx - w * 0.04, h * 0.48, w * 0.08, h * 0.38)),
    );

    // Branches latérales.
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.02, h * 0.62),
        tip: Offset(cx - w * 0.18, h * 0.55),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.02, h * 0.58),
        tip: Offset(cx + w * 0.20, h * 0.50),
        mirror: true);

    // Canopée (gros ovale vert).
    final canopyCenter = Offset(cx, h * 0.30);
    final canopyRect = Rect.fromCenter(
      center: canopyCenter,
      width: w * 0.72,
      height: h * 0.50,
    );
    canvas.drawOval(
      canopyRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.25, -0.4),
          radius: 0.85,
          colors: const <Color>[
            Color(0xFF8FD98F),
            Color(0xFF5CB35C),
            Color(0xFF2E7A2E),
          ],
          stops: const <double>[0.0, 0.5, 1.0],
        ).createShader(canopyRect),
    );

    // Amas de feuilles texturées (petits cercles plus clairs).
    final leafDots = <Offset>[
      canopyCenter + Offset(-w * 0.12, -h * 0.08),
      canopyCenter + Offset(w * 0.10, -h * 0.12),
      canopyCenter + Offset(w * 0.18, -h * 0.02),
      canopyCenter + Offset(-w * 0.20, h * 0.02),
      canopyCenter + Offset(w * 0.05, h * 0.10),
      canopyCenter + Offset(-w * 0.08, h * 0.12),
    ];
    for (final dot in leafDots) {
      final r = w * 0.06;
      final rect = Rect.fromCenter(center: dot, width: r * 2, height: r * 2);
      canvas.drawOval(
        rect,
        Paint()
          ..shader = RadialGradient(
            colors: <Color>[
              const Color(0xFFA8E8A8).withOpacity(0.5),
              const Color(0xFFA8E8A8).withOpacity(0.0),
            ],
          ).createShader(rect),
      );
    }

    // Highlight.
    final hlRect = Rect.fromCenter(
      center: canopyCenter + Offset(-w * 0.10, -h * 0.10),
      width: w * 0.18,
      height: h * 0.10,
    );
    canvas.drawOval(
      hlRect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            Colors.white.withOpacity(0.35),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(hlRect),
    );

    // Yeux.
    _paintEye(canvas, size,
        center: canopyCenter + Offset(-w * 0.08, h * 0.02), blink: blink);
    _paintEye(canvas, size,
        center: canopyCenter + Offset(w * 0.08, h * 0.02), blink: blink);

    // Bouche.
    final mouth = Path()
      ..moveTo(cx - w * 0.04, canopyCenter.dy + h * 0.10)
      ..quadraticBezierTo(
        cx, canopyCenter.dy + h * 0.14,
        cx + w * 0.04, canopyCenter.dy + h * 0.10,
      );
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF1A4A1A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.012
        ..strokeCap = StrokeCap.round,
    );

    // Blush.
    _paintBlush(canvas, size,
        center: canopyCenter + Offset(-w * 0.14, h * 0.06));
    _paintBlush(canvas, size,
        center: canopyCenter + Offset(w * 0.14, h * 0.06));
  }

  void _paintLeaf(
    Canvas canvas,
    Size size, {
    required Offset anchor,
    required Offset tip,
    required bool mirror,
  }) {
    final path = Path();
    final midX = (anchor.dx + tip.dx) / 2;
    final midY = (anchor.dy + tip.dy) / 2;
    final perp = mirror
        ? Offset(midY - tip.dy, tip.dx - midX).normalized() * size.width * 0.08
        : Offset(tip.dy - midY, midX - tip.dx).normalized() * size.width * 0.08;
    path.moveTo(anchor.dx, anchor.dy);
    path.quadraticBezierTo(
      midX + perp.dx,
      midY + perp.dy,
      tip.dx,
      tip.dy,
    );
    path.quadraticBezierTo(
      midX - perp.dx * 0.3,
      midY - perp.dy * 0.3,
      anchor.dx,
      anchor.dy,
    );
    path.close();

    final leafRect = Rect.fromPoints(anchor, tip).inflate(size.width * 0.05);
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF7DC887),
            const Color(0xFF4A8B56),
          ],
        ).createShader(leafRect),
    );
    // Nervure centrale.
    canvas.drawLine(
      anchor,
      tip,
      Paint()
        ..color = const Color(0xFF3E7A48).withOpacity(0.5)
        ..strokeWidth = size.width * 0.005
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintEye(Canvas canvas, Size size,
      {required Offset center, double blink = 0}) {
    final eyeWidth = size.width * 0.08;
    final eyeOpenHeight = size.height * 0.10;
    final eyeHeight = eyeOpenHeight * (1.0 - blink * 0.85);

    if (blink > 0.7) {
      // Yeux quasi-fermés → simple trait horizontal.
      canvas.drawLine(
        center.translate(-eyeWidth * 0.5, 0),
        center.translate(eyeWidth * 0.5, 0),
        Paint()
          ..color = const Color(0xFF2A4A3A)
          ..strokeWidth = size.width * 0.008
          ..strokeCap = StrokeCap.round,
      );
      return;
    }

    // Blanc de l'œil.
    canvas.drawOval(
      Rect.fromCenter(center: center, width: eyeWidth, height: eyeHeight),
      Paint()..color = Colors.white,
    );
    // Contour.
    canvas.drawOval(
      Rect.fromCenter(center: center, width: eyeWidth, height: eyeHeight),
      Paint()
        ..color = const Color(0xFF2A4A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.006,
    );
    // Pupille (s'écrase avec le blink).
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(0, size.height * 0.01),
        width: eyeWidth * 0.55,
        height: eyeHeight * 0.62,
      ),
      Paint()..color = const Color(0xFF1A2A20),
    );
    // Reflets (seulement si pas trop fermé).
    if (blink < 0.4) {
      canvas.drawCircle(
        center.translate(-size.width * 0.012, -size.height * 0.015),
        size.width * 0.012,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        center.translate(size.width * 0.014, size.height * 0.010),
        size.width * 0.006,
        Paint()..color = Colors.white.withOpacity(0.7),
      );
    }
  }

  void _paintBlush(Canvas canvas, Size size, {required Offset center}) {
    final rect = Rect.fromCenter(
      center: center,
      width: size.width * 0.07,
      height: size.height * 0.04,
    );
    canvas.drawOval(
      rect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFFB8C8).withOpacity(0.75),
            const Color(0xFFFFB8C8).withOpacity(0.0),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _CreaturePainter old) =>
      old.level != level || old.starter != starter || old.blink != blink;
}

extension _OffsetNorm on Offset {
  Offset normalized() {
    final d = distance;
    if (d == 0) return Offset.zero;
    return Offset(dx / d, dy / d);
  }
}
