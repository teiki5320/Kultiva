import 'package:flutter/material.dart';

import '../../data/regions/france.dart';
import '../../data/regions/west_africa.dart';
import '../../data/vegetables_base.dart';
import '../../models/region_data.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
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
  bool _gridView = false;

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
            final filtered = _filter(region, favs);
            final regionData =
                region == Region.france ? franceData : westAfricaData;
            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  AppBar(
                    title: const Text('Légumes'),
                    actions: [
                      IconButton(
                        icon: Icon(_gridView
                            ? Icons.view_list_rounded
                            : Icons.grid_view_rounded, size: 22),
                        tooltip: _gridView ? 'Vue liste' : 'Vue grille',
                        onPressed: () =>
                            setState(() => _gridView = !_gridView),
                      ),
                      PopupMenuButton<_SortMode>(
                        icon: const Icon(Icons.sort),
                        tooltip: 'Trier',
                        onSelected: (m) => setState(() => _sortMode = m),
                        itemBuilder: (_) => [
                          _sortItem(_SortMode.alpha, Icons.sort_by_alpha,
                              'Alphabétique'),
                          _sortItem(_SortMode.category, Icons.category,
                              'Par catégorie'),
                          _sortItem(
                              _SortMode.sowNow, Icons.eco, 'À semer ce mois'),
                        ],
                      ),
                    ],
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
                        _CategoryChip(
                          label: 'Favoris',
                          emoji: '❤️',
                          selected: _favOnly,
                          onTap: () =>
                              setState(() => _favOnly = !_favOnly),
                        ),
                        _CategoryChip(
                          label: 'Toutes',
                          emoji: '✨',
                          selected:
                              _selectedCategory == null && !_favOnly,
                          onTap: () => setState(() {
                            _selectedCategory = null;
                            _favOnly = false;
                          }),
                        ),
                        for (final cat in VegetableCategory.values)
                          _CategoryChip(
                            label: cat.label,
                            emoji: cat.emoji,
                            selected: _selectedCategory == cat,
                            onTap: () => setState(
                              () => _selectedCategory =
                                  _selectedCategory == cat ? null : cat,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Compteur.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          '${filtered.length} légume${filtered.length > 1 ? "s" : ""}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: KultivaColors.textSecondary,
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

  PopupMenuItem<_SortMode> _sortItem(
      _SortMode mode, IconData icon, String label) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon,
              color: _sortMode == mode
                  ? KultivaColors.primaryGreen
                  : null),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
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
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final v = list[i];
        final sow = _canSow(v, regionData);
        final harvest = _canHarvest(v, regionData);
        final isFav = favs.contains(v.id);
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
              color: sow
                  ? KultivaColors.lightGreen.withOpacity(0.2)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: sow
                    ? KultivaColors.primaryGreen.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(v.emoji,
                          style: const TextStyle(fontSize: 32)),
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text('$emoji  $label'),
        selected: selected,
        onSelected: (_) => onTap(),
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
