import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/feed_post.dart';

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

      // Récupérer les likes et signalements de l'utilisateur courant.
      final Set<String> myLikes;
      final Set<String> myReports;
      if (uid != null) {
        final results = await Future.wait(<Future<List<Map<String, dynamic>>>>[
          _client.from('post_likes').select('post_id').eq('user_id', uid),
          _client.from('post_reports').select('post_id').eq('user_id', uid),
        ]);
        myLikes =
            results[0].map<String>((row) => row['post_id'] as String).toSet();
        myReports =
            results[1].map<String>((row) => row['post_id'] as String).toSet();
      } else {
        myLikes = <String>{};
        myReports = <String>{};
      }

      return data.map<FeedPost>((row) {
        final profiles = row['profiles'] as Map<String, dynamic>?;
        final name =
            profiles?['display_name'] as String? ?? 'Jardinier anonyme';
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
          reportedByMe: myReports.contains(postId),
          createdAt: DateTime.parse(row['created_at'] as String),
        );
      }).toList();
    } catch (e) {
      // On RELANCE l'erreur : le caller (poussidex_feed) a un écran
      // d'erreur + bouton « Réessayer ». L'avaler affichait un feed
      // « vide » mensonger hors-ligne, avec le retry inatteignable.
      if (kDebugMode) debugPrint('FeedService.fetchFeed error: $e');
      rethrow;
    }
  }

  /// Signale un post. Retourne true si le signalement a été enregistré.
  Future<bool> reportPost(String postId, String reason) async {
    final uid = _userId;
    if (uid == null) return false;
    try {
      await _client.from('post_reports').insert(<String, dynamic>{
        'user_id': uid,
        'post_id': postId,
        'reason': reason,
      });
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint('FeedService.reportPost error: $e');
      return false;
    }
  }

  /// Like ou unlike un post. Retourne `true` si le post est désormais
  /// liké, `false` s'il est déliké.
  ///
  /// **Throw** en cas d'erreur réseau/DB : le caller ne doit appliquer le
  /// delta de compteur qu'en cas de succès. L'ancienne version renvoyait
  /// `false` aussi bien pour un unlike que pour une erreur → l'UI affichait
  /// « -1 like » (voire des valeurs négatives) sur simple coupure réseau.
  Future<bool> toggleLike(String postId) async {
    final uid = _userId;
    if (uid == null) {
      throw Exception('Pas de session Supabase active');
    }
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
    }
    // Like.
    try {
      await _client.from('post_likes').insert(<String, dynamic>{
        'user_id': uid,
        'post_id': postId,
      });
      return true;
    } on PostgrestException catch (e) {
      // 23505 = violation de contrainte unique : un double-tap concurrent
      // a déjà inséré le like. Le post est bien liké, pas d'erreur.
      if (e.code == '23505') return true;
      rethrow;
    }
  }
}
