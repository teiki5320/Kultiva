import 'dart:io';

import 'package:flutter/material.dart';

/// Affiche une photo de plant.
///
/// Accepte indifféremment un **chemin local** (`/var/mobile/.../plant_123.jpg`)
/// ou une **URL distante** (`https://.../plant_123.jpg`). Ce second cas ne
/// peut plus venir que d'une installation antérieure au 30/10/2026, du
/// temps où les photos étaient aussi montées dans le cloud : on continue
/// de les afficher pour ne pas faire disparaître l'historique de ces
/// utilisateurs.
/// Choisit `Image.file` ou `Image.network` selon la forme du path.
///
/// Un `errorBuilder` optionnel est utilisé si la photo est introuvable
/// (fichier supprimé, pas de réseau, etc.).
class PlantationPhoto extends StatelessWidget {
  final String pathOrUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const PlantationPhoto({
    super.key,
    required this.pathOrUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorBuilder,
  });

  /// True si le path représente une URL cloud (vs un fichier local).
  static bool isRemote(String pathOrUrl) => pathOrUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    if (isRemote(pathOrUrl)) {
      return Image.network(
        pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: errorBuilder,
      );
    }
    return Image.file(
      File(pathOrUrl),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: errorBuilder,
    );
  }
}
