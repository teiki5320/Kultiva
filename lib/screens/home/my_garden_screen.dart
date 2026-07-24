import 'package:flutter/material.dart';

import '../../services/tamassi_stats.dart';
import '../root_tabs.dart';

import '../../data/badges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/audio_service.dart';
import '../../services/plantation_migration.dart';
import '../../services/prefs_service.dart';
import '../../services/review_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';
import 'my_garden/garden_header.dart';
import 'my_garden/tamassi_view.dart';
import 'poussidex/poussidex_badges.dart';
import 'poussidex/poussidex_challenges.dart';

/// Incrémenté à chaque reset du starter depuis les paramètres.
/// Le [TamassiView] l'écoute pour recharger l'état du starter.
final ValueNotifier<int> tamassiResetNotifier = ValueNotifier<int>(0);

/// Heure forcée pour le debug (0-23) ou null = heure réelle.
/// Utilisée par le fond kawaii + la bulle de greeting pour pouvoir
/// vérifier les 4 ambiances sans attendre.
final ValueNotifier<int?> debugHourOverride = ValueNotifier<int?>(null);

/// Heure effective : override si set, sinon heure système.
int effectiveHour() => debugHourOverride.value ?? DateTime.now().hour;

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
  AlbumFilter _filter = AlbumFilter.tamassi;
  bool _loaded = false;

  /// Total d'espèces collectionnables (tous les légumes sauf accessoires).
  static final int _totalSpecies = vegetablesBase
      .where((v) => v.category != VegetableCategory.accessories)
      .length;

  @override
  void initState() {
    super.initState();
    _bootstrap();
    tamassiResetNotifier.addListener(_onTamassiResetExternal);
    RootTabs.poussidexFilter.addListener(_onPoussidexFilterExternal);
  }

  void _onTamassiResetExternal() {
    // Après un reset depuis les paramètres : relance le tuto.
    _showTutorialIfNeeded();
  }

  /// Un deep-link `kultiva://poussidex/<section>` a demandé à basculer
  /// sur une section précise (tamassi / challenges / badges).
  void _onPoussidexFilterExternal() {
    final name = RootTabs.poussidexFilter.value;
    if (name == null || !mounted) return;
    AlbumFilter? next;
    switch (name) {
      case 'tamassi':
        next = AlbumFilter.tamassi;
        break;
      case 'challenges':
      case 'feed':
        next = AlbumFilter.challenges;
        break;
      case 'badges':
        next = AlbumFilter.badges;
        break;
    }
    if (next != null && next != _filter) {
      setState(() => _filter = next!);
    }
    // Consomme la demande pour ne pas re-déclencher.
    RootTabs.poussidexFilter.value = null;
  }

  /// Lit l'XP courant depuis les prefs (partagé avec TamassiViewState).
  int _currentXp() {
    final raw = PrefsService.instance.getString('kultiva.creature.xp') ?? '';
    return int.tryParse(raw) ?? 1;
  }

  @override
  void dispose() {
    tamassiResetNotifier.removeListener(_onTamassiResetExternal);
    RootTabs.poussidexFilter.removeListener(_onPoussidexFilterExternal);
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await _maybeMigrate();
    _plantations = Plantation.decodeAll(PrefsService.instance.plantationsJson);
    // UNION avec les badges déjà débloqués (restaurés du cloud ou gagnés
    // par des actions dont les stats sont purement locales) : on ne
    // recalcule QUE pour AJOUTER d'éventuels badges de niveau, jamais pour
    // remplacer le set — sinon un boot après réinstallation révoquait les
    // badges d'action jusqu'au prochain merge cloud.
    final storedBadges = PrefsService.instance.unlockedBadges;
    final levelBadges = computeUnlockedBadges(level: _currentXp());
    _unlockedBadges = <String>{...storedBadges, ...levelBadges};
    _medals = computeAllMedals(_plantations,
        region: PrefsService.instance.region.value);
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

  final GlobalKey<TamassiViewState> _tamassiKey = GlobalKey<TamassiViewState>();

  /// Convertit l'ancienne grille 2D en plantations une seule fois,
  /// puis marque la migration comme faite pour ne plus la rejouer.
  Future<void> _maybeMigrate() async {
    if (PrefsService.instance.gridMigrated) return;
    final legacy = PrefsService.instance.gardenGrid;
    final migrated = migrateGridToPlantations(legacy);
    if (migrated.isNotEmpty) {
      // Fusionne avec les plantations déjà présentes (ex. restaurées du
      // cloud par mergeOnLogin) au lieu de les écraser par les seules
      // entrées de la grille legacy.
      final existing =
          Plantation.decodeAll(PrefsService.instance.plantationsJson);
      final byId = <String, Plantation>{for (final p in existing) p.id: p};
      for (final p in migrated) {
        final prev = byId[p.id];
        byId[p.id] = prev == null ? p : Plantation.merge(prev, p);
      }
      await PrefsService.instance
          .setPlantationsJson(Plantation.encodeAll(byId.values.toList()));
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

  /// Appelé quand l'user soumet une photo pour un défi.
  void _onChallengePhotoTaken(String challengeId, String photoPath) {
    if (mounted) setState(() {});
    // La créature célèbre le défi complété et gagne +20 XP.
    _tamassiKey.currentState?.triggerCelebration();
    _tamassiKey.currentState?.awardChallengeXp(challengeId);
    // Moment positif : on peut solliciter (au plus une fois) une note store.
    ReviewService.instance
        .maybeRequestReview(unlockedBadgeCount: _unlockedBadges.length);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final showActions = _filter == AlbumFilter.tamassi;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            GardenHeader(
              plantationsCount: _plantations.length,
              speciesCount: _medals.length,
              totalSpecies: _totalSpecies,
              unlockedCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
            ),
            GardenFilterBar(
              filter: _filter,
              challengesCount: 0,
              badgesCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
              onChanged: (f) {
                setState(() => _filter = f);
                TamassiStats.recordTab(f.name);
              },
            ),
            // Boutons Arroser + Engrais centrés sous les onglets (Tamassi
            // uniquement).
            if (showActions)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TamassiActionButton(
                      label: 'Arroser',
                      icon: Icons.water_drop,
                      color: KultivaColors.waterBlue,
                      onTap: _onWater,
                    ),
                    const SizedBox(width: 12),
                    TamassiActionButton(
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
    _tamassiKey.currentState?.triggerEffect(TamassiEffect.water);
  }

  void _onFertilize() {
    AudioService.instance.play(Sfx.fertilize);
    _tamassiKey.currentState?.triggerEffect(TamassiEffect.fertilize);
  }

  Widget _buildBody() {
    switch (_filter) {
      case AlbumFilter.tamassi:
        return TamassiView(key: _tamassiKey);
      case AlbumFilter.challenges:
        return PoussidexChallengesGrid(
          onPhotoTaken: _onChallengePhotoTaken,
        );
      case AlbumFilter.badges:
        // Recalcul live à chaque ouverture de l'onglet pour refléter
        // les dernières stats (water, pet, challenges, etc.).
        final live = computeUnlockedBadges(level: _currentXp());
        return PoussidexBadgesGrid(unlocked: live);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Empty states spécifiques à chaque filtre
// ═══════════════════════════════════════════════════════════════════════════
