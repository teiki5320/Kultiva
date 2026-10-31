import 'package:flutter/material.dart';

import '../../../services/plantation_service.dart';
import '../../../services/prefs_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/season_header.dart';
import 'journal_view.dart';

/// Les derniers jours du journal, en bas du cahier.
///
/// Trois journées suffisent à donner le fil ; le reste est derrière
/// « Tout le journal ». L'écran complet existait déjà, mais il fallait
/// ouvrir le Poussidex puis choisir la bonne vue sur quatre.
class CahierJournalSection extends StatefulWidget {
  const CahierJournalSection({super.key});

  @override
  State<CahierJournalSection> createState() => _CahierJournalSectionState();
}

class _CahierJournalSectionState extends State<CahierJournalSection> {
  static const int _joursEnApercu = 3;

  @override
  void initState() {
    super.initState();
    PlantationService.instance.addListener(_onChanged);
  }

  @override
  void dispose() {
    PlantationService.instance.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final plants = PlantationService.instance.all;
    if (plants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Text(
            'Journal',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
        GardenJournalView(
          plantations: plants,
          maxDays: _joursEnApercu,
          shrinkWrap: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const JournalScreen()),
            ),
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.primaryGreen,
            ),
            child: const Text('Tout le journal'),
          ),
        ),
      ],
    );
  }
}

/// Le journal en entier, sur son propre écran.
class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    final region = PrefsService.instance.region.value;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SeasonHeader(
                  season: Season.of(mois, region,
                      zone: PrefsService.instance.effectiveZone),
                  month: mois,
                  height: kPageHeaderHeight,
                  hideLabel: true,
                ),
                const Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '📖  Journal du jardin',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 6, color: Colors.black38),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tout ce que tu as fait, jour par jour',
                          style: TextStyle(
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
                    label: 'Retour',
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
            Expanded(
              child: ListenableBuilder(
                listenable: PlantationService.instance,
                builder: (context, _) => GardenJournalView(
                  plantations: PlantationService.instance.all,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
