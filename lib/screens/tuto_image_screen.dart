import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Viewer plein écran pour un tuto au format image PNG unique (portrait).
/// Supporte le pinch-to-zoom grâce à [InteractiveViewer].
class TutoImageScreen extends StatelessWidget {
  final String titre;
  final String assetPath;

  const TutoImageScreen({
    super.key,
    required this.titre,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titre),
        backgroundColor: KultivaColors.lightBackground,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "Impossible d'ouvrir l'image.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
