import 'package:flutter/material.dart';

import '../../data/ui_i18n.dart';
import '../../data/vegetables_base.dart';
import '../../models/garden_plan.dart';
import '../../services/audio_service.dart';
import '../../services/garden_plan_service.dart';
import '../../services/plantation_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/category_colors.dart';
import '../../utils/text_scale.dart';
import '../../widgets/grille_adaptative.dart';
import '../../widgets/jardins_intro_sheet.dart';
import '../root_tabs.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import 'cahier/cahier_journal_section.dart';
import 'cahier/cahier_plants_section.dart';
import 'cahier/cahier_season_recap.dart';
import 'cahier/cahier_today_card.dart';
import 'garden_planner_screen.dart';
import 'garden_plan_config_sheet.dart';

/// Cahier de culture — l'onglet qu'on ouvre tous les jours.
///
/// Promu en deuxième position de la barre d'onglets le 30/10/2026,
/// puis repris le 31 : il n'avait qu'une `AppBar` grise et une liste
/// de jardins, là où les trois autres onglets ont un bandeau
/// saisonnier. Surtout, il ne répondait pas à la question qu'on se
/// pose en l'ouvrant — qu'est-ce que je fais au jardin ce matin.
///
/// Trois étages maintenant : le bandeau de saison, ce qu'il y a à
/// faire aujourd'hui, puis les jardins, chacun avec l'aperçu de sa
/// propre grille.
class MesJardinsScreen extends StatefulWidget {
  const MesJardinsScreen({super.key});

  @override
  State<MesJardinsScreen> createState() => _MesJardinsScreenState();
}

class _MesJardinsScreenState extends State<MesJardinsScreen> {
  /// L'index de l'onglet Cahier dans `RootTabs`.
  static const _ongletCahier = 1;

  bool _introEnCours = false;

  @override
  void initState() {
    super.initState();
    GardenPlanService.instance.load();
    // ⚠️ `initState` n'est **pas** « quand on ouvre l'onglet ».
    // `RootTabs` empile ses cinq pages dans un `IndexedStack`, qui les
    // construit toutes au premier affichage : la présentation du
    // cahier s'ouvrait donc par-dessus le **tableau de bord**, juste
    // après l'onboarding, pour un onglet où l'utilisateur n'était pas
    // encore allé. Vu à l'écran le 03/11/2026 sur iPhone et sur iPad.
    RootTabs.tabIndex.addListener(_surChangementOnglet);
    _surChangementOnglet();
  }

  @override
  void dispose() {
    RootTabs.tabIndex.removeListener(_surChangementOnglet);
    super.dispose();
  }

  void _surChangementOnglet() {
    if (RootTabs.tabIndex.value != _ongletCahier) return;
    _maybeShowIntro();
  }

  /// Affiche le sheet de présentation à la première ouverture **de
  /// l'onglet** (flag prefs jardinsTutorialDone). Plus jamais après.
  Future<void> _maybeShowIntro() async {
    if (_introEnCours || PrefsService.instance.jardinsTutorialDone) return;
    _introEnCours = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (_) => const JardinsIntroSheet(),
      );
      await PrefsService.instance.setJardinsTutorialDone(true);
      _introEnCours = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // `SafeArea` en haut : sans elle, le bandeau passait sous l'heure
      // et l'opérateur, et le titre se retrouvait collé à la barre
      // d'état. Les onglets Home et Tutos l'ont toujours eue.
      body: SafeArea(
        bottom: false,
        child: ValueListenableBuilder<List<GardenPlan>>(
          valueListenable: GardenPlanService.instance.plans,
          builder: (context, plans, _) {
            return ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: <Widget>[
                _CahierHeader(plans: plans),
                const CahierTodayCard(),
                if (plans.isEmpty) const _EmptyState(),
                const CahierPlantsSection(),
                const CahierJournalSection(),
                // Les jardins ferment le cahier, en post-it : la
                // maquette C4c les met après le journal, parce qu'on
                // ouvre un plan pour **modifier**, pas pour savoir
                // quoi faire ce matin. Ce qui répond au matin — la
                // pile, les plants, le journal — passe devant.
                if (plans.isNotEmpty) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                    child: Text(
                      trUi('Mes jardins'),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GrilleAdaptative(
                      largeurCible: 170,
                      enfants: <Widget>[
                        for (var i = 0; i < plans.length; i++)
                          _SoilGardenCard(plan: plans[i], rang: i),
                      ],
                    ),
                  ),
                ],
                const CahierSeasonRecap(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _BottomActions(
        onCreateSoil: () => _createSoil(context),
      ),
    );
  }

  Future<void> _createSoil(BuildContext context) async {
    AudioService.instance.play(Sfx.tap);
    final created = await showModalBottomSheet<GardenPlan>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const GardenPlanConfigSheet(),
    );
    if (created != null && context.mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => GardenPlannerScreen(initialPlan: created),
        ),
      );
    }
  }
}

