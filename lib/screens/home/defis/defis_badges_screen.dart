import 'package:flutter/material.dart';

import '../../../data/badges.dart';
import '../../../data/challenges.dart';
import '../../../data/ui_i18n.dart';
import '../../../services/garden_stats.dart';
import '../../../services/prefs_service.dart';
import '../../../services/review_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/season_header.dart';
import 'badges_grid.dart';
import 'challenges_grid.dart';
import '../../../widgets/readable_width.dart';

/// Défis photo et badges.
///
/// Ce qui reste du Poussidex, supprimé le 31/10/2026. L'album de
/// collection faisait doublon avec le cahier de culture : « Mes
/// plants » et « Au jardin en ce moment » listaient les mêmes plants,
/// et le journal daté y était enterré sous un sélecteur de quatre
/// vues. Le journal est remonté dans le cahier, et il ne restait de
/// propre au Poussidex que les 50 défis et les 50 badges.
class DefisBadgesScreen extends StatefulWidget {
  /// Section ouverte à l'arrivée : `challenges` ou `badges`.
  final String? section;

  const DefisBadgesScreen({super.key, this.section});

  @override
  State<DefisBadgesScreen> createState() => _DefisBadgesScreenState();
}

class _DefisBadgesScreenState extends State<DefisBadgesScreen> {
  bool _badges = false;
  Set<String> _unlocked = <String>{};

  @override
  void initState() {
    super.initState();
    _badges = widget.section == 'badges';
    _refreshBadges();
  }

  /// Les badges déjà obtenus, union du stocké et du recalculé.
  ///
  /// On n'écrase jamais le set enregistré : un badge gagné autrefois
  /// sur un critère qui n'existe plus reste acquis.
  Future<void> _refreshBadges() async {
    final gagnes = computeUnlockedBadges();
    final tout = <String>{...PrefsService.instance.unlockedBadges, ...gagnes};
    await PrefsService.instance.setUnlockedBadges(tout);
    if (mounted) setState(() => _unlocked = tout);
  }

  void _onChallengePhotoTaken(String challengeId, String photoPath) {
    _refreshBadges();
    // Moment positif : on peut solliciter (au plus une fois) une note.
    ReviewService.instance
        .maybeRequestReview(unlockedBadgeCount: _unlocked.length);
  }

  /// « 3 défis sur 50  ·  2 badges sur 50 » — les quatre accords
  /// possibles sont des clés distinctes : chaque langue accorde à sa
  /// façon.
  static String _sousTitre(int faits, int badges) {
    final args = <Object?>[
      faits,
      allChallenges.length,
      badges,
      allBadges.length,
    ];
    if (faits > 1) {
      return badges > 1
          ? trUiArgs('{0} défis sur {1}  ·  {2} badges sur {3}', args)
          : trUiArgs('{0} défis sur {1}  ·  {2} badge sur {3}', args);
    }
    return badges > 1
        ? trUiArgs('{0} défi sur {1}  ·  {2} badges sur {3}', args)
        : trUiArgs('{0} défi sur {1}  ·  {2} badge sur {3}', args);
  }

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    final faits = GardenStats.loadCompletedChallenges().length;
    return Scaffold(
      body: ReadableWidth(child: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SeasonHeader(
                  season: Season.current(mois),
                  month: mois,
                  height: kPageHeaderHeight,
                  hideLabel: true,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          trUi('📸  Défis & badges'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 6, color: Colors.black38),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _sousTitre(faits, _unlocked.length),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 5, color: Colors.black38),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Semantics(
                    label: trUi('Retour'),
                    button: true,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _Switcher(
              badges: _badges,
              onChanged: (v) => setState(() => _badges = v),
            ),
            Expanded(
              child: _badges
                  ? BadgesGrid(unlocked: _unlocked)
                  : ChallengesGrid(onPhotoTaken: _onChallengePhotoTaken),
            ),
          ],
        ),
      )),
    );
  }
}

/// Bascule entre les deux sections. Deux onglets, pas un sélecteur à
/// quatre vues : c'est ce qui enterrait le journal dans l'ancien
/// Poussidex.
class _Switcher extends StatelessWidget {
  final bool badges;
  final ValueChanged<bool> onChanged;

  const _Switcher({required this.badges, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SegmentedButton<bool>(
        segments: <ButtonSegment<bool>>[
          ButtonSegment<bool>(value: false, label: Text(trUi('📸  Défis'))),
          ButtonSegment<bool>(value: true, label: Text(trUi('🏆  Badges'))),
        ],
        selected: <bool>{badges},
        showSelectedIcon: false,
        onSelectionChanged: (s) => onChanged(s.first),
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor:
              KultivaColors.primaryGreen.withValues(alpha: 0.18),
          selectedForegroundColor: KultivaColors.primaryGreen,
        ),
      ),
    );
  }
}
