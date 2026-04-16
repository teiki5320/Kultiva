import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/badges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/audio_service.dart';
import '../../services/photo_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';
import '../../widgets/medal_badge.dart';
import '../../widgets/share_card.dart';

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
    if (legacy == null || legacy.isEmpty) {
      await PrefsService.instance.setGridMigrated(true);
      return;
    }
    try {
      final data = jsonDecode(legacy) as Map<String, dynamic>;
      final rows = data['rows'] as int;
      final cols = data['cols'] as int;
      final cells = (data['cells'] as List).cast<String?>();
      final watered = (data['watered'] as Map?) ?? const <String, dynamic>{};
      final migrated = <Plantation>[];
      final now = DateTime.now();
      final rng = Random(42);
      int idx = 0;
      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          final vegId = cells[r * cols + c];
          if (vegId == null) continue;
          final wIso = watered['${r}_$c'] as String?;
          final wDates = <DateTime>[];
          if (wIso != null) {
            final w = DateTime.tryParse(wIso);
            if (w != null) wDates.add(w);
          }
          migrated.add(Plantation(
            id: '${now.millisecondsSinceEpoch}_${idx++}_${rng.nextInt(99999)}',
            vegetableId: vegId,
            plantedAt: now, // l'info de date plantation est perdue
            wateredAt: wDates,
          ));
        }
      }
      await PrefsService.instance
          .setPlantationsJson(Plantation.encodeAll(migrated));
    } catch (_) {
      // En cas d'échec de parsing, on abandonne silencieusement.
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
      builder: (_) => const _VegetablePickerSheet(),
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
            return _PlantationDetailSheet(
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
      return _BadgesGrid(unlocked: _unlockedBadges);
    }
    if (_filter == _AlbumFilter.stats) {
      return _StatsView(plantations: _plantations);
    }
    if (_filter == _AlbumFilter.journal) {
      return _JournalView(plantations: _plantations);
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
              _PlantationCard(
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
// Grille de badges (vue "Badges")
// ═══════════════════════════════════════════════════════════════════════════

class _BadgesGrid extends StatelessWidget {
  final Set<String> unlocked;
  const _BadgesGrid({required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 170,
        childAspectRatio: 0.95,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: allBadges.length,
      itemBuilder: (context, i) {
        final b = allBadges[i];
        final isUnlocked = unlocked.contains(b.id);
        return _BadgeTile(badge: b, unlocked: isUnlocked);
      },
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final PoussidexBadge badge;
  final bool unlocked;
  const _BadgeTile({required this.badge, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFB74D);
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? gold.withOpacity(0.12) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: unlocked ? gold : Colors.grey.shade300,
          width: unlocked ? 2.5 : 1.5,
        ),
        boxShadow: unlocked
            ? <BoxShadow>[
                BoxShadow(
                  color: gold.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : const <BoxShadow>[],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 4),
          Opacity(
            opacity: unlocked ? 1.0 : 0.3,
            child: Text(
              badge.emoji,
              style: const TextStyle(fontSize: 44),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badge.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: unlocked ? null : Colors.grey.shade500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              badge.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                height: 1.3,
                color: unlocked
                    ? KultivaColors.textSecondary
                    : Colors.grey.shade400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!unlocked)
            Icon(Icons.lock_outline,
                size: 14, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Vue statistiques du Poussidex
// ═══════════════════════════════════════════════════════════════════════════

class _StatsView extends StatelessWidget {
  final List<Plantation> plantations;
  const _StatsView({required this.plantations});

  static const List<String> _monthsLong = <String>[
    'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
    'juil', 'août', 'sep', 'oct', 'nov', 'déc',
  ];

  String _fmt(DateTime d) => '${d.day} ${_monthsLong[d.month - 1]}';

  @override
  Widget build(BuildContext context) {
    if (plantations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '📊\n\nPas encore de statistiques — plante ton premier légume !',
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

    final total = plantations.length;
    final active = plantations.where((p) => p.isActive).length;
    final totalWaterings =
        plantations.fold<int>(0, (sum, p) => sum + p.wateredAt.length);
    final totalHarvests =
        plantations.fold<int>(0, (sum, p) => sum + p.harvestCount);
    final totalPhotos =
        plantations.fold<int>(0, (sum, p) => sum + p.photoPaths.length);
    final survivalRate = total == 0 ? 0.0 : (active / total * 100);

    // Top familles.
    final families = <VegetableCategory, int>{};
    for (final p in plantations) {
      final v =
          vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
      if (v == null) continue;
      families[v.category] = (families[v.category] ?? 0) + 1;
    }
    final famSorted = families.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topFamilies = famSorted.take(3).toList();

    // Première / dernière plantation.
    final sorted = List<Plantation>.from(plantations)
      ..sort((a, b) => a.plantedAt.compareTo(b.plantedAt));
    final first = sorted.first;
    final last = sorted.last;

    // Arrosages par jour sur les 30 derniers jours.
    final now = DateTime.now();
    final buckets = List<int>.filled(30, 0);
    for (final p in plantations) {
      for (final w in p.wateredAt) {
        final delta = now.difference(w).inDays;
        if (delta >= 0 && delta < 30) {
          buckets[29 - delta]++;
        }
      }
    }
    final maxBucket = buckets.isEmpty
        ? 0
        : buckets.reduce((a, b) => a > b ? a : b);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 4 tuiles de compteurs.
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: <Widget>[
              _StatTile(
                emoji: '🪴',
                label: 'Plants collectés',
                value: '$total',
                color: KultivaColors.primaryGreen,
              ),
              _StatTile(
                emoji: '💧',
                label: 'Arrosages',
                value: '$totalWaterings',
                color: const Color(0xFF4FC3F7),
              ),
              _StatTile(
                emoji: '🧺',
                label: 'Récoltes',
                value: '$totalHarvests',
                color: KultivaColors.terracotta,
              ),
              _StatTile(
                emoji: '📷',
                label: 'Photos',
                value: '$totalPhotos',
                color: const Color(0xFFFFB74D),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Taux de survie.
          _SurvivalBar(active: active, total: total, rate: survivalRate),
          const SizedBox(height: 20),
          // Top familles.
          if (topFamilies.isNotEmpty) ...<Widget>[
            const Text('🎭  Top familles',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 10),
            for (final e in topFamilies)
              _FamilyBar(
                label: e.key.label,
                emoji: e.key.emoji,
                count: e.value,
                max: topFamilies.first.value,
                color: _familyColor(e.key),
              ),
            const SizedBox(height: 20),
          ],
          // Courbe arrosages 30j.
          const Text('💧  Arrosages — 30 derniers jours',
              style:
                  TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 10),
          _WateringChart(buckets: buckets, maxValue: maxBucket),
          const SizedBox(height: 20),
          // Bornes temporelles.
          const Text('📅  Repères',
              style:
                  TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 8),
          _RepereRow(
            icon: '🌱',
            label: 'Première plantation',
            value: _fmt(first.plantedAt),
          ),
          _RepereRow(
            icon: '🕒',
            label: 'Dernière plantation',
            value: _fmt(last.plantedAt),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color color;
  const _StatTile({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurvivalBar extends StatelessWidget {
  final int active;
  final int total;
  final double rate;
  const _SurvivalBar({
    required this.active,
    required this.total,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: KultivaColors.lightGreen, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('🌿', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Taux de plants en cours',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: KultivaColors.primaryGreen)),
              ),
              Text(
                '${rate.toStringAsFixed(0)}% ($active/$total)',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : active / total,
              minHeight: 8,
              backgroundColor: KultivaColors.lightGreen.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                  KultivaColors.primaryGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyBar extends StatelessWidget {
  final String label;
  final String emoji;
  final int count;
  final int max;
  final Color color;
  const _FamilyBar({
    required this.label,
    required this.emoji,
    required this.count,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = max == 0 ? 0.0 : count / max;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          SizedBox(
            width: 82,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 10,
                backgroundColor: color.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _WateringChart extends StatelessWidget {
  final List<int> buckets; // 30 valeurs, dernière = aujourd'hui
  final int maxValue;
  const _WateringChart({required this.buckets, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    if (maxValue == 0) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          "Aucun arrosage sur les 30 derniers jours.",
          style: TextStyle(
              color: KultivaColors.textSecondary, fontSize: 12),
        ),
      );
    }
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA).withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: const Color(0xFF4FC3F7).withOpacity(0.35), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < buckets.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 72 * (buckets[i] / maxValue).clamp(0.02, 1.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        const Color(0xFF29B6F6),
                        const Color(0xFF81D4FA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RepereRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _RepereRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 13)),
          ),
          Text(
            value,
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Vue Journal — toutes les actions chronologiques, groupées par jour
// ═══════════════════════════════════════════════════════════════════════════

class _JournalEvent {
  final DateTime date;
  final String icon;
  final String action; // verbe court : "Planté", "Arrosé", "Terminé"…
  final String vegetableLabel;
  final Color color;
  const _JournalEvent({
    required this.date,
    required this.icon,
    required this.action,
    required this.vegetableLabel,
    required this.color,
  });
}

class _JournalView extends StatelessWidget {
  final List<Plantation> plantations;
  const _JournalView({required this.plantations});

  static const List<String> _monthsLong = <String>[
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dd = DateTime(d.year, d.month, d.day);
    final diff = today.difference(dd).inDays;
    if (diff == 0) return "AUJOURD'HUI";
    if (diff == 1) return 'HIER';
    return '${d.day} ${_monthsLong[d.month - 1].toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    // Construire la liste complète d'événements.
    final events = <_JournalEvent>[];
    for (final p in plantations) {
      final v = vegetablesBase.where((x) => x.id == p.vegetableId).firstOrNull;
      final label = v == null ? p.vegetableId : '${v.emoji} ${v.name}';
      final color = v == null
          ? KultivaColors.primaryGreen
          : _familyColor(v.category);

      events.add(_JournalEvent(
        date: p.plantedAt,
        icon: '🌱',
        action: 'Planté',
        vegetableLabel: label,
        color: color,
      ));
      for (final w in p.wateredAt) {
        events.add(_JournalEvent(
          date: w,
          icon: '💧',
          action: 'Arrosé',
          vegetableLabel: label,
          color: const Color(0xFF4FC3F7),
        ));
      }
      if (p.harvestedAt != null) {
        events.add(_JournalEvent(
          date: p.harvestedAt!,
          icon: '🏁',
          action: 'Culture terminée',
          vegetableLabel: label,
          color: KultivaColors.terracotta,
        ));
      }
      // Photos : on récupère le timestamp encodé dans le nom de fichier
      // "plant_<ts>.jpg" quand possible, sinon on ignore le journal.
      for (final path in p.photoPaths) {
        final match = RegExp(r'plant_(\d+)\.').firstMatch(path);
        if (match == null) continue;
        final ts = int.tryParse(match.group(1)!);
        if (ts == null) continue;
        events.add(_JournalEvent(
          date: DateTime.fromMillisecondsSinceEpoch(ts),
          icon: '📷',
          action: 'Photo ajoutée',
          vegetableLabel: label,
          color: const Color(0xFFFFB74D),
        ));
      }
    }

    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '📜\n\nTon journal se remplira au fil de tes actions.\nPlante, arrose, récolte !',
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

    events.sort((a, b) => b.date.compareTo(a.date));

    // Grouper par jour (yyyy-mm-dd).
    final groups = <String, List<_JournalEvent>>{};
    for (final e in events) {
      final key = '${e.date.year}-${e.date.month}-${e.date.day}';
      groups.putIfAbsent(key, () => <_JournalEvent>[]).add(e);
    }
    final keys = groups.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final key = keys[i];
        final day = groups[key]!.first.date;
        final dayEvents = groups[key]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 14, 6, 6),
              child: Text(
                _dayLabel(day),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: <Widget>[
                  for (int j = 0; j < dayEvents.length; j++) ...<Widget>[
                    _JournalTile(event: dayEvents[j]),
                    if (j != dayEvents.length - 1)
                      Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                        indent: 48,
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _JournalTile extends StatelessWidget {
  final _JournalEvent event;
  const _JournalTile({required this.event});

  String _timeLabel(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: event.color.withOpacity(0.15),
            ),
            alignment: Alignment.center,
            child: Text(event.icon, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.action,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: event.color,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  event.vegetableLabel,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            _timeLabel(event.date),
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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

// ═══════════════════════════════════════════════════════════════════════════
// Carte d'une plantation — bordure famille, barre de progression, stats
// ═══════════════════════════════════════════════════════════════════════════

/// Couleur associée à la famille d'un légume.
Color _familyColor(VegetableCategory cat) {
  switch (cat) {
    case VegetableCategory.fruits:
      return KultivaColors.terracotta;
    case VegetableCategory.leaves:
      return KultivaColors.primaryGreen;
    case VegetableCategory.roots:
      return const Color(0xFF8B6914);
    case VegetableCategory.bulbs:
      return const Color(0xFFB39DDB);
    case VegetableCategory.tubers:
      return const Color(0xFF795548);
    case VegetableCategory.flowers:
      return KultivaColors.springA;
    case VegetableCategory.seeds:
      return KultivaColors.summerA;
    case VegetableCategory.stems:
      return const Color(0xFF66BB6A);
    case VegetableCategory.aromatics:
      return const Color(0xFF26A69A);
    case VegetableCategory.accessories:
      return const Color(0xFF78909C);
  }
}

/// Estimation du nombre de jours jusqu'à récolte (borne haute).
/// Lit [Vegetable.harvestTimeBySeason] si rempli, sinon défaut par famille.
int _expectedHarvestDays(Vegetable v, DateTime plantedAt) {
  final times = v.harvestTimeBySeason;
  if (times != null) {
    final m = plantedAt.month;
    final seasonKey = m >= 3 && m <= 5
        ? 'spring'
        : m >= 6 && m <= 8
            ? 'summer'
            : m >= 9 && m <= 11
                ? 'autumn'
                : 'winter';
    final raw = times[seasonKey] ?? times.values.firstOrNull;
    if (raw != null) {
      // Extrait le dernier nombre entier de la chaîne ("70 à 90 jours" → 90).
      final matches = RegExp(r'\d+').allMatches(raw).toList();
      if (matches.isNotEmpty) {
        return int.tryParse(matches.last.group(0)!) ?? 70;
      }
    }
  }
  // Défauts par famille.
  switch (v.category) {
    case VegetableCategory.leaves:
      return 55;
    case VegetableCategory.roots:
      return 70;
    case VegetableCategory.fruits:
      return 80;
    case VegetableCategory.bulbs:
      return 90;
    case VegetableCategory.tubers:
      return 100;
    case VegetableCategory.aromatics:
      return 45;
    case VegetableCategory.flowers:
      return 60;
    case VegetableCategory.seeds:
      return 90;
    case VegetableCategory.stems:
      return 70;
    case VegetableCategory.accessories:
      return 1;
  }
}

class _PlantationCard extends StatelessWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final MedalTier tier;
  const _PlantationCard({
    required this.plantation,
    required this.vegetable,
    required this.tier,
  });

  static const List<String> _shortMonths = <String>[
    'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
    'juil', 'août', 'sep', 'oct', 'nov', 'déc',
  ];

  @override
  Widget build(BuildContext context) {
    final cc = _familyColor(vegetable.category);
    final days = plantation.daysSincePlanted;
    final expected = _expectedHarvestDays(vegetable, plantation.plantedAt);
    final progress = (days / expected).clamp(0.0, 1.0);
    final mature = progress >= 1.0;
    final thirsty = plantation.isActive &&
        plantation.daysSinceWatered >= vegetable.effectiveWateringDays;
    final watered = plantation.wateredAt.length;
    final harvested = plantation.harvestCount;
    final plantedLabel =
        '${plantation.plantedAt.day} ${_shortMonths[plantation.plantedAt.month - 1]}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cc.withOpacity(0.7), width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cc.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Ligne haute : nom + indicateur soif / récolté.
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  vegetable.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!plantation.isActive)
                const Text('🧺', style: TextStyle(fontSize: 14))
              else if (thirsty)
                const Text('💧', style: TextStyle(fontSize: 14))
              else if (mature)
                const Text('✨', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 6),
          // Photo du plant si disponible, sinon emoji dans cercle famille.
          // Dans les 2 cas, le palier de médaille est affiché (anneau +
          // pastille coin haut-droit).
          Expanded(
            child: Center(
              child: plantation.photoPaths.isNotEmpty
                  ? _PhotoWithTier(
                      path: plantation.photoPaths.last,
                      tier: tier,
                      familyColor: cc,
                      fallbackEmoji: vegetable.emoji,
                    )
                  : MedalBadge(
                      emoji: vegetable.emoji,
                      tier: tier,
                      familyColor: cc,
                      size: 78,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          // Progression.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                plantation.isActive
                    ? 'Jour ${days + 1}${mature ? " ★" : "/$expected"}'
                    : 'Récolté',
                style: TextStyle(
                  color: KultivaColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                plantedLabel,
                style: TextStyle(
                  color: KultivaColors.textSecondary.withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: plantation.isActive ? progress : 1.0,
              minHeight: 5,
              backgroundColor: cc.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(cc),
            ),
          ),
          const SizedBox(height: 6),
          // Stats (💧 arrosages, 🧺 récoltes).
          Row(
            children: <Widget>[
              _StatChip(icon: '💧', count: watered),
              const SizedBox(width: 6),
              _StatChip(icon: '🧺', count: harvested),
            ],
          ),
        ],
      ),
    );
  }
}

/// Photo carrée d'un plant avec anneau/pastille médaille superposés.
class _PhotoWithTier extends StatelessWidget {
  final String path;
  final MedalTier tier;
  final Color familyColor;
  final String fallbackEmoji;

  const _PhotoWithTier({
    required this.path,
    required this.tier,
    required this.familyColor,
    required this.fallbackEmoji,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 82;
    final double radius = 12;
    final Color ring = tier == MedalTier.none ? familyColor : tier.color;
    final double ringWidth = tier == MedalTier.none
        ? 0
        : (tier == MedalTier.shiny ? 3 : 2.5);

    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => MedalBadge(
          emoji: fallbackEmoji,
          tier: tier,
          familyColor: familyColor,
          size: size,
        ),
      ),
    );

    Widget framed = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: tier == MedalTier.none
            ? null
            : Border.all(color: ring, width: ringWidth),
        boxShadow: tier == MedalTier.gold
            ? <BoxShadow>[
                BoxShadow(
                  color: ring.withOpacity(0.35),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : tier == MedalTier.shiny
                ? <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFFFF5CA8).withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : const <BoxShadow>[],
      ),
      child: Padding(
        padding: EdgeInsets.all(ringWidth),
        child: image,
      ),
    );

    if (tier == MedalTier.none) return framed;

    return SizedBox(
      width: size + 6,
      height: size + 6,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(child: Center(child: framed)),
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(tier.emoji, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final int count;
  const _StatChip({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            '×$count',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Fiche détail d'une carte (bottom sheet)
// ═══════════════════════════════════════════════════════════════════════════

class _PlantationDetailSheet extends StatefulWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final VoidCallback onWater;
  final VoidCallback onHarvest;
  final VoidCallback onTerminate;
  final VoidCallback onRemove;
  final ValueChanged<String?> onNoteChanged;
  final ValueChanged<bool> onAddPhoto; // bool = fromCamera
  final ValueChanged<String> onRemovePhoto;

  const _PlantationDetailSheet({
    required this.plantation,
    required this.vegetable,
    required this.onWater,
    required this.onHarvest,
    required this.onTerminate,
    required this.onRemove,
    required this.onNoteChanged,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  @override
  State<_PlantationDetailSheet> createState() =>
      _PlantationDetailSheetState();
}

class _PlantationDetailSheetState extends State<_PlantationDetailSheet> {
  static const List<String> _monthsLong = <String>[
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  String _fmtDate(DateTime d) {
    return '${d.day} ${_monthsLong[d.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.plantation;
    final v = widget.vegetable;
    final cc = _familyColor(v.category);
    final days = p.daysSincePlanted;
    final expected = _expectedHarvestDays(v, p.plantedAt);
    final remaining = (expected - days).clamp(0, expected);
    final progress = (days / expected).clamp(0.0, 1.0);
    final thirsty =
        p.isActive && p.daysSinceWatered >= v.effectiveWateringDays;

    // Timeline d'événements tri anti-chronologique.
    final events = <_TimelineEvent>[];
    events.add(_TimelineEvent(
        date: p.plantedAt, emoji: '🌱', label: 'Planté'));
    for (final w in p.wateredAt) {
      events.add(_TimelineEvent(date: w, emoji: '💧', label: 'Arrosé'));
    }
    if (p.harvestedAt != null) {
      events.add(_TimelineEvent(
          date: p.harvestedAt!, emoji: '🏁', label: 'Culture terminée'));
    }
    events.sort((a, b) => b.date.compareTo(a.date));

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return SingleChildScrollView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Poignée.
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // En-tête grande carte.
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: cc, width: 3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: cc.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cc.withOpacity(0.18),
                          border: Border.all(
                              color: cc.withOpacity(0.5), width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(v.emoji,
                            style: const TextStyle(fontSize: 52)),
                      ),
                      const SizedBox(height: 12),
                      Text(v.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22)),
                      Text(v.category.label,
                          style: TextStyle(
                              color: KultivaColors.textSecondary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Barre progression.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    p.isActive
                        ? 'Jour ${days + 1} / $expected'
                        : 'Culture terminée',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  if (p.isActive)
                    Text(
                      remaining == 0
                          ? '✨ Prêt à récolter'
                          : '⏳ $remaining j restants',
                      style: TextStyle(
                        color: KultivaColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: p.isActive ? progress : 1.0,
                  minHeight: 8,
                  backgroundColor: cc.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(cc),
                ),
              ),
              const SizedBox(height: 20),
              // Infos clés.
              _InfoRow(
                icon: '💧',
                label: p.lastWatered == null
                    ? 'Jamais arrosé'
                    : 'Dernier arrosage : ${_fmtDate(p.lastWatered!)} (${p.daysSinceWatered}j)',
                alert: thirsty,
              ),
              _InfoRow(
                icon: '🧺',
                label:
                    '${p.harvestCount} récolte${p.harvestCount > 1 ? "s" : ""} enregistrée${p.harvestCount > 1 ? "s" : ""}',
              ),
              _InfoRow(
                icon: '📅',
                label: 'Planté le ${_fmtDate(p.plantedAt)}',
              ),
              if (v.watering != null)
                _InfoRow(icon: '🌊', label: v.watering!),
              const SizedBox(height: 18),
              // Photos.
              _PhotoGallery(
                photos: p.photoPaths,
                onAdd: () => _showPhotoSourceSheet(context),
                onRemove: widget.onRemovePhoto,
              ),
              const SizedBox(height: 12),
              // Partage.
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => _openShareDialog(context, cc),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Partager cette carte'),
                  style: TextButton.styleFrom(
                    foregroundColor: KultivaColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Note.
              _NoteEditor(
                initial: p.note,
                onChanged: widget.onNoteChanged,
              ),
              const SizedBox(height: 20),
              // Actions principales.
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onWater : null,
                      icon: const Text('💧',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Arroser'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onHarvest : null,
                      icon: const Text('🧺',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Récolter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KultivaColors.terracotta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Actions secondaires.
              Row(
                children: <Widget>[
                  if (p.isActive)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onTerminate,
                        icon: const Text('🏁',
                            style: TextStyle(fontSize: 14)),
                        label: const Text('Terminer'),
                      ),
                    ),
                  if (p.isActive) const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmRemove(context),
                      icon: const Icon(Icons.delete_outline,
                          size: 18, color: Colors.red),
                      label: const Text('Retirer',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Timeline.
              const Text(
                '📜 Historique',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 8),
              for (final e in events) _TimelineTile(event: e, formatter: _fmtDate),
            ],
          ),
        );
      },
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Retirer ce plant ?'),
        content: Text(
            'Cette action supprime définitivement ${widget.vegetable.name} de ton Poussidex. Tes arrosages et récoltes liés seront perdus.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onRemove();
            },
            child: const Text('Retirer',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _openShareDialog(BuildContext context, Color familyColor) {
    showDialog<void>(
      context: context,
      builder: (_) => SharePreviewDialog(
        plantation: widget.plantation,
        vegetable: widget.vegetable,
        familyColor: familyColor,
      ),
    );
  }

  void _showPhotoSourceSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Text('📸', style: TextStyle(fontSize: 22)),
                title: const Text('Prendre une photo',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onAddPhoto(true);
                },
              ),
              ListTile(
                leading: const Text('🖼️', style: TextStyle(fontSize: 22)),
                title: const Text('Choisir depuis la galerie',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onAddPhoto(false);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineEvent {
  final DateTime date;
  final String emoji;
  final String label;
  const _TimelineEvent({
    required this.date,
    required this.emoji,
    required this.label,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineEvent event;
  final String Function(DateTime) formatter;
  const _TimelineTile({required this.event, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(event.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(event.label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(
            formatter(event.date),
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final bool alert;
  const _InfoRow({required this.icon, required this.label, this.alert = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: alert ? KultivaColors.terracotta : null,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  final List<String> photos;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  const _PhotoGallery({
    required this.photos,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text('📷', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              'Photos${photos.isEmpty ? "" : " (${photos.length})"}',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (final path in photos)
                _PhotoThumb(
                  path: path,
                  onRemove: () => onRemove(path),
                ),
              // Bouton ajouter.
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 96,
                  height: 96,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_a_photo_outlined,
                          color: KultivaColors.primaryGreen, size: 28),
                      const SizedBox(height: 4),
                      Text(
                        photos.isEmpty ? 'Ajouter' : '+',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: KultivaColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  final String path;
  final VoidCallback onRemove;
  const _PhotoThumb({required this.path, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(path),
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined,
                    color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Retirer la photo ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onRemove();
                        },
                        child: const Text('Retirer',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close,
                    size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteEditor extends StatefulWidget {
  final String? initial;
  final ValueChanged<String?> onChanged;
  const _NoteEditor({required this.initial, required this.onChanged});

  @override
  State<_NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<_NoteEditor> {
  late TextEditingController _ctrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    final text = _ctrl.text.trim();
    widget.onChanged(text.isEmpty ? null : text);
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _ctrl,
            autofocus: true,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Ajoute une note sur ce plant…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _ctrl.text = widget.initial ?? '';
                  setState(() => _editing = false);
                },
                child: const Text('Annuler'),
              ),
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      );
    }
    final text = widget.initial;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _editing = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            const Text('📝', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text == null || text.isEmpty
                    ? 'Ajouter une note…'
                    : text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: text == null || text.isEmpty
                      ? KultivaColors.textSecondary
                      : null,
                ),
              ),
            ),
            Icon(Icons.edit_outlined,
                size: 16, color: KultivaColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Picker légume (bottom sheet)
// ═══════════════════════════════════════════════════════════════════════════

class _VegetablePickerSheet extends StatefulWidget {
  const _VegetablePickerSheet();

  @override
  State<_VegetablePickerSheet> createState() => _VegetablePickerSheetState();
}

class _VegetablePickerSheetState extends State<_VegetablePickerSheet> {
  String _query = '';
  bool _favOnly = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return ValueListenableBuilder<Set<String>>(
          valueListenable: PrefsService.instance.favorites,
          builder: (ctx, favs, _) {
            var list = vegetablesBase
                .where((v) => v.category != VegetableCategory.accessories)
                .toList();
            if (_favOnly) {
              list = list.where((v) => favs.contains(v.id)).toList();
            }
            if (_query.isNotEmpty) {
              final q = _query.toLowerCase();
              list = list
                  .where((v) =>
                      v.name.toLowerCase().contains(q) ||
                      v.category.label.toLowerCase().contains(q))
                  .toList();
            }
            list.sort((a, b) {
              final aFav = favs.contains(a.id) ? 0 : 1;
              final bFav = favs.contains(b.id) ? 0 : 1;
              final cmp = aFav.compareTo(bFav);
              return cmp != 0 ? cmp : a.name.compareTo(b.name);
            });
            return Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => setState(() => _query = v.trim()),
                    decoration: const InputDecoration(
                      hintText: 'Rechercher un légume…',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      ChoiceChip(
                        label: const Text('❤️ Favoris'),
                        selected: _favOnly,
                        onSelected: (v) => setState(() => _favOnly = v),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${list.length} légume${list.length > 1 ? "s" : ""}',
                        style: TextStyle(
                          color: KultivaColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: list.isEmpty
                      ? Center(
                          child: Text(
                            'Aucun résultat',
                            style: TextStyle(
                                color: KultivaColors.textSecondary),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollCtrl,
                          itemCount: list.length,
                          itemBuilder: (ctx, i) {
                            final v = list[i];
                            final isFav = favs.contains(v.id);
                            return ListTile(
                              leading: Text(v.emoji,
                                  style: const TextStyle(fontSize: 28)),
                              title: Text(v.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(v.category.label),
                              trailing: isFav
                                  ? Icon(Icons.favorite,
                                      size: 16,
                                      color: KultivaColors.terracotta)
                                  : null,
                              onTap: () =>
                                  Navigator.of(context).pop(v.id),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
