import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/region_data.dart';

/// Service de persistance locale + état réactif de l'application.
///
/// Expose des [ValueListenable] pour les champs les plus utilisés
/// ([region], [darkMode], [notifications], [favorites]), afin d'éviter
/// l'ajout d'un package de state management tiers en v1.
class PrefsService {
  PrefsService._();
  static final PrefsService instance = PrefsService._();

  static const _kRegion = 'kultiva.region';
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

  SharedPreferences? _prefs;

  final ValueNotifier<Region> region = ValueNotifier<Region>(Region.france);
  final ValueNotifier<bool> darkMode = ValueNotifier<bool>(false);
  final ValueNotifier<bool> notifications = ValueNotifier<bool>(true);
  final ValueNotifier<Set<String>> favorites =
      ValueNotifier<Set<String>>(<String>{});
  final ValueNotifier<bool> soundEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> musicEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<double> soundVolume = ValueNotifier<double>(0.7);

  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    region.value = Region.fromId(_prefs!.getString(_kRegion));
    darkMode.value = _prefs!.getBool(_kDarkMode) ?? false;
    notifications.value = _prefs!.getBool(_kNotifications) ?? true;
    favorites.value =
        (_prefs!.getStringList(_kFavorites) ?? const <String>[]).toSet();
    soundEnabled.value = _prefs!.getBool(_kSoundEnabled) ?? true;
    musicEnabled.value = _prefs!.getBool(_kMusicEnabled) ?? false;
    soundVolume.value = _prefs!.getDouble(_kSoundVolume) ?? 0.7;
    _loaded = true;
  }

  Future<void> setRegion(Region value) async {
    region.value = value;
    await _prefs?.setString(_kRegion, value.id);
  }

  Future<void> setDarkMode(bool value) async {
    darkMode.value = value;
    await _prefs?.setBool(_kDarkMode, value);
  }

  Future<void> setNotifications(bool value) async {
    notifications.value = value;
    await _prefs?.setBool(_kNotifications, value);
    // TODO: brancher flutter_local_notifications pour planifier/annuler
    // la notification mensuelle (le 1er de chaque mois).
  }

  Future<void> setSoundEnabled(bool value) async {
    soundEnabled.value = value;
    await _prefs?.setBool(_kSoundEnabled, value);
  }

  Future<void> setMusicEnabled(bool value) async {
    musicEnabled.value = value;
    await _prefs?.setBool(_kMusicEnabled, value);
  }

  Future<void> setSoundVolume(double value) async {
    soundVolume.value = value;
    await _prefs?.setDouble(_kSoundVolume, value);
  }

  bool get onboardingDone => _prefs?.getBool(_kOnboardingDone) ?? false;

  Future<void> setOnboardingDone(bool value) async {
    await _prefs?.setBool(_kOnboardingDone, value);
  }

  bool get gardenTutorialDone =>
      _prefs?.getBool(_kGardenTutorialDone) ?? false;

  Future<void> setGardenTutorialDone(bool value) async {
    await _prefs?.setBool(_kGardenTutorialDone, value);
  }

  bool isFavorite(String vegetableId) =>
      favorites.value.contains(vegetableId);

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

  // --- Garden grid ---
  String? get gardenGrid => _prefs?.getString(_kGardenGrid);

  Future<void> setGardenGrid(String? json) async {
    if (json == null) {
      await _prefs?.remove(_kGardenGrid);
    } else {
      await _prefs?.setString(_kGardenGrid, json);
    }
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
