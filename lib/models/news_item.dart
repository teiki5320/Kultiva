/// Une actualité Kultiva publiée par l'équipe.
///
/// Affichée dans l'app sous forme de story Instagram-like (image plein
/// écran + titre + caption courte). Si [articleUrl] est renseigné, un
/// bouton « Lire l'article complet » ouvre Kultivaprix dans le navigateur.
///
/// Source : table Supabase `news_items` (voir `supabase/migrations/007`).
class NewsItem {
  final String id;
  final String title;
  final String caption;

  /// URL publique de l'image principale (Supabase Storage ou autre CDN).
  final String imageUrl;

  /// URL de l'article complet sur Kultivaprix. Optionnel.
  final String? articleUrl;

  /// URL d'une vidéo (YouTube/Instagram). Optionnel.
  final String? videoUrl;

  /// Tags pour filtrer (ex: 'saison', 'astuce', 'fruits').
  final List<String> tags;

  /// Priorité d'affichage (plus haut = plus en avant). 0 par défaut.
  final int priority;

  final DateTime publishedAt;

  const NewsItem({
    required this.id,
    required this.title,
    required this.caption,
    required this.imageUrl,
    this.articleUrl,
    this.videoUrl,
    this.tags = const <String>[],
    this.priority = 0,
    required this.publishedAt,
  });

  factory NewsItem.fromJson(Map<String, dynamic> j) => NewsItem(
        id: j['id'] as String,
        title: j['title'] as String,
        caption: j['caption'] as String,
        imageUrl: j['image_url'] as String,
        articleUrl: j['article_url'] as String?,
        videoUrl: j['video_url'] as String?,
        tags: (j['tags'] as List<dynamic>? ?? const <dynamic>[])
            .map((e) => e.toString())
            .toList(),
        priority: (j['priority'] as int?) ?? 0,
        publishedAt: DateTime.parse(j['published_at'] as String),
      );
}
