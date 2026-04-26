import 'package:flutter/material.dart';

import '../../../data/challenges.dart';
import '../../../models/vegetable_medal.dart';
import '../../../services/feed_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/plantation_photo.dart';

/// Feed communautaire : scroll vertical des photos de défis postées
/// par tous les utilisateurs Kultiva, du plus récent au plus ancien.
class PoussidexFeed extends StatefulWidget {
  const PoussidexFeed({super.key});

  @override
  State<PoussidexFeed> createState() => _PoussidexFeedState();
}

class _PoussidexFeedState extends State<PoussidexFeed> {
  List<FeedPost> _posts = <FeedPost>[];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final posts = await FeedService.instance.fetchFeed();
      if (mounted) {
        setState(() {
          _posts = posts;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _toggleLike(int index) async {
    final post = _posts[index];
    final nowLiked = await FeedService.instance.toggleLike(post.id);
    if (!mounted) return;
    setState(() {
      _posts[index] = FeedPost(
        id: post.id,
        userId: post.userId,
        userName: post.userName,
        challengeId: post.challengeId,
        photoUrl: post.photoUrl,
        caption: post.caption,
        likesCount: post.likesCount + (nowLiked ? 1 : -1),
        likedByMe: nowLiked,
        createdAt: post.createdAt,
      );
    });
  }

  PhotoChallenge? _findChallenge(String id) {
    for (final c in allChallenges) {
      if (c.id == id) return c;
    }
    return null;
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'à l\'instant';
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'il y a ${diff.inHours}h';
    if (diff.inDays < 7) return 'il y a ${diff.inDays}j';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('⚠️', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'Erreur feed :\n${_error!}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadFeed,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }
    if (_posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('🌍', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'Le feed est vide pour l\'instant.\nComplète des défis et sois le premier à poster !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: KultivaColors.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadFeed,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        itemCount: _posts.length,
        itemBuilder: (context, i) {
          final post = _posts[i];
          final challenge = _findChallenge(post.challengeId);
          return _FeedPostCard(
            post: post,
            challenge: challenge,
            onLike: () => _toggleLike(i),
            timeAgo: _timeAgo(post.createdAt),
          );
        },
      ),
    );
  }
}

class _FeedPostCard extends StatelessWidget {
  final FeedPost post;
  final PhotoChallenge? challenge;
  final VoidCallback onLike;
  final String timeAgo;

  const _FeedPostCard({
    required this.post,
    required this.challenge,
    required this.onLike,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header : nom + défi + temps.
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              children: <Widget>[
                // Avatar placeholder (initiale).
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    post.userName.isNotEmpty
                        ? post.userName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (challenge != null)
                        Text(
                          '${challenge!.emoji} ${challenge!.name}',
                          style: TextStyle(
                            fontSize: 11,
                            color: KultivaColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 11,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Photo du défi.
          ClipRRect(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: PlantationPhoto(
                pathOrUrl: post.photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined,
                      size: 48, color: Colors.grey),
                ),
              ),
            ),
          ),
          // Barre d'actions : like + likes count.
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 14, 10),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: onLike,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        post.likedByMe
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 24,
                        color: post.likedByMe
                            ? Colors.red.shade400
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likesCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: post.likedByMe
                              ? Colors.red.shade400
                              : KultivaColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (challenge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      challenge!.tier.emoji,
                      style: const TextStyle(fontSize: 14),
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
