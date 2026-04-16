import 'package:flutter/material.dart';

import '../../models/region_data.dart';
import '../../services/audio_service.dart';
import '../../services/auth_service.dart';
import '../../services/geolocation_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onSignOut;
  const SettingsScreen({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                _SectionTitle(title: '🌍  Région'),
                Card(
                  child: ValueListenableBuilder<Region>(
                    valueListenable: PrefsService.instance.region,
                    builder: (context, region, _) {
                      return Column(
                        children: <Widget>[
                          for (int i = 0; i < Region.values.length; i++) ...<Widget>[
                            if (i > 0)
                              const Divider(height: 0, indent: 16),
                            RadioListTile<Region>(
                              value: Region.values[i],
                              groupValue: region,
                              onChanged: (v) {
                                if (v != null) {
                                  PrefsService.instance.setRegion(v);
                                }
                              },
                              title: Text(
                                '${Region.values[i].emoji}   ${Region.values[i].label}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeColor: KultivaColors.primaryGreen,
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final region = await GeolocationService.detectRegion();
                        if (!context.mounted) return;
                        if (region != null) {
                          PrefsService.instance.setRegion(region);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Région détectée : ${region.emoji} ${region.label}',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Impossible de détecter la position. Vérifie tes permissions de localisation.',
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.my_location),
                      label: const Text('Détecter ma région automatiquement'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '🔔  Notifications'),
                Card(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: PrefsService.instance.notifications,
                    builder: (context, value, _) {
                      return SwitchListTile(
                        value: value,
                        onChanged:
                            PrefsService.instance.setNotifications,
                        activeColor: KultivaColors.primaryGreen,
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
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '🔊  Sons'),
                Card(
                  child: Column(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: PrefsService.instance.soundEnabled,
                        builder: (context, v, _) => SwitchListTile(
                          value: v,
                          onChanged: PrefsService.instance.setSoundEnabled,
                          activeColor: KultivaColors.primaryGreen,
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
                          activeColor: KultivaColors.primaryGreen,
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
                _SectionTitle(title: '🌙  Apparence'),
                Card(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: PrefsService.instance.darkMode,
                    builder: (context, value, _) {
                      return SwitchListTile(
                        value: value,
                        onChanged: PrefsService.instance.setDarkMode,
                        activeColor: KultivaColors.primaryGreen,
                        title: const Text(
                          'Mode sombre',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '👤  Compte'),
                Card(
                  child: AnimatedBuilder(
                    animation: AuthService.instance,
                    builder: (context, _) {
                      final auth = AuthService.instance;
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  KultivaColors.lightGreen.withOpacity(0.4),
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
                              await PrefsService.instance.setOnboardingDone(false);
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
                          ListTile(
                            leading: const Icon(
                              Icons.school_outlined,
                              color: KultivaColors.primaryGreen,
                            ),
                            title: const Text(
                              'Revoir le tuto Poussidex',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            subtitle: const Text(
                                "Les 3 slides d'explication du Poussidex"),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const GardenTutorialSheet(),
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
                              onSignOut();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
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
    );
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
