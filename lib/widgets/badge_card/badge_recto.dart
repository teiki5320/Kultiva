/// Le recto d'une carte de badge : le visuel, son repli en emoji et le reflet holographique.
///
/// ⚠️ Ces classes vivaient dans
/// `badge_card.dart`, 1 097 lignes et douze classes pour une
/// seule carte. Un fichier par face.
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/content_i18n.dart';
import '../../data/badges.dart';
import '../../theme/app_theme.dart';
import '../lexicon_text.dart';
import 'badge_verso.dart';
import '../../utils/text_scale.dart';

/// Visuel de la carte (face avant). Format ~pokemon (280×400).
class BadgeCardVisual extends StatelessWidget {
  final GardenBadge badge;
  final bool unlocked;

  /// Rotation courante (en radians) — utilisée pour animer l'effet
  /// holographique qui suit le tilt de la carte.
  final double rotationX;
  final double rotationY;

  const BadgeCardVisual({super.key, 
    required this.badge,
    required this.unlocked,
    this.rotationX = 0,
    this.rotationY = 0,
  });

  @override
  Widget build(BuildContext context) {
    final tierColors = TierColors.forBadge(badge.tier, unlocked);
    final Color frameColor = tierColors.frame;

    return FixedTextScale(
      child: Container(
        width: 280,
        height: 400,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: tierColors.frameGradient,
          ),
          border: Border.all(color: frameColor, width: 4),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
            if (unlocked)
              BoxShadow(
                color: tierColors.glow,
                blurRadius: 30,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: frameColor.withValues(alpha: 0.35)),
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
                  color: frameColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: frameColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  badge.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: tierColors.text,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Illustration centrale : image custom si dispo dans
              // assets/images/badges/<id>.webp, sinon gros emoji + sparkles.
              // Superposée d'un effet holographique qui réagit à la
              // rotation de la carte (sur les badges débloqués uniquement).
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: tierColors.innerGradient,
                      ),
                      border: Border.all(
                          color: frameColor.withValues(alpha: 0.4), width: 1.5),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // 1. Illustration (image ou fallback emoji).
                        Opacity(
                          opacity: unlocked ? 1.0 : 0.35,
                          child: Image.asset(
                            'assets/images/badges/${badge.id}.webp',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _EmojiFallback(
                              emoji: badge.emoji,
                              unlocked: unlocked,
                            ),
                          ),
                        ),
                        // 2. Effet holo (badges débloqués uniquement).
                        if (unlocked)
                          IgnorePointer(
                            child: _HolographicOverlay(
                              rotationX: rotationX,
                              rotationY: rotationY,
                            ),
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
                  border: Border.all(color: frameColor.withValues(alpha: 0.25)),
                ),
                child: LexiconText(
                  badge.displayDescription,
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
              // Bas de carte : ID + "KULTIVA".
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
      ),
    );
  }
}

/// Fallback quand l'image `assets/images/badges/<id>.webp` n'existe pas
/// encore : gros emoji centré + sparkles décoratifs.

/// Fallback quand l'image `assets/images/badges/<id>.webp` n'existe pas
/// encore : gros emoji centré + sparkles décoratifs.
class _EmojiFallback extends StatelessWidget {
  final String emoji;
  final bool unlocked;

  const _EmojiFallback({
    required this.emoji,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (unlocked)
          Positioned(
            top: 12,
            left: 14,
            child: Text(
              '✨',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        if (unlocked)
          Positioned(
            bottom: 18,
            right: 18,
            child: Text(
              '⭐',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        Text(emoji, style: const TextStyle(fontSize: 96)),
      ],
    );
  }
}

/// Superposition holographique qui réagit à la rotation de la carte.
///
/// Deux couches :
///  1. Un gradient arc-en-ciel pastel (reflet prismatique) dont
///     l'orientation suit la rotation → on voit différentes teintes
///     selon l'angle de vue.
///  2. Une bande de lumière diagonale (reflet brillant) qui traverse
///     la carte selon [rotationY] → sensation d'un vrai reflet sur
///     une surface brillante.

/// Superposition holographique qui réagit à la rotation de la carte.
///
/// Deux couches :
///  1. Un gradient arc-en-ciel pastel (reflet prismatique) dont
///     l'orientation suit la rotation → on voit différentes teintes
///     selon l'angle de vue.
///  2. Une bande de lumière diagonale (reflet brillant) qui traverse
///     la carte selon [rotationY] → sensation d'un vrai reflet sur
///     une surface brillante.
class _HolographicOverlay extends StatelessWidget {
  final double rotationX;
  final double rotationY;

  const _HolographicOverlay({
    required this.rotationX,
    required this.rotationY,
  });

  static const List<Color> _rainbowColors = <Color>[
    Color(0xFFFFC7E0), // rose
    Color(0xFFC9E6FF), // bleu ciel
    Color(0xFFD8C7FF), // lavande
    Color(0xFFFFF3B0), // jaune doux
    Color(0xFFC7F5E0), // mint
    Color(0xFFFFC7E0), // bouclage rose
  ];

  @override
  Widget build(BuildContext context) {
    // Position normalisée du spot brillant, dérivée de rotationY.
    // rotationY = 0 → centre ; rotationY > 0 → droite ; rotationY < 0
    // → gauche. On clamp pour qu'à fort tilt le reflet sorte du cadre
    // plutôt que de s'étirer.
    final rawPos = 0.5 + rotationY * 0.6;
    final shinePos = rawPos.clamp(-0.2, 1.2);
    final left = (shinePos - 0.18).clamp(0.0, 1.0);
    final mid = shinePos.clamp(0.0, 1.0);
    final right = (shinePos + 0.18).clamp(0.0, 1.0);

    // Intensité du reflet : maximum au tilt maximal, faible au repos.
    final tiltMagnitude = (rotationY.abs() + rotationX.abs()).clamp(0.0, 1.0);
    final shineOpacity = 0.15 + tiltMagnitude * 0.4;

    // Angle du gradient arc-en-ciel : rotate selon rotationY pour donner
    // l'illusion que les teintes changent avec l'inclinaison.
    final angleRad = rotationY * 1.5;
    final dx = math.cos(angleRad);
    final dy = math.sin(angleRad);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Couche 1 : teinte arc-en-ciel (blendMode plus = additive).
        Opacity(
          opacity: 0.25,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-dx, -dy),
                end: Alignment(dx, dy),
                colors: _rainbowColors,
              ),
            ),
          ),
        ),
        // Couche 2 : bande de lumière qui traverse la carte.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: <double>[
                left,
                mid,
                right,
              ],
              colors: <Color>[
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: shineOpacity),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Face arrière de la carte : design "Poussidex Collection" sans
/// dépendre d'un badge spécifique. Même format 280×400 que la face
/// avant pour un retournement fluide.
