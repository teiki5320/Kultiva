/// L'en-tête d'une fiche légume : la carte de présentation, les deux pastilles d'action et les noms locaux.
///
/// ⚠️ Ces widgets vivaient dans
/// `vegetable_detail_screen.dart`, qui portait 18 classes sur
/// 1 357 lignes. Même découpage que le potager carré : un fichier par
/// sujet, et l'écran ne garde que lui-même.
library;

import '../../data/content_i18n.dart';
import '../../data/names_en.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/audio_service.dart';
import '../../data/local_names.dart';
import '../../data/ui_i18n.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lexicon_text.dart';
import '../../widgets/medal_badge.dart';

class HeaderCard extends StatelessWidget {
  final Vegetable vegetable;
  const HeaderCard({super.key, required this.vegetable});

  MedalTier _loadTier() {
    final plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    return computeMedalTier(vegetable.id, plantations,
        region: PrefsService.instance.region.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.plantationsVersion,
      builder: (_, __, ___) {
        final tier = _loadTier();
        return _buildCard(context, tier);
      },
    );
  }

  Widget _buildCard(BuildContext context, MedalTier tier) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              vegetable.displayName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              vegetable.category.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            if (tier != MedalTier.none) ...<Widget>[
              const SizedBox(height: 6),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: tier.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: tier.color, width: 1.2),
                  ),
                  child: Text(
                    '${tier.emoji}  ${tier.label}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: tier.color,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final badge = MedalBadge(
                  emoji: vegetable.emoji,
                  imageAsset: vegetable.imageAsset,
                  tier: tier,
                  familyColor: KultivaColors.primaryGreen,
                  size: 78,
                  showCornerMedal: tier != MedalTier.none,
                );
                // Le panier du bandeau est réservé aux accessoires : les
                // autres fiches ont le grand bouton en bas, et afficher
                // les deux faisait doublon.
                // ⚠️ Deuxième porte, oubliée le 02/11 quand la
                // première a été corrigée : le panier des accessoires
                // testait encore la région, donc s'affichait dans les
                // 36 pays de la base tempérée. Une règle à deux
                // endroits se corrige à deux endroits.
                final url =
                    vegetable.category == VegetableCategory.accessories &&
                            amazonLinkVisible(
                                PrefsService.instance.region.value,
                                PrefsService.instance.country.value)
                        ? amazonUrlFor(vegetable)
                        : null;
                // Sans panier, la pastille est centrée. Un `Row` à deux
                // extrémités dont un seul enfant la plaquait à gauche,
                // avec le vide à sa droite — invisible sur téléphone,
                // béant sur un iPad.
                if (url == null) return Center(child: badge);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    badge,
                    MiniActionBlock(
                      emoji: '🛒',
                      label: trUi('Acheter'),
                      sublabel: trUi('Lien partenaire'),
                      gradientColors: <Color>[
                        KultivaColors.terracotta.withValues(alpha: 0.28),
                        KultivaColors.summerA.withValues(alpha: 0.4),
                      ],
                      foreground: KultivaColors.terracotta,
                      tooltip: trUi('Lien partenaire Amazon — Kultiva touche '
                          'une petite commission si tu achètes.'),
                      onTap: () {
                        AudioService.instance.play(Sfx.cart);
                        launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            if (vegetable.displayDescription != null) ...<Widget>[
              const SizedBox(height: 16),
              LexiconText(
                vegetable.displayDescription!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MiniActionBlock extends StatelessWidget {
  final String emoji;
  final String label;
  final String sublabel;
  final List<Color> gradientColors;
  final Color foreground;
  final String tooltip;
  final VoidCallback onTap;

  const MiniActionBlock({
    super.key,
    required this.emoji,
    required this.label,
    required this.sublabel,
    required this.gradientColors,
    required this.foreground,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        label: '$label, $sublabel',
        hint: tooltip,
        button: true,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: foreground.withValues(alpha: 0.22),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: foreground,
                  ),
                ),
                Text(
                  sublabel,
                  style: TextStyle(
                    fontSize: 7.5,
                    fontWeight: FontWeight.w500,
                    color: foreground.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Noms locaux de la culture (wolof, bambara, haoussa…), affichés en
/// Afrique de l'Ouest pour que le jardinier reconnaisse son légume.

/// Noms locaux de la culture (wolof, bambara, haoussa…), affichés en
/// Afrique de l'Ouest pour que le jardinier reconnaisse son légume.
class LocalNamesCard extends StatelessWidget {
  final List<LocalName> names;
  const LocalNamesCard({super.key, required this.names});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KultivaColors.lightGreen.withValues(alpha: 0.18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              trUi('🗣️  Noms locaux'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final n in names)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: KultivaColors.lightGreen,
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: '${n.name}  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: n.language,
                          style: const TextStyle(
                            fontSize: 11,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ]),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Estimation maraîchage (rendement + valeur marché en FCFA), affichée
/// en Afrique de l'Ouest pour les jardiniers qui cultivent pour vendre.
