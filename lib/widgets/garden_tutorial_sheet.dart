import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Overlay bottom-sheet qui explique en 3 slides comment utiliser
/// Mon Potager. Affiché une seule fois (flag gardenTutorialDone) juste
/// après le choix de la taille de potager.
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
      emoji: '🌱',
      title: 'Pose tes plants',
      subtitle:
          "Tap une case vide pour choisir un légume dans ton catalogue. "
          "Chaque plant prend la forme d'un bonbon kawaii avec le nom en dessous.",
      gradient: [Color(0xFFFFE0E8), Color(0xFFF8C0D0)],
    ),
    _TutoSlide(
      emoji: '💧',
      title: 'Arrose en deux taps',
      subtitle:
          "Active le bouton 💧 en bas : chaque case tapée est arrosée. "
          "Ou utilise '🌧️ Tout arroser' pour tout hydrater d'un coup — "
          "la bannière orange te signale les plantes qui ont soif.",
      gradient: [Color(0xFFE0F0FF), Color(0xFFC0D8F0)],
    ),
    _TutoSlide(
      emoji: '🔍',
      title: 'Appui long = fiche plante',
      subtitle:
          "Maintiens le doigt sur une case plantée pour voir sa fiche : "
          "dernière date d'arrosage, bons voisins, alertes de compagnonnage. "
          "Tu peux aussi retirer le plant depuis là.",
      gradient: [Color(0xFFE0FFE8), Color(0xFFC0E8D0)],
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
                  const Text('🎀', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    'Comment ça marche',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: KultivaColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
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
                  color: slide.gradient.last.withOpacity(0.35),
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
