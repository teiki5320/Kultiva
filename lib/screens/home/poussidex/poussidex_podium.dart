import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';

/// Vue "Podium" : 4 podiums top 3 sur différentes métriques.
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
          title: 'Les plus récoltés',
          emoji: '🧺',
          color: KultivaColors.terracotta,
          entries: topBy((s) => s.totalHarvests),
          unitSingular: 'récolte',
          unitPlural: 'récoltes',
          valueOf: (s) => s.totalHarvests,
          hint: 'Récolte tes plants pour lancer la course.',
        ),
        const SizedBox(height: 14),
        _PodiumSection(
          title: 'Les plus anciens',
          emoji: '⏳',
          color: const Color(0xFF8B6914),
          entries: topBy((s) => s.oldestDays),
          unitSingular: 'jour',
          unitPlural: 'jours',
          valueOf: (s) => s.oldestDays,
          hint: 'Ton plus vieux plant apparaîtra ici.',
        ),
        const SizedBox(height: 14),
        _PodiumSection(
          title: 'Les plus arrosés',
          emoji: '💧',
          color: const Color(0xFF4FC3F7),
          entries: topBy((s) => s.totalWaterings),
          unitSingular: 'arrosage',
          unitPlural: 'arrosages',
          valueOf: (s) => s.totalWaterings,
          hint: 'Arrose tes plants pour remplir le podium.',
        ),
        const SizedBox(height: 14),
        _PodiumSection(
          title: 'Les plus photographiés',
          emoji: '📷',
          color: const Color(0xFFFFB74D),
          entries: topBy((s) => s.totalPhotos),
          unitSingular: 'photo',
          unitPlural: 'photos',
          valueOf: (s) => s.totalPhotos,
          hint: 'Ajoute des photos à tes plants pour ce classement.',
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
  final String emoji;
  final Color color;
  final List<_SpeciesStats> entries;
  final String unitSingular;
  final String unitPlural;
  final int Function(_SpeciesStats) valueOf;
  final String hint;

  const _PodiumSection({
    required this.title,
    required this.emoji,
    required this.color,
    required this.entries,
    required this.unitSingular,
    required this.unitPlural,
    required this.valueOf,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final first = entries.isNotEmpty ? entries[0] : null;
    final second = entries.length > 1 ? entries[1] : null;
    final third = entries.length > 2 ? entries[2] : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header de section avec emoji + titre.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  color.withOpacity(0.10),
                  color.withOpacity(0.18),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: color,
                    ),
                  ),
                ),
                if (first != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${valueOf(first)} ${valueOf(first) > 1 ? unitPlural : unitSingular}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Corps du podium.
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.hourglass_empty,
                      size: 16, color: KultivaColors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hint,
                      style: TextStyle(
                        color: KultivaColors.textSecondary,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: SizedBox(
                height: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: second == null
                          ? const SizedBox()
                          : _PodiumStep(
                              rank: 2,
                              stats: second,
                              unitSingular: unitSingular,
                              unitPlural: unitPlural,
                              value: valueOf(second),
                            ),
                    ),
                    Expanded(
                      child: _PodiumStep(
                        rank: 1,
                        stats: first!,
                        unitSingular: unitSingular,
                        unitPlural: unitPlural,
                        value: valueOf(first),
                      ),
                    ),
                    Expanded(
                      child: third == null
                          ? const SizedBox()
                          : _PodiumStep(
                              rank: 3,
                              stats: third,
                              unitSingular: unitSingular,
                              unitPlural: unitPlural,
                              value: valueOf(third),
                            ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Une marche du podium : emoji + badge-médaille, nom dessous, avec un
/// socle coloré dont la hauteur varie avec le rang. Le 1er a une
/// couronne + un halo doré marqué.
class _PodiumStep extends StatelessWidget {
  final int rank; // 1, 2 ou 3
  final _SpeciesStats stats;
  final String unitSingular;
  final String unitPlural;
  final int value;

  const _PodiumStep({
    required this.rank,
    required this.stats,
    required this.unitSingular,
    required this.unitPlural,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final veg = vegetablesBase
        .where((v) => v.id == stats.vegetableId)
        .firstOrNull;
    if (veg == null) return const SizedBox();

    final stepHeight = rank == 1 ? 80.0 : (rank == 2 ? 58.0 : 40.0);
    final emojiSize = rank == 1 ? 66.0 : 50.0;
    final stepColor = _rankColor(rank);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // 👑 couronne seulement pour le 1er.
        if (rank == 1)
          const Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text('👑', style: TextStyle(fontSize: 28)),
          ),
        // Emoji du légume dans un cercle coloré avec une pastille médaille.
        SizedBox(
          width: emojiSize + 14,
          height: emojiSize + 14,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: emojiSize,
                height: emojiSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: veg.category.familyColor.withOpacity(0.18),
                  border: Border.all(color: stepColor, width: 3),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: stepColor.withOpacity(rank == 1 ? 0.55 : 0.3),
                      blurRadius: rank == 1 ? 14 : 8,
                      spreadRadius: rank == 1 ? 1 : 0,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  veg.emoji,
                  style: TextStyle(fontSize: emojiSize * 0.56),
                ),
              ),
              // Pastille médaille au coin haut-droit.
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _medalEmoji(rank),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // Valeur en gros + unité.
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: rank == 1 ? 20 : 16,
            color: stepColor,
            height: 1.0,
          ),
        ),
        Text(
          value > 1 ? unitPlural : unitSingular,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: stepColor,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        // Socle : juste le nom centré, hauteur varie avec le rang.
        Container(
          width: double.infinity,
          height: stepHeight,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                stepColor,
                stepColor.withOpacity(0.75),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          alignment: Alignment.center,
          child: Text(
            veg.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: rank == 1 ? 12 : 11,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  String _medalEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '';
    }
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFE8B923);
      case 2:
        return const Color(0xFF9AA4B0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return Colors.grey.shade400;
    }
  }
}
