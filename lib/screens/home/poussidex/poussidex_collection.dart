import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/photo_pick_result.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../models/vegetable_medal.dart';
import '../../../services/audio_service.dart';
import '../../../services/photo_service.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/camera_permission_dialog.dart';
import 'plantation_detail_sheet.dart';
import 'poussidex_card.dart';
import 'poussidex_journal.dart';
import 'poussidex_podium.dart';
import 'poussidex_stats.dart';

/// Vues de la collection. Les quatre écrans existaient déjà mais aucun
/// n'était atteignable : `PlantationCard`, `PlantationDetailSheet`,
/// `PoussidexJournalView`, `PoussidexPodiumView` et `PoussidexStatsView`
/// n'étaient importés par aucun fichier. C'est ce que cet écran relie.
enum _CollectionView { grille, journal, podium, stats }

extension _CollectionViewLabel on _CollectionView {
  String get label {
    switch (this) {
      case _CollectionView.grille:
        return '🪴 Plants';
      case _CollectionView.journal:
        return '📖 Journal';
      case _CollectionView.podium:
        return '🏅 Podium';
      case _CollectionView.stats:
        return '📊 Stats';
    }
  }
}

/// La collection de plants — le « Poussidex » promis par la fiche
/// App Store : chaque plant avec ses photos, ses arrosages, ses récoltes
/// et ses médailles.
class PoussidexCollectionView extends StatefulWidget {
  final List<Plantation> plantations;
  final Map<String, MedalTier> medals;

  /// Emmène l'utilisateur vers le catalogue, seul endroit d'où l'on
  /// ajoute un plant (« Je l'ai planté » sur une fiche légume).
  final VoidCallback onBrowseCatalogue;

  const PoussidexCollectionView({
    super.key,
    required this.plantations,
    required this.medals,
    required this.onBrowseCatalogue,
  });

  @override
  State<PoussidexCollectionView> createState() =>
      _PoussidexCollectionViewState();
}

class _PoussidexCollectionViewState extends State<PoussidexCollectionView> {
  _CollectionView _view = _CollectionView.grille;

  Vegetable? _vegetableFor(Plantation p) {
    for (final v in vegetablesBase) {
      if (v.id == p.vegetableId) return v;
    }
    // Un plant dont l'espèce a disparu du catalogue : on ne l'affiche
    // pas, plutôt que de montrer une tomate à sa place.
    return null;
  }

  Future<void> _addPhoto(Plantation p, bool fromCamera) async {
    final result = await PhotoService.pickDetailed(fromCamera: fromCamera);
    if (!mounted) return;
    switch (result.status) {
      case PhotoPickStatus.success:
        if (result.path != null) {
          await PlantationService.instance.addPhoto(p.id, result.path!);
        }
        break;
      case PhotoPickStatus.permissionDenied:
        await showCameraPermissionDialog(context);
        break;
      case PhotoPickStatus.cancelled:
        break;
      case PhotoPickStatus.error:
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('📷 Photo impossible — réessaie dans un instant'),
            ),
          );
        }
        break;
    }
  }

  Future<void> _confirmRemove(Plantation p, Vegetable v) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Retirer ${v.name} ?'),
        content: const Text(
          'Le plant et ses photos seront supprimés de ta collection. '
          'Cette action est définitive.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Retirer'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await PlantationService.instance.remove(p.id);
    }
  }

  void _openDetail(Plantation p, Vegetable v) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        // La feuille se reconstruit à chaque mutation du service, sinon
        // un arrosage ne s'afficherait qu'après fermeture/réouverture.
        return ListenableBuilder(
          listenable: PlantationService.instance,
          builder: (context, _) {
            final fresh = PlantationService.instance.byId(p.id);
            if (fresh == null) {
              // Le plant vient d'être retiré : on referme.
              Navigator.of(sheetCtx).maybePop();
              return const SizedBox.shrink();
            }
            return PlantationDetailSheet(
              plantation: fresh,
              vegetable: v,
              onWater: () {
                AudioService.instance.play(Sfx.water);
                PlantationService.instance.water(fresh.id);
              },
              onHarvest: () {
                AudioService.instance.play(Sfx.celebrate);
                PlantationService.instance.harvest(fresh.id);
              },
              onTerminate: () =>
                  PlantationService.instance.terminate(fresh.id),
              onRemove: () {
                Navigator.of(sheetCtx).pop();
                _confirmRemove(fresh, v);
              },
              onNoteChanged: (note) =>
                  PlantationService.instance.setNote(fresh.id, note),
              onAddPhoto: (fromCamera) => _addPhoto(fresh, fromCamera),
              onRemovePhoto: (path) =>
                  PlantationService.instance.removePhoto(fresh.id, path),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.plantations.isEmpty) {
      return _EmptyCollection(onBrowseCatalogue: widget.onBrowseCatalogue);
    }
    return Column(
      children: <Widget>[
        _ViewSwitcher(
          current: _view,
          onChanged: (v) => setState(() => _view = v),
        ),
        Expanded(child: _buildView()),
      ],
    );
  }

  Widget _buildView() {
    switch (_view) {
      case _CollectionView.grille:
        return _buildGrid();
      case _CollectionView.journal:
        return PoussidexJournalView(plantations: widget.plantations);
      case _CollectionView.podium:
        return PoussidexPodiumView(plantations: widget.plantations);
      case _CollectionView.stats:
        return PoussidexStatsView(plantations: widget.plantations);
    }
  }

  Widget _buildGrid() {
    // Même délégué que la grille des badges : la largeur maximale de
    // tuile rend la grille responsive sans seuil à maintenir.
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 190,
        childAspectRatio: 0.72,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: widget.plantations.length,
      itemBuilder: (context, i) {
        final p = widget.plantations[i];
        final v = _vegetableFor(p);
        if (v == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            AudioService.instance.play(Sfx.tap);
            _openDetail(p, v);
          },
          child: PlantationCard(
            plantation: p,
            vegetable: v,
            tier: widget.medals[p.vegetableId] ?? MedalTier.none,
          ),
        );
      },
    );
  }
}

class _ViewSwitcher extends StatelessWidget {
  final _CollectionView current;
  final ValueChanged<_CollectionView> onChanged;

  const _ViewSwitcher({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: <Widget>[
          for (final v in _CollectionView.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(v.label),
                selected: current == v,
                onSelected: (_) {
                  AudioService.instance.play(Sfx.tap);
                  onChanged(v);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyCollection extends StatelessWidget {
  final VoidCallback onBrowseCatalogue;

  const _EmptyCollection({required this.onBrowseCatalogue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('🪴', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              'Ta collection est vide',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Chaque plant que tu mets en terre entre ici, avec ses '
              'photos, ses arrosages et ses récoltes. Choisis un légume '
              'dans le catalogue, puis touche « Je l\'ai planté ».',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onBrowseCatalogue,
              icon: const Text('🌱', style: TextStyle(fontSize: 18)),
              label: const Text('Parcourir le catalogue'),
            ),
          ],
        ),
      ),
    );
  }
}
