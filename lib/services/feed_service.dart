import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_service.dart';

/// Un post dans le feed communautaire.
class FeedPost {
  final String id;
  final String userId;
  final String userName;
  final String challengeId;
  final String photoUrl;
  final String? caption;
  final int likesCount;
  final bool likedByMe;
  final DateTime createdAt;

  const FeedPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.challengeId,
    required this.photoUrl,
    this.caption,
    required this.likesCount,
    required this.likedByMe,
    required this.createdAt,
  });
}

/// Service pour le feed communautaire des défis photo.
class FeedService {
  FeedService._();
  static final FeedService instance = FeedService._();

  SupabaseClient get _client => Supabase.instance.client;
  String? get _userId => _client.auth.currentUser?.id;

  /// Publie un post de défi dans le feed.
  /// Throw une exception si ça échoue (pour que l'UI puisse l'afficher).
  Future<void> publishChallengePost({
    required String challengeId,
    required String photoUrl,
    String? caption,
  }) async {
    final uid = _userId;
    if (uid == null) {
      throw Exception('Pas de session Supabase active');
    }
    await _client.from('challenge_posts').insert(<String, dynamic>{
      'user_id': uid,
      'challenge_id': challengeId,
      'photo_url': photoUrl,
      'caption': caption,
    });
  }

  /// Récupère les posts du feed (les plus récents en premier).
  /// [limit] = nombre de posts à charger, [offset] pour la pagination.
  Future<List<FeedPost>> fetchFeed({int limit = 20, int offset = 0}) async {
    final uid = _userId;
    try {
      // Requête avec jointure sur profiles pour le display_name.
      // On utilise une jointure LEFT (pas inner) pour que les posts
      // s'affichent même si le profil n'existe pas encore.
      final data = await _client
          .from('challenge_posts')
          .select('*, profiles(display_name)')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      // Récupérer les likes de l'utilisateur courant en une requête.
      final Set<String> myLikes;
      if (uid != null) {
        final likesData = await _client
            .from('post_likes')
            .select('post_id')
            .eq('user_id', uid);
        myLikes = likesData
            .map<String>((row) => row['post_id'] as String)
            .toSet();
      } else {
        myLikes = <String>{};
      }

      return data.map<FeedPost>((row) {
        final profiles = row['profiles'] as Map<String, dynamic>?;
        final name = profiles?['display_name'] as String? ??
            'Jardinier anonyme';
        final postId = row['id'] as String;
        return FeedPost(
          id: postId,
          userId: row['user_id'] as String,
          userName: name,
          challengeId: row['challenge_id'] as String,
          photoUrl: row['photo_url'] as String,
          caption: row['caption'] as String?,
          likesCount: (row['likes_count'] as int?) ?? 0,
          likedByMe: myLikes.contains(postId),
          createdAt: DateTime.parse(row['created_at'] as String),
        );
      }).toList();
    } catch (e) {
      debugPrint('FeedService.fetchFeed error: $e');
      return <FeedPost>[];
    }
  }

  /// Like ou unlike un post.
  Future<bool> toggleLike(String postId) async {
    final uid = _userId;
    if (uid == null) return false;
    try {
      // Vérifier si déjà liké.
      final existing = await _client
          .from('post_likes')
          .select()
          .eq('user_id', uid)
          .eq('post_id', postId)
          .maybeSingle();
      if (existing != null) {
        // Unlike.
        await _client
            .from('post_likes')
            .delete()
            .eq('user_id', uid)
            .eq('post_id', postId);
        return false;
      } else {
        // Like.
        await _client.from('post_likes').insert(<String, dynamic>{
          'user_id': uid,
          'post_id': postId,
        });
        return true;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('FeedService.toggleLike error: $e');
      return false;
    }
  }
}
