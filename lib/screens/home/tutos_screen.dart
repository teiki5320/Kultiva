import 'package:flutter/material.dart';

import '../../data/ui_i18n.dart';
import '../../theme/app_theme.dart';
import '../../widgets/season_header.dart' show kPageHeaderHeight;
import '../../utils/text_scale.dart';
import 'tuto_fiche_screen.dart';

/// Catégorie de tuto avec ses vidéos.
class _TutoCategory {
  final String emoji;
  final String imagePath;
  final String label;
  final Color color;
  final List<_TutoItem> items;
  const _TutoCategory({
    required this.emoji,
    required this.imagePath,
    required this.label,
    required this.color,
    required this.items,
  });
}

class _TutoItem {
  final String emoji;
  final String label;
  final String? htmlAsset;
  const _TutoItem({
    required this.emoji,
    required this.label,
    this.htmlAsset,
  });
}

List<_TutoCategory> get _categories => <_TutoCategory>[
      _TutoCategory(
        emoji: '🎒',
        imagePath: 'assets/images/tuto_prise_en_main.png',
        label: trUi('Prise en main'),
        color: const Color(0xFFB565F2),
        items: [
          _TutoItem(
              emoji: '🏠',
              label: trUi("Découvrir l'application"),
              htmlAsset: 'assets/tutos/decouvrir_dashboard.html'),
        ],
      ),
      _TutoCategory(
        emoji: '💡',
        imagePath: 'assets/images/tuto_astuces.png',
        label: trUi('Astuces'),
        color: const Color(0xFFFFB74D),
        items: [
          _TutoItem(
              emoji: '🌙',
              label: trUi('Jardiner avec la lune'),
              htmlAsset: 'assets/tutos/jardiner_avec_lune.html'),
          _TutoItem(
              emoji: '🐝',
              label: trUi('Attirer les pollinisateurs'),
              htmlAsset: 'assets/tutos/attirer_pollinisateurs.html'),
          _TutoItem(
              emoji: '♻️',
              label: trUi('Réutiliser ses déchets'),
              htmlAsset: 'assets/tutos/reutiliser_dechets.html'),
          _TutoItem(
              emoji: '⏰',
              label: trUi('Gain de temps au jardin'),
              htmlAsset: 'assets/tutos/gain_temps_jardin.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🌱',
        imagePath: 'assets/images/tuto_semis.png',
        label: trUi('Semis'),
        color: const Color(0xFF4A9B5A),
        items: [
          _TutoItem(
              emoji: '🌱',
              label: trUi('Réussir ses semis'),
              htmlAsset: 'assets/tutos/reussir_semis.html'),
          _TutoItem(
              emoji: '🏠',
              label: trUi('Semis en intérieur'),
              htmlAsset: 'assets/tutos/semis_interieur.html'),
          _TutoItem(
              emoji: '📅',
              label: trUi('Quand semer ?'),
              htmlAsset: 'assets/tutos/quand_semer.html'),
          _TutoItem(
              emoji: '🌡️',
              label: trUi('Température de germination'),
              htmlAsset: 'assets/tutos/temperature_germination.html'),
        ],
      ),
      _TutoCategory(
        emoji: '💧',
        imagePath: 'assets/images/tuto_arrosage.png',
        label: trUi('Arrosage'),
        color: const Color(0xFF4A90D9),
        items: [
          _TutoItem(
              emoji: '💧',
              label: trUi('Bien arroser'),
              htmlAsset: 'assets/tutos/bien_arroser.html'),
          _TutoItem(
              emoji: '🕐',
              label: trUi('Quand arroser ?'),
              htmlAsset: 'assets/tutos/quand_arroser.html'),
          _TutoItem(
              emoji: '💦',
              label: trUi('Arrosage goutte à goutte'),
              htmlAsset: 'assets/tutos/goutte_a_goutte.html'),
          _TutoItem(
              emoji: '🌧️',
              label: trUi('Récupérer l\'eau de pluie'),
              htmlAsset: 'assets/tutos/eau_de_pluie.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🧺',
        imagePath: 'assets/images/tuto_recolte.png',
        label: trUi('Récolte'),
        color: const Color(0xFFE8A87C),
        items: [
          _TutoItem(
              emoji: '🍅',
              label: trUi('Quand récolter ?'),
              htmlAsset: 'assets/tutos/quand_recolter.html'),
          _TutoItem(
              emoji: '🥫',
              label: trUi('Conserver ses légumes'),
              htmlAsset: 'assets/tutos/conserver_legumes.html'),
          _TutoItem(
              emoji: '🌿',
              label: trUi('Récolter les aromatiques'),
              htmlAsset: 'assets/tutos/recolter_aromatiques.html'),
          _TutoItem(
              emoji: '🥕',
              label: trUi('Récolter les racines'),
              htmlAsset: 'assets/tutos/recolter_racines.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🌍',
        imagePath: 'assets/images/tuto_sol.png',
        label: trUi('Sol & Compost'),
        color: const Color(0xFF8B6914),
        items: [
          _TutoItem(
              emoji: '🪱',
              label: trUi('Faire son compost'),
              htmlAsset: 'assets/tutos/faire_compost.html'),
          _TutoItem(
              emoji: '🌍',
              label: trUi('Préparer le sol'),
              htmlAsset: 'assets/tutos/preparer_sol.html'),
          _TutoItem(
              emoji: '🧪',
              label: trUi('Engrais naturels'),
              htmlAsset: 'assets/tutos/engrais_naturels.html'),
          _TutoItem(
              emoji: '🍂',
              label: trUi('Paillage'),
              htmlAsset: 'assets/tutos/paillage.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🐛',
        imagePath: 'assets/images/tuto_maladies.png',
        label: trUi('Maladies & Nuisibles'),
        color: const Color(0xFFCC4444),
        items: [
          _TutoItem(
              emoji: '🐌',
              label: trUi('Lutter contre les limaces'),
              htmlAsset: 'assets/tutos/lutter_limaces.html'),
          _TutoItem(
              emoji: '🍄',
              label: trUi('Mildiou'),
              htmlAsset: 'assets/tutos/mildiou.html'),
          _TutoItem(
              emoji: '🐛',
              label: trUi('Pucerons'),
              htmlAsset: 'assets/tutos/pucerons.html'),
          _TutoItem(
              emoji: '🌿',
              label: trUi('Traitements bio'),
              htmlAsset: 'assets/tutos/traitements_bio.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🏡',
        imagePath: 'assets/images/tuto_amenagement.png',
        label: trUi('Aménagement'),
        color: const Color(0xFF7BAFD4),
        items: [
          _TutoItem(
              emoji: '📦',
              label: trUi('Potager surélevé'),
              htmlAsset: 'assets/tutos/potager_sureleve.html'),
          _TutoItem(
              emoji: '🏡',
              label: trUi('Potager en carrés'),
              htmlAsset: 'assets/tutos/potager_carres.html'),
          _TutoItem(
              emoji: '🌻',
              label: trUi('Associations de plantes'),
              htmlAsset: 'assets/tutos/associations_plantes.html'),
          _TutoItem(
              emoji: '🪴',
              label: trUi('Potager en balcon'),
              htmlAsset: 'assets/tutos/potager_balcon.html'),
        ],
      ),
      _TutoCategory(
        emoji: '🌴',
        imagePath: 'assets/images/tuto_climat_tropical.png',
        label: trUi('Climat tropical'),
        color: const Color(0xFF26A69A),
        items: [
          _TutoItem(
              emoji: '☀️',
              label: trUi('Jardiner en saison sèche'),
              htmlAsset: 'assets/tutos/jardiner_saison_seche.html'),
          _TutoItem(
              emoji: '🌧️',
              label: trUi("Préparer l'hivernage"),
              htmlAsset: 'assets/tutos/preparer_hivernage.html'),
          _TutoItem(
              emoji: '⛱️',
              label: trUi('Fabriquer une ombrière'),
              htmlAsset: 'assets/tutos/fabriquer_ombriere.html'),
          _TutoItem(
              emoji: '🍠',
              label: trUi("Cultiver l'igname"),
              htmlAsset: 'assets/tutos/cultiver_igname.html'),
        ],
      ),
    ];

class TutosScreen extends StatelessWidget {
  const TutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header.
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            child: SizedBox(
              height: kPageHeaderHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Illustration header (fallback dégradé pastel si absente).
                  Image.asset(
                    'assets/images/tutos.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFE0B2),
                            KultivaColors.springB,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Voile noir en bas pour lisibilité du titre.
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.0),
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
                    ),
                  ),
                  const _TutoParticleAnimation(),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trUi('🎓 Tutos'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          trUi('Apprends à jardiner, fiche par fiche'),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            shadows: const [
                              Shadow(color: Colors.black38, blurRadius: 6),
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
          const SizedBox(height: 16),
          // Catégories.
          for (final cat in _categories) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      cat.imagePath,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Text(cat.emoji, style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    cat.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (cat.items.length == 1)
              // Catégorie à un seul tuto → carte large pleine largeur.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TutoTile(
                  item: cat.items.first,
                  color: cat.color,
                  wide: true,
                ),
              )
            else
              SizedBox(
                height: scaledHeight(context, 100),
                // ⚠️ Sur un téléphone, les tuiles défilent latéralement :
                // quatre tuiles de 98 points ne tiennent pas dans 375.
                // Sur un iPad elles tiennent largement, et la liste les
                // laissait alignées à gauche avec la moitié de l'écran
                // vide à droite — ce que Jean a vu le 03/11/2026. Quand
                // la place y est, on étale plutôt que de défiler.
                child: LayoutBuilder(
                  builder: (ctx, contraintes) {
                    const largeurTuile = 98.0;
                    final tiennent = cat.items.length * largeurTuile <=
                        contraintes.maxWidth - 24;
                    if (tiennent) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: <Widget>[
                            for (final item in cat.items)
                              Expanded(
                                child: _TutoTile(
                                    item: item,
                                    color: cat.color,
                                    etire: true),
                              ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: cat.items.length,
                      itemBuilder: (ctx, i) {
                        final item = cat.items[i];
                        return _TutoTile(item: item, color: cat.color);
                      },
                    );
                  },
                ),
              ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TutoTile extends StatelessWidget {
  final _TutoItem item;
  final Color color;

  /// Mode "carte large" : utilisée pour les catégories à 1 seul tuto
  /// (ex. Prise en main) pour éviter une mini-tile perdue toute seule
  /// dans l'écran. Elle prend toute la largeur, affiche un plus gros
  /// emoji et un libellé plus lisible.
  final bool wide;

  /// Vrai quand la tuile est posée dans un `Expanded` : elle laisse
  /// alors son parent décider de sa largeur, au lieu de la fixer à 90.
  final bool etire;

  const _TutoTile({
    required this.item,
    required this.color,
    this.wide = false,
    this.etire = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.label,
      hint: item.htmlAsset != null ? trUi('Ouvre la fiche') : null,
      button: item.htmlAsset != null,
      child: GestureDetector(
        onTap: () {
          if (item.htmlAsset != null) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => TutoFicheScreen(
                  titre: item.label,
                  assetPath: item.htmlAsset!,
                ),
              ),
            );
          }
        },
        child: Container(
          width: wide ? double.infinity : (etire ? null : 90),
          margin: wide
              ? const EdgeInsets.symmetric(vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 4),
          padding: wide
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.12),
                color.withValues(alpha: 0.25),
              ],
            ),
            borderRadius: BorderRadius.circular(wide ? 22 : 18),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: wide
              ? Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(item.emoji,
                          style: const TextStyle(fontSize: 32)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.label,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: KultivaColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            trUi(
                                'Le tour complet — Home, Cahier, Étal, Conservation, Tutos'),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: KultivaColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: color, size: 28),
                  ],
                )
              : Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(item.emoji,
                                style: const TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              item.label,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: KultivaColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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

/// Animation d'ampoules, étoiles et cœurs flottants pour l'onglet Tutos —
/// évoque l'apprentissage et l'inspiration plutôt que les saisons.
class _TutoParticleAnimation extends StatefulWidget {
  const _TutoParticleAnimation();
  @override
  State<_TutoParticleAnimation> createState() => _TutoParticleAnimationState();
}

class _TutoParticleAnimationState extends State<_TutoParticleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  static const _emojis = <String>[
    '💡',
    '✨',
    '📚',
    '⭐',
    '💖',
    '🌱',
    '🎓',
    '✨',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final width = MediaQuery.of(context).size.width;
        return Stack(
          children: List.generate(_emojis.length, (i) {
            // Flottement ascendant : les particules montent lentement
            // avec un léger décalage horizontal en ondulation.
            final t = (_ctrl.value + i * (1 / _emojis.length)) % 1.0;
            final baseX = (i * 0.17 + 0.05) % 1.0;
            final wave = 0.04 *
                (1 - (2 * ((t + i * 0.1) % 1.0) - 1).abs()); // petite sinus
            final x = ((baseX + wave) % 1.0) * width * 0.9;
            final y = 170 - t * 180; // monte depuis le bas
            return Positioned(
              left: x,
              top: y,
              child: Opacity(
                // Fade-in au départ, fade-out à la fin du trajet.
                opacity: (t < 0.15
                        ? t / 0.15
                        : t > 0.85
                            ? (1 - t) / 0.15
                            : 1.0)
                    .clamp(0.0, 0.7),
                child: Text(
                  _emojis[i],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
