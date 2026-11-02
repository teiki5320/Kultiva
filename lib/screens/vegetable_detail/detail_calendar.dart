/// Le calendrier d'une fiche légume : les mois de semis et de récolte, la durée jusqu'à la récolte et la note d'adaptation régionale.
///
/// ⚠️ Ces widgets vivaient dans
/// `vegetable_detail_screen.dart`, qui portait 18 classes sur
/// 1 357 lignes. Même découpage que le potager carré : un fichier par
/// sujet, et l'écran ne garde que lui-même.
library;

import 'package:flutter/material.dart';
import '../../data/ui_i18n.dart';
import '../../models/country.dart';
import '../../models/region_data.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';

class MonthsCard extends StatelessWidget {
  final String title;
  final List<int> months;
  final Color color;
  final List<String> shortMonths;

  const MonthsCard({
    super.key,
    required this.title,
    required this.months,
    required this.color,
    required this.shortMonths,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List<Widget>.generate(12, (i) {
                final m = i + 1;
                final active = months.contains(m);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color:
                                active ? color : color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shortMonths[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                active ? FontWeight.w800 : FontWeight.w600,
                            color: active
                                ? color
                                : Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class HarvestTimeSection extends StatelessWidget {
  final Map<String, String> times;
  const HarvestTimeSection({super.key, required this.times});

  static const _order = <String, ({String emoji, Color color})>{
    'spring': (emoji: '🌸', color: Color(0xFFE8A87C)),
    'summer': (emoji: '☀️', color: Color(0xFFFFB74D)),
    'autumn': (emoji: '🍂', color: Color(0xFFD5A679)),
    'winter': (emoji: '❄️', color: Color(0xFF7BAFD4)),
  };

  @override
  Widget build(BuildContext context) {
    final entries =
        _order.entries.where((e) => times.containsKey(e.key)).toList();
    if (entries.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trUi('⏱  Temps avant récolte'),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              for (final e in entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: e.value.color.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(e.value.emoji,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 90,
                        child: Text(
                          _seasonLabel(e.key),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          times[e.key]!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _seasonLabel(String key) {
    switch (key) {
      case 'spring':
        return trUi('Printemps');
      case 'summer':
        return trUi('Été');
      case 'autumn':
        return trUi('Automne');
      case 'winter':
        return trUi('Hiver');
    }
    return key;
  }
}

class RegionalNoteCard extends StatelessWidget {
  final Region region;
  final String note;
  const RegionalNoteCard({super.key, required this.region, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KultivaColors.summerA.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(placeEmojiFor(region, PrefsService.instance.country.value),
                style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trUiArgs('Adaptation — {0}', <Object?>[
                      placeLabelFor(region, PrefsService.instance.country.value)
                    ]),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.35,
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
