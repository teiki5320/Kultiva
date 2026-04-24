import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/vegetable.dart';
import '../../services/culture_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../vegetable_detail_screen.dart';
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
              if (light != null) ...<Widget>[
                const SizedBox(height: 10),
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
                              '↕  ${light.ledDistanceCm!.toStringAsFixed(0)} cm'),
                    if (light.ledColorTemp != null)
                      _InfoChip(label: '🎨  ${light.ledColorTemp!.label}'),
                  ],
                ),
              ],
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
