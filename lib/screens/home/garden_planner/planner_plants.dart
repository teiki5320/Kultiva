/// Choix d'un plant, bandeau d'irrigation, carte de plant et feuille
/// d'aide du potager carré.
///
/// Extrait de `planner_widgets.dart`, qui faisait 1 339 lignes.
library;

import 'package:flutter/material.dart';

import '../../../data/regions/regional_calendar.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/region_data.dart';
import '../../../models/garden_plan.dart';
import '../../../models/vegetable.dart';
import '../../../models/weather_data.dart';
import '../../../services/audio_service.dart';
import '../../../services/culture_service.dart';
import '../../../services/prefs_service.dart';
import '../../../theme/app_theme.dart';
import 'garden_planner_screen.dart';

class PlannerPlantPicker extends StatelessWidget {
  final PlannerSeason season;
  final PickerFilter filter;
  final ValueChanged<PlannerSeason> onSeasonChanged;
  final ValueChanged<PickerFilter> onFilterChanged;
  final void Function(String vegId, int col, int row) onPickedDrop;

  const PlannerPlantPicker({
    super.key,
    required this.season,
    required this.filter,
    required this.onSeasonChanged,
    required this.onFilterChanged,
    required this.onPickedDrop,
  });

  /// Map vegetableId → mois de semis, par région. Construit une seule
  /// fois par région puis mis en cache.
  static final Map<Region, Map<String, Set<int>>> _sowingCache =
      <Region, Map<String, Set<int>>>{};

  static Map<String, Set<int>> _sowingFor(Region region) =>
      _sowingCache.putIfAbsent(region, () {
        final list =
            regionalCalendar(region, zone: PrefsService.instance.effectiveZone);
        return <String, Set<int>>{
          for (final r in list) r.vegetableId: r.sowingMonths.toSet(),
        };
      });

  /// Catégories qui ont au moins une plante avec densityPerSqFt.
  /// Ordre : feuilles, fruits, racines, tiges, bulbes, tubercules,
  /// graines, aromates, fleurs.
  static const List<VegetableCategory> _orderedCategories = <VegetableCategory>[
    VegetableCategory.leaves,
    VegetableCategory.fruits,
    VegetableCategory.roots,
    VegetableCategory.stems,
    VegetableCategory.bulbs,
    VegetableCategory.tubers,
    VegetableCategory.seeds,
    VegetableCategory.aromatics,
    VegetableCategory.flowers,
  ];

  @override
  Widget build(BuildContext context) {
    final region = PrefsService.instance.region.value;
    final sowing = _sowingFor(region);
    return ValueListenableBuilder<Set<String>>(
      valueListenable: PrefsService.instance.favorites,
      builder: (ctx, favs, _) {
        final plants = vegetablesBase.where((v) {
          if (v.category == VegetableCategory.accessories) return false;
          if (v.densityPerSqFt == null) return false;
          // Filtre par catégorie / favoris.
          if (filter is FavoritesFilter && !favs.contains(v.id)) return false;
          if (filter is CategoryFilter &&
              v.category != (filter as CategoryFilter).category) {
            return false;
          }
          // Filtre saison (calendrier de la région active).
          if (season == PlannerSeason.all) return true;
          final months = sowing[v.id];
          if (months == null || months.isEmpty) return false;
          return months.intersection(season.months).isNotEmpty;
        }).toList();
        return _buildPicker(context, plants, favs);
      },
    );
  }

