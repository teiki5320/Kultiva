import 'package:flutter/material.dart';

import '../../models/country.dart';
import '../../models/region_data.dart';
import '../../services/audio_service.dart';
import '../../services/auth_service.dart';
import '../../services/cloud_sync_service.dart';
import '../../services/geolocation_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../home/tuto_fiche_screen.dart';
import 'my_garden_screen.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onSignOut;
  const SettingsScreen({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    // Scaffold indispensable : sans lui la page s'affiche sur fond noir
    // et les SnackBars (détection pays, suppression de compte…) sont
    // rendues derrière la route opaque, donc invisibles.
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            AppBar(title: const Text('Paramètres')),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: <Widget>[
                  const _SectionTitle(title: '🌍  Pays'),
                  Card(
                    child: ValueListenableBuilder<Country?>(
                      valueListenable: PrefsService.instance.country,
                      builder: (context, country, _) {
                        final region = PrefsService.instance.region.value;
                        final effective = country ??
                            (region == Region.france ? Country.france : null);
                        return RadioGroup<Country>(
                          groupValue: effective,
                          onChanged: (v) {
                            if (v != null) {
                              PrefsService.instance.setCountry(v);
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              // Ordre alphabétique : aucun pays n'est
                              // privilégié (le pays courant est coché).
                              for (final (i, c)
                                  in Country.ordered().indexed) ...<Widget>[
                                if (i > 0) const Divider(height: 0, indent: 16),
                                RadioListTile<Country>(
                                  value: c,
                                  title: Text(
                                    '${c.flag}   ${c.label}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  activeColor: KultivaColors.primaryGreen,
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final country =
                              await GeolocationService.detectCountry();
                          if (!context.mounted) return;
                          if (country != null) {
                            PrefsService.instance.setCountry(country);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Pays détecté : ${country.flag} ${country.label}',
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Impossible de détecter ton pays. Vérifie tes permissions de localisation.',
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.my_location),
                        label: const Text('Détecter mon pays automatiquement'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle(title: '🔔  Notifications'),
                  Card(
                    child: Column(
                      children: <Widget>[
                        ValueListenableBuilder<bool>(
                          valueListenable: PrefsService.instance.notifications,
                          builder: (context, value, _) {
                            return SwitchListTile(
                              value: value,
                              onChanged: PrefsService.instance.setNotifications,
                              activeThumbColor: KultivaColors.primaryGreen,
                              title: const Text(
                                'Rappel mensuel',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "Une notification le 1er de chaque mois",
                              ),
                            );
                          },
                        ),
                        const Divider(height: 0, indent: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable:
                              PrefsService.instance.tamassiDailyReminder,
                          builder: (context, value, _) {
                            return SwitchListTile(
                              value: value,
                              onChanged:
                                  PrefsService.instance.setTamassiDailyReminder,
                              activeThumbColor: KultivaColors.primaryGreen,
                              title: const Text(
                                'Rappel Tamassi quotidien',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "Tous les jours à 19h",
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle(title: '🔊  Sons'),
                  Card(
                    child: Column(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: PrefsService.instance.soundEnabled,
                          builder: (context, v, _) => SwitchListTile(
                            value: v,
                            onChanged: PrefsService.instance.setSoundEnabled,
                            activeThumbColor: KultivaColors.primaryGreen,
                            title: const Text('Sons des boutons',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: const Text('Bips kawaii sur les actions'),
                          ),
                        ),
                        const Divider(height: 0, indent: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable: PrefsService.instance.musicEnabled,
                          builder: (context, v, _) => SwitchListTile(
                            value: v,
                            onChanged: (val) async {
                              await PrefsService.instance.setMusicEnabled(val);
                              if (val) {
                                await AudioService.instance.startMusic();
                              } else {
                                await AudioService.instance.stopMusic();
                              }
                            },
                            activeThumbColor: KultivaColors.primaryGreen,
                            title: const Text('Musique de fond',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: const Text('Ambiance douce japonisante'),
                          ),
                        ),
                        const Divider(height: 0, indent: 16),
                        ValueListenableBuilder<double>(
                          valueListenable: PrefsService.instance.soundVolume,
                          builder: (context, v, _) => ListTile(
                            leading: const Icon(Icons.volume_up),
                            title: const Text('Volume',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: Slider(
                              value: v,
                              min: 0,
                              max: 1,
                              divisions: 10,
                              label: '${(v * 100).round()}%',
                              activeColor: KultivaColors.primaryGreen,
                              onChanged: (val) async {
                                await PrefsService.instance.setSoundVolume(val);
                                await AudioService.instance.setMusicVolume(val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle(title: '🌙  Apparence'),
                  Card(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: PrefsService.instance.darkMode,
                      builder: (context, value, _) {
                        return SwitchListTile(
                          value: value,
                          onChanged: PrefsService.instance.setDarkMode,
                          activeThumbColor: KultivaColors.primaryGreen,
                          title: const Text(
                            'Mode sombre',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle(title: '👤  Compte'),
                  Card(
                    child: AnimatedBuilder(
                      animation: AuthService.instance,
                      builder: (context, _) {
                        final auth = AuthService.instance;
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: KultivaColors.lightGreen
                                    .withValues(alpha: 0.4),
                                child: const Text('🌱'),
                              ),
                              title: Text(
                                auth.name ?? 'Invité',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(auth.email ?? 'Non connecté'),
                            ),
                            const Divider(height: 0, indent: 16),
                            ListTile(
                              leading: const Icon(
                                Icons.replay,
                                color: KultivaColors.primaryGreen,
                              ),
                              title: const Text(
                                'Revoir la présentation',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                  'Réafficher les écrans de bienvenue'),
                              onTap: () async {
                                await PrefsService.instance
                                    .setOnboardingDone(false);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Redémarre l\'app pour revoir l\'onboarding'),
                                    ),
                                  );
                                }
                              },
                            ),
                            const Divider(height: 0, indent: 16),
                            ValueListenableBuilder<int?>(
                              valueListenable: debugHourOverride,
                              builder: (context, override, _) {
                                final isAuto = override == null;
                                final displayHour =
                                    override ?? DateTime.now().hour;
                                final period = isAuto
                                    ? 'auto'
                                    : '${displayHour.toString().padLeft(2, '0')}h';
                                return ExpansionTile(
                                  leading: const Icon(
                                    Icons.wb_sunny_outlined,
                                    color: KultivaColors.primaryGreen,
                                  ),
                                  title: const Text(
                                    'Heure de test (debug)',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    'Force l\'heure du fond Tamassi · $period',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  children: <Widget>[
                                    SwitchListTile(
                                      dense: true,
                                      title: const Text('Mode automatique'),
                                      subtitle: const Text(
                                        'Utilise l\'heure réelle du téléphone',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      value: isAuto,
                                      onChanged: (v) =>
                                          debugHourOverride.value =
                                              v ? null : DateTime.now().hour,
                                    ),
                                    if (!isAuto)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Row(
                                          children: <Widget>[
                                            const Text('0h',
                                                style: TextStyle(fontSize: 12)),
                                            Expanded(
                                              child: Slider(
                                                value: displayHour.toDouble(),
                                                min: 0,
                                                max: 23,
                                                divisions: 23,
                                                label: '${displayHour}h',
                                                activeColor:
                                                    KultivaColors.primaryGreen,
                                                onChanged: (v) =>
                                                    debugHourOverride.value =
                                                        v.round(),
                                              ),
                                            ),
                                            const Text('23h',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    if (!isAuto)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 12),
                                        child: Wrap(
                                          spacing: 8,
                                          children: <int>[7, 14, 19, 23]
                                              .map((h) => ActionChip(
                                                    label: Text(
                                                        '${h.toString().padLeft(2, '0')}h'),
                                                    onPressed: () =>
                                                        debugHourOverride
                                                            .value = h,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            const Divider(height: 0, indent: 16),
                            ListTile(
                              leading: const Icon(
                                Icons.restart_alt,
                                color: KultivaColors.primaryGreen,
                              ),
                              title: const Text(
                                'Recommencer le Tamassi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: const Text(
                                'Rechoisir ton starter et renommer ton Tamassi',
                                style: TextStyle(fontSize: 11),
                              ),
                              onTap: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Tout recommencer ?'),
                                    content: const Text(
                                      'Tu vas revenir à l\'écran de sélection '
                                      'du starter. Ton niveau actuel sera '
                                      'conservé.',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text('Annuler'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text('Recommencer'),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm != true || !context.mounted) return;
                                await PrefsService.instance
                                    .setString('kultiva.creature.starter', '');
                                await PrefsService.instance
                                    .setString('kultiva.creature.name', '');
                                // Relance le tuto Poussidex.
                                await PrefsService.instance
                                    .setGardenTutorialDone(false);
                                tamassiResetNotifier.value++;
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        '🌱 Ouvre l\'onglet Poussidex pour '
                                        'choisir ton nouveau compagnon !'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              },
                            ),
                            const Divider(height: 0, indent: 16),
                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: KultivaColors.terracotta,
                              ),
                              title: const Text(
                                'Se déconnecter',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onTap: () async {
                                await AuthService.instance.signOut();
                                await CloudSyncService.instance
                                    .clearLocalData();
                                onSignOut();
                              },
                            ),
                            const Divider(height: 0, indent: 16),
                            ListTile(
                              leading: const Icon(
                                Icons.delete_forever,
                                color: KultivaColors.terracotta,
                              ),
                              title: const Text(
                                'Supprimer mon compte',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: KultivaColors.terracotta,
                                ),
                              ),
                              subtitle: const Text(
                                'Efface définitivement ton compte et toutes '
                                'tes données',
                                style: TextStyle(fontSize: 11),
                              ),
                              onTap: () => _confirmAndDeleteAccount(context),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TutoFicheScreen(
                            titre: 'Politique de confidentialité',
                            assetPath: 'assets/tutos/privacy_policy.html',
                          ),
                        ),
                      ),
                      child: Text(
                        'Politique de confidentialité',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: KultivaColors.primaryGreen,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Kultiva v1.0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: KultivaColors.textSecondary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Suppression de compte (exigence Apple) : confirmation explicite,
  /// barrière de progression pendant l'appel réseau, puis retour à
  /// l'écran de connexion. En cas d'échec (edge function non déployée,
  /// réseau…), un message est affiché et le compte reste intact.
  Future<void> _confirmAndDeleteAccount(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer ton compte ?'),
        content: const Text(
          'Cette action est définitive. Ton compte et toutes tes données '
          '(Poussidex, badges, Tamassi, jardins, photos) seront supprimés '
          'et ne pourront pas être récupérés.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.terracotta,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer définitivement'),
          ),
        ],
      ),
    );
    if (confirm != true || !context.mounted) return;
    // Barrière non annulable pendant la suppression.
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await AuthService.instance.deleteAccount();
      await CloudSyncService.instance.clearLocalData();
      if (!context.mounted) return;
      Navigator.of(context).pop(); // ferme la barrière
      onSignOut(); // ferme les Paramètres + retour connexion
    } catch (e) {
      if (!context.mounted) return;
      Navigator.of(context).pop(); // ferme la barrière
      messenger.showSnackBar(
        SnackBar(
          content: Text(e is AuthException ? e.message : '$e'),
        ),
      );
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
