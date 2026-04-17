import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/badges.dart';
import '../../../data/challenges.dart';
import '../../../models/vegetable_medal.dart';
import '../../../services/cloud_sync_service.dart';
import '../../../services/photo_service.dart';
import '../../../services/prefs_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/badge_card.dart';
import '../../../widgets/challenge_story_card.dart';
import '../../../widgets/plantation_photo.dart';

/// Grille des 30 défis photo du Poussidex. Chaque défi est un tile
/// avec son emoji + nom. Les défis complétés montrent la photo de
/// l'utilisateur ; les défis non complétés un bouton "Participer".
class PoussidexChallengesGrid extends StatefulWidget {
  final void Function(String challengeId, String photoPath)? onPhotoTaken;

  const PoussidexChallengesGrid({super.key, this.onPhotoTaken});

  @override
  State<PoussidexChallengesGrid> createState() =>
      _PoussidexChallengesGridState();
}

class _PoussidexChallengesGridState extends State<PoussidexChallengesGrid> {
  /// Map {challengeId → photoPath (local ou URL cloud)}.
  Map<String, String> _completed = <String, String>{};

  @override
  void initState() {
    super.initState();
    _loadCompleted();
  }

  void _loadCompleted() {
    final raw = PrefsService.instance.getString('kultiva.challenges.v1');
    if (raw == null || raw.isEmpty) return;
    try {
      final map = (jsonDecode(raw) as Map).cast<String, String>();
      setState(() => _completed = map);
    } catch (_) {}
  }

  Future<void> _saveCompleted() async {
    await PrefsService.instance.setString(
      'kultiva.challenges.v1',
      jsonEncode(_completed),
    );
  }

  Future<void> _participate(PhotoChallenge challenge) async {
    final path = await PhotoService.pick(fromCamera: true);
    if (path == null) return;
    setState(() => _completed[challenge.id] = path);
    await _saveCompleted();
    widget.onPhotoTaken?.call(challenge.id, path);
    // Upload la photo vers le cloud en arrière-plan.
    final url = await CloudSyncService.instance.uploadPhoto(
      localPath: path,
      plantationId: 'challenge_${challenge.id}',
    );
    if (url != null) {
      setState(() => _completed[challenge.id] = url);
      await _saveCompleted();
    }
    if (!mounted) return;
    // Montrer la carte du défi complété avec l'animation pack-opening.
    final badge = PoussidexBadge(
      id: challenge.id,
      emoji: challenge.emoji,
      name: challenge.name,
      description: challenge.description,
      tier: challenge.tier,
    );
    await showBadgeUnlockedAnimation(context, badge: badge);
    if (!mounted) return;
    // Proposer le partage Story Instagram.
    final finalPath = _completed[challenge.id] ?? path;
    await showChallengeStoryShare(
      context,
      challenge: challenge,
      photoPath: finalPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        allChallenges.where((c) => _completed.containsKey(c.id)).length;
    return Column(
      children: <Widget>[
        // Compteur de progression.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: <Widget>[
              Text(
                '📸 $completedCount / ${allChallenges.length} défis complétés',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              // Barre de progression.
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: allChallenges.isEmpty
                        ? 0
                        : completedCount / allChallenges.length,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        KultivaColors.primaryGreen),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Grille de défis.
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 0.82,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: allChallenges.length,
            itemBuilder: (context, i) {
              final c = allChallenges[i];
              final photoPath = _completed[c.id];
              return _ChallengeTile(
                challenge: c,
                photoPath: photoPath,
                onParticipate: () => _participate(c),
                onTap: photoPath != null
                    ? () => _showCompletedCard(c)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  void _showCompletedCard(PhotoChallenge challenge) {
    final photoPath = _completed[challenge.id];
    if (photoPath == null) return;
    // On propose directement le partage Story (plus utile que
    // revoir la carte Pokémon pour un défi déjà fait).
    showChallengeStoryShare(
      context,
      challenge: challenge,
      photoPath: photoPath,
    );
  }
}

/// Tile d'un défi dans la grille.
class _ChallengeTile extends StatelessWidget {
  final PhotoChallenge challenge;
  final String? photoPath;
  final VoidCallback onParticipate;
  final VoidCallback? onTap;

  const _ChallengeTile({
    required this.challenge,
    required this.photoPath,
    required this.onParticipate,
    this.onTap,
  });

  Color get _tierColor {
    switch (challenge.tier) {
      case MedalTier.bronze:
        return const Color(0xFFCD7F32);
      case MedalTier.silver:
        return const Color(0xFF9AA4B0);
      case MedalTier.gold:
        return const Color(0xFFE8B923);
      case MedalTier.shiny:
        return const Color(0xFFFF5CA8);
      case MedalTier.none:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = photoPath != null;
    final color = _tierColor;

    return GestureDetector(
      onTap: done ? onTap : onParticipate,
      child: Container(
        decoration: BoxDecoration(
          color: done ? color.withOpacity(0.12) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: done ? color : Colors.grey.shade300,
            width: done ? 2.5 : 1.5,
          ),
          boxShadow: done
              ? <BoxShadow>[
                  BoxShadow(
                    color: color.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Column(
          children: <Widget>[
            // Zone photo / emoji.
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: done
                    ? Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          PlantationPhoto(
                            pathOrUrl: photoPath!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: Text(
                                challenge.emoji,
                                style: const TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                          // Pastille "fait" ✓.
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              challenge.emoji,
                              style: const TextStyle(fontSize: 40),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '📷 Participer',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            // Nom + tier.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: <Widget>[
                  Text(
                    challenge.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: done ? null : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    challenge.tier.emoji,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