  Widget _buildPicker(
      BuildContext context, List<Vegetable> plants, Set<String> favs) {
    return Container(
      decoration: BoxDecoration(
        // Surface du thème (fond crème en clair, sombre en dark) : le
        // blanc en dur rendait le picker illisible en thème sombre.
        color: Theme.of(context).colorScheme.surface,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                'Choisir les plantes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              PopupMenuButton<PlannerSeason>(
                tooltip: 'Filtrer par saison',
                initialValue: season,
                onSelected: onSeasonChanged,
                itemBuilder: (_) =>
                    PlannerSeason.optionsFor(PrefsService.instance.region.value)
                        .map((s) => PopupMenuItem<PlannerSeason>(
                              value: s,
                              child: Row(
                                children: <Widget>[
                                  Text(s.emoji),
                                  const SizedBox(width: 8),
                                  Text(s.label),
                                ],
                              ),
                            ))
                        .toList(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      season.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: KultivaColors.primaryGreen,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                      size: 16,
                      color: KultivaColors.primaryGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Chips horizontaux : Favoris / Toutes / catégories.
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _filterChip(const FavoritesFilter(), '⭐'),
                const SizedBox(width: 6),
                _filterChip(const AllFilter(), '🌍'),
                for (final cat in _orderedCategories) ...<Widget>[
                  const SizedBox(width: 6),
                  _filterChip(CategoryFilter(cat), cat.emoji),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: plants.isEmpty
                ? Center(
                    child: Text(
                      filter is FavoritesFilter
                          ? 'Aucun favori. Ajoute des plantes en favori depuis l\'onglet Étal.'
                          : 'Aucune plante dans ce filtre.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: KultivaColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: plants.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => PlannerPlantCard(plant: plants[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(PickerFilter f, String emoji) {
    final selected = f.runtimeType == filter.runtimeType &&
        (f is! CategoryFilter ||
            (filter is CategoryFilter &&
                (filter as CategoryFilter).category == f.category));
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onFilterChanged(f),
      label: Text('$emoji  ${f.label}', style: const TextStyle(fontSize: 11)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

/// Banner irrigation affiché au-dessus de la grille.
///
/// Synthétise la météo (température, prévision pluie 7j) et donne un
/// conseil d'arrosage agrégé pour le potager carré. Les conseils sont
/// dérivés du modèle utilisé par WateringAdvisor mais en mode "global"
/// plutôt que par culture (le planificateur agrège plusieurs plants).
/// Bandeau d'irrigation au-dessus de la grille du planificateur. Coupé
/// en 2 (refonte demandée par l'user) : météo à gauche + bouton
/// « Arroser tout » à droite. Le bouton marque arrosé toutes les
/// cellules du jardin qui ont une CultureEntry liée.
class PlannerIrrigationBanner extends StatelessWidget {
  final WeatherData? weather;
  final GardenPlan plan;
  const PlannerIrrigationBanner({
    super.key,
    required this.weather,
    required this.plan,
  });

  /// Liste des cultureIds liés aux cellules du plan (cellules qui ont
  /// été créées via _onPlacePlant après la refonte cohérence).
  List<String> _cultureIdsInPlan() {
    return <String>[
      for (final cell in plan.cells.values)
        if (cell.cultureId != null) cell.cultureId!,
    ];
  }

  Future<void> _waterAll(BuildContext context) async {
    final ids = _cultureIdsInPlan();
    if (ids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun plant à arroser dans ce jardin'),
        ),
      );
      return;
    }
    AudioService.instance.play(Sfx.water);
    final count = await CultureService.instance.markManyWatered(ids);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('💧 $count plant(s) arrosé(s)'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final advice = _computeAdvice();
    final cultureCount = _cultureIdsInPlan().length;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            advice.color.withValues(alpha: 0.18),
            advice.color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: advice.color.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Row(
        children: <Widget>[
          // ─── Partie gauche : météo + conseil ───
          Expanded(
            child: Row(
              children: <Widget>[
                Text(advice.emoji, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        advice.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        advice.message,
                        style: const TextStyle(
                          fontSize: 11,
                          color: KultivaColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ─── Séparateur vertical ───
          Container(
            width: 1,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: advice.color.withValues(alpha: 0.35),
          ),
          // ─── Partie droite : bouton Arroser (bleu eau) ───
          GestureDetector(
            onTap: cultureCount > 0 ? () => _waterAll(context) : null,
            child: Opacity(
              opacity: cultureCount > 0 ? 1 : 0.45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: KultivaColors.waterBlue,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: KultivaColors.waterBlue.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Arroser',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.waterBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ({String emoji, String title, String message, Color color}) _computeAdvice() {
    final w = weather;
    if (w == null) {
      return (
        emoji: '💧',
        title: 'Irrigation',
        message: 'Météo en cours de chargement…',
        color: Colors.blue,
      );
    }
    final dailyRain =
        w.dailyPrecipitation.take(3).fold<double>(0, (s, p) => s + p);
    final maxTempNext3 =
        w.dailyTempMax.take(3).fold<double>(0, (m, t) => t > m ? t : m);

    if (dailyRain >= 5) {
      return (
        emoji: '🌧️',
        title: 'Pluie attendue',
        message: 'Pluie cumulée ~ ${dailyRain.toStringAsFixed(0)} mm sur 3j. '
            'Pas besoin d\'arroser pour l\'instant.',
        color: Colors.blue,
      );
    }
    if (maxTempNext3 >= 28) {
      return (
        emoji: '☀️',
        title: 'Forte chaleur',
        message: 'Pic à ${maxTempNext3.toStringAsFixed(0)} °C prévu. Arrose '
            'tôt le matin ou en fin de journée, pailler les pieds.',
        color: Colors.orange,
      );
    }
    return (
      emoji: '🌤️',
      title: 'Conditions normales',
      message: 'Vérifie tes plants : un sol sec sur 3 cm = il faut arroser.',
      color: KultivaColors.primaryGreen,
    );
  }
}

/// Carte d'une plante draggable depuis le picker.
class PlannerPlantCard extends StatelessWidget {
  final Vegetable plant;
  const PlannerPlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 78,
      decoration: BoxDecoration(
        color: KultivaColors.lightGreen.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: plant.imageAsset != null
                    ? Image.asset(
                        plant.imageAsset!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(plant.emoji,
                              style: const TextStyle(fontSize: 30)),
                        ),
                      )
                    : Center(
                        child: Text(plant.emoji,
                            style: const TextStyle(fontSize: 30)),
                      ),
              ),
              const SizedBox(height: 2),
              Text(
                plant.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if ((plant.densityPerSqFt ?? 1) > 1)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: KultivaColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${plant.densityPerSqFt}x',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    // LongPressDraggable plutôt que Draggable : le tap court permet de
    // scroller horizontalement le picker, l'appui long déclenche le drag.
    return LongPressDraggable<String>(
      data: plant.id,
      delay: const Duration(milliseconds: 200),
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(width: 78, height: 78, child: card),
      ),
      childWhenDragging:
          Opacity(opacity: 0.35, child: SizedBox(width: 78, child: card)),
      child: card,
    );
  }
}

/// Sheet d'aide / tutoriel inspiré des screenshots utilisateur.
class PlannerTipsSheet extends StatelessWidget {
  const PlannerTipsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Comment utiliser le planificateur',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Fermer',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const PlannerTipStep(
              n: 1,
              text:
                  "Glisse une plante depuis la barre du bas vers une case de la grille pour la planter.",
            ),
            const PlannerTipStep(
              n: 2,
              text:
                  "Touche une case occupée pour voir les détails ou la vider.",
            ),
            const PlannerTipStep(
              n: 3,
              text:
                  "Le chiffre indique le nombre de plants qui tiennent dans une case (ex. 9 carottes par 30×30 cm).",
            ),
            const PlannerTipStep(
              n: 4,
              text:
                  "Anneau vert autour d'une case = plantes compagnes voisines, anneau rouge = à séparer.",
            ),
            const PlannerTipStep(
              n: 5,
              text:
                  "Chaque case mesure 1×1 pied (≈ 30×30 cm). Configure la taille de ton jardin via « Configurer ».",
            ),
          ],
        );
      },
    );
  }
}

class PlannerTipStep extends StatelessWidget {
  final int n;
  final String text;
  const PlannerTipStep({super.key, required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: KultivaColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$n',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
