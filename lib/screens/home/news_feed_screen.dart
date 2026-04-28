import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/news_item.dart';
import '../../services/news_service.dart';
import '../../theme/app_theme.dart';

/// Écran feed des actualités Kultiva.
///
/// Style stories Instagram : chaque actu = une slide plein écran.
/// L'utilisateur swipe verticalement entre les actus. Si l'actu a un
/// `articleUrl`, un bouton « Article complet » ouvre Kultivaprix dans
/// le navigateur.
class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  void initState() {
    super.initState();
    NewsService.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder<List<NewsItem>>(
        valueListenable: NewsService.instance.items,
        builder: (ctx, items, _) {
          if (items.isEmpty) {
            return const _EmptyOrLoading();
          }
          return RefreshIndicator(
            onRefresh: NewsService.instance.refresh,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (_, i) => _NewsSlide(
                item: items[i],
                index: i,
                total: items.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyOrLoading extends StatelessWidget {
  const _EmptyOrLoading();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8,
            left: 4,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('🌱', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 18),
                  const Text(
                    'Pas encore d\'actualité',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reviens dans quelques jours pour découvrir les nouvelles '
                    'actus du jardin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsSlide extends StatelessWidget {
  final NewsItem item;
  final int index;
  final int total;
  const _NewsSlide({
    required this.item,
    required this.index,
    required this.total,
  });

  Future<void> _openArticle() async {
    final url = item.articleUrl;
    if (url == null) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Image plein écran.
        Image.network(
          item.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: KultivaColors.primaryGreen,
            alignment: Alignment.center,
            child: const Text('🌱', style: TextStyle(fontSize: 80)),
          ),
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            );
          },
        ),
        // Dégradé sombre du bas pour lisibilité du texte.
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.55),
                  Colors.black.withValues(alpha: 0.85),
                ],
                stops: const <double>[0, 0.45, 0.7, 1],
              ),
            ),
          ),
        ),
        // Barre du haut : indicateur de progression + close.
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: <Widget>[
                for (int i = 0; i < total; i++) ...<Widget>[
                  Expanded(
                    child: Container(
                      height: 3,
                      margin: EdgeInsets.symmetric(
                        horizontal: i == 0 || i == total - 1 ? 0 : 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: i <= index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
        ),
        // Contenu en bas.
        Positioned(
          left: 18,
          right: 18,
          bottom: 28,
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (item.tags.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: item.tags
                        .take(3)
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '#$t',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.caption,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                if (item.articleUrl != null)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: KultivaColors.textPrimary,
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _openArticle,
                      icon: const Icon(Icons.article_outlined, size: 18),
                      label: const Text(
                        'Lire l\'article complet',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
