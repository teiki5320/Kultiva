import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../config/app_info.dart';
import '../../data/ui_i18n.dart';
import '../../models/country.dart';
import '../../models/region_data.dart';
import '../../services/audio_service.dart';
import '../../services/geolocation_service.dart';
import '../../services/photo_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/text_normalize.dart';
import '../home/tuto_fiche_screen.dart';

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
            AppBar(title: Text(trUi('Paramètres'))),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: <Widget>[
                  _SectionTitle(title: trUi('🌍  Pays')),
                  // ⚠️ C'étaient 73 boutons radio empilés, soit toute
                  // la page de réglages avant d'atteindre le son ou la
                  // langue. Un menu déroulant filtrable tient en une
                  // ligne : demande de Jean, et il avait raison.
                  const _SelecteurPays(),
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
                                  trUiArgs('Pays détecté : {0} {1}', <Object?>[
                                    detected.country.flag,
                                    detected.country.displayLabel,
                                  ]),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  trUi('Impossible de détecter ton pays. '
                                      'Vérifie tes permissions de localisation.'),
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.my_location),
                        label: Text(trUi('Détecter mon pays automatiquement')),
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
                              _SectionTitle(title: trUi('🌦️  Ma zone')),
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
                  _SectionTitle(title: trUi('🔔  Notifications')),
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
                              title: Text(
                                trUi('Rappel mensuel'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                trUi("Une notification le 1er de chaque mois"),
                              ),
                            );
                          },
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
                            title: Text(trUi('Musique de fond'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                            subtitle: Text(trUi('Ambiance douce japonisante')),
                          ),
                        ),
                        const Divider(height: 0, indent: 16),
                        ValueListenableBuilder<double>(
                          valueListenable: PrefsService.instance.soundVolume,
                          builder: (context, v, _) => ListTile(
                            leading: const Icon(Icons.volume_up),
                            title: Text(trUi('Volume'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
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
                  const _SectionTitle(title: '🗣️  Langue'),
                  Card(
                    child: ValueListenableBuilder<String?>(
                      valueListenable: PrefsService.instance.language,
                      builder: (context, choisie, _) {
                        return RadioGroup<String?>(
                          groupValue: choisie,
                          onChanged: PrefsService.instance.setLanguage,
                          child: Column(
                            children: <Widget>[
                              RadioListTile<String?>(
                                value: null,
                                activeColor: KultivaColors.primaryGreen,
                                title: Text(
                                  trUi('Celle du téléphone'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              for (final code
                                  in PrefsService.supportedLanguages)
                                RadioListTile<String?>(
                                  value: code,
                                  activeColor: KultivaColors.primaryGreen,
                                  title: Text(
                                    _langueLabel(code),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 14),
                                child: Text(
                                  // On le dit plutôt que de le laisser
                                  // découvrir : une interface traduite
                                  // sur du contenu français surprend
                                  // moins quand on a été prévenu. Le
                                  // texte vit dans les ARB et change
                                  // avec la langue : chacune n'est pas
                                  // au même stade.
                                  L.of(context).settingsLanguagePartial,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: KultivaColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle(title: trUi('🌙  Apparence')),
                  Card(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: PrefsService.instance.darkMode,
                      builder: (context, value, _) {
                        return SwitchListTile(
                          value: value,
                          onChanged: PrefsService.instance.setDarkMode,
                          activeThumbColor: KultivaColors.primaryGreen,
                          title: Text(
                            trUi('Mode sombre'),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle(title: trUi('🌱  Mon jardin')),
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            Icons.replay,
                            color: KultivaColors.primaryGreen,
                          ),
                          title: Text(
                            trUi('Revoir la présentation'),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle:
                              Text(trUi('Réafficher les écrans de bienvenue')),
                          onTap: () async {
                            await PrefsService.instance
                                .setOnboardingDone(false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(trUi(
                                      'Redémarre l\'app pour revoir l\'onboarding')),
                                ),
                              );
                            }
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
                          title: Text(
                            trUi('Effacer mon jardin'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: KultivaColors.terracotta,
                            ),
                          ),
                          subtitle: Text(
                            trUi('Plants, badges, défis et jardins — '
                                'définitif'),
                            style: const TextStyle(fontSize: 11),
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
                          builder: (_) => TutoFicheScreen(
                            titre: trUi('Politique de confidentialité'),
                            assetPath: 'assets/tutos/privacy_policy.html',
                          ),
                        ),
                      ),
                      child: Text(
                        trUi('Politique de confidentialité'),
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
        title: Text(trUi('Effacer ton jardin ?')),
        content: Text(
          trUi('Tes plants, tes photos, tes badges, tes défis, tes jardins '
              'seront effacés de ce téléphone.\n\n'
              'Tes réglages (son, thème, région) sont conservés.'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(trUi('Annuler')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(trUi('Continuer')),
          ),
        ],
      ),
    );
    if (first != true || !context.mounted) return;

    final second = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(trUi('C\'est définitif')),
        content: Text(
          trUi('Kultiva n\'a pas de compte : rien n\'est sauvegardé ailleurs. '
              'Une fois effacé, ton jardin ne peut pas être récupéré.'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(trUi('Garder mon jardin')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: KultivaColors.terracotta,
            ),
            child: Text(trUi('Tout effacer')),
          ),
        ],
      ),
    );
    if (second != true || !context.mounted) return;

    await PrefsService.instance.clearUserScopedData();
    // Les photos des plants effacés n'ont plus de référence : la purge
    // les retire du disque.
    await PhotoService.purgeOrphans();

    if (!context.mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(trUi('🧹 Ton jardin a été effacé. À toi de rejouer !')),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// Chaque langue se nomme dans sa propre langue : un anglophone
/// cherche « English », pas « Anglais ».
String _langueLabel(String code) {
  switch (code) {
    case 'en':
      return '🇬🇧  English';
    case 'es':
      return '🇪🇸  Español';
    case 'fr':
    default:
      return '🇫🇷  Français';
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

/// Le choix du pays : une ligne qui ouvre la liste des 73, avec une
/// recherche.
///
/// ⚠️ **Première tentative : un `DropdownMenu` filtrable.** Il ne
/// s'ouvrait pas — vérifié à l'écran, la capture d'avant et celle
/// d'après le tap étaient identiques à l'octet près. Je l'avais livré
/// sans le regarder. Une feuille modale est de toute façon la bonne
/// réponse sur téléphone pour 73 entrées, et c'est la convention de
/// navigation du projet.
///
/// ⚠️ **Choisir un pays change aussi la langue** depuis le 02/11/2026,
/// et on le dit à l'écran plutôt que de le laisser découvrir. Le
/// réglage « Langue », juste en dessous, reste maître ensuite.
class _SelecteurPays extends StatelessWidget {
  const _SelecteurPays();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Country?>(
      valueListenable: PrefsService.instance.country,
      builder: (context, country, _) {
        final region = PrefsService.instance.region.value;
        final choisi =
            country ?? (region == Region.france ? Country.france : null);
        return Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text(choisi?.flag ?? '🌍',
                    style: const TextStyle(fontSize: 26)),
                title: Text(
                  choisi?.displayLabel ?? trUi('Où jardines-tu ?'),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(trUi('Appuie pour changer')),
                trailing: const Icon(Icons.expand_more),
                onTap: () => _choisir(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Text(
                  trUi('Le pays choisit le calendrier de semis, les '
                      'saisons et la langue.'),
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: KultivaColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _choisir(BuildContext context) async {
    final avant = PrefsService.instance.effectiveLanguage;
    final choix = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _ListePays(),
    );
    if (choix == null || !context.mounted) return;
    await PrefsService.instance.setCountry(choix);
    if (!context.mounted) return;
    final apres = PrefsService.instance.effectiveLanguage;
    if (apres != avant) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(trUiArgs(
            'Langue passée en {0}. Tu peux la changer juste en dessous.',
            <Object?>[_langueLabel(apres)],
          )),
        ),
      );
    }
  }
}

/// La liste des 73 pays, filtrable au clavier.
///
/// ⚠️ La recherche porte sur le nom affiché **et** sur le nom
/// français, plus la capitale et le code ISO : un hispanophone tape
/// « Alemania », un francophone « Allemagne », et les deux trouvent.
/// Même règle que l'onboarding.
class _ListePays extends StatefulWidget {
  const _ListePays();

  @override
  State<_ListePays> createState() => _ListePaysState();
}

class _ListePaysState extends State<_ListePays> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final q = foldAccents(_query.trim());
    final pays = Country.ordered()
        .where((c) =>
            q.isEmpty ||
            foldAccents(c.displayLabel).contains(q) ||
            foldAccents(c.label).contains(q) ||
            foldAccents(c.displayCapital).contains(q) ||
            c.isoCode.toLowerCase() == q)
        .toList();
    final actuel = PrefsService.instance.country.value;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: trUi('Chercher un pays…'),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: pays.isEmpty
                ? Center(child: Text(trUi('Aucun pays ne correspond.')))
                : ListView.builder(
                    itemCount: pays.length,
                    itemBuilder: (_, i) {
                      final c = pays[i];
                      return ListTile(
                        leading: Text(c.flag,
                            style: const TextStyle(fontSize: 24)),
                        title: Text(c.displayLabel,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700)),
                        subtitle: Text(c.displayCapital),
                        trailing: c == actuel
                            ? const Icon(Icons.check,
                                color: KultivaColors.primaryGreen)
                            : null,
                        onTap: () => Navigator.of(context).pop(c),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
