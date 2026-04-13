import 'package:flutter/material.dart';

import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/petal_animation.dart';
import '../../widgets/vegetable_card.dart';
import '../vegetable_detail_screen.dart';

/// Modes de tri disponibles pour le catalogue.
enum _SortMode { alpha, category, sowNow }

/// Onglet "Légumes" — catalogue complet avec recherche, filtre par
/// catégorie et options de tri.
class VegetablesScreen extends StatefulWidget {
  const VegetablesScreen({super.key});

  @override
  State<VegetablesScreen> createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  VegetableCategory? _selectedCategory;
  String _query = '';
  _SortMode _sortMode = _SortMode.alpha;
  bool _favOnly = false;
  bool _gridView = true;
  bool _initialFavChecked = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Vegetable> _filter(Region region, Set<String> favs) {
    final now = DateTime.now().month;
    final regionData =
        region == Region.france ? franceData : westAfricaData;

    final filtered = vegetablesBase.where((v) {
      if (_favOnly && !favs.contains(v.id)) return false;
      if (_selectedCategory != null && v.category != _selectedCategory) {
        return false;
      }
      if (_query.isNotEmpty) {
        final q = _query.toLowerCase();
        return v.name.toLowerCase().contains(q) ||
            (v.description?.toLowerCase().contains(q) ?? false);
      }
      return true;
    }).toList();

    switch (_sortMode) {
      case _SortMode.alpha:
        filtered.sort((a, b) => a.name.compareTo(b.name));
      case _SortMode.category:
        filtered.sort((a, b) {
          final cmp = a.category.label.compareTo(b.category.label);
          return cmp != 0 ? cmp : a.name.compareTo(b.name);
        });
      case _SortMode.sowNow:
        filtered.sort((a, b) {
          final aCanSow = regionData.any(
              (rd) => rd.vegetableId == a.id && rd.sowingMonths.contains(now));
          final bCanSow = regionData.any(
              (rd) => rd.vegetableId == b.id && rd.sowingMonths.contains(now));
          if (aCanSow && !bCanSow) return -1;
          if (!aCanSow && bCanSow) return 1;
          return a.name.compareTo(b.name);
        });
    }
    return filtered;
  }

  bool _canSow(Vegetable v, List<RegionData> regionData) {
    final now = DateTime.now().month;
    return regionData.any(
        (rd) => rd.vegetableId == v.id && rd.sowingMonths.contains(now));
  }

