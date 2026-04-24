import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'weather_screen.dart';
import 'monthly_calendar_screen.dart';
import 'vegetables_screen.dart';

/// Écran dédié au potager traditionnel — schéma du cycle naturel,
/// pourquoi / comment, liens vers Semer, Météo et catalogue accessoires.
class PotagerTraditionnelScreen extends StatelessWidget {
  const PotagerTraditionnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌻  Potager traditionnel'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const _PotagerHero(),
          const SizedBox(height: 20),
          const _CycleDiagram(),
          const SizedBox(height: 20),
          _SectionCard(
            emoji: '🌿',
            title: 'Pourquoi rester sur la terre ?',
            bullets: const <String>[
              'Le sol vivant nourrit tes légumes avec ses vers, mycéliums et bactéries.',
              'La biodiversité protège naturellement contre les ravageurs.',
              'Respecter les saisons = légumes plus savoureux, moins d\'arrosage.',
              'Autonomie : peu de matériel, beaucoup de bon sens.',
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            emoji: '🛠️',
            title: 'Comment bien démarrer ?',
            bullets: const <String>[
              'Prépare ton sol : compost, paillage, pas de retournement profond.',
              'Choisis la bonne saison pour chaque légume (voir onglet Semer).',
              'Arrose au bon moment selon la météo (prévisions + pluies).',
              'Alterne les familles (rotation) pour éviter l\'épuisement du sol.',
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                child: _LinkCta(
                  emoji: '📅',
                  title: 'Calendrier',
                  subtitle: 'Mois par mois',
                  onTap: () => Navigator.of(context).push(
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
                  onTap: () => Navigator.of(context).push(
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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const VegetablesScreen(),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _PotagerHero extends StatelessWidget {
  const _PotagerHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('🌻', style: TextStyle(fontSize: 56)),
          SizedBox(height: 8),
          Text(
            'Cultiver en pleine terre',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: KultivaColors.textPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Le potager traditionnel, c'est respecter le rythme des saisons, "
            "nourrir le sol, et laisser faire la nature. Simple, économique, "
            "et délicieusement vivant.",
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: KultivaColors.textPrimary,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '🔄  Le cycle naturel',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
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
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: KultivaColors.springA.withOpacity(0.5),
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 26)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
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
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: KultivaColors.textSecondary,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> bullets;

  const _SectionCard({
    required this.emoji,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$emoji  $title',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 4, right: 8),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: KultivaColors.primaryGreen,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        b,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            Text(emoji, style: const TextStyle(fontSize: 28)),
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
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KultivaColors.primaryGreen.withOpacity(0.22),
              KultivaColors.springA.withOpacity(0.45),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: KultivaColors.primaryGreen,
            width: 1.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('🧰', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Accessoires pleine terre',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Outils, terreau, semences, arrosage, paillage — tout le catalogue.',
                    style: TextStyle(
                      fontSize: 12,
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
