/// Les grandes cartes kawaii du tableau de bord, et la bulle qui les décore.
///
/// ⚠️ Ces widgets vivaient dans `sow_screen.dart`,
/// 1 051 lignes dont 570 de décor. L'écran ne garde que ce qui
/// calcule.
library;

import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/text_scale.dart';
import '../../../../services/audio_service.dart';

class KawaiiCard extends StatelessWidget {
  final String emoji;
  final String? imagePath;
  final String label;
  final String subtitle;
  final List<Color> gradientColors;
  final Color bubbleColor;
  final VoidCallback onTap;

  const KawaiiCard({
    super.key,
    required this.emoji,
    this.imagePath,
    required this.label,
    required this.subtitle,
    required this.gradientColors,
    required this.bubbleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $subtitle',
      button: true,
      child: GestureDetector(
        onTap: () {
          AudioService.instance.play(Sfx.tap);
          onTap();
        },
        child: Container(
          // 138 et non 130 : la hauteur utile était de 98 px, et un
          // libellé sur deux lignes en demande 99 (44 d'icône + 40 de
          // titre + 2 + 13 de sous-titre). « Défis & badges » tient sur
          // une ligne, « Challenges & badges » et « Retos e insignias »
          // non — la carte les coupait au milieu.
          height: scaledHeight(context, 138),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: gradientColors.last.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: -8,
                right: -8,
                child: Bubble(
                    size: 40, color: bubbleColor.withValues(alpha: 0.15)),
              ),
              Positioned(
                bottom: 10,
                right: 12,
                child: Bubble(
                    size: 24, color: bubbleColor.withValues(alpha: 0.12)),
              ),
              Positioned(
                top: 20,
                right: 30,
                child: Bubble(
                    size: 14, color: bubbleColor.withValues(alpha: 0.10)),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: bubbleColor.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: imagePath != null
                          ? ClipOval(
                              child: Image.asset(imagePath!,
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Text(emoji,
                                      style: const TextStyle(fontSize: 22))),
                            )
                          : Text(emoji, style: const TextStyle(fontSize: 22)),
                    ),
                    // ⚠️ Le titre et le sous-titre forment **un seul**
                    // enfant flexible, collé en bas par le
                    // `spaceBetween` de la colonne.
                    //
                    // Avant, un `Spacer()` poussait le texte vers le
                    // bas. Mais un `Spacer` est un `Expanded`, donc il
                    // se partageait l'espace libre à parts égales avec
                    // le titre : celui-ci n'obtenait qu'une ligne, et
                    // « Challenges & badges » s'affichait
                    // « Challenges & ». Le français, qui tient sur une
                    // ligne, ne montrait rien du problème.
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              label,
                              style: TextStyle(
                                color: KultivaColors.textPrimary
                                    .withValues(alpha: 0.9),
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: KultivaColors.textPrimary
                                  .withValues(alpha: 0.55),
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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

class Bubble extends StatelessWidget {
  final double size;
  final Color color;
  const Bubble({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Slides du carrousel
// ═══════════════════════════════════════════════════════════════════════════════

/// Base décorative commune à tous les slides.
