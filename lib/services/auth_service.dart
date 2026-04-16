import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    hide AuthException;
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Service d'authentification — branché sur Supabase.
///
/// Les sessions sont persistées automatiquement par supabase_flutter
/// (via flutter_secure_storage sur iOS/Android). On écoute
/// `onAuthStateChange` pour garder le state du service synchro avec
/// les login/logout qui se produisent ailleurs (OAuth redirect, etc.).
class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  SupabaseClient get _client => Supabase.instance.client;

  StreamSubscription<AuthState>? _authSub;

  /// Session courante (null si déconnecté).
  Session? get session => _client.auth.currentSession;

  /// Email de l'utilisateur connecté, ou null.
  String? get email => _client.auth.currentUser?.email;

  /// Nom d'affichage (tiré des user_metadata ou dérivé de l'email).
  String? get name {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final meta = user.userMetadata ?? const <String, dynamic>{};
    final n = meta['display_name'] as String?;
    if (n != null && n.isNotEmpty) return n;
    // Fallback : partie avant le @ de l'email.
    return user.email?.split('@').first;
  }

  /// true si une session Supabase est active.
  bool get isSignedIn => _client.auth.currentSession != null;

  /// À appeler au démarrage de l'app (après Supabase.initialize).
  /// S'abonne aux changements de session pour pousser les updates à
  /// l'UI (ex: login depuis OAuth redirect).
  Future<void> load() async {
    _authSub ??= _client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
    notifyListeners();
  }

  /// Inscription email/password. Supabase envoie un email de
  /// confirmation si le projet a la confirmation activée (par défaut).
  /// Pour un onboarding fluide, on peut désactiver la confirmation
  /// dans Supabase Dashboard → Authentication → Providers → Email.
  Future<void> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      throw const AuthException('Le nom est requis');
    }
    _validateEmail(email);
    _validatePassword(password);
    try {
      final res = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: <String, dynamic>{'display_name': name.trim()},
      );
      if (res.user == null) {
        throw const AuthException(
          'Inscription échouée — vérifie tes identifiants.',
        );
      }
      notifyListeners();
    } on sb.AuthException catch (e) {
      throw AuthException(_friendlyError(e));
    }
  }

  /// Connexion email/password classique.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _validateEmail(email);
    _validatePassword(password);
    try {
      final res = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (res.session == null) {
        throw const AuthException(
          'Connexion échouée — vérifie tes identifiants.',
        );
      }
      notifyListeners();
    } on sb.AuthException catch (e) {
      throw AuthException(_friendlyError(e));
    }
  }

  /// Déconnexion — efface la session locale.
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (_) {
      // On ignore — signOut() peut échouer s'il n'y a pas de réseau
      // mais la session locale sera quand même invalidée.
    }
    notifyListeners();
  }

  // ─────────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────────

  void _validateEmail(String email) {
    final e = email.trim();
    if (e.isEmpty || !e.contains('@') || !e.contains('.')) {
      throw const AuthException('Email invalide');
    }
  }

  void _validatePassword(String password) {
    if (password.length < 6) {
      throw const AuthException(
          'Mot de passe trop court (6 caractères min.)');
    }
  }

  /// Traduit les messages d'erreur Supabase en français + convivial.
  String _friendlyError(sb.AuthException e) {
    final msg = e.message.toLowerCase();
    if (msg.contains('invalid login') ||
        msg.contains('invalid credentials')) {
      return 'Email ou mot de passe incorrect.';
    }
    if (msg.contains('user already registered')) {
      return 'Un compte existe déjà avec cet email.';
    }
    if (msg.contains('email not confirmed')) {
      return 'Email non confirmé — vérifie ta boîte mail.';
    }
    if (msg.contains('network')) {
      return 'Pas de connexion internet.';
    }
    return e.message;
  }
}

/// Exception levée par [AuthService] avec un message user-friendly.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
