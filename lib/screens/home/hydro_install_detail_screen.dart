import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
import '../../utils/phenology.dart';
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
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    children: <Widget>[
                      _SystemSummary(install: install),
                      const SizedBox(height: 14),
                      _LightSummary(install: install),
                      const SizedBox(height: 14),
                      if (install.flushDue) ...<Widget>[
                        _FlushAlert(install: install),
                        const SizedBox(height: 14),
                      ],
                      _EquipmentSection(install: install),
                      const SizedBox(height: 14),
                      _DailyReadingsButton(install: install),
                      const SizedBox(height: 18),
                      const _SectionTitle('🌿  Mes plants'),
                      const SizedBox(height: 8),
                      _SlotsGrid(install: install),
                    ],
                  ),
                ),
                // Picker style pleine terre : drag/drop d'un légume vers
                // un slot vide, ou tap pour placer dans le 1er slot vide.
                _HydroPlantPicker(install: install),
              ],
            ),
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
        // Layout préféré du système (DWC = 3×2, NFT = 4×2, etc.). Si
        // l'utilisateur a configuré moins/plus de slots que la grille
        // par défaut, on s'aligne sur slotCount en répartissant.
        final layout = install.systemType.defaultLayout;
        final cols = _computeCols(install.slotCount, layout.cols);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemCount: install.slotCount,
          itemBuilder: (_, i) => _SlotCell(
            install: install,
            slotIndex: i,
            culture: byId[install.slotCultureIds[i]],
          ),
        );
      },
    );
  }

  /// Choisit un nombre de colonnes raisonnable. La grille s'adapte au
  /// `slotCount` réel (pas de cap dur), avec un palier à ~6 colonnes
  /// pour rester lisible sur un écran de téléphone.
  int _computeCols(int slotCount, int defaultCols) {
    if (slotCount <= 0) return 1;
    if (slotCount <= 6) return slotCount;
    if (slotCount <= 12) return defaultCols.clamp(2, 4);
    if (slotCount <= 24) return 4;
    return 6;
  }
}

/// Cellule carrée d'un slot dans la grille de l'install. Style kawaii
/// cohérent avec les cases du planificateur pleine terre (gradient
/// pastel, arrondis 14, ombre douce).
class _SlotCell extends StatelessWidget {
  final HydroInstall install;
  final int slotIndex;
  final CultureEntry? culture;

  const _SlotCell({
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
      return _emptyCell(context);
    }
    return _filledCell(context);
  }

