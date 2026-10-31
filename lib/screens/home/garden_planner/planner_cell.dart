/// Une case du potager carré : la tuile de la grille, et la feuille
/// qui s'ouvre quand on tape dessus (arrosage, densité, date, conseil).
///
/// Extrait de `planner_widgets.dart`, qui faisait 1 339 lignes.
library;

import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/culture_entry.dart';
import '../../../models/garden_plan.dart';
import '../../../models/weather_data.dart';
import '../../../services/audio_service.dart';
import '../../../services/culture_service.dart';
import '../../../services/prefs_service.dart';
import '../../../services/watering_advisor.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/companion_status.dart';
import '../../../utils/phenology.dart';
import 'planner_advice.dart';

/// Une case de la grille. Accepte les drops du plant picker.
class PlannerGridCell extends StatelessWidget {
  final double size;
  final int col;
  final int row;
  final PlannedCell? cell;
  final CompanionStatus status;
  final ValueChanged<String> onAccept;
  final VoidCallback onTap;

  const PlannerGridCell({
    super.key,
    required this.size,
    required this.col,
    required this.row,
    required this.cell,
    required this.status,
    required this.onAccept,
    required this.onTap,
  });

  Color get _ringColor {
    switch (status) {
      case CompanionStatus.good:
        return Colors.green.shade600;
      case CompanionStatus.bad:
        return Colors.red.shade400;
      case CompanionStatus.neutral:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidates, rejects) {
        final hovering = candidates.isNotEmpty;
        final c = cell;
        // Style kawaii : gradient pastel, coins arrondis 14, ombre douce.
        final baseGradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: hovering
              ? <Color>[
                  KultivaColors.primaryGreen.withValues(alpha: 0.55),
                  KultivaColors.primaryGreen.withValues(alpha: 0.30),
                ]
              : <Color>[
                  KultivaColors.lightGreen.withValues(alpha: 0.55),
                  KultivaColors.lightGreen.withValues(alpha: 0.30),
                ],
        );
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: baseGradient,
            borderRadius: BorderRadius.circular(14),
            border: hovering
                ? Border.all(
                    color: KultivaColors.primaryGreen,
                    width: 2.5,
                  )
                : (c != null && status != CompanionStatus.neutral
                    ? Border.all(color: _ringColor, width: 2.5)
                    : Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1,
                      )),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: KultivaColors.primaryGreen.withValues(alpha: 0.10),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Semantics(
              label: c == null
                  ? 'Case vide'
                  : 'Case plantée : ${vegetableById(c.vegetableId).name}',
              hint: c == null ? 'Poser un plant' : 'Ouvrir la fiche du plant',
              button: true,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onTap,
                child: c == null ? null : _buildContent(c),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(PlannedCell cell) {
    final veg = vegetableById(cell.vegetableId);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: veg.imageAsset != null
              ? Image.asset(
                  veg.imageAsset!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(
                    child:
                        Text(veg.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                )
              : Center(
                  child: Text(veg.emoji, style: const TextStyle(fontSize: 22)),
                ),
        ),
        if (status == CompanionStatus.good)
          const Positioned(
            top: 2,
            left: 2,
            child: Text('👍', style: TextStyle(fontSize: 12)),
          )
        else if (status == CompanionStatus.bad)
          const Positioned(
            top: 2,
            left: 2,
            child: Text('⚠️', style: TextStyle(fontSize: 12)),
          ),
        if (cell.count > 1)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${cell.count}x',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Bottom-sheet avec actions sur une case occupée :
/// ajuster le nombre de plants, ouvrir la fiche détail, ou vider.
class PlannerCellActionSheet extends StatefulWidget {
  final PlannedCell cell;
  final ValueChanged<int> onCountChanged;
  final ValueChanged<DateTime> onPlantedAtChanged;
  final VoidCallback onClear;

  /// Météo du jardin, pour le conseil d'arrosage du plant. Null tant
  /// qu'elle n'est pas chargée (ou si la localisation est refusée) : le
  /// conseil est alors simplement masqué.
  final WeatherData? weather;

  const PlannerCellActionSheet({
    super.key,
    required this.cell,
    required this.onCountChanged,
    required this.onPlantedAtChanged,
    required this.onClear,
    this.weather,
  });

  @override
  State<PlannerCellActionSheet> createState() => _PlannerCellActionSheetState();
}

class _PlannerCellActionSheetState extends State<PlannerCellActionSheet> {
  late int _count;
  late DateTime _plantedAt;

  @override
  void initState() {
    super.initState();
    _count = widget.cell.count;
    _plantedAt = widget.cell.plantedAt;
  }

  String _formatPlantedAt(DateTime when) {
    final days = DateTime.now().difference(when).inDays;
    final dateStr =
        '${when.day.toString().padLeft(2, '0')}/${when.month.toString().padLeft(2, '0')}/${when.year}';
    if (days == 0) return 'Planté aujourd\'hui ($dateStr)';
    if (days == 1) return 'Planté hier ($dateStr)';
    return 'Planté il y a $days jours ($dateStr)';
  }

  /// Date dernier arrosage formatée pour l'utilisateur (ou message
  /// d'invitation si jamais).
  String _formatLastWatering(DateTime? when) {
    if (when == null) return 'Pas encore arrosé';
    final days = DateTime.now().difference(when).inDays;
    if (days == 0) return 'Arrosé aujourd\'hui';
    if (days == 1) return 'Arrosé hier';
    return 'Arrosé il y a $days jours';
  }

  /// Couleur du badge arrosage : vert si récent (≤ seuil), orange si à
  /// la limite, rouge si dépassé. Seuil dérivé de Vegetable.watering.
  Color _wateringBadgeColor(DateTime? lastWater, int thresholdDays) {
    if (lastWater == null) return const Color(0xFFE8A87C);
    final days = DateTime.now().difference(lastWater).inDays;
    if (days <= thresholdDays - 1) return KultivaColors.primaryGreen;
    if (days <= thresholdDays) return const Color(0xFFE8A87C);
    return const Color(0xFFD4564A);
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _plantedAt,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
      helpText: 'Date de plantation',
      cancelText: 'Annuler',
      confirmText: 'OK',
      locale: const Locale('fr', 'FR'),
    );
    if (picked == null) return;
    setState(() => _plantedAt = picked);
    widget.onPlantedAtChanged(picked);
  }

  Future<void> _markWatered() async {
    final cid = widget.cell.cultureId;
    if (cid == null) return;
    AudioService.instance.play(Sfx.water);
    await CultureService.instance.markWatered(cid);
    if (mounted) {
      setState(() {}); // Refresh badge
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('💧 Arrosage enregistré'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final veg = vegetableById(widget.cell.vegetableId);
    final maxDensity = veg.densityPerSqFt ?? 1;
    // Charge la culture liée si la cellule en a une (créée auto au
    // placement depuis la refonte cohérence avril 2026).
    final cid = widget.cell.cultureId;
    CultureEntry? culture;
    if (cid != null) {
      final matching =
          CultureService.instance.loadAll().where((c) => c.id == cid).toList();
      if (matching.isNotEmpty) culture = matching.first;
    }
    // Les arrosages vivent dans le dossier du plant depuis le
    // rattachement du 30/10/2026 : on passe par le service, qui sait
    // aussi relire les anciennes sauvegardes.
    final lastWater = culture == null
        ? null
        : CultureService.instance.lastWateringFor(culture);
    final daysSinceStarted = DateTime.now().difference(_plantedAt).inDays;
    final phase = deducedPhase(veg, daysSinceStarted);
    final wateringDays = veg.effectiveWateringDays;
    final wateringColor = _wateringBadgeColor(lastWater, wateringDays);
    // Conseil d'arrosage du jour pour CE plant : croise son dernier
    // arrosage, la pluie tombée, la pluie prévue et le seuil de
    // canicule de la région.
    final advice = suggestWatering(
      lastWater,
      widget.weather,
      region: PrefsService.instance.region.value,
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (veg.imageAsset != null)
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.asset(
                      veg.imageAsset!,
                      errorBuilder: (_, __, ___) =>
                          Text(veg.emoji, style: const TextStyle(fontSize: 32)),
                    ),
                  )
                else
                  Text(veg.emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    veg.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ─── Date de plantation (modifiable) ──────────────────
            Semantics(
              label: 'Date de plantation',
              hint: 'Choisir une autre date',
              button: true,
              child: InkWell(
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: KultivaColors.lightGreen.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: KultivaColors.lightGreen.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Text('🌱', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _formatPlantedAt(_plantedAt),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Stade : ${phase.emoji} ${phase.label}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: KultivaColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit_calendar_outlined, size: 18),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── Bloc Arrosage ────────────────────────────────────
            if (cid != null) ...<Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                decoration: BoxDecoration(
                  color: wateringColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: wateringColor.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('💧', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _formatLastWatering(lastWater),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: wateringColor,
                            ),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: _markWatered,
                          icon: const Icon(Icons.water_drop, size: 16),
                          label: const Text('Arroser'),
                          style: FilledButton.styleFrom(
                            backgroundColor: KultivaColors.waterBlue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Conseil du jour, calculé sur la météo réelle. Il
                    // passe AVANT le conseil générique de la fiche :
                    // « saute l'arrosage, il a plu » est plus utile que
                    // « arrose régulièrement ».
                    if (advice != null) ...<Widget>[
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(advice.emoji,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              advice.message,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.35,
                                fontWeight: FontWeight.w700,
                                color: KultivaColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (veg.watering != null) ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        '👉 ${veg.watering}',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color:
                              KultivaColors.textPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                    Text(
                      'Fréquence indicative : tous les $wateringDays jours '
                      'environ (selon météo).',
                      style: const TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // ─── Conseils selon phase ─────────────────────────────
            PlannerPhaseAdviceTile(veg: veg, phase: phase),
            const SizedBox(height: 12),
            PlannerRotationWarning(
              vegetableId: widget.cell.vegetableId,
              currentCultureId: widget.cell.cultureId,
            ),

            // ─── Densité plants par case ──────────────────────────
            const Text(
              "Combien de plants dans cette case ?",
              style: TextStyle(
                fontSize: 13,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                IconButton.filledTonal(
                  onPressed: _count > 1 ? () => setState(() => _count--) : null,
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '$_count / $maxDensity',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: _count < maxDensity
                      ? () => setState(() => _count++)
                      : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Maximum recommandé : $maxDensity plants par case (30×30 cm)',
              style: const TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            PlannerCompanionInfo(vegetableId: widget.cell.vegetableId),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onClear,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Vider'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: KultivaColors.primaryGreen,
                    ),
                    onPressed: () {
                      widget.onCountChanged(_count);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tile de conseil contextuel selon la phase du plant. Donne une
/// action concrète (« pince les gourmands », « apporte du compost »…).
