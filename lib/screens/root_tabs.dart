import 'package:flutter/material.dart';

import '../models/plantation.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../services/prefs_service.dart';
import 'home/my_garden_screen.dart';
import 'home/sow_screen.dart';
import 'home/tutos_screen.dart';
import 'home/vegetables_screen.dart';

/// Conteneur des 4 onglets principaux de Kultiva.
/// Paramètres accessible via icône engrenage en haut à droite.
class RootTabs extends StatefulWidget {
  final VoidCallback onSignOut;
  const RootTabs({super.key, required this.onSignOut});

  /// Onglet actif (0=Home, 1=Étal, 2=Poussidex, 3=Tutos). Permet aux
  /// deep-links des tutos HTML (`kultiva://poussidex`, etc.) de basculer
  /// sur l'onglet cible.
  static final ValueNotifier<int> tabIndex = ValueNotifier<int>(0);

  /// Sous-onglet Poussidex demandé par un deep-link ('tamassi',
  /// 'challenges' ou 'badges'). `null` = pas de changement.
  static final ValueNotifier<String?> poussidexFilter =
      ValueNotifier<String?>(null);

  /// Incrémenté pour demander un retour à l'écran de connexion. Les
  /// Paramètres sont poussés via un proxy qui n'a pas accès au callback
  /// onSignOut du bootstrap : ce notifier fait le pont (déconnexion et
  /// suppression de compte).
  static final ValueNotifier<int> signOutRequested = ValueNotifier<int>(0);

  /// Demande un retour à l'écran de connexion depuis n'importe où.
  static void requestSignOut() =>
      signOutRequested.value = signOutRequested.value + 1;

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> with WidgetsBindingObserver {
  int _index = 0;
  final GlobalKey<MyGardenScreenState> _poussidexKey =
      GlobalKey<MyGardenScreenState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    RootTabs.tabIndex.addListener(_onTabIndexExternalChange);
    RootTabs.signOutRequested.addListener(_onSignOutRequested);
    // Premier check juste après le boot — si des plants ont soif, notif.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runWateringCheck();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    RootTabs.tabIndex.removeListener(_onTabIndexExternalChange);
    RootTabs.signOutRequested.removeListener(_onSignOutRequested);
    super.dispose();
  }

  /// Déconnexion ou suppression de compte demandée depuis les Paramètres.
  void _onSignOutRequested() {
    if (!mounted) return;
    widget.onSignOut();
  }

  /// Un deep-link (depuis un tuto HTML) a demandé un changement d'onglet.
  void _onTabIndexExternalChange() {
    final target = RootTabs.tabIndex.value;
    if (target == _index || !mounted) return;
    setState(() => _index = target);
    if (target == 2) {
      _poussidexKey.currentState?.onBecameVisible();
    }
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
    final activeVegIds = plantations
        .where((p) => p.isActive)
        .map((p) => p.vegetableId)
        .toSet()
        .toList();
    if (activeVegIds.isEmpty) return;
    // On ne await pas — c'est du best-effort async.
    NotificationService.checkAndNotify(activeVegIds);
    NotificationService.checkAndNotifyHeatwave();
    NotificationService.checkAndNotifyFirstRains();
  }

  VoidCallback get onSignOut => widget.onSignOut;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const SowScreen(),
      const VegetablesScreen(),
      MyGardenScreen(key: _poussidexKey),
      const TutosScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          AudioService.instance.play(Sfx.tap);
          setState(() => _index = i);
          RootTabs.tabIndex.value = i;
          if (i == 2) {
            _poussidexKey.currentState?.onBecameVisible();
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront),
            label: 'Étal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark_outlined),
            activeIcon: Icon(Icons.collections_bookmark),
            label: 'Poussidex',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Tutos',
          ),
        ],
      ),
    );
  }
}
