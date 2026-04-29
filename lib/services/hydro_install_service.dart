import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/culture_entry.dart';
import '../models/garden_plan.dart';
import '../models/hydro_install.dart';
import 'culture_service.dart';
import 'prefs_service.dart';

/// Service de gestion des installations hydroponiques (objets physiques :
/// 1 bac + 1 lampe + 1 réservoir + N slots).
///
/// Stockage local via SharedPreferences ; expose une [installs]
/// notifiable pour les widgets. Migration automatique des cultures
/// hydro orphelines au premier lancement.
class HydroInstallService {
  HydroInstallService._();
  static final HydroInstallService instance = HydroInstallService._();

  final ValueNotifier<List<HydroInstall>> installs =
      ValueNotifier<List<HydroInstall>>(<HydroInstall>[]);

  final Random _random = Random();

  /// À appeler au démarrage de l'app. Charge depuis prefs et lance la
  /// migration des cultures hydro orphelines (cultures existantes pas
  /// liées à une install) le cas échéant.
  Future<void> load() async {
    installs.value =
        HydroInstall.decodeAll(PrefsService.instance.hydroInstallsJson);
    await _migrateOrphanCulturesIfNeeded();
  }

  /// Si on a des cultures hydro qui ne sont référencées par aucune
  /// install, on les regroupe dans une install fictive « Mon install »
  /// pour ne perdre aucune donnée.
  Future<void> _migrateOrphanCulturesIfNeeded() async {
    final hydroCultures = CultureService.instance
        .activeByMethod(CultivationMethod.hydroponic);
    if (hydroCultures.isEmpty) return;

    final knownIds = <String>{
      for (final i in installs.value)
        for (final id in i.slotCultureIds)
          if (id != null) id,
    };
    final orphans =
        hydroCultures.where((c) => !knownIds.contains(c.id)).toList();
    if (orphans.isEmpty) return;

    // Crée une install par défaut qui accueille tous les orphelins.
    final defaultInstall = HydroInstall(
      id: _generateId(),
      name: 'Mon install',
      systemType: _guessSystemTypeFromCultures(orphans),
      slotCount: orphans.length.clamp(1, 8),
      reservoirL: 20.0,
      slotCultureIds: <String?>[for (final c in orphans) c.id],
      createdAt: DateTime.now(),
      light: orphans.first.light,
    );
    final next = <HydroInstall>[...installs.value, defaultInstall];
    await _persist(next);
  }

  /// Devine grossièrement le type de système à partir des cultures
  /// existantes — utilisé seulement pour la migration où on n'a pas
  /// l'info. Par défaut : DWC (le plus courant chez les amateurs).
  HydroSystemType _guessSystemTypeFromCultures(List<CultureEntry> _) {
    return HydroSystemType.dwc;
  }

  Future<HydroInstall> create({
    required String name,
    required HydroSystemType systemType,
    required int slotCount,
    required double reservoirL,
    HydroLightConfig? light,
    String? photoPath,
  }) async {
    final install = HydroInstall(
      id: _generateId(),
      name: name,
      systemType: systemType,
      slotCount: slotCount,
      reservoirL: reservoirL,
      light: light,
      photoPath: photoPath,
      createdAt: DateTime.now(),
      slotCultureIds: List<String?>.filled(slotCount, null),
    );
    final next = <HydroInstall>[...installs.value, install];
    await _persist(next);
    return install;
  }

  Future<void> update(HydroInstall updated) async {
    final next = installs.value
        .map((i) => i.id == updated.id ? updated : i)
        .toList();
    await _persist(next);
  }

  Future<void> remove(String id) async {
    // Supprime l'install ET les cultures qui y sont reliées.
    final install = byId(id);
    if (install != null) {
      for (final cid in install.slotCultureIds) {
        if (cid != null) {
          await CultureService.instance.remove(cid);
        }
      }
    }
    final next = installs.value.where((i) => i.id != id).toList();
    await _persist(next);
  }

  HydroInstall? byId(String id) {
    for (final i in installs.value) {
      if (i.id == id) return i;
    }
    return null;
  }

  /// Trouve l'install qui contient une culture donnée. null si la
  /// culture n'est dans aucune install.
  HydroInstall? installForCulture(String cultureId) {
    for (final i in installs.value) {
      if (i.slotCultureIds.contains(cultureId)) return i;
    }
    return null;
  }

  /// Place une culture (déjà créée via [CultureService]) dans le
  /// premier slot vide d'une install. Si l'install est pleine, la
  /// culture reste créée mais non placée (à l'utilisateur de gérer).
  Future<void> placeCulture({
    required String installId,
    required String cultureId,
    int? atSlot,
  }) async {
    final install = byId(installId);
    if (install == null) return;
    final updated = atSlot == null
        ? install.placeCultureInFreeSlot(cultureId)
        : install.placeCultureAt(atSlot, cultureId);
    await update(updated);
  }

  Future<void> removeCultureFromInstall({
    required String installId,
    required String cultureId,
  }) async {
    final install = byId(installId);
    if (install == null) return;
    await update(install.removeCulture(cultureId));
  }

  Future<void> markFlushed(String installId) async {
    final install = byId(installId);
    if (install == null) return;
    await update(install.copyWith(lastFlushAt: DateTime.now()));
  }

  Future<void> _persist(List<HydroInstall> next) async {
    await PrefsService.instance
        .setHydroInstallsJson(HydroInstall.encodeAll(next));
    installs.value = next;
  }

  String _generateId() {
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36);
    return 'hi_${ts}_$rand';
  }
}
