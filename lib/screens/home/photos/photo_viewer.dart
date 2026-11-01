import '../../../data/names_en.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/challenges.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/garden_photo.dart';
import '../../../services/plantation_service.dart';
import '../../../utils/months.dart';

/// Une photo en plein écran, avec ce qu'on sait d'elle.
///
/// Zoomable : une photo de feuille tachée ne sert à rien si on ne peut
/// pas s'en approcher.
Future<void> showPhotoViewer(
  BuildContext context, {
  required GardenPhoto photo,
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => _PhotoViewer(photo: photo),
    ),
  );
}

class _PhotoViewer extends StatelessWidget {
  final GardenPhoto photo;

  const _PhotoViewer({required this.photo});

  String get _titre {
    if (photo.source == PhotoSource.challenge) {
      final defi =
          allChallenges.where((c) => c.id == photo.challengeId).firstOrNull;
      return defi == null ? 'Défi photo' : '${defi.emoji}  ${defi.name}';
    }
    final id = photo.vegetableId;
    if (id == null) return 'Photo du jardin';
    final veg = vegetableById(id);
    return '${veg.emoji}  ${veg.displayName}';
  }

  String get _sousTitre {
    final quand = dayLabel(photo.takenAt);
    final age = photo.ageSentence;
    return age == null ? quand : '$quand  ·  $age';
  }

  Future<void> _supprimer(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer cette photo ?'),
        content: const Text(
          'Elle sera effacée de l\'appareil. Kultiva ne garde aucune '
          'copie ailleurs, donc c\'est définitif.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final plantId = photo.plantationId;
    if (plantId != null) {
      // Le plant est propriétaire de sa photo : c'est lui qui la retire,
      // fichier compris. On ne touche pas au disque depuis l'écran.
      await PlantationService.instance.removePhoto(plantId, photo.path);
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Une photo de défi n'a pas de propriétaire qui sache la retirer
    // proprement : son magasin est la grille des défis, qui s'en charge.
    final supprimable = photo.plantationId != null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _titre,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Text(
              _sousTitre,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: <Widget>[
          if (supprimable)
            IconButton(
              tooltip: 'Supprimer',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _supprimer(context),
            ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          child: Image.file(
            File(photo.path),
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'Cette photo n\'est plus sur l\'appareil.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
