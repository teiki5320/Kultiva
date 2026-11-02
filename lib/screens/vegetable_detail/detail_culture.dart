/// Comment on cultive : les lignes techniques d'une fiche légume, et le mode d'emploi d'un accessoire.
///
/// ⚠️ Ces widgets vivaient dans
/// `vegetable_detail_screen.dart`, qui portait 18 classes sur
/// 1 357 lignes. Même découpage que le potager carré : un fichier par
/// sujet, et l'écran ne garde que lui-même.
library;

import '../../data/content_i18n.dart';
import 'package:flutter/material.dart';
import '../../data/accessory_guide.dart';
import '../../data/ui_i18n.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lexicon_text.dart';

class InfoRow {
  final String label;
  final String? value;
  const InfoRow(this.label, this.value);
}

class InfoSection extends StatelessWidget {
  final String title;
  final List<InfoRow> rows;
  const InfoSection({super.key, required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    final filled = rows.where((r) => r.value != null).toList();
    if (filled.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              for (final r in filled)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 110,
                        child: Text(
                          r.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r.value!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Le mode d'emploi d'un accessoire : quand, comment, combien,
/// l'entretien, et ce qu'on peut fabriquer à la place.
class AccessoryGuideCard extends StatelessWidget {
  final AccessoryGuide guide;
  const AccessoryGuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final diy = guide.displayDiy;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _ligne('🗓️', trUi('Quand s\'en servir'), guide.displayWhen),
            _ligne('🤲', trUi('Comment l\'utiliser'), guide.displayHow),
            _ligne('📐', trUi('Combien il en faut'), guide.displayHowMuch),
            _ligne('🧽', trUi('Entretien'), guide.displayCare),
            // Tout n'a pas d'équivalent maison : on ne forge pas un
            // sécateur. Le champ est nul là où ce serait mentir.
            if (diy != null)
              _ligne('🔨', trUi('À faire soi-même'), diy, dernier: true)
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _ligne(String emoji, String titre, String texte,
      {bool dernier = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: dernier ? 0 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                LexiconText(
                  texte,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
