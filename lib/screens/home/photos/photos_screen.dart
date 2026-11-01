import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/garden_photo.dart';
import '../../../models/photo_pick_result.dart';
import '../../../models/plantation.dart';
import '../../../services/audio_service.dart';
import '../../../services/photo_library_service.dart';
import '../../../services/photo_service.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/camera_permission_dialog.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/season_header.dart';
import 'photo_gallery.dart';
import 'photo_timeline.dart';

/// L'onglet Photo : tout ce que le jardin a laissé en images.
///
/// Les photos existaient déjà — chaque plant porte les siennes, chaque
/// défi la sienne — mais elles n'étaient visibles qu'une par une, au
/// fond du dossier d'un plant. Personne ne pouvait voir son jardin en
/// photos, ni comparer un plant à lui-même d'une semaine à l'autre.
///
/// Deux vues, pas quatre : la pellicule, et l'évolution par plant.
class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  bool _evolution = false;
  List<GardenPhoto> _photos = <GardenPhoto>[];

  @override
  void initState() {
    super.initState();
    _recharger();
    PlantationService.instance.addListener(_recharger);
  }

  @override
  void dispose() {
    PlantationService.instance.removeListener(_recharger);
    super.dispose();
  }

  void _recharger() {
    if (!mounted) return;
    setState(() => _photos = PhotoLibraryService.all());
  }

  /// Prend une photo et l'accroche à un plant.
  ///
  /// L'ordre compte : on demande le plant **avant** d'ouvrir la caméra.
  /// L'inverse obligeait à choisir une fois la photo prise, et une
  /// hésitation à ce moment-là perdait la photo.
  Future<void> _prendrePhoto() async {
    final actifs = PlantationService.instance.active;
    if (actifs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Plante d\'abord quelque chose : une photo s\'accroche à un plant.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final plant = actifs.length == 1
        ? actifs.first
        : await showModalBottomSheet<Plantation>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => _ChoixDuPlant(plants: actifs),
          );
    if (plant == null || !mounted) return;

    final result = await PhotoService.pickDetailed(fromCamera: true);
    if (result.status == PhotoPickStatus.permissionDenied) {
      if (!mounted) return;
      await showCameraPermissionDialog(context);
      return;
    }
    final path = result.path;
    if (path == null) return;

    AudioService.instance.play(Sfx.camera);
    // La photo appartient au plant : c'est son service qui l'enregistre,
    // et l'écouteur posé dans `initState` rafraîchit la pellicule.
    await PlantationService.instance.addPhoto(plant.id, path);
    if (!mounted) return;

    final combien = PhotoLibraryService.forPlantation(plant.id).length;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(combien >= 2
            ? 'Photo ajoutée 📸 — regarde l\'évolution de ton plant.'
            : 'Photo ajoutée 📸'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SeasonHeader(
                  season: Season.current(mois),
                  month: mois,
                  height: kPageHeaderHeight,
                  hideLabel: true,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '📷  Photos',
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
                          _photos.isEmpty
                              ? 'Le jardin n\'a pas encore de souvenirs'
                              : '${_photos.length} photo'
                                  '${_photos.length > 1 ? 's' : ''} du jardin',
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SegmentedButton<bool>(
                segments: const <ButtonSegment<bool>>[
                  ButtonSegment<bool>(value: false, label: Text('🎞  Pellicule')),
                  ButtonSegment<bool>(value: true, label: Text('🌱  Évolution')),
                ],
                selected: <bool>{_evolution},
                showSelectedIcon: false,
                onSelectionChanged: (s) =>
                    setState(() => _evolution = s.first),
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor:
                      KultivaColors.primaryGreen.withValues(alpha: 0.18),
                  selectedForegroundColor: KultivaColors.primaryGreen,
                ),
              ),
            ),
            Expanded(
              child: _evolution
                  ? PhotoTimeline(onChanged: _recharger)
                  : PhotoGallery(photos: _photos, onChanged: _recharger),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _prendrePhoto,
        backgroundColor: KultivaColors.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.photo_camera_outlined),
        label: const Text('Photographier'),
      ),
    );
  }
}

/// Quel plant est sur la photo ? Posé avant d'ouvrir la caméra.
class _ChoixDuPlant extends StatelessWidget {
  final List<Plantation> plants;

  const _ChoixDuPlant({required this.plants});

  @override
  Widget build(BuildContext context) {
    final sombre = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sombre ? KultivaColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Text(
                'Quel plant photographies-tu ?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: plants.length,
                itemBuilder: (_, i) {
                  final p = plants[i];
                  final veg = vegetableById(p.vegetableId);
                  final jours = p.daysSincePlanted;
                  return ListTile(
                    leading:
                        Text(veg.emoji, style: const TextStyle(fontSize: 22)),
                    title: Text(
                      veg.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      jours <= 0 ? 'Planté aujourd\'hui' : 'En terre depuis '
                          '$jours jour${jours > 1 ? 's' : ''}',
                    ),
                    onTap: () => Navigator.of(context).pop(p),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
