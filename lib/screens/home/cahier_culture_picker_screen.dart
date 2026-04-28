import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'hydroponie_screen.dart';
import 'potager_traditionnel_screen.dart';

/// Écran sélecteur entre Pleine terre et Hydroponie.
///
/// Remplace les anciennes cards séparées « Potager traditionnel » et
/// « Hydroponie » du dashboard. Une seule carte « Cahier de culture »
/// ouvre cet écran, et l'utilisateur choisit ensuite quelle méthode.
class CahierCulturePickerScreen extends StatelessWidget {
  const CahierCulturePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📔  Cahier de culture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Quelle méthode aujourd\'hui ?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Choisis le type de culture pour ouvrir le bon cahier.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            _MethodCard(
              emoji: '🌻',
              label: 'Pleine terre',
              subtitle: 'Potager classique, sol vivant, saisons',
              gradientColors: const <Color>[
                KultivaColors.springA,
                KultivaColors.springB,
              ],
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const PotagerTraditionnelScreen(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _MethodCard(
              emoji: '💧',
              label: 'Hydroponie',
              subtitle: 'Cultiver sans terre, en eau nutritive',
              gradientColors: const <Color>[
                KultivaColors.winterA,
                KultivaColors.winterB,
              ],
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const HydroponieScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _MethodCard({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: gradientColors.first.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
