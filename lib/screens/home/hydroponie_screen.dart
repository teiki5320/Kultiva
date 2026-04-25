import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/culture_reading.dart';
import '../../models/vegetable.dart';
import '../../services/culture_reading_service.dart';
import '../../services/culture_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/reading_targets.dart';
import '../../widgets/reading_sparkline.dart';
import '../vegetable_detail_screen.dart';
import 'culture_reading_sheet.dart';
import 'culture_start_sheet.dart';

/// Cahier de culture hydroponique : suivi sérieux des cultures sans terre,
/// avec configuration lumière (type, heures, LED). Distinct du Poussidex.
class HydroponieScreen extends StatelessWidget {
  const HydroponieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📔  Cahier hydroponie'),
      ),
      floatingActionButton: _StartFab(),
      body: ValueListenableBuilder<int>(
        valueListenable: PrefsService.instance.culturesVersion,
        builder: (ctx, _, __) {
          final active = CultureService.instance
              .activeByMethod(CultivationMethod.hydroponic);
          final ended = CultureService.instance
              .endedByMethod(CultivationMethod.hydroponic);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: <Widget>[
              const _HydroHero(),
              const SizedBox(height: 16),
              _SectionHeader(
                emoji: '🌿',
                title: 'Cultures en cours',
                count: active.length,
              ),
              const SizedBox(height: 8),
              if (active.isEmpty)
                const _EmptyState(
                  emoji: '💧',
                  message:
                      "Aucune culture en cours. Appuie sur « Démarrer une culture » pour créer ta première fiche (tu pourras configurer la lumière : naturelle, LED, heures/jour…).",
                )
              else
                ...active.map((c) => _CultureCard(culture: c)),
              const SizedBox(height: 24),
              if (ended.isNotEmpty) ...<Widget>[
                _EndedSection(list: ended),
                const SizedBox(height: 24),
              ],
              _InfoExpansion(),
              const SizedBox(height: 12),
              _AccessoryCta(
                onTap: () {
                  final hydro = vegetablesBase.firstWhere(
                    (v) => v.id == 'acc_hydroponie',
                  );
                  Navigator.of(ctx).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          VegetableDetailScreen(vegetable: hydro),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StartFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (_) =>
              const CultureStartSheet(method: CultivationMethod.hydroponic),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text(
        'Démarrer une culture',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      backgroundColor: const Color(0xFF4A9BBF),
      foregroundColor: Colors.white,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String emoji;
  final String title;
  final int count;

  const _SectionHeader({
    required this.emoji,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF4A9BBF).withOpacity(0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4A9BBF),
            ),
          ),
        ),
      ],
    );
  }
}

class _CultureCard extends StatelessWidget {
  final CultureEntry culture;
  const _CultureCard({required this.culture});

