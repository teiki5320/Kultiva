import 'package:flutter/material.dart';

import '../../../services/audio_service.dart';
import '../../../theme/app_theme.dart';

/// Filtre actif dans le Poussidex.
enum AlbumFilter { tamassi, challenges, badges }

class GardenHeader extends StatelessWidget {
  final int plantationsCount;
  final int speciesCount;
  final int totalSpecies;
  final int unlockedCount;
  final int totalBadges;
  const GardenHeader({
    super.key,
    required this.plantationsCount,
    required this.speciesCount,
    required this.totalSpecies,
    required this.unlockedCount,
    required this.totalBadges,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: SizedBox(
        height: 170,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/potager.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      KultivaColors.springA,
                      KultivaColors.springB,
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withValues(alpha: 0),
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '🪴 Mon Poussidex',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      shadows: <Shadow>[
                        Shadow(color: Colors.black45, blurRadius: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '🏅 $speciesCount / $totalSpecies espèces  ·  🏆 $unlockedCount / $totalBadges badges',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      shadows: const <Shadow>[
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
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Barre de filtres (Tout / En cours / Récoltés / Badges)
// ═══════════════════════════════════════════════════════════════════════════

class GardenFilterBar extends StatelessWidget {
  final AlbumFilter filter;
  final int challengesCount;
  final int badgesCount;
  final int totalBadges;
  final ValueChanged<AlbumFilter> onChanged;

  const GardenFilterBar({
    super.key,
    required this.filter,
    required this.challengesCount,
    required this.badgesCount,
    required this.totalBadges,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GardenFilterChip(
            label: '🌱 Tamassi',
            count: 0,
            hideCount: true,
            selected: filter == AlbumFilter.tamassi,
            color: KultivaColors.primaryGreen,
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(AlbumFilter.tamassi);
            },
          ),
          GardenFilterChip(
            label: '📸 Défis',
            count: 0,
            hideCount: true,
            selected: filter == AlbumFilter.challenges,
            color: KultivaColors.challengePink,
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(AlbumFilter.challenges);
            },
          ),
          GardenFilterChip(
            label: '🏆 Badges',
            count: badgesCount,
            total: totalBadges,
            selected: filter == AlbumFilter.badges,
            color: KultivaColors.badgeGold,
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(AlbumFilter.badges);
            },
          ),
        ],
      ),
    );
  }
}

class GardenFilterChip extends StatelessWidget {
  final String label;
  final int count;
  final int? total;
  final bool hideCount;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const GardenFilterChip({
    super.key,
    required this.label,
    required this.count,
    this.total,
    this.hideCount = false,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final suffix =
        hideCount ? '' : (total != null ? ' $count/$total' : ' ($count)');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.2) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color,
              width: selected ? 2.5 : 2,
            ),
          ),
          child: Text(
            '$label$suffix',
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
