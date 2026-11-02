/// Les conservations et recettes d'un légume sur sa fiche : le top 3, puis le reste, replié.
///
/// ⚠️ Ces widgets vivaient dans
/// `vegetable_detail_screen.dart`, qui portait 18 classes sur
/// 1 357 lignes. Même découpage que le potager carré : un fichier par
/// sujet, et l'écran ne garde que lui-même.
library;

import 'package:flutter/material.dart';
import '../../data/recipes.dart';
import '../../widgets/recipe_row.dart';
import '../../data/ui_i18n.dart';
import '../../theme/app_theme.dart';

/// Estimation maraîchage (rendement + valeur marché en FCFA), affichée
/// en Afrique de l'Ouest pour les jardiniers qui cultivent pour vendre.
class RecipesSection extends StatelessWidget {
  final String vegetableId;
  const RecipesSection({super.key, required this.vegetableId});

  @override
  Widget build(BuildContext context) {
    final top = top3For(vegetableId);
    final autres = otherRecipesFor(vegetableId);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 2, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trUi('🫙  Garder ta récolte'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    if (top.any((r) => r.isPreservation))
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          trUi('Trois façons de la faire durer. Un jardinier '
                              'n\'a pas un légume, il en a quinze d\'un coup.'),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              for (final r in top)
                RecipeRow(vegetableId: vegetableId, recipe: r),
              if (autres.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 14, top: 4),
                  child:
                      AutresRecettes(vegetableId: vegetableId, recipes: autres),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Les recettes hors du top 3, repliées derrière une ligne.
///
/// Repliées et pas absentes : le top 3 reste le propos, mais une
/// recette que rien n'atteint est un bug.

/// Les recettes hors du top 3, repliées derrière une ligne.
///
/// Repliées et pas absentes : le top 3 reste le propos, mais une
/// recette que rien n'atteint est un bug.
class AutresRecettes extends StatefulWidget {
  final String vegetableId;
  final List<Recipe> recipes;

  const AutresRecettes(
      {super.key, required this.vegetableId, required this.recipes});

  @override
  State<AutresRecettes> createState() => _AutresRecettesState();
}

class _AutresRecettesState extends State<AutresRecettes> {
  bool _ouvert = false;

  @override
  Widget build(BuildContext context) {
    final n = widget.recipes.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _ouvert = !_ouvert),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  _ouvert ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: KultivaColors.primaryGreen,
                ),
                const SizedBox(width: 6),
                Text(
                  // Le top 3 garde la récolte ; le reste se mange le jour
                  // même. Dire lequel est lequel évite de chercher une
                  // conserve dans la liste des plats.
                  n > 1
                      ? trUiArgs(
                          '{0} recettes à manger tout de suite', <Object?>[n])
                      : trUiArgs(
                          '{0} recette à manger tout de suite', <Object?>[n]),
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: KultivaColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_ouvert)
          for (final r in widget.recipes)
            RecipeRow(
              vegetableId: ownerOf(r) ?? widget.vegetableId,
              recipe: r,
            ),
      ],
    );
  }
}

/// Conseils d'achat au marché (semences, semenceaux, boutures, rejets),
/// affichés en Afrique de l'Ouest à la place du lien Amazon indisponible.
