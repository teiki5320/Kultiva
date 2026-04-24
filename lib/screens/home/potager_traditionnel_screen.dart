import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/vegetable.dart';
import '../../services/culture_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import 'culture_start_sheet.dart';
import 'monthly_calendar_screen.dart';
import 'vegetables_screen.dart';
import 'weather_screen.dart';

/// Cahier de culture pleine terre : suivi sérieux des cultures en cours
/// et passées, distinct du Poussidex (qui reste le mini-jeu kawaii).
class PotagerTraditionnelScreen extends StatelessWidget {
  const PotagerTraditionnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📔  Cahier pleine terre'),
      ),
      floatingActionButton: _StartFab(
        onStarted: () {
          // Nothing to do — ValueListenableBuilder below rebuilds.
        },
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: PrefsService.instance.culturesVersion,
        builder: (ctx, _, __) {
          final active = CultureService.instance
              .activeByMethod(CultivationMethod.soil);
          final ended = CultureService.instance
              .endedByMethod(CultivationMethod.soil);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: <Widget>[
              const _PotagerHero(),
              const SizedBox(height: 16),
              _SectionHeader(
                emoji: '🌿',
                title: 'Cultures en cours',
                count: active.length,
              ),
              const SizedBox(height: 8),
              if (active.isEmpty)
                const _EmptyState(
                  emoji: '🌱',
                  message:
                      "Aucune culture en cours. Appuie sur « Démarrer une culture » pour créer ta première fiche.",
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: _LinkCta(
                      emoji: '📅',
                      title: 'Calendrier',
                      subtitle: 'Mois par mois',
                      onTap: () => Navigator.of(ctx).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const MonthlyCalendarScreen(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _LinkCta(
                      emoji: '🌦️',
                      title: 'Météo',
                      subtitle: 'Pluie à venir',
                      onTap: () => Navigator.of(ctx).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const WeatherScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _AccessoriesCta(
                onTap: () => Navigator.of(ctx).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const VegetablesScreen(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StartFab extends StatelessWidget {
  final VoidCallback onStarted;
  const _StartFab({required this.onStarted});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final created = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (_) =>
              const CultureStartSheet(method: CultivationMethod.soil),
        );
        if (created == true) onStarted();
      },
      icon: const Icon(Icons.add),
      label: const Text(
        'Démarrer une culture',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      backgroundColor: KultivaColors.primaryGreen,
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
            color: KultivaColors.primaryGreen.withOpacity(0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: KultivaColors.primaryGreen,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _showActions(context),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: KultivaColors.springA.withOpacity(0.3),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: KultivaColors.primaryGreen.withOpacity(0.35),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: KultivaColors.primaryGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  veg?.emoji ?? '🌱',
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
                    if (culture.note != null &&
                        culture.note!.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 4),
                      Text(
                        culture.note!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
              const Icon(Icons.chevron_right),
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

class _EmptyState extends StatelessWidget {
  final String emoji;
  final String message;
  const _EmptyState({required this.emoji, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: KultivaColors.springA.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: KultivaColors.textSecondary.withOpacity(0.2),
          style: BorderStyle.solid,
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
            'ℹ️  Découvrir la pleine terre',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          children: const <Widget>[
            _CycleDiagram(),
            SizedBox(height: 12),
            _BulletSection(
              emoji: '🌿',
              title: 'Pourquoi rester sur la terre ?',
              bullets: <String>[
                'Le sol vivant nourrit tes légumes avec ses vers, mycéliums et bactéries.',
                'La biodiversité protège naturellement contre les ravageurs.',
                'Respecter les saisons = légumes plus savoureux, moins d\'arrosage.',
                'Autonomie : peu de matériel, beaucoup de bon sens.',
              ],
            ),
            _BulletSection(
              emoji: '🛠️',
              title: 'Comment bien démarrer ?',
              bullets: <String>[
                'Prépare ton sol : compost, paillage, pas de retournement profond.',
                'Choisis la bonne saison pour chaque légume.',
                'Arrose au bon moment selon la météo.',
                'Alterne les familles (rotation) pour éviter l\'épuisement du sol.',
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PotagerHero extends StatelessWidget {
  const _PotagerHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KultivaColors.springA,
            KultivaColors.springB,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: <Widget>[
          const Text('🌻', style: TextStyle(fontSize: 44)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Mon cahier pleine terre',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: KultivaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Suivi sérieux de tes cultures en sol vivant.",
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

class _CycleDiagram extends StatelessWidget {
  const _CycleDiagram();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              _CycleNode(emoji: '🌱', label: 'Semis'),
              _CycleArrow(),
              _CycleNode(emoji: '🌿', label: 'Pousse'),
              _CycleArrow(),
              _CycleNode(emoji: '🧺', label: 'Récolte'),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '↓  rien ne se perd  ↓',
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
              _CycleNode(emoji: '🟫', label: 'Sol'),
              _CycleArrow(reverse: true),
              _CycleNode(emoji: '🍂', label: 'Paillage'),
              _CycleArrow(reverse: true),
              _CycleNode(emoji: '♻️', label: 'Compost'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CycleNode extends StatelessWidget {
  final String emoji;
  final String label;
  const _CycleNode({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: KultivaColors.springA.withOpacity(0.5),
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

class _CycleArrow extends StatelessWidget {
  final bool reverse;
  const _CycleArrow({this.reverse = false});

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
                  const Padding(
                    padding: EdgeInsets.only(top: 5, right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: KultivaColors.primaryGreen,
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

class _LinkCta extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LinkCta({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: KultivaColors.springA.withOpacity(0.35),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: KultivaColors.primaryGreen.withOpacity(0.4),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccessoriesCta extends StatelessWidget {
  final VoidCallback onTap;
  const _AccessoriesCta({required this.onTap});

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
              KultivaColors.primaryGreen.withOpacity(0.22),
              KultivaColors.springA.withOpacity(0.45),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: KultivaColors.primaryGreen,
            width: 1.2,
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('🧰', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Accessoires pleine terre',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                  Text(
                    'Outils, terreau, paillage…',
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
              color: KultivaColors.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }
}
