import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/badges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/audio_service.dart';
import '../../services/photo_service.dart';
import '../../services/plantation_migration.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/category_colors.dart';
import '../../widgets/garden_tutorial_sheet.dart';
import 'poussidex/plantation_detail_sheet.dart';
import 'poussidex/poussidex_badges.dart';
import 'poussidex/poussidex_card.dart';
import 'poussidex/poussidex_journal.dart';
import 'poussidex/poussidex_stats.dart';
import 'poussidex/vegetable_picker_sheet.dart';

/// Filtre actif dans le Poussidex.
enum _AlbumFilter { all, growing, harvested, badges, stats, journal }

/// Poussidex — album de collection des légumes plantés.
///
/// Remplace l'ancienne grille 2D par une liste chronologique de
/// [Plantation]. Chunk 3a : squelette minimal fonctionnel (header + grille
/// de cartes simples + FAB + migration silencieuse). Les chunks suivants
/// enrichiront les cartes, la fiche détail, les badges et le tuto.
class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  State<MyGardenScreen> createState() => MyGardenScreenState();
}

class MyGardenScreenState extends State<MyGardenScreen> {
  List<Plantation> _plantations = <Plantation>[];
  Set<String> _unlockedBadges = <String>{};
  Map<String, MedalTier> _medals = <String, MedalTier>{};
  _AlbumFilter _filter = _AlbumFilter.all;
  bool _loaded = false;
  bool _deleteMode = false;

