import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/country.dart';
import '../models/region_data.dart';
import 'notification_service.dart';

/// Service de persistance locale + état réactif de l'application.
///
/// Expose des [ValueListenable] pour les champs les plus utilisés
/// ([region], [darkMode], [notifications], [favorites]), afin d'éviter
/// l'ajout d'un package de state management tiers en v1.
class PrefsService {
  PrefsService._();
  static final PrefsService instance = PrefsService._();

  static const _kRegion = 'kultiva.region';
  static const _kCountry = 'kultiva.country';
  static const _kClimateZone = 'kultiva.climateZone';
  static const _kDarkMode = 'kultiva.darkMode';
  static const _kNotifications = 'kultiva.notifications';
  static const _kOnboardingDone = 'kultiva.onboardingDone';
  static const _kFavorites = 'kultiva.favorites';
  static const _kAuthEmail = 'kultiva.auth.email';
  static const _kAuthName = 'kultiva.auth.name';
  static const _kGardenGrid = 'kultiva.gardenGrid';
  static const _kWateringHistory = 'kultiva.wateringHistory';
  static const _kSoundEnabled = 'kultiva.soundEnabled';
  static const _kMusicEnabled = 'kultiva.musicEnabled';
  static const _kSoundVolume = 'kultiva.soundVolume';
  static const _kGardenTutorialDone = 'kultiva.gardenTutorialDone';
  static const _kPlantations = 'kultiva.plantations.v1';
  static const _kUnlockedBadges = 'kultiva.unlockedBadges.v1';
  static const _kGridMigrated = 'kultiva.gridMigratedToPoussidex';
  static const _kLastWateringCheck = 'kultiva.lastWateringNotificationCheck';
  static const _kLastHeatwaveCheck = 'kultiva.lastHeatwaveNotificationCheck';
  static const _kLastFirstRainsCheck = 'kultiva.lastFirstRainsNotification';
  static const _kTamassiDailyReminder = 'kultiva.tamassiDailyReminder';
  static const _kCultures = 'kultiva.cultures.v1';
  static const _kJardinsTutorialDone = 'kultiva.jardinsTutorialDone';
  static const _kPrefsUpdatedAt = 'kultiva.prefs.updatedAt';

  SharedPreferences? _prefs;

  final ValueNotifier<Region> region = ValueNotifier<Region>(Region.france);

  /// Pays choisi par l'utilisateur (France ou pays francophone d'Afrique
  /// de l'Ouest). Null pour les utilisateurs historiques qui n'ont que la
  /// région — la région reste le pivot pour tous les calendriers.
  final ValueNotifier<Country?> country = ValueNotifier<Country?>(null);

  /// Sous-zone climatique choisie/détectée (affine calendriers et
  /// saisons dans un même pays). Null = utiliser la zone par défaut du
  /// pays. Voir [effectiveZone].
  final ValueNotifier<ClimateZone?> climateZone =
      ValueNotifier<ClimateZone?>(null);

  /// Zone climatique effective : la sous-zone détectée/choisie si elle
  /// existe, sinon la zone par défaut du pays. Utilisée par tous les
  /// calendriers et saisons régionalisés.
  ClimateZone? get effectiveZone => climateZone.value ?? country.value?.zone;
  final ValueNotifier<bool> darkMode = ValueNotifier<bool>(false);
  final ValueNotifier<bool> notifications = ValueNotifier<bool>(true);
  final ValueNotifier<Set<String>> favorites =
      ValueNotifier<Set<String>>(<String>{});
  final ValueNotifier<bool> soundEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> musicEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<double> soundVolume = ValueNotifier<double>(0.7);
  final ValueNotifier<bool> tamassiDailyReminder = ValueNotifier<bool>(true);

  /// Notifier incrémenté à chaque écriture de la collection de
  /// plantations. Les écrans qui dépendent des médailles (Étal) s'y
  /// abonnent pour se rafraîchir sans avoir à importer l'état du
  /// Poussidex.
  final ValueNotifier<int> plantationsVersion = ValueNotifier<int>(0);

  /// Même pattern que [plantationsVersion], pour le cahier de culture
  /// (séparé du Poussidex).
  final ValueNotifier<int> culturesVersion = ValueNotifier<int>(0);

  /// Callback appelé après chaque changement de préférence. Permet
  /// à CloudSyncService de re-uploader les prefs sans créer de
  /// dépendance circulaire. Réglé une fois dans main().
  VoidCallback? onPreferencesChanged;

