import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/plantation.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../services/prefs_service.dart';
import 'home/mes_jardins_screen.dart';
import 'home/photos/photos_screen.dart';
import 'home/recettes/recettes_screen.dart';
import 'home/sow_screen.dart';
import 'home/tutos_screen.dart';
import 'home/vegetables_screen.dart';

/// Conteneur des 6 onglets principaux de Kultiva.
/// Paramètres accessible via icône engrenage en haut à droite.
class RootTabs extends StatefulWidget {
  const RootTabs({super.key});

  /// Onglet actif (0=Home, 1=Cahier, 2=Étal, 3=Tutos, 4=Photo,
  /// 5=Recettes).
  /// Permet aux
  /// deep-links des tutos HTML (`kultiva://cahier`, etc.) de basculer
  /// sur l'onglet cible.
  ///
  /// Ordre changé le 30/10/2026 : le cahier de culture passe en
  /// deuxième position, devant l'Étal. C'est l'écran qu'on ouvre tous
  /// les jours ; le catalogue, on le consulte.
  ///
  /// Photo est arrivé en dernier (01/11/2026) et pas au milieu,
  /// volontairement : les tutos HTML naviguent en posant un index ici,
  /// et insérer un onglet avant les autres les aurait tous décalés
  /// d'un cran — « Étal » aurait ouvert le cahier, sans que rien
  /// n'échoue visiblement.
  static final ValueNotifier<int> tabIndex = ValueNotifier<int>(0);

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> with WidgetsBindingObserver {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    RootTabs.tabIndex.addListener(_onTabIndexExternalChange);
    // Premier check juste après le boot — si des plants ont soif, notif.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runWateringCheck();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    RootTabs.tabIndex.removeListener(_onTabIndexExternalChange);
    super.dispose();
  }

  /// Un deep-link (depuis un tuto HTML) a demandé un changement d'onglet.
  void _onTabIndexExternalChange() {
    final target = RootTabs.tabIndex.value;
    if (target == _index || !mounted) return;
    setState(() => _index = target);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // L'utilisateur revient dans l'app (ex: après quelques jours) —
      // on vérifie si des plants ont besoin d'eau. Le throttle dans
      // NotificationService limite à 1 notif / 24h.
      _runWateringCheck();
    }
  }

  /// Déclenche la vérification d'arrosage sur les plants actifs.
  /// Silencieux si les notifs sont désactivées, si aucun plant actif,
  /// ou si le throttle de 24h n'est pas écoulé.
  void _runWateringCheck() {
    final plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    final actives = plantations.where((p) => p.isActive).toList();
    if (actives.isEmpty) return;
    // On passe les plants eux-mêmes, et pas seulement leurs espèces :
    // l'alerte a besoin de leurs dates d'arrosage pour ne pas réclamer
    // de l'eau pour un plant qu'on vient d'arroser.
    // On ne await pas — c'est du best-effort async.
    NotificationService.checkAndNotify(actives);
    NotificationService.checkAndNotifyHeatwave();
    NotificationService.checkAndNotifyFirstRains();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const SowScreen(),
      const MesJardinsScreen(),
      const VegetablesScreen(),
      const TutosScreen(),
      const PhotosScreen(),
      const RecettesScreen(),
    ];
    // Les libellés de la barre sont la première chose traduite : ils
    // sont visibles sur tous les écrans.
    final t = L.of(context);
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        // Au-delà de trois onglets, Material bascule en mode
        // « shifting » et masque les libellés non sélectionnés. On les
        // garde tous : « Cahier » et « Étal » ne se devinent pas à
        // l'icône.
        type: BottomNavigationBarType.fixed,
        // Six onglets tiennent sur 65 px chacun : à la taille par
        // défaut, « Recettes » est tronqué. On rétrécit plutôt que de
        // masquer les libellés — « Cahier » et « Étal » ne se devinent
        // pas à l'icône.
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 22,
        currentIndex: _index,
        onTap: (i) {
          AudioService.instance.play(Sfx.tap);
          setState(() => _index = i);
          RootTabs.tabIndex.value = i;
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: t.tabHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            activeIcon: const Icon(Icons.menu_book),
            label: t.tabCahier,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.storefront_outlined),
            activeIcon: const Icon(Icons.storefront),
            label: t.tabEtal,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school_outlined),
            activeIcon: const Icon(Icons.school),
            label: t.tabTutos,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.photo_camera_outlined),
            activeIcon: const Icon(Icons.photo_camera),
            label: t.tabPhoto,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_menu_outlined),
            activeIcon: const Icon(Icons.restaurant_menu),
            label: t.tabRecettes,
          ),
        ],
      ),
    );
  }
}
