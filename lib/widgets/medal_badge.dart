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

  /// Image kawaii affichée à la place de l'emoji si renseignée
  /// (ex. fiches accessoires). Fallback emoji si null ou si le load échoue.
  final String? imageAsset;

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
    this.imageAsset,
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

    // Construction du cercle inner : simple fond famille pour
    // none/bronze/shiny ; pièce métallique brillante pour silver/gold.
    Widget circle = _buildInnerCircle(emojiSize);

    // Anneau + glow extérieur. Silver et gold reçoivent un vrai glow
    // (pas qu'un boxShadow discret) pour trancher sur les fonds pastel.
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
      final glowShadows = switch (tier) {
        MedalTier.gold => <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFFFB800).withOpacity(0.55),
              blurRadius: 18,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: const Color(0xFFFFF0A0).withOpacity(0.45),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        MedalTier.silver => <BoxShadow>[
            BoxShadow(
              color: const Color(0xFF9AA4B0).withOpacity(0.45),
              blurRadius: 14,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        _ => const <BoxShadow>[],
      };
      ring = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor, width: ringWidth),
          boxShadow: glowShadows,
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

  /// Construit le disque central. Pour silver/gold, empile :
  ///  1. dégradé radial décalé (lumière venant du haut-gauche),
  ///  2. reflet diagonal (band gloss) qui simule un reflet de lumière,
  ///  3. highlight brillant en haut-gauche,
  ///  4. l'emoji centré.
  /// Pour les autres paliers, simple cercle teinté famille.
  Widget _buildInnerCircle(double emojiSize) {
    final isMetallic =
        tier == MedalTier.silver || tier == MedalTier.gold;
    if (!isMetallic) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: familyColor.withOpacity(0.15),
        ),
        alignment: Alignment.center,
        child: _buildCenterContent(emojiSize),
      );
    }

    final List<Color> metallicColors = tier == MedalTier.gold
        ? const <Color>[
            Color(0xFFFFFCE0), // highlight quasi blanc
            Color(0xFFFFE870), // or clair
            Color(0xFFF5C518), // or vif
            Color(0xFFB8851F), // or profond (ombre)
          ]
        : const <Color>[
            Color(0xFFFFFFFF), // highlight pur
            Color(0xFFE5EAF0), // argent clair
            Color(0xFFB8C1CC), // argent
            Color(0xFF6E7986), // argent profond (ombre)
          ];

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // 1. Disque métallique : dégradé radial décalé pour simuler
          //    une source de lumière en haut-gauche.
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.4),
                radius: 1.1,
                colors: metallicColors,
                stops: const <double>[0.0, 0.25, 0.65, 1.0],
              ),
            ),
          ),
          // 2. Bande de reflet diagonale (gloss) — très subtile.
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.white.withOpacity(0.45),
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.15),
                ],
                stops: const <double>[0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          // 3. Highlight spéculaire (petit spot blanc en haut-gauche).
          Positioned(
            top: size * 0.12,
            left: size * 0.18,
            child: Container(
              width: size * 0.32,
              height: size * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const <double>[0.0, 1.0],
                ),
              ),
            ),
          ),
          // 4. Emoji (ou image kawaii) centré.
          _buildCenterContent(emojiSize),
        ],
      ),
    );
  }

  /// Affiche l'image kawaii si fournie, sinon l'emoji.
  /// L'image est insérée dans un padding interne pour laisser un petit
  /// espace autour, et basculée en emoji si le chargement échoue.
  Widget _buildCenterContent(double emojiSize) {
    if (imageAsset == null) {
      return Text(emoji, style: TextStyle(fontSize: emojiSize));
    }
    final double imgSize = size * 0.82;
    return Image.asset(
      imageAsset!,
      width: imgSize,
      height: imgSize,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) =>
          Text(emoji, style: TextStyle(fontSize: emojiSize)),
    );
  }
}