  Vegetable? _veg() {
    try {
      return vegetablesBase.firstWhere((v) => v.id == culture.vegetableId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final veg = _veg();
    final days = culture.daysSinceStarted;
    final light = culture.light;
    final dli = light != null ? estimateDli(light) : null;
    final dliStat = dli != null ? dliStatus(dli, culture.phase) : null;
    final ledRec = recommendedLedDistance(culture.phase);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _showActions(context),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: KultivaColors.winterA.withOpacity(0.45),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF4A9BBF).withOpacity(0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9BBF).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      veg?.emoji ?? '💧',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          veg?.name ?? culture.vegetableId,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          days == 0
                              ? 'Démarrée aujourd\'hui'
                              : 'Démarrée il y a $days jour${days > 1 ? "s" : ""}',
                          style: TextStyle(
                            fontSize: 12,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 10),
              _PhaseChip(culture: culture),
              if (light != null) ...<Widget>[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _InfoChip(
                      label: '${light.type.emoji}  ${light.type.label}',
                    ),
                    _InfoChip(
                      label:
                          '⏱  ${light.hoursPerDay.toStringAsFixed(0)} h/jour',
                    ),
                    if (light.ledWatts != null)
                      _InfoChip(label: '⚡  ${light.ledWatts} W'),
                    if (light.ledDistanceCm != null)
                      _InfoChip(
                        label:
                            '↕  ${light.ledDistanceCm!.toStringAsFixed(0)} cm '
                            '(reco. ${ledRec.ideal.toStringAsFixed(0)})',
                      ),
                    if (light.ledColorTemp != null)
                      _InfoChip(label: '🎨  ${light.ledColorTemp!.label}'),
                    if (dli != null)
                      _DliChip(dli: dli, status: dliStat!),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              _ReadingsRow(cultureId: culture.id, phase: culture.phase),
              if (culture.note != null && culture.note!.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Text(
                  culture.note!,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Marquer terminée'),
              onTap: () async {
                Navigator.pop(ctx);
                await CultureService.instance.endCulture(culture.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(ctx).colorScheme.error,
              ),
              title: Text(
                'Supprimer',
                style: TextStyle(
                  color: Theme.of(ctx).colorScheme.error,
                ),
              ),
              onTap: () async {
                Navigator.pop(ctx);
                await CultureService.instance.remove(culture.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF4A9BBF).withOpacity(0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF2E6680),
        ),
      ),
    );
  }
}

/// Rangée des 4 mesures hydro (pH, EC, température solution, niveau
/// réservoir). Tap = ouvre la sheet pour ajouter une nouvelle mesure.
class _ReadingsRow extends StatelessWidget {
  final String cultureId;
  final GrowthPhase phase;
  const _ReadingsRow({required this.cultureId, required this.phase});

  static const _types = <ReadingType>[
    ReadingType.ph,
    ReadingType.ec,
    ReadingType.waterTemp,
    ReadingType.reservoirLevel,
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.cultureReadingsVersion,
      builder: (ctx, _, __) {
        return Row(
          children: <Widget>[
            for (var i = 0; i < _types.length; i++) ...<Widget>[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: _ReadingChip(
                  cultureId: cultureId,
                  type: _types[i],
                  phase: phase,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ReadingChip extends StatelessWidget {
  final String cultureId;
  final ReadingType type;
  final GrowthPhase phase;
  const _ReadingChip({
    required this.cultureId,
    required this.type,
    required this.phase,
  });

  Color _statusColor(ReadingStatus s) {
    switch (s) {
      case ReadingStatus.ok:
        return KultivaColors.primaryGreen;
      case ReadingStatus.warn:
        return const Color(0xFFE8A87C);
      case ReadingStatus.bad:
        return const Color(0xFFD4564A);
      case ReadingStatus.unknown:
        return const Color(0xFF4A9BBF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final svc = CultureReadingService.instance;
    final latest = svc.latest(cultureId, type);
    final recent = svc.recent(cultureId, type, days: 14);
    final tgt = hydroTargetFor(type, phase);
    final status = tgt?.statusFor(latest?.value) ?? ReadingStatus.unknown;
    final color = _statusColor(status);
    final values = recent
        .where((r) => r.value != null)
        .map((r) => r.value!)
        .toList();

    return InkWell(
      onTap: () async {
        await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (_) => CultureReadingSheet(
            cultureId: cultureId,
            type: type,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(type.emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _shortLabel(type),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.textPrimary.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              latest?.value == null
                  ? '—'
                  : _fmtValue(latest!.value!, type),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            ReadingSparkline(values: values, color: color, height: 18),
          ],
        ),
      ),
    );
  }

  static String _shortLabel(ReadingType t) {
    switch (t) {
      case ReadingType.ph:
        return 'pH';
      case ReadingType.ec:
        return 'EC';
      case ReadingType.waterTemp:
        return 'Temp.';
      case ReadingType.reservoirLevel:
        return 'Niveau';
      default:
        return t.label;
    }
  }

  static String _fmtValue(double v, ReadingType t) {
    switch (t) {
      case ReadingType.ph:
        return v.toStringAsFixed(1);
      case ReadingType.ec:
        return '${v.toStringAsFixed(1)} mS';
      case ReadingType.waterTemp:
        return '${v.toStringAsFixed(0)}°';
      case ReadingType.reservoirLevel:
        return '${v.toStringAsFixed(0)}%';
      default:
        return v.toStringAsFixed(1);
    }
  }
}

class _EmptyState extends StatelessWidget {
  final String emoji;
  final String message;
  const _EmptyState({required this.emoji, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: KultivaColors.winterA.withOpacity(0.4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: KultivaColors.textSecondary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 42)),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: KultivaColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndedSection extends StatelessWidget {
  final List<CultureEntry> list;
  const _EndedSection({required this.list});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: _SectionHeader(
          emoji: '✅',
          title: 'Cultures terminées',
          count: list.length,
        ),
        children: list.map((c) => _CultureCard(culture: c)).toList(),
      ),
    );
  }
}

class _InfoExpansion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            'ℹ️  Découvrir l\'hydroponie',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          children: const <Widget>[
            _DiagramBlock(),
            SizedBox(height: 12),
            _BulletSection(
              emoji: '🌟',
              title: 'Pourquoi essayer ?',
              bullets: <String>[
                'Jusqu\'à 90 % d\'eau en moins qu\'un potager classique.',
                'Croissance 2 à 3 fois plus rapide.',
                'Cultivable en intérieur, toute l\'année.',
                'Zéro terre, zéro maladies du sol, zéro mauvaises herbes.',
              ],
            ),
            _BulletSection(
              emoji: '🔧',
              title: 'Comment ça marche ?',
              bullets: <String>[
                'Réservoir d\'eau enrichie en nutriments.',
                'Pompe fait circuler la solution vers les racines.',
                'Substrat inerte (billes d\'argile, laine de roche…).',
                'Systèmes simples : DWC, Kratky, NFT.',
              ],
            ),
            _BulletSection(
              emoji: '💡',
              title: 'Lumière',
              bullets: <String>[
                'Naturelle (plein soleil ≥ 6 h/jour) pour balcon.',
                'LED horticole (spectre complet ou blanc + rouge) en intérieur.',
                'Mixte : LED d\'appoint l\'hiver ou en zones peu ensoleillées.',
                'Durée recommandée : 10-16 h selon la phase de croissance.',
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HydroHero extends StatelessWidget {
  const _HydroHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KultivaColors.winterA,
            KultivaColors.winterB,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: <Widget>[
          const Text('💧', style: TextStyle(fontSize: 44)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Mon cahier hydroponie',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: KultivaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cultiver sans terre, avec suivi lumière.',
                  style: TextStyle(
                    fontSize: 13,
                    color: KultivaColors.textPrimary.withOpacity(0.8),
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

class _DiagramBlock extends StatelessWidget {
  const _DiagramBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              _DiagramNode(emoji: '🪴', label: 'Plants'),
              _DiagramArrow(),
              _DiagramNode(emoji: '🌿', label: 'Racines'),
              _DiagramArrow(),
              _DiagramNode(emoji: '💧', label: 'Solution'),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '↑  cycle fermé  ↓',
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: KultivaColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              _DiagramNode(emoji: '🪣', label: 'Réservoir'),
              _DiagramArrow(reverse: true),
              _DiagramNode(emoji: '⚙️', label: 'Pompe'),
              _DiagramArrow(reverse: true),
              _DiagramNode(emoji: '💦', label: 'Nutriments'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagramNode extends StatelessWidget {
  final String emoji;
  final String label;
  const _DiagramNode({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: KultivaColors.winterA.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _DiagramArrow extends StatelessWidget {
  final bool reverse;
  const _DiagramArrow({this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        reverse ? '←' : '→',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: KultivaColors.textSecondary,
        ),
      ),
    );
  }
}

class _BulletSection extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> bullets;

  const _BulletSection({
    required this.emoji,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$emoji  $title',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: const Color(0xFF4A9BBF),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(fontSize: 13, height: 1.4),
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

/// Chip cliquable représentant la phase de croissance de la culture.
/// Tap = ouvre la sheet de sélection de phase.
class _PhaseChip extends StatelessWidget {
  final CultureEntry culture;
  const _PhaseChip({required this.culture});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickPhase(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: KultivaColors.primaryGreen.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: KultivaColors.primaryGreen.withOpacity(0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              culture.phase.emoji,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 6),
            Text(
              'Phase : ${culture.phase.label}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: KultivaColors.primaryGreen,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.tune,
              size: 14,
              color: KultivaColors.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPhase(BuildContext context) async {
    final picked = await showModalBottomSheet<GrowthPhase>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phase de croissance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            for (final p in GrowthPhase.values)
              ListTile(
                leading: Text(p.emoji,
                    style: const TextStyle(fontSize: 22)),
                title: Text(p.label),
                trailing: p == culture.phase
                    ? const Icon(Icons.check,
                        color: KultivaColors.primaryGreen)
                    : null,
                onTap: () => Navigator.pop(ctx, p),
              ),
          ],
        ),
      ),
    );
    if (picked != null && picked != culture.phase) {
      await CultureService.instance
          .update(culture.copyWith(phase: picked));
    }
  }
}

/// Chip DLI (Daily Light Integral) calculé à partir de la config LED.
class _DliChip extends StatelessWidget {
  final double dli;
  final ReadingStatus status;
  const _DliChip({required this.dli, required this.status});

  Color get _color {
    switch (status) {
      case ReadingStatus.ok:
        return KultivaColors.primaryGreen;
      case ReadingStatus.warn:
        return const Color(0xFFE8A87C);
      case ReadingStatus.bad:
        return const Color(0xFFD4564A);
      case ReadingStatus.unknown:
        return const Color(0xFF4A9BBF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '☀️  DLI ${dli.toStringAsFixed(0)} mol',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: _color,
        ),
      ),
    );
  }
}

class _AccessoryCta extends StatelessWidget {
  final VoidCallback onTap;
  const _AccessoryCta({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF4A9BBF).withOpacity(0.22),
              KultivaColors.winterA.withOpacity(0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF4A9BBF),
            width: 1.2,
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('🛒', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Voir le kit hydroponie',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E6680),
                    ),
                  ),
                  Text(
                    'Accessoire complet avec description et lien.',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF4A9BBF),
            ),
          ],
        ),
      ),
    );
  }
}
