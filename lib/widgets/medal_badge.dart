import 'package:flutter/material.dart';

import '../models/vegetable_medal.dart';

/// Affiche un emoji dans un cercle entouré d'un anneau coloré selon le
/// palier [MedalTier]. Utilisé sur les cards Poussidex, le catalogue
/// Étal et la fiche détail d'un légume.
///
/// Pour [MedalTier.shiny], l'anneau est un gradient arc-en-ciel et une
/// légère aura rose rayonne autour.
class MedalBadge extends StatelessWidget {
  final String emoji;
  final MedalTier tier;
  final double size;
  final Color familyColor;

  /// Si [showCornerMedal] est true, une petite pastille emoji
  /// (🥉/🥈/🥇/✨) est posée dans le coin en haut à droite.
  final bool showCornerMedal;

  const MedalBadge({
    super.key,
    required this.emoji,
    required this.tier,
    required this.familyColor,
    this.size = 70,
    this.showCornerMedal = true,
  });

  static const List<Color> _shinyGradient = <Color>[
    Color(0xFFFF5CA8), // rose
    Color(0xFFB565F2), // violet
    Color(0xFF5AC8FA), // cyan
    Color(0xFF6CD6A0), // mint
    Color(0xFFFFD36E), // jaune doux
    Color(0xFFFF5CA8), // bouclage rose
  ];

  @override
  Widget build(BuildContext context) {
    final ringColor = _ringColor;
    final double ringWidth =
        tier == MedalTier.none ? 1.5 : (tier == MedalTier.shiny ? 3.5 : 3.0);
    final double emojiSize = size * 0.55;
    final cornerSize = (size * 0.34).clamp(16.0, 26.0);

    // Fond du cercle : teinte famille par défaut ; gold reçoit un dégradé
    // radial doré pour matérialiser l'effet "pièce".
    final BoxDecoration circleDecoration = tier == MedalTier.gold
        ? const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                Color(0xFFFFF3B0), // centre jaune clair
                Color(0xFFFFD54A), // milieu or
                Color(0xFFE8B923), // bord or profond
              ],
              stops: <double>[0.0, 0.65, 1.0],
            ),
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            color: familyColor.withOpacity(0.15),
          );

    Widget circle = Container(
      width: size,
      height: size,
      decoration: circleDecoration,
      alignment: Alignment.center,
      child: Text(emoji, style: TextStyle(fontSize: emojiSize)),
    );

    // Anneau : uni (bronze/silver/gold) ou arc-en-ciel (shiny).
    Widget ring;
    if (tier == MedalTier.shiny) {
      ring = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const SweepGradient(colors: _shinyGradient),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFFF5CA8).withOpacity(0.5),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(ringWidth),
        child: ClipOval(child: circle),
      );
    } else {
      ring = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor, width: ringWidth),
          boxShadow: tier == MedalTier.gold
              ? <BoxShadow>[
                  BoxShadow(
                    color: ringColor.withOpacity(0.35),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: ClipOval(child: circle),
      );
    }

    if (!showCornerMedal || tier == MedalTier.none) {
      return ring;
    }

    // Pastille médaille coin haut-droit.
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ring,
          Positioned(
            top: -2,
            right: -4,
            child: Container(
              width: cornerSize,
              height: cornerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                tier.emoji,
                style: TextStyle(fontSize: cornerSize * 0.62),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color get _ringColor {
    switch (tier) {
      case MedalTier.none:
        return familyColor.withOpacity(0.35);
      case MedalTier.bronze:
      case MedalTier.silver:
      case MedalTier.gold:
      case MedalTier.shiny:
        return tier.color;
    }
  }
}
