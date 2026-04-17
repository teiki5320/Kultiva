import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/weather_service.dart';

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

  final GlobalKey<_TamassiViewState> _tamassiKey =
      GlobalKey<_TamassiViewState>();

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
    _tamassiKey.currentState?.triggerEffect(_TamassiEffect.water);
  }

  void _onFertilize() {
    _tamassiKey.currentState?.triggerEffect(_TamassiEffect.fertilize);
  }

  Widget _buildBody() {
    switch (_filter) {
      case _AlbumFilter.tamassi:
        return _TamassiView(key: _tamassiKey);
      case _AlbumFilter.challenges:
        return PoussidexChallengesGrid(
          onPhotoTaken: _onChallengePhotoTaken,
        );
      case _AlbumFilter.badges:
        return PoussidexBadgesGrid(unlocked: _unlockedBadges);
    }
  }
}

/// Type d'effet déclenché depuis les boutons Arroser/Engrais.
enum _TamassiEffect { water, fertilize }

/// Vue Tamassi — la créature Poussia en grand avec son nom et niveau.
/// Inclut un slider de prototypage pour tester les stades d'évolution.
class _TamassiView extends StatefulWidget {
  const _TamassiView({super.key});

  @override
  State<_TamassiView> createState() => _TamassiViewState();
}

class _TamassiViewState extends State<_TamassiView>
    with SingleTickerProviderStateMixin {
  double _level = 5;
  late final AnimationController _effectCtrl;
  _TamassiEffect? _effect;

  @override
  void initState() {
    super.initState();
    _effectCtrl = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _effectCtrl.dispose();
    super.dispose();
  }

  /// Appelée par le parent via GlobalKey quand on tape Arroser/Engrais.
  void triggerEffect(_TamassiEffect effect) {
    HapticFeedback.mediumImpact();
    setState(() => _effect = effect);
    _effectCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _effect = null);
    });
  }

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
    final screenWidth = MediaQuery.of(context).size.width;
    final creatureSize = min(screenWidth * 0.9, 420.0);
    return Stack(
      children: <Widget>[
        // Fond kawaii plein écran.
        const Positioned.fill(child: _KawaiiBackground()),
        // Contenu principal.
        Column(
          children: <Widget>[
            const Spacer(),
            // Créature + overlay effets (drops / sparkles).
            SizedBox(
              width: creatureSize,
              height: creatureSize,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: PlantCreature(level: lv, size: creatureSize),
                  ),
                  if (_effect != null)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _effectCtrl,
                          builder: (_, __) => CustomPaint(
                            painter: _EffectPainter(
                              effect: _effect!,
                              progress: _effectCtrl.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 96),
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
          ],
        ),
      ],
    );
  }
}

/// Fond kawaii dynamique : gradient selon l'heure du jour, particules
/// selon la météo réelle (Open-Meteo) ou la saison en fallback.
class _KawaiiBackground extends StatefulWidget {
  const _KawaiiBackground();

  @override
  State<_KawaiiBackground> createState() => _KawaiiBackgroundState();
}

