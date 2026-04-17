import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/badges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/audio_service.dart';
import '../../services/cloud_sync_service.dart';
import '../../services/photo_service.dart';
import '../../services/plantation_migration.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/category_colors.dart';
import '../../widgets/badge_card.dart';
import '../../widgets/garden_tutorial_sheet.dart';
import '../../widgets/plant_creature.dart';
import 'poussidex/plantation_detail_sheet.dart';
import 'poussidex/poussidex_badges.dart';
import 'poussidex/poussidex_card.dart';
import 'poussidex/poussidex_challenges.dart';
import 'poussidex/vegetable_picker_sheet.dart';

/// Filtre actif dans le Poussidex.
enum _AlbumFilter { tamassi, challenges, badges }

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
  _AlbumFilter _filter = _AlbumFilter.tamassi;
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
    unawaited(CloudSyncService.instance.uploadBadges(next));
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
    // Animation "pack opening" pour chaque nouveau badge, séquentielle :
    // la prochaine ne se lance qu'une fois la précédente fermée.
    _showNewBadgesSequentially(newly.toList());
  }

  /// Affiche les cartes des nouveaux badges une par une, en attendant
  /// que l'utilisateur tape pour fermer entre chaque.
  Future<void> _showNewBadgesSequentially(List<String> ids) async {
    for (final id in ids) {
      if (!mounted) return;
      final b = allBadges.firstWhere((x) => x.id == id);
      await showBadgeUnlockedAnimation(context, badge: b);
    }
  }

  List<Plantation> get _filteredPlantations => _plantations;

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
    // Upload vers le cloud en fire-and-forget (pas de await, l'UI
    // n'attend pas le réseau pour répondre au tap).
    unawaited(
      CloudSyncService.instance.uploadAllPlantations(_plantations),
    );
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
    unawaited(CloudSyncService.instance.deletePlantation(p.id));
  }

  /// Supprime une plantation en mode suppression avec un bouton d'annulation
  /// dans un SnackBar (fenêtre de 4 secondes).
  void _removeWithUndo(Plantation p, Vegetable veg) {
    setState(() => _plantations.removeWhere((x) => x.id == p.id));
    _save();
    unawaited(CloudSyncService.instance.deletePlantation(p.id));
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
    final localPath = await PhotoService.pick(fromCamera: fromCamera);
    if (localPath == null) return;
    // Ajoute la photo immédiatement (chemin local) pour que l'UI
    // affiche la miniature sans attendre le réseau.
    _replace(p.copyWith(
      photoPaths: <String>[...p.photoPaths, localPath],
    ));
    // Upload vers Supabase Storage en arrière-plan ; si succès on
    // remplace le chemin local par l'URL cloud dans la plantation,
    // et on efface le fichier local (économise l'espace device).
    unawaited(_uploadAndReplacePhoto(p.id, localPath));
  }

  /// Upload une photo locale vers Storage puis met à jour la
  /// plantation pour remplacer le chemin local par l'URL renvoyée.
  Future<void> _uploadAndReplacePhoto(
      String plantationId, String localPath) async {
    final url = await CloudSyncService.instance.uploadPhoto(
      localPath: localPath,
      plantationId: plantationId,
    );
    if (url == null) return; // Upload échoué : on garde le local.
    if (!mounted) return;
    final idx = _plantations.indexWhere((x) => x.id == plantationId);
    if (idx < 0) return;
    final current = _plantations[idx];
    final updated = current.copyWith(
      photoPaths: current.photoPaths
          .map((p) => p == localPath ? url : p)
          .toList(),
    );
    setState(() => _plantations[idx] = updated);
    await PrefsService.instance
        .setPlantationsJson(Plantation.encodeAll(_plantations));
    unawaited(
      CloudSyncService.instance.uploadAllPlantations(_plantations),
    );
    // Efface le fichier local maintenant qu'on a l'URL cloud.
    unawaited(PhotoService.deleteFile(localPath));
  }

  void _removePhoto(Plantation p, String path) {
    // Supprime le fichier (local OU cloud).
    if (path.startsWith('http')) {
      unawaited(CloudSyncService.instance.deletePhoto(path));
    } else {
      PhotoService.deleteFile(path);
    }
    _replace(p.copyWith(
      photoPaths: p.photoPaths.where((x) => x != path).toList(),
    ));
  }

  /// Appelé quand l'user soumet une photo pour un défi.
  void _onChallengePhotoTaken(String challengeId, String photoPath) {
    // On rebuild le grid pour montrer la photo tout de suite.
    if (mounted) setState(() {});
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
    final showFab = _filter == _AlbumFilter.tamassi;
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
            _FilterBar(
              filter: _filter,
              challengesCount: 0,
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
                  heroTag: 'tamassi_water_fab',
                  onPressed: _onWater,
                  icon: const Icon(Icons.water_drop, color: Colors.white),
                  label: const Text(
                    'Arroser',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  backgroundColor: Colors.blue.shade400,
                ),
                const SizedBox(width: 10),
                FloatingActionButton.extended(
                  heroTag: 'tamassi_fertilize_fab',
                  onPressed: _onFertilize,
                  icon: const Icon(Icons.eco, color: Colors.white),
                  label: const Text(
                    'Engrais',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  backgroundColor: KultivaColors.terracotta,
                ),
              ],
            )
          : null,
    );
  }

  void _onWater() {
    // TODO : brancher XP booster "arroser" quand le système de niveaux arrive.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('💧 Arrosage — XP boost bientôt.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onFertilize() {
    // TODO : brancher XP booster "engrais".
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🌿 Engrais — XP boost bientôt.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildBody() {
    switch (_filter) {
      case _AlbumFilter.tamassi:
        return const _TamassiView();
      case _AlbumFilter.challenges:
        return PoussidexChallengesGrid(
          onPhotoTaken: _onChallengePhotoTaken,
        );
      case _AlbumFilter.badges:
        return PoussidexBadgesGrid(unlocked: _unlockedBadges);
    }
  }
}

