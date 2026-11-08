import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../data/content_i18n.dart';
import '../../../data/names_en.dart';
import '../../../data/ui_i18n.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/vegetable.dart';
import '../../../models/watering_alert.dart';
import '../../../models/weather_data.dart';
import '../../../services/audio_service.dart';
import '../../../services/plantation_service.dart';
import '../../../services/watering_service.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/climate.dart';
import '../../../utils/heatwave_tips.dart';
import '../../../utils/phenology.dart';

/// Ce qu'il y a à faire au jardin aujourd'hui, en pile de post-it.
///
/// Le cahier listait des jardins : pour savoir quoi faire il fallait
/// ouvrir un jardin, tapoter une case, lire la fiche du plant, et
/// recommencer pour chacun. La carte du 31/10/2026 a rassemblé les
/// trois questions du matin — qui a soif, qui est mûr, fait-il trop
/// chaud.
///
/// Refaite le 06/11/2026 en **pile** (maquette « C4c · La pile du
/// jour », validée par Jean) : une tâche à la fois, en grand. On la
/// glisse à droite quand c'est fait, à gauche pour la remettre à
/// demain. Les deux boutons sous la pile font la même chose, pour qui
/// ne glisse pas et pour VoiceOver.
///
/// ⚠️ Glisser à droite **écrit** dans le jardin : l'arrosage passe par
/// `waterMany`, la récolte par `harvest`, comme avant. Seule la
/// canicule n'a rien à écrire — la glisser dit simplement « vu ».
/// « Plus tard » ne vit que le temps de la journée et de la session :
/// une tâche remise réapparaît le lendemain, ou au prochain lancement.
class CahierTodayCard extends StatefulWidget {
  const CahierTodayCard({super.key});

  /// Vide la mémoire du jour entre deux tests.
  ///
  /// ⚠️ « Fait » et « plus tard » vivent dans des ensembles
  /// **statiques** — c'est voulu, la journée ne se reconstruit pas
  /// quand le cahier se reconstruit. Mais un test qui glisse un
  /// post-it laissait la pile vide pour le test suivant, qui ne
  /// trouvait plus rien à glisser et échouait pour une raison qui
  /// n'était pas la sienne.
  @visibleForTesting
  static void resetForTesting() {
    _CahierTodayCardState._faites.clear();
    _CahierTodayCardState._remises.clear();
  }

  @override
  State<CahierTodayCard> createState() => _CahierTodayCardState();
}

class _CahierTodayCardState extends State<CahierTodayCard> {
  List<WateringAlert> _alerts = <WateringAlert>[];
  WeatherData? _weather;
  bool _loading = true;
  bool _busy = false;

  /// Les tâches réglées ou remises aujourd'hui, par clé `jour:type`.
  /// Statique : le cahier se reconstruit souvent, la journée non.
  static final Set<String> _faites = <String>{};
  static final Set<String> _remises = <String>{};

  static String get _jour {
    final d = DateTime.now();
    return '${d.year}-${d.month}-${d.day}';
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    PlantationService.instance.addListener(_refresh);
  }

