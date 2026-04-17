import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/plant_creature.dart';

class CreatureDemoScreen extends StatefulWidget {
  const CreatureDemoScreen({super.key});

  @override
  State<CreatureDemoScreen> createState() => _CreatureDemoScreenState();
}

class _CreatureDemoScreenState extends State<CreatureDemoScreen> {
  double _level = 5;

  String get _stageName {
    final lv = _level.round();
    if (lv < 5) return 'Graine';
    if (lv < 15) return 'Pousse';
    if (lv < 30) return 'Fleur';
    return 'Arbre';
  }

  @override
  Widget build(BuildContext context) {
    final lv = _level.round();
    return Scaffold(
      appBar: AppBar(title: const Text('Poussia — prototype')),
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
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const Spacer(),
              PlantCreature(level: lv, size: 280),
              const SizedBox(height: 20),
              Text(
                'Poussia',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Niveau $lv · $_stageName',
                style: TextStyle(
                  fontSize: 14,
                  color: KultivaColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    const Text('1', style: TextStyle(fontWeight: FontWeight.w700)),
                    Expanded(
                      child: Slider(
                        value: _level,
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: '$lv',
                        activeColor: KultivaColors.primaryGreen,
                        onChanged: (v) => setState(() => _level = v),
                      ),
                    ),
                    const Text('100', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              // Raccourcis vers les paliers clés.
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Wrap(
                  spacing: 8,
                  children: <int>[1, 5, 10, 15, 20, 30, 50, 75, 100]
                      .map((lv) => ActionChip(
                            label: Text('$lv'),
                            onPressed: () =>
                                setState(() => _level = lv.toDouble()),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