/// Vue Tamassi — la créature Poussia en grand avec son nom et niveau.
/// Inclut un slider de prototypage pour tester les stades d'évolution.
class _TamassiView extends StatefulWidget {
  const _TamassiView();

  @override
  State<_TamassiView> createState() => _TamassiViewState();
}

class _TamassiViewState extends State<_TamassiView> {
  double _level = 5;

  String get _stageName {
    final lv = _level.round();
    if (lv < 5) return 'Graine I';
    if (lv < 10) return 'Graine II';
    if (lv < 15) return 'Graine III';
    if (lv < 20) return 'Germe';
    if (lv < 30) return 'Pousse';
    if (lv < 40) return 'Bourgeon';
    if (lv < 50) return 'Fleur';
    if (lv < 60) return 'Plante';
    if (lv < 75) return 'Arbrisseau';
    if (lv < 100) return 'Arbre';
    return 'Arbre légendaire';
  }

  @override
  Widget build(BuildContext context) {
    final lv = _level.round();
    return Column(
      children: <Widget>[
        const Spacer(),
        PlantCreature(level: lv, size: 260),
        const SizedBox(height: 16),
        const Text(
          'Poussia',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Niveau $lv · $_stageName',
          style: TextStyle(
            fontSize: 13,
            color: KultivaColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        // Slider temporaire pour tester les stades d'évolution.
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child: Row(
            children: <Widget>[
              const Text('1',
                  style: TextStyle(fontWeight: FontWeight.w700)),
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
              const Text('100',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 96),
          child: Wrap(
            spacing: 8,
            children: <int>[1, 5, 10, 15, 20, 30, 40, 50, 60, 75, 100]
                .map((v) => ActionChip(
                      label: Text('$v'),
                      onPressed: () =>
                          setState(() => _level = v.toDouble()),
                    ))
                .toList(),
          ),
        ),
      ],
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
  final int challengesCount;
  final int badgesCount;
  final int totalBadges;
  final ValueChanged<_AlbumFilter> onChanged;

  const _FilterBar({
    required this.filter,
    required this.challengesCount,
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
            label: '🌱 Tamassi',
            count: 0,
            hideCount: true,
            selected: filter == _AlbumFilter.tamassi,
            color: KultivaColors.primaryGreen,
            onTap: () => onChanged(_AlbumFilter.tamassi),
          ),
          _FilterChip(
            label: '📸 Défis',
            count: 0,
            hideCount: true,
            selected: filter == _AlbumFilter.challenges,
            color: const Color(0xFFFF8FAB),
            onTap: () => onChanged(_AlbumFilter.challenges),
          ),
          _FilterChip(
            label: '🏆 Badges',
            count: badgesCount,
            total: totalBadges,
            selected: filter == _AlbumFilter.badges,
            color: const Color(0xFFE8B923),
            onTap: () => onChanged(_AlbumFilter.badges),
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

