import 'package:flutter/material.dart';

import '../../../data/badges.dart';
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

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFB74D);
    return GestureDetector(
      onTap: () => showBadgeCard(
        context,
        badge: badge,
        unlocked: unlocked,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: unlocked ? gold.withOpacity(0.12) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: unlocked ? gold : Colors.grey.shade300,
            width: unlocked ? 2.5 : 1.5,
          ),
          boxShadow: unlocked
              ? <BoxShadow>[
                  BoxShadow(
                    color: gold.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
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
      ),
    );
  }
}
