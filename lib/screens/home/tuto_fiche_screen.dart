import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/app_theme.dart';

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
              _handleDeepLink(uri.host);
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
      final html = await rootBundle.loadString(widget.assetPath);
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

  void _handleDeepLink(String target) {
    Navigator.of(context).pop();
    // TODO: naviguer vers l'écran correspondant via RootTabs.
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
