import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'screens/onboarding_screen.dart';
import 'screens/root_tabs.dart';
import 'services/audio_service.dart';
import 'services/culture_service.dart';
import 'services/notification_service.dart';
import 'services/photo_service.dart';
import 'services/plantation_migration.dart';
import 'services/plantation_service.dart';
import 'services/prefs_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sentry est initialisé AVANT le bootstrap, pas après : tout ce que
  // fait `_bootstrapAndRun` (préférences, notifications, fuseau
  // horaire) tourne ainsi dans la zone surveillée. Sinon un
  // plantage au démarrage — la phase la plus fragile — ne remonterait
  // jamais, et l'utilisateur ne verrait qu'un écran vide.
  await SentryFlutter.init(
    (options) {
      // DSN Sentry du projet — public par design (voir docs/INFRA.md).
      options.dsn =
          'https://0ea500cdcb663dfbe9e22a7b4e309721@o4511455467864064.ingest.de.sentry.io/4511455478808656';
      // Échantillonnage bas : limite le trafic réseau de télémétrie
      // (forfaits data limités) tout en gardant les crash reports.
      options.tracesSampleRate = 0.05;
    },
    appRunner: _bootstrapAndRun,
  );
}

/// Exécute une étape de démarrage non critique : si elle échoue, on la
/// signale à Sentry et l'app démarre quand même. Un plugin de
/// notifications capricieux ou une purge de photos impossible ne doit
/// pas empêcher d'ouvrir le calendrier.
Future<void> _guard(String step, Future<void> Function() body) async {
  try {
    await body();
  } catch (e, s) {
    await Sentry.captureException(
      e,
      stackTrace: s,
      withScope: (scope) => scope.setTag('bootstrap_step', step),
    );
  }
}

Future<void> _bootstrapAndRun() async {
  // Kultiva est verrouillée en portrait (aucune vue paysage). Complète
  // le verrouillage déclaré côté iOS (Info.plist) pour Android.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Nunito est bundlée dans assets/google_fonts/ : on interdit tout
  // téléchargement de police au runtime (important sur les forfaits
  // data limités, notamment en Afrique de l'Ouest).
  GoogleFonts.config.allowRuntimeFetching = false;
  await PrefsService.instance.load();
  // La collection de plants est chargée ICI, par le démarrage, et non
  // par l'écran « Mon jardin » comme avant : le service qui détient les
  // plantations ne doit pas dépendre du passage de l'utilisateur sur un
  // onglet. Si un « Je l'ai planté » partait avant ce chargement, le
  // service écrirait sa liste vide par-dessus la collection.
  await _guard('plantations_init', () async {
    await migrateLegacyGridIfNeeded();
    PlantationService.instance.load();
    // Rattache les cultures du cahier antérieures au 30/10/2026 à un
    // dossier de plant (un seul registre d'arrosage).
    await CultureService.instance.linkLegacyEntries();
  });
  await _guard('notifications_init', NotificationService.init);
  // Purge best-effort des photos locales orphelines (non bloquant).
  PhotoService.purgeOrphans();
  // Re-programme le rappel mensuel si l'utilisateur l'a laissé activé.
  if (PrefsService.instance.notifications.value) {
    await _guard(
      'monthly_reminder',
      NotificationService.scheduleMonthlyReminder,
    );
  }
  // Re-programme le rappel quotidien Tamassi si activé.
  if (PrefsService.instance.tamassiDailyReminder.value) {
    await _guard(
      'daily_reminder',
      NotificationService.scheduleDailyTamassiReminder,
    );
  }
  if (PrefsService.instance.musicEnabled.value) {
    await _guard(
      'start_music',
      () async => AudioService.instance.startMusic(),
    );
  }
  runApp(const KultivaApp());
}

class KultivaApp extends StatelessWidget {
  const KultivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PrefsService.instance.darkMode,
      builder: (context, darkMode, _) {
        return MaterialApp(
          title: 'Kultiva',
          debugShowCheckedModeBanner: false,
          // App 100 % francophone : locale fixée en fr-FR pour que les
          // DatePicker et widgets Material soient en français.
          locale: const Locale('fr', 'FR'),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[Locale('fr', 'FR')],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          // L'app suit la taille de texte choisie dans les réglages du
          // système, mais plafonnée : beaucoup de cards ont encore une
          // hauteur fixe et débordaient aux très grandes valeurs. C'est
          // une mesure de sauvegarde, pas une mise en conformité — le
          // vrai correctif est de rendre ces cards extensibles, écran par
          // écran (voir _plans/audit-2026-10-30.md).
          builder: (context, child) {
            final media = MediaQuery.of(context);
            return MediaQuery(
              data: media.copyWith(
                textScaler: media.textScaler.clamp(
                  minScaleFactor: 1.0,
                  maxScaleFactor: 1.3,
                ),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: const _KultivaBootstrap(),
        );
      },
    );
  }
}

/// Orchestre le flow onboarding → main.
///
/// Il n'y a plus d'étape d'authentification : les comptes ont été
/// retirés de la v1 (le jardin vit sur l'appareil), donc l'app entre
/// directement dans son contenu. Et plus d'écran de démarrage Dart :
/// `flutter_native_splash` affiche le splash natif pendant le
/// chargement, donc l'app n'a plus qu'à entrer dans son contenu.
class _KultivaBootstrap extends StatefulWidget {
  const _KultivaBootstrap();

  @override
  State<_KultivaBootstrap> createState() => _KultivaBootstrapState();
}

enum _BootStep { onboarding, main }

class _KultivaBootstrapState extends State<_KultivaBootstrap> {
  late _BootStep _step;

  @override
  void initState() {
    super.initState();
    _step = PrefsService.instance.onboardingDone
        ? _BootStep.main
        : _BootStep.onboarding;
  }

  void _afterOnboarding() => setState(() => _step = _BootStep.main);

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _BootStep.onboarding:
        return OnboardingScreen(onDone: _afterOnboarding);
      case _BootStep.main:
        return const RootTabs();
    }
  }
}
