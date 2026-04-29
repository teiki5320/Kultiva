import 'package:flutter/material.dart';

import '../../models/garden_plan.dart';
import '../../models/hydro_install.dart';
import '../../services/audio_service.dart';
import '../../services/garden_plan_service.dart';
import '../../services/hydro_install_service.dart';
import '../../services/culture_service.dart';
import '../../models/culture_entry.dart';
import '../../theme/app_theme.dart';
import 'create_hydro_install_sheet.dart';
import 'garden_planner_screen.dart';
import 'hydro_install_detail_screen.dart';
import 'garden_plan_config_sheet.dart';

/// Écran principal du Cahier de culture (point d'entrée depuis le
/// dashboard). Liste tous les jardins de l'utilisateur, mélange
/// pleine terre + hydroponie. Deux FABs en bas pour créer chaque type.
///
/// Refonte cohérence avril 2026 : remplace CahierCulturePickerScreen
/// (qui obligeait à choisir une méthode AVANT de voir ses jardins) et
/// fusionne PotagerTraditionnelScreen + HydroponieScreen sur leur vue
/// principale (la liste des jardins).
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
    HydroInstallService.instance.load();
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
          return ValueListenableBuilder<List<HydroInstall>>(
            valueListenable: HydroInstallService.instance.installs,
            builder: (context, installs, __) {
              final soilPlans =
                  plans.where((p) => p.hydroSystem == null).toList();
              if (soilPlans.isEmpty && installs.isEmpty) {
                return _EmptyState();
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                children: <Widget>[
                  for (final p in soilPlans) _SoilGardenCard(plan: p),
                  for (final i in installs) _HydroGardenCard(install: i),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: _BottomActions(
        onCreateHydro: () => _createHydro(context),
        onCreateSoil: () => _createSoil(context),
      ),
    );
  }

  Future<void> _createHydro(BuildContext context) async {
    AudioService.instance.play(Sfx.tap);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateHydroInstallSheet(),
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
              'Crée ton premier jardin pleine terre ou ta première '
              'installation hydroponique avec les boutons en bas.',
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

/// Card d'un jardin pleine terre (vert).
class _SoilGardenCard extends StatelessWidget {
  final GardenPlan plan;
  const _SoilGardenCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final filledCells = plan.cells.values
        .where((v) => v != null && v.isNotEmpty)
        .length;
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

/// Card d'une install hydroponique (bleu).
class _HydroGardenCard extends StatelessWidget {
  final HydroInstall install;
  const _HydroGardenCard({required this.install});

  @override
  Widget build(BuildContext context) {
    final filled = install.filledSlots;
    final total = install.slotCount;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          AudioService.instance.play(Sfx.tap);
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => HydroInstallDetailScreen(installId: install.id),
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
                KultivaColors.winterA.withValues(alpha: 0.65),
                KultivaColors.winterB.withValues(alpha: 0.55),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4A9BBF).withValues(alpha: 0.5),
              width: 1.4,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF4A9BBF).withValues(alpha: 0.15),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text('💧', style: TextStyle(fontSize: 30)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          install.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Hydroponie · ${install.systemType.label}  ·  '
                          '${install.reservoirL.toStringAsFixed(0)} L  ·  '
                          '$filled/$total plants',
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
              if (install.filledSlots > 0) ...<Widget>[
                const SizedBox(height: 10),
                _PlantsLine(install: install),
              ],
              if (install.flushDue) ...<Widget>[
                const SizedBox(height: 8),
                _FlushHint(install: install),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlantsLine extends StatelessWidget {
  final HydroInstall install;
  const _PlantsLine({required this.install});

  @override
  Widget build(BuildContext context) {
    final cultures = CultureService.instance.loadAll();
    final byId = <String, CultureEntry>{
      for (final c in cultures) c.id: c,
    };
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final cid in install.slotCultureIds)
          if (cid != null)
            _miniPlantChip(byId[cid]),
      ],
    );
  }

  Widget _miniPlantChip(CultureEntry? c) {
    final emoji = '🌱';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        c == null
            ? emoji
            : '${_emojiFor(c.vegetableId) ?? emoji}  J+${c.daysSinceStarted}',
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }

  String? _emojiFor(String vegetableId) {
    // Petit lookup léger sans importer les bases.
    const fallbacks = <String, String>{
      'tomate': '🍅',
      'laitue': '🥬',
      'fraise': '🍓',
      'basilic': '🌿',
      'menthe': '🌿',
      'concombre': '🥒',
      'poivron': '🌶️',
      'carotte': '🥕',
      'aubergine': '🍆',
    };
    return fallbacks[vegetableId];
  }
}

class _FlushHint extends StatelessWidget {
  final HydroInstall install;
  const _FlushHint({required this.install});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('🪣', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        Text(
          'Réservoir à rincer',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFB36A3D),
          ),
        ),
      ],
    );
  }
}

/// Barre du bas avec deux boutons : « + Hydro » (bleu, gauche) et
/// « + Nouveau jardin » (vert, droite). Couleurs cohérentes avec
/// les cards de chaque type.
class _BottomActions extends StatelessWidget {
  final VoidCallback onCreateHydro;
  final VoidCallback onCreateSoil;

  const _BottomActions({
    required this.onCreateHydro,
    required this.onCreateSoil,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FilledButton.icon(
                onPressed: onCreateHydro,
                icon: const Text('💧', style: TextStyle(fontSize: 18)),
                label: const Text(
                  '+ Hydro',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4A9BBF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
