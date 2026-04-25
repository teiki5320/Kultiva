import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../data/vegetables_base.dart';
import '../models/culture_entry.dart';
import '../models/vegetable.dart';
import '../utils/heatwave_tips.dart';
import 'culture_service.dart';
import 'prefs_service.dart';
import 'watering_service.dart';
import 'weather_service.dart';

/// Service de notifications locales :
///  - `scheduleMonthlyReminder()` — rappel "astuces du mois" planifié le
///     1er de chaque mois à 9h via `zonedSchedule` (re-déclenche).
///  - `checkAndNotify()` — envoie une notif immédiate si des plants ont
///     besoin d'eau (peut être appelé quand l'app passe en foreground).
class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  /// IDs fixes pour pouvoir annuler/remplacer les notifs.
  static const int _monthlyId = 100;
  static const int _wateringId = 42;
  static const int _dailyTamassiId = 73;
  static const int _heatwaveId = 200;

  /// Initialise le plugin. Appelé au démarrage de l'app.
  static Future<void> init() async {
    if (_initialized) return;
    if (kIsWeb) {
      _initialized = true;
      return;
    }
    try {
      // Timezone : initialise la DB de fuseaux puis règle le local.
      tz.initializeTimeZones();
      // Par défaut on prend le fuseau du device (France = Europe/Paris).
      // `tz.local` est déjà correct sauf override explicite.

      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
        macOS: iosSettings,
      );
      await _plugin.initialize(settings);
      _initialized = true;
    } catch (_) {
      _initialized = true;
    }
  }

  /// Planifie une notification récurrente le 1er de chaque mois à 9h00.
  /// Idempotent : annule la précédente avant d'en créer une nouvelle.
  static Future<void> scheduleMonthlyReminder() async {
    if (kIsWeb || !_initialized) return;
    try {
      await _plugin.cancel(_monthlyId);

      final now = tz.TZDateTime.now(tz.local);
      // Prochain 1er du mois à 9h. Si on est le 1er après 9h, on cible
      // le 1er du mois suivant.
      tz.TZDateTime next = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        1,
        9,
      );
      if (!next.isAfter(now)) {
        next = tz.TZDateTime(
          tz.local,
          now.month == 12 ? now.year + 1 : now.year,
          now.month == 12 ? 1 : now.month + 1,
          1,
          9,
        );
      }

      const androidDetails = AndroidNotificationDetails(
        'kultiva_monthly',
        'Rappel mensuel',
        channelDescription:
            'Résumé mensuel : légumes à semer, à récolter, astuces.',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
        macOS: iosDetails,
      );

      await _plugin.zonedSchedule(
        _monthlyId,
        '🌱 Un nouveau mois au potager',
        'Découvre ce que tu peux semer et récolter ce mois-ci.',
        next,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );
    } catch (_) {
      // Fail silently (perms refused, unsupported platform, etc.).
    }
  }

  /// Annule la notification mensuelle récurrente.
  static Future<void> cancelMonthlyReminder() async {
    if (kIsWeb || !_initialized) return;
    try {
      await _plugin.cancel(_monthlyId);
    } catch (_) {}
  }

  /// Planifie une notification quotidienne (19h locale) pour rappeler
  /// à l'utilisateur de venir voir son Tamassi.
  static Future<void> scheduleDailyTamassiReminder() async {
    if (kIsWeb || !_initialized) return;
    try {
      await _plugin.cancel(_dailyTamassiId);
      final now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime next =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, 19);
      if (!next.isAfter(now)) {
        next = next.add(const Duration(days: 1));
      }
      const androidDetails = AndroidNotificationDetails(
        'kultiva_tamassi_daily',
        'Rappel Tamassi',
        channelDescription:
            'Rappel quotidien pour venir voir ton Tamassi.',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
        macOS: iosDetails,
      );
      await _plugin.zonedSchedule(
        _dailyTamassiId,
        '🌱 Ton Tamassi t\'attend !',
        'Viens lui dire bonjour et récupérer ton XP du jour.',
        next,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (_) {
      // Fail silently (perms refused, etc.).
    }
  }

  /// Annule la notification quotidienne Tamassi.
  static Future<void> cancelDailyTamassiReminder() async {
    if (kIsWeb || !_initialized) return;
    try {
      await _plugin.cancel(_dailyTamassiId);
    } catch (_) {}
  }

  /// Vérifie les besoins en arrosage et envoie une notification immédiate
  /// si nécessaire. À appeler quand l'app revient en foreground.
  ///
  /// Respecte les règles suivantes :
  ///  - Ne rien faire si l'utilisateur a désactivé les notifications
  ///    dans les paramètres.
  ///  - Throttle : max 1 notif d'arrosage toutes les 24h.
  ///  - Silencieux s'il n'y a aucun plant en cours ou aucun plant en
  ///    détresse.
  static Future<void> checkAndNotify(List<String> gardenVegIds) async {
    if (kIsWeb || !_initialized) return;
    if (gardenVegIds.isEmpty) return;
    if (!PrefsService.instance.notifications.value) return;

    // Throttle : 24h minimum entre 2 notifs d'arrosage.
    final last = PrefsService.instance.lastWateringNotificationCheck;
    if (last != null &&
        DateTime.now().difference(last).inHours < 24) {
      return;
    }

    try {
      final weather = await WeatherService.getWeather();
      if (weather == null) return;

      final alerts = await WateringService.analyzeGarden(gardenVegIds);
      final urgent = alerts
          .where((a) => a.needsWatering && !a.rainExpected)
          .toList();

      if (urgent.isEmpty) return;

      final names = urgent.take(3).map((a) => a.vegetable.name).join(', ');
      final suffix =
          urgent.length > 3 ? ' et ${urgent.length - 3} autres' : '';
      final body =
          '${weather.consecutiveDryDays} jours sans pluie. '
          '$names$suffix ont besoin d\'eau !';

      const androidDetails = AndroidNotificationDetails(
        'kultiva_watering',
        'Alertes arrosage',
        channelDescription: 'Notifications quand vos légumes ont soif',
        importance: Importance.high,
        priority: Priority.high,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
        macOS: iosDetails,
      );

      await _plugin.show(
        _wateringId,
        '💧 Vos légumes ont soif !',
        body,
        details,
      );
      await PrefsService.instance
          .setLastWateringNotificationCheck(DateTime.now());
    } catch (_) {}
  }

  /// Vérifie si une canicule est prévue dans les 3 prochains jours
  /// (Tmax >= 30°C sur 2 jours d'affilée). Si oui, envoie une notif
  /// avec un conseil légume-spécifique tiré de la culture pleine
  /// terre la plus récemment démarrée.
  ///
  /// Throttle : max 1 fois tous les 7 jours.
  static Future<void> checkAndNotifyHeatwave() async {
    if (kIsWeb || !_initialized) return;
    if (!PrefsService.instance.notifications.value) return;

    final last = PrefsService.instance.lastHeatwaveNotificationCheck;
    if (last != null &&
        DateTime.now().difference(last).inDays < 7) {
      return;
    }
    try {
      final weather = await WeatherService.getWeather();
      if (weather == null) return;

      final tmaxList = weather.dailyTempMax;
      if (tmaxList.length < 9) return;
      // Index 7 = aujourd'hui ; on regarde aujourd'hui + 3 jours.
      var hotStreak = 0;
      var maxStreak = 0;
      var peak = 0.0;
      for (var i = 7; i <= 10 && i < tmaxList.length; i++) {
        final t = tmaxList[i];
        if (t > peak) peak = t;
        if (t >= 30) {
          hotStreak++;
          if (hotStreak > maxStreak) maxStreak = hotStreak;
        } else {
          hotStreak = 0;
        }
      }
      if (maxStreak < 2) return;

      // Conseil légume-spécifique : on prend les cultures pleine
      // terre actives, on garde la catégorie la plus représentée.
      final actives = CultureService.instance
          .activeByMethod(CultivationMethod.soil);
      String tip;
      if (actives.isEmpty) {
        tip = 'Arrose tôt le matin ou en soirée, paille tes plants '
            'et ombre les jeunes pousses.';
      } else {
        final categories = <VegetableCategory, int>{};
        for (final c in actives) {
          try {
            final v = vegetablesBase
                .firstWhere((veg) => veg.id == c.vegetableId);
            categories[v.category] = (categories[v.category] ?? 0) + 1;
          } catch (_) {}
        }
        final top = categories.entries.isEmpty
            ? VegetableCategory.fruits
            : (categories.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value)))
                .first
                .key;
        tip = heatwaveTipFor(top);
      }

      const androidDetails = AndroidNotificationDetails(
        'kultiva_heatwave',
        'Alerte canicule',
        channelDescription:
            'Avertissement quand une vague de chaleur est prévue.',
        importance: Importance.high,
        priority: Priority.high,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
        macOS: iosDetails,
      );

      await _plugin.show(
        _heatwaveId,
        '🥵 Canicule prévue (${peak.toStringAsFixed(0)}°C)',
        tip,
        details,
      );
      await PrefsService.instance
          .setLastHeatwaveNotificationCheck(DateTime.now());
    } catch (_) {}
  }
}
