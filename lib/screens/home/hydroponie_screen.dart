import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/hydro_install.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/culture_service.dart';
import '../../services/hydro_install_service.dart';
import '../../theme/app_theme.dart';
import 'create_hydro_install_sheet.dart';
import 'hydro_install_detail_screen.dart';

/// Écran principal de l'onglet Hydroponie après la refonte cohérence
/// (avril 2026). Liste les installations de l'utilisateur (1 install
/// = 1 bac physique = lampe + réservoir + N slots de plants), permet
/// d'en créer de nouvelles et d'accéder au détail de chacune.
///
/// Les sous-onglets Planification / Croissance / Rappel ont disparu —
/// tout est centralisé ici, avec accès au détail d'une install pour
/// le suivi de ses plants et la saisie des mesures du jour.
class HydroponieScreen extends StatefulWidget {
  const HydroponieScreen({super.key});

  @override
  State<HydroponieScreen> createState() => _HydroponieScreenState();
}

class _HydroponieScreenState extends State<HydroponieScreen> {
  @override
  void initState() {
    super.initState();
    HydroInstallService.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💧  Mon jardin hydroponique'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Créer une install'),
        backgroundColor: KultivaColors.primaryGreen,
      ),
      body: ValueListenableBuilder<List<HydroInstall>>(
        valueListenable: HydroInstallService.instance.installs,
        builder: (context, installs, _) {
          if (installs.isEmpty) {
            return _EmptyState(onCreate: () => _openCreateSheet(context));
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: installs.length,
            itemBuilder: (_, i) => _InstallCard(install: installs[i]),
          );
        },
      ),
    );
  }

  Future<void> _openCreateSheet(BuildContext context) async {
    AudioService.instance.play(Sfx.tap);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateHydroInstallSheet(),
    );
  }
}

/// État vide : invite à créer la première install.
class _EmptyState extends StatelessWidget {
  final VoidCallback onCreate;
  const _EmptyState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('💧', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 18),
            Text(
              'Aucune installation pour l\'instant',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Une installation hydroponique c\'est ton bac : '
              'le système (DWC, Kratky…), la lampe, le réservoir et '
              'les emplacements pour tes plants.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: KultivaColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: const Text('Créer ma première install'),
              style: FilledButton.styleFrom(
                backgroundColor: KultivaColors.primaryGreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card d'une install dans la liste principale.
class _InstallCard extends StatelessWidget {
  final HydroInstall install;
  const _InstallCard({required this.install});

  @override
  Widget build(BuildContext context) {
    final filled = install.filledSlots;
    final total = install.slotCount;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
            color: KultivaColors.winterA.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4A9BBF).withValues(alpha: 0.45),
              width: 1.4,
            ),
            boxShadow: [
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
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9BBF).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
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
                          '${install.systemType.label}  ·  '
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
              const SizedBox(height: 12),
              _PlantsPreview(install: install),
              if (install.flushDue) ...<Widget>[
                const SizedBox(height: 10),
                _FlushAlert(install: install),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Aperçu des plants dans une install (chips colorées).
class _PlantsPreview extends StatelessWidget {
  final HydroInstall install;
  const _PlantsPreview({required this.install});

  @override
  Widget build(BuildContext context) {
    if (install.filledSlots == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: KultivaColors.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('🌱', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Aucun plant dans cette install. Ouvre-la pour en ajouter.',
                style: TextStyle(
                  fontSize: 12,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      );
    }
    final cultures = CultureService.instance.loadAll();
    final byId = <String, CultureEntry>{
      for (final c in cultures) c.id: c,
    };
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final cid in install.slotCultureIds)
          if (cid != null) _PlantChip(culture: byId[cid]),
      ],
    );
  }
}

class _PlantChip extends StatelessWidget {
  final CultureEntry? culture;
  const _PlantChip({required this.culture});

  Vegetable? _veg() {
    final c = culture;
    if (c == null) return null;
    try {
      return vegetablesBase.firstWhere((v) => v.id == c.vegetableId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = culture;
    if (c == null) {
      return _chipShell(
        emoji: '❓',
        label: 'plant inconnu',
        color: KultivaColors.textSecondary,
      );
    }
    final veg = _veg();
    return _chipShell(
      emoji: veg?.emoji ?? '🌱',
      label: '${veg?.name ?? c.vegetableId} · J+${c.daysSinceStarted}',
      color: KultivaColors.primaryGreen,
    );
  }

  Widget _chipShell({
    required String emoji,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlushAlert extends StatelessWidget {
  final HydroInstall install;
  const _FlushAlert({required this.install});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8A87C).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8A87C)),
      ),
      child: Row(
        children: <Widget>[
          const Text('🪣', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Réservoir à rincer (dernier il y a '
              '${install.daysSinceFlush}j)',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFFB36A3D),
              ),
            ),
          ),
          TextButton(
            onPressed: () => HydroInstallService.instance
                .markFlushed(install.id),
            child: const Text('Fait'),
          ),
        ],
      ),
    );
  }
}

