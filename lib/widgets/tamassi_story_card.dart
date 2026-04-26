import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/app_theme.dart';
import 'plant_creature.dart';

/// Affiche une Story Card 9:16 du Tamassi avec ton nom + niveau, puis
/// propose le partage (Instagram Stories, etc.) via le share sheet iOS.
Future<void> showTamassiStoryShare(
  BuildContext context, {
  required CreatureStarter starter,
  required String creatureName,
  required int level,
  required String stageName,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _TamassiStoryDialog(
      starter: starter,
      creatureName: creatureName,
      level: level,
      stageName: stageName,
    ),
  );
}

class _TamassiStoryDialog extends StatefulWidget {
  final CreatureStarter starter;
  final String creatureName;
  final int level;
  final String stageName;

  const _TamassiStoryDialog({
    required this.starter,
    required this.creatureName,
    required this.level,
    required this.stageName,
  });

  @override
  State<_TamassiStoryDialog> createState() => _TamassiStoryDialogState();
}

class _TamassiStoryDialogState extends State<_TamassiStoryDialog> {
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
          '${tmp.path}/kultiva_tamassi_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        <XFile>[XFile(file.path)],
        text: 'Voici ${widget.creatureName}, mon Tamassi niveau '
            '${widget.level} sur Kultiva ! 🌱',
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
          SizedBox(
            width: 270,
            height: 480,
            child: RepaintBoundary(
              key: _cardKey,
              child: _TamassiStoryVisual(
                starter: widget.starter,
                creatureName: widget.creatureName,
                level: widget.level,
                stageName: widget.stageName,
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

/// Story Card 9:16 : fond pastel, créature au centre, nom + niveau
/// + stage + watermark KULTIVA.
class _TamassiStoryVisual extends StatelessWidget {
  final CreatureStarter starter;
  final String creatureName;
  final int level;
  final String stageName;

  const _TamassiStoryVisual({
    required this.starter,
    required this.creatureName,
    required this.level,
    required this.stageName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFFFE9F1),
            Color(0xFFE9F6FF),
            Color(0xFFDCF2D4),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Décor : petites fleurs en coin.
          const Positioned(top: 20, right: 28,
            child: Text('🌸', style: TextStyle(fontSize: 30))),
          const Positioned(top: 60, left: 30,
            child: Text('🌼', style: TextStyle(fontSize: 22))),
          const Positioned(bottom: 80, left: 24,
            child: Text('🌿', style: TextStyle(fontSize: 26))),
          const Positioned(bottom: 100, right: 30,
            child: Text('✨', style: TextStyle(fontSize: 22))),
          // Créature centrée.
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                // Le PlantCreature utilise un GestureDetector inutile dans
                // la capture — on l'utilise quand même pour garder le même
                // rendu visuel (animations incluses au moment du capture).
                PlantCreature(
                  level: level,
                  starter: starter,
                  size: 200,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Text(
                    creatureName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Niveau $level · $stageName',
                  style: TextStyle(
                    color: KultivaColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Footer "KULTIVA".
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '🪴 KULTIVA',
                style: TextStyle(
                  color: KultivaColors.textPrimary.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