  bool _canHarvest(Vegetable v, List<RegionData> regionData) {
    final now = DateTime.now().month;
    return regionData.any(
        (rd) => rd.vegetableId == v.id && rd.harvestMonths.contains(now));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        return ValueListenableBuilder<Set<String>>(
          valueListenable: PrefsService.instance.favorites,
          builder: (context, favs, _) {
            // Au premier affichage, activer favoris si non vide.
            if (!_initialFavChecked) {
              _initialFavChecked = true;
              if (favs.isNotEmpty) {
                _favOnly = true;
              }
            }
            final filtered = _filter(region, favs);
            final regionData =
                region == Region.france ? franceData : westAfricaData;
            final season = Season.fromMonth(DateTime.now().month);
            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header kawaii saisonnier.
                  _KawaiiHeader(
                    season: season,
                    count: filtered.length,
                    gridView: _gridView,
                    onToggleView: () =>
                        setState(() => _gridView = !_gridView),
                    sortMode: _sortMode,
                    onSortChanged: (m) =>
                        setState(() => _sortMode = m),
                  ),
                  // Barre de recherche.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _query = v.trim()),
                      decoration: InputDecoration(
                        hintText: 'Rechercher un légume…',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _searchCtrl.clear();
                                  setState(() => _query = '');
                                },
                              ),
                      ),
                    ),
                  ),
                  // Chips catégories + favoris.
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        _PastelChip(
                          label: 'Favoris',
                          emoji: '❤️',
                          color: KultivaColors.terracotta,
                          selected: _favOnly,
                          onTap: () =>
                              setState(() => _favOnly = !_favOnly),
                        ),
                        _PastelChip(
                          label: 'Toutes',
                          emoji: '✨',
                          color: KultivaColors.primaryGreen,
                          selected:
                              _selectedCategory == null && !_favOnly,
                          onTap: () => setState(() {
                            _selectedCategory = null;
                            _favOnly = false;
                          }),
                        ),
                        for (final cat in VegetableCategory.values)
                          _PastelChip(
                            label: cat.label,
                            emoji: cat.emoji,
                            color: _categoryColor(cat),
                            selected: _selectedCategory == cat,
                            onTap: () => setState(
                              () => _selectedCategory =
                                  _selectedCategory == cat ? null : cat,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Liste ou grille.
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('🌱',
                                    style: const TextStyle(fontSize: 48)),
                                const SizedBox(height: 12),
                                Text(
                                  'Aucun légume trouvé',
                                  style: TextStyle(
                                    color: KultivaColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _gridView
                            ? _buildGrid(filtered, favs, regionData)
                            : _buildList(filtered, favs, regionData),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildList(
      List<Vegetable> list, Set<String> favs, List<RegionData> regionData) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final v = list[i];
        return VegetableCard(
          vegetable: v,
          canSowNow: _canSow(v, regionData),
          isFavorite: favs.contains(v.id),
          onFavoriteToggle: () =>
              PrefsService.instance.toggleFavorite(v.id),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => VegetableDetailScreen(
                vegetable: v,
                vegetables: list,
                initialIndex: i,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid(
      List<Vegetable> list, Set<String> favs, List<RegionData> regionData) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adapter le nombre de colonnes à la largeur.
        final cols = constraints.maxWidth > 900 ? 8 : (constraints.maxWidth > 600 ? 6 : (constraints.maxWidth > 400 ? 4 : 3));
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemCount: list.length,
          itemBuilder: (context, i) {
        final v = list[i];
        final sow = _canSow(v, regionData);
        final harvest = _canHarvest(v, regionData);
        final isFav = favs.contains(v.id);
        final cc = _categoryColor(v.category);
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => VegetableDetailScreen(
                vegetable: v,
                vegetables: list,
                initialIndex: i,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cc.withOpacity(0.12),
                  cc.withOpacity(0.25),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: cc.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // Bulles kawaii.
                Positioned(
                  top: -8, right: -8,
                  child: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cc.withOpacity(0.12),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8, left: -6,
                  child: Container(
                    width: 18, height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cc.withOpacity(0.08),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Emoji dans cercle blanc.
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(v.emoji,
                            style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          v.name,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // Badges saison.
                if (sow || harvest)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Row(
                      children: [
                        if (sow)
                          _MiniTag(
                              label: 'Semer',
                              color: KultivaColors.primaryGreen),
                        if (sow && harvest) const SizedBox(width: 3),
                        if (harvest)
                          _MiniTag(
                              label: 'Récolte',
                              color: KultivaColors.terracotta),
                      ],
                    ),
                  ),
                // Favori.
                if (isFav)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(Icons.favorite,
                        size: 14, color: KultivaColors.terracotta),
                  ),
                // Indicateur catégorie.
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _categoryColor(v.category),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
      },
    );
  }

  Color _categoryColor(VegetableCategory cat) {
    switch (cat) {
      case VegetableCategory.fruits:
        return KultivaColors.terracotta;
      case VegetableCategory.leaves:
        return KultivaColors.primaryGreen;
      case VegetableCategory.roots:
        return const Color(0xFF8B6914);
      case VegetableCategory.bulbs:
        return const Color(0xFFB39DDB);
      case VegetableCategory.tubers:
        return const Color(0xFF795548);
      case VegetableCategory.flowers:
        return KultivaColors.springA;
      case VegetableCategory.seeds:
        return KultivaColors.summerA;
      case VegetableCategory.stems:
        return const Color(0xFF66BB6A);
      case VegetableCategory.aromatics:
        return const Color(0xFF26A69A);
    }
  }
}

// Header kawaii saisonnier.
class _KawaiiHeader extends StatelessWidget {
  final Season season;
  final int count;
  final bool gridView;
  final VoidCallback onToggleView;
  final _SortMode sortMode;
  final ValueChanged<_SortMode> onSortChanged;

  const _KawaiiHeader({
    required this.season,
    required this.count,
    required this.gridView,
    required this.onToggleView,
    required this.sortMode,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _seasonColors(season);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors[0].withOpacity(0.4), colors[1].withOpacity(0.3)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Text(season.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Catalogue',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                Text(
                  '$count légume${count > 1 ? "s" : ""}',
                  style: TextStyle(
                    fontSize: 12,
                    color: KultivaColors.textPrimary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(gridView
                ? Icons.view_list_rounded
                : Icons.grid_view_rounded, size: 22),
            onPressed: onToggleView,
          ),
          PopupMenuButton<_SortMode>(
            icon: const Icon(Icons.sort, size: 22),
            onSelected: onSortChanged,
            itemBuilder: (_) => [
              _sortItem(_SortMode.alpha, 'Alphabétique'),
              _sortItem(_SortMode.category, 'Par catégorie'),
              _sortItem(_SortMode.sowNow, 'À semer ce mois'),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_SortMode> _sortItem(_SortMode mode, String label) {
    return PopupMenuItem(
      value: mode,
      child: Text(label,
          style: TextStyle(
            fontWeight: sortMode == mode ? FontWeight.w800 : FontWeight.w500,
            color: sortMode == mode ? KultivaColors.primaryGreen : null,
          )),
    );
  }

  List<Color> _seasonColors(Season s) {
    switch (s) {
      case Season.spring:
        return [KultivaColors.springA, KultivaColors.springB];
      case Season.summer:
        return [KultivaColors.summerA, KultivaColors.summerB];
      case Season.autumn:
        return [KultivaColors.autumnA, KultivaColors.autumnB];
      case Season.winter:
        return [KultivaColors.winterA, KultivaColors.winterB];
    }
  }
}

// Chip pastel coloré par catégorie.
class _PastelChip extends StatelessWidget {
  final String label;
  final String emoji;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _PastelChip({
    required this.label,
    required this.emoji,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.25) : color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? color : color.withOpacity(0.15),
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Text(
            '$emoji $label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? color : KultivaColors.textPrimary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
