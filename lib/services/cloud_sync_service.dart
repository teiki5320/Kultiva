import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/plantation.dart';
import 'auth_service.dart';
import 'prefs_service.dart';

/// Service de synchro cloud entre le Poussidex local (shared_preferences)
/// et Supabase.
///
/// Stratégie : **local-first**. L'app fonctionne offline comme avant ;
/// dès qu'une session Supabase est présente, chaque save est aussi
/// uploadé vers le cloud en best-effort. Au login, on tire le cloud et
/// on fusionne avec le local en conservant la version la plus récente
/// (last-write-wins via `updated_at`).
class CloudSyncService {
  CloudSyncService._();
  static final CloudSyncService instance = CloudSyncService._();

  SupabaseClient get _client => Supabase.instance.client;

  bool get _signedIn => AuthService.instance.isSignedIn;
  String? get _userId => _client.auth.currentUser?.id;

  /// Upload l'état complet des plantations locales vers le cloud.
  /// Utilise `upsert` pour créer ou mettre à jour les enregistrements
  /// par ID. Fire-and-forget : ne bloque pas l'UI.
  Future<void> uploadAllPlantations(List<Plantation> plantations) async {
    if (!_signedIn) return;
    final uid = _userId;
    if (uid == null) return;
    try {
      if (plantations.isEmpty) {
        // Rien à uploader — on pourrait vouloir vider les lignes cloud
        // restantes, mais c'est le rôle de deletePlantation().
        return;
      }
      final rows = plantations.map((p) => _toRow(p, uid)).toList();
      await _client.from('plantations').upsert(rows);
    } catch (e) {
      if (kDebugMode) debugPrint('CloudSync.uploadAll error: $e');
    }
  }

  /// Supprime une plantation du cloud (RLS garantit qu'on ne touche
  /// que celles de l'utilisateur courant).
  Future<void> deletePlantation(String id) async {
    if (!_signedIn) return;
    try {
      await _client.from('plantations').delete().eq('id', id);
    } catch (e) {
      if (kDebugMode) debugPrint('CloudSync.delete error: $e');
    }
  }

  /// Télécharge toutes les plantations du cloud pour l'utilisateur
  /// courant. Retourne une liste vide si offline / pas loggé / erreur.
  Future<List<Plantation>> fetchPlantations() async {
    if (!_signedIn) return <Plantation>[];
    try {
      final data = await _client.from('plantations').select();
      return data.map<Plantation>(_fromRow).toList();
    } catch (e) {
      if (kDebugMode) debugPrint('CloudSync.fetch error: $e');
      return <Plantation>[];
    }
  }

  /// À appeler juste après un login réussi. Fusionne les plantations
  /// locales avec celles du cloud :
  ///  - Si une plantation existe uniquement côté local → upload vers cloud.
  ///  - Si elle existe uniquement côté cloud → ajouter au local.
  ///  - Si elle existe des 2 côtés → conserver la plus récente.
  /// Écrit le résultat dans shared_preferences et retourne la liste
  /// mergée pour que l'UI puisse recharger.
  Future<List<Plantation>> mergeOnLogin() async {
    if (!_signedIn) {
      return Plantation.decodeAll(PrefsService.instance.plantationsJson);
    }

    final local =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    final cloud = await fetchPlantations();

    // Index par ID pour fusion rapide.
    final merged = <String, Plantation>{};
    for (final p in local) {
      merged[p.id] = p;
    }
    for (final p in cloud) {
      final existing = merged[p.id];
      if (existing == null) {
        merged[p.id] = p;
      } else {
        // Last-write-wins : on garde celui qui a le plus de données
        // (plus de récoltes / arrosages / photos). C'est une heuristique
        // raisonnable tant qu'on n'a pas un champ updated_at côté
        // Plantation — à raffiner plus tard.
        final pick = _pickLatest(existing, p);
        merged[p.id] = pick;
      }
    }

    final result = merged.values.toList();
    // Persiste localement le merge.
    await PrefsService.instance
        .setPlantationsJson(Plantation.encodeAll(result));
    // Upload tout — garantit que le cloud est aligné avec le merge.
    await uploadAllPlantations(result);

    return result;
  }

  /// Vide TOUTES les données locales (plantations, badges, prefs).
  /// À appeler au sign-out pour éviter qu'un autre compte se retrouve
  /// avec les données du précédent.
  Future<void> clearLocalData() async {
    await PrefsService.instance.setPlantationsJson('[]');
    await PrefsService.instance.setUnlockedBadges(<String>{});
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  Map<String, dynamic> _toRow(Plantation p, String userId) {
    return <String, dynamic>{
      'id': p.id,
      'user_id': userId,
      'vegetable_id': p.vegetableId,
      'planted_at': p.plantedAt.toIso8601String(),
      'harvested_at': p.harvestedAt?.toIso8601String(),
      'harvest_count': p.harvestCount,
      'watered_at':
          p.wateredAt.map((d) => d.toIso8601String()).toList(),
      'note': p.note,
      // On n'upload PAS le chemin local des photos : c'est un path
      // filesystem (/var/mobile/...) qui n'a aucun sens sur un autre
      // device. Les photos seront uploadées dans Supabase Storage au
      // chunk 9c, avec des URLs publiques qui remplaceront ces paths.
      'photo_paths': const <String>[],
    };
  }

  Plantation _fromRow(Map<String, dynamic> row) {
    final watered = (row['watered_at'] as List?) ?? const <dynamic>[];
    final photos = (row['photo_paths'] as List?) ?? const <dynamic>[];
    return Plantation(
      id: row['id'] as String,
      vegetableId: row['vegetable_id'] as String,
      plantedAt: DateTime.parse(row['planted_at'] as String),
      harvestedAt: row['harvested_at'] == null
          ? null
          : DateTime.parse(row['harvested_at'] as String),
      harvestCount: (row['harvest_count'] as int?) ?? 0,
      wateredAt: watered
          .map((e) => DateTime.parse(e as String))
          .toList(),
      note: row['note'] as String?,
      photoPaths: photos.map((e) => e as String).toList(),
    );
  }

  /// Choisit la version la plus "récente" entre 2 plantations ayant le
  /// même ID. Heuristique : plus de récoltes + plus d'arrosages gagne.
  Plantation _pickLatest(Plantation a, Plantation b) {
    final scoreA = a.harvestCount + a.wateredAt.length;
    final scoreB = b.harvestCount + b.wateredAt.length;
    if (scoreB > scoreA) return b;
    if (scoreA > scoreB) return a;
    // Égalité : on prend celui avec la dernière action (arrosage le
    // plus récent, ou planté le plus récemment).
    final lastA = a.wateredAt.isNotEmpty ? a.wateredAt.last : a.plantedAt;
    final lastB = b.wateredAt.isNotEmpty ? b.wateredAt.last : b.plantedAt;
    return lastB.isAfter(lastA) ? b : a;
  }
}
