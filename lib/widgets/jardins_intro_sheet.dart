import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Sheet de présentation à la première ouverture de « Mes jardins ».
///
/// Affiché une seule fois (flag prefs `jardinsTutorialDone`). Couvre
/// les 4 fonctions clés : jardins multiples pleine terre, placement
/// par drag/drop dans des cases, suivi par plant (arrosage + phase
/// + photos), et la possibilité d'ajuster la date de plantation pour
/// un suivi rétroactif.
class JardinsIntroSheet extends StatefulWidget {
  const JardinsIntroSheet({super.key});

  @override
  State<JardinsIntroSheet> createState() => _JardinsIntroSheetState();
}

class _JardinsIntroSheetState extends State<JardinsIntroSheet> {
  final PageController _controller = PageController();
  int _page = 0;

  static const List<_IntroSlide> _slides = <_IntroSlide>[
    _IntroSlide(
      emoji: '🌿',
      title: 'Mes jardins',
      subtitle:
          "Crée autant de jardins pleine terre que tu veux, "
          "chacun avec sa grille de cases. L'app suit tes plants "
          "et te conseille tout au long de la saison.",
      gradient: [Color(0xFFE0FFE8), Color(0xFFC0E8D0)],
    ),
    _IntroSlide(
      emoji: '🟢',
      title: 'Place tes plants',
      subtitle:
          "Choisis un plant en bas, dépose-le sur une case. La case "
          "se remplit avec un emoji + le nombre de plants. Tap pour "
          "ouvrir la fiche détaillée.",
      gradient: [Color(0xFFFFE0EC), Color(0xFFFFBDD2)],
    ),
    _IntroSlide(
      emoji: '💧',
      title: 'Suis tes plants au quotidien',
      subtitle:
          "Bouton « Arroser » dans chaque fiche, conseils d'irrigation "
          "adaptés au légume, et un badge couleur pour savoir si tu "
          "as arrosé récemment ou pas.",
      gradient: [Color(0xFFE0F0FF), Color(0xFFC0D8F0)],
    ),
    _IntroSlide(
      emoji: '📅',
      title: 'Date de plantation = stade',
      subtitle:
          "Tu peux corriger la date de plantation à tout moment. "
          "L'app calcule automatiquement le stade (semis / croissance / "
          "floraison / fructification) et adapte ses conseils.",
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
        height: 540,
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
                  const Text('📔', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Bienvenue dans Mes jardins',
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

class _IntroSlide {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  const _IntroSlide({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}

class _SlideView extends StatelessWidget {
  final _IntroSlide slide;
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
