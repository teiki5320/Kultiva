import 'package:flutter/material.dart';

import '../../data/regions/regional_calendar.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../utils/months.dart';
import '../../utils/text_normalize.dart';
import '../../theme/app_theme.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';
import '../vegetable_detail_screen.dart';

/// Vue calendrier annuel — une ligne par légume, douze segments.
///
/// C'était un tableau de 130 lignes sur 12 colonnes qu'on faisait
/// défiler latéralement : sur un téléphone on voyait quatre mois, et
/// il fallait garder en tête le nom du légume parti hors écran à
/// gauche. Depuis le 31/10/2026, chaque légume occupe une ligne
/// pleine largeur — son nom au-dessus, son année en dessous sous
/// forme de barre de douze segments. Plus rien ne défile de côté.
class CalendarGridScreen extends StatefulWidget {
  const CalendarGridScreen({super.key});

  @override
  State<CalendarGridScreen> createState() => _CalendarGridScreenState();
}

class _CalendarGridScreenState extends State<CalendarGridScreen> {
  /// Filtre actif — null = tout afficher, sinon ne montre que les légumes
  /// avec une activité (semis ou récolte) durant ce mois.
  int? _filterMonth;

  /// L'année d'un légume en une phrase, pour les lecteurs d'écran.
  ///
  /// Une barre de douze segments colorés n'existe pas pour VoiceOver.
  /// L'ancienne grille donnait douze cases dont la plupart disaient
  /// « rien à faire » : on résume la ligne entière à la place.
  static String _rowSummary(Vegetable veg, RegionData rd) {
    final parts = <String>[];
    final semis = monthRangesLabel(rd.sowingMonths);
    final recolte = monthRangesLabel(rd.harvestMonths);
    if (semis.isNotEmpty) parts.add('semis $semis');
    if (recolte.isNotEmpty) parts.add('récolte $recolte');
    if (parts.isEmpty) return '${veg.name} : aucune période connue';
    return '${veg.name} : ${parts.join(', ')}';
  }

