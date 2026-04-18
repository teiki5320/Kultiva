import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Les 3 starters jouables (style Pokémon).
enum CreatureStarter { poussia, soleia, spira }

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

  /// Mapping niveau → chemin d'asset PNG (null si pas d'illustration
  /// disponible, on retombe alors sur le CustomPainter).
  String? _assetPathForLevel() {
    final lv = widget.level;
    final String folder;
    final String prefix;
    switch (widget.starter) {
      case CreatureStarter.poussia:
        folder = 'Poussia';
        prefix = 'P';
        break;
      case CreatureStarter.soleia:
        folder = 'Soleia';
        prefix = 'S';
        break;
      case CreatureStarter.spira:
        folder = 'Spira';
        prefix = 'SP';
        break;
    }
    final base = 'assets/images/creatures/$folder';
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
    return '$base/$prefix$n.png';
  }

  /// Retourne soit une Image.asset (si illustration dispo) soit le
  /// CustomPainter de fallback.
  Widget _buildCreatureVisual() {
    final assetPath = _assetPathForLevel();
    if (assetPath != null) {
      // Les 4 premiers stades (graines + germe) sont visuellement plus
      // petits → on les zoom pour qu'ils remplissent mieux l'espace.
      final scale = widget.level < 20 ? 1.45 : 1.0;
      Widget image = SizedBox.square(
        dimension: widget.size,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => CustomPaint(
            size: Size.square(widget.size),
            painter: _CreaturePainter(
              level: widget.level,
              starter: widget.starter,
              blink: _blinkCtrl.value,
            ),
          ),
        ),
      );
      if (scale != 1.0) {
        image = Transform.scale(scale: scale, child: image);
      }
      return image;
    }
    return CustomPaint(
      size: Size.square(widget.size),
      painter: _CreaturePainter(
        level: widget.level,
        starter: widget.starter,
        blink: _blinkCtrl.value,
      ),
    );
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
                  child: _buildCreatureVisual(),
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
    // 11 paliers d'évolution (thresholds) :
    // 1, 5, 10, 15, 20, 30, 40, 50, 60, 75, 100.
    if (level < 5) {
      _paintPoussiaSeed1(canvas, size);
    } else if (level < 10) {
      _paintPoussiaSeed2(canvas, size);
    } else if (level < 15) {
      _paintPoussiaSeed3(canvas, size);
    } else if (level < 20) {
      _paintPoussiaGerme(canvas, size);
    } else if (level < 30) {
      _paintPoussiaSprout(canvas, size);
    } else if (level < 40) {
      _paintPoussiaBud(canvas, size);
    } else if (level < 50) {
      _paintPoussiaFlower(canvas, size);
    } else if (level < 60) {
      _paintPoussiaBush(canvas, size);
    } else if (level < 75) {
      _paintPoussiaSapling(canvas, size);
    } else if (level < 100) {
      _paintPoussiaTree(canvas, size);
    } else {
      _paintPoussiaLegendaryTree(canvas, size);
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

  /// Corps de graine commun (ovale brun + yeux + bouche + highlight).
  /// Utilisé par les 3 variantes Seed1/Seed2/Seed3 et le stade Germe.
  void _paintSeedBody(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

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

    // Yeux + bouche + blush.
    _paintEye(canvas, size,
        center: Offset(cx - w * 0.08, h * 0.56), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.08, h * 0.56), blink: blink);
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
    _paintBlush(canvas, size, center: Offset(cx - w * 0.14, h * 0.62));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.14, h * 0.62));
  }

  /// Seed 1 (niveau 1-4) : graine dormante, intacte. Juste des yeux.
  void _paintPoussiaSeed1(Canvas canvas, Size size) {
    _paintSeedBody(canvas, size);
  }

  /// Seed 2 (niveau 5-9) : première craquelure fine sur le dessus.
  void _paintPoussiaSeed2(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    _paintSeedBody(canvas, size);
    // Fine craquelure, rien ne sort encore.
    final crackPath = Path()
      ..moveTo(cx - w * 0.05, h * 0.38)
      ..lineTo(cx - w * 0.01, h * 0.36)
      ..lineTo(cx + w * 0.03, h * 0.38);
    canvas.drawPath(
      crackPath,
      Paint()
        ..color = const Color(0xFF3A2818)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.008
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  /// Seed 3 (niveau 10-14) : craquelure ouverte, minuscule pousse
  /// qui pointe le bout du nez.
  void _paintPoussiaSeed3(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    _paintSeedBody(canvas, size);
    // Craquelure plus ouverte (deux segments en V).
    final crackPath = Path()
      ..moveTo(cx - w * 0.08, h * 0.39)
      ..lineTo(cx - w * 0.02, h * 0.35)
      ..lineTo(cx + w * 0.04, h * 0.38)
      ..lineTo(cx + w * 0.07, h * 0.34);
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
    final tinyLeaf = Path()
      ..moveTo(cx + w * 0.02, h * 0.22)
      ..quadraticBezierTo(cx + w * 0.10, h * 0.18, cx + w * 0.08, h * 0.24)
      ..quadraticBezierTo(cx + w * 0.05, h * 0.23, cx + w * 0.02, h * 0.22);
    canvas.drawPath(tinyLeaf, Paint()..color = const Color(0xFF5CAF5C));
  }

  /// Germe (niveau 15-19) : la graine est encore visible en bas,
  /// une petite tige + 2 feuilles latérales émergent.
  void _paintPoussiaGerme(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // Graine en bas, un peu plus petite (shift & shrink du body).
    final seedRect = Rect.fromCenter(
      center: Offset(cx, h * 0.82),
      width: w * 0.38,
      height: h * 0.22,
    );
    canvas.drawOval(
      seedRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          colors: const <Color>[Color(0xFFB48A63), Color(0xFF6F4A2A)],
        ).createShader(seedRect),
    );

    // Tige.
    final stemPath = Path()
      ..moveTo(cx - w * 0.02, h * 0.80)
      ..cubicTo(cx - w * 0.06, h * 0.62, cx + w * 0.06, h * 0.54,
          cx - w * 0.015, h * 0.44)
      ..lineTo(cx + w * 0.015, h * 0.44)
      ..cubicTo(cx + w * 0.08, h * 0.54, cx - w * 0.04, h * 0.62,
          cx + w * 0.02, h * 0.80)
      ..close();
    canvas.drawPath(
      stemPath,
      Paint()..color = const Color(0xFF4F9F5A),
    );

    // 2 petites feuilles.
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.02, h * 0.60),
        tip: Offset(cx - w * 0.18, h * 0.52),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.02, h * 0.58),
        tip: Offset(cx + w * 0.20, h * 0.50),
        mirror: true);

    // Petite tête bulbe en haut avec yeux.
    final headRect = Rect.fromCenter(
      center: Offset(cx, h * 0.38),
      width: w * 0.32,
      height: h * 0.26,
    );
    canvas.drawOval(
      headRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.5),
          colors: const <Color>[
            Color(0xFFB8E6B8),
            Color(0xFF6FB87A),
            Color(0xFF3E8A4B),
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ).createShader(headRect),
    );

    _paintEye(canvas, size,
        center: Offset(cx - w * 0.06, h * 0.38), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.06, h * 0.38), blink: blink);

    final mouth = Path()
      ..moveTo(cx - w * 0.025, h * 0.45)
      ..quadraticBezierTo(cx, h * 0.475, cx + w * 0.025, h * 0.45);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF2A4A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.010
        ..strokeCap = StrokeCap.round,
    );
    _paintBlush(canvas, size, center: Offset(cx - w * 0.10, h * 0.42));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.10, h * 0.42));
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

  /// Bourgeon (niveau 30-39) : tige + 4 feuilles + gros bourgeon fermé
  /// au sommet (yeux sur le bourgeon).
  void _paintPoussiaBud(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    // Terre.
    _paintEarthMound(canvas, size, topY: h * 0.82, width: w * 0.5);

    // Tige.
    final stemPath = Path()
      ..moveTo(cx - w * 0.018, h * 0.84)
      ..cubicTo(cx - w * 0.06, h * 0.65, cx + w * 0.06, h * 0.50,
          cx - w * 0.01, h * 0.32)
      ..lineTo(cx + w * 0.01, h * 0.32)
      ..cubicTo(cx + w * 0.08, h * 0.50, cx - w * 0.04, h * 0.65,
          cx + w * 0.018, h * 0.84)
      ..close();
    canvas.drawPath(stemPath, Paint()..color = const Color(0xFF4F9F5A));

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

    // Bourgeon (gros ovale vert clair en forme de goutte).
    final budCenter = Offset(cx, h * 0.24);
    final budPath = Path();
    budPath.moveTo(cx, h * 0.08);
    budPath.cubicTo(
      cx + w * 0.12, h * 0.14,
      cx + w * 0.12, h * 0.32,
      cx, h * 0.36,
    );
    budPath.cubicTo(
      cx - w * 0.12, h * 0.32,
      cx - w * 0.12, h * 0.14,
      cx, h * 0.08,
    );
    budPath.close();
    canvas.drawPath(
      budPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.5),
          radius: 0.9,
          colors: const <Color>[
            Color(0xFFFFC8E0),
            Color(0xFFF594B8),
            Color(0xFFCA5E86),
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ).createShader(Rect.fromCenter(
            center: budCenter, width: w * 0.24, height: h * 0.28)),
    );

    // "Sépales" verts à la base du bourgeon.
    final sepalsPath = Path()
      ..moveTo(cx - w * 0.10, h * 0.32)
      ..quadraticBezierTo(cx - w * 0.06, h * 0.38, cx - w * 0.02, h * 0.34)
      ..quadraticBezierTo(cx, h * 0.40, cx + w * 0.02, h * 0.34)
      ..quadraticBezierTo(cx + w * 0.06, h * 0.38, cx + w * 0.10, h * 0.32)
      ..lineTo(cx + w * 0.08, h * 0.30)
      ..lineTo(cx - w * 0.08, h * 0.30)
      ..close();
    canvas.drawPath(sepalsPath, Paint()..color = const Color(0xFF4F9F5A));

    // Highlight.
    final hlRect = Rect.fromCenter(
      center: Offset(cx - w * 0.04, h * 0.16),
      width: w * 0.06,
      height: h * 0.05,
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

    // Yeux sur le bourgeon.
    _paintEye(canvas, size,
        center: Offset(cx - w * 0.04, h * 0.24), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.04, h * 0.24), blink: blink);

    // Bouche.
    final mouth = Path()
      ..moveTo(cx - w * 0.02, h * 0.30)
      ..quadraticBezierTo(cx, h * 0.325, cx + w * 0.02, h * 0.30);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF6A1A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.008
        ..strokeCap = StrokeCap.round,
    );
    _paintBlush(canvas, size, center: Offset(cx - w * 0.08, h * 0.28));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.08, h * 0.28));
  }

  /// Plante (niveau 50-59) : plante touffue avec plusieurs feuilles et
  /// 3 mini fleurs. Yeux au cœur de la plante.
  void _paintPoussiaBush(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    _paintEarthMound(canvas, size, topY: h * 0.82, width: w * 0.6);

    // Feuilles d'arrière (plus sombres, plus grandes).
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.04, h * 0.78),
        tip: Offset(cx - w * 0.30, h * 0.58),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.04, h * 0.76),
        tip: Offset(cx + w * 0.32, h * 0.54),
        mirror: true);

    // Corps touffu central (gros ovale vert).
    final bodyCenter = Offset(cx, h * 0.48);
    final bodyRect = Rect.fromCenter(
      center: bodyCenter,
      width: w * 0.56,
      height: h * 0.46,
    );
    canvas.drawOval(
      bodyRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.2, -0.3),
          radius: 0.9,
          colors: const <Color>[
            Color(0xFFB8E6B8),
            Color(0xFF6FB87A),
            Color(0xFF3E8A4B),
          ],
          stops: const <double>[0.0, 0.5, 1.0],
        ).createShader(bodyRect),
    );

    // Feuilles d'avant (plus claires, par-dessus le corps).
    _paintLeaf(canvas, size,
        anchor: Offset(cx - w * 0.08, h * 0.62),
        tip: Offset(cx - w * 0.22, h * 0.48),
        mirror: false);
    _paintLeaf(canvas, size,
        anchor: Offset(cx + w * 0.08, h * 0.60),
        tip: Offset(cx + w * 0.24, h * 0.46),
        mirror: true);

    // 3 mini fleurs roses.
    for (final pos in <Offset>[
      Offset(cx - w * 0.16, h * 0.35),
      Offset(cx + w * 0.02, h * 0.28),
      Offset(cx + w * 0.18, h * 0.38),
    ]) {
      _paintMiniFlower(canvas, size, center: pos, radius: w * 0.04);
    }

    // Highlight sur le corps.
    final hlRect = Rect.fromCenter(
      center: Offset(cx - w * 0.12, h * 0.40),
      width: w * 0.14,
      height: h * 0.08,
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

    // Yeux au centre.
    _paintEye(canvas, size,
        center: Offset(cx - w * 0.07, h * 0.50), blink: blink);
    _paintEye(canvas, size,
        center: Offset(cx + w * 0.07, h * 0.50), blink: blink);

    final mouth = Path()
      ..moveTo(cx - w * 0.03, h * 0.58)
      ..quadraticBezierTo(cx, h * 0.61, cx + w * 0.03, h * 0.58);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF2A4A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.010
        ..strokeCap = StrokeCap.round,
    );
    _paintBlush(canvas, size, center: Offset(cx - w * 0.14, h * 0.56));
    _paintBlush(canvas, size, center: Offset(cx + w * 0.14, h * 0.56));
  }

  /// Arbrisseau (niveau 60-74) : petit tronc fin + canopée naissante,
  /// plus petit que l'arbre adulte.
  void _paintPoussiaSapling(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    _paintEarthMound(canvas, size, topY: h * 0.85, width: w * 0.55);

    // Petit tronc fin.
    final trunkPath = Path()
      ..moveTo(cx - w * 0.025, h * 0.86)
      ..lineTo(cx - w * 0.020, h * 0.56)
      ..lineTo(cx + w * 0.020, h * 0.56)
      ..lineTo(cx + w * 0.025, h * 0.86)
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
        ).createShader(Rect.fromLTWH(
            cx - w * 0.025, h * 0.56, w * 0.05, h * 0.30)),
    );

    // Canopée plus petite.
    final canopyCenter = Offset(cx, h * 0.38);
    final canopyRect = Rect.fromCenter(
      center: canopyCenter,
      width: w * 0.54,
      height: h * 0.42,
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

    final hlRect = Rect.fromCenter(
      center: canopyCenter + Offset(-w * 0.08, -h * 0.08),
      width: w * 0.14,
      height: h * 0.08,
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

    _paintEye(canvas, size,
        center: canopyCenter + Offset(-w * 0.06, h * 0.01), blink: blink);
    _paintEye(canvas, size,
        center: canopyCenter + Offset(w * 0.06, h * 0.01), blink: blink);

    final mouth = Path()
      ..moveTo(cx - w * 0.03, canopyCenter.dy + h * 0.08)
      ..quadraticBezierTo(
        cx, canopyCenter.dy + h * 0.11,
        cx + w * 0.03, canopyCenter.dy + h * 0.08,
      );
    canvas.drawPath(
      mouth,
      Paint()
        ..color = const Color(0xFF1A4A1A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.010
        ..strokeCap = StrokeCap.round,
    );
    _paintBlush(canvas, size,
        center: canopyCenter + Offset(-w * 0.12, h * 0.05));
    _paintBlush(canvas, size,
        center: canopyCenter + Offset(w * 0.12, h * 0.05));
  }

  /// Arbre légendaire (niveau 100) : même base que l'arbre mais avec
  /// une aura dorée, des petites étoiles autour et un highlight magique.
  void _paintPoussiaLegendaryTree(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    final canopyCenter = Offset(cx, h * 0.30);

    // Aura dorée derrière l'arbre.
    final auraRect = Rect.fromCenter(
      center: canopyCenter,
      width: w * 1.0,
      height: h * 0.85,
    );
    canvas.drawOval(
      auraRect,
      Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFFE8A0).withOpacity(0.55),
            const Color(0xFFFFE8A0).withOpacity(0.12),
            const Color(0xFFFFE8A0).withOpacity(0.0),
          ],
          stops: const <double>[0.0, 0.5, 1.0],
        ).createShader(auraRect),
    );

    // On délègue à _paintPoussiaTree pour l'arbre lui-même.
    _paintPoussiaTree(canvas, size);

    // Étoiles autour.
    final starPositions = <Offset>[
      Offset(cx - w * 0.38, h * 0.18),
      Offset(cx + w * 0.36, h * 0.12),
      Offset(cx - w * 0.32, h * 0.45),
      Offset(cx + w * 0.38, h * 0.42),
      Offset(cx - w * 0.10, h * 0.06),
      Offset(cx + w * 0.14, h * 0.04),
    ];
    for (int i = 0; i < starPositions.length; i++) {
      _paintStar(
        canvas,
        center: starPositions[i],
        size: w * (0.020 + (i.isEven ? 0.010 : 0.004)),
        color: Colors.white,
      );
    }

    // Couronne brillante au-dessus de la canopée.
    _paintCrownSparkle(canvas, size, center: Offset(cx, h * 0.08));
  }

  // ─────────────────────────────────────────────────────────────────
  // Helpers de stade
  // ─────────────────────────────────────────────────────────────────

  void _paintEarthMound(Canvas canvas, Size size,
      {required double topY, required double width}) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    final left = cx - width / 2;
    final right = cx + width / 2;
    final earthPath = Path()
      ..moveTo(left, h * 0.94)
      ..quadraticBezierTo(cx, topY, right, h * 0.94)
      ..lineTo(right, h * 0.96)
      ..lineTo(left, h * 0.96)
      ..close();
    canvas.drawPath(
      earthPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.5),
          colors: const <Color>[Color(0xFF8B6B4A), Color(0xFF5A3A1A)],
        ).createShader(Rect.fromLTWH(left, topY, width, h * 0.96 - topY)),
    );
  }

  void _paintMiniFlower(Canvas canvas, Size size,
      {required Offset center, required double radius}) {
    // 5 pétales roses + centre jaune.
    for (int i = 0; i < 5; i++) {
      final angle = (i * math.pi * 2 / 5) - math.pi / 2;
      final p = center + Offset(math.cos(angle) * radius, math.sin(angle) * radius);
      canvas.drawCircle(
        p,
        radius * 0.55,
        Paint()..color = const Color(0xFFFFB7D5),
      );
    }
    canvas.drawCircle(
      center,
      radius * 0.5,
      Paint()..color = const Color(0xFFFFE68A),
    );
  }

  void _paintStar(Canvas canvas,
      {required Offset center, required double size, required Color color}) {
    final path = Path();
    const points = 4;
    for (int i = 0; i < points * 2; i++) {
      final angle = i * math.pi / points - math.pi / 2;
      final r = i.isEven ? size : size * 0.38;
      final p = center + Offset(math.cos(angle) * r, math.sin(angle) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void _paintCrownSparkle(Canvas canvas, Size size, {required Offset center}) {
    final w = size.width;
    // Gros point central.
    canvas.drawCircle(center, w * 0.015, Paint()..color = Colors.white);
    // 4 rayons.
    for (int i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      final p1 = center + Offset(math.cos(angle) * w * 0.015, math.sin(angle) * w * 0.015);
      final p2 = center + Offset(math.cos(angle) * w * 0.04, math.sin(angle) * w * 0.04);
      canvas.drawLine(
        p1, p2,
        Paint()
          ..color = Colors.white
          ..strokeWidth = w * 0.006
          ..strokeCap = StrokeCap.round,
      );
    }
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