  /// Quand true, l'application de préférences venues du cloud est en
  /// cours : on ne bump pas le timestamp local et on ne re-uploade pas
  /// (sinon chaque champ appliqué déclencherait un upload concurrent et
  /// ferait croire que le local est plus récent que le cloud).
  bool _applyingRemote = false;

  /// Horodatage de la dernière modification locale des préférences
  /// (UTC). Sert au last-write-wins contre le cloud, pour ne pas écraser
  /// un choix fait hors-ligne par une valeur cloud périmée.
  DateTime? get prefsUpdatedAt {
    final iso = _prefs?.getString(_kPrefsUpdatedAt);
    if (iso == null) return null;
    return DateTime.tryParse(iso);
  }

  /// Applique des préférences venues du cloud sans re-déclencher d'upload
  /// ni bumper le timestamp local.
  Future<void> applyRemotePreferences(Future<void> Function() body) async {
    _applyingRemote = true;
    try {
      await body();
    } finally {
      _applyingRemote = false;
    }
  }

  void _notifyPrefsChanged() {
    if (_applyingRemote) return;
    _prefs?.setString(
        _kPrefsUpdatedAt, DateTime.now().toUtc().toIso8601String());
    try {
      onPreferencesChanged?.call();
    } catch (_) {}
  }

  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    region.value = Region.fromId(_prefs!.getString(_kRegion));
    country.value = Country.fromIso(_prefs!.getString(_kCountry));
    // Le pays, s'il est connu, fait autorité sur la région.
    if (country.value != null) region.value = country.value!.region;
    climateZone.value = ClimateZone.fromName(_prefs!.getString(_kClimateZone));
    darkMode.value = _prefs!.getBool(_kDarkMode) ?? false;
    notifications.value = _prefs!.getBool(_kNotifications) ?? true;
    favorites.value =
        (_prefs!.getStringList(_kFavorites) ?? const <String>[]).toSet();
    soundEnabled.value = _prefs!.getBool(_kSoundEnabled) ?? true;
    musicEnabled.value = _prefs!.getBool(_kMusicEnabled) ?? false;
    soundVolume.value = _prefs!.getDouble(_kSoundVolume) ?? 0.7;
    tamassiDailyReminder.value =
        _prefs!.getBool(_kTamassiDailyReminder) ?? true;
    _loaded = true;
  }

  Future<void> setTamassiDailyReminder(bool value) async {
    tamassiDailyReminder.value = value;
    await _prefs?.setBool(_kTamassiDailyReminder, value);
    if (value) {
      await NotificationService.scheduleDailyTamassiReminder();
    } else {
      await NotificationService.cancelDailyTamassiReminder();
    }
    _notifyPrefsChanged();
  }

  /// Lecture/écriture générique pour stocker des données arbitraires
  /// (ex: défis complétés). Pour des champs typés, utiliser les
  /// getters/setters dédiés ci-dessous.
  String? getString(String key) => _prefs?.getString(key);
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> setRegion(Region value) async {
    region.value = value;
    // Une région choisie sans pays invalide le pays mémorisé s'il est
    // incohérent (ex. passage manuel AO → France).
    if (country.value != null && country.value!.region != value) {
      country.value = null;
      await _prefs?.remove(_kCountry);
    }
    // La sous-zone n'a de sens qu'en Afrique de l'Ouest.
    if (value != Region.westAfrica && climateZone.value != null) {
      climateZone.value = null;
      await _prefs?.remove(_kClimateZone);
    }
    await _prefs?.setString(_kRegion, value.id);
    _notifyPrefsChanged();
  }

  /// Choisit un pays et aligne la région dessus. [zone] est la sous-zone
  /// affinée (par latitude GPS ou choix manuel) ; null réinitialise sur
  /// la zone par défaut du pays.
  Future<void> setCountry(Country value, {ClimateZone? zone}) async {
    country.value = value;
    region.value = value.region;
    climateZone.value = zone;
    await _prefs?.setString(_kCountry, value.isoCode);
    await _prefs?.setString(_kRegion, value.region.id);
    if (zone == null) {
      await _prefs?.remove(_kClimateZone);
    } else {
      await _prefs?.setString(_kClimateZone, zone.name);
    }
    _notifyPrefsChanged();
  }

  /// Change uniquement la sous-zone climatique (sélecteur manuel).
  Future<void> setClimateZone(ClimateZone? zone) async {
    climateZone.value = zone;
    if (zone == null) {
      await _prefs?.remove(_kClimateZone);
    } else {
      await _prefs?.setString(_kClimateZone, zone.name);
    }
    _notifyPrefsChanged();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode.value = value;
    await _prefs?.setBool(_kDarkMode, value);
    _notifyPrefsChanged();
  }

  Future<void> setNotifications(bool value) async {
    notifications.value = value;
    await _prefs?.setBool(_kNotifications, value);
    if (value) {
      await NotificationService.scheduleMonthlyReminder();
    } else {
      await NotificationService.cancelMonthlyReminder();
    }
    _notifyPrefsChanged();
  }

  Future<void> setSoundEnabled(bool value) async {
    soundEnabled.value = value;
    await _prefs?.setBool(_kSoundEnabled, value);
    _notifyPrefsChanged();
  }

  Future<void> setMusicEnabled(bool value) async {
    musicEnabled.value = value;
    await _prefs?.setBool(_kMusicEnabled, value);
    _notifyPrefsChanged();
  }

  Future<void> setSoundVolume(double value) async {
    soundVolume.value = value;
    await _prefs?.setDouble(_kSoundVolume, value);
    _notifyPrefsChanged();
  }

  bool get onboardingDone => _prefs?.getBool(_kOnboardingDone) ?? false;

  Future<void> setOnboardingDone(bool value) async {
    await _prefs?.setBool(_kOnboardingDone, value);
  }

  bool get gardenTutorialDone => _prefs?.getBool(_kGardenTutorialDone) ?? false;

  Future<void> setGardenTutorialDone(bool value) async {
    await _prefs?.setBool(_kGardenTutorialDone, value);
  }

  bool isFavorite(String vegetableId) => favorites.value.contains(vegetableId);

  Future<void> toggleFavorite(String vegetableId) async {
    final next = Set<String>.from(favorites.value);
    if (next.contains(vegetableId)) {
      next.remove(vegetableId);
    } else {
      next.add(vegetableId);
    }
    favorites.value = next;
    await _prefs?.setStringList(_kFavorites, next.toList());
  }

  // --- Garden grid (legacy, migré vers Poussidex) ---
  String? get gardenGrid => _prefs?.getString(_kGardenGrid);

  Future<void> setGardenGrid(String? json) async {
    if (json == null) {
      await _prefs?.remove(_kGardenGrid);
    } else {
      await _prefs?.setString(_kGardenGrid, json);
    }
  }

  // --- Poussidex : collection de plantations ---
  String? get plantationsJson => _prefs?.getString(_kPlantations);

  Future<void> setPlantationsJson(String json) async {
    await _prefs?.setString(_kPlantations, json);
    plantationsVersion.value = plantationsVersion.value + 1;
  }

  // --- Cahier de culture (séparé du Poussidex) ---
  String? get culturesJson => _prefs?.getString(_kCultures);

  Future<void> setCulturesJson(String json) async {
    await _prefs?.setString(_kCultures, json);
    culturesVersion.value = culturesVersion.value + 1;
  }

  // --- Tutoriel premier-lancement de Mes Jardins ---
  bool get jardinsTutorialDone =>
      _prefs?.getBool(_kJardinsTutorialDone) ?? false;

  Future<void> setJardinsTutorialDone(bool value) async {
    await _prefs?.setBool(_kJardinsTutorialDone, value);
  }

  Set<String> get unlockedBadges =>
      (_prefs?.getStringList(_kUnlockedBadges) ?? const <String>[]).toSet();

  Future<void> setUnlockedBadges(Set<String> ids) async {
    await _prefs?.setStringList(_kUnlockedBadges, ids.toList());
  }

  bool get gridMigrated => _prefs?.getBool(_kGridMigrated) ?? false;

  Future<void> setGridMigrated(bool value) async {
    await _prefs?.setBool(_kGridMigrated, value);
  }

  /// Dernier moment où une notification d'alerte d'arrosage a été
  /// envoyée. Utilisé pour throttler à max 1 notif par 24h.
  DateTime? get lastWateringNotificationCheck {
    final iso = _prefs?.getString(_kLastWateringCheck);
    if (iso == null) return null;
    return DateTime.tryParse(iso);
  }

  Future<void> setLastWateringNotificationCheck(DateTime t) async {
    await _prefs?.setString(_kLastWateringCheck, t.toIso8601String());
  }

  /// Dernière notif canicule envoyée. Utilisé pour throttler (max 1
  /// par 7 jours).
  DateTime? get lastHeatwaveNotificationCheck {
    final iso = _prefs?.getString(_kLastHeatwaveCheck);
    if (iso == null) return null;
    return DateTime.tryParse(iso);
  }

  Future<void> setLastHeatwaveNotificationCheck(DateTime t) async {
    await _prefs?.setString(_kLastHeatwaveCheck, t.toIso8601String());
  }

  /// Dernière notif « premières pluies » envoyée (throttle 30 jours).
  DateTime? get lastFirstRainsNotificationCheck {
    final iso = _prefs?.getString(_kLastFirstRainsCheck);
    if (iso == null) return null;
    return DateTime.tryParse(iso);
  }

  Future<void> setLastFirstRainsNotificationCheck(DateTime t) async {
    await _prefs?.setString(_kLastFirstRainsCheck, t.toIso8601String());
  }

  // --- Watering history ---
  /// Retourne la liste des dates d'arrosage (ISO 8601).
  List<String> get wateringHistory =>
      _prefs?.getStringList(_kWateringHistory) ?? [];

  /// Enregistre un arrosage maintenant.
  Future<void> recordWatering() async {
    final history = wateringHistory;
    history.insert(0, DateTime.now().toIso8601String());
    // Garder max 60 jours d'historique.
    if (history.length > 60) history.removeRange(60, history.length);
    await _prefs?.setStringList(_kWateringHistory, history);
  }

  /// Dernier arrosage enregistré, ou null.
  DateTime? get lastWatering {
    final h = wateringHistory;
    if (h.isEmpty) return null;
    return DateTime.tryParse(h.first);
  }

  /// Nombre de jours depuis le dernier arrosage.
  int? get daysSinceLastWatering {
    final last = lastWatering;
    if (last == null) return null;
    return DateTime.now().difference(last).inDays;
  }

  String? get authEmail => _prefs?.getString(_kAuthEmail);
  String? get authName => _prefs?.getString(_kAuthName);

  /// Purge toutes les données rattachées à un compte : Poussidex, badges,
  /// cultures, jardins, Tamassi (XP/starter/nom/streak), défis, favoris,
  /// historique d'arrosage et statistiques. Appelé à la déconnexion et à
  /// la suppression de compte, pour qu'un autre compte ne récupère jamais
  /// les données du précédent sur le même appareil.
  ///
  /// Les préférences de l'appareil (son, thème, région, notifications)
  /// sont conservées : elles sont re-synchronisées depuis le cloud à la
  /// prochaine connexion.
  Future<void> clearUserScopedData() async {
    final p = _prefs;
    if (p == null) return;
    const exactKeys = <String>[
      _kPlantations,
      _kUnlockedBadges,
      _kCultures,
      _kFavorites,
      _kWateringHistory,
      _kGardenGrid,
      _kGridMigrated,
      _kGardenTutorialDone,
      'kultiva.creature.xp',
      'kultiva.creature.starter',
      'kultiva.creature.name',
      'kultiva.creature.streak',
      'kultiva.creature.lastSeen',
      'kultiva.creature.lastWater',
      'kultiva.creature.lastFertilize',
      'kultiva.creature.lastCaress',
      'kultiva.challenges.v1',
      'garden_plans_v1',
    ];
    for (final k in exactKeys) {
      await p.remove(k);
    }
    // Statistiques Tamassi : clés dynamiques `tamassi.stats.*`.
    final statKeys =
        p.getKeys().where((k) => k.startsWith('tamassi.stats.')).toList();
    for (final k in statKeys) {
      await p.remove(k);
    }
    // Remet les notifiers réactifs à l'état vierge.
    favorites.value = <String>{};
    plantationsVersion.value = plantationsVersion.value + 1;
    culturesVersion.value = culturesVersion.value + 1;
  }

  Future<void> setAuth({String? email, String? name}) async {
    if (email == null) {
      await _prefs?.remove(_kAuthEmail);
    } else {
      await _prefs?.setString(_kAuthEmail, email);
    }
    if (name == null) {
      await _prefs?.remove(_kAuthName);
    } else {
      await _prefs?.setString(_kAuthName, name);
    }
  }
}
