import 'dart:io';

import 'package:flutter/material.dart';

import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../models/vegetable_medal.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/months.dart';
import '../../../widgets/medal_badge.dart';

/// Estimation du nombre de jours jusqu'à récolte (borne haute). Lit
/// [Vegetable.harvestTimeBySeason] si rempli, sinon défaut par famille.
///
/// Exposé comme helper public car utilisé par [PlantationCard] et par
/// la fiche détail [PlantationDetailSheet].
int expectedHarvestDays(Vegetable v, DateTime plantedAt) {
  final times = v.harvestTimeBySeason;
  if (times != null) {
    final m = plantedAt.month;
    final seasonKey = m >= 3 && m <= 5
        ? 'spring'
        : m >= 6 && m <= 8
            ? 'summer'
            : m >= 9 && m <= 11
                ? 'autumn'
                : 'winter';
    final raw = times[seasonKey] ?? times.values.firstOrNull;
    if (raw != null) {
      final matches = RegExp(r'\d+').allMatches(raw).toList();
      if (matches.isNotEmpty) {
        return int.tryParse(matches.last.group(0)!) ?? 70;
      }
    }
  }
  switch (v.category) {
    case VegetableCategory.leaves:
      return 55;
    case VegetableCategory.roots:
      return 70;
    case VegetableCategory.fruits:
      return 80;
    case VegetableCategory.bulbs:
      return 90;
    case VegetableCategory.tubers:
      return 100;
    case VegetableCategory.aromatics:
      return 45;
    case VegetableCategory.flowers:
      return 60;
    case VegetableCategory.seeds:
      return 90;
    case VegetableCategory.stems:
      return 70;
    case VegetableCategory.accessories:
      return 1;
  }
}

/// Carte d'une plantation dans la grille Poussidex.
class PlantationCard extends StatelessWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final MedalTier tier;
  const PlantationCard({
    super.key,
    required this.plantation,
    required this.vegetable,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final cc = vegetable.category.familyColor;
    final days = plantation.daysSincePlanted;
    final expected = expectedHarvestDays(vegetable, plantation.plantedAt);
    final progress = (days / expected).clamp(0.0, 1.0);
    final mature = progress >= 1.0;
    final thirsty = plantation.isActive &&
        plantation.daysSinceWatered >= vegetable.effectiveWateringDays;
    final watered = plantation.wateredAt.length;
    final harvested = plantation.harvestCount;
    final plantedLabel =
        '${plantation.plantedAt.day} ${monthNamesShort[plantation.plantedAt.month - 1]}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cc.withOpacity(0.7), width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cc.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  vegetable.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!plantation.isActive)
                const Text('🧺', style: TextStyle(fontSize: 14))
              else if (thirsty)
                const Text('💧', style: TextStyle(fontSize: 14))
              else if (mature)
                const Text('✨', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Center(
              child: plantation.photoPaths.isNotEmpty
                  ? _PhotoWithTier(
                      path: plantation.photoPaths.last,
                      tier: tier,
                      familyColor: cc,
                      fallbackEmoji: vegetable.emoji,
                    )
                  : MedalBadge(
                      emoji: vegetable.emoji,
                      tier: tier,
                      familyColor: cc,
                      size: 78,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                plantation.isActive
                    ? 'Jour ${days + 1}${mature ? " ★" : "/$expected"}'
                    : 'Récolté',
                style: TextStyle(
                  color: KultivaColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                plantedLabel,
                style: TextStyle(
                  color: KultivaColors.textSecondary.withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: plantation.isActive ? progress : 1.0,
              minHeight: 5,
              backgroundColor: cc.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(cc),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              _StatChip(icon: '💧', count: watered),
              const SizedBox(width: 6),
              _StatChip(icon: '🧺', count: harvested),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhotoWithTier extends StatelessWidget {
  final String path;
  final MedalTier tier;
  final Color familyColor;
  final String fallbackEmoji;

  const _PhotoWithTier({
    required this.path,
    required this.tier,
    required this.familyColor,
    required this.fallbackEmoji,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 82;
    final double radius = 12;
    final Color ring = tier == MedalTier.none ? familyColor : tier.color;
    final double ringWidth = tier == MedalTier.none
        ? 0
        : (tier == MedalTier.shiny ? 3 : 2.5);

    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => MedalBadge(
          emoji: fallbackEmoji,
          tier: tier,
          familyColor: familyColor,
          size: size,
        ),
      ),
    );

    Widget framed = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: tier == MedalTier.none
            ? null
            : Border.all(color: ring, width: ringWidth),
        boxShadow: tier == MedalTier.gold
            ? <BoxShadow>[
                BoxShadow(
                  color: ring.withOpacity(0.35),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : tier == MedalTier.shiny
                ? <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFFFF5CA8).withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : const <BoxShadow>[],
      ),
      child: Padding(
        padding: EdgeInsets.all(ringWidth),
        child: image,
      ),
    );

    if (tier == MedalTier.none) return framed;

    return SizedBox(
      width: size + 6,
      height: size + 6,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(child: Center(child: framed)),
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(tier.emoji, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final int count;
  const _StatChip({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            '×$count',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
