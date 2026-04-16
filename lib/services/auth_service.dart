import 'dart:async';

import 'package:flutter/foundation.dart';

import 'prefs_service.dart';

/// Service d'authentification — v1 locale (email + mot de passe).
///
/// Valide les emails localement et persiste la session via
/// [PrefsService]. Les flows Google/Apple/Supabase ont été retirés en
/// v1 (ils étaient des stubs qui renvoyaient un compte fake). Quand un
/// backend réel sera branché :
///   1. Ajoute `supabase_flutter` dans pubspec.yaml.
///   2. Initialise `Supabase.initialize(...)` dans main.dart.
///   3. Remplace [signInWithEmail] par `Supabase.instance.client.auth.
///      signInWithPassword(...)`.
///   4. Pour Google/Apple, ajoute `google_sign_in` + `sign_in_with_apple`
///      et utilise `signInWithIdToken`.
class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  String? _email;
  String? _name;

  String? get email => _email;
  String? get name => _name;
  bool get isSignedIn => _email != null;

  Future<void> load() async {
    _email = PrefsService.instance.authEmail;
    _name = PrefsService.instance.authName;
    notifyListeners();
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || !email.contains('@')) {
      throw const AuthException("Email invalide");
    }
    if (password.length < 6) {
      throw const AuthException(
          "Mot de passe trop court (6 caractères min.)");
    }
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _email = email.trim();
    _name ??= _email!.split('@').first;
    await PrefsService.instance.setAuth(email: _email, name: _name);
    notifyListeners();
  }

  Future<void> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      throw const AuthException("Le nom est requis");
    }
    await signInWithEmail(email: email, password: password);
    _name = name.trim();
    await PrefsService.instance.setAuth(email: _email, name: _name);
    notifyListeners();
  }

  Future<void> signOut() async {
    _email = null;
    _name = null;
    await PrefsService.instance.setAuth(email: null, name: null);
    notifyListeners();
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
