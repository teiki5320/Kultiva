import 'package:flutter/material.dart';

import '../models/vegetable.dart';
import '../theme/app_theme.dart';

/// Card d'un légume — emoji dans cercle pastel, nom, note, badges saison,
/// indicateur catégorie coloré, bouton favori.
class VegetableCard extends StatelessWidget {
  final Vegetable vegetable;
  final bool canSowNow;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const VegetableCard({
    super.key,
    required this.vegetable,
    this.canSowNow = false,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  Color _catColor() {
    switch (vegetable.category) {
      case VegetableCategory.fruits:
        return KultivaColors.terracotta;
      case VegetableCategory.leaves:
        return KultivaColors.primaryGreen;
      case VegetableCategory.roots:
        return const Color(0xFF8B6914);
      case VegetableCategory.bulbs:
        return const Color(0xFFB39DDB);
      case VegetableCategory.tubers:
        return const Color(0xFF795548);
      case VegetableCategory.flowers:
        return KultivaColors.springA;
      case VegetableCategory.seeds:
        return KultivaColors.summerA;
      case VegetableCategory.stems:
        return const Color(0xFF66BB6A);
      case VegetableCategory.aromatics:
        return const Color(0xFF26A69A);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cc = _catColor();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Emoji dans cercle pastel avec bande catégorie.
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cc.withOpacity(0.12),
                      cc.withOpacity(0.25),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cc.withOpacity(0.2)),
                ),
                alignment: Alignment.center,
                child: Text(vegetable.emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 12),
              // Contenu.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vegetable.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (canSowNow)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: KultivaColors.primaryGreen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Semer',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vegetable.note ??
                          vegetable.description ??
                          vegetable.category.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: KultivaColors.textPrimary.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Catégorie chip.
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: cc.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        vegetable.category.label,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: cc,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (onFavoriteToggle != null)
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isFavorite
                          ? KultivaColors.terracotta
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
