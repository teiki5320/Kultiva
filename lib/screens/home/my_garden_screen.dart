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

/// Incrémenté à chaque reset du starter depuis les paramètres.
/// Le [_TamassiView] l'écoute pour recharger l'état du starter.
final ValueNotifier<int> tamassiResetNotifier = ValueNotifier<int>(0);

/// Heure forcée pour le debug (0-23) ou null = heure réelle.
/// Utilisée par le fond kawaii + la bulle de greeting pour pouvoir
/// vérifier les 4 ambiances sans attendre.
final ValueNotifier<int?> debugHourOverride = ValueNotifier<int?>(null);

/// Heure effective : override si set, sinon heure système.
int effectiveHour() =>
    debugHourOverride.value ?? DateTime.now().hour;

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
    tamassiResetNotifier.addListener(_onTamassiResetExternal);
  }

  void _onTamassiResetExternal() {
    // Après un reset depuis les paramètres : relance le tuto.
    _showTutorialIfNeeded();
  }

  @override
  void dispose() {
    tamassiResetNotifier.removeListener(_onTamassiResetExternal);
    super.dispose();
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
    if (mounted) setState(() {});
    // La créature célèbre le défi complété et gagne +20 XP.
    _tamassiKey.currentState?.triggerCelebration();
    _tamassiKey.currentState?.awardChallengeXp();
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
    final showActions = _filter == _AlbumFilter.tamassi;
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
            // Boutons Arroser + Engrais centrés sous les onglets (Tamassi
            // uniquement).
            if (showActions)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _TamassiActionButton(
                      label: 'Arroser',
                      icon: Icons.water_drop,
                      color: Colors.blue.shade400,
                      onTap: _onWater,
                    ),
                    const SizedBox(width: 12),
                    _TamassiActionButton(
                      label: 'Engrais',
                      icon: Icons.eco,
                      color: KultivaColors.terracotta,
                      onTap: _onFertilize,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  void _onWater() {
    AudioService.instance.play(Sfx.water);
    _tamassiKey.currentState?.triggerEffect(_TamassiEffect.water);
  }

  void _onFertilize() {
    AudioService.instance.play(Sfx.fertilize);
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

/// Vue Tamassi — la créature du joueur avec animations.
/// Si aucun starter n'est choisi, affiche l'écran de sélection.
class _TamassiView extends StatefulWidget {
  const _TamassiView({super.key});

  @override
  State<_TamassiView> createState() => _TamassiViewState();
}

class _TamassiViewState extends State<_TamassiView>
    with TickerProviderStateMixin {
  static const _kStarter = 'kultiva.creature.starter';
  static const _kName = 'kultiva.creature.name';
  static const _kStreak = 'kultiva.creature.streak';
  static const _kLastSeen = 'kultiva.creature.lastSeen';

  double _level = 5;
  late final AnimationController _effectCtrl;
  late final AnimationController _crossingCtrl;
  late final AnimationController _evolveCtrl;
  late final AnimationController _celebrateCtrl;
  late final AnimationController _ambientCtrl;
  _TamassiEffect? _effect;

  CreatureStarter? _starter;
  String _creatureName = '';
  int _streak = 0;

  // XP réel (différent de _level qui vient du slider debug).
  // Gagné via Arroser (+5), Engrais (+10), Défi complété (+20).
  int _xp = 0;
  static const _kXp = 'kultiva.creature.xp';
  static const _kLastWater = 'kultiva.creature.lastWater';
  static const _kLastFertilize = 'kultiva.creature.lastFertilize';
  static const _kLastCaress = 'kultiva.creature.lastCaress';

  String _prevStage = '';
  bool _showEvolve = false;
  bool _celebrating = false;

  bool _showGreeting = false;
  Timer? _greetingTimer;
  Timer? _crossingTimer;
  _CrossingAnimal? _currentCrossing;
  bool _crossingLTR = true;
  WeatherData? _weatherCache;

  @override
  void initState() {
    super.initState();
    _effectCtrl = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );
    _crossingCtrl = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );
    _evolveCtrl = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );
    _celebrateCtrl = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _ambientCtrl = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _loadCreature();
    _loadXp();
    _prevStage = _stageName;
    _updateStreak();
    _showGreetingBubble();
    _scheduleCrossing();
    _loadWeatherCache();
    tamassiResetNotifier.addListener(_onResetRequested);
  }

  Future<void> _loadWeatherCache() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weatherCache = w);
  }

  void _loadXp() {
    final stored = PrefsService.instance.getString(_kXp);
    final xp = stored == null ? 1 : int.tryParse(stored) ?? 1;
    _xp = xp.clamp(1, 100);
    _level = _xp.toDouble();
  }

  bool _canAct(String dayKeyPref) {
    final todayKey = _todayKey();
    return PrefsService.instance.getString(dayKeyPref) != todayKey;
  }

  String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month}-${d.day}';
  }

  Future<void> _gainXp(int amount, String reason) async {
    final oldLevel = _xp;
    final newLevel = (_xp + amount).clamp(1, 100);
    if (newLevel == oldLevel) return;
    setState(() {
      _xp = newLevel;
      _level = _xp.toDouble();
    });
    await PrefsService.instance.setString(_kXp, _xp.toString());
    _checkLevelUp();
    // Toast "+X XP" en haut de l'écran.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('+$amount XP · $reason'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          backgroundColor: KultivaColors.primaryGreen,
        ),
      );
    }
  }

  void _onResetRequested() {
    if (!mounted) return;
    PrefsService.instance.setString(_kXp, '1');
    PrefsService.instance.setString(_kLastWater, '');
    PrefsService.instance.setString(_kLastFertilize, '');
    PrefsService.instance.setString(_kLastCaress, '');
    setState(() {
      _starter = null;
      _creatureName = '';
      _xp = 1;
      _level = 1;
    });
  }

  /// Déclenché par le parent quand un défi est complété.
  void triggerCelebration() {
    HapticFeedback.heavyImpact();
    AudioService.instance.play(Sfx.celebrate);
    setState(() => _celebrating = true);
    _celebrateCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _celebrating = false);
    });
  }

  void _checkLevelUp() {
    final newStage = _stageName;
    if (newStage != _prevStage) {
      _prevStage = newStage;
      HapticFeedback.mediumImpact();
      AudioService.instance.play(Sfx.levelUp);
      setState(() => _showEvolve = true);
      _evolveCtrl.forward(from: 0).whenComplete(() {
        if (mounted) setState(() => _showEvolve = false);
      });
    }
  }

  void _updateStreak() {
    final prefs = PrefsService.instance;
    final lastSeenRaw = prefs.getString(_kLastSeen);
    final storedStreak = int.tryParse(prefs.getString(_kStreak) ?? '') ?? 0;
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month}-${today.day}';
    int next = storedStreak;
    if (lastSeenRaw == null) {
      next = 1;
    } else if (lastSeenRaw == todayKey) {
      // Déjà vu aujourd'hui : pas de changement.
      next = storedStreak > 0 ? storedStreak : 1;
    } else {
      final last = DateTime.tryParse(lastSeenRaw);
      if (last == null) {
        next = 1;
      } else {
        final diff = today.difference(last).inDays;
        next = diff == 1 ? storedStreak + 1 : 1;
      }
    }
    prefs.setString(_kLastSeen, todayKey);
    prefs.setString(_kStreak, next.toString());
    _streak = next;
  }

  String get _moodEmoji {
    if (_streak >= 7) return '🤩';
    if (_streak >= 3) return '😄';
    if (_streak >= 1) return '😊';
    return '😐';
  }

  bool get _isNight {
    final h = effectiveHour();
    return h >= 21 || h < 6;
  }

  void _showGreetingBubble() {
    if (_starter == null) return;
    setState(() => _showGreeting = true);
    _greetingTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showGreeting = false);
    });
  }

  String _greetingText() {
    final hour = effectiveHour();
    if (hour < 6) return 'Chut… 💤';
    if (hour < 12) return 'Bonjour ! ☀️';
    if (hour < 18) return 'Coucou ! 🌸';
    if (hour < 22) return 'Bonsoir ! 🌙';
    return 'Bonne nuit ! 💤';
  }

  void _scheduleCrossing() {
    _crossingTimer = Timer(
      Duration(seconds: 25 + Random().nextInt(35)),
      () {
        if (!mounted) return;
        final pool = _animalPoolForHour(effectiveHour());
        final animal = pool[Random().nextInt(pool.length)];
        setState(() {
          _currentCrossing = animal;
          _crossingLTR = !_crossingLTR;
        });
        _crossingCtrl.duration =
            Duration(milliseconds: animal.durationMs);
        _crossingCtrl.forward(from: 0).whenComplete(() {
          if (mounted) setState(() => _currentCrossing = null);
        });
        _scheduleCrossing();
      },
    );
  }

  List<_CrossingAnimal> _animalPoolForHour(int hour) {
    final pool = <_CrossingAnimal>[];
    if (hour >= 6 && hour < 12) {
      pool.addAll(const <_CrossingAnimal>[
        _CrossingAnimal(
            emoji: '🐦', style: _CrossingStyle.flyHigh, durationMs: 5000),
        _CrossingAnimal(
            emoji: '🐝', style: _CrossingStyle.zigzag, durationMs: 6000),
      ]);
    } else if (hour >= 12 && hour < 18) {
      pool.addAll(const <_CrossingAnimal>[
        _CrossingAnimal(
            emoji: '🦋', style: _CrossingStyle.zigzag, durationMs: 6000),
        _CrossingAnimal(
            emoji: '🐞', style: _CrossingStyle.groundSlow, durationMs: 8000),
        _CrossingAnimal(
            emoji: '🐛', style: _CrossingStyle.groundSlow, durationMs: 9000),
      ]);
    } else if (hour >= 18 && hour < 21) {
      pool.addAll(const <_CrossingAnimal>[
        _CrossingAnimal(
            emoji: '🦔', style: _CrossingStyle.groundSlow, durationMs: 8000),
        _CrossingAnimal(
            emoji: '🐸', style: _CrossingStyle.hop, durationMs: 5000),
        _CrossingAnimal(
            emoji: '🐿️', style: _CrossingStyle.groundSlow, durationMs: 4000),
      ]);
    } else {
      // Nuit : chouette + chauve-souris (lucioles permanentes).
      pool.addAll(const <_CrossingAnimal>[
        _CrossingAnimal(
            emoji: '🦉', style: _CrossingStyle.flyHigh, durationMs: 5500),
        _CrossingAnimal(
            emoji: '🦇', style: _CrossingStyle.zigzag, durationMs: 5000),
      ]);
    }
    // Bonus météo : renforce la cohérence avec le fond.
    final code = _weatherCache?.currentWeatherCode;
    if (code != null) {
      if (code >= 51 && code <= 67 || code >= 80 && code <= 82) {
        // Pluie : grenouille + escargot.
        pool.addAll(const <_CrossingAnimal>[
          _CrossingAnimal(
              emoji: '🐸', style: _CrossingStyle.hop, durationMs: 5000),
          _CrossingAnimal(
              emoji: '🐌',
              style: _CrossingStyle.groundSlow,
              durationMs: 11000),
        ]);
      } else if (code >= 71 && code <= 77) {
        // Neige : pingouin qui glisse.
        pool.add(const _CrossingAnimal(
            emoji: '🐧', style: _CrossingStyle.groundSlow, durationMs: 6500));
      } else if (code == 0 || code == 1) {
        // Grand soleil : abeille supplémentaire.
        pool.add(const _CrossingAnimal(
            emoji: '🐝', style: _CrossingStyle.zigzag, durationMs: 6000));
      }
    }
    return pool;
  }

  void _loadCreature() {
    final raw = PrefsService.instance.getString(_kStarter);
    if (raw != null) {
      _starter = CreatureStarter.values.firstWhere(
        (s) => s.name == raw,
        orElse: () => CreatureStarter.poussia,
      );
      _creatureName = PrefsService.instance.getString(_kName) ?? '';
    }
  }

  Future<void> _selectStarter(CreatureStarter starter) async {
    AudioService.instance.play(Sfx.creatureTap);
    final name = await _askName(context, starter);
    if (name == null || name.trim().isEmpty) return;
    AudioService.instance.play(Sfx.success);
    await PrefsService.instance.setString(_kStarter, starter.name);
    await PrefsService.instance.setString(_kName, name.trim());
    if (!mounted) return;
    setState(() {
      _starter = starter;
      _creatureName = name.trim();
    });
    _showGreetingBubble();
  }

  Future<String?> _askName(
      BuildContext context, CreatureStarter starter) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Nomme ta ${starter.name[0].toUpperCase()}${starter.name.substring(1)} !',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: 'Ex: Poupoune, Sunny, Twisty…',
          ),
          onSubmitted: (v) {
            if (v.trim().isNotEmpty) Navigator.pop(ctx, v.trim());
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              final v = controller.text.trim();
              if (v.isNotEmpty) Navigator.pop(ctx, v);
            },
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _greetingTimer?.cancel();
    _crossingTimer?.cancel();
    _effectCtrl.dispose();
    _crossingCtrl.dispose();
    _evolveCtrl.dispose();
    _celebrateCtrl.dispose();
    _ambientCtrl.dispose();
    tamassiResetNotifier.removeListener(_onResetRequested);
    super.dispose();
  }

  /// Déclenche l'effet visuel (gouttes/étincelles) et gagne de l'XP
  /// si l'action n'a pas encore été faite aujourd'hui.
  void triggerEffect(_TamassiEffect effect) {
    HapticFeedback.mediumImpact();
    setState(() => _effect = effect);
    _effectCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _effect = null);
    });
    final todayKey = _todayKey();
    if (effect == _TamassiEffect.water) {
      if (_canAct(_kLastWater)) {
        PrefsService.instance.setString(_kLastWater, todayKey);
        _gainXp(1, '💧 Arrosage quotidien');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💧 Déjà arrosé aujourd\'hui — reviens demain !'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      if (_canAct(_kLastFertilize)) {
        PrefsService.instance.setString(_kLastFertilize, todayKey);
        _gainXp(2, '🌿 Engrais quotidien');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🌿 Déjà fertilisé aujourd\'hui — reviens demain !'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  /// Appelée quand un défi photo est complété (+3 XP).
  void awardChallengeXp() {
    _gainXp(3, '📸 Défi complété !');
  }

  /// Tap sur la créature — caresse quotidienne (+3 XP).
  void _onCaress() {
    if (_canAct(_kLastCaress)) {
      PrefsService.instance.setString(_kLastCaress, _todayKey());
      _gainXp(3, '💕 Caresse quotidienne');
    }
    // Pas de snackbar "déjà caressé" — sinon on spammerait à chaque tap.
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
    // Pas de starter choisi → écran de sélection.
    if (_starter == null) {
      return _buildStarterSelection();
    }
    return _buildCreatureView();
  }

  Widget _buildStarterSelection() {
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: _KawaiiBackground()),
        SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Choisis ton compagnon',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Il t\'accompagnera dans tes aventures !',
                style: TextStyle(
                  fontSize: 13,
                  color: KultivaColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/creatures/3.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Text('🌱🌻🌿',
                                    style: TextStyle(fontSize: 64)),
                              ),
                            ),
                          ),
                          // Zones cliquables : 3 tiers de l'image.
                          Positioned.fill(
                            child: Row(
                              children: <Widget>[
                                // Gauche : Soleia.
                                Expanded(
                                  child: _StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.soleia),
                                  ),
                                ),
                                // Centre : Spira.
                                Expanded(
                                  child: _StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.spira),
                                  ),
                                ),
                                // Droite : Poussia.
                                Expanded(
                                  child: _StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.poussia),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Text(
                  '👆 Tape sur ton compagnon',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreatureView() {
    final lv = _level.round();
    final screenWidth = MediaQuery.of(context).size.width;
    final creatureSize = min(screenWidth * 0.9, 420.0);
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: _KawaiiBackground()),
        // Bouton debug "+10 XP" en haut à droite (test d'évolution).
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            child: Material(
              color: Colors.black.withOpacity(0.55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => _gainXp(10, '🧪 Debug'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    '+10 XP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Animal qui traverse l'écran (selon l'heure).
        if (_currentCrossing != null)
          AnimatedBuilder(
            animation: _crossingCtrl,
            builder: (context, _) {
              final anim = _currentCrossing!;
              final p = _crossingCtrl.value;
              final w = MediaQuery.of(context).size.width;
              final h = MediaQuery.of(context).size.height;
              final x = _crossingLTR
                  ? -80 + p * (w + 160)
                  : w + 80 - p * (w + 160);
              late final double y;
              late final double rotateZ;
              late final double rotateY;
              switch (anim.style) {
                case _CrossingStyle.flyHigh:
                  // Vol haut, ligne quasi droite avec léger bob.
                  y = 100.0 + 18.0 * sin(p * pi * 4);
                  rotateZ = _crossingLTR ? -0.08 : 0.08;
                  rotateY = sin(p * pi * 8) * 0.3;
                  break;
                case _CrossingStyle.zigzag:
                  // Vol moyen en arc + battement.
                  y = 140.0 +
                      80.0 * (1 - (p - 0.5).abs() * 2) +
                      18.0 * sin(p * pi * 6);
                  rotateZ = _crossingLTR ? -0.1 : 0.1;
                  rotateY = sin(p * pi * 12) * 0.4;
                  break;
                case _CrossingStyle.groundSlow:
                  // Déplacement au sol, légère ondulation.
                  y = h * 0.78 + 4.0 * sin(p * pi * 10);
                  rotateZ = 0;
                  rotateY = _crossingLTR ? 0 : pi; // miroir
                  break;
                case _CrossingStyle.hop:
                  // Série de bonds paraboliques.
                  final hopPhase = (p * 4) % 1.0;
                  final hopHeight = 40.0 * (1 - (hopPhase * 2 - 1) * (hopPhase * 2 - 1));
                  y = h * 0.75 - hopHeight;
                  rotateZ = 0;
                  rotateY = _crossingLTR ? 0 : pi;
                  break;
              }
              return Positioned(
                left: x,
                top: y,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(rotateZ)
                    ..rotateY(rotateY),
                  child: Text(
                    anim.emoji,
                    style: TextStyle(fontSize: anim.size),
                  ),
                ),
              );
            },
          ),
        Column(
          children: <Widget>[
            // En-tête : nom de la créature (petit, centré, en haut).
            const SizedBox(height: 8),
            Text(
              _creatureName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Niveau $lv',
              style: TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_streak >= 2) ...<Widget>[
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.orange.shade300, width: 1),
                ),
                child: Text(
                  '🔥 $_streak jours',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            ],
            const Spacer(flex: 12),
            SizedBox(
              width: creatureSize,
              height: creatureSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: PlantCreature(
                      level: lv,
                      size: creatureSize,
                      starter: _starter!,
                      onTap: _onCaress,
                    ),
                  ),
                  // Lucioles qui tournoient autour de la créature la nuit.
                  if (_isNight)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _ambientCtrl,
                          builder: (_, __) => CustomPaint(
                            painter: _FireflyOrbitPainter(
                              progress: _ambientCtrl.value,
                            ),
                          ),
                        ),
                      ),
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
                  // Bulle de greeting (Bonjour/Coucou/Bonsoir...).
                  if (_showGreeting)
                    Positioned(
                      top: -8,
                      left: creatureSize * 0.55,
                      child: _SpeechBubble(text: _greetingText()),
                    ),
                  // Évolution : grande animation cinématique (4.5s).
                  if (_showEvolve)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _evolveCtrl,
                          builder: (_, __) {
                            final p = _evolveCtrl.value;
                            // Phase 1 : flash blanc (0-0.15)
                            // Phase 2 : rayons magiques qui tournent (0.05-0.85)
                            // Phase 3 : bandeau ÉVOLUTION qui grandit (0.2-0.9)
                            // Phase 4 : fade out tout (0.85-1.0)
                            final flashOpacity = p < 0.15
                                ? (p / 0.15) * 0.9
                                : p < 0.35
                                    ? 0.9 - ((p - 0.15) / 0.2) * 0.6
                                    : p > 0.85
                                        ? (1 - p) / 0.15 * 0.3
                                        : 0.3;
                            final raysProgress = (p - 0.05).clamp(0.0, 0.85);
                            final raysOpacity = p < 0.85
                                ? (raysProgress * 2).clamp(0.0, 1.0) *
                                    (p > 0.7 ? (0.85 - p) / 0.15 : 1.0)
                                : 0.0;
                            final bannerP = ((p - 0.2) / 0.65).clamp(0.0, 1.0);
                            final bannerOpacity = p < 0.9
                                ? bannerP.clamp(0.0, 1.0) *
                                    (p > 0.8 ? (0.9 - p) / 0.1 : 1.0)
                                : 0.0;
                            final bannerScale = 0.3 +
                                bannerP * 1.0 +
                                sin(bannerP * pi) * 0.05;
                            return Stack(
                              children: <Widget>[
                                // Flash blanc.
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.white
                                        .withOpacity(flashOpacity),
                                  ),
                                ),
                                // Rayons lumineux rotatifs.
                                if (raysOpacity > 0)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _EvolutionRaysPainter(
                                        progress: raysProgress,
                                        opacity: raysOpacity,
                                      ),
                                    ),
                                  ),
                                // Particules qui explosent.
                                if (p > 0.1 && p < 0.95)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _ConfettiPainter(
                                        progress: ((p - 0.1) / 0.85)
                                            .clamp(0.0, 1.0),
                                      ),
                                    ),
                                  ),
                                // Bandeau "ÉVOLUTION !".
                                Center(
                                  child: Transform.scale(
                                    scale: bannerScale,
                                    child: Opacity(
                                      opacity: bannerOpacity,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26, vertical: 14),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: <Color>[
                                              Color(0xFFFFE066),
                                              Color(0xFFFFB04C),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: const Color(0xFFFFB04C)
                                                  .withOpacity(0.7),
                                              blurRadius: 24,
                                              spreadRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text(
                                              '✨ ÉVOLUTION ✨',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 26,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _stageName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  // "Bravo !" sur célébration (défi complété).
                  if (_celebrating)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _celebrateCtrl,
                          builder: (_, __) {
                            final p = _celebrateCtrl.value;
                            return CustomPaint(
                              painter: _ConfettiPainter(progress: p),
                              child: Center(
                                child: Transform.scale(
                                  scale: 0.6 + (1 - (p - 0.5).abs() * 2) * 0.5,
                                  child: Opacity(
                                    opacity: (1 - p).clamp(0.0, 1.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        '🎉 Bravo ! 🎉',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            // Barre d'XP : progression vers la prochaine évolution.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
              child: _XpBar(level: lv),
            ),
            // Slider debug (à retirer quand le système XP sera branché).
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
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
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                          _xp = v.round();
                        });
                        PrefsService.instance
                            .setString(_kXp, _xp.toString());
                        _checkLevelUp();
                      },
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

/// Zone cliquable transparente sur l'image de sélection du starter.
/// Affiche un petit scale + glow au tap (press).
class _StarterTapZone extends StatefulWidget {
  final VoidCallback onTap;
  const _StarterTapZone({required this.onTap});

  @override
  State<_StarterTapZone> createState() => _StarterTapZoneState();
}

class _StarterTapZoneState extends State<_StarterTapZone> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: _pressed ? Colors.white.withOpacity(0.25) : Colors.transparent,
        ),
      ),
    );
  }
}

/// Bouton d'action Arroser / Engrais sous les onglets Tamassi.
class _TamassiActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TamassiActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Style de trajectoire d'un animal qui traverse l'écran.
enum _CrossingStyle { flyHigh, zigzag, groundSlow, hop }

/// Animal qui traverse l'écran. L'emoji et la trajectoire dépendent
/// de l'heure (pool dans `_animalPoolForHour`).
class _CrossingAnimal {
  final String emoji;
  final _CrossingStyle style;
  final double size;
  final int durationMs;

  const _CrossingAnimal({
    required this.emoji,
    required this.style,
    this.size = 32,
    this.durationMs = 6000,
  });
}

/// Seuils d'évolution de la créature (11 stades).
const List<int> _kEvolutionThresholds = <int>[
  1, 5, 10, 15, 20, 30, 40, 50, 60, 75, 100,
];

/// Barre de progression XP vers la prochaine évolution.
class _XpBar extends StatelessWidget {
  final int level;
  const _XpBar({required this.level});

  (int, int) get _bounds {
    int cur = _kEvolutionThresholds.first;
    int next = _kEvolutionThresholds.last;
    for (int i = 0; i < _kEvolutionThresholds.length; i++) {
      final t = _kEvolutionThresholds[i];
      if (t <= level) {
        cur = t;
        next = i + 1 < _kEvolutionThresholds.length
            ? _kEvolutionThresholds[i + 1]
            : t;
      }
    }
    return (cur, next);
  }

  @override
  Widget build(BuildContext context) {
    final (cur, next) = _bounds;
    final maxed = cur == next;
    final progress = maxed
        ? 1.0
        : ((level - cur) / (next - cur)).clamp(0.0, 1.0);
    const accent = Color(0xFFE8808E); // rose-rouge du contour
    const fill = Color(0xFFE8A8B0); // rose rempli
    const track = Color(0xFFFFF5F5); // blanc rosé (fond de barre)
    const barHeight = 22.0;
    const peachSize = 42.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            return SizedBox(
              height: peachSize + 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  // Barre (fond + remplissage + contour).
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: track,
                        borderRadius: BorderRadius.circular(barHeight / 2),
                        border: Border.all(color: accent, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(barHeight / 2),
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          tween: Tween<double>(begin: 0, end: progress),
                          builder: (context, value, _) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: value.clamp(0.0, 1.0),
                                heightFactor: 1.0,
                                child: Container(color: fill),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Texte "Prochain niveau : N" à droite dans la barre.
                  Positioned(
                    right: 12,
                    bottom: 0,
                    height: barHeight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        maxed ? 'Niveau max' : 'Prochain niveau : $next',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                  // 🍑 Pêche qui se déplace avec la progression.
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    tween: Tween<double>(begin: 0, end: progress),
                    builder: (context, value, _) {
                      final x = (barWidth * value.clamp(0.0, 1.0)) -
                          peachSize / 2;
                      return Positioned(
                        left: x.clamp(-peachSize / 2,
                            barWidth - peachSize / 2),
                        top: 0,
                        child: const Text(
                          '🍑',
                          style: TextStyle(fontSize: peachSize),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Painter qui dessine 8 lucioles tournant lentement autour de la
/// créature pendant la nuit. Chaque luciole a sa propre orbite, phase
/// et clignotement indépendant.
class _FireflyOrbitPainter extends CustomPainter {
  final double progress;
  _FireflyOrbitPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final baseRadius = size.width * 0.42;
    const count = 8;
    for (int i = 0; i < count; i++) {
      final speed = 0.5 + (i % 3) * 0.15;
      final angle = (progress * speed + i / count) * 2 * pi;
      // Rayon variable sur chaque luciole.
      final radiusVariation =
          1.0 + 0.15 * sin(progress * 2 * pi + i * 1.1);
      final r = baseRadius * (0.85 + (i % 2) * 0.1) * radiusVariation;
      // Léger bob vertical.
      final yBob = sin(progress * 4 * pi + i * 0.8) * size.height * 0.02;
      final p = center + Offset(cos(angle) * r, sin(angle) * r * 0.6 + yBob);
      // Clignotement : sinusoïde décalée pour chaque luciole.
      final blink = (sin(progress * 4 * pi + i * 1.6) * 0.5 + 0.5);
      final opacity = (0.3 + blink * 0.7).clamp(0.0, 1.0);
      // Halo doux autour du point lumineux.
      canvas.drawCircle(
        p, 10,
        Paint()
          ..color = const Color(0xFFFFF3A0).withOpacity(opacity * 0.22)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
      // Point lumineux.
      canvas.drawCircle(
        p, 3.2,
        Paint()..color = const Color(0xFFFFE37A).withOpacity(opacity),
      );
      // Reflet blanc central.
      canvas.drawCircle(
        p, 1.4,
        Paint()..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FireflyOrbitPainter old) =>
      old.progress != progress;
}

/// Rayons lumineux qui tournent pendant l'animation d'évolution.
class _EvolutionRaysPainter extends CustomPainter {
  final double progress;
  final double opacity;
  _EvolutionRaysPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.45);
    final maxRadius = size.longestSide;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(progress * pi * 2);
    const rayCount = 14;
    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 2 * pi / rayCount);
      final rayPath = Path()
        ..moveTo(0, 0)
        ..lineTo(cos(angle - 0.04) * maxRadius,
            sin(angle - 0.04) * maxRadius)
        ..lineTo(
            cos(angle + 0.04) * maxRadius, sin(angle + 0.04) * maxRadius)
        ..close();
      canvas.drawPath(
        rayPath,
        Paint()
          ..shader = RadialGradient(
            colors: <Color>[
              Color.lerp(
                      const Color(0xFFFFE066),
                      const Color(0xFFFFB04C),
                      (i % 2).toDouble())!
                  .withOpacity(opacity * 0.7),
              Colors.transparent,
            ],
          ).createShader(
              Rect.fromCircle(center: Offset.zero, radius: maxRadius)),
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _EvolutionRaysPainter old) =>
      old.progress != progress || old.opacity != opacity;
}

/// Confetti painter for the "Bravo !" celebration when a challenge is
/// completed.
class _ConfettiPainter extends CustomPainter {
  final double progress;
  _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(314);
    const count = 28;
    final colors = <Color>[
      const Color(0xFFFF8FAB),
      const Color(0xFFFFE066),
      const Color(0xFF6FB87A),
      const Color(0xFF7BAFD4),
      const Color(0xFFC77DFF),
    ];
    for (int i = 0; i < count; i++) {
      final angle = rng.nextDouble() * pi * 2;
      final speed = 0.8 + rng.nextDouble() * 0.6;
      final dist = progress * size.width * 0.55 * speed;
      final x = size.width / 2 + cos(angle) * dist;
      final y = size.height / 2 +
          sin(angle) * dist +
          progress * progress * size.height * 0.25; // gravity
      final c = colors[i % colors.length];
      final rot = rng.nextDouble() * pi * 2 + progress * pi * 4;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 9, height: 4),
        Paint()..color = c.withOpacity((1 - progress).clamp(0.0, 1.0)),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}

/// Petite bulle de dialogue kawaii pour les salutations.
class _SpeechBubble extends StatelessWidget {
  final String text;
  const _SpeechBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _StarterButton extends StatelessWidget {
  final String label;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const _StarterButton({
    required this.label,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color, width: 2.5),
          ),
          child: Column(
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
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
    debugHourOverride.addListener(_onHourChanged);
  }

  void _onHourChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    debugHourOverride.removeListener(_onHourChanged);
    _particleCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadWeather() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weather = w);
  }

  @override
  Widget build(BuildContext context) {
    final hour = effectiveHour();
    final isNight = hour >= 21 || hour < 6;
    final gradient = _gradientForHour(hour);
    final assetPath = _backgroundAssetForHour(hour);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Fond : image PNG si dispo, sinon gradient procédural.
        Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
              ..._staticDecorations(hour),
            ],
          ),
        ),
        // Particules météo / saison (toujours par-dessus).
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
    );
  }

  String _backgroundAssetForHour(int hour) {
    if (hour >= 6 && hour < 12) {
      return 'assets/images/backgrounds/morning.png';
    }
    if (hour >= 12 && hour < 18) {
      return 'assets/images/backgrounds/afternoon.png';
    }
    if (hour >= 18 && hour < 21) {
      return 'assets/images/backgrounds/evening.png';
    }
    return 'assets/images/backgrounds/night.png';
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
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(_AlbumFilter.tamassi);
            },
          ),
          _FilterChip(
            label: '📸 Défis',
            count: 0,
            hideCount: true,
            selected: filter == _AlbumFilter.challenges,
            color: const Color(0xFFFF8FAB),
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(_AlbumFilter.challenges);
            },
          ),
          _FilterChip(
            label: '🏆 Badges',
            count: badgesCount,
            total: totalBadges,
            selected: filter == _AlbumFilter.badges,
            color: const Color(0xFFE8B923),
            onTap: () {
              AudioService.instance.play(Sfx.tap);
              onChanged(_AlbumFilter.badges);
            },
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

