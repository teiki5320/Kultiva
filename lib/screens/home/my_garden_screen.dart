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
import '../../widgets/petal_animation.dart';
import '../../widgets/season_header.dart';

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

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5EE),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            child: SizedBox(
              height: 170,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/potager.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [KultivaColors.springA, KultivaColors.springB],
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  const _GardenParticleAnimation(),
                  Positioned(
                    left: 20, bottom: 12,
                    child: Text('Mon Potager',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        shadows: const [
                          Shadow(color: Colors.black45, blurRadius: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _rows == 0 ? _buildSetup() : _buildGarden(),
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetup() {
    return SingleChildScrollView(
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
        // Bannière arrosage claire.
        if (alertCells.isNotEmpty)
          GestureDetector(
            onTap: () {
              for (final a in alertCells) {
                _waterCell(a.r, a.c);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '💧 ${alertCells.length} plante${alertCells.length > 1 ? "s" : ""} arrosée${alertCells.length > 1 ? "s" : ""} !'),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  KultivaColors.terracotta.withOpacity(0.15),
                  KultivaColors.summerA.withOpacity(0.1),
                ]),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: KultivaColors.terracotta.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Text('💧', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${alertCells.length} plante${alertCells.length > 1 ? "s ont" : " a"} soif — Tap pour tout arroser',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: KultivaColors.terracotta,
                      ),
                    ),
                  ),
                  Icon(Icons.water_drop, color: KultivaColors.terracotta, size: 18),
                ],
              ),
            ),
          ),
        // Barre de progression.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '$plantCount / ${_rows * _cols} cases plantées',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    'Tap = planter · Appui long = détails',
                    style: TextStyle(fontSize: 10, color: KultivaColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: (_rows * _cols) > 0 ? plantCount / (_rows * _cols) : 0,
                  minHeight: 6,
                  backgroundColor: KultivaColors.lightGreen.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(KultivaColors.primaryGreen),
                ),
              ),
            ],
          ),
        ),
        // Cadre bois + pelouse + grille.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8F0),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8B4B8),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE8B4B8).withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomPaint(
                  painter: _GridPainter(),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: List.generate(_rows, (r) {
                            return Row(
                              children: List.generate(_cols, (c) {
                                final cellId = _grid[r][c];
                                final veg = cellId != null
                                    ? vegetablesBase.where((v) => v.id == cellId).firstOrNull
                                    : null;
                                final dryDays = cellId != null ? _cellDryDays(r, c) : 0;
                                final threshold = veg?.effectiveWateringDays ?? 4;
                                return _GardenCell(
                                  veg: veg,
                                  dryDays: dryDays,
                                  threshold: threshold,
                                  warnings: _getWarnings(r, c),
                                  onTap: () => _showPicker(r, c),
                                  onLongPress: veg != null
                                      ? () => _showPlantDetail(r, c, veg)
                                      : null,
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _GridButton(icon: Icons.add, label: 'Ligne', onTap: _addRow),
              const SizedBox(width: 8),
              _GridButton(icon: Icons.remove, label: 'Ligne', onTap: _removeRow),
              const SizedBox(width: 16),
              _GridButton(icon: Icons.add, label: 'Colonne', onTap: _addCol),
              const SizedBox(width: 8),
              _GridButton(icon: Icons.remove, label: 'Colonne', onTap: _removeCol),
              const Spacer(),
              TextButton(
                onPressed: _resetGarden,
                child: Text('Recommencer',
                    style: TextStyle(color: Colors.red.shade300, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPlantDetail(int row, int col, Vegetable veg) {
    final dryDays = _cellDryDays(row, col);
    final threshold = veg.effectiveWateringDays;
    final key = '${row}_$col';
    final lastTs = _wateredMap[key];
    final lastWatered = lastTs != null ? DateTime.tryParse(lastTs) : null;

    // Voisins bons/mauvais.
    final goodNeighbors = <String>[];
    final badNeighbors = <String>[];
    final companions = companionMap[veg.id] ?? [];
    final incompatibles = incompatibleMap[veg.id] ?? [];
    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;
        final nr = row + dr, nc = col + dc;
        if (nr < 0 || nr >= _rows || nc < 0 || nc >= _cols) continue;
        final nId = _grid[nr][nc];
        if (nId == null) continue;
        final nVeg = vegetablesBase.where((v) => v.id == nId).firstOrNull;
        if (nVeg == null) continue;
        if (companions.contains(nId)) goodNeighbors.add('${nVeg.emoji} ${nVeg.name}');
        if (incompatibles.contains(nId)) badNeighbors.add('${nVeg.emoji} ${nVeg.name}');
      }
    }

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(
                color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 16),
              Text(veg.emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(veg.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              Text(veg.category.label, style: TextStyle(color: KultivaColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 16),
              // Arrosage.
              _DetailRow(
                icon: dryDays >= threshold ? '🚨' : '💧',
                label: lastWatered != null
                    ? 'Arrosé il y a ${DateTime.now().difference(lastWatered).inDays}j'
                    : 'Jamais arrosé manuellement',
              ),
              _DetailRow(icon: '⏱', label: 'Besoin : tous les ${threshold}j'),
              if (veg.watering != null)
                _DetailRow(icon: '🌊', label: veg.watering!),
              // Compagnons.
              if (goodNeighbors.isNotEmpty)
                _DetailRow(icon: '✅', label: goodNeighbors.join(', ')),
              if (badNeighbors.isNotEmpty)
                _DetailRow(icon: '⛔', label: badNeighbors.join(', ')),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _waterCell(row, col);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${veg.emoji} ${veg.name} arrosé !')),
                        );
                      },
                      icon: const Text('💧', style: TextStyle(fontSize: 16)),
                      label: const Text('Arroser'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _placeVegetable(row, col, null);
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Retirer'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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


class _GardenCell extends StatelessWidget {
  final Vegetable? veg;
  final int dryDays;
  final int threshold;
  final List<String> warnings;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _GardenCell({
    required this.veg,
    required this.dryDays,
    required this.threshold,
    required this.warnings,
    required this.onTap,
    this.onLongPress,
  });

  Color _cellColor() {
    if (veg == null) return const Color(0xFFFCE4EC);
    if (warnings.isNotEmpty) return const Color(0xFFFFCCBC);
    if (dryDays >= threshold + 2) return const Color(0xFFFFE0B2);
    if (dryDays >= threshold) return const Color(0xFFFFF3E0);
    return const Color(0xFFF8BBD0);
  }

  String _waterEmoji() {
    if (dryDays >= threshold + 2) return '🚨';
    if (dryDays >= threshold) return '💦';
    return '💧';
  }

  @override
  Widget build(BuildContext context) {
    final cc = _cellColor();
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 82,
        height: 82,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: cc,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE8B4B8).withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE8B4B8).withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Bulles décoratives.
            Positioned(top: -5, right: -5,
              child: Container(width: 20, height: 20,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: const Color(0xFFE8B4B8).withOpacity(0.2)))),
            Positioned(bottom: 3, left: 2,
              child: Container(width: 12, height: 12,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: const Color(0xFFE8B4B8).withOpacity(0.15)))),
            if (veg != null) ...[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(veg!.emoji,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(veg!.name, style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w700,
                        color: Color(0xFF8B6B7A)),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 3, bottom: 3,
                child: Text(_waterEmoji(),
                    style: const TextStyle(fontSize: 9)),
              ),
            ] else
              Center(
                child: Text('+', style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w300,
                  color: const Color(0xFFE8B4B8).withOpacity(0.7))),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String icon;
  final String label;
  const _DetailRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 13, height: 1.3)),
          ),
        ],
      ),
    );
  }
}

