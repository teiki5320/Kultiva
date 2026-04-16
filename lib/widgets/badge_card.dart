import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/badges.dart';
import '../theme/app_theme.dart';

/// Ouvre un overlay plein écran qui affiche une grande carte "Pokemon"
/// pour un badge donné. La carte tourne légèrement en idle sur l'axe Y,
/// et on peut la faire pivoter manuellement en la draguant.
///
/// [unlocked] détermine si la carte est affichée en pleine couleur ou
/// en silhouette verrouillée.
Future<void> showBadgeCard(
  BuildContext context, {
  required PoussidexBadge badge,
  required bool unlocked,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.75),
    barrierDismissible: true,
    barrierLabel: 'Fermer',
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, __, ___) => _BadgeCardOverlay(
      badge: badge,
      unlocked: unlocked,
    ),
    transitionBuilder: (context, anim, _, child) {
      final scale = Tween<double>(begin: 0.7, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOutBack))
          .animate(anim);
      return FadeTransition(
        opacity: anim,
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}

class _BadgeCardOverlay extends StatefulWidget {
  final PoussidexBadge badge;
  final bool unlocked;

  const _BadgeCardOverlay({
    required this.badge,
    required this.unlocked,
  });

  @override
  State<_BadgeCardOverlay> createState() => _BadgeCardOverlayState();
}

class _BadgeCardOverlayState extends State<_BadgeCardOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _idleCtrl;

  /// Rotation Y contrôlée par le drag utilisateur (en radians).
  double _dragRotationY = 0;

  /// Rotation X contrôlée par le drag vertical (en radians).
  double _dragRotationX = 0;

  /// true pendant un drag : pause le balancement idle.
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _idleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _idleCtrl.dispose();
    super.dispose();
  }

  void _onDragStart(_) {
    setState(() => _dragging = true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 0.008 rad par pixel = ~0.5° par pixel → une gesture normale
      // (quelques centaines de pixels) permet un demi-tour.
      _dragRotationY += details.delta.dx * 0.008;
      _dragRotationX -= details.delta.dy * 0.005;
      // Cap X rotation pour éviter de retourner la carte verticalement.
      _dragRotationX = _dragRotationX.clamp(-0.6, 0.6);
    });
  }

  void _onDragEnd(_) {
    setState(() => _dragging = false);
    // On ne reset pas la rotation : la carte reste là où l'utilisateur
    // l'a laissée, et le balancement idle reprend à partir de cette
    // position.
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tap sur le fond → ferme.
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedBuilder(
          animation: _idleCtrl,
          builder: (context, _) {
            // Balancement idle : sinusoïde ±0.25 rad (~14°) sur Y.
            final idleY = _dragging
                ? 0.0
                : math.sin(_idleCtrl.value * 2 * math.pi) * 0.25;
            final totalY = _dragRotationY + idleY;
            final totalX = _dragRotationX;

            final matrix = Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // perspective
              ..rotateX(totalX)
              ..rotateY(totalY);

            return GestureDetector(
              // Le tap sur la carte ne ferme pas (on absorbe l'event).
              onTap: () {},
              onPanStart: _onDragStart,
              onPanUpdate: _onDragUpdate,
              onPanEnd: _onDragEnd,
              child: Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: _BadgeCardVisual(
                  badge: widget.badge,
                  unlocked: widget.unlocked,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Visuel de la carte (face avant). Format ~pokemon (280×400).
class _BadgeCardVisual extends StatelessWidget {
  final PoussidexBadge badge;
  final bool unlocked;

  const _BadgeCardVisual({
    required this.badge,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFB74D);
    final Color frameColor = unlocked ? gold : Colors.grey.shade500;

    return Container(
      width: 280,
      height: 400,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: unlocked
              ? <Color>[
                  const Color(0xFFFFF3B0),
                  const Color(0xFFFFD54A),
                  const Color(0xFFE8B923),
                ]
              : <Color>[
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                ],
        ),
        border: Border.all(color: frameColor, width: 4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          if (unlocked)
            BoxShadow(
              color: gold.withOpacity(0.45),
              blurRadius: 30,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: frameColor.withOpacity(0.35)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          children: <Widget>[
            // Bandeau du nom.
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: frameColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: frameColor.withOpacity(0.5)),
              ),
              child: Text(
                badge.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: unlocked
                      ? const Color(0xFF5A3E00)
                      : Colors.grey.shade700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Illustration centrale : grand emoji dans un cadre coloré.
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: unlocked
                        ? <Color>[
                            const Color(0xFFFFF9E6),
                            const Color(0xFFFFE5A8),
                          ]
                        : <Color>[
                            Colors.grey.shade100,
                            Colors.grey.shade200,
                          ],
                  ),
                  border: Border.all(
                      color: frameColor.withOpacity(0.4), width: 1.5),
                ),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: unlocked ? 1.0 : 0.35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      if (unlocked)
                        // Étoiles décoratives en fond d'illustration.
                        Positioned(
                          top: 12,
                          left: 14,
                          child: Text('✨',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.9),
                              )),
                        ),
                      if (unlocked)
                        Positioned(
                          bottom: 18,
                          right: 18,
                          child: Text('⭐',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              )),
                        ),
                      Text(
                        badge.emoji,
                        style: const TextStyle(fontSize: 96),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Description.
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: frameColor.withOpacity(0.25)),
              ),
              child: Text(
                badge.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  color: unlocked
                      ? KultivaColors.textPrimary
                      : Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Bas de carte : ID + "Kultiva".
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '#${badge.id.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'KULTIVA',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: frameColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
