import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/garden_photo.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/months.dart';
import 'photo_viewer.dart';

/// La pellicule : toutes les photos du jardin, du plus récent au plus
/// ancien, regroupées par mois.
class PhotoGallery extends StatelessWidget {
  final List<GardenPhoto> photos;
  final VoidCallback onChanged;

  const PhotoGallery({
    super.key,
    required this.photos,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) return const _PelliculeVide();

    // Les photos arrivent déjà triées du plus récent au plus ancien :
    // on découpe la liste à chaque changement de mois sans retrier.
    final sections = <_Section>[];
    for (final p in photos) {
      final cle = '${p.takenAt.year}-${p.takenAt.month}';
      if (sections.isEmpty || sections.last.cle != cle) {
        sections.add(_Section(cle, monthLabel(p.takenAt), <GardenPhoto>[p]));
      } else {
        sections.last.photos.add(p);
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
      itemCount: sections.length,
      itemBuilder: (context, i) {
        final s = sections[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(2, i == 0 ? 4 : 18, 2, 8),
              child: Text(
                s.titre,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: s.photos.length,
              itemBuilder: (_, j) => PhotoThumbnail(
                photo: s.photos[j],
                onChanged: onChanged,
                showAge: false,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Section {
  final String cle;
  final String titre;
  final List<GardenPhoto> photos;
  _Section(this.cle, this.titre, this.photos);
}

/// Une vignette carrée, avec son âge en surimpression.
class PhotoThumbnail extends StatelessWidget {
  final GardenPhoto photo;
  final VoidCallback onChanged;

  /// Affiche « J+12 » en bas de la vignette. Vrai dans l'évolution
  /// d'un plant, où l'écart entre deux photos est tout le sujet ; faux
  /// dans la pellicule, où l'étiquette se répète sur chaque case sans
  /// rien apprendre.
  final bool showAge;

  const PhotoThumbnail({
    super.key,
    required this.photo,
    required this.onChanged,
    this.showAge = true,
  });

  /// Ce que la photo montre, en un caractère.
  String get _marque {
    if (photo.source == PhotoSource.challenge) return '🏆';
    final id = photo.vegetableId;
    return id == null ? '🌱' : vegetableById(id).emoji;
  }

  @override
  Widget build(BuildContext context) {
    final age = photo.ageLabel;
    return Semantics(
      button: true,
      label: 'Photo du jardin${age == null ? '' : ', $age'}',
      child: GestureDetector(
        onTap: () async {
          await showPhotoViewer(context, photo: photo);
          onChanged();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.file(
                File(photo.path),
                fit: BoxFit.cover,
                // `cacheWidth` évite de décoder une photo de 1600 px
                // pour l'afficher dans une vignette de 120 : sans ça une
                // pellicule d'une centaine de photos sature la mémoire.
                cacheWidth: 360,
                errorBuilder: (_, __, ___) => Container(
                  color: KultivaColors.lightGreen.withValues(alpha: 0.3),
                  child: const Icon(Icons.broken_image_outlined,
                      color: Colors.white70),
                ),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_marque,
                      style: const TextStyle(fontSize: 11)),
                ),
              ),
              if (showAge && age != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Colors.black.withValues(alpha: 0.55),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      age,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PelliculeVide extends StatelessWidget {
  const _PelliculeVide();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('📷', style: TextStyle(fontSize: 44)),
            SizedBox(height: 12),
            Text(
              'Aucune photo pour l\'instant',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8),
            Text(
              'Photographie un plant aujourd\'hui, puis le même dans une '
              'semaine : c\'est en les voyant côte à côte qu\'on se rend '
              'compte que ça pousse.',
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
