import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/plantation.dart';
import '../models/vegetable.dart';
import '../theme/app_theme.dart';
import '../utils/months.dart';
import 'plantation_photo.dart';

/// Dialog qui affiche une prévisualisation "partage" d'une carte Poussidex
/// et propose de l'exporter comme image (via RepaintBoundary) puis de
/// la partager via la feuille de partage native.
class SharePreviewDialog extends StatefulWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final Color familyColor;

  const SharePreviewDialog({
    super.key,
    required this.plantation,
    required this.vegetable,
    required this.familyColor,
  });

  @override
  State<SharePreviewDialog> createState() => _SharePreviewDialogState();
}

class _SharePreviewDialogState extends State<SharePreviewDialog> {
  final GlobalKey _cardKey = GlobalKey();
  bool _sharing = false;

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      // Attendre une frame pour garantir que le RepaintBoundary est rendu.
      await Future<void>.delayed(const Duration(milliseconds: 60));
      final boundary = _cardKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception('Conversion PNG échouée');
      }
      final Uint8List bytes = byteData.buffer.asUint8List();
      final tmp = await getTemporaryDirectory();
      final file = File(
          '${tmp.path}/poussidex_${widget.plantation.id}_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles(
        <XFile>[XFile(file.path)],
        text:
            "Regarde mon ${widget.vegetable.name.toLowerCase()} dans mon Poussidex Kultiva ! 🌱",
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
          RepaintBoundary(
            key: _cardKey,
            child: _ShareCardContent(
              plantation: widget.plantation,
              vegetable: widget.vegetable,
              familyColor: widget.familyColor,
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

/// Contenu visuel d'une carte Poussidex format partage (carré ~340 px).
class _ShareCardContent extends StatelessWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final Color familyColor;

  const _ShareCardContent({
    required this.plantation,
    required this.vegetable,
    required this.familyColor,
  });

  String _fmt(DateTime d) => '${d.day} ${monthNamesLong[d.month - 1]}';

  @override
  Widget build(BuildContext context) {
    final days = plantation.daysSincePlanted;
    final hasPhoto = plantation.photoPaths.isNotEmpty;
    return Container(
      width: 340,
      height: 420,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            familyColor.withValues(alpha: 0.18),
            familyColor.withValues(alpha: 0.45),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: familyColor, width: 4),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('🪴',
                  style: TextStyle(fontSize: 24)),
              Text(
                'POUSSIDEX',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 2,
                  color: familyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: familyColor, width: 3),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: familyColor.withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: hasPhoto
                    ? PlantationPhoto(
                        pathOrUrl: plantation.photoPaths.last,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(vegetable.emoji,
                              style: const TextStyle(fontSize: 90)),
                        ),
                      )
                    : Center(
                        child: Text(vegetable.emoji,
                            style: const TextStyle(fontSize: 90)),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            vegetable.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontSize: 28),
          ),
          Text(
            vegetable.category.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: familyColor,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _StatBlock(
                  label: 'Jour', value: '${days + 1}'),
              _StatBlock(
                  label: '💧', value: '${plantation.wateredAt.length}'),
              _StatBlock(
                  label: '🧺', value: '${plantation.harvestCount}'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Planté le ${_fmt(plantation.plantedAt)}  •  Kultiva',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: KultivaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  const _StatBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontSize: 22)),
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: KultivaColors.textSecondary,
            )),
      ],
    );
  }
}
