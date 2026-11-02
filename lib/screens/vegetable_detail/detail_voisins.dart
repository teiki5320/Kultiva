/// Ce qui entoure une culture : maladies, rotation, compagnonnage et conseils d'achat au marché.
///
/// ⚠️ Ces widgets vivaient dans
/// `vegetable_detail_screen.dart`, qui portait 18 classes sur
/// 1 357 lignes. Même découpage que le potager carré : un fichier par
/// sujet, et l'écran ne garde que lui-même.
library;

import '../../data/content_i18n.dart';
import '../../data/names_en.dart';
import 'package:flutter/material.dart';
import '../../data/diseases.dart';
import '../../data/market_buying_tips.dart';
import '../../data/rotation.dart';
import '../../data/ui_i18n.dart';
import '../../data/vegetables_base.dart';
import '../../models/vegetable.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lexicon_text.dart';

class DiseaseSection extends StatelessWidget {
  final List<Disease> diseases;
  const DiseaseSection({super.key, required this.diseases});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trUi('🐛  Maladies & ravageurs'),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              for (final d in diseases)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LexiconText(
                        d.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: KultivaColors.terracotta,
                        ),
                      ),
                      const SizedBox(height: 2),
                      LexiconText(
                        d.displayRemedy,
                        style: const TextStyle(fontSize: 13, height: 1.3),
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

class RotationSection extends StatelessWidget {
  final RotationData data;
  const RotationSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final successors = data.goodAfter
        .map((id) {
          try {
            return vegetablesBase.firstWhere((v) => v.id == id);
          } catch (_) {
            return null;
          }
        })
        .whereType<Vegetable>()
        .toList();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trUi('🔄  Rotation des cultures'),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    trUi('Famille : '),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(tr(data.family),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    trUi('Attendre : '),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(
                    trUiArgs('{0} ans avant de replanter au même endroit',
                        <Object?>[data.waitYears]),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (successors.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  trUi('Bons successeurs :'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: successors.map((v) {
                    return Chip(
                      avatar:
                          Text(v.emoji, style: const TextStyle(fontSize: 16)),
                      // ⚠️ `displayName`, pas `name` : les pastilles
                      // de rotation affichaient « Haricot vert » sous
                      // une fiche espagnole.
                      label: Text(v.displayName,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CompanionSection extends StatelessWidget {
  final String title;
  final List<String> ids;
  final Color color;
  const CompanionSection({
    super.key,
    required this.title,
    required this.ids,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final vegs = ids
        .map((id) {
          try {
            return vegetablesBase.firstWhere((v) => v.id == id);
          } catch (_) {
            return null;
          }
        })
        .whereType<Vegetable>()
        .toList();
    if (vegs.isEmpty) return const SizedBox.shrink();
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
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vegs.map((v) {
                  return Chip(
                    avatar: Text(v.emoji, style: const TextStyle(fontSize: 16)),
                    label: Text(
                      // ⚠️ Idem pour les pastilles de compagnonnage.
                      v.displayName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Conseils d'achat au marché (semences, semenceaux, boutures, rejets),
/// affichés en Afrique de l'Ouest à la place du lien Amazon indisponible.
class BuyingTipsSection extends StatelessWidget {
  final List<BuyingTip> tips;
  const BuyingTipsSection({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        color: KultivaColors.terracotta.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                trUi('🛍️  Bien acheter au marché'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              for (final t in tips)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                              KultivaColors.terracotta.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          t.what,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: KultivaColors.terracotta,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr(t.advice),
                        style: const TextStyle(
                          fontSize: 13,
                          color: KultivaColors.textPrimary,
                          height: 1.35,
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
