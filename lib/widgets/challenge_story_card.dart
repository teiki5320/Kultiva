import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/challenges.dart';
import '../models/vegetable_medal.dart';
import '../theme/app_theme.dart';
import 'plantation_photo.dart';

/// Affiche un dialogue de prévisualisation d'une Story Card 9:16
/// (format Instagram Stories) pour un défi complété, puis propose
/// de partager l'image.
Future<void> showChallengeStoryShare(
  BuildContext context, {
  required PhotoChallenge challenge,
  required String photoPath,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _StoryShareDialog(
      challenge: challenge,
      photoPath: photoPath,
    ),
  );
}

class _StoryShareDialog extends StatefulWidget {
  final PhotoChallenge challenge;
  final String photoPath;

  const _StoryShareDialog({
    required this.challenge,
    required this.photoPath,
  });

  @override
  State<_StoryShareDialog> createState() => _StoryShareDialogState();
}

class _StoryShareDialogState extends State<_StoryShareDialog> {
  final GlobalKey _cardKey = GlobalKey();
  bool _sharing = false;

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 60));
      final boundary = _cardKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('PNG export failed');
      final Uint8List bytes = byteData.buffer.asUint8List();
      final tmp = await getTemporaryDirectory();
      final file = File(
          '${tmp.path}/kultiva_story_${widget.challenge.id}_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        <XFile>[XFile(file.path)],
        text: 'J\'ai complété le défi "${widget.challenge.name}" '
            'sur Kultiva ! ${widget.challenge.emoji} 🌱',
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Impossible de partager : $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Preview de la Story Card (réduite pour l'écran).
          SizedBox(
            width: 270,
            height: 480,
            child: RepaintBoundary(
              key: _cardKey,
              child: _StoryCardVisual(
                challenge: widget.challenge,
                photoPath: widget.photoPath,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: KultivaColors.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Annuler'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _sharing ? null : _share,
                  icon: _sharing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.share, size: 18),
                  label: Text(_sharing ? 'Export…' : 'Partager'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KultivaColors.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Visuel de la Story Card : format 9:16 (1080×1920 à pixelRatio 3).
/// Design : photo plein écran + cadre tier + info en overlay.
class _StoryCardVisual extends StatelessWidget {
  final PhotoChallenge challenge;
  final String photoPath;

  const _StoryCardVisual({
    required this.challenge,
    required this.photoPath,
  });

  Color get _tierColor {
    switch (challenge.tier) {
      case MedalTier.bronze:
        return const Color(0xFFCD7F32);
      case MedalTier.silver:
        return const Color(0xFF9AA4B0);
      case MedalTier.gold:
        return const Color(0xFFE8B923);
      case MedalTier.shiny:
        return const Color(0xFFFF5CA8);
      case MedalTier.none:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _tierColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 5),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Photo plein cadre.
          PlantationPhoto(
            pathOrUrl: photoPath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: color.withOpacity(0.3),
              alignment: Alignment.center,
              child: Text(challenge.emoji,
                  style: const TextStyle(fontSize: 80)),
            ),
          ),
          // Dégradé noir en haut + en bas pour la lisibilité du texte.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                stops: const <double>[0.0, 0.2, 0.7, 1.0],
              ),
            ),
          ),
          // Header : emoji + nom du défi + tier.
          Positioned(
            top: 24,
            left: 20,
            right: 20,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(challenge.emoji,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'DÉFI ${challenge.tier.label.toUpperCase()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  challenge.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer : "Défi complété" + Kultiva.
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('✅', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      const Text(
                        'Défi complété',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        challenge.tier.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '🪴 KULTIVA',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 3,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
