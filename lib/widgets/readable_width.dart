import 'package:flutter/material.dart';

/// Borne la largeur du contenu et le centre sur les grands écrans.
///
/// Kultiva a été dessinée pour un téléphone. Sur un iPad en paysage,
/// la même mise en page s'étire sur 1 366 points : une ligne de texte
/// traverse l'écran d'un bord à l'autre, et l'œil perd le début de la
/// ligne suivante. Une carte prévue pour 340 points devient une bande
/// presque vide.
///
/// 720 points est la mesure retenue — assez large pour deux colonnes
/// de tuiles, assez étroite pour qu'une phrase reste lisible. En
/// dessous de cette largeur, ce widget ne fait rien : sur téléphone,
/// l'affichage est identique au pixel près.
class ReadableWidth extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ReadableWidth({super.key, required this.child, this.maxWidth = 720});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
