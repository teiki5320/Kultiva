import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/companions.dart';
import '../../data/vegetables_base.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../services/notification_service.dart';
import '../../services/watering_service.dart';
import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';

/// Tailles prédéfinies de potager.
enum GardenPreset {
  balcon(2, 3, 'Balcon', '🌿'),
  petit(4, 6, 'Petit jardin', '🏡'),
  grand(6, 10, 'Grand potager', '🌾');

  final int rows;
  final int cols;
  final String label;
  final String emoji;
  const GardenPreset(this.rows, this.cols, this.label, this.emoji);
}

/// Onglet "Mon Potager" — plan visuel interactif du jardin avec grille
/// drag & drop, vérification de compagnonnage, et tailles ajustables.
class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  State<MyGardenScreen> createState() => _MyGardenScreenState();
}

class _MyGardenScreenState extends State<MyGardenScreen> {
  int _rows = 0;
  int _cols = 0;
  late List<List<String?>> _grid; // vegetableId or null
  Map<String, String> _wateredMap = {}; // "r_c" -> ISO timestamp
  bool _initialized = false;
  WeatherData? _weather;
  List<WateringAlert> _alerts = [];
  bool _loadingWeather = false;

  @override
  void initState() {
    super.initState();
    _loadGarden();
  }

  /// Charge la météo et analyse les besoins en arrosage.
  Future<void> _refreshWeather() async {
    if (_loadingWeather) return;
    setState(() => _loadingWeather = true);
    try {
      _weather = await WeatherService.getWeather();
      if (_weather != null) {
        final vegIds = <String>[];
        for (final row in _grid) {
          for (final cell in row) {
            if (cell != null) vegIds.add(cell);
          }
        }
        _alerts = await WateringService.analyzeGarden(vegIds);
        // Envoyer une notification si des légumes ont soif (mobile uniquement).
        NotificationService.checkAndNotify(vegIds);
      }
    } catch (_) {}
    if (mounted) setState(() => _loadingWeather = false);
  }

