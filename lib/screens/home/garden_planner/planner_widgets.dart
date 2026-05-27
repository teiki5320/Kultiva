import 'package:flutter/material.dart';

import '../../../data/companions.dart';
import '../../../data/regions/france.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/culture_entry.dart';
import '../../../models/garden_plan.dart';
import '../../../models/vegetable.dart';
import '../../../models/weather_data.dart';
import '../../../services/audio_service.dart';
import '../../../services/culture_service.dart';
import '../../../services/prefs_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/companion_status.dart';
import '../../../utils/phenology.dart';
import 'garden_planner_screen.dart';

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
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
              child: c == null ? null : _buildContent(c),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(PlannedCell cell) {
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == cell.vegetableId,
      orElse: () => vegetablesBase.first,
    );
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
                    child: Text(veg.emoji,
                        style: const TextStyle(fontSize: 22)),
                  ),
                )
              : Center(
                  child: Text(veg.emoji,
                      style: const TextStyle(fontSize: 22)),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
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
  const PlannerCellActionSheet({
    super.key,
    required this.cell,
    required this.onCountChanged,
    required this.onPlantedAtChanged,
    required this.onClear,
  });

  @override
  State<PlannerCellActionSheet> createState() =>
      _PlannerCellActionSheetState();
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
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == widget.cell.vegetableId,
      orElse: () => vegetablesBase.first,
    );
    final maxDensity = veg.densityPerSqFt ?? 1;
    // Charge la culture liée si la cellule en a une (créée auto au
    // placement depuis la refonte cohérence avril 2026).
    final cid = widget.cell.cultureId;
    CultureEntry? culture;
    if (cid != null) {
      final matching = CultureService.instance
          .loadAll()
          .where((c) => c.id == cid)
          .toList();
      if (matching.isNotEmpty) culture = matching.first;
    }
    final lastWater =
        culture?.wateredAt.isNotEmpty == true ? culture!.wateredAt.last : null;
    final daysSinceStarted =
        DateTime.now().difference(_plantedAt).inDays;
    final phase = deducedPhase(veg, daysSinceStarted);
    final wateringDays = veg.effectiveWateringDays;
    final wateringColor = _wateringBadgeColor(lastWater, wateringDays);

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
                      errorBuilder: (_, __, ___) => Text(veg.emoji,
                          style: const TextStyle(fontSize: 32)),
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
            InkWell(
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
                    if (veg.watering != null) ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        '👉 ${veg.watering}',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: KultivaColors.textPrimary
                              .withValues(alpha: 0.8),
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
                  onPressed: _count > 1
                      ? () => setState(() => _count--)
                      : null,
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
    final v = vegetablesBase.firstWhere(
      (e) => e.id == id,
      orElse: () => vegetablesBase.first,
    );
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
class PlannerPlantPicker extends StatelessWidget {
  final PlannerSeason season;
  final PickerFilter filter;
  final ValueChanged<PlannerSeason> onSeasonChanged;
  final ValueChanged<PickerFilter> onFilterChanged;
  final void Function(String vegId, int col, int row) onPickedDrop;

  const PlannerPlantPicker({
    super.key,
    required this.season,
    required this.filter,
    required this.onSeasonChanged,
    required this.onFilterChanged,
    required this.onPickedDrop,
  });

  /// Map vegetableId → mois de semis France. Construit une seule fois.
  static final Map<String, Set<int>> _sowingByVegetable = <String, Set<int>>{
    for (final r in franceData) r.vegetableId: r.sowingMonths.toSet(),
  };

  /// Catégories qui ont au moins une plante avec densityPerSqFt.
  /// Ordre : feuilles, fruits, racines, tiges, bulbes, tubercules,
  /// graines, aromates, fleurs.
  static const List<VegetableCategory> _orderedCategories = <VegetableCategory>[
    VegetableCategory.leaves,
    VegetableCategory.fruits,
    VegetableCategory.roots,
    VegetableCategory.stems,
    VegetableCategory.bulbs,
    VegetableCategory.tubers,
    VegetableCategory.seeds,
    VegetableCategory.aromatics,
    VegetableCategory.flowers,
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: PrefsService.instance.favorites,
      builder: (ctx, favs, _) {
        final plants = vegetablesBase.where((v) {
          if (v.category == VegetableCategory.accessories) return false;
          if (v.densityPerSqFt == null) return false;
          // Filtre par catégorie / favoris.
          if (filter is FavoritesFilter && !favs.contains(v.id)) return false;
          if (filter is CategoryFilter &&
              v.category != (filter as CategoryFilter).category) {
            return false;
          }
          // Filtre saison.
          if (season == PlannerSeason.all) return true;
          final months = _sowingByVegetable[v.id];
          if (months == null || months.isEmpty) return false;
          return months.intersection(season.months).isNotEmpty;
        }).toList();
        return _buildPicker(context, plants, favs);
      },
    );
  }

  Widget _buildPicker(
      BuildContext context, List<Vegetable> plants, Set<String> favs) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                'Choisir les plantes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              PopupMenuButton<PlannerSeason>(
                tooltip: 'Filtrer par saison',
                initialValue: season,
                onSelected: onSeasonChanged,
                itemBuilder: (_) => PlannerSeason.values
                    .map((s) => PopupMenuItem<PlannerSeason>(
                          value: s,
                          child: Row(
                            children: <Widget>[
                              Text(s.emoji),
                              const SizedBox(width: 8),
                              Text(s.label),
                            ],
                          ),
                        ))
                    .toList(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      season.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: KultivaColors.primaryGreen,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                      size: 16,
                      color: KultivaColors.primaryGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Chips horizontaux : Favoris / Toutes / catégories.
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _filterChip(const FavoritesFilter(), '⭐'),
                const SizedBox(width: 6),
                _filterChip(const AllFilter(), '🌍'),
                for (final cat in _orderedCategories) ...<Widget>[
                  const SizedBox(width: 6),
                  _filterChip(CategoryFilter(cat), cat.emoji),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: plants.isEmpty
                ? Center(
                    child: Text(
                      filter is FavoritesFilter
                          ? 'Aucun favori. Ajoute des plantes en favori depuis l\'onglet Étal.'
                          : 'Aucune plante dans ce filtre.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: KultivaColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: plants.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => PlannerPlantCard(plant: plants[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(PickerFilter f, String emoji) {
    final selected = f.runtimeType == filter.runtimeType &&
        (f is! CategoryFilter ||
            (filter is CategoryFilter &&
                (filter as CategoryFilter).category == f.category));
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onFilterChanged(f),
      label: Text('$emoji  ${f.label}',
          style: const TextStyle(fontSize: 11)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

/// Banner irrigation affiché au-dessus de la grille.
///
/// Synthétise la météo (température, prévision pluie 7j) et donne un
/// conseil d'arrosage agrégé pour le potager carré. Les conseils sont
/// dérivés du modèle utilisé par WateringAdvisor mais en mode "global"
/// plutôt que par culture (le planificateur agrège plusieurs plants).
/// Bandeau d'irrigation au-dessus de la grille du planificateur. Coupé
/// en 2 (refonte demandée par l'user) : météo à gauche + bouton
/// « Arroser tout » à droite. Le bouton marque arrosé toutes les
/// cellules du jardin qui ont une CultureEntry liée.
class PlannerIrrigationBanner extends StatelessWidget {
  final WeatherData? weather;
  final GardenPlan plan;
  const PlannerIrrigationBanner({
    super.key,
    required this.weather,
    required this.plan,
  });

  /// Liste des cultureIds liés aux cellules du plan (cellules qui ont
  /// été créées via _onPlacePlant après la refonte cohérence).
  List<String> _cultureIdsInPlan() {
    return <String>[
      for (final cell in plan.cells.values)
        if (cell.cultureId != null) cell.cultureId!,
    ];
  }

  Future<void> _waterAll(BuildContext context) async {
    final ids = _cultureIdsInPlan();
    if (ids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun plant à arroser dans ce jardin'),
        ),
      );
      return;
    }
    AudioService.instance.play(Sfx.water);
    for (final id in ids) {
      await CultureService.instance.markWatered(id);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('💧 ${ids.length} plant(s) arrosé(s)'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final advice = _computeAdvice();
    final cultureCount = _cultureIdsInPlan().length;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            advice.color.withValues(alpha: 0.18),
            advice.color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: advice.color.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Row(
        children: <Widget>[
          // ─── Partie gauche : météo + conseil ───
          Expanded(
            child: Row(
              children: <Widget>[
                Text(advice.emoji, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        advice.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        advice.message,
                        style: const TextStyle(
                          fontSize: 11,
                          color: KultivaColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ─── Séparateur vertical ───
          Container(
            width: 1,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: advice.color.withValues(alpha: 0.35),
          ),
          // ─── Partie droite : bouton Arroser (bleu eau) ───
          GestureDetector(
            onTap: cultureCount > 0 ? () => _waterAll(context) : null,
            child: Opacity(
              opacity: cultureCount > 0 ? 1 : 0.45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: KultivaColors.waterBlue,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: KultivaColors.waterBlue
                              .withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Arroser',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.waterBlue,
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

  ({String emoji, String title, String message, Color color}) _computeAdvice() {
    final w = weather;
    if (w == null) {
      return (
        emoji: '💧',
        title: 'Irrigation',
        message: 'Météo en cours de chargement…',
        color: Colors.blue,
      );
    }
    final dailyRain = w.dailyPrecipitation.take(3).fold<double>(0, (s, p) => s + p);
    final maxTempNext3 =
        w.dailyTempMax.take(3).fold<double>(0, (m, t) => t > m ? t : m);

    if (dailyRain >= 5) {
      return (
        emoji: '🌧️',
        title: 'Pluie attendue',
        message: 'Pluie cumulée ~ ${dailyRain.toStringAsFixed(0)} mm sur 3j. '
            'Pas besoin d\'arroser pour l\'instant.',
        color: Colors.blue,
      );
    }
    if (maxTempNext3 >= 28) {
      return (
        emoji: '☀️',
        title: 'Forte chaleur',
        message: 'Pic à ${maxTempNext3.toStringAsFixed(0)} °C prévu. Arrose '
            'tôt le matin ou en fin de journée, pailler les pieds.',
        color: Colors.orange,
      );
    }
    return (
      emoji: '🌤️',
      title: 'Conditions normales',
      message: 'Vérifie tes plants : un sol sec sur 3 cm = il faut arroser.',
      color: KultivaColors.primaryGreen,
    );
  }
}

/// Carte d'une plante draggable depuis le picker.
class PlannerPlantCard extends StatelessWidget {
  final Vegetable plant;
  const PlannerPlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 78,
      decoration: BoxDecoration(
        color: KultivaColors.lightGreen.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: plant.imageAsset != null
                    ? Image.asset(
                        plant.imageAsset!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(plant.emoji,
                              style: const TextStyle(fontSize: 30)),
                        ),
                      )
                    : Center(
                        child: Text(plant.emoji,
                            style: const TextStyle(fontSize: 30)),
                      ),
              ),
              const SizedBox(height: 2),
              Text(
                plant.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if ((plant.densityPerSqFt ?? 1) > 1)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: KultivaColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${plant.densityPerSqFt}x',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    // LongPressDraggable plutôt que Draggable : le tap court permet de
    // scroller horizontalement le picker, l'appui long déclenche le drag.
    return LongPressDraggable<String>(
      data: plant.id,
      delay: const Duration(milliseconds: 200),
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(width: 78, height: 78, child: card),
      ),
      childWhenDragging:
          Opacity(opacity: 0.35, child: SizedBox(width: 78, child: card)),
      child: card,
    );
  }
}

/// Sheet d'aide / tutoriel inspiré des screenshots utilisateur.
class PlannerTipsSheet extends StatelessWidget {
  const PlannerTipsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Comment utiliser le planificateur',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const PlannerTipStep(
              n: 1,
              text:
                  "Glisse une plante depuis la barre du bas vers une case de la grille pour la planter.",
            ),
            const PlannerTipStep(
              n: 2,
              text:
                  "Touche une case occupée pour voir les détails ou la vider.",
            ),
            const PlannerTipStep(
              n: 3,
              text:
                  "Le chiffre indique le nombre de plants qui tiennent dans une case (ex. 9 carottes par 30×30 cm).",
            ),
            const PlannerTipStep(
              n: 4,
              text:
                  "Anneau vert autour d'une case = plantes compagnes voisines, anneau rouge = à séparer.",
            ),
            const PlannerTipStep(
              n: 5,
              text:
                  "Chaque case mesure 1×1 pied (≈ 30×30 cm). Configure la taille de ton jardin via « Configurer ».",
            ),
          ],
        );
      },
    );
  }
}

class PlannerTipStep extends StatelessWidget {
  final int n;
  final String text;
  const PlannerTipStep({super.key, required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: KultivaColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$n',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
