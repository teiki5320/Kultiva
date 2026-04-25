import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Type de système hydroponique partagé.
enum HydroSystemType {
  dwc('dwc', 'DWC (Deep Water Culture)', '🪣'),
  nft('nft', 'NFT (Nutrient Film Technique)', '〰️'),
  kratky('kratky', 'Kratky (passif)', '💧'),
  ebbFlow('ebbFlow', 'Ebb & Flow (marée)', '🌊'),
  drip('drip', 'Goutte-à-goutte', '💦'),
  aero('aero', 'Aéroponie', '💨'),
  other('other', 'Autre / DIY', '🛠️');

  final String id;
  final String label;
  final String emoji;
  const HydroSystemType(this.id, this.label, this.emoji);

  static HydroSystemType fromId(String? id) {
    return HydroSystemType.values.firstWhere(
      (s) => s.id == id,
      orElse: () => HydroSystemType.other,
    );
  }
}

/// Un build partagé : installation complète d'un utilisateur.
class HydroBuild {
  final String id;
  final String userId;
  final String userName;
  final HydroSystemType systemType;
  final List<String> equipment;
  final String? photoUrl;
  final String? caption;
  final String? vegetableId;
  final int likesCount;
  final bool likedByMe;
  final DateTime createdAt;

  const HydroBuild({
    required this.id,
    required this.userId,
    required this.userName,
    required this.systemType,
    required this.equipment,
    this.photoUrl,
    this.caption,
    this.vegetableId,
    required this.likesCount,
    required this.likedByMe,
    required this.createdAt,
  });
}

class HydroBuildService {
  HydroBuildService._();
  static final HydroBuildService instance = HydroBuildService._();

  SupabaseClient get _client => Supabase.instance.client;
  String? get _userId => _client.auth.currentUser?.id;

  /// Publie un nouveau build. Throw si pas de session.
  Future<void> publish({
    required HydroSystemType systemType,
    required List<String> equipment,
    String? photoUrl,
    String? caption,
    String? vegetableId,
  }) async {
    final uid = _userId;
    if (uid == null) {
      throw Exception('Pas de session Supabase active');
    }
    await _client.from('hydro_builds').insert(<String, dynamic>{
      'user_id': uid,
      'system_type': systemType.id,
      'equipment': equipment,
      'photo_url': photoUrl,
      'caption': caption,
      'vegetable_id': vegetableId,
    });
  }

  Future<List<HydroBuild>> fetchAll({
    int limit = 30,
    HydroSystemType? filterSystem,
  }) async {
    final uid = _userId;
    try {
      var q = _client.from('hydro_builds').select(
            '*, profiles(display_name)',
          );
      if (filterSystem != null) {
        q = q.eq('system_type', filterSystem.id);
      }
      final data =
          await q.order('created_at', ascending: false).limit(limit);

      final Set<String> myLikes;
      if (uid != null) {
        final likesData = await _client
            .from('hydro_build_likes')
            .select('build_id')
            .eq('user_id', uid);
        myLikes = likesData
            .map<String>((row) => row['build_id'] as String)
            .toSet();
      } else {
        myLikes = const <String>{};
      }

      return data.map<HydroBuild>((row) {
        final profile = row['profiles'] as Map<String, dynamic>?;
        final equipRaw = row['equipment'];
        final equip = equipRaw is List
            ? equipRaw.map((e) => e.toString()).toList()
            : <String>[];
        return HydroBuild(
          id: row['id'] as String,
          userId: row['user_id'] as String,
          userName:
              (profile?['display_name'] as String?) ?? 'Jardinier·ère',
          systemType: HydroSystemType.fromId(row['system_type'] as String?),
          equipment: equip,
          photoUrl: row['photo_url'] as String?,
          caption: row['caption'] as String?,
          vegetableId: row['vegetable_id'] as String?,
          likesCount: (row['likes_count'] as int?) ?? 0,
          likedByMe: myLikes.contains(row['id']),
          createdAt: DateTime.parse(row['created_at'] as String),
        );
      }).toList();
    } catch (e) {
      if (kDebugMode) debugPrint('HydroBuildService.fetchAll error: $e');
      return <HydroBuild>[];
    }
  }

  Future<bool> toggleLike(String buildId, {required bool currentlyLiked}) async {
    final uid = _userId;
    if (uid == null) return currentlyLiked;
    try {
      if (currentlyLiked) {
        await _client
            .from('hydro_build_likes')
            .delete()
            .eq('user_id', uid)
            .eq('build_id', buildId);
        return false;
      } else {
        await _client.from('hydro_build_likes').insert(<String, dynamic>{
          'user_id': uid,
          'build_id': buildId,
        });
        return true;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('HydroBuildService.toggleLike error: $e');
      return currentlyLiked;
    }
  }

  Future<void> delete(String buildId) async {
    try {
      await _client.from('hydro_builds').delete().eq('id', buildId);
    } catch (e) {
      if (kDebugMode) debugPrint('HydroBuildService.delete error: $e');
    }
  }
}
