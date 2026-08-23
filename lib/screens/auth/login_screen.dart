import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/supabase_config.dart';
import '../../services/auth_service.dart';
import '../../services/cloud_sync_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignedIn;

  /// Appelé quand l'utilisateur choisit « Continuer sans compte ».
  /// Optionnel : quand l'écran est ouvert depuis les Paramètres pour se
  /// connecter, on ne propose pas de repartir en invité.
  final VoidCallback? onContinueAsGuest;

  const LoginScreen({
    super.key,
    required this.onSignedIn,
    this.onContinueAsGuest,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await _runAuth(() => AuthService.instance.signInWithEmail(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        ));
  }

  Future<void> _signInWithGoogle() =>
      _runAuth(AuthService.instance.signInWithGoogle);

  Future<void> _signInWithApple() =>
      _runAuth(AuthService.instance.signInWithApple);

  /// Exécute l'action d'auth donnée, gère loading/erreur/sync cloud.
  Future<void> _runAuth(Future<void> Function() action) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await action();
      // Vérifie qu'on est bien loggé (l'user peut annuler un flow OAuth).
      if (!AuthService.instance.isSignedIn) return;
      // On quitte le mode invité : l'utilisateur a désormais un compte.
      await PrefsService.instance.setGuestMode(false);
      // Contrat local-first : on navigue tout de suite, la synchro cloud
      // (plantations + badges + prefs + photos) tourne en arrière-plan
      // et ne bloque pas l'écran de connexion sur un réseau lent.
      unawaited(CloudSyncService.instance.syncAllOnLogin());
      if (mounted) widget.onSignedIn();
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Mode invité : on mémorise le choix et on entre dans l'app. Rien ne
  /// part vers le cloud tant qu'aucun compte n'existe — tout reste en
  /// local, conformément au contrat local-first.
  Future<void> _continueAsGuest() async {
    await PrefsService.instance.setGuestMode(true);
    if (mounted) widget.onContinueAsGuest?.call();
  }

  /// Sign in with Apple n'a de sens que sur iOS / macOS natifs.
  /// Ailleurs on masque le bouton.
  bool get _showAppleButton => !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  /// Le bouton Google s'affiche dès qu'un Web Client ID a été
  /// configuré dans SupabaseConfig. Sinon on le cache pour ne pas
  /// promettre une feature qui ne marche pas.
  bool get _showGoogleButton => GoogleOAuthConfig.webClientId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          children: <Widget>[
            const SizedBox(height: 16),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  'assets/images/onboarding_1.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: KultivaColors.lightGreen.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    alignment: Alignment.center,
                    child: const Text('🌱', style: TextStyle(fontSize: 60)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Bon retour !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Connecte-toi pour retrouver ton jardin',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Email requis';
                      }
                      if (!v.contains('@')) return 'Email invalide';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 6) {
                        return '6 caractères minimum';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            if (_error != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Se connecter'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _loading
                  ? null
                  : () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => RegisterScreen(
                            onSignedIn: widget.onSignedIn,
                          ),
                        ),
                      ),
              child: const Text("Créer un compte"),
            ),
            if (_showGoogleButton || _showAppleButton) ...<Widget>[
              const SizedBox(height: 20),
              const _OrSeparator(),
              const SizedBox(height: 16),
              if (_showGoogleButton) ...<Widget>[
                OutlinedButton.icon(
                  onPressed: _loading ? null : _signInWithGoogle,
                  icon: const Text('🇬', style: TextStyle(fontSize: 18)),
                  label: const Text('Continuer avec Google'),
                ),
                const SizedBox(height: 10),
              ],
              if (_showAppleButton)
                OutlinedButton.icon(
                  onPressed: _loading ? null : _signInWithApple,
                  icon: const Icon(Icons.apple, size: 20),
                  label: const Text('Continuer avec Apple'),
                ),
            ],
            if (widget.onContinueAsGuest != null) ...<Widget>[
              const SizedBox(height: 24),
              TextButton(
                onPressed: _loading ? null : _continueAsGuest,
                child: const Text(
                  'Continuer sans compte',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Le calendrier, le catalogue, ton potager et les tutos '
                'fonctionnent sans compte, hors connexion. Le compte sert '
                'à sauvegarder ton jardin et à rejoindre la communauté.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: KultivaColors.textSecondary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: KultivaColors.lightGreen.withValues(alpha: 0.6),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'ou',
            style: TextStyle(color: KultivaColors.textSecondary),
          ),
        ),
        Expanded(
          child: Divider(
            color: KultivaColors.lightGreen.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
