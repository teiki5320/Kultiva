import 'dart:math';

import '../models/culture_entry.dart';
import 'error_reporter.dart';
import 'plantation_service.dart';
import 'prefs_service.dart';

/// Service du cahier de culture (suivi pleine terre).
/// Stockage local via SharedPreferences, notifie via
/// PrefsService.culturesVersion (pattern identique aux plantations).
///
/// ## Un seul dossier par plant (30/10/2026)
///
/// Avant, un même plant vivait dans deux registres qui ne se parlaient
/// pas : la `CultureEntry` du cahier portait ses propres `wateredAt`, et
/// la `Plantation` du Poussidex les siens. Arroser depuis le potager
/// carré ne comptait donc ni dans les statistiques du Poussidex, ni pour
/// les médailles, ni pour l'alerte d'arrosage — qui lit les plantations.
///
/// Désormais la chaîne est complète : **case de la grille → feuille de
/// culture → dossier du plant**. La `Plantation` est la référence (dates
/// d'arrosage, récoltes, photos, note) ; la `CultureEntry` ne garde que
/// ce qui lui est propre, la phase phénologique et les bornes du suivi.
/// `CultureEntry.wateredAt` n'est plus écrit : il ne subsiste que pour
/// relire les sauvegardes antérieures (voir [wateringsFor]).
class CultureService {
  CultureService._();
  static final CultureService instance = CultureService._();

  final Random _random = Random();

  /// Liste complète des cultures (actives + terminées).
  List<CultureEntry> loadAll() {
    return CultureEntry.decodeAll(PrefsService.instance.culturesJson);
  }

  /// Cultures actives (endedAt == null), les plus récentes en premier.
  List<CultureEntry> active() {
    final list = loadAll().where((c) => c.isActive).toList();
    list.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return list;
  }

  /// Cultures terminées, les plus récemment finies en premier.
  List<CultureEntry> ended() {
    final list = loadAll().where((c) => !c.isActive).toList();
    list.sort((a, b) =>
        (b.endedAt ?? b.startedAt).compareTo(a.endedAt ?? a.startedAt));
    return list;
  }

  /// Liste du cahier destinée à être **modifiée puis réécrite**, ou
  /// `null` si la sauvegarde est illisible.
  ///
  /// Les mutations partaient de `loadAll()`, qui renvoie une liste vide
  /// aussi bien pour un cahier vide que pour un cahier corrompu : la
  /// première modification réécrivait alors une liste d'un seul
  /// élément, effaçant tout le reste.
  List<CultureEntry>? _loadForWrite() {
    final list =
        CultureEntry.decodeAllOrNull(PrefsService.instance.culturesJson);
    if (list == null) {
      ErrorReporter.report(
        'cultures_decode',
        StateError('culturesJson illisible'),
        StackTrace.current,
      );
    }
    return list;
  }

  CultureEntry? byId(String id) {
    for (final c in loadAll()) {
      if (c.id == id) return c;
    }
    return null;
  }

  // ───────────────────────────────────────────────────────────────────────
  // Lecture des arrosages
  // ───────────────────────────────────────────────────────────────────────

  /// Arrosages réellement enregistrés pour [culture], du plus ancien au
  /// plus récent.
  ///
  /// Source de vérité : la [Plantation] liée. On retombe sur
  /// `culture.wateredAt` pour les sauvegardes écrites avant le
  /// rattachement, et si la plantation a été supprimée depuis le
  /// Poussidex — sinon l'historique disparaîtrait de l'écran sans que
  /// l'utilisateur comprenne pourquoi.
  List<DateTime> wateringsFor(CultureEntry culture) {
    final pid = culture.linkedPlantationId;
    if (pid != null) {
      final p = PlantationService.instance.byId(pid);
      if (p != null) return p.wateredAt;
    }
    return culture.wateredAt;
  }

  /// Dernier arrosage connu, ou null.
  DateTime? lastWateringFor(CultureEntry culture) {
    final all = wateringsFor(culture);
    return all.isEmpty ? null : all.last;
  }

  // ───────────────────────────────────────────────────────────────────────
  // Mutations
  // ───────────────────────────────────────────────────────────────────────

  /// Démarre une culture **et** le dossier de plant correspondant.
  ///
  /// Les deux naissent ensemble : un plant posé dans le potager carré
  /// est un plant de la collection, pas une entité parallèle.
  Future<CultureEntry> add({
    required String vegetableId,
    required DateTime startedAt,
    String? note,
    String? linkedPlantationId,
  }) async {
    var pid = linkedPlantationId;
    if (pid == null) {
      final plantation = await PlantationService.instance
          .add(vegetableId, plantedAt: startedAt);
      pid = plantation.id;
    }
    final entry = CultureEntry(
      id: _generateId(),
      vegetableId: vegetableId,
      startedAt: startedAt,
      note: note,
      linkedPlantationId: pid,
    );
    final list = _loadForWrite();
    if (list == null) return entry;
    await _persist(list..add(entry));
    return entry;
  }

