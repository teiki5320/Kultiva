import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Mini-barres représentant les jours d'arrosage des [days] derniers
/// jours. Une barre haute = arrosé ce jour-là, une barre basse = pas
/// arrosé. Le jour le plus ancien est à gauche, aujourd'hui à droite.
class WateringBars extends StatelessWidget {
  final List<bool> history;
  final double height;
  final Color? color;

  const WateringBars({
    super.key,
    required this.history,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? KultivaColors.primaryGreen;
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (var i = 0; i < history.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: 2),
            Expanded(
              child: Container(
                height: history[i] ? height : height * 0.25,
                decoration: BoxDecoration(
                  color: history[i] ? c : c.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
