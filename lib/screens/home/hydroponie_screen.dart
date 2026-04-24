import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../theme/app_theme.dart';
import '../vegetable_detail_screen.dart';

/// Écran dédié à l'hydroponie — schéma kawaii, pourquoi / comment,
/// et lien direct vers l'accessoire `acc_hydroponie` du catalogue.
class HydroponieScreen extends StatelessWidget {
  const HydroponieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💧  Hydroponie'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const _HydroponieHero(),
          const SizedBox(height: 20),
          const _DiagramCard(),
          const SizedBox(height: 20),
          _SectionCard(
            emoji: '🌟',
            title: 'Pourquoi essayer ?',
            bullets: const <String>[
              'Jusqu\'à 90 % d\'eau en moins qu\'un potager classique.',
              'Croissance 2 à 3 fois plus rapide.',
              'Cultivable en intérieur, sur balcon, toute l\'année.',
              'Zéro terre, zéro maladies du sol, zéro mauvaises herbes.',
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            emoji: '🔧',
            title: 'Comment ça marche ?',
            bullets: const <String>[
              'Un réservoir contient de l\'eau enrichie en nutriments.',
              'Une pompe fait circuler la solution vers les racines.',
              'Les plants poussent dans un substrat inerte (billes d\'argile, laine de roche…).',
              'Systèmes simples : DWC (racines immergées), Kratky (sans pompe), NFT (film nutritif).',
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            emoji: '🥬',
            title: 'Légumes adaptés',
            bullets: const <String>[
              'Salades, épinards, roquette — très rapides.',
              'Basilic, menthe, ciboulette — aromatiques parfaites.',
              'Fraises, tomates cerises — fruits stars en hydroponie.',
              'À éviter : carottes, pommes de terre (racines profondes).',
            ],
          ),
          const SizedBox(height: 24),
          _AccessoryCta(
            onTap: () {
              final hydro = vegetablesBase.firstWhere(
                (v) => v.id == 'acc_hydroponie',
              );
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => VegetableDetailScreen(vegetable: hydro),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _HydroponieHero extends StatelessWidget {
  const _HydroponieHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('💧', style: TextStyle(fontSize: 56)),
          SizedBox(height: 8),
          Text(
            'Cultiver sans terre',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: KultivaColors.textPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "L'hydroponie, c'est faire pousser tes légumes directement "
            "dans l'eau nutritive. Pratique, économique, et ça marche "
            "même en appartement.",
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

class _DiagramCard extends StatelessWidget {
  const _DiagramCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '🔬  Comment ça fonctionne',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
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
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: KultivaColors.winterA.withOpacity(0.35),
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

class _AccessoryCta extends StatelessWidget {
  final VoidCallback onTap;
  const _AccessoryCta({required this.onTap});

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
            const Text('🛒', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Voir le kit hydroponie',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Découvre l'accessoire complet avec description et lien d'achat.",
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
