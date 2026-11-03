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

  /// Hauteur de la carte pour une largeur donnée.
  ///
  /// 138 est le plancher, et il vient d'une mesure : la hauteur utile
  /// est de 98 px, et un libellé sur deux lignes en demande 99
  /// (44 d'icône + 40 de titre + 2 + 13 de sous-titre). « Défis &
  /// badges » tient sur une ligne, « Challenges & badges » et « Retos e
  /// insignias » non — la carte les coupait au milieu.
  ///
  /// ⚠️ Au-dessus, la hauteur suit la largeur. Sur un iPad, deux
  /// colonnes font 493 points de large : à 138 de haut, c'est une
  /// bande, pas une tuile. Le plafond évite l'excès inverse sur un
  /// écran encore plus large.
  ///
  /// ⚠️ Ce plafond était à 190, ce qui le rendait contraignant dès
  /// qu'on dépassait le téléphone. Il est passé à 260, mais **pas
  /// au-delà, et pour une raison qui se voit à l'écran** : essayé à
  /// 300 le 03/11/2026, la carte devenait un aplat de couleur de
  /// 493 × 300 avec une icône de 44 points perdue dans un coin. Le
  /// défaut n'était pas la hauteur, c'était que le **contenu** ne
  /// suivait pas la taille de la carte — voir [echellePour].
  static double hauteurPour(double largeur) =>
      (largeur * 0.62).clamp(138.0, 260.0);

  /// De combien agrandir le contenu d'une carte large.
  ///
  /// Une carte d'iPad fait presque trois fois la largeur d'une carte
  /// d'iPhone. Agrandir la boîte sans agrandir ce qu'elle contient ne
  /// donne pas une carte d'iPad, ça donne une carte de téléphone
  /// étirée, avec une icône minuscule dans un angle.
  ///
  /// **220 est le seuil, et il est mesuré, pas choisi.** La carte la
  /// plus large qu'un téléphone produise est celle d'un iPhone 18 Pro
  /// Max : 440 points d'écran, moins 32 de marges et 12 de gouttière,
  /// divisé par deux colonnes, soit **198**. Le seuil est posé
  /// au-dessus, donc le facteur vaut exactement 1 sur **tous** les
  /// téléphones et leur affichage ne bouge pas d'un pixel.
  ///
  /// ⚠️ Il valait 173 dans la première version, et c'était faux pour
  /// cette raison même : sur un 18 Pro Max le facteur montait à 1,14
  /// et l'icône grossissait de 14 % — pendant que le commentaire
  /// affirmait le contraire. Vu en comparant deux captures.
  ///
  /// Le plafond de 1,8 évite qu'un écran encore plus large produise
  /// une icône d'affiche. Un iPad 13″ en deux colonnes donne 493
  /// points de large, donc 2,24 : il est plafonné.
  static double echellePour(double largeur) => (largeur / 220).clamp(1.0, 1.8);

  /// Une carte large range son contenu **en ligne** plutôt qu'en colonne.
  ///
  /// Sur un téléphone la carte fait 165 × 138 : une icône au-dessus
  /// d'un titre remplit la boîte. Sur un iPad elle fait 492 × 251, et
  /// la même disposition laisse **86 points de vide** entre l'icône et
  /// le titre, mesurés à l'écran le 03/11/2026 — une bande claire au
  /// milieu de la carte.
  ///
  /// ⚠️ Le remède n'est pas de raccourcir la carte. Sa hauteur est ce
  /// qui fait que six cartes remplissent l'écran : à 202 de haut
  /// (trois colonnes), deux rangées laissent 350 points nus en
  /// dessous. C'est le **contenu** qui doit occuper la surface.
  ///
  /// Le seuil est celui de [echellePour], et pour la même raison : la
  /// carte la plus large qu'un téléphone produise fait 198 points.
  static bool enLignePour(double largeur) => largeur >= 220;

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
        child: LayoutBuilder(builder: (context, contraintes) {
          final largeur =
              contraintes.hasBoundedWidth ? contraintes.maxWidth : 170.0;
          final k = echellePour(largeur);
          return Container(
          height: scaledHeight(context, hauteurPour(largeur)),
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
                    size: 40 * k, color: bubbleColor.withValues(alpha: 0.15)),
              ),
              Positioned(
                bottom: 10,
                right: 12,
                child: Bubble(
                    size: 24 * k, color: bubbleColor.withValues(alpha: 0.12)),
              ),
              Positioned(
                top: 20,
                right: 30,
                child: Bubble(
                    size: 14 * k, color: bubbleColor.withValues(alpha: 0.10)),
              ),
              Padding(
                padding: EdgeInsets.all(16 * k),
                child: enLignePour(largeur)
                    // ⚠️ Le `Center` n'est pas décoratif : sans lui le
                    // `Row` prend la hauteur de son plus grand enfant
                    // et le `Stack` le colle en haut, laissant les deux
                    // tiers bas de la carte nus. Vu à l'écran le
                    // 03/11/2026, juste après avoir cru le problème
                    // réglé par le passage en ligne.
                    ? Center(
                        child: Row(
                          children: <Widget>[
                            _icone(k),
                            SizedBox(width: 16 * k),
                            Expanded(child: _texte(k)),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _icone(k),
                          // ⚠️ Le titre et le sous-titre forment **un
                          // seul** enfant flexible, collé en bas par le
                          // `spaceBetween` de la colonne.
                          //
                          // Avant, un `Spacer()` poussait le texte vers
                          // le bas. Mais un `Spacer` est un `Expanded`,
                          // donc il se partageait l'espace libre à parts
                          // égales avec le titre : celui-ci n'obtenait
                          // qu'une ligne, et « Challenges & badges »
                          // s'affichait « Challenges & ». Le français,
                          // qui tient sur une ligne, ne montrait rien du
                          // problème.
                          Flexible(child: _texte(k)),
                        ],
                      ),
              ),
            ],
          ),
        );
        }),
      ),
    );
  }

  /// La pastille ronde qui porte l'image du légume, ou son emoji.
  Widget _icone(double k) => Container(
        width: 44 * k,
        height: 44 * k,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
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
                    width: 44 * k,
                    height: 44 * k,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Text(emoji, style: TextStyle(fontSize: 22 * k))),
              )
            : Text(emoji, style: TextStyle(fontSize: 22 * k)),
      );

  /// Le titre et le sous-titre, dans cet ordre.
  Widget _texte(double k) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: KultivaColors.textPrimary.withValues(alpha: 0.9),
                fontWeight: FontWeight.w800,
                // Échelle adoucie de moitié : une icône peut doubler,
                // un titre qui doublerait crierait.
                fontSize: 15 * (1 + (k - 1) * 0.5),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 2 * k),
          Text(
            subtitle,
            style: TextStyle(
              color: KultivaColors.textPrimary.withValues(alpha: 0.55),
              fontWeight: FontWeight.w600,
              fontSize: 11 * (1 + (k - 1) * 0.5),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
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
