import 'package:flutter/material.dart';

/// L'image d'un légume, à coins arrondis.
///
/// Les visuels du catalogue portent un fond crème cuit dans le fichier.
/// Posés tels quels sur une case verte à coins arrondis — le potager
/// carré, les cartes du plant picker — ils y dessinent un carré beige à
/// angles droits. Le clip leur donne l'arrondi de la case qui les
/// accueille.
///
/// L'`AspectRatio` n'est pas décoratif. Les visuels sont carrés, et sans
/// lui le clip arrondirait la boîte du widget, pas l'image dessinée
/// dedans : `BoxFit.contain` la centre, et dans une boîte plus haute que
/// large elle ne touche pas les coins qu'on vient d'arrondir.
class VegetableImage extends StatelessWidget {
  /// Chemin de l'asset, non nul — l'appelant choisit quoi faire quand
  /// le légume n'a pas d'image.
  final String asset;

  /// Repli affiché si l'asset manque à l'appel.
  final String emoji;

  /// À régler sur l'arrondi de la case moins son padding, pour que les
  /// deux courbes soient concentriques.
  final double radius;

  final double emojiSize;

  const VegetableImage({
    super.key,
    required this.asset,
    required this.emoji,
    required this.radius,
    this.emojiSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset(
            asset,
            // `cover` et non `contain` : la boîte est déjà carrée comme
            // l'image, et `cover` garantit qu'elle la remplit jusqu'aux
            // coins, donc que le clip mord.
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Center(
              child: Text(emoji, style: TextStyle(fontSize: emojiSize)),
            ),
          ),
        ),
      ),
    );
  }
}
