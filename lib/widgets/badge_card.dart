import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/content_i18n.dart';
import '../data/ui_i18n.dart';
import '../data/badges.dart';
import 'badge_card/badge_recto.dart';
import 'badge_card/badge_verso.dart';

// Les trois faces sont réexportées : les écrans qui importaient
// `badge_card.dart` pour `showBadgeUnlockedAnimation` continuent de
// marcher sans rien changer. Même patron que `planner_widgets.dart`.
export 'badge_card/badge_deblocage.dart';
export 'badge_card/badge_recto.dart';
export 'badge_card/badge_verso.dart';

/// Ouvre un overlay plein écran qui affiche une grande carte "Pokemon"
/// pour un badge donné. La carte tourne légèrement en idle sur l'axe Y,
/// et on peut la faire pivoter manuellement en la draguant.
///
/// [unlocked] détermine si la carte est affichée en pleine couleur ou
/// en silhouette verrouillée.
Future<void> showBadgeCard(
  BuildContext context, {
  required GardenBadge badge,
  required bool unlocked,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.75),
    barrierDismissible: true,
    barrierLabel: trUi('Fermer'),
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
  final GardenBadge badge;
  final bool unlocked;

  const _BadgeCardOverlay({
    required this.badge,
    required this.unlocked,
  });

  @override
  State<_BadgeCardOverlay> createState() => _BadgeCardOverlayState();
}

class _BadgeCardOverlayState extends State<_BadgeCardOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _idleCtrl;
  late final AnimationController _flipCtrl;

  /// Rotation Y contrôlée par le drag utilisateur (en radians).
  double _dragRotationY = 0;

  /// Rotation X contrôlée par le drag vertical (en radians).
  double _dragRotationX = 0;

  /// true pendant un drag : pause le balancement idle.
  bool _dragging = false;

  /// true si la carte montre sa face arrière.
  bool _showingBack = false;

  @override
  void initState() {
    super.initState();
    _idleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _idleCtrl.dispose();
    _flipCtrl.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() => _showingBack = !_showingBack);
    if (_showingBack) {
      _flipCtrl.forward();
    } else {
      _flipCtrl.reverse();
    }
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
    return Semantics(
      onDismiss: () => Navigator.of(context).pop(),
      child: GestureDetector(
        // Tap sur le fond → ferme.
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge(<Listenable>[_idleCtrl, _flipCtrl]),
            builder: (context, _) {
              // Balancement idle : sinusoïde ±0.25 rad (~14°) sur Y.
              final idleY = _dragging
                  ? 0.0
                  : math.sin(_idleCtrl.value * 2 * math.pi) * 0.25;
              // Angle du retournement : 0 → π sur _flipCtrl.
              final flipY = _flipCtrl.value * math.pi;
              final totalY = _dragRotationY + idleY + flipY;
              final totalX = _dragRotationX;

              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0015) // perspective
                ..rotateX(totalX)
                ..rotateY(totalY);

              // On détermine quelle face montrer en fonction de l'angle Y
              // effectif (modulo 2π). Si on est dans [π/2, 3π/2] → face
              // arrière. Sinon → face avant.
              final normalizedY =
                  (totalY % (2 * math.pi) + 2 * math.pi) % (2 * math.pi);
              final showBack =
                  normalizedY > math.pi / 2 && normalizedY < 3 * math.pi / 2;

              // Contenu à afficher. Le dos est pré-inversé en miroir (Y)
              // pour compenser la rotation — sans ça, les textes du dos
              // apparaîtraient à l'envers.
              final Widget content = showBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: BadgeCardBack(
                        unlocked: widget.unlocked,
                        tier: widget.badge.tier,
                      ),
                    )
                  : BadgeCardVisual(
                      badge: widget.badge,
                      unlocked: widget.unlocked,
                      rotationX: totalX,
                      rotationY: totalY,
                    );

              return Semantics(
                label: widget.unlocked
                    ? trUiArgs('Badge {0}, débloqué',
                        <Object?>[widget.badge.displayName])
                    : trUiArgs('Badge {0}, verrouillé',
                        <Object?>[widget.badge.displayName]),
                child: GestureDetector(
                  // Tap sur la carte = retournement (au lieu de rien).
                  onTap: _toggleFlip,
                  onPanStart: _onDragStart,
                  onPanUpdate: _onDragUpdate,
                  onPanEnd: _onDragEnd,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: matrix,
                    child: content,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
