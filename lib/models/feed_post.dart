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