  Widget _emptyCell(BuildContext context) {
    // Une cellule vide est aussi un DragTarget : un drag depuis le
    // picker en bas droppé ici place le légume dans ce slot avec
    // « planté aujourd'hui » par défaut.
    return DragTarget<String>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) =>
          _placeQuick(context, details.data),
      builder: (ctx, candidates, _) {
        final hovering = candidates.isNotEmpty;
        return InkWell(
          onTap: () => _pickPlant(context),
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: hovering
                    ? <Color>[
                        KultivaColors.primaryGreen.withValues(alpha: 0.25),
                        KultivaColors.lightGreen.withValues(alpha: 0.4),
                      ]
                    : <Color>[
                        Colors.white,
                        KultivaColors.winterA.withValues(alpha: 0.55),
                      ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: hovering
                    ? KultivaColors.primaryGreen
                    : KultivaColors.textSecondary.withValues(alpha: 0.25),
                width: hovering ? 2 : 1,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:
                      KultivaColors.primaryGreen.withValues(alpha: 0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        KultivaColors.lightGreen.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: KultivaColors.primaryGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Slot ${slotIndex + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Placement rapide via drag/drop : crée la culture avec
  /// `startedAt = now` et `phase = seedling`. L'utilisateur peut
  /// ajuster ensuite en tapant sur le slot rempli.
  Future<void> _placeQuick(BuildContext context, String vegId) async {
    AudioService.instance.play(Sfx.plant);
    final entry = await CultureService.instance.add(
      method: CultivationMethod.hydroponic,
      vegetableId: vegId,
      startedAt: DateTime.now(),
    );
    await HydroInstallService.instance.placeCulture(
      installId: install.id,
      cultureId: entry.id,
      atSlot: slotIndex,
    );
  }

  Widget _filledCell(BuildContext context) {
    final veg = _veg();
    final c = culture!;
    return InkWell(
      onTap: () => _showPlantActions(context, c),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              KultivaColors.springB.withValues(alpha: 0.4),
              KultivaColors.springA.withValues(alpha: 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.55),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: KultivaColors.primaryGreen.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              veg?.emoji ?? '🌱',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 4),
            Text(
              veg?.name ?? c.vegetableId,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'J+${c.daysSinceStarted}',
              style: TextStyle(
                fontSize: 10,
                color: KultivaColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
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
    if (picked == null || !context.mounted) return;

    // Étape 2 : configurer la date de plantation (et phase déduite,
    // overridable par l'utilisateur).
    final result = await showModalBottomSheet<_PlantConfig>(
      context: context,
      isScrollControlled: true,
      backgroundColor: KultivaColors.lightBackground,
      builder: (_) => _PlantConfigSheet(veg: picked),
    );
    if (result == null) return;

    // Crée la culture avec la bonne date de démarrage.
    final entry = await CultureService.instance.add(
      method: CultivationMethod.hydroponic,
      vegetableId: picked.id,
      startedAt: result.startedAt,
    );
    // Si la phase diffère du défaut (seedling), on la met à jour.
    if (result.phase != GrowthPhase.seedling) {
      await CultureService.instance.update(
        entry.copyWith(phase: result.phase),
      );
    }

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
                        AudioService.instance.play(Sfx.plant);
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

/// Section « 🛒 Mon équipement de mesure ». Liste les 4 outils essentiels
/// (pH-mètre, EC-mètre, thermomètre, hygromètre) avec leur statut
/// (configuré / pas encore). Bouton « Acheter » ouvre Amazon avec le
/// tag affilié Kultiva. Bouton « Configuré » bascule l'état (l'utilisateur
/// déclare avoir l'outil → le champ correspondant apparaît dans
/// « Mes mesures du jour »).
/// Section « Mon équipement de mesure » — désormais rétractable
/// (replié par défaut, déplié si rien n'est encore configuré pour
/// orienter l'utilisateur vers la configuration initiale).
class _EquipmentSection extends StatelessWidget {
  final HydroInstall install;
  const _EquipmentSection({required this.install});

  Future<void> _openAmazon(HydroEquipment e) async {
    final uri = Uri.parse(e.amazonUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final hasAny = install.equipment.isNotEmpty;
    final ownedCount = install.equipment.length;
    final totalCount = HydroEquipment.values.length;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: KultivaColors.lightGreen.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Theme(
        // Désactive les divisions par défaut de l'ExpansionTile.
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          // Replié par défaut (validé avec l'utilisatrice). On déplie
          // automatiquement si rien n'est configuré, pour pousser
          // doucement à se renseigner sur le matériel.
          initiallyExpanded: !hasAny,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
          leading: const Text('🛒', style: TextStyle(fontSize: 20)),
          title: const Text(
            'Mon équipement de mesure',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            hasAny
                ? '$ownedCount/$totalCount outils configurés'
                : 'À configurer pour débloquer les mesures',
            style: TextStyle(
              fontSize: 11,
              color: KultivaColors.textSecondary,
            ),
          ),
          trailing: hasAny
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$ownedCount/$totalCount',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                )
              : null,
          children: <Widget>[
            if (!hasAny) ...<Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Sans ces outils, tu cultives à l\'aveugle. Voici les '
                  '4 mesures qui font la différence.',
                  style: TextStyle(
                    fontSize: 11,
                    color: KultivaColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
            for (final e in HydroEquipment.values) ...<Widget>[
              _EquipmentRow(
                install: install,
                equipment: e,
                owned: install.equipment.contains(e),
                onToggle: () => HydroInstallService.instance
                    .toggleEquipment(install.id, e),
                onBuy: () => _openAmazon(e),
              ),
              if (e != HydroEquipment.values.last)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Divider(height: 1),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EquipmentRow extends StatelessWidget {
  final HydroInstall install;
  final HydroEquipment equipment;
  final bool owned;
  final VoidCallback onToggle;
  final VoidCallback onBuy;

  const _EquipmentRow({
    required this.install,
    required this.equipment,
    required this.owned,
    required this.onToggle,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: owned
                  ? KultivaColors.primaryGreen.withValues(alpha: 0.15)
                  : KultivaColors.lightGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(equipment.emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        equipment.label,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (owned)
                      const Icon(
                        Icons.check_circle,
                        color: KultivaColors.primaryGreen,
                        size: 18,
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  equipment.whyItMatters,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.35,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    OutlinedButton.icon(
                      onPressed: onToggle,
                      icon: Icon(
                        owned ? Icons.remove_circle_outline : Icons.check,
                        size: 14,
                      ),
                      label: Text(
                        owned ? 'Je ne l\'ai plus' : 'J\'ai déjà',
                        style: const TextStyle(fontSize: 11),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: const Size(0, 30),
                        foregroundColor: owned
                            ? KultivaColors.textSecondary
                            : KultivaColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (!owned)
                      FilledButton.icon(
                        onPressed: onBuy,
                        icon: const Icon(Icons.shopping_cart, size: 14),
                        label: Text(
                          'Acheter ${equipment.priceHint}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          minimumSize: const Size(0, 30),
                          backgroundColor: KultivaColors.terracotta,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Bundle de configuration d'un nouveau plant — date plantée + phase.
class _PlantConfig {
  final DateTime startedAt;
  final GrowthPhase phase;
  const _PlantConfig({required this.startedAt, required this.phase});
}

/// Sheet « Quand l'as-tu planté ? » — slider 0-180 jours, phase
/// déduite live depuis les données phénologiques du légume,
/// override possible.
class _PlantConfigSheet extends StatefulWidget {
  final Vegetable veg;

  const _PlantConfigSheet({required this.veg});

  @override
  State<_PlantConfigSheet> createState() => _PlantConfigSheetState();
}

class _PlantConfigSheetState extends State<_PlantConfigSheet> {
  int _daysAgo = 0;
  GrowthPhase? _phaseOverride; // null = utilise la phase déduite

  GrowthPhase _deducedPhase() => deducedPhase(widget.veg, _daysAgo);

  GrowthPhase get _activePhase => _phaseOverride ?? _deducedPhase();

  @override
  Widget build(BuildContext context) {
    final phase = _activePhase;
    final isOverride = _phaseOverride != null;
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (_, scroll) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: ListView(
            controller: scroll,
            children: <Widget>[
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: KultivaColors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Quand l\'as-tu planté ?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  '${widget.veg.emoji}  ${widget.veg.name}',
                  style: TextStyle(
                    fontSize: 13,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // ─── Slider jours ────────────────────────────────────
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: KultivaColors.lightGreen.withValues(alpha: 0.6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _daysLabel(_daysAgo),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _daysAgo == 0
                          ? 'Tu viens de le planter'
                          : 'Il y a $_daysAgo jour${_daysAgo > 1 ? "s" : ""}',
                      style: TextStyle(
                        fontSize: 12,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                    Slider(
                      value: _daysAgo.toDouble(),
                      min: 0,
                      max: 180,
                      divisions: 180,
                      activeColor: KultivaColors.primaryGreen,
                      onChanged: (v) => setState(() {
                        _daysAgo = v.round();
                        _phaseOverride = null; // reset l'override
                      }),
                    ),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        _quickChip('Aujourd\'hui', 0),
                        _quickChip('Il y a 1 sem', 7),
                        _quickChip('Il y a 2 sem', 14),
                        _quickChip('Il y a 1 mois', 30),
                        _quickChip('Il y a 2 mois', 60),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ─── Phase déduite ───────────────────────────────────
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: KultivaColors.springB.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      isOverride
                          ? 'Phase choisie manuellement'
                          : '✨ Phase déduite automatiquement',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Text(phase.emoji, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            phase.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final p in GrowthPhase.values)
                          _phaseChip(p, p == phase),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ─── Bouton confirmer ────────────────────────────────
              FilledButton.icon(
                onPressed: () {
                  AudioService.instance.play(Sfx.plant);
                  Navigator.of(context).pop(_PlantConfig(
                    startedAt: DateTime.now()
                        .subtract(Duration(days: _daysAgo)),
                    phase: phase,
                  ));
                },
                icon: const Icon(Icons.check),
                label: const Text('Planter ici'),
                style: FilledButton.styleFrom(
                  backgroundColor: KultivaColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _daysLabel(int days) {
    if (days == 0) return 'Planté aujourd\'hui';
    return 'Planté il y a $days jour${days > 1 ? "s" : ""}';
  }

  Widget _quickChip(String label, int days) {
    final selected = _daysAgo == days && _phaseOverride == null;
    return GestureDetector(
      onTap: () => setState(() {
        _daysAgo = days;
        _phaseOverride = null;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? KultivaColors.primaryGreen.withValues(alpha: 0.18)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.lightGreen.withValues(alpha: 0.5),
            width: selected ? 1.8 : 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _phaseChip(GrowthPhase p, bool selected) {
    return GestureDetector(
      onTap: () => setState(() {
        _phaseOverride = p == _deducedPhase() ? null : p;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? KultivaColors.primaryGreen.withValues(alpha: 0.22)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.lightGreen.withValues(alpha: 0.5),
            width: selected ? 1.8 : 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(p.emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              p.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                color: selected
                    ? KultivaColors.primaryGreen
                    : KultivaColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Picker de légumes hydro-friendly fixé en bas du détail d'install.
/// Reproduit le pattern du _PlantPicker de pleine terre : chips de
/// filtre par catégorie + ListView horizontal de cartes draggables.
///
/// Drag d'une carte vers un slot vide → place le légume avec
/// `startedAt = now`. Tap sur une carte → place dans le 1er slot vide.
class _HydroPlantPicker extends StatefulWidget {
  final HydroInstall install;
  const _HydroPlantPicker({required this.install});

  @override
  State<_HydroPlantPicker> createState() => _HydroPlantPickerState();
}

enum _PickerCatFilter { favorites, all, byCategory }

class _HydroPlantPickerState extends State<_HydroPlantPicker> {
  _PickerCatFilter _filter = _PickerCatFilter.favorites;
  VegetableCategory? _selectedCategory;
  String _query = '';

  static const List<VegetableCategory> _orderedCats = <VegetableCategory>[
    VegetableCategory.leaves,
    VegetableCategory.fruits,
    VegetableCategory.aromatics,
    VegetableCategory.roots,
    VegetableCategory.bulbs,
    VegetableCategory.flowers,
  ];

  bool _matches(Vegetable v, Set<String> favs) {
    if (!v.hydroFriendly) return false;
    if (v.category == VegetableCategory.accessories) return false;
    if (_query.isNotEmpty &&
        !v.name.toLowerCase().contains(_query.toLowerCase())) {
      return false;
    }
    switch (_filter) {
      case _PickerCatFilter.favorites:
        return favs.contains(v.id);
      case _PickerCatFilter.all:
        return true;
      case _PickerCatFilter.byCategory:
        return _selectedCategory != null &&
            v.category == _selectedCategory;
    }
  }

  Future<void> _placeInFirstEmptySlot(Vegetable v) async {
    AudioService.instance.play(Sfx.plant);
    final emptyIndex = widget.install.slotCultureIds.indexOf(null);
    if (emptyIndex < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun slot vide — agrandis ton install'),
        ),
      );
      return;
    }
    final entry = await CultureService.instance.add(
      method: CultivationMethod.hydroponic,
      vegetableId: v.id,
      startedAt: DateTime.now(),
    );
    await HydroInstallService.instance.placeCulture(
      installId: widget.install.id,
      cultureId: entry.id,
      atSlot: emptyIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                '🌱  Glisse un plant vers une case',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 130,
                height: 32,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Chercher…',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 16),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Chips filtre.
          SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _filterChip('⭐  Favoris', _PickerCatFilter.favorites, null),
                const SizedBox(width: 6),
                _filterChip('🌍  Tous', _PickerCatFilter.all, null),
                for (final cat in _orderedCats) ...<Widget>[
                  const SizedBox(width: 6),
                  _filterChip(
                    '${cat.emoji}  ${cat.label}',
                    _PickerCatFilter.byCategory,
                    cat,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Liste horizontale de cartes draggables.
          ValueListenableBuilder<Set<String>>(
            valueListenable: PrefsService.instance.favorites,
            builder: (_, favs, __) {
              final list = vegetablesBase
                  .where((v) => _matches(v, favs))
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));
              return SizedBox(
                height: 86,
                child: list.isEmpty
                    ? Center(
                        child: Text(
                          _filter == _PickerCatFilter.favorites
                              ? 'Aucun favori. Tape Tous ou une catégorie.'
                              : 'Aucun plant ne correspond.',
                          style: TextStyle(
                            fontSize: 11,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 8),
                        itemBuilder: (_, i) => _DraggablePlantCard(
                          plant: list[i],
                          onTapPlace: () => _placeInFirstEmptySlot(list[i]),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    _PickerCatFilter target,
    VegetableCategory? cat,
  ) {
    final selected = _filter == target &&
        (target != _PickerCatFilter.byCategory ||
            _selectedCategory == cat);
    return GestureDetector(
      onTap: () {
        AudioService.instance.play(Sfx.tap);
        setState(() {
          _filter = target;
          _selectedCategory = cat;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected
              ? KultivaColors.primaryGreen.withValues(alpha: 0.18)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.lightGreen.withValues(alpha: 0.6),
            width: selected ? 1.6 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// Carte draggable d'un plant dans le picker. LongPress pour démarrer
/// le drag (évite les conflits avec le scroll horizontal). Tap court
/// → placement automatique dans le premier slot vide.
class _DraggablePlantCard extends StatelessWidget {
  final Vegetable plant;
  final VoidCallback onTapPlace;

  const _DraggablePlantCard({
    required this.plant,
    required this.onTapPlace,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<String>(
      data: plant.id,
      delay: const Duration(milliseconds: 200),
      feedback: _cardBody(elevated: true),
      childWhenDragging: Opacity(opacity: 0.4, child: _cardBody()),
      child: GestureDetector(
        onTap: onTapPlace,
        child: _cardBody(),
      ),
    );
  }

  Widget _cardBody({bool elevated = false}) {
    return Container(
      width: 72,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: KultivaColors.lightGreen.withValues(alpha: 0.6),
        ),
        boxShadow: elevated
            ? <BoxShadow>[
                BoxShadow(
                  color:
                      KultivaColors.primaryGreen.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(plant.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 2),
            Text(
              plant.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