/// Bandeau de saison du cahier, avec son titre et son compte.
class _CahierHeader extends StatelessWidget {
  final List<GardenPlan> plans;
  const _CahierHeader({required this.plans});

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    final plants = PlantationService.instance.active.length;
    final cases = plans.fold<int>(0, (s, p) => s + p.cells.length);
    return Stack(
      children: <Widget>[
        SeasonHeader(
          season: Season.current(mois),
          month: mois,
          height: kPageHeaderHeight,
          hideLabel: true,
        ),
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trUi('📔  Cahier de culture'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(blurRadius: 6, color: Colors.black38),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _resume(plans.length, cases, plants),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(blurRadius: 5, color: Colors.black38),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String _resume(int jardins, int cases, int plants) {
    if (jardins == 0) return trUi('Ton premier jardin t\'attend');
    // Le pluriel a ses deux phrases : chaque langue accorde à sa façon.
    final j = jardins > 1
        ? trUiArgs('{0} jardins', <Object?>[jardins])
        : trUiArgs('{0} jardin', <Object?>[jardins]);
    final c = cases > 1
        ? trUiArgs('{0} cases occupées', <Object?>[cases])
        : trUiArgs('{0} case occupée', <Object?>[cases]);
    if (plants == 0) return '$j · $c';
    final pl = plants > 1
        ? trUiArgs('{0} plants suivis', <Object?>[plants])
        : trUiArgs('{0} plant suivi', <Object?>[plants]);
    return '$j · $c · $pl';
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('🌿', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 18),
          Text(
            trUi('Aucun jardin pour l\'instant'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            trUi('Crée ton premier jardin pleine terre avec le bouton '
                'en bas. Tu pourras ensuite y placer tes plants par '
                'glisser-déposer.'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: KultivaColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Un jardin en post-it, avec l'aperçu de sa grille.
///
/// Maquette « C4c · La pile du jour » : deux papiers pastel côte à
/// côte, nom et « 6 / 8 cases ». ⚠️ **L'aperçu de la grille reste** :
/// il date du 31/10/2026 et c'est lui qui distingue deux jardins du
/// premier coup d'œil — la maquette ne le montrait pas, le retirer
/// aurait rendu deux potagers identiques au regard.
class _SoilGardenCard extends StatelessWidget {
  final GardenPlan plan;

  /// Sa place dans la liste : donne sa couleur et son inclinaison,
  /// pour que deux post-it voisins ne soient pas jumeaux.
  final int rang;

  const _SoilGardenCard({required this.plan, required this.rang});

  static const List<Color> _papiers = <Color>[
    Color(0xFFE3F1E0),
    Color(0xFFFBD8E6),
    Color(0xFFD6ECF5),
    Color(0xFFFFF3C4),
  ];

  @override
  Widget build(BuildContext context) {
    final occupees = plan.cells.length;
    final total = plan.cols * plan.rows;
    final papier = _papiers[rang % _papiers.length];
    final pair = rang.isEven;
    return Semantics(
      label: trUiArgs('Jardin {0}, {1} cases occupées sur {2}',
          <Object?>[plan.name, occupees, total]),
      hint: trUi('Ouvre le plan de ce jardin'),
      button: true,
      excludeSemantics: true,
      child: InkWell(
        onTap: () {
          AudioService.instance.play(Sfx.tap);
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => GardenPlannerScreen(initialPlan: plan),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: papier,
            // Le coin arrondi change de côté d'un post-it à l'autre,
            // comme sur la maquette.
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(4),
              topRight: const Radius.circular(4),
              bottomLeft: Radius.circular(pair ? 20 : 4),
              bottomRight: Radius.circular(pair ? 4 : 20),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: scaledHeight(context, 46),
                height: scaledHeight(context, 46),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _PlanThumbnail(plan: plan),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      plan.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      total > 1
                          ? trUiArgs('{0} / {1} cases',
                              <Object?>[occupees, total])
                          : trUiArgs('{0} / {1} case',
                              <Object?>[occupees, total]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Aperçu miniature d'un plan : une pastille par case, à la couleur de
/// la famille du légume qui l'occupe.
///
/// Les cards montraient toutes le même tournesol : deux jardins
/// différents se ressemblaient trait pour trait, et il fallait lire le
/// nom pour les distinguer. La forme de la grille et ce qu'on y a
/// planté se reconnaissent du premier coup d'œil.
class _PlanThumbnail extends StatelessWidget {
  final GardenPlan plan;
  const _PlanThumbnail({required this.plan});

  @override
  Widget build(BuildContext context) {
    // Au-delà, les pastilles font moins d'un pixel : un tournesol dit
    // davantage qu'une bouillie grise.
    if (plan.cols > 10 || plan.rows > 10) {
      return const Center(child: Text('🌻', style: TextStyle(fontSize: 26)));
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cote = constraints.maxWidth / plan.cols;
        final rayon = cote < 6 ? 1.0 : 2.0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int r = 0; r < plan.rows; r++)
              Expanded(
                child: Row(
                  // `stretch` est indispensable : sans lui, un
                  // `DecoratedBox` sans enfant reçoit une contrainte de
                  // hauteur lâche et s'écrase à zéro — l'aperçu était
                  // un carré blanc vide.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (int c = 0; c < plan.cols; c++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(0.6),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: _couleur(plan.cellAt(c, r)?.vegetableId),
                              borderRadius: BorderRadius.circular(rayon),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  static Color _couleur(String? vegetableId) {
    if (vegetableId == null) {
      return KultivaColors.lightGreen.withValues(alpha: 0.28);
    }
    final veg = vegetablesBase.where((v) => v.id == vegetableId).firstOrNull;
    if (veg == null) return KultivaColors.lightGreen;
    return veg.category.familyColor;
  }
}

/// Barre du bas avec un bouton « + Nouveau jardin » (vert).
class _BottomActions extends StatelessWidget {
  final VoidCallback onCreateSoil;

  const _BottomActions({required this.onCreateSoil});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: FilledButton.icon(
          onPressed: onCreateSoil,
          icon: const Text('🌻', style: TextStyle(fontSize: 18)),
          label: Text(
            trUi('+ Nouveau jardin'),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: KultivaColors.primaryGreen,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