class _KawaiiBackgroundState extends State<_KawaiiBackground>
    with SingleTickerProviderStateMixin {
  WeatherData? _weather;
  late final AnimationController _particleCtrl;

  @override
  void initState() {
    super.initState();
    _particleCtrl = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _loadWeather();
  }

  @override
  void dispose() {
    _particleCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadWeather() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weather = w);
  }

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isNight = hour >= 21 || hour < 6;
    final gradient = _gradientForHour(hour);

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        children: <Widget>[
          // Déco statique adaptée au moment.
          ..._staticDecorations(hour),
          // Particules météo / saison.
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleCtrl,
              builder: (_, __) => CustomPaint(
                painter: _WeatherParticlePainter(
                  weatherCode: _weather?.currentWeatherCode,
                  progress: _particleCtrl.value,
                  isNight: isNight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _gradientForHour(int hour) {
    if (hour >= 6 && hour < 12) {
      // Matin.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFFFF0E0), // orange rosé clair
          Color(0xFFE9F6FF), // bleu ciel
          Color(0xFFDCF2D4), // herbe
        ],
      );
    } else if (hour >= 12 && hour < 18) {
      // Après-midi.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFE9F6FF),
          Color(0xFFFFE9F1),
          Color(0xFFDCF2D4),
        ],
      );
    } else if (hour >= 18 && hour < 21) {
      // Soir.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFFFD6A5), // coucher de soleil
          Color(0xFFFFB4C2), // rose chaud
          Color(0xFFC8DFBB), // herbe sombre
        ],
      );
    } else {
      // Nuit.
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFF1A1A3E), // bleu nuit profond
          Color(0xFF2D2B55), // violet nuit
          Color(0xFF1C3A2A), // herbe nuit
        ],
      );
    }
  }

  List<Widget> _staticDecorations(int hour) {
    final isNight = hour >= 21 || hour < 6;
    if (isNight) {
      return <Widget>[
        // Lune.
        const Positioned(
          top: 20, right: 30,
          child: Text('🌙', style: TextStyle(fontSize: 42)),
        ),
        // Étoiles.
        const Positioned(top: 30, left: 40,
          child: Text('⭐', style: TextStyle(fontSize: 14))),
        const Positioned(top: 60, left: 140,
          child: Text('⭐', style: TextStyle(fontSize: 10))),
        const Positioned(top: 80, right: 80,
          child: Text('⭐', style: TextStyle(fontSize: 12))),
        const Positioned(top: 120, left: 60,
          child: Text('⭐', style: TextStyle(fontSize: 8))),
        const Positioned(top: 50, right: 150,
          child: Text('⭐', style: TextStyle(fontSize: 11))),
        const Positioned(top: 160, right: 50,
          child: Text('⭐', style: TextStyle(fontSize: 9))),
      ];
    }
    // Jour.
    final isSunny = _weather == null ||
        (_weather!.currentWeatherCode <= 2);
    return <Widget>[
      if (isSunny)
        const Positioned(top: 15, right: 25,
          child: Text('☀️', style: TextStyle(fontSize: 36)))
      else ...<Widget>[
        Positioned(top: 20, left: 30,
          child: Text('☁️', style: TextStyle(
            fontSize: 44, color: Colors.white.withOpacity(0.9)))),
        Positioned(top: 60, right: 40,
          child: Text('☁️', style: TextStyle(
            fontSize: 32, color: Colors.white.withOpacity(0.8)))),
        Positioned(top: 140, left: 20,
          child: Text('☁️', style: TextStyle(
            fontSize: 28, color: Colors.white.withOpacity(0.7)))),
      ],
      const Positioned(bottom: 20, left: 20,
        child: Text('🌸', style: TextStyle(fontSize: 26))),
      const Positioned(bottom: 40, right: 30,
        child: Text('🌼', style: TextStyle(fontSize: 22))),
      const Positioned(bottom: 12, left: 160,
        child: Text('🌿', style: TextStyle(fontSize: 20))),
    ];
  }
}

/// Painter de particules selon la météo ou la saison.
class _WeatherParticlePainter extends CustomPainter {
  final int? weatherCode;
  final double progress;
  final bool isNight;

  _WeatherParticlePainter({
    required this.weatherCode,
    required this.progress,
    required this.isNight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final type = _resolveType();
    switch (type) {
      case _WeatherType.rain:
        _paintRain(canvas, size, heavy: false);
        break;
      case _WeatherType.heavyRain:
        _paintRain(canvas, size, heavy: true);
        break;
      case _WeatherType.snow:
        _paintSnow(canvas, size);
        break;
      case _WeatherType.storm:
        _paintRain(canvas, size, heavy: true);
        _paintLightning(canvas, size);
        break;
      case _WeatherType.clear:
        if (isNight) {
          _paintFireflies(canvas, size);
        } else {
          _paintSunSparkles(canvas, size);
        }
        break;
      case _WeatherType.cloudy:
        break; // les nuages sont déjà en emoji statique
      case _WeatherType.petals:
        _paintFallingPetals(canvas, size);
        break;
      case _WeatherType.leaves:
        _paintFallingLeaves(canvas, size);
        break;
    }
  }

  _WeatherType _resolveType() {
    if (weatherCode != null) {
      final c = weatherCode!;
      if (c >= 95) return _WeatherType.storm;
      if (c >= 71 && c <= 77) return _WeatherType.snow;
      if (c >= 61 && c <= 67 || c >= 80 && c <= 82) {
        return _WeatherType.heavyRain;
      }
      if (c >= 51 && c <= 57) return _WeatherType.rain;
      if (c >= 1 && c <= 3) return _WeatherType.cloudy;
      return _WeatherType.clear;
    }
    // Fallback saisonnier.
    final month = DateTime.now().month;
    if (month >= 3 && month <= 5) return _WeatherType.petals;
    if (month >= 6 && month <= 8) return _WeatherType.clear;
    if (month >= 9 && month <= 11) return _WeatherType.leaves;
    return _WeatherType.snow;
  }

  void _paintRain(Canvas canvas, Size size, {required bool heavy}) {
    final rng = Random(77);
    final count = heavy ? 30 : 14;
    final paint = Paint()
      ..strokeWidth = heavy ? 2.0 : 1.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < count; i++) {
      final x = rng.nextDouble() * size.width;
      final speed = 0.6 + rng.nextDouble() * 0.4;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height * 1.1 - size.height * 0.05;
      final len = size.height * (heavy ? 0.04 : 0.025);
      paint.color = const Color(0xFF6BAADC).withOpacity(0.6);
      canvas.drawLine(Offset(x, y), Offset(x - 2, y + len), paint);
    }
  }

