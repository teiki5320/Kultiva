import 'package:flutter/material.dart';

import '../../data/companions.dart';
import '../../data/regions/france.dart';
import '../../data/vegetables_base.dart';
import '../../models/garden_plan.dart';
import '../../models/vegetable.dart';
import '../../services/garden_plan_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/companion_status.dart';
import 'garden_plan_config_sheet.dart';
import 'hydro_system_picker_sheet.dart';

/// Saison utilisée pour filtrer le plant picker.
enum PlannerSeason {
  all,
  spring,
  summer,
  autumn,
  winter;

  String get label {
    switch (this) {
      case PlannerSeason.all:
        return "Toute l'année";
      case PlannerSeason.spring:
        return 'Printemps';
      case PlannerSeason.summer:
        return 'Été';
      case PlannerSeason.autumn:
        return 'Automne';
      case PlannerSeason.winter:
        return 'Hiver';
    }
  }

  String get emoji {
    switch (this) {
      case PlannerSeason.all:
        return '🗓️';
      case PlannerSeason.spring:
        return '🌸';
      case PlannerSeason.summer:
        return '☀️';
      case PlannerSeason.autumn:
        return '🍂';
      case PlannerSeason.winter:
        return '❄️';
    }
  }

  /// Mois (1-12) couverts par cette saison dans l'hémisphère nord.
  Set<int> get months {
    switch (this) {
      case PlannerSeason.all:
        return const <int>{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
      case PlannerSeason.spring:
        return const <int>{3, 4, 5};
      case PlannerSeason.summer:
        return const <int>{6, 7, 8};
      case PlannerSeason.autumn:
        return const <int>{9, 10, 11};
      case PlannerSeason.winter:
        return const <int>{12, 1, 2};
    }
  }
}

/// Écran principal du planificateur de potager carré.
///
/// Inspiré de l'app référence (capture utilisateur) :
/// - grille 30×30 cm en haut, plant picker scrollable en bas,
/// - drag-and-drop d'un plant du picker vers une case,
/// - tap sur une case occupée pour la vider.
///
/// L'écran charge un [GardenPlan] existant ou en crée un nouveau via
/// [GardenPlanConfigSheet] si aucun plan n'est sélectionné.
class GardenPlannerScreen extends StatefulWidget {
  /// Plan à éditer. Si null, on en crée un nouveau au premier rendu.
  final GardenPlan? initialPlan;

  /// Si vrai et `initialPlan` est null, on ouvre le sélecteur de système
  /// hydroponique au lieu du config sheet pleine terre.
  final bool hydroMode;

  const GardenPlannerScreen({
    super.key,
    this.initialPlan,
    this.hydroMode = false,
  });

  @override
  State<GardenPlannerScreen> createState() => _GardenPlannerScreenState();
}

class _GardenPlannerScreenState extends State<GardenPlannerScreen> {
  GardenPlan? _plan;
  bool _dirty = false;
  PlannerSeason _season = PlannerSeason.all;

  @override
  void initState() {
    super.initState();
    _plan = widget.initialPlan;
    if (_plan == null) {
      // Au premier frame, on ouvre le modal de création approprié.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final created = await showModalBottomSheet<GardenPlan>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => widget.hydroMode
              ? const HydroSystemPickerSheet()
              : const GardenPlanConfigSheet(),
        );
        if (!mounted) return;
        if (created == null) {
          Navigator.of(context).pop();
        } else {
          setState(() => _plan = created);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final plan = _plan;
    if (plan == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: _onCancel,
          style: TextButton.styleFrom(
            foregroundColor: KultivaColors.primaryGreen,
          ),
          child: const Text('Annuler'),
        ),
        leadingWidth: 90,
        title: Text(
          plan.name,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: KultivaColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: _dirty ? _onSave : null,
              child: const Text(
                'Sauvegarder',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Barre Configurer / Conseils.
            _buildToolBar(),
            // Grille élastique, prend tout l'espace dispo.
            Expanded(child: _buildGrid(plan)),
            // Plant picker fixé en bas.
            _PlantPicker(
              season: _season,
              hydroOnly: plan.isHydroponic,
              onSeasonChanged: (s) => setState(() => _season = s),
              onPickedDrop: (vegId, col, row) =>
                  _onPlacePlant(vegId, col, row),
            ),
          ],
        ),
      ),
    );
  }

  int get _totalPlants {
    final plan = _plan;
    if (plan == null) return 0;
    return plan.cells.values.fold<int>(0, (sum, c) => sum + c.count);
  }

