import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/months.dart';

/// Vue "Stats" du Poussidex : 4 tuiles de compteurs, taux de survie,
/// top familles, courbe d'arrosage 30 jours, repères temporels.
class PoussidexStatsView extends StatelessWidget {
  final List<Plantation> plantations;
  const PoussidexStatsView({super.key, required this.plantations});

  String _fmt(DateTime d) => '${d.day} ${monthNamesShort[d.month - 1]}';

  @override
  Widget build(BuildContext context) {
    if (plantations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '📊\n\nPas encore de statistiques — plante ton premier légume !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      );
    }

    final total = plantations.length;
    final active = plantations.where((p) => p.isActive).length;
    final totalWaterings =
        plantations.fold<int>(0, (sum, p) => sum + p.wateredAt.length);
    final totalHarvests =
        plantations.fold<int>(0, (sum, p) => sum + p.harvestCount);
    final totalPhotos =
        plantations.fold<int>(0, (sum, p) => sum + p.photoPaths.length);
    final survivalRate = total == 0 ? 0.0 : (active / total * 100);

    // Top familles.
    final families = <VegetableCategory, int>{};
    for (final p in plantations) {
      final v =
          vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
      if (v == null) continue;
      families[v.category] = (families[v.category] ?? 0) + 1;
    }
    final famSorted = families.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topFamilies = famSorted.take(3).toList();

    // Première / dernière plantation.
    final sorted = List<Plantation>.from(plantations)
      ..sort((a, b) => a.plantedAt.compareTo(b.plantedAt));
    final first = sorted.first;
    final last = sorted.last;

    // Arrosages par jour sur les 30 derniers jours.
    final now = DateTime.now();
    final buckets = List<int>.filled(30, 0);
    for (final p in plantations) {
      for (final w in p.wateredAt) {
        final delta = now.difference(w).inDays;
        if (delta >= 0 && delta < 30) {
          buckets[29 - delta]++;
        }
      }
    }
    final maxBucket = buckets.isEmpty
        ? 0
        : buckets.reduce((a, b) => a > b ? a : b);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 4 tuiles de compteurs.
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: <Widget>[
              _StatTile(
                emoji: '🪴',
                label: 'Plants collectés',
                value: '$total',
                color: KultivaColors.primaryGreen,
              ),
              _StatTile(
                emoji: '💧',
                label: 'Arrosages',
                value: '$totalWaterings',
                color: const Color(0xFF4FC3F7),
              ),
              _StatTile(
                emoji: '🧺',
                label: 'Récoltes',
                value: '$totalHarvests',
                color: KultivaColors.terracotta,
              ),
              _StatTile(
                emoji: '📷',
                label: 'Photos',
                value: '$totalPhotos',
                color: const Color(0xFFFFB74D),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SurvivalBar(active: active, total: total, rate: survivalRate),
          const SizedBox(height: 20),
          if (topFamilies.isNotEmpty) ...<Widget>[
            const Text('🎭  Top familles',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 10),
            for (final e in topFamilies)
              _FamilyBar(
                label: e.key.label,
                emoji: e.key.emoji,
                count: e.value,
                max: topFamilies.first.value,
                color: e.key.familyColor,
              ),
            const SizedBox(height: 20),
          ],
          const Text('💧  Arrosages — 30 derniers jours',
              style:
                  TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 10),
          _WateringChart(buckets: buckets, maxValue: maxBucket),
          const SizedBox(height: 20),
          const Text('📅  Repères',
              style:
                  TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 8),
          _RepereRow(
            icon: '🌱',
            label: 'Première plantation',
            value: _fmt(first.plantedAt),
          ),
          _RepereRow(
            icon: '🕒',
            label: 'Dernière plantation',
            value: _fmt(last.plantedAt),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color color;
  const _StatTile({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurvivalBar extends StatelessWidget {
  final int active;
  final int total;
  final double rate;
  const _SurvivalBar({
    required this.active,
    required this.total,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: KultivaColors.lightGreen, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('🌿', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Taux de plants en cours',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: KultivaColors.primaryGreen)),
              ),
              Text(
                '${rate.toStringAsFixed(0)}% ($active/$total)',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : active / total,
              minHeight: 8,
              backgroundColor: KultivaColors.lightGreen.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                  KultivaColors.primaryGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyBar extends StatelessWidget {
  final String label;
  final String emoji;
  final int count;
  final int max;
  final Color color;
  const _FamilyBar({
    required this.label,
    required this.emoji,
    required this.count,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = max == 0 ? 0.0 : count / max;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          SizedBox(
            width: 82,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 10,
                backgroundColor: color.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _WateringChart extends StatelessWidget {
  final List<int> buckets; // 30 valeurs, dernière = aujourd'hui
  final int maxValue;
  const _WateringChart({required this.buckets, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    if (maxValue == 0) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          "Aucun arrosage sur les 30 derniers jours.",
          style: TextStyle(
              color: KultivaColors.textSecondary, fontSize: 12),
        ),
      );
    }
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA).withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: const Color(0xFF4FC3F7).withOpacity(0.35), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < buckets.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 72 * (buckets[i] / maxValue).clamp(0.02, 1.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        const Color(0xFF29B6F6),
                        const Color(0xFF81D4FA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RepereRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _RepereRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 13)),
          ),
          Text(
            value,
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
