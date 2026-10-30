import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/plantation.dart';
import 'photo_service.dart';
import 'prefs_service.dart';

/// Propriétaire unique des mutations du Poussidex.
///
/// Avant, aucun service ne possédait les plantations : seules une
/// migration unique depuis l'ancienne grille et la synchro cloud
/// écrivaient `plantationsJson`. Il n'existait donc **aucun moyen, dans
/// l'app, d'ajouter un plant, de l'arroser ou de le récolter** — alors
/// que la fiche App Store le promet en titre.
///
/// Tout passe par ici : on lit l'état, on le modifie, on le persiste. Les
/// comptes ayant été retirés de la v1, il n'y a plus de cloud : les
/// plantations et leurs photos vivent uniquement sur l'appareil.
class PlantationService extends ChangeNotifier {
  PlantationService._();
  static final PlantationService instance = PlantationService._();

  static final Random _rng = Random();

  List<Plantation> _plantations = <Plantation>[];

  /// Plantations connues, de la plus récente à la plus ancienne.
  List<Plantation> get all => List<Plantation>.unmodifiable(_plantations);

  /// Plantations encore en cours (non récoltées définitivement).
  List<Plantation> get active =>
      _plantations.where((p) => p.isActive).toList(growable: false);

  /// À appeler une fois au démarrage.
  ///
  /// S'abonne ensuite à `plantationsVersion` pour se recaler quand les
  /// plantations sont réécrites **ailleurs** — typiquement la fusion
  /// cloud après une connexion, ou la purge au sign-out. Sans ça, le
  /// service aurait gardé la copie d'avant la fusion et l'écran aurait
  /// affiché une collection périmée.
  void load() {
    _reload();
    PrefsService.instance.plantationsVersion.removeListener(_onStoreChanged);
    PrefsService.instance.plantationsVersion.addListener(_onStoreChanged);
  }

  void _onStoreChanged() {
    // Nos propres écritures bumpent aussi la version : on ne recharge que
    // si le magasin dit autre chose que ce qu'on a en mémoire, sinon on
    // bouclerait.
    final stored = PrefsService.instance.plantationsJson ?? '';
    if (stored == Plantation.encodeAll(_plantations)) return;
    _reload();
  }

  void _reload() {
    _plantations = Plantation.decodeAll(PrefsService.instance.plantationsJson)
      ..sort((a, b) => b.plantedAt.compareTo(a.plantedAt));
    notifyListeners();
  }

  Plantation? byId(String id) {
    for (final p in _plantations) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Combien de fois cette espèce a été cultivée — c'est ce décompte qui
  /// alimente les médailles bronze / argent / or.
  int countFor(String vegetableId) =>
      _plantations.where((p) => p.vegetableId == vegetableId).length;

  // ───────────────────────────────────────────────────────────────────────
  // Mutations
  // ───────────────────────────────────────────────────────────────────────

  /// Ajoute un plant à la collection. [plantedAt] permet de saisir une
  /// mise en terre passée ; par défaut, maintenant.
  Future<Plantation> add(String vegetableId, {DateTime? plantedAt}) async {
    final now = DateTime.now();
    final plantation = Plantation(
      // Même forme d'identifiant que la migration : horodatage + aléa,
      // suffisant pour être unique sans dépendre d'un paquet d'uuid.
      id: '${now.millisecondsSinceEpoch}_${_rng.nextInt(99999)}',
      vegetableId: vegetableId,
      plantedAt: plantedAt ?? now,
    );
    _plantations = <Plantation>[plantation, ..._plantations];
    await _persist();
    return plantation;
  }

  /// Enregistre un arrosage. C'est le geste le plus fréquent de l'app :
  /// il doit laisser une trace, sinon l'historique du plant est faux.
  Future<void> water(String id, {DateTime? at}) =>
      _update(id, (p) => p.copyWith(
            wateredAt: <DateTime>[...p.wateredAt, at ?? DateTime.now()],
          ));

  /// Incrémente le compteur de récoltes **sans** clore la culture : une
  /// tomate se récolte plusieurs fois.
  Future<void> harvest(String id) =>
      _update(id, (p) => p.copyWith(harvestCount: p.harvestCount + 1));

  /// Clôt la culture (fin de saison, plant arraché). Le plant reste dans
  /// la collection et continue de compter pour les médailles.
  Future<void> terminate(String id, {DateTime? at}) =>
      _update(id, (p) => p.copyWith(harvestedAt: at ?? DateTime.now()));

  /// Rouvre une culture close par erreur.
  Future<void> reopen(String id) =>
      _update(id, (p) => p.copyWith(clearHarvestedAt: true));

  Future<void> setNote(String id, String? note) {
    final clean = note?.trim();
    final empty = clean == null || clean.isEmpty;
    return _update(
      id,
      (p) => p.copyWith(note: empty ? null : clean, clearNote: empty),
    );
  }

  Future<void> addPhoto(String id, String path) =>
      _update(id, (p) => p.copyWith(
            photoPaths: <String>[...p.photoPaths, path],
          ));

  /// Retire une photo du plant et supprime le fichier local.
  ///
  /// Un chemin en `http` ne peut venir que d'une ancienne installation,
  /// du temps où les photos étaient aussi montées dans le cloud : on le
  /// retire de la liste, il n'y a plus de fichier local à effacer.
  Future<void> removePhoto(String id, String path) async {
    await _update(id, (p) => p.copyWith(
          photoPaths: p.photoPaths.where((s) => s != path).toList(),
        ));
    if (!path.startsWith('http')) {
      await PhotoService.deleteFile(path);
    }
  }

  /// Retire un plant de la collection, ses photos locales avec lui.
  Future<void> remove(String id) async {
    final plantation = byId(id);
    _plantations = _plantations.where((p) => p.id != id).toList();
    await _persist();
    if (plantation == null) return;
    for (final path in plantation.photoPaths) {
      if (!path.startsWith('http')) {
        await PhotoService.deleteFile(path);
      }
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Interne
  // ───────────────────────────────────────────────────────────────────────

  Future<void> _update(
    String id,
    Plantation Function(Plantation) transform,
  ) async {
    var touched = false;
    _plantations = _plantations.map((p) {
      if (p.id != id) return p;
      touched = true;
      return transform(p);
    }).toList();
    if (!touched) return;
    await _persist();
  }

  Future<void> _persist() async {
    // On maintient l'invariant « du plus récent au plus ancien » ici, et
    // pas seulement à la lecture : `add` accepte une date de mise en
    // terre passée, qui ne va pas forcément en tête.
    _plantations = <Plantation>[..._plantations]
      ..sort((a, b) => b.plantedAt.compareTo(a.plantedAt));
    await PrefsService.instance
        .setPlantationsJson(Plantation.encodeAll(_plantations));
    notifyListeners();
  }
}
