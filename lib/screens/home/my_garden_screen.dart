import 'package:flutter/material.dart';

import '../root_tabs.dart';

import '../../data/badges.dart';
import '../../data/challenges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../models/vegetable_medal.dart';
import '../../services/garden_stats.dart';
import '../../services/plantation_service.dart';
import '../../services/prefs_service.dart';
import '../../services/review_service.dart';
import '../../widgets/garden_tutorial_sheet.dart';
import 'my_garden/garden_header.dart';
import 'poussidex/poussidex_badges.dart';
import 'poussidex/poussidex_challenges.dart';
import 'poussidex/poussidex_collection.dart';

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
  AlbumFilter _filter = AlbumFilter.collection;
  bool _loaded = false;

  /// Défis photo déjà réalisés. La pastille affichait « 0 » en dur,
  /// masqué par un `hideCount` : l'onglet Badges annonçait sa
  /// progression, l'onglet Défis faisait semblant.
  int get _completedChallenges =>
      GardenStats.loadCompletedChallenges().length;

  /// Total d'espèces collectionnables (tous les légumes sauf accessoires).
  static final int _totalSpecies = vegetablesBase
      .where((v) => v.category != VegetableCategory.accessories)
      .length;

  @override
  void initState() {
    super.initState();
    _bootstrap();
    RootTabs.poussidexFilter.addListener(_onPoussidexFilterExternal);
    // Ouvert par un deep-link, l'écran naît après que la section a été
    // demandée : l'écouteur ne verrait rien. On lit la valeur en cours.
    if (RootTabs.poussidexFilter.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onPoussidexFilterExternal();
      });
    }
    // La collection peut changer depuis une autre page (bouton « Je
    // l'ai planté » sur une fiche légume) : on se recale sur le service
    // plutôt que de garder une copie qui dériverait.
    PlantationService.instance.addListener(_onPlantationsChanged);
  }

  /// Un deep-link `kultiva://poussidex/<section>` a demandé à basculer
  /// sur une section précise (plants / challenges / badges).
  void _onPoussidexFilterExternal() {
    final name = RootTabs.poussidexFilter.value;
    if (name == null || !mounted) return;
    AlbumFilter? next;
    switch (name) {
      // 'tamassi' a pu être écrit dans un signet ou un tuto d'une
      // version antérieure : on retombe sur la collection plutôt que
      // d'ignorer le lien. Vérifié le 31/10/2026 : aucun des 34 tutos
      // embarqués n'utilise cette route — ils ne contiennent en tout
      // que deux liens `kultiva://`, tous deux vers `home`.
      case 'tamassi':
      case 'collection':
      case 'plants':
        next = AlbumFilter.collection;
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

  @override
  void dispose() {
    RootTabs.poussidexFilter.removeListener(_onPoussidexFilterExternal);
    PlantationService.instance.removeListener(_onPlantationsChanged);
    super.dispose();
  }

  Future<void> _bootstrap() async {
    // Le chargement de la collection et la migration de l'ancienne
    // grille ont lieu au démarrage de l'app (`main.dart`) : cet écran
    // se contente de lire le service.
    _plantations = PlantationService.instance.all;
    // UNION avec les badges déjà débloqués (restaurés du cloud ou gagnés
    // par des actions dont les stats sont purement locales) : on ne
    // recalcule QUE pour AJOUTER d'éventuels badges de niveau, jamais pour
    // remplacer le set — sinon un boot après réinstallation révoquait les
    // badges d'action jusqu'au prochain merge cloud.
    final storedBadges = PrefsService.instance.unlockedBadges;
    final gagnes = computeUnlockedBadges();
    _unlockedBadges = <String>{...storedBadges, ...gagnes};
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

  /// La collection a bougé : on relit le service et on recalcule les
  /// médailles, qui se déduisent du nombre de plants par espèce.
  void _onPlantationsChanged() {
    if (!mounted) return;
    setState(() {
      _plantations = PlantationService.instance.all;
      _medals = computeAllMedals(
        _plantations,
        region: PrefsService.instance.region.value,
      );
    });
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
    // Moment positif : on peut solliciter (au plus une fois) une note store.
    ReviewService.instance
        .maybeRequestReview(unlockedBadgeCount: _unlockedBadges.length);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
              plantsCount: _plantations.length,
              challengesCount: _completedChallenges,
              totalChallenges: allChallenges.length,
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
    );
  }

  Widget _buildBody() {
    switch (_filter) {
      case AlbumFilter.collection:
        return PoussidexCollectionView(
          plantations: _plantations,
          medals: _medals,
          // Un plant s'ajoute depuis une fiche légume : on y emmène
          // l'utilisateur plutôt que de dupliquer un sélecteur ici.
          onBrowseCatalogue: () => RootTabs.tabIndex.value = 2,
        );
      case AlbumFilter.challenges:
        return PoussidexChallengesGrid(
          onPhotoTaken: _onChallengePhotoTaken,
        );
      case AlbumFilter.badges:
        // Recalcul à chaque ouverture : arrosages, récoltes et défis
        // ont pu bouger depuis le dernier passage.
        final live = computeUnlockedBadges();
        return PoussidexBadgesGrid(unlocked: live);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Empty states spécifiques à chaque filtre
// ═══════════════════════════════════════════════════════════════════════════
