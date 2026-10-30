import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'screens/auth/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/root_tabs.dart';
import 'screens/splash_screen.dart';
import 'services/audio_service.dart';
import 'services/auth_service.dart';
import 'services/cloud_sync_service.dart';
import 'services/notification_service.dart';
import 'services/photo_service.dart';
import 'services/prefs_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sentry est initialisé AVANT le bootstrap, pas après : tout ce que
  // fait `_bootstrapAndRun` (Supabase, préférences, notifications,
  // fuseau horaire) tourne ainsi dans la zone surveillée. Sinon un
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
  // Initialise Supabase (auth + sync cloud). Doit être fait avant
  // AuthService.load() qui pioche la session courante dans Supabase.
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  await PrefsService.instance.load();
  // Dès qu'une préférence change, on la pousse vers le cloud (si
  // l'utilisateur est connecté). Fire-and-forget — l'UI ne bloque pas.
  PrefsService.instance.onPreferencesChanged = () {
    CloudSyncService.instance.uploadPreferences();
  };
  await AuthService.instance.load();
  await _guard('notifications_init', NotificationService.init);
  // Si l'utilisateur a déjà une session (il avait ouvert l'app avant),
  // on synchronise plants + badges + prefs avec le cloud en arrière-
  // plan. Pas de await : l'UI démarre tout de suite.
  if (AuthService.instance.isSignedIn) {
    CloudSyncService.instance.syncAllOnLogin();
  }
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

/// Orchestre le flow splash → onboarding → auth → main.
class _KultivaBootstrap extends StatefulWidget {
  const _KultivaBootstrap();

  @override
  State<_KultivaBootstrap> createState() => _KultivaBootstrapState();
}

enum _BootStep { splash, onboarding, auth, main }

class _KultivaBootstrapState extends State<_KultivaBootstrap> {
  late _BootStep _step;

  @override
  void initState() {
    super.initState();
    // Skip splash: go directly to onboarding/auth/main.
    if (!PrefsService.instance.onboardingDone) {
      _step = _BootStep.onboarding;
    } else if (!_hasAccess) {
      _step = _BootStep.auth;
    } else {
      _step = _BootStep.main;
    }
  }

  void _afterSplash() {
    setState(() {
      if (!PrefsService.instance.onboardingDone) {
        _step = _BootStep.onboarding;
      } else if (!_hasAccess) {
        _step = _BootStep.auth;
      } else {
        _step = _BootStep.main;
      }
    });
  }

  void _afterOnboarding() {
    setState(() {
      _step = _hasAccess ? _BootStep.main : _BootStep.auth;
    });
  }

  /// L'app est accessible soit avec une session Supabase, soit en mode
  /// invité — le cœur de Kultiva est local-first et n'exige aucun compte.
  bool get _hasAccess =>
      AuthService.instance.isSignedIn || PrefsService.instance.guestMode;

  void _afterSignIn() => setState(() => _step = _BootStep.main);

  /// Choix « Continuer sans compte » depuis l'écran de connexion.
  void _afterGuest() => setState(() => _step = _BootStep.main);

  /// Déconnexion, ou sortie volontaire du mode invité pour se connecter :
  /// dans les deux cas on repasse par l'écran d'authentification.
  void _afterSignOut() => setState(() => _step = _BootStep.auth);

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _BootStep.splash:
        return SplashScreen(onDone: _afterSplash);
      case _BootStep.onboarding:
        return OnboardingScreen(onDone: _afterOnboarding);
      case _BootStep.auth:
        return LoginScreen(
          onSignedIn: _afterSignIn,
          onContinueAsGuest: _afterGuest,
        );
      case _BootStep.main:
        return RootTabs(onSignOut: _afterSignOut);
    }
  }
}