  Future<void> _loadGarden() async {
    final json = PrefsService.instance.gardenGrid;
    if (json != null) {
      try {
        final data = jsonDecode(json) as Map<String, dynamic>;
        _rows = data['rows'] as int;
        _cols = data['cols'] as int;
        final cells = (data['cells'] as List).cast<String?>();
        _grid = List.generate(
          _rows,
          (r) => List<String?>.generate(
              _cols, (c) => cells[r * _cols + c],
              growable: true),
          growable: true,
        );
        // Charger les timestamps d'arrosage par cellule.
        final w = data['watered'];
        if (w is Map) {
          _wateredMap = w.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
        _initialized = true;
        setState(() {});
        _refreshWeather();
        return;
      } catch (_) {}
    }
    // No saved garden — show setup
    setState(() => _initialized = true);
  }

  void _saveGarden() {
    final cells = <String?>[];
    for (final row in _grid) {
      cells.addAll(row);
    }
    final json = jsonEncode({
      'rows': _rows,
      'cols': _cols,
      'cells': cells,
      'watered': _wateredMap,
    });
    PrefsService.instance.setGardenGrid(json);
  }

  void _createGarden(GardenPreset preset) {
    setState(() {
      _rows = preset.rows;
      _cols = preset.cols;
      _grid = List.generate(
          _rows, (_) => List<String?>.filled(_cols, null, growable: true),
          growable: true);
    });
    _saveGarden();
  }

  void _resetGarden() {
    setState(() {
      _rows = 0;
      _cols = 0;
    });
    PrefsService.instance.setGardenGrid(null);
  }

  void _addRow() {
    setState(() {
      _rows++;
      _grid.add(List<String?>.filled(_cols, null, growable: true));
    });
    _saveGarden();
  }

  void _removeRow() {
    if (_rows <= 1) return;
    setState(() {
      _grid.removeLast();
      _rows--;
    });
    _saveGarden();
  }

  void _addCol() {
    setState(() {
      _cols++;
      for (final row in _grid) {
        row.add(null);
      }
    });
    _saveGarden();
  }

  void _removeCol() {
    if (_cols <= 1) return;
    setState(() {
      _cols--;
      for (final row in _grid) {
        row.removeLast();
      }
    });
    _saveGarden();
  }

  void _placeVegetable(int row, int col, String? vegId) {
    setState(() {
      _grid[row][col] = vegId;
      if (vegId == null) _wateredMap.remove('${row}_$col');
    });
    _saveGarden();
    _refreshWeather();
  }

  /// Arrose une cellule spécifique (pas global).
  void _waterCell(int row, int col) {
    setState(() {
      _wateredMap['${row}_$col'] = DateTime.now().toIso8601String();
    });
    _saveGarden();
  }

  /// Jours secs effectifs pour une cellule.
  /// = min(jours sans pluie météo, jours depuis arrosage manuel).
  int _cellDryDays(int row, int col) {
    final weatherDry = _weather?.consecutiveDryDays ?? 0;
    final key = '${row}_$col';
    final ts = _wateredMap[key];
    if (ts == null) return weatherDry;
    final last = DateTime.tryParse(ts);
    if (last == null) return weatherDry;
    final manualDry = DateTime.now().difference(last).inDays;
    return manualDry < weatherDry ? manualDry : weatherDry;
  }

  /// Check if a vegetable at (row, col) has any incompatible neighbors.
  List<String> _getWarnings(int row, int col) {
    final vegId = _grid[row][col];
    if (vegId == null) return [];
    final incompatibles = incompatibleMap[vegId] ?? [];
    if (incompatibles.isEmpty) return [];
    final warnings = <String>[];
    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;
        final nr = row + dr, nc = col + dc;
        if (nr < 0 || nr >= _rows || nc < 0 || nc >= _cols) continue;
        final neighbor = _grid[nr][nc];
        if (neighbor != null && incompatibles.contains(neighbor)) {
          final veg = vegetablesBase.where((v) => v.id == neighbor).firstOrNull;
          if (veg != null) warnings.add(veg.name);
        }
      }
    }
    return warnings;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          AppBar(
            title: const Text('Mon Potager'),
            actions: [
              if (_rows > 0)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.tune),
                  onSelected: (v) {
                    switch (v) {
                      case 'add_row':
                        _addRow();
                      case 'remove_row':
                        _removeRow();
                      case 'add_col':
                        _addCol();
                      case 'remove_col':
                        _removeCol();
                      case 'reset':
                        _resetGarden();
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: 'add_row', child: Text('+ Ajouter une ligne')),
                    const PopupMenuItem(
                        value: 'remove_row',
                        child: Text('- Supprimer une ligne')),
                    const PopupMenuItem(
                        value: 'add_col',
                        child: Text('+ Ajouter une colonne')),
                    const PopupMenuItem(
                        value: 'remove_col',
                        child: Text('- Supprimer une colonne')),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                        value: 'reset',
                        child: Text('Recommencer',
                            style: TextStyle(color: Colors.red))),
                  ],
                ),
            ],
          ),
          Expanded(
            child: _rows == 0 ? _buildSetup() : _buildGarden(),
          ),
        ],
      ),
    );
  }

  Widget _buildSetup() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: KultivaColors.lightGreen.withOpacity(0.35),
                borderRadius: BorderRadius.circular(36),
              ),
              alignment: Alignment.center,
              child: const Text('🌱', style: TextStyle(fontSize: 70)),
            ),
            const SizedBox(height: 24),
            Text(
              "Planifie ton potager",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choisis une taille de départ, puis ajuste comme tu veux.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            for (final preset in GardenPreset.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _createGarden(preset),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KultivaColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      '${preset.emoji}  ${preset.label}  (${preset.rows}×${preset.cols})',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Vérifie si un légume spécifique a besoin d'arrosage.
  WateringAlert? _alertFor(String vegId) {
    try {
      return _alerts.firstWhere((a) => a.vegetable.id == vegId);
    } catch (_) {
      return null;
    }
  }

  Widget _buildGarden() {
    final urgentAlerts = _alerts.where((a) => a.needsWatering).toList();
    // Compter les plantes et trouver celles en alerte avec position.
    int plantCount = 0;
    final alertCells = <({int r, int c, String vegId, int dryDays})>[];
    for (int r = 0; r < _rows; r++) {
      for (int c = 0; c < _cols; c++) {
        final id = _grid[r][c];
        if (id == null) continue;
        plantCount++;
        final veg = vegetablesBase.where((v) => v.id == id).firstOrNull;
        if (veg != null) {
          final dry = _cellDryDays(r, c);
          if (dry >= veg.effectiveWateringDays) {
            alertCells.add((r: r, c: c, vegId: id, dryDays: dry));
          }
        }
      }
    }
    return Column(
      children: [
        // Barre résumé compacte.
        _SummaryBar(
          plantCount: plantCount,
          alertCount: alertCells.length,
          weather: _weather,
          loading: _loadingWeather,
          onRefresh: _refreshWeather,
        ),
        // Chips alertes arrosage.
        if (alertCells.isNotEmpty)
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: alertCells.length,
              itemBuilder: (ctx, i) {
                final a = alertCells[i];
                final veg = vegetablesBase
                    .where((v) => v.id == a.vegId)
                    .firstOrNull;
                if (veg == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ActionChip(
                    avatar: Text(veg.emoji, style: const TextStyle(fontSize: 14)),
                    label: Text(
                      '${a.dryDays}j',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor:
                        KultivaColors.terracotta.withOpacity(0.15),
                    side: BorderSide(
                      color: KultivaColors.terracotta.withOpacity(0.3),
                    ),
                    onPressed: () {
                      _waterCell(a.r, a.c);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${veg.emoji} ${veg.name} arrosé !'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                'Grille $_rows × $_cols',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                'Tape une case pour placer un légume',
                style: TextStyle(
                  fontSize: 12,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: List.generate(_rows, (r) {
                  return Row(
                    children: List.generate(_cols, (c) {
                      final cellId = _grid[r][c];
                      return _GardenCell(
                        vegId: cellId,
                        warnings: _getWarnings(r, c),
                        waterAlert: cellId != null ? _alertFor(cellId) : null,
                        onTap: () => _showPicker(r, c),
                        onClear: () => _placeVegetable(r, c, null),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(int row, int col) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return _VegetablePicker(
          onSelected: (vegId) {
            _placeVegetable(row, col, vegId);
            Navigator.pop(ctx);
          },
        );
      },
    );
  }
}

/// Picker de légumes avec recherche et filtre favoris.
class _VegetablePicker extends StatefulWidget {
  final ValueChanged<String> onSelected;
  const _VegetablePicker({required this.onSelected});

  @override
  State<_VegetablePicker> createState() => _VegetablePickerState();
}

class _VegetablePickerState extends State<_VegetablePicker> {
  String _query = '';
  bool _favOnly = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return ValueListenableBuilder<Set<String>>(
          valueListenable: PrefsService.instance.favorites,
          builder: (ctx, favs, _) {
            var list = List<Vegetable>.from(vegetablesBase);
            if (_favOnly) {
              list = list.where((v) => favs.contains(v.id)).toList();
            }
            if (_query.isNotEmpty) {
              final q = _query.toLowerCase();
              list = list
                  .where((v) =>
                      v.name.toLowerCase().contains(q) ||
                      v.category.label.toLowerCase().contains(q))
                  .toList();
            }
            // Favoris en premier, puis alphabétique.
            list.sort((a, b) {
              final aFav = favs.contains(a.id) ? 0 : 1;
              final bFav = favs.contains(b.id) ? 0 : 1;
              final cmp = aFav.compareTo(bFav);
              return cmp != 0 ? cmp : a.name.compareTo(b.name);
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => setState(() => _query = v.trim()),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un légume…',
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text('❤️ Favoris'),
                        selected: _favOnly,
                        onSelected: (v) => setState(() => _favOnly = v),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${list.length} légume${list.length > 1 ? "s" : ""}',
                        style: TextStyle(
                          color: KultivaColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: list.isEmpty
                      ? Center(
                          child: Text(
                            'Aucun résultat',
                            style: TextStyle(
                              color: KultivaColors.textSecondary,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollCtrl,
                          itemCount: list.length,
                          itemBuilder: (ctx, i) {
                            final v = list[i];
                            final isFav = favs.contains(v.id);
                            return ListTile(
                              leading: Text(v.emoji,
                                  style: const TextStyle(fontSize: 28)),
                              title: Text(v.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(v.category.label),
                              trailing: isFav
                                  ? Icon(Icons.favorite,
                                      size: 16,
                                      color: KultivaColors.terracotta)
                                  : null,
                              onTap: () => widget.onSelected(v.id),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final int plantCount;
  final int alertCount;
  final WeatherData? weather;
  final bool loading;
  final VoidCallback onRefresh;
  const _SummaryBar({
    required this.plantCount,
    required this.alertCount,
    required this.weather,
    required this.loading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text('🌱', style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text('$plantCount',
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(width: 12),
            if (alertCount > 0) ...[
              Text('💧', style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text('$alertCount',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.terracotta)),
              const SizedBox(width: 12),
            ],
            if (weather != null) ...[
              Text(weather!.weatherEmoji,
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text('${weather!.currentTemp.toStringAsFixed(0)}°C',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
            if (loading && weather == null)
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            const Spacer(),
            GestureDetector(
              onTap: onRefresh,
              child: const Icon(Icons.refresh, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// _WateringAlertBanner supprimé — remplacé par les chips inline dans _buildGarden.

class _GardenCell extends StatelessWidget {
  final String? vegId;
  final List<String> warnings;
  final WateringAlert? waterAlert;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _GardenCell({
    required this.vegId,
    required this.warnings,
    this.waterAlert,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final veg = vegId != null
        ? vegetablesBase.where((v) => v.id == vegId).firstOrNull
        : null;
    final hasWarning = warnings.isNotEmpty;
    final needsWater = waterAlert?.needsWatering ?? false;

    return GestureDetector(
      onTap: onTap,
      onLongPress: vegId != null ? onClear : null,
      child: Tooltip(
        message: veg != null
            ? '${veg.name}'
                '${hasWarning ? "\n⚠️ Mauvais voisin : ${warnings.join(", ")}" : ""}'
                '${needsWater ? "\n💧 ${waterAlert!.message}" : ""}'
            : 'Case vide — tape pour placer',
        child: Container(
          width: 72,
          height: 72,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: veg != null
                ? (hasWarning
                    ? KultivaColors.terracotta.withOpacity(0.15)
                    : KultivaColors.lightGreen.withOpacity(0.25))
                : Colors.grey.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasWarning
                  ? KultivaColors.terracotta
                  : (veg != null
                      ? KultivaColors.primaryGreen.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.2)),
              width: hasWarning ? 2.5 : 1,
            ),
          ),
          child: veg != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(veg.emoji, style: const TextStyle(fontSize: 22)),
                    Text(
                      veg.name,
                      style: const TextStyle(
                          fontSize: 9, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasWarning)
                          const Text('⚠️', style: TextStyle(fontSize: 9)),
                        if (needsWater)
                          Text(waterAlert!.emoji,
                              style: const TextStyle(fontSize: 9)),
                      ],
                    ),
                  ],
                )
              : Icon(Icons.add, size: 20, color: Colors.grey.withOpacity(0.4)),
        ),
      ),
    );
  }
}
