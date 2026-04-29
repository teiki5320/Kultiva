import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/garden_plan.dart';
import '../../models/hydro_install.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/culture_service.dart';
import '../../services/hydro_install_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/hydro_advisor.dart';
import 'daily_readings_sheet.dart';

/// Détail d'une installation hydroponique : lampe, slots (chaque slot
/// rempli ou vide), bouton « Mesures du jour », rappel rinçage.
///
/// Tap sur un slot vide → sheet de choix de légume.
/// Tap sur un slot rempli → modale d'actions (changer de phase, retirer).
class HydroInstallDetailScreen extends StatefulWidget {
  final String installId;

  const HydroInstallDetailScreen({super.key, required this.installId});

  @override
  State<HydroInstallDetailScreen> createState() =>
      _HydroInstallDetailScreenState();
}

class _HydroInstallDetailScreenState
    extends State<HydroInstallDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<HydroInstall>>(
      valueListenable: HydroInstallService.instance.installs,
      builder: (context, installs, _) {
        final install = installs.firstWhere(
          (i) => i.id == widget.installId,
          orElse: () => HydroInstall(
            id: widget.installId,
            name: '?',
            systemType: HydroSystemType.dwc,
            slotCount: 0,
            reservoirL: 0,
            slotCultureIds: const <String?>[],
            createdAt: DateTime.now(),
          ),
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(install.name),
            actions: <Widget>[
              IconButton(
                tooltip: 'Renommer',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => _renameInstall(install),
              ),
              IconButton(
                tooltip: 'Supprimer cette install',
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmDelete(install),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: <Widget>[
              _SystemSummary(install: install),
              const SizedBox(height: 14),
              _LightSummary(install: install),
              const SizedBox(height: 14),
              if (install.flushDue) ...<Widget>[
                _FlushAlert(install: install),
                const SizedBox(height: 14),
              ],
              _DailyReadingsButton(install: install),
              const SizedBox(height: 18),
              const _SectionTitle('🌿  Mes plants'),
              const SizedBox(height: 8),
              _SlotsGrid(install: install),
            ],
          ),
        );
      },
    );
  }

  Future<void> _renameInstall(HydroInstall install) async {
    final controller = TextEditingController(text: install.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Renommer'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nom de l\'install'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(ctx).pop(controller.text.trim()),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      await HydroInstallService.instance
          .update(install.copyWith(name: newName));
    }
  }

  Future<void> _confirmDelete(HydroInstall install) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer cette install ?'),
        content: Text(
          'Tu vas supprimer « ${install.name} » et les '
          '${install.filledSlots} plant(s) qu\'elle contient. Cette '
          'action est irréversible.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await HydroInstallService.instance.remove(install.id);
      if (mounted) Navigator.of(context).pop();
    }
  }
}

class _SystemSummary extends StatelessWidget {
  final HydroInstall install;
  const _SystemSummary({required this.install});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: KultivaColors.winterA.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4A9BBF).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF4A9BBF).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('💧', style: TextStyle(fontSize: 26)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  install.systemType.fullLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Réservoir ${install.reservoirL.toStringAsFixed(0)} L  ·  '
                  '${install.slotCount} emplacements',
                  style: TextStyle(
                    fontSize: 12,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LightSummary extends StatelessWidget {
  final HydroInstall install;
  const _LightSummary({required this.install});

  @override
  Widget build(BuildContext context) {
    final light = install.light;
    if (light == null) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: KultivaColors.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('💡', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Aucune lampe configurée',
                style: TextStyle(
                  fontSize: 13,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      );
    }
    final hours = light.hoursPerDay.toStringAsFixed(0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D0).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8C96A).withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(light.type.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${light.type.label}  ·  $hours h/jour',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          if (light.ledWatts != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              '${light.ledWatts} W'
              '${light.ledColorTemp != null ? "  ·  ${light.ledColorTemp!.label}" : ""}',
              style: TextStyle(
                fontSize: 12,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            _LampHeightAdvice(
              watts: light.ledWatts!,
              phase: _dominantPhase(install),
            ),
          ],
        ],
      ),
    );
  }

  /// Cherche la phase dominante parmi les plants de l'install — pour
  /// afficher une recommandation de hauteur sensée. Si pas de plants,
  /// on affiche la phase végétative par défaut.
  GrowthPhase _dominantPhase(HydroInstall install) {
    final cultures = CultureService.instance.loadAll();
    final byId = <String, CultureEntry>{
      for (final c in cultures) c.id: c,
    };
    final phases = <GrowthPhase, int>{};
    for (final cid in install.slotCultureIds) {
      if (cid == null) continue;
      final c = byId[cid];
      if (c == null) continue;
      phases.update(c.phase, (n) => n + 1, ifAbsent: () => 1);
    }
    if (phases.isEmpty) return GrowthPhase.vegetative;
    return phases.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }
}

class _LampHeightAdvice extends StatelessWidget {
  final int watts;
  final GrowthPhase phase;
  const _LampHeightAdvice({required this.watts, required this.phase});

  @override
  Widget build(BuildContext context) {
    final reco = recommendedLampHeight(phase: phase, watts: watts);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('📏', style: TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            reco.advice,
            style: TextStyle(
              fontSize: 11,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: KultivaColors.textPrimary.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}

class _FlushAlert extends StatelessWidget {
  final HydroInstall install;
  const _FlushAlert({required this.install});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8A87C).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8A87C)),
      ),
      child: Row(
        children: <Widget>[
          const Text('🪣', style: TextStyle(fontSize: 18)),
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
            onPressed: () =>
                HydroInstallService.instance.markFlushed(install.id),
            child: const Text('Fait'),
          ),
        ],
      ),
    );
  }
}

