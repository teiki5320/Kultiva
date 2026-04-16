import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';

/// Vue "Podium" : 4 podiums top 3 sur différentes métriques.
/// Chaque podium montre les 3 espèces/plants les mieux classés avec
/// un visuel de podium doré/argenté/bronze.
class PoussidexPodiumView extends StatelessWidget {
  final List<Plantation> plantations;
  const PoussidexPodiumView({super.key, required this.plantations});

  @override
  Widget build(BuildContext context) {
    if (plantations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '🏅\n\nPas encore de podium — plante ton premier légume pour lancer la compétition !',
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

    // Agrégats par espèce.
    final bySpecies = <String, _SpeciesStats>{};
    for (final p in plantations) {
      final s = bySpecies.putIfAbsent(
        p.vegetableId,
        () => _SpeciesStats(vegetableId: p.vegetableId),
      );
      s.plantingCount++;
      s.totalHarvests += p.harvestCount;
      s.totalWaterings += p.wateredAt.length;
      s.totalPhotos += p.photoPaths.length;
      final age = DateTime.now().difference(p.plantedAt).inDays;
      if (age > s.oldestDays) s.oldestDays = age;
    }

    final list = bySpecies.values.toList();

    List<_SpeciesStats> topBy(int Function(_SpeciesStats) metric) {
      final sorted = List<_SpeciesStats>.from(list)
        ..sort((a, b) => metric(b).compareTo(metric(a)));
      return sorted.take(3).where((s) => metric(s) > 0).toList();
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
      children: <Widget>[
        _PodiumSection(
          title: '🧺 Les plus récoltés',
          entries: topBy((s) => s.totalHarvests),
          unit: 'récoltes',
          valueOf: (s) => s.totalHarvests,
        ),
        const SizedBox(height: 16),
        _PodiumSection(
          title: '⏳ Les plus anciens',
          entries: topBy((s) => s.oldestDays),
          unit: 'jours',
          valueOf: (s) => s.oldestDays,
        ),
        const SizedBox(height: 16),
        _PodiumSection(
          title: '💧 Les plus arrosés',
          entries: topBy((s) => s.totalWaterings),
          unit: 'arrosages',
          valueOf: (s) => s.totalWaterings,
        ),
        const SizedBox(height: 16),
        _PodiumSection(
          title: '📷 Les plus photographiés',
          entries: topBy((s) => s.totalPhotos),
          unit: 'photos',
          valueOf: (s) => s.totalPhotos,
        ),
      ],
    );
  }
}

/// Stats agrégées par espèce pour le podium.
class _SpeciesStats {
  final String vegetableId;
  int plantingCount = 0;
  int totalHarvests = 0;
  int totalWaterings = 0;
  int totalPhotos = 0;
  int oldestDays = 0;
  _SpeciesStats({required this.vegetableId});
}

/// Une section podium avec un titre + les 3 marches.
class _PodiumSection extends StatelessWidget {
  final String title;
  final List<_SpeciesStats> entries;
  final String unit;
  final int Function(_SpeciesStats) valueOf;

  const _PodiumSection({
    required this.title,
    required this.entries,
    required this.unit,
    required this.valueOf,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 14)),
            const Spacer(),
            Text(
              '—',
              style: TextStyle(
                color: KultivaColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    // On attribue la 1ère, 2ème, 3ème place aux index 0, 1, 2.
    final first = entries.isNotEmpty ? entries[0] : null;
    final second = entries.length > 1 ? entries[1] : null;
    final third = entries.length > 2 ? entries[2] : null;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          // Marche du podium — 2ème à gauche, 1ère au centre, 3ème à droite.
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: second == null
                      ? const SizedBox()
                      : _PodiumStep(
                          rank: 2,
                          stats: second,
                          unit: unit,
                          value: valueOf(second),
                        ),
                ),
                Expanded(
                  child: first == null
                      ? const SizedBox()
                      : _PodiumStep(
                          rank: 1,
                          stats: first,
                          unit: unit,
                          value: valueOf(first),
                        ),
                ),
                Expanded(
                  child: third == null
                      ? const SizedBox()
                      : _PodiumStep(
                          rank: 3,
                          stats: third,
                          unit: unit,
                          value: valueOf(third),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Une marche du podium : emoji légume au sommet, couronne pour le 1er,
/// médaille pour les autres, socle coloré avec hauteur selon le rang.
class _PodiumStep extends StatelessWidget {
  final int rank; // 1, 2 ou 3
  final _SpeciesStats stats;
  final String unit;
  final int value;

  const _PodiumStep({
    required this.rank,
    required this.stats,
    required this.unit,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final veg = vegetablesBase
        .where((v) => v.id == stats.vegetableId)
        .firstOrNull;
    if (veg == null) return const SizedBox();

    // Hauteur du socle selon le rang.
    final stepHeight = rank == 1 ? 90.0 : (rank == 2 ? 65.0 : 45.0);
    // Couleur du socle selon le rang.
    final stepColor = _rankColor(rank);
    final medalEmoji = rank == 1 ? '🥇' : (rank == 2 ? '🥈' : '🥉');

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Couronne pour le 1er.
        if (rank == 1)
          const Text('👑', style: TextStyle(fontSize: 20)),
        // Emoji du légume dans un cercle coloré.
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: veg.category.familyColor.withOpacity(0.18),
            border: Border.all(color: stepColor, width: 2.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: stepColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(veg.emoji, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 3),
        // Valeur (ex : 12 récoltes).
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            color: stepColor,
          ),
        ),
        // Socle avec rang + nom.
        Container(
          width: double.infinity,
          height: stepHeight,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                stepColor,
                stepColor.withOpacity(0.8),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            border: Border.all(color: stepColor.withOpacity(0.8)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(medalEmoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 2),
              Text(
                veg.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFE8B923); // or
      case 2:
        return const Color(0xFF9AA4B0); // argent
      case 3:
        return const Color(0xFFCD7F32); // bronze
      default:
        return Colors.grey.shade400;
    }
  }
}
