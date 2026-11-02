import 'package:flutter/material.dart';

import '../data/ui_i18n.dart';
import '../models/country.dart';
import '../models/region_data.dart';
import '../services/geolocation_service.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';
import '../utils/text_normalize.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDone;
  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static List<_OnboardingContent> get _pages => <_OnboardingContent>[
        _OnboardingContent(
          imagePath: 'assets/images/onboarding_1.png',
          fallbackEmoji: '🌱',
          title: trUi('Bienvenue sur Kultiva'),
          subtitle: trUi(
              'Le potager kawaii dans ta poche. Calendrier de semis, suivi '
              'de tes plants, météo, conseils — tout au même endroit, en '
              'français.'),
        ),
        _OnboardingContent(
          imagePath: 'assets/images/onboarding_2.png',
          fallbackEmoji: '📔',
          title: trUi('Ton cahier de culture'),
          subtitle: trUi('Crée ton potager pleine terre, place tes plants par '
              'glisser-déposer dans les cases et suis chaque phase de '
              'croissance.'),
        ),
        _OnboardingContent(
          imagePath: 'assets/images/onboarding_3.png',
          fallbackEmoji: '🌦️',
          title: trUi('Météo + alertes arrosage'),
          subtitle: trUi(
              "L'app suit la météo de ton jardin et te prévient quand "
              "il faut arroser, protéger d'une canicule ou rentrer un plant."),
        ),
        // Cette page présentait le Poussidex, puis a été renommée « Ton
        // cahier de culture » sans que son texte change : l'onboarding
        // annonçait donc deux fois le même écran, avec les mêmes carrés et
        // le même glisser-déposer. Elle parle maintenant de ce qui s'ajoute
        // au cahier — le journal, les défis, les médailles.
        _OnboardingContent(
          imagePath: 'assets/images/onboarding_journal.png',
          fallbackEmoji: '📖',
          title: trUi('Le journal de ton jardin'),
          subtitle:
              trUi("Chaque semis, chaque arrosage, chaque récolte s'inscrit "
                  "à sa date. Relis ta saison jour par jour, décroche des "
                  "médailles par légume et 50 défis photo."),
        ),
        _OnboardingContent(
          imagePath: 'assets/images/onboarding_tutos.png',
          fallbackEmoji: '📚',
          title: trUi('Apprends à ton rythme'),
          subtitle:
              trUi("L'onglet Tutos t'accompagne pas à pas : réussir tes semis, "
                  "bien arroser, lutter contre les nuisibles et apprendre les "
                  "bons gestes au jardin."),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  if (_page > 0)
                    TextButton(
                      onPressed: () => _controller.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      ),
                      child: Text(trUi('Retour')),
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
                      _page < _totalPages - 1
                          ? trUi('Suivant')
                          : trUi('Commencer'),
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
  final String fallbackEmoji;
  final String title;
  final String subtitle;
  const _OnboardingContent({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.fallbackEmoji = '🌱',
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
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: KultivaColors.lightGreen.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(52),
                ),
                alignment: Alignment.center,
                child: Text(
                  content.fallbackEmoji,
                  style: const TextStyle(fontSize: 110),
                ),
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

class _RegionSelectorPage extends StatefulWidget {
  const _RegionSelectorPage();

  @override
  State<_RegionSelectorPage> createState() => _RegionSelectorPageState();
}

class _RegionSelectorPageState extends State<_RegionSelectorPage> {
  bool _detecting = false;

  /// Pays proposé en tête de liste : déduit de la région du téléphone
  /// (fr_SN → Sénégal, aucune permission requise) puis affiné par
  /// géolocalisation passive. Un utilisateur sénégalais doit arriver
  /// sur une appli sénégalaise, pas sur une appli française déclinée.
  Country? _suggested;

  /// La liste est passée de 9 à 73 pays le 01/11/2026 : sans
  /// recherche, trouver le sien demandait de dérouler une page et
  /// demie.
  final TextEditingController _recherche = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _recherche.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final localeIso =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    _suggested = Country.fromIso(localeIso);
    _refinePassively();
  }

  /// Géolocalisation silencieuse : uniquement si la permission est déjà
  /// accordée (aucun dialogue système surprise). Pré-sélectionne le pays
  /// détecté tant que l'utilisateur n'a rien choisi lui-même.
  Future<void> _refinePassively() async {
    final detected = await GeolocationService.detectCountryPassive();
    if (!mounted || detected == null) return;
    setState(() => _suggested = detected);
    if (PrefsService.instance.country.value == null) {
      await PrefsService.instance.setCountry(detected);
    }
  }

  Future<void> _detectCountry() async {
    setState(() => _detecting = true);
    // Détecte le pays ET affine la sous-zone climatique par latitude.
    final detected = await GeolocationService.detectCountryAndZone();
    if (!mounted) return;
    setState(() {
      _detecting = false;
      if (detected != null) _suggested = detected.country;
    });
    if (detected != null) {
      await PrefsService.instance
          .setCountry(detected.country, zone: detected.zone);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(trUiArgs('{0} Tu jardines : {1} !',
              <Object?>[detected.country.flag, detected.country.displayLabel])),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            trUi('Impossible de détecter ton pays — choisis-le dans la liste.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Country?>(
      valueListenable: PrefsService.instance.country,
      builder: (context, country, _) {
        final region = PrefsService.instance.region.value;
        final q = foldAccents(_query.trim());
        final countries = Country.ordered(first: _suggested)
            .where((c) =>
                q.isEmpty ||
                foldAccents(c.displayLabel).contains(q) ||
                foldAccents(c.label).contains(q) ||
                foldAccents(c.displayCapital).contains(q) ||
                foldAccents(c.capitalName).contains(q) ||
                c.isoCode.toLowerCase() == q)
            .toList();
        bool isSelected(Country c) =>
            c == country ||
            (country == null &&
                c == Country.france &&
                region == Region.france &&
                _suggested == null);
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(52),
                child: Image.asset(
                  'assets/images/onboarding_4.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Text('🌍', style: TextStyle(fontSize: 90)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                trUi('Où jardines-tu ?'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                trUi("Calendrier de semis, saisons et conseils s'adaptent "
                    'à ton pays.'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: KultivaColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _recherche,
                onChanged: (v) => setState(() => _query = v),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: trUi('Cherche ton pays ou ta capitale…'),
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _recherche.clear();
                            setState(() => _query = '');
                          },
                        ),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (countries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    trUiArgs(
                        'Aucun pays ne porte « {0} ». Kultiva en couvre {1} '
                        '— dis-nous si le tien manque.',
                        <Object?>[_query, Country.values.length]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ),
              for (final c in countries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _CountryTile(
                    country: c,
                    selected: isSelected(c),
                    suggested: c == _suggested,
                    onTap: () => PrefsService.instance.setCountry(c),
                  ),
                ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _detecting ? null : _detectCountry,
                icon: _detecting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(_detecting
                    ? trUi('Détection en cours…')
                    : trUi('Détecter mon pays')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  final Country country;
  final bool selected;
  final bool suggested;
  final VoidCallback onTap;

  const _CountryTile({
    required this.country,
    required this.selected,
    this.suggested = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: suggested && !selected
          ? trUiArgs('{0}, suggéré d\'après ton téléphone',
              <Object?>[country.displayLabel])
          : country.displayLabel,
      button: true,
      selected: selected,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: selected
                ? KultivaColors.primaryGreen.withValues(alpha: 0.12)
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
              Text(country.flag, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  country.displayLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              if (suggested && !selected)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: KultivaColors.primaryGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    trUi('📍 Suggéré'),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.primaryGreen,
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
      ),
    );
  }
}
