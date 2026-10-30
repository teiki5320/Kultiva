/// Conseils affichés sous un plant du potager carré : étape de
/// croissance déduite, et compagnonnage avec les cases voisines.
///
/// Extrait de `planner_widgets.dart`, qui faisait 1 339 lignes.
library;

import 'package:flutter/material.dart';

import '../../../data/companions.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/culture_entry.dart';
import '../../../models/vegetable.dart';
import '../../../theme/app_theme.dart';

class PlannerPhaseAdviceTile extends StatelessWidget {
  final Vegetable veg;
  final GrowthPhase phase;

  const PlannerPhaseAdviceTile({
    super.key,
    required this.veg,
    required this.phase,
  });

  String _adviceFor(Vegetable veg, GrowthPhase phase) {
    switch (phase) {
      case GrowthPhase.seedling:
        return 'Garde le sol humide, protège des limaces et du froid '
            'avec un voile si besoin.';
      case GrowthPhase.vegetative:
        if (veg.category == VegetableCategory.fruits) {
          return 'Tuteure le plant, pince les gourmands (tomates), '
              'apporte du compost si feuilles claires.';
        }
        if (veg.category == VegetableCategory.leaves ||
            veg.category == VegetableCategory.aromatics) {
          return 'Récolte au fur et à mesure pour stimuler la repousse, '
              'arrose au pied le matin.';
        }
        return 'Le plant prend du volume — arrose régulièrement et '
            'binesle pied pour aérer le sol.';
      case GrowthPhase.flowering:
        return 'Floraison en cours : maintenir l\'arrosage régulier, '
            'apporter de la potasse (cendres bois).';
      case GrowthPhase.fruiting:
        return 'Récolte régulière pour stimuler la production. '
            'Surveille les nuisibles et l\'humidité.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: KultivaColors.summerA.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8C96A).withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(phase.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Conseil pour ce stade',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7A5A1E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _adviceFor(veg, phase),
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
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

/// Affiche la liste des compagnes et incompatibles d'un légume.
class PlannerCompanionInfo extends StatelessWidget {
  final String vegetableId;
  const PlannerCompanionInfo({super.key, required this.vegetableId});

  String _label(String id) {
    final v = vegetableById(id);
    return '${v.emoji} ${v.name}';
  }

  @override
  Widget build(BuildContext context) {
    final companions = companionMap[vegetableId] ?? const <String>[];
    final incompat = incompatibleMap[vegetableId] ?? const <String>[];
    if (companions.isEmpty && incompat.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (companions.isNotEmpty) ...<Widget>[
          Row(
            children: <Widget>[
              const Text('👍', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                'À planter à côté',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: companions
                .take(8)
                .map((id) => Chip(
                      label: Text(
                        _label(id),
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.green.shade50,
                      side: BorderSide(color: Colors.green.shade200),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
        ],
        if (companions.isNotEmpty && incompat.isNotEmpty)
          const SizedBox(height: 10),
        if (incompat.isNotEmpty) ...<Widget>[
          Row(
            children: <Widget>[
              const Text('⚠️', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                'À éviter à côté',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: incompat
                .take(8)
                .map((id) => Chip(
                      label: Text(
                        _label(id),
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.red.shade50,
                      side: BorderSide(color: Colors.red.shade200),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}

/// Plant picker en bas d'écran avec :
/// - chips horizontales Favoris / Toutes / [catégories],
/// - filtre saisonnier sur la droite,
/// - cards de plantes draggables (long-press pour démarrer le drag).