  Widget _buildToolBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          TextButton.icon(
            onPressed: _openConfig,
            icon: const Icon(Icons.dashboard_customize, size: 18),
            label: const Text('Configurer'),
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.textPrimary,
            ),
          ),
          const Spacer(),
          if (_totalPlants > 0) ...<Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: KultivaColors.lightGreen.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '🌱 $_totalPlants plant${_totalPlants > 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          TextButton.icon(
            onPressed: _showTips,
            icon: const Icon(Icons.help_outline, size: 18),
            label: const Text('Conseils'),
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Récupère les IDs des plantes voisines (haut/bas/gauche/droite) d'une case.
  Iterable<String> _neighborsOf(GardenPlan plan, int col, int row) sync* {
    for (final pair in const <List<int>>[
      [0, -1],
      [0, 1],
      [-1, 0],
      [1, 0],
    ]) {
      final n = plan.cellAt(col + pair[0], row + pair[1]);
      if (n != null) yield n.vegetableId;
    }
  }

  Widget _buildGrid(GardenPlan plan) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // On veut des cases carrées qui rentrent dans l'espace dispo.
        const padding = 16.0;
        const gap = 4.0;
        final availW = constraints.maxWidth - padding * 2;
        final availH = constraints.maxHeight - padding * 2;
        final cellW = (availW - gap * (plan.cols - 1)) / plan.cols;
        final cellH = (availH - gap * (plan.rows - 1)) / plan.rows;
        final cellSize = cellW < cellH ? cellW : cellH;

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int r = 0; r < plan.rows; r++) ...<Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (int c = 0; c < plan.cols; c++) ...<Widget>[
                        _GridCell(
                          size: cellSize,
                          col: c,
                          row: r,
                          cell: plan.cellAt(c, r),
                          status: plan.cellAt(c, r) == null
                              ? CompanionStatus.neutral
                              : statusFor(
                                  vegetableId:
                                      plan.cellAt(c, r)!.vegetableId,
                                  neighbors: _neighborsOf(plan, c, r),
                                ),
                          onAccept: (vegId) => _onPlacePlant(vegId, c, r),
                          onTap: () => _onTapCell(c, r),
                        ),
                        if (c < plan.cols - 1) const SizedBox(width: gap),
                      ],
                    ],
                  ),
                  if (r < plan.rows - 1) const SizedBox(height: gap),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPlacePlant(String vegId, int col, int row) {
    final plan = _plan;
    if (plan == null) return;
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == vegId,
      orElse: () => vegetablesBase.first,
    );
    final density = veg.densityPerSqFt ?? 1;
    final cell = PlannedCell(
      col: col,
      row: row,
      vegetableId: vegId,
      count: density,
      plantedAt: DateTime.now(),
    );
    setState(() {
      _plan = plan.withCell(col, row, cell);
      _dirty = true;
    });
  }

  void _onTapCell(int col, int row) {
    final plan = _plan;
    if (plan == null) return;
    final cell = plan.cellAt(col, row);
    if (cell == null) return;
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _CellActionSheet(
        cell: cell,
        onCountChanged: (newCount) {
          setState(() {
            _plan = plan.withCell(col, row, cell.copyWith(count: newCount));
            _dirty = true;
          });
        },
        onClear: () {
          Navigator.of(context).pop();
          setState(() {
            _plan = plan.withCell(col, row, null);
            _dirty = true;
          });
        },
      ),
    );
  }

  Future<void> _openConfig() async {
    final updated = await showModalBottomSheet<GardenPlan>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => GardenPlanConfigSheet(existing: _plan),
    );
    if (updated != null && mounted) {
      setState(() {
        _plan = updated;
        _dirty = true;
      });
    }
  }

  void _showTips() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _TipsSheet(),
    );
  }

  Future<void> _onCancel() async {
    if (!_dirty) {
      Navigator.of(context).pop();
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quitter sans sauvegarder ?'),
        content: const Text('Tes modifications seront perdues.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continuer l\'édition'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Quitter'),
          ),
        ],
      ),
    );
    if (discard == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _onSave() async {
    final plan = _plan;
    if (plan == null) return;
    await GardenPlanService.instance.save(plan);
    if (!mounted) return;
    setState(() => _dirty = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jardin sauvegardé 🌱')),
    );
  }
}

