import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    hide AuthException;
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../config/supabase_config.dart';

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

  /// Connexion Google via OAuth natif. L'utilisateur voit la feuille
  /// Google → on récupère un idToken → on l'échange avec Supabase
  /// pour créer/récupérer la session.
  ///
  /// Prérequis :
  ///  - Google Cloud Console : créer un OAuth Client iOS (pour l'app)
  ///    + un OAuth Client Web (pour l'échange Supabase).
  ///  - Supabase Dashboard → Authentication → Providers → Google :
  ///    activer et coller le Client ID + Secret du Web client.
  ///  - ios/Runner/Info.plist : ajouter le REVERSED_CLIENT_ID du
  ///    Client iOS comme URL scheme.
  Future<void> signInWithGoogle() async {
    final serverClientId = GoogleOAuthConfig.webClientId;
    if (serverClientId == null) {
      throw const AuthException(
        'Google Sign-In pas encore configuré — renseigne le Web '
        'Client ID dans lib/config/supabase_config.dart.',
      );
    }
    try {
      final googleUser = await GoogleSignIn(
        // clientId = iOS Client ID (pour ouvrir la feuille Google native).
        // serverClientId = Web Client ID (pour que Google renvoie un
        // idToken que Supabase peut valider).
        clientId: GoogleOAuthConfig.iosClientId,
        serverClientId: serverClientId,
      ).signIn();
      if (googleUser == null) {
        // L'utilisateur a annulé.
        return;
      }
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;
      if (idToken == null) {
        throw const AuthException(
          'Google n\'a pas renvoyé d\'identifiant valide.',
        );
      }
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      notifyListeners();
    } on sb.AuthException catch (e) {
      throw AuthException(_friendlyError(e));
    } catch (e) {
      throw AuthException('Connexion Google échouée : $e');
    }
  }

  /// Connexion Apple via Sign in with Apple (iOS natif ou web fallback).
  /// Fonctionne uniquement sur iOS 13+ et macOS. Sur Android tu peux
  /// utiliser la même méthode via un webAuthenticationOptions, mais
  /// c'est moins fluide — on recommande de cacher le bouton Apple sur
  /// Android.
  ///
  /// Prérequis :
  ///  - Apple Developer : activer "Sign in with Apple" sur l'App ID,
  ///    créer un Service ID + une Key Sign In with Apple.
  ///  - Xcode : ajouter la capability "Sign In with Apple".
  ///  - Supabase Dashboard → Authentication → Providers → Apple :
  ///    activer et renseigner Services ID + Team ID + Key + Key ID.
  Future<void> signInWithApple() async {
    try {
      // Nonce aléatoire : on envoie sha256(raw) à Apple, et on donne
      // le raw à Supabase pour qu'il vérifie le lien. Sans ça, Apple
      // refuse parfois de nous renvoyer un idToken utilisable.
      final rawNonce = _generateNonce();
      final hashedNonce = _sha256(rawNonce);

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
      final idToken = credential.identityToken;
      if (idToken == null) {
        throw const AuthException(
          'Apple n\'a pas renvoyé d\'identifiant valide.',
        );
      }
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      // Apple ne renvoie le nom qu'au tout premier login — on le
      // persiste dans user_metadata pour pouvoir l'afficher plus tard.
      final first = credential.givenName;
      final last = credential.familyName;
      if (first != null || last != null) {
        final displayName = [first, last]
            .where((e) => e != null && e.trim().isNotEmpty)
            .join(' ');
        if (displayName.isNotEmpty) {
          await _client.auth.updateUser(
            UserAttributes(
              data: <String, dynamic>{'display_name': displayName},
            ),
          );
        }
      }
      notifyListeners();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return;
      throw AuthException('Connexion Apple refusée : ${e.message}');
    } on sb.AuthException catch (e) {
      throw AuthException(_friendlyError(e));
    } catch (e) {
      throw AuthException('Connexion Apple échouée : $e');
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

  /// Génère un nonce cryptographique aléatoire (32 caractères base-36).
  String _generateNonce() {
    final rand = Random.secure();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._';
    return List.generate(32, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  /// SHA-256 en hex (requis par Apple Sign-In).
  String _sha256(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