class _DailyReadingsButton extends StatelessWidget {
  final HydroInstall install;
  const _DailyReadingsButton({required this.install});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {
          AudioService.instance.play(Sfx.tap);
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => DailyReadingsSheet.forInstall(installId: install.id),
          );
        },
        icon: const Icon(Icons.auto_awesome, size: 18),
        label: const Text('Mes mesures du jour'),
        style: FilledButton.styleFrom(
          backgroundColor: KultivaColors.primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _SlotsGrid extends StatelessWidget {
  final HydroInstall install;
  const _SlotsGrid({required this.install});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.culturesVersion,
      builder: (context, _, __) {
        final cultures = CultureService.instance.loadAll();
        final byId = <String, CultureEntry>{
          for (final c in cultures) c.id: c,
        };
        return Column(
          children: <Widget>[
            for (var i = 0; i < install.slotCount; i++) ...<Widget>[
              if (i > 0) const SizedBox(height: 8),
              _SlotTile(
                install: install,
                slotIndex: i,
                culture: byId[install.slotCultureIds[i]],
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SlotTile extends StatelessWidget {
  final HydroInstall install;
  final int slotIndex;
  final CultureEntry? culture;

  const _SlotTile({
    required this.install,
    required this.slotIndex,
    required this.culture,
  });

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
    if (culture == null) {
      return _emptyTile(context);
    }
    return _filledTile(context);
  }

  Widget _emptyTile(BuildContext context) {
    return InkWell(
      onTap: () => _pickPlant(context),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: KultivaColors.textSecondary.withValues(alpha: 0.25),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: KultivaColors.lightGreen.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: KultivaColors.primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Slot ${slotIndex + 1}  ·  Touche pour ajouter un plant',
                style: TextStyle(
                  fontSize: 13,
                  color: KultivaColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filledTile(BuildContext context) {
    final veg = _veg();
    final c = culture!;
    return InkWell(
      onTap: () => _showPlantActions(context, c),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: KultivaColors.springB.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                veg?.emoji ?? '🌱',
                style: const TextStyle(fontSize: 26),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    veg?.name ?? c.vegetableId,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'J+${c.daysSinceStarted}  ·  ${c.phase.label}',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPlant(BuildContext context) async {
    AudioService.instance.play(Sfx.tap);
    final picked = await showModalBottomSheet<Vegetable>(
      context: context,
      isScrollControlled: true,
      backgroundColor: KultivaColors.lightBackground,
      builder: (_) => const _HydroVegetablePickerSheet(),
    );
    if (picked == null) return;

    // Crée la culture et l'attache au slot.
    final entry = await CultureService.instance.add(
      method: CultivationMethod.hydroponic,
      vegetableId: picked.id,
      startedAt: DateTime.now(),
    );
    await HydroInstallService.instance.placeCulture(
      installId: install.id,
      cultureId: entry.id,
      atSlot: slotIndex,
    );
  }

  Future<void> _showPlantActions(
      BuildContext context, CultureEntry c) async {
    AudioService.instance.play(Sfx.tap);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: KultivaColors.lightBackground,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            Text(
              c.vegetableId,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const _PhasePicker.title(),
            for (final phase in GrowthPhase.values)
              ListTile(
                leading: Text(phase.emoji,
                    style: const TextStyle(fontSize: 20)),
                title: Text(phase.label),
                trailing: c.phase == phase
                    ? const Icon(
                        Icons.check_circle,
                        color: KultivaColors.primaryGreen,
                      )
                    : null,
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await CultureService.instance
                      .update(c.copyWith(phase: phase));
                },
              ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Colors.red),
              title: const Text(
                'Retirer ce plant',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                await HydroInstallService.instance.removeCultureFromInstall(
                  installId: install.id,
                  cultureId: c.id,
                );
                await CultureService.instance.remove(c.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PhasePicker extends StatelessWidget {
  const _PhasePicker.title();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Phase de croissance',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: KultivaColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// Sheet de sélection d'un légume hydro-friendly à placer dans un slot.
/// Liste filtrée sur `vegetable.hydroFriendly == true`.
class _HydroVegetablePickerSheet extends StatefulWidget {
  const _HydroVegetablePickerSheet();

  @override
  State<_HydroVegetablePickerSheet> createState() =>
      _HydroVegetablePickerSheetState();
}

class _HydroVegetablePickerSheetState
    extends State<_HydroVegetablePickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = vegetablesBase.where((v) {
      if (!v.hydroFriendly) return false;
      if (_query.isEmpty) return true;
      return v.name.toLowerCase().contains(_query.toLowerCase());
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scroll) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: <Widget>[
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: KultivaColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choisis un plant',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Rechercher (tomate, basilic…)',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: scroll,
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final v = filtered[i];
                    return ListTile(
                      leading: Text(v.emoji,
                          style: const TextStyle(fontSize: 22)),
                      title: Text(v.name),
                      subtitle: v.note == null
                          ? null
                          : Text(
                              v.note!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      onTap: () {
                        AudioService.instance.play(Sfx.cart);
                        Navigator.of(context).pop(v);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
      ),
    );
  }
}
