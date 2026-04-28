import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Écran feed des actualités Kultiva (style stories Instagram).
///
/// Stub — rempli en V7 batch 6 avec le modèle `NewsItem`, le service,
/// et l'UI de slides swipables.
class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📰  Actualités'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('🚧', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 18),
              const Text(
                'Bientôt disponible',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Les actualités du jardin arrivent — astuces de saison, '
                'nouvelles variétés, conseils du moment, vidéos inspirantes.',
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
      ),
    );
  }
}
