import 'package:flutter/material.dart';

import '../models/plantation.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../services/prefs_service.dart';
import 'creature_demo_screen.dart';
import 'home/settings_screen.dart';
import 'home/sow_screen.dart';
import 'home/tutos_screen.dart';
import 'home/vegetables_screen.dart';

/// Conteneur des 4 onglets principaux de Kultiva.
/// Paramètres accessible via icône engrenage en haut à droite.
class RootTabs extends StatefulWidget {
  final VoidCallback onSignOut;
  const RootTabs({super.key, required this.onSignOut});

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> with WidgetsBindingObserver {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Premier check juste après le boot — si des plants ont soif, notif.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runWateringCheck();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SettingsScreen(onSignOut: onSignOut),
      ),
    );
  }

  VoidCallback get onSignOut => widget.onSignOut;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const SowScreen(),
      const VegetablesScreen(),
      const CreatureDemoScreen(),
      const TutosScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          AudioService.instance.play(Sfx.tap);
          setState(() => _index = i);
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
