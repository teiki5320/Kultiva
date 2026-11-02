/// Conseils affichés sous un plant du potager carré : étape de
/// croissance déduite, et compagnonnage avec les cases voisines.
///
/// Extrait de `planner_widgets.dart`, qui faisait 1 339 lignes.
library;

import 'package:flutter/material.dart';

import '../../../data/companions.dart';
import '../../../data/names_en.dart';
import '../../../data/ui_i18n.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/culture_entry.dart';
import '../../../models/vegetable.dart';
import '../../../services/advice_service.dart';
import '../../../services/culture_service.dart';
import '../../../utils/rotation_advisor.dart';
import '../../../theme/app_theme.dart';

class PlannerPhaseAdviceTile extends StatelessWidget {
  final Vegetable veg;
  final GrowthPhase phase;

  const PlannerPhaseAdviceTile({
    super.key,
    required this.veg,
    required this.phase,
  });


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
                Text(
                  trUi('Conseil pour ce stade'),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7A5A1E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AdviceService.phaseAdvice(veg, phase),
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
    return '${v.emoji} ${v.displayName}';
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
                trUi('À planter à côté'),
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
                trUi('À éviter à côté'),
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

/// Avertissement de rotation des cultures.
///
/// `lib/utils/rotation_advisor.dart` existait depuis le chantier v5 et
/// n'était importé par aucun fichier : la fiche App Store, la landing
/// et CLAUDE.md promettaient tous les trois un « avertissement de
/// rotation » que l'app ne donnait nulle part. La fiche légume montre
/// bien une section « 🔄 Rotation des cultures », mais c'est le
/// conseil générique du livre, pas un avertissement sur ce que
/// l'utilisateur a réellement cultivé.
///
/// N'affiche rien quand il n'y a rien à dire — c'est le cas courant.
class PlannerRotationWarning extends StatelessWidget {
  final String vegetableId;

  /// La culture de la case elle-même, à ne pas confondre avec son
  /// propre passé.
  final String? currentCultureId;

  const PlannerRotationWarning({
    super.key,
    required this.vegetableId,
    this.currentCultureId,
  });

  @override
  Widget build(BuildContext context) {
    // Seules les cultures closes comptent : la rotation parle de ce
    // qui a occupé la terre avant, pas de ce qui y pousse aujourd'hui.
    final passees = CultureService.instance
        .ended()
        .where((c) => c.id != currentCultureId)
        .toList();
    final avertissement = checkRotation(
      vegetableId: vegetableId,
      previousCultures: passees,
    );
    if (avertissement == null) return const SizedBox.shrink();

    return Padding(
      // L'espacement vit ici plutôt qu'entre les deux blocs : sinon
      // le cas courant, où rien ne s'affiche, laisse un trou.
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        label: trUiArgs('Attention à la rotation. {0}',
            <Object?>[avertissement.message]),
        excludeSemantics: true,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: KultivaColors.terracotta.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: KultivaColors.terracotta.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('🔄', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trUi('Attention à la rotation'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      avertissement.message,
                      style: const TextStyle(fontSize: 12, height: 1.35),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
