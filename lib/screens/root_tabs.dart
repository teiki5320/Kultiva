import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/plantation.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../services/prefs_service.dart';
import 'home/mes_jardins_screen.dart';
import 'home/recettes/recettes_screen.dart';
import 'home/sow_screen.dart';
import 'home/tutos_screen.dart';
import 'home/vegetables_screen.dart';
import '../widgets/readable_width.dart';

/// Conteneur des 5 onglets principaux de Kultiva.
/// Paramètres accessible via icône engrenage en haut à droite.
class RootTabs extends StatefulWidget {
  const RootTabs({super.key});

  /// Onglet actif (0=Home, 1=Cahier, 2=Étal, 3=Recettes, 4=Tutos).
  /// Permet aux
  /// deep-links des tutos HTML (`kultiva://cahier`, etc.) de basculer
  /// sur l'onglet cible.
  ///
  /// Ordre changé le 30/10/2026 : le cahier de culture passe en
  /// deuxième position, devant l'Étal. C'est l'écran qu'on ouvre tous
  /// les jours ; le catalogue, on le consulte.
  ///
  /// ⚠️ Les nouveaux onglets s'ajoutent **en bout de barre**, jamais au
  /// milieu : les tutos HTML naviguent en posant un index ici, et
  /// insérer un onglet avant les autres les décalerait tous d'un cran
  /// — « Étal » ouvrirait le cahier, sans que rien n'échoue
  /// visiblement. L'onglet Photo, ajouté le 01/11/2026 puis retiré le
  /// même jour, a bien recalé Recettes de 5 à 4.
  ///
  /// Tutos est passé en dernier le 01/11/2026 (demande de Jean) :
  /// Recettes prend l'index 3, Tutos le 4. C'est le seul changement
  /// d'ordre qui ait déplacé un onglet existant — d'où la mise à jour
  /// des deep-links dans `tuto_fiche_screen.dart`.
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
    // Kultiva a été dessinée pour un téléphone. Sur un iPad, la même
    // mise en page s'étire sur 1 032 points : les cartes du tableau de
    // bord deviennent des bandes presque vides, et une ligne de texte
    // traverse l'écran d'un bord à l'autre.
    //
    // ⚠️ L'Étal est la seule exception, et c'est voulu : sa grille de
    // tuiles se répartit toute seule (huit colonnes sur un iPad, deux
    // sur un téléphone) et profite vraiment de la largeur. La borner
    // lui ferait perdre ce qu'elle sait faire.
    final pages = <Widget>[
      // Le tableau de bord est plus étroit que les autres : ses six
      // cartes sont des tuiles de hauteur fixe (138 points). À 720 de
      // large elles font deux fois et demie leur hauteur — des bandes,
      // là où le téléphone montre des tuiles presque carrées.
      const ReadableWidth(maxWidth: 560, child: SowScreen()),
      const ReadableWidth(child: MesJardinsScreen()),
      const VegetablesScreen(),
      const ReadableWidth(child: RecettesScreen()),
      const ReadableWidth(child: TutosScreen()),
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
        // À la taille par défaut, « Recettes » est tronqué. On
        // rétrécit plutôt que de masquer les libellés — « Cahier » et
        // « Étal » ne se devinent pas à l'icône.
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
            icon: const Icon(Icons.restaurant_menu_outlined),
            activeIcon: const Icon(Icons.restaurant_menu),
            label: t.tabRecettes,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school_outlined),
            activeIcon: const Icon(Icons.school),
            label: t.tabTutos,
          ),
        ],
      ),
    );
  }
}
