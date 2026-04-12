import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/companions.dart';
import '../../data/vegetables_base.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadGarden();
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
          (r) => List.generate(_cols, (c) => cells[r * _cols + c]),
        );
        _initialized = true;
        setState(() {});
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
    });
    PrefsService.instance.setGardenGrid(json);
  }

  void _createGarden(GardenPreset preset) {
    setState(() {
      _rows = preset.rows;
      _cols = preset.cols;
      _grid = List.generate(_rows, (_) => List.filled(_cols, null));
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
      _grid.add(List.filled(_cols, null));
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
    setState(() => _grid[row][col] = vegId);
    _saveGarden();
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

  Widget _buildGarden() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      return _GardenCell(
                        vegId: _grid[r][c],
                        warnings: _getWarnings(r, c),
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
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.85,
          expand: false,
          builder: (ctx, scrollCtrl) {
            final sorted = List<Vegetable>.from(vegetablesBase)
              ..sort((a, b) => a.name.compareTo(b.name));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Choisir un légume',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollCtrl,
                    itemCount: sorted.length,
                    itemBuilder: (ctx, i) {
                      final v = sorted[i];
                      return ListTile(
                        leading: Text(v.emoji,
                            style: const TextStyle(fontSize: 28)),
                        title: Text(v.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(v.category.label),
                        onTap: () {
                          _placeVegetable(row, col, v.id);
                          Navigator.pop(ctx);
                        },
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

class _GardenCell extends StatelessWidget {
  final String? vegId;
  final List<String> warnings;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _GardenCell({
    required this.vegId,
    required this.warnings,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final veg = vegId != null
        ? vegetablesBase.where((v) => v.id == vegId).firstOrNull
        : null;
    final hasWarning = warnings.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      onLongPress: vegId != null ? onClear : null,
      child: Tooltip(
        message: veg != null
            ? '${veg.name}${hasWarning ? "\n⚠️ Mauvais voisin : ${warnings.join(", ")}" : ""}'
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
                    Text(veg.emoji, style: const TextStyle(fontSize: 24)),
                    Text(
                      veg.name,
                      style: const TextStyle(
                          fontSize: 9, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    if (hasWarning)
                      const Text('⚠️', style: TextStyle(fontSize: 10)),
                  ],
                )
              : Icon(Icons.add, size: 20, color: Colors.grey.withOpacity(0.4)),
        ),
      ),
    );
  }
}
