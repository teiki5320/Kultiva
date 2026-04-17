import 'package:flutter/material.dart';

/// Les 3 starters jouables (style Pokémon).
enum CreatureStarter { poussia, soleia, racia }

/// La créature-plante du Poussidex. Rendue 100% en CustomPainter —
/// son apparence évolue avec le niveau.
///
/// Étape 1 : dessin statique de Poussia au stade "pousse" uniquement.
/// Les animations et les autres stades arrivent dans les étapes suivantes.
class PlantCreature extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _CreaturePainter(level: level, starter: starter),
      ),
    );
  }
}

class _CreaturePainter extends CustomPainter {
  final int level;
  final CreatureStarter starter;

  _CreaturePainter({required this.level, required this.starter});

  @override
  void paint(Canvas canvas, Size size) {
    // Étape 1 : on ignore le level et starter, on dessine toujours
    // Poussia au stade "pousse".
    _paintGroundShadow(canvas, size);
    _paintPoussiaSprout(canvas, size);
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

    // --- 6. Yeux kawaii ---
    _paintEye(canvas, size, center: Offset(cx - w * 0.09, h * 0.36));
    _paintEye(canvas, size, center: Offset(cx + w * 0.09, h * 0.36));

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

  void _paintEye(Canvas canvas, Size size, {required Offset center}) {
    final eyeWidth = size.width * 0.08;
    final eyeHeight = size.height * 0.10;

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
    // Pupille.
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(0, size.height * 0.01),
        width: eyeWidth * 0.55,
        height: eyeHeight * 0.62,
      ),
      Paint()..color = const Color(0xFF1A2A20),
    );
    // Reflet dans la pupille (2 points brillants).
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
      old.level != level || old.starter != starter;
}

extension _OffsetNorm on Offset {
  Offset normalized() {
    final d = distance;
    if (d == 0) return Offset.zero;
    return Offset(dx / d, dy / d);
  }
}
