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