  void _openVegetable(Vegetable v) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VegetableDetailScreen(vegetable: v),
      ),
    );
  }

  void _toggleMonth(int month) {
    setState(() => _filterMonth = _filterMonth == month ? null : month);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().month;
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final regionData =
            regionalCalendar(region, zone: PrefsService.instance.effectiveZone);
        var entries = regionData.toList()
          ..sort((a, b) {
            final va =
                vegetablesBase.where((v) => v.id == a.vegetableId).firstOrNull;
            final vb =
                vegetablesBase.where((v) => v.id == b.vegetableId).firstOrNull;
            return compareFolded(va?.name ?? '', vb?.name ?? '');
          });

        // Filtre par mois actif.
        if (_filterMonth != null) {
          entries = entries
              .where((rd) =>
                  rd.sowingMonths.contains(_filterMonth) ||
                  rd.harvestMonths.contains(_filterMonth))
              .toList();
        }

        return Scaffold(
          body: Column(
            children: [
              // Header saisonnier avec flèche retour + bouton filtre off.
              Stack(
                children: [
                  SeasonHeader(
                    season: Season.of(_filterMonth ?? now, region,
                        zone: PrefsService.instance.effectiveZone),
                    month: _filterMonth ?? now,
                    height: 150,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: SafeArea(
                      child: Semantics(
                        label: 'Fermer le calendrier',
                        button: true,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_filterMonth != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: SafeArea(
                        child: Semantics(
                          label: 'Afficher tous les mois',
                          button: true,
                          child: GestureDetector(
                            onTap: () => setState(() => _filterMonth = null),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.filter_alt_off,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Légende.
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: KultivaColors.lightGreen.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    const _LegendItem(
                        color: KultivaColors.primaryGreen, label: 'Semis'),
                    const SizedBox(width: 16),
                    const _LegendItem(
                        color: KultivaColors.terracotta, label: 'Récolte'),
                    const SizedBox(width: 12),
                    const _LegendItem(
                      color: KultivaColors.primaryGreen,
                      secondColor: KultivaColors.terracotta,
                      label: 'Les deux',
                    ),
                    const SizedBox(width: 12),
                    // `Expanded` et pas `Spacer` : sur un iPhone SE à
                    // grosse police, la légende et l'astuce ne tiennent
                    // pas sur 320 pt, et un `Row` qui déborde est une
                    // barre jaune en travers de l'écran.
                    Expanded(
                      child: _filterMonth != null
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: KultivaColors.primaryGreen
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${monthNamesLongCap[_filterMonth! - 1]} '
                                  '(${entries.length})',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: KultivaColors.primaryGreen,
                                  ),
                                ),
                              ),
                            )
                          : const Text(
                              '💡 Tap mois = filtre',
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                color: KultivaColors.textSecondary,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              _MonthHeader(
                currentMonth: now,
                filterMonth: _filterMonth,
                onTapMonth: _toggleMonth,
              ),
              Expanded(
                child: entries.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            "Rien à semer ni à récolter ce mois-ci dans ta "
                            'région.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: KultivaColors.textSecondary,
                                fontSize: 13),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          // Colonne du mois en cours, derrière la liste :
                          // elle apparaît entre les lignes et sous les
                          // noms, et situe l'instant présent dans l'année.
                          Positioned.fill(
                            child: IgnorePointer(
                              child: _CurrentMonthColumn(month: now),
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 4, bottom: 24),
                            itemCount: entries.length,
                            itemBuilder: (context, i) {
                              final rd = entries[i];
                              final veg = vegetablesBase
                                  .where((v) => v.id == rd.vegetableId)
                                  .firstOrNull;
                              if (veg == null) return const SizedBox.shrink();
                              return _VegetableYearRow(
                                vegetable: veg,
                                data: rd,
                                summary: _rowSummary(veg, rd),
                                onTap: () => _openVegetable(veg),
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Les douze initiales de mois, alignées sur les barres en dessous.
///
/// Reste en haut quand la liste défile : c'est la seule chose qui dit
/// à quel mois correspond un segment.
class _MonthHeader extends StatelessWidget {
  final int currentMonth;
  final int? filterMonth;
  final ValueChanged<int> onTapMonth;

  const _MonthHeader({
    required this.currentMonth,
    required this.filterMonth,
    required this.onTapMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: <Widget>[
          for (int m = 1; m <= 12; m++)
            Expanded(
              child: Semantics(
                label: monthNamesLongCap[m - 1],
                hint: 'Filtre le calendrier sur ce mois',
                button: true,
                selected: filterMonth == m,
                excludeSemantics: true,
                child: GestureDetector(
                  onTap: () => onTapMonth(m),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: filterMonth == m
                          ? KultivaColors.primaryGreen.withValues(alpha: 0.2)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      monthNamesShortCap[m - 1].substring(0, 1),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: m == currentMonth
                            ? KultivaColors.primaryGreen
                            : KultivaColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Bande verticale translucide sur la colonne du mois en cours.
class _CurrentMonthColumn extends StatelessWidget {
  final int month;
  const _CurrentMonthColumn({required this.month});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          for (int m = 1; m <= 12; m++)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                color: m == month
                    ? KultivaColors.primaryGreen.withValues(alpha: 0.08)
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}

/// Un légume et son année : le nom, puis douze segments.
class _VegetableYearRow extends StatelessWidget {
  final Vegetable vegetable;
  final RegionData data;
  final String summary;
  final VoidCallback onTap;

  const _VegetableYearRow({
    required this.vegetable,
    required this.data,
    required this.summary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: summary,
      hint: 'Ouvre sa fiche',
      button: true,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(vegetable.emoji, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      vegetable.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (data.regionalNote != null)
                    const Icon(Icons.info_outline,
                        size: 13, color: KultivaColors.textSecondary),
                ],
              ),
              const SizedBox(height: 4),
              _YearBar(data: data),
            ],
          ),
        ),
      ),
    );
  }
}

/// Douze segments côte à côte : vert pour un semis, terracotta pour
/// une récolte, dégradé des deux quand les deux tombent le même mois.
///
/// Les segments se touchent, sans écart : une période de semis de mars
/// à juin doit se lire comme une seule bande, pas comme quatre carrés.
class _YearBar extends StatelessWidget {
  final RegionData data;
  const _YearBar({required this.data});

  @override
  Widget build(BuildContext context) {
    final sombre = Theme.of(context).brightness == Brightness.dark;
    final vide = sombre
        ? KultivaColors.darkCard
        : KultivaColors.lightGreen.withValues(alpha: 0.22);
    return Row(
      children: <Widget>[
        for (int m = 1; m <= 12; m++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: _segment(m, vide),
              ),
            ),
          ),
      ],
    );
  }

  Widget _segment(int month, Color vide) {
    final sow = data.sowingMonths.contains(month);
    final harvest = data.harvestMonths.contains(month);
    if (sow && harvest) {
      // Deux arrêts au même point : une coupe nette, pas un dégradé.
      // Le fondu donnait une bouillie brune qu'on ne reconnaissait ni
      // comme du vert ni comme du terracotta.
      return Container(
        height: 20,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: <double>[0.5, 0.5],
            colors: <Color>[
              KultivaColors.primaryGreen,
              KultivaColors.terracotta,
            ],
          ),
        ),
      );
    }
    return Container(
      height: 20,
      color: sow
          ? KultivaColors.primaryGreen
          : harvest
              ? KultivaColors.terracotta
              : vide,
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;

  /// Rempli, la pastille est coupée en deux : c'est le cas « semis et
  /// récolte le même mois », qui concerne une trentaine de cultures.
  final Color? secondColor;
  final String label;
  const _LegendItem({
    required this.color,
    required this.label,
    this.secondColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: secondColor == null ? color : null,
            gradient: secondColor == null
                ? null
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const <double>[0.5, 0.5],
                    colors: <Color>[color, secondColor!],
                  ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(label,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
