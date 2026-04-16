import 'package:flutter/material.dart';

import '../models/vegetable.dart';
import '../theme/app_theme.dart';

/// Couleur associée à une famille de légumes — centralisée pour éviter
/// la duplication (auparavant définie dans 3 écrans + 1 widget).
///
/// Usage :
///   `vegetable.category.familyColor`
///   `VegetableCategory.fruits.familyColor`
extension VegetableCategoryColor on VegetableCategory {
  Color get familyColor {
    switch (this) {
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
      case VegetableCategory.accessories:
        return const Color(0xFF78909C);
    }
  }
}
