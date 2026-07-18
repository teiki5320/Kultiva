import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/garden_plan.dart';
import '../../../models/region_data.dart';
import '../../../models/vegetable.dart';
import '../../../models/weather_data.dart';
import '../../../services/culture_service.dart';
import '../../../services/garden_plan_service.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/companion_status.dart';
import '../garden_plan_config_sheet.dart';
import 'planner_widgets.dart';

/// Filtre actif sur le plant picker. Reflète le pattern Étal :
/// favoris / tous / par catégorie.
sealed class PickerFilter {
  const PickerFilter();
  String get label;
}

class FavoritesFilter extends PickerFilter {
  const FavoritesFilter();
  @override
  String get label => 'Favoris';
}

class AllFilter extends PickerFilter {
  const AllFilter();
  @override
  String get label => 'Toutes';
}

class CategoryFilter extends PickerFilter {
  final VegetableCategory category;
  const CategoryFilter(this.category);
  @override
  String get label => category.label;
}

/// Saison utilisée pour filtrer le plant picker.
///
/// Les quatre saisons européennes servent en France ; l'Afrique de
/// l'Ouest filtre sur saison sèche / hivernage.
enum PlannerSeason {
  all,
  spring,
  summer,
  autumn,
  winter,
  dry,
  rains;

  /// Saisons proposées dans le filtre selon la région active.
  static List<PlannerSeason> optionsFor(Region region) {
    if (region == Region.westAfrica) {
      return const <PlannerSeason>[
        PlannerSeason.all,
        PlannerSeason.dry,
        PlannerSeason.rains,
      ];
    }
    return const <PlannerSeason>[
      PlannerSeason.all,
      PlannerSeason.spring,
      PlannerSeason.summer,
      PlannerSeason.autumn,
      PlannerSeason.winter,
    ];
  }

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
      case PlannerSeason.dry:
        return 'Saison sèche';
      case PlannerSeason.rains:
        return 'Hivernage';
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
      case PlannerSeason.dry:
        return '☀️';
      case PlannerSeason.rains:
        return '🌧️';
    }
  }

  /// Mois (1-12) couverts par cette saison.
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
      case PlannerSeason.dry:
        return const <int>{11, 12, 1, 2, 3, 4, 5};
      case PlannerSeason.rains:
        return const <int>{6, 7, 8, 9, 10};
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

  const GardenPlannerScreen({
    super.key,
    this.initialPlan,
  });

  @override
  State<GardenPlannerScreen> createState() => _GardenPlannerScreenState();
}

class _GardenPlannerScreenState extends State<GardenPlannerScreen> {
  GardenPlan? _plan;
  bool _dirty = false;
  PlannerSeason _season = PlannerSeason.all;
  PickerFilter _filter = const FavoritesFilter();
  WeatherData? _weather;

  @override
  void initState() {
    super.initState();
    _plan = widget.initialPlan;
    _loadWeather();
    if (_plan == null) {
      // Au premier frame, on ouvre le modal de création (pleine terre).
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final created = await showModalBottomSheet<GardenPlan>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => const GardenPlanConfigSheet(),
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
            // Banner irrigation (visible si grille non vide).
            if (plan.cells.isNotEmpty)
              PlannerIrrigationBanner(weather: _weather, plan: plan),
            // Grille élastique, prend tout l'espace dispo.
            Expanded(child: _buildGrid(plan)),
            // Plant picker fixé en bas.
            PlannerPlantPicker(
              season: _season,
              filter: _filter,
              onSeasonChanged: (s) => setState(() => _season = s),
              onFilterChanged: (f) => setState(() => _filter = f),
              onPickedDrop: (vegId, col, row) =>
                  _onPlacePlant(vegId, col, row),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadWeather() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weather = w);
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
                        PlannerGridCell(
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

  Future<void> _onPlacePlant(String vegId, int col, int row) async {
    final plan = _plan;
    if (plan == null) return;
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == vegId,
      orElse: () => vegetablesBase.first,
    );
    final density = veg.densityPerSqFt ?? 1;
    final plantedAt = DateTime.now();

    // Refonte cohérence avril 2026 : on crée AUSSI une CultureEntry
    // trackable pour suivre ce plant (phase, observations, photos…).
    // L'id de la culture est stocké dans la cellule via cultureId.
    final culture = await CultureService.instance.add(
      vegetableId: vegId,
      startedAt: plantedAt,
    );

    final cell = PlannedCell(
      col: col,
      row: row,
      vegetableId: vegId,
      count: density,
      plantedAt: plantedAt,
      cultureId: culture.id,
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
      isScrollControlled: true,
      builder: (_) => PlannerCellActionSheet(
        cell: cell,
        onCountChanged: (newCount) {
          setState(() {
            _plan = plan.withCell(col, row, cell.copyWith(count: newCount));
            _dirty = true;
          });
        },
        onPlantedAtChanged: (newDate) async {
          // Met à jour la cellule avec la nouvelle date.
          final fresh = plan.cellAt(col, row);
          if (fresh == null) return;
          setState(() {
            _plan = plan.withCell(
              col,
              row,
              fresh.copyWith(plantedAt: newDate),
            );
            _dirty = true;
          });
          // Synchronise la culture liée pour que la phase déduite
          // soit cohérente partout (sheet de mesures, etc.).
          final cid = fresh.cultureId;
          if (cid == null) return;
          final cultures = CultureService.instance.loadAll();
          final existing = cultures.firstWhere(
            (c) => c.id == cid,
            orElse: () => cultures.first,
          );
          if (existing.id == cid) {
            await CultureService.instance.update(
              existing.copyWith(startedAt: newDate),
            );
          }
        },
        onClear: () async {
          Navigator.of(context).pop();
          // Refonte cohérence : si la cellule a une culture liée
          // (créée auto au placement), on la supprime avec.
          if (cell.cultureId != null) {
            await CultureService.instance.remove(cell.cultureId!);
          }
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
      builder: (_) => const PlannerTipsSheet(),
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
