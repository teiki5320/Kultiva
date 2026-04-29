import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Overlay bottom-sheet de présentation du Poussidex.
///
/// Refonte avril 2026 : axe « jardiner avec ses enfants ». Le Poussidex
/// est positionné comme l'outil familial de Kultiva — l'enfant a un
/// compagnon qui évolue avec ses gestes au jardin, ce qui transforme
/// l'arrosage et l'observation des plants en jeu.
///
/// Affiché une seule fois (flag gardenTutorialDone) à la première
/// ouverture de l'onglet Poussidex.
class GardenTutorialSheet extends StatefulWidget {
  const GardenTutorialSheet({super.key});

  @override
  State<GardenTutorialSheet> createState() => _GardenTutorialSheetState();
}

class _GardenTutorialSheetState extends State<GardenTutorialSheet> {
  final PageController _controller = PageController();
  int _page = 0;

  static const List<_TutoSlide> _slides = <_TutoSlide>[
    _TutoSlide(
      emoji: '👨‍👩‍👧',
      title: 'Le potager, en famille',
      subtitle:
          "Le Poussidex est pensé pour faire jardiner les enfants. "
          "Ton enfant choisit un compagnon kawaii — Spira, Soleia ou "
          "Poussia — qui grandit chaque fois qu'il s'occupe du jardin.",
      gradient: [Color(0xFFE0FFE8), Color(0xFFC0E8D0)],
    ),
    _TutoSlide(
      emoji: '🌱',
      title: 'Un compagnon qui évolue',
      subtitle:
          "À chaque arrosage, chaque photo, chaque défi relevé, le "
          "Tamassi gagne de l'XP et change d'apparence. 11 stades à "
          "débloquer ensemble — de la petite graine à l'arbre légendaire.",
      gradient: [Color(0xFFE0F0FF), Color(0xFFC0D8F0)],
    ),
    _TutoSlide(
      emoji: '📸',
      title: 'Des défis photo qui les motivent',
      subtitle:
          "« Le légume le plus grand », « La fleur la plus jolie »... "
          "Une trentaine de défis qui transforment les enfants en "
          "petits explorateurs du jardin. Une photo = une badge.",
      gradient: [Color(0xFFFFE0EC), Color(0xFFFFBDD2)],
    ),
    _TutoSlide(
      emoji: '🏆',
      title: 'Une collection à compléter',
      subtitle:
          "Les badges débloqués s'ajoutent à un album façon collection "
          "Pokémon : bronze, argent, or et shiny. Idéal pour donner "
          "envie aux enfants de revenir au jardin.",
      gradient: [Color(0xFFFFF0D8), Color(0xFFF8D8A0)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 520,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF5EE),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  const Text('👨‍👩‍👧', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Jardiner avec tes enfants',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: KultivaColors.textPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Passer'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _SlideView(slide: _slides[i]),
              ),
            ),
            // Dots.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(_slides.length, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: active ? 22 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: active
                        ? KultivaColors.primaryGreen
                        : KultivaColors.lightGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  if (_page > 0)
                    TextButton(
                      onPressed: () => _controller.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      ),
                      child: const Text('Retour'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_page < _slides.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KultivaColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      _page < _slides.length - 1 ? 'Suivant' : 'C\'est parti !',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
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

class _TutoSlide {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  const _TutoSlide({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}

class _SlideView extends StatelessWidget {
  final _TutoSlide slide;
  const _SlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: slide.gradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.gradient.last.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(slide.emoji, style: const TextStyle(fontSize: 70)),
          ),
          const SizedBox(height: 24),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: KultivaColors.textSecondary,
              height: 1.4,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