  Future<void> update(CultureEntry updated) async {
    final list = _loadForWrite();
    if (list == null) return;
    final i = list.indexWhere((c) => c.id == updated.id);
    if (i == -1) return;
    list[i] = updated;
    await _persist(list);
  }

  /// Clôt la culture, et le plant avec elle.
  Future<void> endCulture(String id, {DateTime? at}) async {
    final when = at ?? DateTime.now();
    final list = _loadForWrite();
    if (list == null) return;
    final i = list.indexWhere((c) => c.id == id);
    if (i == -1) return;
    list[i] = list[i].copyWith(endedAt: when);
    await _persist(list);
    final pid = list[i].linkedPlantationId;
    if (pid != null) {
      await PlantationService.instance.terminate(pid, at: when);
    }
  }

  Future<void> reopen(String id) async {
    final list = _loadForWrite();
    if (list == null) return;
    final i = list.indexWhere((c) => c.id == id);
    if (i == -1) return;
    list[i] = list[i].copyWith(clearEndedAt: true);
    await _persist(list);
    final pid = list[i].linkedPlantationId;
    if (pid != null) {
      await PlantationService.instance.reopen(pid);
    }
  }

  /// Retire une culture du cahier.
  ///
  /// Le plant lié ne disparaît de la collection que s'il n'a aucune
  /// trace de vie (voir `PlantationService.removeIfPristine`) :
  /// réorganiser sa grille ne doit pas effacer un plant qu'on a soigné
  /// pendant des semaines.
  Future<void> remove(String id) async {
    final culture = byId(id);
    final list = _loadForWrite();
    if (list == null) return;
    await _persist(list..removeWhere((c) => c.id == id));
    final pid = culture?.linkedPlantationId;
    if (pid != null) {
      await PlantationService.instance.removeIfPristine(pid);
    }
  }

  /// Enregistre un arrosage à [at] (ou maintenant) pour une culture.
  /// No-op si la culture n'existe pas.
  Future<void> markWatered(String id, {DateTime? at}) async {
    final pid = await _plantationIdFor(id);
    if (pid == null) return;
    await PlantationService.instance.water(pid, at: at);
  }

  /// Arrose plusieurs cultures d'un coup (« Arroser tout » du potager
  /// carré) en une seule écriture de la collection.
  Future<int> markManyWatered(Iterable<String> ids, {DateTime? at}) async {
    final pids = <String>[];
    for (final id in ids) {
      final pid = await _plantationIdFor(id);
      if (pid != null) pids.add(pid);
    }
    await PlantationService.instance.waterMany(pids, at: at);
    return pids.length;
  }

  /// Rattache les cultures écrites avant le 30/10/2026 à un dossier de
  /// plant, en y versant leurs arrosages déjà saisis.
  ///
  /// Idempotent : une culture déjà liée est laissée telle quelle. À
  /// appeler une fois au démarrage, après `PlantationService.load()`.
  Future<void> linkLegacyEntries() async {
    final list = _loadForWrite();
    if (list == null) return;
    var changed = false;
    for (var i = 0; i < list.length; i++) {
      final c = list[i];
      if (c.linkedPlantationId != null) continue;
      final plantation = await PlantationService.instance.add(
        c.vegetableId,
        plantedAt: c.startedAt,
        wateredAt: c.wateredAt,
      );
      if (!c.isActive) {
        await PlantationService.instance
            .terminate(plantation.id, at: c.endedAt);
      }
      list[i] = c.copyWith(linkedPlantationId: plantation.id);
      changed = true;
    }
    if (changed) await _persist(list);
  }

  // ───────────────────────────────────────────────────────────────────────
  // Interne
  // ───────────────────────────────────────────────────────────────────────

  /// Identifiant du dossier de plant d'une culture, créé à la volée si
  /// la culture n'en a pas encore (entrée antérieure au rattachement que
  /// la migration n'aurait pas vue). Renvoie null si la culture est
  /// inconnue.
  Future<String?> _plantationIdFor(String cultureId) async {
    final list = _loadForWrite();
    if (list == null) return null;
    final i = list.indexWhere((c) => c.id == cultureId);
    if (i == -1) return null;
    final existing = list[i].linkedPlantationId;
    if (existing != null && PlantationService.instance.byId(existing) != null) {
      return existing;
    }
    final plantation = await PlantationService.instance.add(
      list[i].vegetableId,
      plantedAt: list[i].startedAt,
      wateredAt: list[i].wateredAt,
    );
    list[i] = list[i].copyWith(linkedPlantationId: plantation.id);
    await _persist(list);
    return plantation.id;
  }

  Future<void> _persist(List<CultureEntry> list) async {
    await PrefsService.instance.setCulturesJson(CultureEntry.encodeAll(list));
  }

  String _generateId() {
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36);
    return 'cul_${ts}_$rand';
  }
}
