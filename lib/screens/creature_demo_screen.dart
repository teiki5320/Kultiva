import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/plant_creature.dart';

/// Écran de prototypage pour la créature-plante du Poussidex.
///
/// Étape 1 : juste un gros affichage statique de Poussia (sprout).
class CreatureDemoScreen extends StatelessWidget {
  const CreatureDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poussia — étape 1')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              KultivaColors.springB.withOpacity(0.35),
              KultivaColors.lightBackground,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const PlantCreature(level: 5, size: 300),
              const SizedBox(height: 24),
              const Text(
                'Poussia',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Niveau 5 · Pousse',
                style: TextStyle(
                  fontSize: 14,
                  color: KultivaColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
