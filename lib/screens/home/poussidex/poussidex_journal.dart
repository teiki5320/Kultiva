import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/months.dart';

/// Vue "Journal" : toutes les actions (plantation, arrosage, récolte,
/// photo) regroupées par jour, en ordre anti-chronologique.
class PoussidexJournalView extends StatelessWidget {
  final List<Plantation> plantations;
  const PoussidexJournalView({super.key, required this.plantations});

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dd = DateTime(d.year, d.month, d.day);
    final diff = today.difference(dd).inDays;
    if (diff == 0) return "AUJOURD'HUI";
    if (diff == 1) return 'HIER';
    return '${d.day} ${monthNamesLong[d.month - 1].toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final events = <_JournalEvent>[];
    for (final p in plantations) {
      final v = vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
      final label = v == null ? p.vegetableId : '${v.emoji} ${v.name}';
      final color = v == null
          ? KultivaColors.primaryGreen
          : v.category.familyColor;

      events.add(_JournalEvent(
        date: p.plantedAt,
        icon: '🌱',
        action: 'Planté',
        vegetableLabel: label,
        color: color,
      ));
      for (final w in p.wateredAt) {
        events.add(_JournalEvent(
          date: w,
          icon: '💧',
          action: 'Arrosé',
          vegetableLabel: label,
          color: const Color(0xFF4FC3F7),
        ));
      }
      if (p.harvestedAt != null) {
        events.add(_JournalEvent(
          date: p.harvestedAt!,
          icon: '🏁',
          action: 'Culture terminée',
          vegetableLabel: label,
          color: KultivaColors.terracotta,
        ));
      }
      for (final path in p.photoPaths) {
        final match = RegExp(r'plant_(\d+)\.').firstMatch(path);
        if (match == null) continue;
        final ts = int.tryParse(match.group(1)!);
        if (ts == null) continue;
        events.add(_JournalEvent(
          date: DateTime.fromMillisecondsSinceEpoch(ts),
          icon: '📷',
          action: 'Photo ajoutée',
          vegetableLabel: label,
          color: const Color(0xFFFFB74D),
        ));
      }
    }

    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '📜\n\nTon journal se remplira au fil de tes actions.\nPlante, arrose, récolte !',
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

    events.sort((a, b) => b.date.compareTo(a.date));

    final groups = <String, List<_JournalEvent>>{};
    for (final e in events) {
      final key = '${e.date.year}-${e.date.month}-${e.date.day}';
      groups.putIfAbsent(key, () => <_JournalEvent>[]).add(e);
    }
    final keys = groups.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final key = keys[i];
        final day = groups[key]!.first.date;
        final dayEvents = groups[key]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 14, 6, 6),
              child: Text(
                _dayLabel(day),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: <Widget>[
                  for (int j = 0; j < dayEvents.length; j++) ...<Widget>[
                    _JournalTile(event: dayEvents[j]),
                    if (j != dayEvents.length - 1)
                      Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                        indent: 48,
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _JournalEvent {
  final DateTime date;
  final String icon;
  final String action;
  final String vegetableLabel;
  final Color color;
  const _JournalEvent({
    required this.date,
    required this.icon,
    required this.action,
    required this.vegetableLabel,
    required this.color,
  });
}

class _JournalTile extends StatelessWidget {
  final _JournalEvent event;
  const _JournalTile({required this.event});

  String _timeLabel(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: event.color.withValues(alpha: 0.15),
            ),
            alignment: Alignment.center,
            child: Text(event.icon, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.action,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: event.color,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  event.vegetableLabel,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            _timeLabel(event.date),
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