/// Une case de la grille. Accepte les drops du plant picker.
class _GridCell extends StatelessWidget {
  final double size;
  final int col;
  final int row;
  final PlannedCell? cell;
  final CompanionStatus status;
  final ValueChanged<String> onAccept;
  final VoidCallback onTap;

  const _GridCell({
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
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: hovering
                  ? KultivaColors.primaryGreen.withValues(alpha: 0.35)
                  : KultivaColors.lightGreen.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(6),
              border: hovering
                  ? Border.all(
                      color: KultivaColors.primaryGreen,
                      width: 2,
                    )
                  : (c != null && status != CompanionStatus.neutral
                      ? Border.all(color: _ringColor, width: 2)
                      : null),
            ),
            child: c == null ? null : _buildContent(c),
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
class _CellActionSheet extends StatefulWidget {
  final PlannedCell cell;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onClear;
  const _CellActionSheet({
    required this.cell,
    required this.onCountChanged,
    required this.onClear,
  });

  @override
  State<_CellActionSheet> createState() => _CellActionSheetState();
}

class _CellActionSheetState extends State<_CellActionSheet> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.cell.count;
  }

  @override
  Widget build(BuildContext context) {
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == widget.cell.vegetableId,
      orElse: () => vegetablesBase.first,
    );
    final maxDensity = veg.densityPerSqFt ?? 1;
    return SafeArea(
      child: Padding(
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
            const SizedBox(height: 14),
            Text(
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
              style: TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            _CompanionInfo(vegetableId: widget.cell.vegetableId),
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

/// Affiche la liste des compagnes et incompatibles d'un légume.
class _CompanionInfo extends StatelessWidget {
  final String vegetableId;
  const _CompanionInfo({required this.vegetableId});

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

/// Plant picker en bas d'écran. Filtre les plantes avec densityPerSqFt
/// renseigné (les vivaces / arbres ne s'inscrivent pas dans la grille).
/// Filtre additionnellement par saison via les `sowingMonths` du
/// `RegionData` français, et par `hydroFriendly` en mode hydro.
class _PlantPicker extends StatelessWidget {
  final PlannerSeason season;
  final bool hydroOnly;
  final ValueChanged<PlannerSeason> onSeasonChanged;
  final void Function(String vegId, int col, int row) onPickedDrop;

  const _PlantPicker({
    required this.season,
    required this.hydroOnly,
    required this.onSeasonChanged,
    required this.onPickedDrop,
  });

  /// Map vegetableId → mois de semis France. Construit une seule fois.
  static final Map<String, Set<int>> _sowingByVegetable = <String, Set<int>>{
    for (final r in franceData) r.vegetableId: r.sowingMonths.toSet(),
  };

  @override
  Widget build(BuildContext context) {
    final plants = vegetablesBase.where((v) {
      if (v.category == VegetableCategory.accessories) return false;
      if (v.densityPerSqFt == null) return false;
      if (hydroOnly && !v.hydroFriendly) return false;
      if (season == PlannerSeason.all) return true;
      final months = _sowingByVegetable[v.id];
      if (months == null || months.isEmpty) return false;
      return months.intersection(season.months).isNotEmpty;
    }).toList();
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
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: KultivaColors.primaryGreen,
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      size: 16,
                      color: KultivaColors.primaryGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: plants.isEmpty
                ? Center(
                    child: Text(
                      'Aucune plante semable en ${season.label.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: plants.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => _PlantCard(plant: plants[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Carte d'une plante draggable depuis le picker.
class _PlantCard extends StatelessWidget {
  final Vegetable plant;
  const _PlantCard({required this.plant});

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

    return Draggable<String>(
      data: plant.id,
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
class _TipsSheet extends StatelessWidget {
  const _TipsSheet();

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
            _TipStep(
              n: 1,
              text:
                  "Glisse une plante depuis la barre du bas vers une case de la grille pour la planter.",
            ),
            _TipStep(
              n: 2,
              text:
                  "Touche une case occupée pour voir les détails ou la vider.",
            ),
            _TipStep(
              n: 3,
              text:
                  "Le chiffre indique le nombre de plants qui tiennent dans une case (ex. 9 carottes par 30×30 cm).",
            ),
            _TipStep(
              n: 4,
              text:
                  "Bientôt : anneaux verts pour les compagnes, rouges pour les combatives.",
            ),
            _TipStep(
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

class _TipStep extends StatelessWidget {
  final int n;
  final String text;
  const _TipStep({required this.n, required this.text});

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
            decoration: BoxDecoration(
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
