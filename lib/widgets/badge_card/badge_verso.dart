/// Le verso d'une carte de badge, et la palette de ses quatre niveaux.
///
/// ⚠️ Ces classes vivaient dans
/// `badge_card.dart`, 1 097 lignes et douze classes pour une
/// seule carte. Un fichier par face.
library;

import 'package:flutter/material.dart';
import '../../data/ui_i18n.dart';
import '../../models/vegetable_medal.dart';
import '../../utils/text_scale.dart';

/// Face arrière de la carte : design "Poussidex Collection" sans
/// dépendre d'un badge spécifique. Même format 280×400 que la face
/// avant pour un retournement fluide.
class BadgeCardBack extends StatelessWidget {
  final bool unlocked;
  final MedalTier tier;

  const BadgeCardBack({super.key, 
    required this.unlocked,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final tierColors = TierColors.forBadge(tier, unlocked);
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: tierColors.innerGradient,
            ),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: frameColor.withValues(alpha: 0.5), width: 2),
          ),
          child: Stack(
            children: <Widget>[
              // Motif de fond : hexagones + sparkles en mosaïque douce.
              Positioned.fill(
                child: Opacity(
                  opacity: 0.25,
                  child: CustomPaint(
                    painter: _BackPatternPainter(color: frameColor),
                  ),
                ),
              ),
              // Contenu central : gros emoji + lettrage stylisé.
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    // Grand logo (emoji central).
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.9),
                        border: Border.all(color: frameColor, width: 3),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: frameColor.withValues(alpha: 0.4),
                            blurRadius: 16,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '🪴',
                        style: TextStyle(fontSize: 72),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      // Le dos de la carte disait « POUSSIDEX », écran
                      // supprimé le 31/10/2026. C'est une carte de
                      // badge : elle le dit.
                      'BADGES',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        letterSpacing: 4,
                        color: tierColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trUi('COLLECTION'),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 5,
                        color: frameColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'KULTIVA',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 3,
                        color: frameColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Motif de fond décoratif pour le dos de carte : petits symboles
/// jardinage (feuilles, sparkles) dispersés en diagonale.

/// Motif de fond décoratif pour le dos de carte : petits symboles
/// jardinage (feuilles, sparkles) dispersés en diagonale.
class _BackPatternPainter extends CustomPainter {
  final Color color;
  _BackPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const symbols = <String>['🌱', '✨', '🍃', '⭐'];
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final step = 48.0;
    int i = 0;
    for (double y = -step; y < size.height + step; y += step) {
      for (double x = -step; x < size.width + step; x += step) {
        final offsetX = (i.isEven) ? 0.0 : step / 2;
        final symbol = symbols[i % symbols.length];
        textPainter.text = TextSpan(
          text: symbol,
          style: TextStyle(
            fontSize: 16,
            color: color.withValues(alpha: 0.8),
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x + offsetX, y));
        i++;
      }
    }
  }

  @override
  bool shouldRepaint(_BackPatternPainter old) => old.color != color;
}

/// Palette de couleurs pour une carte badge selon son [MedalTier].
/// Chaque palier a sa propre teinte de cadre, son gradient, et sa
/// couleur de texte assombrie qui garde le contraste.

/// Palette de couleurs pour une carte badge selon son [MedalTier].
/// Chaque palier a sa propre teinte de cadre, son gradient, et sa
/// couleur de texte assombrie qui garde le contraste.
class TierColors {
  final Color frame;
  final Color glow;
  final Color text;
  final List<Color> frameGradient;
  final List<Color> innerGradient;

  const TierColors({
    required this.frame,
    required this.glow,
    required this.text,
    required this.frameGradient,
    required this.innerGradient,
  });

  static TierColors forBadge(MedalTier tier, bool unlocked) {
    final base = () {
      switch (tier) {
        case MedalTier.bronze:
          return _bronze;
        case MedalTier.silver:
          return _silver;
        case MedalTier.gold:
          return _gold;
        case MedalTier.shiny:
          return _shiny;
        case MedalTier.none:
          return _locked;
      }
    }();
    // Les badges verrouillés gardent la teinte de leur tier mais en
    // version désaturée : l'utilisateur voit à quoi ressemble un
    // shiny/gold sans avoir besoin de le débloquer.
    if (!unlocked) return base._faded();
    return base;
  }

  TierColors _faded() {
    Color dim(Color c) => Color.lerp(c, Colors.grey.shade400, 0.55) ?? c;
    return TierColors(
      frame: dim(frame),
      glow: glow.withValues(alpha: 0),
      text: Colors.grey.shade700,
      frameGradient: frameGradient.map(dim).toList(),
      innerGradient: innerGradient.map(dim).toList(),
    );
  }

  static const _bronze = TierColors(
    frame: Color(0xFFCD7F32),
    glow: Color(0x73B5722B), // 0.45 alpha
    text: Color(0xFF5A3817),
    frameGradient: <Color>[
      Color(0xFFF2D3A7),
      Color(0xFFCD7F32),
      Color(0xFF8E4F10),
    ],
    innerGradient: <Color>[
      Color(0xFFFDEAD3),
      Color(0xFFE8BE85),
    ],
  );

  static const _silver = TierColors(
    frame: Color(0xFF9AA4B0),
    glow: Color(0x7399A4B1),
    text: Color(0xFF2F3A45),
    frameGradient: <Color>[
      Color(0xFFEFF3F8),
      Color(0xFFB8C1CC),
      Color(0xFF6E7986),
    ],
    innerGradient: <Color>[
      Color(0xFFF7F9FC),
      Color(0xFFCED5DE),
    ],
  );

  static const _gold = TierColors(
    frame: Color(0xFFFFB74D),
    glow: Color(0x73FFB800),
    text: Color(0xFF5A3E00),
    frameGradient: <Color>[
      Color(0xFFFFF3B0),
      Color(0xFFFFD54A),
      Color(0xFFE8B923),
    ],
    innerGradient: <Color>[
      Color(0xFFFFF9E6),
      Color(0xFFFFE5A8),
    ],
  );

  static const _shiny = TierColors(
    frame: Color(0xFFFF5CA8),
    glow: Color(0x80FF5CA8), // 0.5 alpha — plus vif
    text: Color(0xFF6B1F4B),
    frameGradient: <Color>[
      Color(0xFFFFB3C1), // rose
      Color(0xFFB5DEFF), // cyan
      Color(0xFFCFB5FF), // lavande
      Color(0xFFFFF0A0), // jaune doux
      Color(0xFFC7F5E0), // mint
    ],
    innerGradient: <Color>[
      Color(0xFFFFF2FA),
      Color(0xFFFFE0EE),
    ],
  );

  static final _locked = TierColors(
    frame: Colors.grey.shade500,
    glow: Colors.grey.shade500.withValues(alpha: 0.3),
    text: Colors.grey.shade700,
    frameGradient: <Color>[
      Colors.grey.shade300,
      Colors.grey.shade400,
    ],
    innerGradient: <Color>[
      Colors.grey.shade100,
      Colors.grey.shade200,
    ],
  );
}
