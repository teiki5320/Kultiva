import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/news_item.dart';

/// Service local-first pour les actualités Kultiva.
///
/// Lit la table Supabase `news_items` quand une connexion est dispo,
/// puis cache la liste en SharedPreferences pour rester offline-friendly.
/// Cohérent avec le contrat local-first du reste de Kultiva.
class NewsService {
  NewsService._();
  static final NewsService instance = NewsService._();

  static const String _cacheKey = 'news_items_cache_v1';

  /// Liste réactive triée par date de publication décroissante.
  final ValueNotifier<List<NewsItem>> items =
      ValueNotifier<List<NewsItem>>(<NewsItem>[]);

  /// Charge depuis le cache local immédiatement, puis en arrière-plan
  /// rafraîchit depuis Supabase (silencieusement si réseau absent).
  Future<void> load() async {
    await _loadFromCache();
    // Rafraîchissement en arrière-plan, ne bloque pas l'UI.
    _refreshFromSupabase();
  }

  Future<void> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cacheKey);
      if (raw == null || raw.isEmpty) return;
      final list = (jsonDecode(raw) as List<dynamic>)
          .map((e) => NewsItem.fromJson(e as Map<String, dynamic>))
          .toList();
      items.value = list;
    } catch (_) {
      // Cache corrompu → on ignore.
    }
  }

  Future<void> _refreshFromSupabase() async {
    try {
      final client = Supabase.instance.client;
      final rows = await client
          .from('news_items')
          .select()
          .order('priority', ascending: false)
          .order('published_at', ascending: false)
          .limit(50);
      final list = (rows as List<dynamic>)
          .map((e) => NewsItem.fromJson(e as Map<String, dynamic>))
          .toList();
      items.value = list;
      // Persister le cache.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _cacheKey,
        jsonEncode(rows),
      );
    } catch (_) {
      // Pas de réseau ou Supabase indispo → on garde le cache.
    }
  }

  /// Force un rafraîchissement (pull-to-refresh côté UI).
  Future<void> refresh() => _refreshFromSupabase();
}