/// Animation de feuilles et gouttes pour l'onglet Mon Potager.
class _GardenParticleAnimation extends StatefulWidget {
  const _GardenParticleAnimation();
  @override
  State<_GardenParticleAnimation> createState() =>
      _GardenParticleAnimationState();
}

class _GardenParticleAnimationState extends State<_GardenParticleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  static const _emojis = ['🍃', '💧', '🌿', '✨', '🍃', '💧', '🌱', '✨'];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Stack(
          children: List.generate(8, (i) {
            final t = (_ctrl.value + i * 0.125) % 1.0;
            final x = (i * 0.14 + 0.03) % 1.0;
            return Positioned(
              left: x * MediaQuery.of(context).size.width * 0.8,
              top: t * 170 - 15,
              child: Opacity(
                opacity: (1 - t).clamp(0.0, 0.5),
                child: Text(_emojis[i % _emojis.length],
                    style: const TextStyle(fontSize: 14)),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Quadrillage kawaii rose/lavande.
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fond dégradé rose → lavande.
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFCE4EC), Color(0xFFE8EAF6)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
    // Quadrillage blanc.
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 0.8;
    const step = 18.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _GridButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: KultivaColors.lightGreen.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: KultivaColors.primaryGreen.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: KultivaColors.primaryGreen),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700,
              color: KultivaColors.primaryGreen)),
          ],
        ),
      ),
    );
  }
}
