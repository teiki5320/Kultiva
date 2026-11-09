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
    // ⚠️ Deux traitements, et la frontière est le **contenu**, pas
    // l'écran. Les grilles prennent toute la largeur : une tuile de
    // plus par ligne, c'est une tuile de plus qu'on voit sans défiler.
    // Les colonnes de texte gardent leur mesure : au-delà, l'œil perd
    // le début de la ligne suivante, et le signet d'une recette finit
    // à 1 400 points de son titre.
    //
    // Première version du 03/11/2026 : tout était borné à 720, y
    // compris les grilles. Jean a regardé l'iPad et dit ce qui se
    // voyait — « ça ne prend pas toute la place ». Il avait raison.
    final pages = <Widget>[
      // Tableau de bord, Étal et Tutos sont des grilles : elles
      // comptent leurs colonnes d'après la place disponible.
      const SowScreen(),
      const ReadableWidth(maxWidth: 900, child: MesJardinsScreen()),
      const VegetablesScreen(),
      // Conservation est la seule vraie colonne de texte des cinq :
      // trois lignes de description par recette, et un signet au bout.
      const ReadableWidth(maxWidth: 760, child: RecettesScreen()),
      const TutosScreen(),
    ];
    // Les libellés de la barre sont la première chose traduite : ils
    // sont visibles sur tous les écrans.
    final t = L.of(context);
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: _sousEncoche(
        context,
        BottomNavigationBar(
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
      ),
    );
  }
}

/// Range la barre d'onglets à l'intérieur d'une encoche **latérale**.
///
/// L'iPhone Duo (09/11/2026) est le premier appareil visé qui en a
/// une : écran fermé, `MediaQuery.padding` vaut `right: 84`, parce
/// qu'iOS dessine sa barre d'état verticalement, sur le côté. Un
/// `Scaffold` descend la marge **basse** jusqu'à sa barre d'onglets,
/// jamais les latérales — « Tutos », le cinquième onglet, était donc
/// peint à 435 points sur un bord sûr qui s'arrête à 382. Mesuré par
/// `test/iphone_duo_test.dart`, et vu à l'écran sur le simulateur.
///
/// Le fond reste **pleine largeur** : c'est le contenu qui se range,
/// pas la barre. Une barre rétrécie laisserait voir le fond de l'app
/// dans les 84 points, ce qui se verrait bien plus qu'un libellé
/// décalé.
///
/// ⚠️ **Sur un appareil sans encoche latérale, cette fonction rend la
/// barre telle quelle** — pas un `ColoredBox` de plus, pas un
/// `Padding` de zéro. C'est ce que vérifie le test « rien ne bouge
/// sur un téléphone » : à marges nulles, l'arbre rendu est celui
/// d'avant, au widget près.
Widget _sousEncoche(BuildContext context, Widget barre) {
  final marges = MediaQuery.paddingOf(context);
  if (marges.left == 0 && marges.right == 0) return barre;
  final theme = Theme.of(context);
  return ColoredBox(
    color: theme.bottomNavigationBarTheme.backgroundColor ??
        theme.colorScheme.surface,
    child: Padding(
      padding: EdgeInsets.only(left: marges.left, right: marges.right),
      child: barre,
    ),
  );
}