  @override
  void dispose() {
    PlantationService.instance.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _refresh() async {
    final actifs = PlantationService.instance.active;
    var alerts = <WateringAlert>[];
    WeatherData? weather;
    try {
      // Hors ligne, `analyzeGarden` renvoie une liste vide plutôt que
      // de faire attendre. Si la géolocalisation est coupée, elle peut
      // lever : la pile doit quand même s'afficher, les récoltes ne
      // dépendant que des dates de plantation.
      alerts = await WateringService.analyzeGarden(actifs);
      weather = await WeatherService.getWeather();
    } catch (_) {
      // Pas de météo aujourd'hui, tant pis.
    }
    if (!mounted) return;
    setState(() {
      _alerts = alerts.where((a) => a.needsWatering).toList();
      _weather = weather;
      _loading = false;
    });
  }

  /// Espèces dont la fenêtre de récolte est ouverte.
  List<Vegetable> get _toHarvest {
    final vus = <String>{};
    final out = <Vegetable>[];
    for (final p in PlantationService.instance.active) {
      if (vus.contains(p.vegetableId)) continue;
      final veg =
          vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
      if (veg == null) continue;
      final jours = DateTime.now().difference(p.plantedAt).inDays;
      if (expectedStage(veg, jours)?.harvestReady ?? false) {
        vus.add(p.vegetableId);
        out.add(veg);
      }
    }
    return out;
  }

  double? get _todayMax => _weather?.tempMaxToday;

  bool get _heatwave {
    final max = _todayMax;
    if (max == null) return false;
    return max >= currentHeatwaveThreshold();
  }

  Future<void> _waterAll() async {
    final especes = _alerts.map((a) => a.vegetable.id).toSet();
    final ids = PlantationService.instance.active
        .where((p) => especes.contains(p.vegetableId))
        .map((p) => p.id)
        .toList();
    if (ids.isEmpty) return;
    // Une seule écriture pour tout le jardin : arroser plant par plant
    // re-sérialisait la collection entière à chaque fois.
    await PlantationService.instance.waterMany(ids);
    if (!mounted) return;
    _annonce(ids.length == 1
        ? trUi('Arrosage noté 💧')
        : trUiArgs('{0} plants arrosés 💧', <Object?>[ids.length]));
  }

  Future<void> _harvestAll(List<Vegetable> recoltes) async {
    final especes = recoltes.map((v) => v.id).toSet();
    final ids = PlantationService.instance.active
        .where((p) => especes.contains(p.vegetableId))
        .where((p) {
          final veg = recoltes.firstWhere((v) => v.id == p.vegetableId);
          final jours = DateTime.now().difference(p.plantedAt).inDays;
          return expectedStage(veg, jours)?.harvestReady ?? false;
        })
        .map((p) => p.id)
        .toList();
    for (final id in ids) {
      await PlantationService.instance.harvest(id);
    }
    if (!mounted || ids.isEmpty) return;
    _annonce(ids.length == 1
        ? trUi('Récolte notée 🧺')
        : trUiArgs('{0} récoltes notées 🧺', <Object?>[ids.length]));
  }

  void _annonce(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texte), duration: const Duration(seconds: 2)),
    );
  }

  List<_Tache> _taches(List<Vegetable> recoltes) {
    final actifs = PlantationService.instance.active;
    final out = <_Tache>[];
    if (_alerts.isNotEmpty) {
      final premier = _alerts.first.vegetable;
      out.add(_Tache(
        cle: '$_jour:arrosage',
        couleur: const Color(0xFFD6ECF5),
        accent: KultivaColors.waterBlue,
        icone: const _Goutte(),
        titre: trUiArgs('Arroser : {0}',
            <Object?>[_listeEspeces(_alerts.map((a) => a.vegetable))]),
        detail: _alerts.any((a) => a.urgency >= 2)
            ? trUi('Urgent : la terre est sèche')
            : null,
        image: premier.imageAsset,
        faire: _waterAll,
      ));
    }
    if (recoltes.isNotEmpty) {
      out.add(_Tache(
        cle: '$_jour:recolte',
        couleur: const Color(0xFFFBE2CD),
        accent: KultivaColors.terracotta,
        image: recoltes.first.imageAsset,
        emoji: recoltes.first.emoji,
        titre: trUiArgs('À récolter : {0}', <Object?>[_listeEspeces(recoltes)]),
        faire: () => _harvestAll(recoltes),
      ));
    }
    if (_heatwave) {
      final categorie = actifs
          .map((p) =>
              vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull)
          .whereType<Vegetable>()
          .map((v) => v.category)
          .firstOrNull;
      out.add(_Tache(
        cle: '$_jour:canicule',
        couleur: const Color(0xFFFFF3C4),
        accent: const Color(0xFF8A6A00),
        emoji: '🥵',
        titre: trUiArgs("{0} °C aujourd'hui. {1}", <Object?>[
          _todayMax!.round(),
          categorie == null
              ? trUi('Pense à pailler et ombrer.')
              : tr(heatwaveTipFor(categorie)),
        ]),
      ));
    }
    return out;
  }

  /// ⚠️ Synchrone exprès : un `Dismissible` glissé doit quitter
  /// l'arbre **dans la même image**, sinon Flutter lève « A dismissed
  /// Dismissible widget is still part of the tree ». La tâche sort
  /// donc de la pile tout de suite ; l'écriture suit.
  void _regler(_Tache t, {required bool fait}) {
    AudioService.instance.play(Sfx.tap);
    final faire = fait ? t.faire : null;
    setState(() {
      (fait ? _faites : _remises).add(t.cle);
      if (faire != null) _busy = true;
    });
    if (faire == null) return;
    faire().whenComplete(() {
      if (mounted) setState(() => _busy = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final actifs = PlantationService.instance.active;
    if (actifs.isEmpty) return const SizedBox.shrink();

    final toutes = _taches(_toHarvest);
    final restantes = toutes
        .where((t) => !_faites.contains(t.cle) && !_remises.contains(t.cle))
        .toList();
    final faitesAujourdhui = _faites.where((k) => k.startsWith('$_jour:'));
    final total = restantes.length + faitesAujourdhui.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  trUi('Ma pile du jour'),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ),
              if (total > 0)
                _Points(faits: faitesAujourdhui.length, total: total),
            ],
          ),
          const SizedBox(height: 12),
          if (restantes.isEmpty)
            _PostIt(
              couleur: const Color(0xFFE3F1E0),
              enfant: Text(
                _loading
                    ? trUi('Lecture du jardin…')
                    : faitesAujourdhui.isNotEmpty
                        ? trUi('Tout est fait pour aujourd\'hui 🌱')
                        : actifs.length > 1
                            ? trUiArgs(
                                "Rien d'urgent aujourd'hui. {0} plants en terre.",
                                <Object?>[actifs.length])
                            : trUiArgs(
                                "Rien d'urgent aujourd'hui. {0} plant en terre.",
                                <Object?>[actifs.length]),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.textPrimary,
                ),
              ),
            )
          else ...<Widget>[
            _Pile(
              taches: restantes,
              onFait: (t) => _regler(t, fait: true),
              onPlusTard: (t) => _regler(t, fait: false),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy
                        ? null
                        : () => _regler(restantes.first, fait: false),
                    child: Text(trUi('Plus tard')),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _busy
                        ? null
                        : () => _regler(restantes.first, fait: true),
                    child: Text(trUi('Fait →')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              trUi('Glisse à droite quand c\'est fait, à gauche pour demain.'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12, color: KultivaColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  /// « tomate, courgette et radis » — les noms, pas « 3 espèces ».
  static String _listeEspeces(Iterable<Vegetable> legumes) {
    final noms = legumes.map((v) => v.displayName.toLowerCase()).toList();
    if (noms.length <= 3) {
      if (noms.length == 1) return noms.first;
      return trUiArgs('{0} et {1}',
          <Object?>[noms.sublist(0, noms.length - 1).join(', '), noms.last]);
    }
    return noms.length - 3 > 1
        ? trUiArgs('{0} et {1} autres',
            <Object?>[noms.take(3).join(', '), noms.length - 3])
        : trUiArgs('{0} et {1} autre',
            <Object?>[noms.take(3).join(', '), noms.length - 3]);
  }
}

/// Une tâche de la pile.
class _Tache {
  final String cle;
  final Color couleur;
  final Color accent;
  final Widget? icone;
  final String? emoji;
  final String? image;
  final String titre;
  final String? detail;
  final Future<void> Function()? faire;

  const _Tache({
    required this.cle,
    required this.couleur,
    required this.accent,
    required this.titre,
    this.icone,
    this.emoji,
    this.image,
    this.detail,
    this.faire,
  });
}

/// La pile : deux post-it en dessous, celui du dessus se glisse.
class _Pile extends StatelessWidget {
  final List<_Tache> taches;
  final ValueChanged<_Tache> onFait;
  final ValueChanged<_Tache> onPlusTard;

  const _Pile({
    required this.taches,
    required this.onFait,
    required this.onPlusTard,
  });

  @override
  Widget build(BuildContext context) {
    final dessus = taches.first;
    final dessous = taches.skip(1).take(2).toList();
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        // Les post-it du dessous, décalés et tournés : on voit qu'il en
        // reste. Le plus profond est dessiné en premier.
        for (var i = dessous.length - 1; i >= 0; i--)
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, 10.0 * (i + 1)),
              child: Transform.rotate(
                angle: (i.isEven ? 3 : -2) * math.pi / 180,
                child: Transform.scale(
                  scale: 1 - 0.05 * (i + 1),
                  child: _PostIt(couleur: dessous[i].couleur),
                ),
              ),
            ),
          ),
        // ⚠️ La clé change avec la tâche : sans elle, `Dismissible`
        // garderait l'état « déjà glissé » et la carte suivante
        // n'apparaîtrait pas.
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TweenAnimationBuilder<double>(
            key: ValueKey<String>('monte-${dessus.cle}'),
            tween: Tween<double>(begin: 0.94, end: 1),
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutBack,
            builder: (_, s, child) => Transform.scale(scale: s, child: child),
            child: Dismissible(
              key: ValueKey<String>(dessus.cle),
              background: _Fond(
                texte: trUi('FAIT'),
                couleur: KultivaColors.primaryGreen,
                alignement: Alignment.centerLeft,
              ),
              secondaryBackground: _Fond(
                texte: trUi('Pour demain'),
                couleur: KultivaColors.textSecondary,
                alignement: Alignment.centerRight,
              ),
              onDismissed: (sens) => sens == DismissDirection.startToEnd
                  ? onFait(dessus)
                  : onPlusTard(dessus),
              child: Semantics(
                label: dessus.titre,
                hint: trUi(
                    'Glisse à droite quand c\'est fait, à gauche pour demain.'),
                child: Transform.rotate(
                  angle: -2 * math.pi / 180,
                  child: _PostIt(
                    couleur: dessus.couleur,
                    enfant: _ContenuTache(tache: dessus),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContenuTache extends StatelessWidget {
  final _Tache tache;
  const _ContenuTache({required this.tache});

  @override
  Widget build(BuildContext context) {
    final Widget visuel = tache.icone ??
        (tache.image != null
            ? Image.asset(tache.image!, width: 44, height: 44)
            : Text(tache.emoji ?? '🌱', style: const TextStyle(fontSize: 34)));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 44, child: visuel),
        const SizedBox(height: 8),
        Text(
          tache.titre,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: KultivaColors.textPrimary,
          ),
        ),
        if (tache.detail != null) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            tache.detail!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color.lerp(tache.accent, Colors.black, 0.35),
            ),
          ),
        ],
      ],
    );
  }
}