  void _paintSnow(Canvas canvas, Size size) {
    final rng = Random(55);
    const count = 20;
    for (int i = 0; i < count; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.3 + rng.nextDouble() * 0.3;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 4 + i) * 15;
      final x = baseX + drift;
      final r = 2.0 + rng.nextDouble() * 3;
      canvas.drawCircle(
        Offset(x, y), r,
        Paint()..color = Colors.white.withOpacity(0.8),
      );
    }
  }

  void _paintLightning(Canvas canvas, Size size) {
    // Flash toutes les ~3 secondes (basé sur progress cycle de 8s).
    final flash = (progress * 3 % 1.0);
    if (flash < 0.03) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = Colors.white.withOpacity(0.3 * (1 - flash / 0.03)),
      );
    }
  }

  void _paintSunSparkles(Canvas canvas, Size size) {
    final rng = Random(33);
    for (int i = 0; i < 6; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.5;
      final phase = (progress * 2 + i * 0.17) % 1.0;
      final opacity = (sin(phase * pi * 2) * 0.5 + 0.5) * 0.5;
      final r = 2.0 + rng.nextDouble() * 2;
      canvas.drawCircle(
        Offset(x, y), r,
        Paint()..color = const Color(0xFFFFE066).withOpacity(opacity),
      );
    }
  }

  void _paintFireflies(Canvas canvas, Size size) {
    final rng = Random(88);
    for (int i = 0; i < 8; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final phase = (progress * 1.5 + i * 0.125) % 1.0;
      final opacity = (sin(phase * pi * 2) * 0.5 + 0.5) * 0.7;
      final driftX = sin(progress * pi * 3 + i) * 8;
      final driftY = cos(progress * pi * 2 + i * 1.3) * 6;
      canvas.drawCircle(
        Offset(baseX + driftX, baseY + driftY),
        2.5,
        Paint()..color = const Color(0xFFE8FF6B).withOpacity(opacity),
      );
    }
  }

  void _paintFallingPetals(Canvas canvas, Size size) {
    final rng = Random(44);
    for (int i = 0; i < 10; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.2 + rng.nextDouble() * 0.25;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 3 + i * 0.8) * 20;
      final x = baseX + drift;
      final r = 3.0 + rng.nextDouble() * 2;
      final rotation = progress * pi * 2 + i;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2.5, height: r),
        Paint()..color = const Color(0xFFFFB7D5).withOpacity(0.7),
      );
      canvas.restore();
    }
  }

  void _paintFallingLeaves(Canvas canvas, Size size) {
    final rng = Random(66);
    for (int i = 0; i < 8; i++) {
      final baseX = rng.nextDouble() * size.width;
      final speed = 0.15 + rng.nextDouble() * 0.2;
      final rawY = (progress * speed + rng.nextDouble()) % 1.0;
      final y = rawY * size.height;
      final drift = sin(progress * pi * 2 + i * 1.2) * 25;
      final x = baseX + drift;
      final r = 4.0 + rng.nextDouble() * 3;
      final rotation = progress * pi * 3 + i * 0.7;
      final colors = <Color>[
        const Color(0xFFD4832E),
        const Color(0xFFC85A25),
        const Color(0xFFE8A83E),
      ];
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2.2, height: r),
        Paint()..color = colors[i % colors.length].withOpacity(0.65),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _WeatherParticlePainter old) =>
      old.progress != progress || old.weatherCode != weatherCode;
}

enum _WeatherType {
  clear, cloudy, rain, heavyRain, snow, storm, petals, leaves,
}

