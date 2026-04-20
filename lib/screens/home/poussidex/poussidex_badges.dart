import 'package:flutter/material.dart';

import '../../../data/badges.dart';
import '../../../models/vegetable_medal.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/badge_card.dart';

/// Grille des 25 badges Poussidex. Un tap sur un badge ouvre la carte
/// "Pokémon" correspondante (via showBadgeCard).
class PoussidexBadgesGrid extends StatelessWidget {
  final Set<String> unlocked;
  const PoussidexBadgesGrid({super.key, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 170,
        childAspectRatio: 0.95,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: allBadges.length,
      itemBuilder: (context, i) {
        final b = allBadges[i];
        final isUnlocked = unlocked.contains(b.id);
        return _BadgeTile(badge: b, unlocked: isUnlocked);
      },
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final PoussidexBadge badge;
  final bool unlocked;
  const _BadgeTile({required this.badge, required this.unlocked});

  /// Couleur de référence du palier. Les verrouillés utilisent la même
  /// teinte mais en version désaturée pour qu'on voie "de quoi ça aura
  /// l'air" sans tout dévoiler.
  Color get _tierBaseColor {
    switch (badge.tier) {
      case MedalTier.bronze:
        return const Color(0xFFCD7F32);
      case MedalTier.silver:
        return const Color(0xFF9AA4B0);
      case MedalTier.gold:
        return const Color(0xFFFFB74D);
      case MedalTier.shiny:
        return const Color(0xFFFF5CA8);
      case MedalTier.none:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = _tierBaseColor;
    final c = unlocked
        ? base
        : (Color.lerp(base, Colors.grey.shade400, 0.55) ?? base);
    return GestureDetector(
      onTap: unlocked
          ? () => showBadgeCard(
                context,
                badge: badge,
                unlocked: unlocked,
              )
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: c.withOpacity(unlocked ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: c,
            width: unlocked ? 2.5 : 1.5,
          ),
          boxShadow: unlocked
              ? <BoxShadow>[
                  BoxShadow(
                    color: base.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 4),
                Opacity(
                  opacity: unlocked ? 1.0 : 0.3,
                  child: Text(
                    badge.emoji,
                    style: const TextStyle(fontSize: 44),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  badge.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: unlocked ? null : Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    badge.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: unlocked
                          ? KultivaColors.textSecondary
                          : Colors.grey.shade400,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!unlocked)
                  Icon(Icons.lock_outline,
                      size: 14, color: Colors.grey.shade400),
              ],
            ),
            // Pastille médaille dans le coin haut-droit (badges
            // débloqués seulement, pour signaler visuellement la rareté).
            if (unlocked)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: c, width: 1.5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: c.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badge.tier.emoji,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
