import 'package:flutter/material.dart';

import '../models/region_data.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDone;
  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const List<_OnboardingContent> _pages = <_OnboardingContent>[
    _OnboardingContent(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Bienvenue sur Kultiva',
      subtitle:
          "Ton copain potager : calendrier de semis, suivi d'arrosage, météo et conseils, tout au même endroit.",
    ),
    _OnboardingContent(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Ton tableau de bord',
      subtitle:
          "Chaque jour : ton légume du jour, la météo, les cartes Semer / Récolter / Calendrier. Tout se met à jour selon la saison.",
    ),
    _OnboardingContent(
      imagePath: 'assets/images/onboarding_poussidex.png',
      title: 'Ton Poussidex',
      subtitle:
          "Adopte ton Tamassi — Poussia, Soleia ou Spira — et fais-le "
          "évoluer à travers 11 stades. Relève des défis photo, gagne "
          "des badges façon Pokémon et monte ton Tamassi jusqu'au "
          "niveau 100 !",
    ),
    _OnboardingContent(
      imagePath: 'assets/images/onboarding_tutos.png',
      title: 'Apprends en vidéo',
      subtitle:
          "L'onglet Tutos regroupe astuces et vidéos pour débuter, "
          "réussir tes semis, arroser juste, lutter contre les nuisibles.",
    ),
    _OnboardingContent(
      imagePath: 'assets/images/onboarding_5.png',
      title: 'Achète et compare en un clic',
      subtitle:
          "Depuis chaque fiche légume, tu peux acheter des graines bio, du matériel de jardinage et comparer les prix en ligne.",
    ),
  ];

  int get _totalPages => _pages.length + 1; // +1 pour le sélecteur de région

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await PrefsService.instance.setOnboardingDone(true);
    if (mounted) widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KultivaColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _totalPages,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, index) {
                  if (index < _pages.length) {
                    return _OnboardingPage(content: _pages[index]);
                  }
                  return const _RegionSelectorPage();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(_totalPages, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: active ? 24 : 8,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
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
                      if (_page < _totalPages - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                      } else {
                        _finish();
                      }
                    },
                    child: Text(
                      _page < _totalPages - 1 ? 'Suivant' : 'Commencer',
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

class _OnboardingContent {
  final String imagePath;
  final String title;
  final String subtitle;
  const _OnboardingContent({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingContent content;
  const _OnboardingPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(52),
            child: Image.asset(
              content.imagePath,
              width: 240,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 240, height: 240,
                decoration: BoxDecoration(
                  color: KultivaColors.lightGreen.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(52),
                ),
                alignment: Alignment.center,
                child: const Text('🌱', style: TextStyle(fontSize: 110)),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.textPrimary,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            content.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: KultivaColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _RegionSelectorPage extends StatelessWidget {
  const _RegionSelectorPage();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        return SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(52),
                child: Image.asset(
                  'assets/images/onboarding_4.png',
                  width: 200, height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Text('🌍', style: TextStyle(fontSize: 100)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Choisis ta région',
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
              ),
              const SizedBox(height: 8),
              Text(
                "Les conseils de semis s'adaptent à ta zone.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: KultivaColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 24),
              for (final r in Region.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _RegionTile(
                    region: r,
                    selected: r == region,
                    onTap: () => PrefsService.instance.setRegion(r),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RegionTile extends StatelessWidget {
  final Region region;
  final bool selected;
  final VoidCallback onTap;

  const _RegionTile({
    required this.region,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? KultivaColors.primaryGreen.withOpacity(0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? KultivaColors.primaryGreen
                : KultivaColors.lightGreen,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(region.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                region.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: KultivaColors.primaryGreen,
              ),
          ],
        ),
      ),
    );
  }
}
