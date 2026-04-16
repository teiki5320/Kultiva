import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import 'home/my_garden_screen.dart';
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

class _RootTabsState extends State<RootTabs> {
  int _index = 0;
  final GlobalKey<MyGardenScreenState> _poussidexKey =
      GlobalKey<MyGardenScreenState>();

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
          // Déclenche le tuto Poussidex la 1ère fois que l'utilisateur
          // arrive sur cet onglet (la méthode gère elle-même le flag).
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