/// Un post-it : papier pastel, un coin arrondi, une ombre douce.
class _PostIt extends StatelessWidget {
  final Color couleur;
  final Widget? enfant;
  const _PostIt({required this.couleur, this.enfant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
          bottomLeft: Radius.circular(28),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: enfant,
    );
  }
}

class _Fond extends StatelessWidget {
  final String texte;
  final Color couleur;
  final Alignment alignement;
  const _Fond({
    required this.texte,
    required this.couleur,
    required this.alignement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignement,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: couleur, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          texte,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: couleur,
          ),
        ),
      ),
    );
  }
}

/// Les points de progression : un par tâche du jour, pleins si faits.
class _Points extends StatelessWidget {
  final int faits;
  final int total;
  const _Points({required this.faits, required this.total});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: faits > 1
          ? trUiArgs('{0} faits sur {1}', <Object?>[faits, total])
          : trUiArgs('{0} fait sur {1}', <Object?>[faits, total]),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (var i = 0; i < total; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(left: 6),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < faits ? KultivaColors.primaryGreen : null,
                border: Border.all(color: KultivaColors.primaryGreen, width: 2),
              ),
            ),
        ],
      ),
    );
  }
}

/// La goutte d'eau, dessinée : un emoji 💧 change d'allure selon le
/// téléphone, et l'arrosage a sa couleur à lui dans toute l'app.
class _Goutte extends StatelessWidget {
  const _Goutte();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.water_drop_rounded,
        size: 40, color: KultivaColors.waterBlue);
  }
}
