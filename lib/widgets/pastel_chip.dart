import 'package:flutter/material.dart';

/// Pastille de filtre, colorée par famille de légume.
///
/// Vivait en privé dans `vegetables_screen.dart`. Le calendrier annuel
/// a repris le même filtrage que l'Étal le 31/10/2026 : plutôt que de
/// recopier la pastille, elle est partagée — deux copies, ce sont deux
/// apparences qui divergent à la première retouche.
class PastelChip extends StatelessWidget {
  final String label;
  final String emoji;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const PastelChip({
    super.key,
    required this.label,
    required this.emoji,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Semantics(
        label: '$label${selected ? ', sélectionné' : ''}',
        button: true,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // Sélectionné : fond coloré. Non sélectionné : fond blanc +
              // bordure couleur famille pour se repérer visuellement.
              color: selected ? color.withValues(alpha: 0.2) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color,
                width: selected ? 2.5 : 2,
              ),
            ),
            child: Text(
              '$emoji $label',
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
