import 'package:flutter/material.dart';

/// Une grille qui choisit son nombre de colonnes d'après la largeur
/// disponible, et dont les tuiles **remplissent** la ligne.
///
/// ⚠️ Pourquoi elle existe. Le 03/11/2026, après avoir borné le contenu
/// à 720 points sur iPad, Jean a regardé l'écran et dit ce qui se
/// voyait : « ça ne prend pas toute la place ». Il avait raison deux
/// fois. La colonne laissait 150 points vides de chaque côté, et à
/// l'intérieur les tuiles — larges de 90 points, alignées à gauche dans
/// une liste horizontale — n'en remplissaient même pas la moitié.
///
/// Borner une colonne de **texte** est juste : l'œil perd le début de
/// la ligne suivante au-delà d'une certaine mesure. Borner une grille
/// de **tuiles** ne l'est pas : une tuile de plus par ligne, c'est une
/// tuile de plus qu'on voit sans défiler. D'où la règle retenue : le
/// texte garde sa mesure, les grilles prennent la largeur.
///
/// [largeurCible] est la largeur **souhaitée** d'une tuile, pas la
/// largeur finale : le nombre de colonnes en est déduit, puis l'espace
/// restant est redistribué pour que la dernière tuile touche le bord
/// droit. Sur un téléphone de 375 points avec une cible de 170, on
/// obtient deux colonnes — exactement ce que l'app affichait avant.
class GrilleAdaptative extends StatelessWidget {
  final List<Widget> enfants;
  final double largeurCible;
  final double espacement;

  /// Plafond de colonnes. Six cartes sur une seule ligne, sur un écran
  /// très large, redeviendraient des bandes : c'est le défaut qu'on
  /// corrige, pas celui qu'on veut recréer à l'autre bout.
  final int colonnesMax;

  const GrilleAdaptative({
    super.key,
    required this.enfants,
    required this.largeurCible,
    this.espacement = 12,
    this.colonnesMax = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        final dispo = contraintes.maxWidth;
        var colonnes = ((dispo + espacement) / (largeurCible + espacement))
            .floor()
            .clamp(1, colonnesMax);
        // Jamais plus de colonnes que de tuiles : sinon la dernière
        // ligne s'étire sur une largeur calculée pour une ligne pleine.
        if (colonnes > enfants.length) colonnes = enfants.length;
        final largeur =
            (dispo - espacement * (colonnes - 1)) / colonnes;
        return Wrap(
          spacing: espacement,
          runSpacing: espacement,
          children: <Widget>[
            for (final e in enfants) SizedBox(width: largeur, child: e),
          ],
        );
      },
    );
  }
}
