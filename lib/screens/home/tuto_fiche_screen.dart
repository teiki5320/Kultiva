import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/app_theme.dart';
import '../root_tabs.dart';

/// Affiche une fiche tuto HTML (stockée dans assets/tutos/) dans un
/// WebView plein écran. Intercepte les liens `kultiva://` pour
/// naviguer vers les écrans de l'app.
class TutoFicheScreen extends StatefulWidget {
  final String titre;
  final String assetPath;

  const TutoFicheScreen({
    super.key,
    required this.titre,
    required this.assetPath,
  });

  @override
  State<TutoFicheScreen> createState() => _TutoFicheScreenState();
}

class _TutoFicheScreenState extends State<TutoFicheScreen> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF4F7FA))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri != null && uri.scheme == 'kultiva') {
              _handleDeepLink(uri);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    try {
      var html = await rootBundle.loadString(widget.assetPath);
      html = await _inlineAssetImages(html);
      await _controller.loadHtmlString(html);
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible de charger la fiche : $e')),
        );
      }
    }
  }

  /// Remplace les `<img src="screens/xxx.png">` relatifs par des data-URL
  /// base64 pour qu'ils s'affichent dans le WebView (`loadHtmlString` n'a
  /// pas d'URL de base donc les chemins relatifs ne sont pas résolus).
  /// Les images doivent être dans `assets/tutos/screens/`.
  Future<String> _inlineAssetImages(String html) async {
    final regex = RegExp(
      '''<img([^>]*?)src=["'](screens/[^"']+)["']([^>]*?)>''',
    );
    final matches = regex.allMatches(html).toList();
    var result = html;
    for (final m in matches) {
      final relPath = m.group(2)!; // ex: screens/decouvrir_dashboard.png
      final bundlePath = 'assets/tutos/$relPath';
      try {
        final bytes = await rootBundle.load(bundlePath);
        final b64 = base64Encode(bytes.buffer.asUint8List());
        final ext = relPath.split('.').last.toLowerCase();
        final mime = (ext == 'jpg' || ext == 'jpeg')
            ? 'image/jpeg'
            : (ext == 'webp' ? 'image/webp' : 'image/png');
        final dataUrl = 'data:$mime;base64,$b64';
        final before = m.group(1) ?? '';
        final after = m.group(3) ?? '';
        result = result.replaceFirst(
          m.group(0)!,
          '<img${before}src="$dataUrl"$after>',
        );
      } catch (_) {
        // Image introuvable — on laisse tel quel (affichera un placeholder
        // cassé mais le reste du HTML continue de charger).
      }
    }
    return result;
  }

  /// Intercepte les liens `kultiva://<route>` cliqués dans une fiche HTML
  /// et bascule l'app sur l'écran cible. Routes supportées :
  ///   kultiva://home                → onglet Home (semis)
  ///   kultiva://vegetables          → onglet Étal
  ///   kultiva://poussidex           → onglet Poussidex (section Tamassi)
  ///   kultiva://poussidex/badges    → Poussidex section Badges
  ///   kultiva://poussidex/challenges→ Poussidex section Défis
  ///   kultiva://tutos               → onglet Tutos
  ///   kultiva://tuto/<nom>          → remplace la fiche par une autre
  void _handleDeepLink(Uri uri) {
    final host = uri.host;
    final segments = uri.pathSegments;
    switch (host) {
      case 'home':
        Navigator.of(context).pop();
        RootTabs.tabIndex.value = 0;
        return;
      case 'vegetables':
      case 'etal':
        Navigator.of(context).pop();
        RootTabs.tabIndex.value = 1;
        return;
      case 'poussidex':
        Navigator.of(context).pop();
        RootTabs.tabIndex.value = 2;
        if (segments.isNotEmpty) {
          RootTabs.poussidexFilter.value = segments.first;
        }
        return;
      case 'tutos':
        Navigator.of(context).pop();
        RootTabs.tabIndex.value = 3;
        return;
      case 'tuto':
        if (segments.isNotEmpty) {
          final name = segments.first;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (_) => TutoFicheScreen(
                titre: _humanize(name),
                assetPath: 'assets/tutos/$name.html',
              ),
            ),
          );
        }
        return;
    }
  }

  static String _humanize(String slug) {
    return slug
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titre),
        backgroundColor: KultivaColors.lightBackground,
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
