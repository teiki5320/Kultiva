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
  final bool reportedByMe;
  final DateTime createdAt;

  /// Code ISO du pays du jardinier (ex. 'SN'), null pour les anciens
  /// posts ou si le pays n'est pas choisi.
  final String? country;

  const FeedPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.challengeId,
    required this.photoUrl,
    this.caption,
    required this.likesCount,
    required this.likedByMe,
    this.reportedByMe = false,
    required this.createdAt,
    this.country,
  });
}
