import 'package:flutter/material.dart';

import '../../../models/photo_pick_result.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../services/audio_service.dart';
import '../../../services/photo_service.dart';
import '../../../services/plantation_service.dart';
import '../../../widgets/camera_permission_dialog.dart';
import 'plantation_detail_sheet.dart';

/// Ouvre le dossier d'un plant : arrosages, récoltes, photos, note.
///
/// Un seul point d'entrée, parce qu'il n'y a qu'un dossier par plant.
/// Le câblage vivait dans `poussidex_collection.dart` ; le cahier de
/// culture en a besoin lui aussi, et dupliquer huit callbacks c'est
/// se garantir deux comportements qui divergent — l'un jouant le son
/// de l'arrosoir, l'autre non.
Future<void> showPlantationSheet(
  BuildContext context,
  Plantation plantation,
  Vegetable vegetable,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) {
      // La feuille se reconstruit à chaque mutation du service, sinon
      // un arrosage ne s'afficherait qu'après fermeture/réouverture.
      return ListenableBuilder(
        listenable: PlantationService.instance,
        builder: (context, _) {
          final fresh = PlantationService.instance.byId(plantation.id);
          if (fresh == null) {
            // Le plant vient d'être retiré : on referme.
            Navigator.of(sheetCtx).maybePop();
            return const SizedBox.shrink();
          }
          return PlantationDetailSheet(
            plantation: fresh,
            vegetable: vegetable,
            onWater: () {
              AudioService.instance.play(Sfx.water);
              PlantationService.instance.water(fresh.id);
            },
            onHarvest: () {
              AudioService.instance.play(Sfx.celebrate);
              PlantationService.instance.harvest(fresh.id);
            },
            onTerminate: () => PlantationService.instance.terminate(fresh.id),
            onRemove: () {
              Navigator.of(sheetCtx).pop();
              _confirmRemove(context, fresh, vegetable);
            },
            onNoteChanged: (note) =>
                PlantationService.instance.setNote(fresh.id, note),
            onAddPhoto: (fromCamera) => _addPhoto(context, fresh, fromCamera),
            onRemovePhoto: (path) =>
                PlantationService.instance.removePhoto(fresh.id, path),
          );
        },
      );
    },
  );
}

Future<void> _confirmRemove(
  BuildContext context,
  Plantation p,
  Vegetable v,
) async {
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

Future<void> _addPhoto(
  BuildContext context,
  Plantation p,
  bool fromCamera,
) async {
  final result = await PhotoService.pickDetailed(fromCamera: fromCamera);
  if (!context.mounted) return;
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📷 Photo impossible — réessaie dans un instant'),
          ),
        );
      }
      break;
  }
}
