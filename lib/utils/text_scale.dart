import 'package:flutter/material.dart';

/// Hauteur fixe qui suit la taille de texte choisie par l'utilisateur.
///
/// Les barres de filtres, les sélecteurs de mois et les tuiles de l'app
/// sont posés dans des `SizedBox` à hauteur fixe. Tant que le texte
/// garde sa taille par défaut, tout tient ; dès que l'utilisateur
/// agrandit la police dans les réglages de son téléphone — ce que fait
/// toute personne qui voit mal — le contenu déborde de la boîte et
/// Flutter affiche la bande jaune et noire.
///
/// `scaledHeight(context, 48)` rend 48 au réglage normal, et une boîte
/// plus haute quand le texte grossit. L'app plafonne par ailleurs le
/// facteur à 1,3 (voir `main.dart`), ce qui borne l'agrandissement.
///
/// À utiliser pour une boîte **qui contient du texte**. Une hauteur
/// d'espacement (`SizedBox(height: 12)` entre deux blocs) ou une taille
/// d'image n'ont pas à bouger.
double scaledHeight(BuildContext context, double base) =>
    MediaQuery.of(context).textScaler.scale(base);

/// Fige la taille de texte à l'intérieur d'une image.
///
/// Les cartes à partager (plant, défi, Tamassi) et la carte de badge
/// sont dessinées sur une toile aux dimensions fixes, puis exportées
/// en PNG. Les y faire suivre la police du téléphone ne rend service à
/// personne : l'image part sur Instagram, où elle sera lue par
/// d'autres gens, et un texte agrandi n'y gagne pas en lisibilité — il
/// sort du cadre.
///
/// À ne jamais utiliser sur une interface que l'utilisateur lit
/// lui-même. Là, le bon réflexe est `scaledHeight`.
class FixedTextScale extends StatelessWidget {
  final Widget child;
  const FixedTextScale({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: child,
    );
  }
}

/// Combien de lignes **entières** d'un texte tiennent dans [hauteur].
///
/// ⚠️ Le défaut que ça corrige, vu à l'écran le 03/11/2026 en prenant
/// la capture « Défis & badges » pour les boutiques : les descriptions
/// des tuiles de badge étaient **coupées en plein milieu d'une ligne**
/// — « Planter ton premier » puis la moitié haute des lettres de
/// « légume ».
///
/// La cause n'est pas l'ellipse, c'est qu'elle ne se déclenchait pas.
/// Le `Text` portait `maxLines: 4` dans un `Expanded` qui n'offrait que
/// la place d'une ligne et demie : le paragraphe se croyait dans les
/// clous, donc pas d'ellipse, et c'est la **boîte** qui tranchait. Un
/// `maxLines` doit valoir ce que la boîte peut montrer, pas ce que
/// l'auteur espère.
///
/// [taille] est la taille de police **non mise à l'échelle** ; c'est
/// cette fonction qui applique le réglage de l'utilisateur, sans quoi
/// le calcul retomberait faux dès qu'il agrandit la police — soit
/// exactement le cas que `scaledHeight` existe pour couvrir.
int lignesQuiTiennent(
  BuildContext context,
  double hauteur,
  double taille, {
  double interligne = 1.3,
  int max = 4,
}) {
  final hauteurLigne = MediaQuery.textScalerOf(context).scale(taille) * interligne;
  if (hauteurLigne <= 0) return 1;
  return (hauteur / hauteurLigne).floor().clamp(1, max);
}
