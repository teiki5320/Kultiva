/// L'animation jouée quand un badge se débloque : la carte qui arrive, et la gerbe de particules.
///
/// ⚠️ Ces classes vivaient dans
/// `badge_card.dart`, 1 097 lignes et douze classes pour une
/// seule carte. Un fichier par face.
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/content_i18n.dart';
import '../../data/ui_i18n.dart';
import '../../data/badges.dart';
import '../../models/vegetable_medal.dart';
import '../../services/audio_service.dart';
import 'badge_recto.dart';

class _BadgeUnlockedOverlay extends StatefulWidget {
  final GardenBadge badge;
  const _BadgeUnlockedOverlay({required this.badge});

  @override
  State<_BadgeUnlockedOverlay> createState() => _BadgeUnlockedOverlayState();
}

class _BadgeUnlockedOverlayState extends State<_BadgeUnlockedOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  // Contrôleur séparé pour le balancement idle une fois la carte posée.
  late final AnimationController _idleCtrl;
  bool _showParticles = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _idleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    // Feedback haptique léger au début (whoosh) pour signaler qu'un
    // truc arrive, suivi d'un impact fort à l'atterrissage.
    HapticFeedback.lightImpact();
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.heavyImpact();
        AudioService.instance.play(Sfx.plant);
        setState(() => _showParticles = true);
        _idleCtrl.repeat();
      }
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _idleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onDismiss: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Burst de particules radiales une fois la carte posée.
            if (_showParticles)
              Positioned.fill(
                child: IgnorePointer(
                  child: _ParticleBurst(tier: widget.badge.tier),
                ),
              ),
            // Carte centrale animée.
            AnimatedBuilder(
              animation: Listenable.merge(<Listenable>[_ctrl, _idleCtrl]),
              builder: (context, _) {
                final t = _ctrl.value;
                // Phase 1 (0 → 0.65) : chute depuis le ciel + spin.
                // Phase 2 (0.65 → 0.95) : atterrissage avec bounce.
                // Phase 3 (0.95 → 1.0) : stabilisation douce.
                final fallCurve = Curves.easeIn.transform(
                  (t / 0.65).clamp(0.0, 1.0),
                );
                final bounceCurve = Curves.elasticOut.transform(
                  ((t - 0.65) / 0.35).clamp(0.0, 1.0),
                );

                // Translation verticale : du haut de l'écran vers le centre.
                final dy = (1 - fallCurve) * -400;
                // Rotation totale : 3 tours complets durant la chute, plus
                // lente qu'avant pour laisser le temps de voir la carte.
                final spinY = (1 - fallCurve) * 3 * 2 * math.pi;
                // Scale : petite quand elle tombe, grossit en atterrissant.
                final scale = 0.3 + bounceCurve * 0.7;
                // Balancement idle une fois posée.
                final idleY = _showParticles
                    ? math.sin(_idleCtrl.value * 2 * math.pi) * 0.2
                    : 0.0;

                final matrix = Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..translateByDouble(0.0, dy, 0.0, 1.0)
                  ..scaleByDouble(scale, scale, scale, 1.0)
                  ..rotateY(spinY + idleY);

                return Transform(
                  alignment: Alignment.center,
                  transform: matrix,
                  child: BadgeCardVisual(
                    badge: widget.badge,
                    unlocked: true,
                    rotationY: spinY + idleY,
                  ),
                );
              },
            ),
            // Banderole "NOUVEAU BADGE !" en haut quand posée.
            if (_showParticles)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.12,
                child: IgnorePointer(
                  child: Column(
                    children: <Widget>[
                      Text(
                        trUi('✨ NOUVEAU BADGE ✨'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.7),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.badge.displayName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.6),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Indication "Tap pour continuer" en bas une fois posée.
            if (_showParticles)
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.08,
                child: IgnorePointer(
                  child: Text(
                    trUi('Tape n\'importe où pour continuer'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.7),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Burst de 24 particules (emojis) qui rayonnent depuis le centre,
/// avec des couleurs et emojis qui varient selon le [tier] du badge.

/// Burst de 24 particules (emojis) qui rayonnent depuis le centre,
/// avec des couleurs et emojis qui varient selon le [tier] du badge.
class _ParticleBurst extends StatefulWidget {
  final MedalTier tier;
  const _ParticleBurst({required this.tier});

  @override
  State<_ParticleBurst> createState() => _ParticleBurstState();
}

class _ParticleBurstState extends State<_ParticleBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<String> get _emojis {
    switch (widget.tier) {
      case MedalTier.bronze:
        return <String>['✨', '🌱', '⭐'];
      case MedalTier.silver:
        return <String>['✨', '⭐', '💫'];
      case MedalTier.gold:
        return <String>['✨', '🏆', '⭐', '💫'];
      case MedalTier.shiny:
        return <String>['✨', '🌈', '⭐', '💫', '💖', '🌟'];
      case MedalTier.none:
        return <String>['✨'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final emojis = _emojis;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final t = _ctrl.value;
        final size = MediaQuery.of(context).size;
        final cx = size.width / 2;
        final cy = size.height / 2;
        return Stack(
          children: List<Widget>.generate(24, (i) {
            final angle = (i / 24) * 2 * math.pi;
            final distance = t * 220;
            final x = cx + math.cos(angle) * distance;
            final y = cy + math.sin(angle) * distance;
            final fontSize = 24.0 * (1 - t * 0.5);
            final opacity = (1 - t).clamp(0.0, 1.0);
            return Positioned(
              left: x - fontSize / 2,
              top: y - fontSize / 2,
              child: Opacity(
                opacity: opacity,
                child: Text(
                  emojis[i % emojis.length],
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Affiche une animation "pack opening" quand un nouveau badge est
/// débloqué : la carte tombe du ciel en tournant sur elle-même, se
/// stabilise au centre en face avant, et des particules de sparkles
/// explosent autour. L'utilisateur peut tap pour fermer.
Future<void> showBadgeUnlockedAnimation(
  BuildContext context, {
  required GardenBadge badge,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.85),
    barrierDismissible: false,
    barrierLabel: trUi('Nouveau badge'),
    transitionDuration: const Duration(milliseconds: 1),
    pageBuilder: (_, __, ___) => _BadgeUnlockedOverlay(badge: badge),
  );
}
