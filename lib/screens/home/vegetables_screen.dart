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

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Vegetable> _filter(Region region) {
    final now = DateTime.now().month;
    final regionData =
        region == Region.france ? franceData : westAfricaData;

    final filtered = vegetablesBase.where((v) {
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        final filtered = _filter(region);
        return SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              AppBar(
                title: const Text('Légumes'),
                actions: [
                  PopupMenuButton<_SortMode>(
                    icon: const Icon(Icons.sort),
                    tooltip: 'Trier',
                    onSelected: (mode) => setState(() => _sortMode = mode),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: _SortMode.alpha,
                        child: Row(
                          children: [
                            Icon(Icons.sort_by_alpha,
                                color: _sortMode == _SortMode.alpha
                                    ? KultivaColors.primaryGreen
                                    : null),
                            const SizedBox(width: 8),
                            const Text('Alphabétique'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: _SortMode.category,
                        child: Row(
                          children: [
                            Icon(Icons.category,
                                color: _sortMode == _SortMode.category
                                    ? KultivaColors.primaryGreen
                                    : null),
                            const SizedBox(width: 8),
                            const Text('Par catégorie'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: _SortMode.sowNow,
                        child: Row(
                          children: [
                            Icon(Icons.eco,
                                color: _sortMode == _SortMode.sowNow
                                    ? KultivaColors.primaryGreen
                                    : null),
                            const SizedBox(width: 8),
                            const Text('À semer ce mois'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: <Widget>[
                    _CategoryChip(
                      label: 'Toutes',
                      emoji: '✨',
                      selected: _selectedCategory == null,
                      onTap: () => setState(() => _selectedCategory = null),
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
              const SizedBox(height: 4),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            "Aucun légume ne correspond à ta recherche.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: KultivaColors.textSecondary,
                                ),
                          ),
                        ),
                      )
                    : ValueListenableBuilder<Set<String>>(
                        valueListenable: PrefsService.instance.favorites,
                        builder: (context, favs, _) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final v = filtered[index];
                              return VegetableCard(
                                vegetable: v,
                                isFavorite: favs.contains(v.id),
                                onFavoriteToggle: () => PrefsService.instance
                                    .toggleFavorite(v.id),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        VegetableDetailScreen(
                                          vegetable: v,
                                          vegetables: filtered,
                                          initialIndex: index,
                                        ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
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
