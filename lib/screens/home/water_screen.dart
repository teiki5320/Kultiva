import 'package:flutter/material.dart';

import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/water_calendar.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import 'tuto_fiche_screen.dart';

/// Suivi de l'eau — écran Afrique de l'Ouest.
///
/// Montre où l'on en est dans l'année de l'eau (arrivée / fin des
/// pluies), un journal d'arrosage simple, et les techniques d'économie
/// d'eau (paillage, zaï, canari, ombrière) avec liens vers les tutos.
class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  Future<void> _recordWatering() async {
    await PrefsService.instance.recordWatering();
    if (mounted) setState(() {});
  }

  int get _wateringsThisMonth {
    final now = DateTime.now();
    return PrefsService.instance.wateringHistory.where((iso) {
      final d = DateTime.tryParse(iso);
      return d != null && d.year == now.year && d.month == now.month;
    }).length;
  }

  void _openTuto(WaterTechnique t) {
    if (t.tutoFile == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TutoFicheScreen(
          titre: t.title,
          assetPath: 'assets/tutos/${t.tutoFile}.html',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final zone = PrefsService.instance.country.value?.zone;
    final advisory = waterAdvisory(now, zone);
    final season = Season.of(now.month, PrefsService.instance.region.value,
        zone: zone);
    final days = advisory.relevantDays;
    final lastWatering = PrefsService.instance.lastWatering;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SeasonHeader(season: season, month: now.month, height: 150),
              Positioned(
                top: 8,
                left: 8,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 12,
                left: 16,
                child: Text(
                  '💧 Suivi de l\'eau',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black45, blurRadius: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ── Phase de l'année de l'eau + compte à rebours ──
                Card(
                  color: advisory.raining
                      ? const Color(0xFFE3F0E8)
                      : const Color(0xFFFBEEDD),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(advisory.emoji,
                                style: const TextStyle(fontSize: 34)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    advisory.headline,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  if (days >= 0)
                                    Text(
                                      advisory.raining
                                          ? 'Fin des pluies ${WaterAdvisory.humanizeDays(days)}'
                                          : 'Prochaines pluies ${WaterAdvisory.humanizeDays(days)}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: KultivaColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          advisory.message,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ── Journal d'arrosage ──
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '🚿  Mes arrosages',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _StatTile(
                                value: '$_wateringsThisMonth',
                                label: 'ce mois-ci',
                              ),
                            ),
                            Expanded(
                              child: _StatTile(
                                value: lastWatering == null
                                    ? '—'
                                    : _shortDate(lastWatering),
                                label: 'dernier arrosage',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _recordWatering,
                            icon: const Icon(Icons.water_drop),
                            label: const Text("J'ai arrosé aujourd'hui"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ── Techniques d'économie d'eau ──
                Text(
                  'Économiser l\'eau',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                for (final t in waterTechniques)
                  Card(
                    child: ListTile(
                      leading: Text(t.emoji,
                          style: const TextStyle(fontSize: 28)),
                      title: Text(
                        t.title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(t.description),
                      trailing: t.tutoFile != null
                          ? const Icon(Icons.chevron_right)
                          : null,
                      onTap: t.tutoFile != null ? () => _openTuto(t) : null,
                      isThreeLine: true,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _shortDate(DateTime d) {
    const months = <String>[
      'janv', 'févr', 'mars', 'avr', 'mai', 'juin',
      'juil', 'août', 'sept', 'oct', 'nov', 'déc',
    ];
    return '${d.day} ${months[d.month - 1]}';
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;
  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: KultivaColors.primaryGreen,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: KultivaColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
