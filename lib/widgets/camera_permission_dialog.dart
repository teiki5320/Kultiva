import 'package:flutter/material.dart';

import '../services/photo_service.dart';
import '../theme/app_theme.dart';

/// Dialog expliquant à l'utilisateur que la caméra est refusée
/// et proposant d'ouvrir directement les réglages OS.
///
/// À afficher quand [PhotoService.pickDetailed] retourne
/// [PhotoPickStatus.permissionDenied] : iOS et Android ne montrent
/// plus le prompt système après un refus, la seule issue est Réglages.
Future<void> showCameraPermissionDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Row(
        children: <Widget>[
          Text('📷', style: TextStyle(fontSize: 28)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Appareil photo bloqué',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ),
        ],
      ),
      content: const Text(
        'Kultiva a besoin de l\'appareil photo pour les défis photo '
        'et les photos de plants.\n\n'
        'Tu as refusé l\'autorisation. Tu peux la réactiver dans '
        'les réglages du téléphone.',
        style: TextStyle(fontSize: 14, height: 1.4),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Plus tard'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: KultivaColors.primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () async {
            Navigator.of(ctx).pop();
            await PhotoService.openSettings();
          },
          child: const Text(
            'Ouvrir les Réglages',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}
