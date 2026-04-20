import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

/// Viewer PDF plein écran en paysage. Utilisé pour les tutos au format
/// diaporama horizontal (ex. PowerPoint exporté en PDF).
///
/// Verrouille l'orientation en paysage à l'ouverture et restaure le
/// portrait à la sortie — le reste de l'app reste donc en portrait.
class TutoPdfScreen extends StatefulWidget {
  final String titre;
  final String assetPath;

  const TutoPdfScreen({
    super.key,
    required this.titre,
    required this.assetPath,
  });

  @override
  State<TutoPdfScreen> createState() => _TutoPdfScreenState();
}

class _TutoPdfScreenState extends State<TutoPdfScreen> {
  String? _localPath;
  String? _error;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _copyAssetToTemp();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Future<void> _copyAssetToTemp() async {
    try {
      final data = await rootBundle.load(widget.assetPath);
      final dir = await getTemporaryDirectory();
      final name = widget.assetPath.split('/').last;
      final file = File('${dir.path}/$name');
      await file.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        flush: true,
      );
      if (!mounted) return;
      setState(() => _localPath = file.path);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Impossible d\'ouvrir le PDF ($e)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            if (_localPath != null)
              PDFView(
                filePath: _localPath!,
                swipeHorizontal: true,
                pageSnap: true,
                pageFling: true,
                fitPolicy: FitPolicy.BOTH,
              )
            else if (_error != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            Positioned(
              top: 8,
              left: 8,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
