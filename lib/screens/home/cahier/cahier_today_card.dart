import 'package:flutter/material.dart';

import '../../../data/vegetables_base.dart';
import '../../../models/vegetable.dart';
import '../../../models/watering_alert.dart';
import '../../../models/weather_data.dart';
import '../../../services/plantation_service.dart';
import '../../../services/prefs_service.dart';
import '../../../services/watering_service.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/climate.dart';
import '../../../utils/heatwave_tips.dart';
import '../../../utils/phenology.dart';

/// Ce qu'il y a à faire au jardin aujourd'hui.
///
/// Le cahier de culture listait des jardins : pour savoir quoi faire
/// il fallait ouvrir un jardin, tapoter une case, lire la fiche du
/// plant, et recommencer pour chacun. Les informations existaient
/// toutes — l'alerte d'arrosage, la phénologie, le seuil de canicule —
/// mais seules les notifications les utilisaient. L'écran qu'on ouvre
/// tous les jours ne disait rien.
///
/// Trois questions, dans l'ordre où elles se posent le matin : qui a
/// soif, qui est mûr, et fait-il trop chaud.
class CahierTodayCard extends StatefulWidget {
  const CahierTodayCard({super.key});

  @override
  State<CahierTodayCard> createState() => _CahierTodayCardState();
}

class _CahierTodayCardState extends State<CahierTodayCard> {
  List<WateringAlert> _alerts = <WateringAlert>[];
  WeatherData? _weather;
  bool _loading = true;
  bool _watering = false;

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
      // lever : la carte doit quand même s'afficher, les récoltes ne
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

  /// Plants dont la fenêtre de récolte est ouverte, par espèce.
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

  /// Température max prévue aujourd'hui, si la météo a répondu.
  double? get _todayMax => _weather?.tempMaxToday;

  bool get _heatwave {
    final max = _todayMax;
    if (max == null) return false;
    return max >= heatwaveThresholdFor(PrefsService.instance.region.value);
  }

  Future<void> _waterAll() async {
    final especes = _alerts.map((a) => a.vegetable.id).toSet();
    final ids = PlantationService.instance.active
        .where((p) => especes.contains(p.vegetableId))
        .map((p) => p.id)
        .toList();
    if (ids.isEmpty) return;
    setState(() => _watering = true);
    // Une seule écriture pour tout le jardin : arroser plant par plant
    // re-sérialisait la collection entière à chaque fois.
    await PlantationService.instance.waterMany(ids);
    if (!mounted) return;
    setState(() => _watering = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ids.length == 1
            ? 'Arrosage noté 💧'
            : '${ids.length} plants arrosés 💧'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Pas de `_refresh()` ici : `waterMany` notifie le service, et
    // l'écouteur posé dans `initState` s'en charge. L'appeler aussi
    // relançait une deuxième requête météo pour rien.
  }

  @override
  Widget build(BuildContext context) {
    final actifs = PlantationService.instance.active;
    if (actifs.isEmpty) return const SizedBox.shrink();

    final recoltes = _toHarvest;
    final lignes = <Widget>[];

    if (_alerts.isNotEmpty) {
      lignes.add(_TaskLine(
        emoji: '💧',
        text: 'Arroser : ${_listeEspeces(_alerts.map((a) => a.vegetable))}',
        urgent: _alerts.any((a) => a.urgency >= 2),
        action: _watering ? null : 'Arroser',
        onAction: _watering ? null : _waterAll,
      ));
    }
    if (recoltes.isNotEmpty) {
      lignes.add(_TaskLine(
        emoji: '🧺',
        text: 'À récolter : ${_listeEspeces(recoltes)}',
      ));
    }
    if (_heatwave) {
      final categorie = actifs
          .map((p) =>
              vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull)
          .whereType<Vegetable>()
          .map((v) => v.category)
          .firstOrNull;
      lignes.add(_TaskLine(
        emoji: '🥵',
        urgent: true,
        text: '${_todayMax!.round()} °C aujourd\'hui. '
            '${categorie == null ? "Pense à pailler et ombrer." : heatwaveTipFor(categorie)}',
      ));
    }

    if (lignes.isEmpty) {
      lignes.add(_TaskLine(
        emoji: '✅',
        text: _loading
            ? 'Lecture du jardin…'
            : 'Rien d\'urgent aujourd\'hui. '
                '${actifs.length} plant${actifs.length > 1 ? 's' : ''} '
                'en terre.',
      ));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? KultivaColors.darkCard
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: KultivaColors.lightGreen.withValues(alpha: 0.5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: KultivaColors.primaryGreen.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'À faire aujourd\'hui',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            ...lignes,
          ],
        ),
      ),
    );
  }

  /// « tomate, courgette et radis » — les noms, pas « 3 espèces ».
  static String _listeEspeces(Iterable<Vegetable> legumes) {
    final noms = legumes.map((v) => v.name.toLowerCase()).toList();
    if (noms.length <= 3) {
      if (noms.length == 1) return noms.first;
      return '${noms.sublist(0, noms.length - 1).join(', ')} '
          'et ${noms.last}';
    }
    return '${noms.take(3).join(', ')} et ${noms.length - 3} autre'
        '${noms.length - 3 > 1 ? 's' : ''}';
  }
}

class _TaskLine extends StatelessWidget {
  final String emoji;
  final String text;
  final bool urgent;
  final String? action;
  final VoidCallback? onAction;

  const _TaskLine({
    required this.emoji,
    required this.text,
    this.urgent = false,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                fontWeight: urgent ? FontWeight.w700 : FontWeight.w500,
                color: urgent ? KultivaColors.terracotta : null,
              ),
            ),
          ),
          if (action != null) ...<Widget>[
            const SizedBox(width: 8),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: KultivaColors.waterBlue,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                minimumSize: const Size(0, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(action!,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ],
      ),
    );
  }
}
