import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/phenology.dart';
import '../poussidex/plantation_sheet.dart';

/// Les plants en terre, avec leur âge, leur étape et leur soif.
///
/// Le cahier ne listait que des jardins. Pour voir un plant il fallait
/// ouvrir un jardin, viser sa case sur la grille et la tapoter — et
/// les plants ajoutés depuis une fiche légume (« Je l'ai planté »)
/// n'apparaissaient nulle part dans le cahier. La liste rassemble les
/// deux, et ouvre le même dossier que le Poussidex.
class CahierPlantsSection extends StatefulWidget {
  const CahierPlantsSection({super.key});

  @override
  State<CahierPlantsSection> createState() => _CahierPlantsSectionState();
}

class _CahierPlantsSectionState extends State<CahierPlantsSection> {
  /// Au-delà, la liste noie le reste du cahier.
  static const int _apercu = 6;

  bool _tout = false;

  @override
  void initState() {
    super.initState();
    PlantationService.instance.addListener(_onChanged);
  }

  @override
  void dispose() {
    PlantationService.instance.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final actifs = PlantationService.instance.active;
    if (actifs.isEmpty) return const SizedBox.shrink();
    final visibles = _tout ? actifs : actifs.take(_apercu).toList();
    final reste = actifs.length - visibles.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
          child: Text(
            'Au jardin en ce moment  ·  ${actifs.length}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
        for (final p in visibles)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _PlantRow(plantation: p),
          ),
        if (reste > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              onPressed: () => setState(() => _tout = true),
              style: TextButton.styleFrom(
                foregroundColor: KultivaColors.primaryGreen,
              ),
              child: Text('Voir les $reste autres'),
            ),
          ),
      ],
    );
  }
}

class _PlantRow extends StatelessWidget {
  final Plantation plantation;
  const _PlantRow({required this.plantation});

  /// « il y a 3 jours », « aujourd'hui », « hier ».
  static String _ilYA(int jours) {
    if (jours <= 0) return "aujourd'hui";
    if (jours == 1) return 'hier';
    return 'il y a $jours j';
  }

  @override
  Widget build(BuildContext context) {
    final veg = vegetablesBase
        .where((v) => v.id == plantation.vegetableId)
        .firstOrNull;
    // Un plant dont l'espèce a disparu du catalogue : on ne montre pas
    // une tomate à sa place.
    if (veg == null) return const SizedBox.shrink();

    final jours = DateTime.now().difference(plantation.plantedAt).inDays;
    final etape = expectedStage(veg, jours);
    final dernierArrosage = plantation.wateredAt.isEmpty
        ? null
        : DateTime.now().difference(plantation.wateredAt.last).inDays;

    final details = <String>[
      'planté ${_ilYA(jours)}',
      if (etape != null) etape.label.toLowerCase(),
      dernierArrosage == null
          ? 'jamais arrosé'
          : 'arrosé ${_ilYA(dernierArrosage)}',
    ].join('  ·  ');

    return Semantics(
      label: '${veg.name}, $details',
      hint: 'Ouvre le dossier de ce plant',
      button: true,
      excludeSemantics: true,
      child: InkWell(
        onTap: () => showPlantationSheet(context, plantation, veg),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: veg.category.familyColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(etape?.emoji ?? veg.emoji,
                    style: const TextStyle(fontSize: 17)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      veg.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      details,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  size: 18, color: KultivaColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
