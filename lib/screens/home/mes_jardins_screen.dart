import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/garden_plan.dart';
import '../../services/audio_service.dart';
import '../../services/garden_plan_service.dart';
import '../../services/plantation_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/category_colors.dart';
import '../../utils/text_scale.dart';
import '../../widgets/jardins_intro_sheet.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import 'cahier/cahier_plants_section.dart';
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
  @override
  void initState() {
    super.initState();
    GardenPlanService.instance.load();
    _maybeShowIntro();
  }

  /// Affiche le sheet de présentation à la première ouverture (flag
  /// prefs jardinsTutorialDone). Plus jamais après.
  Future<void> _maybeShowIntro() async {
    if (PrefsService.instance.jardinsTutorialDone) return;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<List<GardenPlan>>(
        valueListenable: GardenPlanService.instance.plans,
        builder: (context, plans, _) {
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: <Widget>[
              _CahierHeader(plans: plans),
              const CahierTodayCard(),
              if (plans.isEmpty)
                const _EmptyState()
              else ...<Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
                  child: Text(
                    'Mes jardins',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
                for (final p in plans)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SoilGardenCard(plan: p),
                  ),
              ],
              const CahierPlantsSection(),
            ],
          );
        },
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
    final region = PrefsService.instance.region.value;
    final plants = PlantationService.instance.active.length;
    final cases = plans.fold<int>(0, (s, p) => s + p.cells.length);
    return Stack(
      children: <Widget>[
        SeasonHeader(
          season:
              Season.of(mois, region, zone: PrefsService.instance.effectiveZone),
          month: mois,
          height: 140,
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
                  const Text(
                    '📔  Cahier de culture',
                    style: TextStyle(
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
    if (jardins == 0) return 'Ton premier jardin t\'attend';
    final j = '$jardins jardin${jardins > 1 ? 's' : ''}';
    final c = '$cases case${cases > 1 ? 's' : ''} occupée'
        '${cases > 1 ? 's' : ''}';
    if (plants == 0) return '$j · $c';
    return '$j · $c · $plants plant${plants > 1 ? 's' : ''} suivi'
        '${plants > 1 ? 's' : ''}';
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(32, 40, 32, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('🌿', style: TextStyle(fontSize: 64)),
          SizedBox(height: 18),
          Text(
            'Aucun jardin pour l\'instant',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Crée ton premier jardin pleine terre avec le bouton '
            'en bas. Tu pourras ensuite y placer tes plants par '
            'glisser-déposer.',
            textAlign: TextAlign.center,
            style: TextStyle(
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

/// Card d'un jardin pleine terre, avec l'aperçu de sa grille.
class _SoilGardenCard extends StatelessWidget {
  final GardenPlan plan;
  const _SoilGardenCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final filledCells = plan.cells.length;
    final total = plan.cols * plan.rows;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        label: 'Jardin ${plan.name}, $filledCells cases occupées sur $total',
        hint: 'Ouvre le plan de ce jardin',
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  KultivaColors.springB.withValues(alpha: 0.55),
                  KultivaColors.springA.withValues(alpha: 0.45),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: KultivaColors.primaryGreen.withValues(alpha: 0.5),
                width: 1.4,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: KultivaColors.primaryGreen.withValues(alpha: 0.15),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: scaledHeight(context, 56),
                  height: scaledHeight(context, 56),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _PlanThumbnail(plan: plan),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        plan.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Pleine terre  ·  ${plan.cols}×${plan.rows}  ·  '
                        '$filledCells/$total occupées',
                        style: const TextStyle(
                          fontSize: 12,
                          color: KultivaColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
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
          label: const Text(
            '+ Nouveau jardin',
            style: TextStyle(fontWeight: FontWeight.w800),
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
