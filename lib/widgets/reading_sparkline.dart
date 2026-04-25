import 'package:flutter/material.dart';

/// Sparkline minimaliste : trace une courbe lissée à partir d'une liste
/// de valeurs (de gauche = ancien à droite = récent).
///
/// Pas de package externe : un simple CustomPainter qui dessine une
/// polyline + un dot sur le dernier point.
class ReadingSparkline extends StatelessWidget {
  final List<double> values;
  final Color color;
  final double height;

  const ReadingSparkline({
    super.key,
    required this.values,
    required this.color,
    this.height = 22,
  });

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) {
      return SizedBox(height: height);
    }
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparkPainter(values: values, color: color),
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  final List<double> values;
  final Color color;

  _SparkPainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final minV = values.reduce((a, b) => a < b ? a : b);
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 0.0001 ? 1.0 : (maxV - minV);

    final stepX = size.width / (values.length - 1);
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = stepX * i;
      final norm = (values[i] - minV) / range;
      final y = size.height - norm * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final stroke = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, stroke);

    final lastX = stepX * (values.length - 1);
    final lastNorm = (values.last - minV) / range;
    final lastY = size.height - lastNorm * size.height;
    final dot = Paint()..color = color;
    canvas.drawCircle(Offset(lastX, lastY), 2.2, dot);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter old) =>
      old.values != values || old.color != color;
}
