import 'package:flutter/material.dart';

import '../../models/garden_plan.dart';
import '../../services/audio_service.dart';
import '../../services/garden_plan_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/jardins_intro_sheet.dart';
import 'garden_planner_screen.dart';
import 'garden_plan_config_sheet.dart';

/// Écran principal du Cahier de culture (point d'entrée depuis le
/// dashboard). Liste tous les jardins pleine terre de l'utilisateur.
/// Un bouton « + Nouveau jardin » en bas pour en créer un.
///
/// Tap sur une card → GardenPlannerScreen (cases + picker).
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
      appBar: AppBar(
        title: const Text('📔  Mes jardins'),
      ),
      body: ValueListenableBuilder<List<GardenPlan>>(
        valueListenable: GardenPlanService.instance.plans,
        builder: (context, plans, _) {
          if (plans.isEmpty) {
            return const _EmptyState();
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            children: <Widget>[
              for (final p in plans) _SoilGardenCard(plan: p),
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
      backgroundColor: Colors.white,
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('🌿', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 18),
            const Text(
              'Aucun jardin pour l\'instant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
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
      ),
    );
  }
}

/// Card d'un jardin pleine terre.
class _SoilGardenCard extends StatelessWidget {
  final GardenPlan plan;
  const _SoilGardenCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final filledCells = plan.cells.length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                color:
                    KultivaColors.primaryGreen.withValues(alpha: 0.15),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('🌻', style: TextStyle(fontSize: 30)),
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
                      'Pleine terre  ·  ${plan.cols}×${plan.rows} cases  ·  '
                      '$filledCells plants',
                      style: TextStyle(
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
    );
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