  /// Total d'espèces collectionnables (tous les légumes sauf accessoires).
  static final int _totalSpecies = vegetablesBase
      .where((v) => v.category != VegetableCategory.accessories)
      .length;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _maybeMigrate();
    _plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    _unlockedBadges = PrefsService.instance.unlockedBadges;
    // Met à jour (au cas où des badges seraient débloqués par la simple
    // lecture de données déjà présentes, sans déclencher de snackbar
    // historique — on se contente d'aligner l'état).
    _unlockedBadges = computeUnlockedBadges(_plantations);
    _medals = computeAllMedals(_plantations);
    await PrefsService.instance.setUnlockedBadges(_unlockedBadges);
    if (mounted) setState(() => _loaded = true);
    // Le tuto n'est PAS déclenché ici — RootTabs l'appelle via
    // [onBecameVisible] quand l'utilisateur arrive sur cet onglet.
  }

  /// Appelé par RootTabs quand l'utilisateur sélectionne l'onglet
  /// Poussidex pour la première fois.
  void onBecameVisible() {
    _showTutorialIfNeeded();
  }

  /// Appelée après chaque action qui modifie la collection — détecte les
  /// nouveaux badges débloqués et montre un snackbar kawaii pour chacun.
  void _refreshBadges() {
    final next = computeUnlockedBadges(_plantations);
    final newly = next.difference(_unlockedBadges);
    final nextMedals = computeAllMedals(_plantations);
    final newlyPromoted = <String, MedalTier>{};
    for (final entry in nextMedals.entries) {
      final prev = _medals[entry.key] ?? MedalTier.none;
      if (entry.value.rank > prev.rank && entry.value != MedalTier.bronze) {
        newlyPromoted[entry.key] = entry.value;
      }
    }
    _unlockedBadges = next;
    _medals = nextMedals;
    PrefsService.instance.setUnlockedBadges(next);
    if (!mounted) return;
    // Snackbar promotion d'espèce (argent/or/shiny).
    for (final entry in newlyPromoted.entries) {
      final veg = vegetablesBase
          .where((v) => v.id == entry.key)
          .firstOrNull;
      if (veg == null) continue;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${entry.value.emoji} ${veg.name} passe ${entry.value.label} !',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: entry.value.color,
          duration: const Duration(seconds: 3),
        ),
      );
    }
    if (newly.isEmpty) return;
    for (final id in newly) {
      final b = allBadges.firstWhere((x) => x.id == id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Badge débloqué : ${b.emoji} ${b.name}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: KultivaColors.primaryGreen,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  List<Plantation> get _filteredPlantations {
    switch (_filter) {
      case _AlbumFilter.all:
      case _AlbumFilter.badges: // ignoré, la vue badges ne passe pas par là
      case _AlbumFilter.stats: // ignoré, la vue stats ne passe pas par là
      case _AlbumFilter.journal: // ignoré, la vue journal ne passe pas par là
        return _plantations;
      case _AlbumFilter.growing:
        return _plantations.where((p) => p.isActive).toList();
      case _AlbumFilter.harvested:
        return _plantations
            .where((p) => !p.isActive || p.harvestCount > 0)
            .toList();
    }
  }

  /// Convertit l'ancienne grille 2D en plantations une seule fois,
  /// puis marque la migration comme faite pour ne plus la rejouer.
  Future<void> _maybeMigrate() async {
    if (PrefsService.instance.gridMigrated) return;
    final legacy = PrefsService.instance.gardenGrid;
    final migrated = migrateGridToPlantations(legacy);
    if (migrated.isNotEmpty) {
      await PrefsService.instance
          .setPlantationsJson(Plantation.encodeAll(migrated));
    }
    await PrefsService.instance.setGridMigrated(true);
  }

  void _showTutorialIfNeeded() {
    if (PrefsService.instance.gardenTutorialDone) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        builder: (_) => const GardenTutorialSheet(),
      ).whenComplete(() {
        PrefsService.instance.setGardenTutorialDone(true);
      });
    });
  }

  Future<void> _save() async {
    await PrefsService.instance
        .setPlantationsJson(Plantation.encodeAll(_plantations));
    _refreshBadges();
  }

  String _genId() =>
      '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(100000)}';

  void _plant(String vegetableId) {
    setState(() {
      _plantations.add(Plantation(
        id: _genId(),
        vegetableId: vegetableId,
        plantedAt: DateTime.now(),
      ));
    });
    _save();
    AudioService.instance.play(Sfx.plant);
  }

  void _replace(Plantation updated) {
    setState(() {
      final i = _plantations.indexWhere((x) => x.id == updated.id);
      if (i >= 0) _plantations[i] = updated;
    });
    _save();
  }

  void _water(Plantation p) {
    _replace(p.copyWith(wateredAt: <DateTime>[...p.wateredAt, DateTime.now()]));
    AudioService.instance.play(Sfx.drop);
  }

  /// Liste des plantations qui ont soif (isActive + seuil dépassé).
  List<Plantation> get _thirsty {
    final result = <Plantation>[];
    for (final p in _plantations) {
      if (!p.isActive) continue;
      final v = vegetablesBase
          .where((x) => x.id == p.vegetableId)
          .firstOrNull;
      if (v == null) continue;
      if (p.daysSinceWatered >= v.effectiveWateringDays) result.add(p);
    }
    return result;
  }

  /// Arrose en un tap toutes les plantes qui ont soif.
  void _waterAllThirsty() {
    final list = _thirsty;
    if (list.isEmpty) return;
    final now = DateTime.now();
    setState(() {
      for (int i = 0; i < _plantations.length; i++) {
        final p = _plantations[i];
        if (list.any((x) => x.id == p.id)) {
          _plantations[i] = p.copyWith(
            wateredAt: <DateTime>[...p.wateredAt, now],
          );
        }
      }
    });
    _save();
    AudioService.instance.play(Sfx.rain);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '💧 ${list.length} plante${list.length > 1 ? "s" : ""} arrosée${list.length > 1 ? "s" : ""}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _harvest(Plantation p) {
    _replace(p.copyWith(harvestCount: p.harvestCount + 1));
    AudioService.instance.play(Sfx.plant);
  }

  void _terminate(Plantation p) {
    _replace(p.copyWith(harvestedAt: DateTime.now()));
  }

  void _remove(Plantation p) {
    setState(() => _plantations.removeWhere((x) => x.id == p.id));
    _save();
  }

  /// Supprime une plantation en mode suppression avec un bouton d'annulation
  /// dans un SnackBar (fenêtre de 4 secondes).
  void _removeWithUndo(Plantation p, Vegetable veg) {
    setState(() => _plantations.removeWhere((x) => x.id == p.id));
    _save();
    AudioService.instance.play(Sfx.tap);
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🗑️ ${veg.name} retiré du Poussidex'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Annuler',
          textColor: Colors.white,
          onPressed: () {
            setState(() => _plantations.add(p));
            _save();
          },
        ),
      ),
    );
    // Si la collection est vide, on sort auto du mode suppression.
    if (_plantations.isEmpty) {
      setState(() => _deleteMode = false);
    }
  }

  void _setNote(Plantation p, String? note) {
    _replace(p.copyWith(note: note));
  }

  Future<void> _addPhoto(Plantation p, {required bool fromCamera}) async {
    final path = await PhotoService.pick(fromCamera: fromCamera);
    if (path == null) return;
    _replace(p.copyWith(photoPaths: <String>[...p.photoPaths, path]));
  }

  void _removePhoto(Plantation p, String path) {
    PhotoService.deleteFile(path);
    _replace(p.copyWith(
      photoPaths: p.photoPaths.where((x) => x != path).toList(),
    ));
  }

  void _openPicker() {
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const VegetablePickerSheet(),
    ).then((vegId) {
      if (vegId != null) _plant(vegId);
    });
  }

  Future<void> _showDetail(Plantation p, Vegetable v) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            // On lit la dernière version de la plantation à chaque rebuild
            // pour refléter immédiatement les photos ajoutées sans fermer
            // la sheet.
            final current =
                _plantations.firstWhere((x) => x.id == p.id, orElse: () => p);
            return PlantationDetailSheet(
              plantation: current,
              vegetable: v,
              onWater: () {
                _water(current);
                Navigator.pop(ctx);
              },
              onHarvest: () {
                _harvest(current);
                Navigator.pop(ctx);
              },
              onTerminate: () {
                _terminate(current);
                Navigator.pop(ctx);
              },
              onRemove: () {
                _remove(current);
                Navigator.pop(ctx);
              },
              onNoteChanged: (note) => _setNote(current, note),
              onAddPhoto: (fromCamera) async {
                await _addPhoto(current, fromCamera: fromCamera);
                setSheetState(() {});
              },
              onRemovePhoto: (path) {
                _removePhoto(current, path);
                setSheetState(() {});
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final showFab = _filter != _AlbumFilter.badges &&
        _filter != _AlbumFilter.stats &&
        _filter != _AlbumFilter.journal &&
        _plantations.isNotEmpty;
    final thirstyCount = _thirsty.length;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            _Header(
              plantationsCount: _plantations.length,
              speciesCount: _medals.length,
              totalSpecies: _totalSpecies,
              unlockedCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
            ),
            if (thirstyCount > 0 &&
                !_deleteMode &&
                _filter != _AlbumFilter.badges &&
                _filter != _AlbumFilter.stats &&
                _filter != _AlbumFilter.journal)
              _ThirstyBanner(
                count: thirstyCount,
                onTap: _waterAllThirsty,
              ),
            if (_deleteMode)
              _DeleteModeBanner(
                onExit: () => setState(() => _deleteMode = false),
              ),
            _FilterBar(
              filter: _filter,
              allCount: _plantations.length,
              growingCount:
                  _plantations.where((p) => p.isActive).length,
              harvestedCount: _plantations
                  .where((p) => !p.isActive || p.harvestCount > 0)
                  .length,
              badgesCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
              onChanged: (f) => setState(() => _filter = f),
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: showFab
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton.extended(
                  heroTag: 'poussidex_delete_fab',
                  onPressed: () => setState(() => _deleteMode = !_deleteMode),
                  icon: Icon(
                    _deleteMode ? Icons.close : Icons.delete_outline,
                    color: Colors.white,
                  ),
                  label: Text(
                    _deleteMode ? 'Terminé' : 'Retirer',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: _deleteMode
                      ? Colors.grey.shade600
                      : Colors.red.shade400,
                ),
                const SizedBox(width: 10),
                FloatingActionButton.extended(
                  heroTag: 'poussidex_plant_fab',
                  onPressed: _deleteMode ? null : _openPicker,
                  icon: const Icon(Icons.add),
                  label: const Text('Planter',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  backgroundColor: _deleteMode
                      ? Colors.grey.shade300
                      : KultivaColors.primaryGreen,
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_filter == _AlbumFilter.badges) {
      return PoussidexBadgesGrid(unlocked: _unlockedBadges);
    }
    if (_filter == _AlbumFilter.stats) {
      return PoussidexStatsView(plantations: _plantations);
    }
    if (_filter == _AlbumFilter.journal) {
      return PoussidexJournalView(plantations: _plantations);
    }
    if (_plantations.isEmpty) {
      return _EmptyState(onPlant: _openPicker);
    }
    final list = _filteredPlantations;
    if (list.isEmpty) {
      return _FilterEmptyState(filter: _filter);
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 0.78,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final p = list[i];
        final veg =
            vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
        if (veg == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            if (_deleteMode) {
              _removeWithUndo(p, veg);
            } else {
              _showDetail(p, veg);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              PlantationCard(
                plantation: p,
                vegetable: veg,
                tier: _medals[p.vegetableId] ?? MedalTier.bronze,
              ),
              // Overlay rouge + croix quand on est en mode suppression.
              if (_deleteMode)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: Colors.red.shade400, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.shade400,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Header
// ═══════════════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int plantationsCount;
  final int speciesCount;
  final int totalSpecies;
  final int unlockedCount;
  final int totalBadges;
  const _Header({
    required this.plantationsCount,
    required this.speciesCount,
    required this.totalSpecies,
    required this.unlockedCount,
    required this.totalBadges,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: SizedBox(
        height: 170,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/potager.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      KultivaColors.springA,
                      KultivaColors.springB,
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.35),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '🪴 Mon Poussidex',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      shadows: const <Shadow>[
                        Shadow(color: Colors.black45, blurRadius: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '🏅 $speciesCount / $totalSpecies espèces  ·  🏆 $unlockedCount / $totalBadges badges',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      shadows: const <Shadow>[
                        Shadow(color: Colors.black38, blurRadius: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Bannière "X plantes ont soif — tap pour tout arroser"
// ═══════════════════════════════════════════════════════════════════════════

class _ThirstyBanner extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _ThirstyBanner({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                KultivaColors.terracotta.withOpacity(0.18),
                const Color(0xFFFFE0B2).withOpacity(0.25),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: KultivaColors.terracotta.withOpacity(0.35),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Text('💧', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$count plante${count > 1 ? "s ont" : " a"} soif — Tap pour tout arroser',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: KultivaColors.terracotta,
                  ),
                ),
              ),
              Icon(Icons.water_drop,
                  color: KultivaColors.terracotta, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Bannière "Mode suppression actif — tap pour sortir"
// ═══════════════════════════════════════════════════════════════════════════

class _DeleteModeBanner extends StatelessWidget {
  final VoidCallback onExit;
  const _DeleteModeBanner({required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.red.shade300),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.delete_outline,
                color: Colors.red.shade700, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Tape une carte pour la retirer',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.red.shade700,
                ),
              ),
            ),
            TextButton(
              onPressed: onExit,
              child: Text(
                'Terminé',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Barre de filtres (Tout / En cours / Récoltés / Badges)
// ═══════════════════════════════════════════════════════════════════════════

class _FilterBar extends StatelessWidget {
  final _AlbumFilter filter;
  final int allCount;
  final int growingCount;
  final int harvestedCount;
  final int badgesCount;
  final int totalBadges;
  final ValueChanged<_AlbumFilter> onChanged;

  const _FilterBar({
    required this.filter,
    required this.allCount,
    required this.growingCount,
    required this.harvestedCount,
    required this.badgesCount,
    required this.totalBadges,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: <Widget>[
          _FilterChip(
            label: '✨ Tout',
            count: allCount,
            selected: filter == _AlbumFilter.all,
            color: KultivaColors.primaryGreen,
            onTap: () => onChanged(_AlbumFilter.all),
          ),
          _FilterChip(
            label: '🌱 En cours',
            count: growingCount,
            selected: filter == _AlbumFilter.growing,
            color: KultivaColors.primaryGreen,
            onTap: () => onChanged(_AlbumFilter.growing),
          ),
          _FilterChip(
            label: '🧺 Récoltés',
            count: harvestedCount,
            selected: filter == _AlbumFilter.harvested,
            color: KultivaColors.terracotta,
            onTap: () => onChanged(_AlbumFilter.harvested),
          ),
          _FilterChip(
            label: '🏆 Badges',
            count: badgesCount,
            total: totalBadges,
            selected: filter == _AlbumFilter.badges,
            color: const Color(0xFFFFB74D),
            onTap: () => onChanged(_AlbumFilter.badges),
          ),
          _FilterChip(
            label: '📊 Stats',
            count: allCount,
            hideCount: true,
            selected: filter == _AlbumFilter.stats,
            color: const Color(0xFF7BAFD4),
            onTap: () => onChanged(_AlbumFilter.stats),
          ),
          _FilterChip(
            label: '📜 Journal',
            count: allCount,
            hideCount: true,
            selected: filter == _AlbumFilter.journal,
            color: const Color(0xFFB39DDB),
            onTap: () => onChanged(_AlbumFilter.journal),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final int? total;
  final bool hideCount;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    this.total,
    this.hideCount = false,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final suffix = hideCount
        ? ''
        : (total != null ? ' $count/$total' : ' ($count)');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color,
              width: selected ? 2.5 : 2,
            ),
          ),
          child: Text(
            '$label$suffix',
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}


// ═══════════════════════════════════════════════════════════════════════════
// Empty states spécifiques à chaque filtre
// ═══════════════════════════════════════════════════════════════════════════

class _FilterEmptyState extends StatelessWidget {
  final _AlbumFilter filter;
  const _FilterEmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final message = switch (filter) {
      _AlbumFilter.growing =>
        '🌱\n\nAucun plant en cours pour le moment.\nPlante quelque chose avec le bouton +.',
      _AlbumFilter.harvested =>
        '🧺\n\nAucune récolte enregistrée.\nOuvre une fiche plant et appuie sur Récolter.',
      _ => 'Aucun légume à afficher.',
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: KultivaColors.textSecondary,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Empty state
// ═══════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final VoidCallback onPlant;
  const _EmptyState({required this.onPlant});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('📖', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              'Ton Poussidex est vide',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Plante ton premier légume pour commencer ta collection !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onPlant,
              icon: const Text('🌱', style: TextStyle(fontSize: 16)),
              label: const Text('Planter mon 1er légume'),
              style: ElevatedButton.styleFrom(
                backgroundColor: KultivaColors.primaryGreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
