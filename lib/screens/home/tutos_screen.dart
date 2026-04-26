import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_theme.dart';
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
  final String url;
  final String? htmlAsset;
  const _TutoItem({
    required this.emoji,
    required this.label,
    this.url = '',
    this.htmlAsset,
  });
}

const _categories = <_TutoCategory>[
  _TutoCategory(
    emoji: '🎒',
    imagePath: 'assets/images/tuto_prise_en_main.png',
    label: 'Prise en main',
    color: Color(0xFFB565F2),
    items: [
      _TutoItem(emoji: '🏠', label: 'Découvrir le dashboard', htmlAsset: 'assets/tutos/decouvrir_dashboard.html'),
      _TutoItem(emoji: '🪴', label: 'Ton Tamassi', htmlAsset: 'assets/tutos/utiliser_poussidex.html'),
      _TutoItem(emoji: '📷', label: 'Les défis photo', htmlAsset: 'assets/tutos/ajouter_photos.html'),
      _TutoItem(emoji: '🏆', label: 'Débloquer les badges', htmlAsset: 'assets/tutos/debloquer_badges.html'),
    ],
  ),
  _TutoCategory(
    emoji: '💡',
    imagePath: 'assets/images/tuto_astuces.png',
    label: 'Astuces',
    color: Color(0xFFFFB74D),
    items: [
      _TutoItem(emoji: '🌙', label: 'Jardiner avec la lune', htmlAsset: 'assets/tutos/jardiner_avec_lune.html'),
      _TutoItem(emoji: '🐝', label: 'Attirer les pollinisateurs', htmlAsset: 'assets/tutos/attirer_pollinisateurs.html'),
      _TutoItem(emoji: '♻️', label: 'Réutiliser ses déchets', htmlAsset: 'assets/tutos/reutiliser_dechets.html'),
      _TutoItem(emoji: '⏰', label: 'Gain de temps au jardin', htmlAsset: 'assets/tutos/gain_temps_jardin.html'),
    ],
  ),
  _TutoCategory(
    emoji: '🌱',
    imagePath: 'assets/images/tuto_semis.png',
    label: 'Semis',
    color: Color(0xFF4A9B5A),
    items: [
      _TutoItem(emoji: '🌱', label: 'Réussir ses semis', htmlAsset: 'assets/tutos/reussir_semis.html'),
      _TutoItem(emoji: '🏠', label: 'Semis en intérieur', htmlAsset: 'assets/tutos/semis_interieur.html'),
      _TutoItem(emoji: '📅', label: 'Quand semer ?', htmlAsset: 'assets/tutos/quand_semer.html'),
      _TutoItem(emoji: '🌡️', label: 'Température de germination', htmlAsset: 'assets/tutos/temperature_germination.html'),
    ],
  ),
  _TutoCategory(
    emoji: '💧',
    imagePath: 'assets/images/tuto_arrosage.png',
    label: 'Arrosage',
    color: Color(0xFF4A90D9),
    items: [
      _TutoItem(emoji: '💧', label: 'Bien arroser', htmlAsset: 'assets/tutos/bien_arroser.html'),
      _TutoItem(emoji: '🕐', label: 'Quand arroser ?', htmlAsset: 'assets/tutos/quand_arroser.html'),
      _TutoItem(emoji: '💦', label: 'Arrosage goutte à goutte', htmlAsset: 'assets/tutos/goutte_a_goutte.html'),
      _TutoItem(emoji: '🌧️', label: 'Récupérer l\'eau de pluie', htmlAsset: 'assets/tutos/eau_de_pluie.html'),
    ],
  ),
  _TutoCategory(
    emoji: '🧺',
    imagePath: 'assets/images/tuto_recolte.png',
    label: 'Récolte',
    color: Color(0xFFE8A87C),
    items: [
      _TutoItem(emoji: '🍅', label: 'Quand récolter ?', htmlAsset: 'assets/tutos/quand_recolter.html'),
      _TutoItem(emoji: '🥫', label: 'Conserver ses légumes', htmlAsset: 'assets/tutos/conserver_legumes.html'),
      _TutoItem(emoji: '🌿', label: 'Récolter les aromatiques', htmlAsset: 'assets/tutos/recolter_aromatiques.html'),
      _TutoItem(emoji: '🥕', label: 'Récolter les racines', htmlAsset: 'assets/tutos/recolter_racines.html'),
    ],
  ),
  _TutoCategory(
    emoji: '🌍',
    imagePath: 'assets/images/tuto_sol.png',
    label: 'Sol & Compost',
    color: Color(0xFF8B6914),
    items: [
      _TutoItem(emoji: '🪱', label: 'Faire son compost', htmlAsset: 'assets/tutos/faire_compost.html'),
      _TutoItem(emoji: '🌍', label: 'Préparer le sol', htmlAsset: 'assets/tutos/preparer_sol.html'),
      _TutoItem(emoji: '🧪', label: 'Engrais naturels', htmlAsset: 'assets/tutos/engrais_naturels.html'),
      _TutoItem(emoji: '🍂', label: 'Paillage', htmlAsset: 'assets/tutos/paillage.html'),
    ],
  ),
  _TutoCategory(
    emoji: '🐛',
    imagePath: 'assets/images/tuto_maladies.png',
    label: 'Maladies & Nuisibles',
    color: Color(0xFFCC4444),
    items: [
      _TutoItem(emoji: '🐌', label: 'Lutter contre les limaces', htmlAsset: 'assets/tutos/lutter_limaces.html'),
      _TutoItem(emoji: '🍄', label: 'Mildiou', htmlAsset: 'assets/tutos/mildiou.html'),
      _TutoItem(emoji: '🐛', label: 'Pucerons', htmlAsset: 'assets/tutos/pucerons.html'),
      _TutoItem(emoji: '🌿', label: 'Traitements bio', htmlAsset: 'assets/tutos/traitements_bio.html'),
    ],
  ),
  _TutoCategory(
    emoji: '🏡',
    imagePath: 'assets/images/tuto_amenagement.png',
    label: 'Aménagement',
    color: Color(0xFF7BAFD4),
    items: [
      _TutoItem(emoji: '📦', label: 'Potager surélevé', htmlAsset: 'assets/tutos/potager_sureleve.html'),
      _TutoItem(emoji: '🏡', label: 'Potager en carrés', htmlAsset: 'assets/tutos/potager_carres.html'),
      _TutoItem(emoji: '🌻', label: 'Associations de plantes', htmlAsset: 'assets/tutos/associations_plantes.html'),
      _TutoItem(emoji: '🪴', label: 'Potager en balcon', htmlAsset: 'assets/tutos/potager_balcon.html'),
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
              height: 170,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Illustration header (fallback dégradé pastel si absente).
                  Image.asset(
                    'assets/images/tutos.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFFFE0B2),
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
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🎓 Tutos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            shadows: const [
                              Shadow(color: Colors.black45, blurRadius: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Apprends à jardiner en vidéo',
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
                      width: 32, height: 32, fit: BoxFit.cover,
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
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: cat.items.length,
                itemBuilder: (ctx, i) {
                  final item = cat.items[i];
                  return _TutoTile(item: item, color: cat.color);
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
  const _TutoTile({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        } else if (item.url.isNotEmpty) {
          launchUrl(Uri.parse(item.url),
              mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bientôt disponible !')),
          );
        }
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.25),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
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
                      style: TextStyle(
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
    );
  }
}

/// Animation d'ampoules, étoiles et cœurs flottants pour l'onglet Tutos —
/// évoque l'apprentissage et l'inspiration plutôt que les saisons.
class _TutoParticleAnimation extends StatefulWidget {
  const _TutoParticleAnimation();
  @override
  State<_TutoParticleAnimation> createState() =>
      _TutoParticleAnimationState();
}

class _TutoParticleAnimationState extends State<_TutoParticleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  static const _emojis = <String>[
    '💡', '✨', '📚', '⭐', '💖', '🌱', '🎓', '✨',
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