/// Peintre d'effet particules pour Arroser (gouttes d'eau) et Engrais
/// (étincelles vertes/dorées). L'animation est pilotée par [progress]
/// qui va de 0 à 1.
class _EffectPainter extends CustomPainter {
  final _TamassiEffect effect;
  final double progress;

  _EffectPainter({required this.effect, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (effect == _TamassiEffect.water) {
      _paintWater(canvas, size);
    } else {
      _paintFertilize(canvas, size);
    }
  }

  void _paintWater(Canvas canvas, Size size) {
    // 10 gouttes qui tombent du haut vers le milieu de la créature.
    final rng = Random(42);
    const dropCount = 10;
    for (int i = 0; i < dropCount; i++) {
      final startX = size.width * (0.15 + 0.70 * rng.nextDouble());
      final delay = i * 0.06;
      final localP = ((progress - delay) / 0.55).clamp(0.0, 1.0);
      if (localP <= 0) continue;
      // Gouttes tombent de y=-10% à y=55% (centre de la créature).
      final startY = -size.height * 0.1;
      final endY = size.height * 0.55;
      final y = startY + (endY - startY) * _easeInQuad(localP);
      final dropSize = size.width * 0.018;
      // Goutte : forme d'œuf inversé.
      final dropPath = Path()
        ..moveTo(startX, y - dropSize * 2)
        ..quadraticBezierTo(
          startX + dropSize, y - dropSize,
          startX + dropSize * 0.6, y + dropSize * 0.8,
        )
        ..quadraticBezierTo(
          startX, y + dropSize,
          startX - dropSize * 0.6, y + dropSize * 0.8,
        )
        ..quadraticBezierTo(
          startX - dropSize, y - dropSize,
          startX, y - dropSize * 2,
        )
        ..close();
      canvas.drawPath(
        dropPath,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFF9BD4FF).withOpacity(0.9),
              const Color(0xFF3A9BE8).withOpacity(0.95),
            ],
          ).createShader(Rect.fromCircle(
              center: Offset(startX, y), radius: dropSize * 2)),
      );
      // Splash quand la goutte atteint le bas (dernier 25% du localP).
      if (localP > 0.75) {
        final splashP = (localP - 0.75) / 0.25;
        final splashRadius = dropSize * 3 * splashP;
        canvas.drawCircle(
          Offset(startX, endY),
          splashRadius,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color =
                const Color(0xFF3A9BE8).withOpacity(0.5 * (1 - splashP)),
        );
      }
    }
  }

  void _paintFertilize(Canvas canvas, Size size) {
    // 14 étincelles qui montent depuis le bas de la créature en fade.
    final rng = Random(123);
    const sparkCount = 14;
    for (int i = 0; i < sparkCount; i++) {
      final xBase = size.width * (0.12 + 0.76 * rng.nextDouble());
      final xDrift = (rng.nextDouble() - 0.5) * size.width * 0.08;
      final delay = i * 0.045;
      final localP = ((progress - delay) / 0.65).clamp(0.0, 1.0);
      if (localP <= 0) continue;
      // Monte de y=85% à y=15%.
      final startY = size.height * 0.85;
      final endY = size.height * 0.15;
      final y = startY + (endY - startY) * _easeOutCubic(localP);
      final x = xBase + xDrift * localP;
      final opacity = (1 - localP).clamp(0.0, 1.0);
      final sparkSize = size.width * 0.018 * (1 + 0.5 * (1 - localP));
      final color = i.isEven
          ? const Color(0xFFB2E371) // vert tendre
          : const Color(0xFFFFD86B); // jaune doré
      _drawSpark(canvas, Offset(x, y), sparkSize, color, opacity);
    }
  }

  void _drawSpark(
      Canvas canvas, Offset center, double size, Color color, double opacity) {
    final paint = Paint()..color = color.withOpacity(opacity);
    // 4-branch star.
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4;
      final r = i.isEven ? size : size * 0.35;
      final p = center + Offset(cos(angle) * r, sin(angle) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _easeInQuad(double t) => t * t;
  double _easeOutCubic(double t) {
    final x = 1 - t;
    return 1 - x * x * x;
  }

  @override
  bool shouldRepaint(covariant _EffectPainter old) =>
      old.progress != progress || old.effect != effect;
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
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color,
              width: selected ? 2.5 : 2,
            ),
          ),
          child: Text(
            '$label$suffix',
            style: TextStyle(
              fontSize: 14,
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

