import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data/vegetables_base.dart';
import 'watering_service.dart';
import 'weather_service.dart';

/// Service de notifications locales pour les alertes d'arrosage.
class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  /// Initialise le plugin de notifications. Appelé au démarrage de l'app.
  static Future<void> init() async {
    if (_initialized) return;
    // Skip sur le web — pas de support.
    if (kIsWeb) {
      _initialized = true;
      return;
    }
    try {
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
      // Silently fail on unsupported platforms.
      _initialized = true;
    }
  }

  /// Vérifie les besoins en arrosage et envoie une notification si nécessaire.
  static Future<void> checkAndNotify(List<String> gardenVegIds) async {
    if (kIsWeb || !_initialized) return;
    if (gardenVegIds.isEmpty) return;

    try {
      final weather = await WeatherService.getWeather();
      if (weather == null) return;

      final alerts = await WateringService.analyzeGarden(gardenVegIds);
      final urgent = alerts.where((a) => a.needsWatering && !a.rainExpected).toList();

      if (urgent.isEmpty) return;

      final names = urgent.take(3).map((a) => a.vegetable.name).join(', ');
      final suffix = urgent.length > 3 ? ' et ${urgent.length - 3} autres' : '';
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
        42, // ID fixe — on remplace la notif précédente.
        '💧 Vos légumes ont soif !',
        body,
        details,
      );
    } catch (_) {
      // Fail silently.
    }
  }
}
