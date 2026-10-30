import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/app_info.dart';
import '../../models/country.dart';
import '../../models/region_data.dart';
import '../../services/audio_service.dart';
import '../../services/geolocation_service.dart';
import '../../services/photo_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../home/tuto_fiche_screen.dart';
import 'my_garden_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                          final detected =
                              await GeolocationService.detectCountryAndZone();
                          if (!context.mounted) return;
                          if (detected != null) {
                            PrefsService.instance.setCountry(detected.country,
                                zone: detected.zone);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Pays détecté : ${detected.country.flag} ${detected.country.label}',
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
                  // Sélecteur de sous-zone climatique (Afrique de l'Ouest) :
                  // affine les calendriers dans un même pays (Bamako
                  // soudanien, nord Côte d'Ivoire…).
                  ValueListenableBuilder<Country?>(
                    valueListenable: PrefsService.instance.country,
                    builder: (context, country, _) {
                      if (country == null || !country.isWestAfrica) {
                        return const SizedBox.shrink();
                      }
                      return ValueListenableBuilder<ClimateZone?>(
                        valueListenable: PrefsService.instance.climateZone,
                        builder: (context, zone, _) {
                          final effective = PrefsService.instance.effectiveZone;
                          return Column(
                            children: <Widget>[
                              const SizedBox(height: 8),
                              const _SectionTitle(title: '🌦️  Ma zone'),
                              Card(
                                child: RadioGroup<ClimateZone>(
                                  groupValue: effective,
                                  onChanged: (v) {
                                    if (v != null) {
                                      PrefsService.instance.setClimateZone(v);
                                    }
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      for (final (i, z) in ClimateZone
                                          .westAfricanZones
                                          .indexed) ...<Widget>[
                                        if (i > 0)
                                          const Divider(height: 0, indent: 16),
                                        RadioListTile<ClimateZone>(
                                          value: z,
                                          title: Text(
                                            z.label,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          subtitle: Text(z.description),
                                          activeColor:
                                              KultivaColors.primaryGreen,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
                  const _SectionTitle(title: '🌱  Mon jardin'),
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            Icons.replay,
                            color: KultivaColors.primaryGreen,
                          ),
                          title: const Text(
                            'Revoir la présentation',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle:
                              const Text('Réafficher les écrans de bienvenue'),
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
                        if (kDebugMode) ...<Widget>[
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
                                  style: TextStyle(fontWeight: FontWeight.w700),
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
                                    onChanged: (v) => debugHourOverride.value =
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
                                                      debugHourOverride.value =
                                                          h,
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
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
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text('Annuler'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx, true),
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
                                content:
                                    Text('🌱 Ouvre l\'onglet Poussidex pour '
                                        'choisir ton nouveau compagnon !'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 0, indent: 16),
                        // Sans compte ni synchronisation, c'est le seul
                        // moyen de repartir de zéro sans désinstaller
                        // l'app. D'où la double confirmation : ce que ce
                        // bouton efface est irrécupérable.
                        ListTile(
                          leading: const Icon(
                            Icons.delete_forever,
                            color: KultivaColors.terracotta,
                          ),
                          title: const Text(
                            'Effacer mon jardin',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: KultivaColors.terracotta,
                            ),
                          ),
                          subtitle: const Text(
                            'Plants, badges, défis, jardins et Tamassi — '
                            'définitif',
                            style: TextStyle(fontSize: 11),
                          ),
                          onTap: () => _confirmErase(context),
                        ),
                      ],
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
                      AppInfo.label,
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

  /// Efface toutes les données du jardin, après deux confirmations.
  ///
  /// Le jardin ne vit que sur l'appareil : il n'y a ni compte ni
  /// sauvegarde pour le récupérer. La seconde étape demande donc de
  /// relire ce qui va disparaître, plutôt qu'un simple « OK » réflexe.
  Future<void> _confirmErase(BuildContext context) async {
    final first = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Effacer ton jardin ?'),
        content: const Text(
          'Tes plants, tes photos, tes badges, tes défis, tes jardins '
          'et ton Tamassi seront effacés de ce téléphone.\n\n'
          'Tes réglages (son, thème, région) sont conservés.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
    if (first != true || !context.mounted) return;

    final second = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('C\'est définitif'),
        content: const Text(
          'Kultiva n\'a pas de compte : rien n\'est sauvegardé ailleurs. '
          'Une fois effacé, ton jardin ne peut pas être récupéré.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Garder mon jardin'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.terracotta,
            ),
            child: const Text('Tout effacer'),
          ),
        ],
      ),
    );
    if (second != true || !context.mounted) return;

    await PrefsService.instance.clearUserScopedData();
    // Les photos des plants effacés n'ont plus de référence : la purge
    // les retire du disque.
    await PhotoService.purgeOrphans();
    // Tamassi repart de la sélection du starter, et le tuto du jardin
    // se rejoue comme à la première ouverture.
    await PrefsService.instance.setGardenTutorialDone(false);
    tamassiResetNotifier.value++;
    if (!context.mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧹 Ton jardin a été effacé. À toi de rejouer !'),
        duration: Duration(seconds: 3),
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
