import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/garden_photo.dart';
import '../../../models/plantation.dart';
import '../../../services/photo_library_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/months.dart';
import 'photo_gallery.dart';

/// L'évolution de chaque plant, une ligne par plant.
///
/// C'est le vrai usage des photos d'un jardin : pas « montre-moi mes
/// photos », mais « montre-moi ce plant il y a trois semaines ». La
/// donnée existait depuis le début — chaque `Plantation` porte ses
/// photos — mais il fallait ouvrir le dossier d'un plant à la fois pour
/// les voir, et rien ne les mettait côte à côte.
class PhotoTimeline extends StatelessWidget {
  final VoidCallback onChanged;

  const PhotoTimeline({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final plants = PhotoLibraryService.plantsWithPhotos();
    if (plants.isEmpty) return const _EvolutionVide();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
      itemCount: plants.length,
      itemBuilder: (_, i) => _PlantCard(
        plant: plants[i],
        onChanged: onChanged,
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  final Plantation plant;
  final VoidCallback onChanged;

  const _PlantCard({required this.plant, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final veg = vegetableById(plant.vegetableId);
    final photos = PhotoLibraryService.forPlantation(plant.id);
    if (photos.isEmpty) return const SizedBox.shrink();

    final sombre = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: sombre ? KultivaColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: KultivaColors.lightGreen.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(veg.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  veg.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${photos.length} photo${photos.length > 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (photos.length >= 2)
            _AvantApres(
              premiere: photos.first,
              derniere: photos.last,
              onChanged: onChanged,
            )
          else
            SizedBox(
              height: 110,
              child: PhotoThumbnail(photo: photos.first, onChanged: onChanged),
            ),
          if (photos.length > 2) ...<Widget>[
            const SizedBox(height: 10),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) => SizedBox(
                  width: 72,
                  child: PhotoThumbnail(
                    photo: photos[i],
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// La première photo et la dernière, côte à côte. C'est la vue qui fait
/// l'effet : un mois d'écart tient dans un coup d'œil.
class _AvantApres extends StatelessWidget {
  final GardenPhoto premiere;
  final GardenPhoto derniere;
  final VoidCallback onChanged;

  const _AvantApres({
    required this.premiere,
    required this.derniere,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ecart = derniere.takenAt.difference(premiere.takenAt).inDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: Row(
            children: <Widget>[
              Expanded(
                child: PhotoThumbnail(photo: premiere, onChanged: onChanged),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: PhotoThumbnail(photo: derniere, onChanged: onChanged),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          ecart <= 0
              ? 'Deux photos du même jour'
              : '${dayLabel(premiere.takenAt)} → ${dayLabel(derniere.takenAt)}'
                  '  ·  $ecart jour${ecart > 1 ? 's' : ''} d\'écart',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: KultivaColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _EvolutionVide extends StatelessWidget {
  const _EvolutionVide();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('🌱', style: TextStyle(fontSize: 44)),
            SizedBox(height: 12),
            Text(
              'Aucun plant photographié',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8),
            Text(
              'Dès qu\'un plant a deux photos, Kultiva les met côte à '
              'côte et compte les jours entre les deux.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: KultivaColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
