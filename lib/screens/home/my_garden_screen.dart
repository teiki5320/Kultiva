import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/companions.dart';
import '../../data/vegetables_base.dart';
import '../../models/vegetable.dart';
import '../../services/prefs_service.dart';
import '../../services/notification_service.dart';
import '../../services/watering_service.dart';
import '../../services/audio_service.dart';
import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';
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
  bool _waterMode = false; // Mode arrosage : tap = arrose
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
    _maybeShowTutorial();
  }

  /// Affiche le tuto 3 slides la première fois qu'un potager est créé.
  void _maybeShowTutorial() {
    if (PrefsService.instance.gardenTutorialDone) return;
    // On attend que le build ait eu lieu avant de pusher la sheet.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        builder: (_) => const GardenTutorialSheet(),
      ).whenComplete(() {
        PrefsService.instance.setGardenTutorialDone(true);
      });
    });
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
    if (vegId != null) AudioService.instance.play(Sfx.plant);
  }

  /// Arrose une cellule spécifique (pas global).
  void _waterCell(int row, int col, {bool playSound = true}) {
    setState(() {
      _wateredMap['${row}_$col'] = DateTime.now().toIso8601String();
    });
    _saveGarden();
    if (playSound) AudioService.instance.play(Sfx.drop);
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
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: Image.asset(
                'assets/images/onboarding_1.png',
                width: 160, height: 160, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 140, height: 140,
                  decoration: BoxDecoration(
                    color: KultivaColors.lightGreen.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  alignment: Alignment.center,
                  child: const Text('🌱', style: TextStyle(fontSize: 70)),
                ),
              ),
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
        // Potager Bonbon — Candy Pastel.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF0F4),
                    Color(0xFFFFF5F0),
                    Color(0xFFF8F0FF),
                    Color(0xFFF0F8FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFF0D0D8), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF0D0D8).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: CustomPaint(
                  painter: _CandyDotsPainter(),
                  child: Stack(
                    children: [
                      // Sucette gauche.
                      Positioned(top: 8, left: 10, child: Column(children: [
                        Container(width: 18, height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const SweepGradient(colors: [
                              Color(0xFFF8D0E0), Color(0xFFFFF0F4),
                              Color(0xFFE0D0F0), Color(0xFFF8D0E0),
                            ]),
                            border: Border.all(color: const Color(0xFFF0C0D0), width: 1.5),
                          )),
                        Container(width: 2, height: 16, color: const Color(0xFFE8D0D8)),
                      ])),
                      // Sucette droite.
                      Positioned(top: 10, right: 12, child: Column(children: [
                        Container(width: 14, height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const SweepGradient(colors: [
                              Color(0xFFD0E8F0), Color(0xFFF0F8FF),
                              Color(0xFFD0F0E0), Color(0xFFD0E8F0),
                            ]),
                            border: Border.all(color: const Color(0xFFC0D8E0), width: 1.5),
                          )),
                        Container(width: 2, height: 14, color: const Color(0xFFD0D8E0)),
                      ])),
                      // Sprinkles éparpillés.
                      ...List.generate(14, (i) {
                        final colors = [
                          const Color(0xFFF8D0E0), const Color(0xFFD0E8F0),
                          const Color(0xFFF0E0B8), const Color(0xFFD0F0D8),
                          const Color(0xFFD8D0F0),
                        ];
                        return Positioned(
                          left: (4 + i * 7) * 3.0,
                          top: (5 + (i % 5) * 18) * 1.0,
                          child: Transform.rotate(
                            angle: i * 28 * 3.14 / 180,
                            child: Container(
                              width: 3, height: 7,
                              decoration: BoxDecoration(
                                color: colors[i % 5].withOpacity(0.25),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        );
                      }),
                      // Grille de bonbons.
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 40, 16, 32),
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
                                      index: r * _cols + c,
                                    );
                                  }),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      // Nœud ruban en bas.
                      const Positioned(
                        bottom: 8, left: 0, right: 0,
                        child: Center(
                          child: Text('🎀', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Boutons arrosage.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _waterMode = !_waterMode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _waterMode
                          ? const Color(0xFF4FC3F7)
                          : const Color(0xFF4FC3F7).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF4FC3F7),
                        width: _waterMode ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_waterMode ? '💧' : '🚿', style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          _waterMode ? 'Mode arrosage actif' : 'Arroser',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _waterMode ? Colors.white : const Color(0xFF0288D1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: _waterAll,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF29B6F6).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF29B6F6),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🌧️', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          'Tout arroser',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0277BD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
    // Mode arrosage : tap = arrose la case (si plante présente).
    if (_waterMode) {
      if (_grid[row][col] != null) {
        _waterCell(row, col);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💧 Arrosé !'),
            duration: Duration(milliseconds: 600),
          ),
        );
      }
      return;
    }
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

  void _waterAll() {
    int count = 0;
    for (int r = 0; r < _rows; r++) {
      for (int c = 0; c < _cols; c++) {
        if (_grid[r][c] != null) {
          _waterCell(r, c, playSound: false);
          count++;
        }
      }
    }
    AudioService.instance.play(Sfx.rain);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('💧 $count plante${count > 1 ? "s" : ""} arrosée${count > 1 ? "s" : ""} !')),
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
  final int index;

  const _GardenCell({
    required this.veg,
    required this.dryDays,
    required this.threshold,
    required this.warnings,
    required this.onTap,
    this.onLongPress,
    this.index = 0,
  });

  // 9 couleurs candy avec bordure.
  static const _candyColors = [
    [Color(0xFFFFE0E8), Color(0xFFF8C0D0)], // rose
    [Color(0xFFE0F0FF), Color(0xFFC0D8F0)], // bleu
    [Color(0xFFFFF0D8), Color(0xFFF0E0B8)], // jaune
    [Color(0xFFE0FFE8), Color(0xFFC0E8D0)], // vert
    [Color(0xFFF0E0FF), Color(0xFFD8C0F0)], // violet
    [Color(0xFFFFE8E0), Color(0xFFF0D0C0)], // pêche
    [Color(0xFFE0F8F0), Color(0xFFC0E0D8)], // menthe
    [Color(0xFFF8F0E0), Color(0xFFE8D8C0)], // crème
    [Color(0xFFE8E0F8), Color(0xFFD0C8E8)], // lavande
  ];

  Color _candyBg() {
    if (warnings.isNotEmpty) return const Color(0xFFFFCCBC);
    if (dryDays >= threshold + 2) return const Color(0xFFFFD4C4);
    if (dryDays >= threshold) return const Color(0xFFFFF0D8);
    return _candyColors[index % 9][0];
  }

  Color _candyBorder() {
    if (warnings.isNotEmpty) return const Color(0xFFFF8A65);
    if (dryDays >= threshold + 2) return const Color(0xFFE8896B);
    if (dryDays >= threshold) return const Color(0xFFF0E0B8);
    return _candyColors[index % 9][1];
  }

  String _waterEmoji() {
    if (dryDays >= threshold + 2) return '🚨';
    if (dryDays >= threshold) return '💦';
    return ''; // Bien arrosé : pas d'indicateur.
  }

  @override
  Widget build(BuildContext context) {
    final bg = _candyBg();
    final border = _candyBorder();
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 80,
        height: 76,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Twist gauche (emballage).
            Positioned(
              left: -3, top: 28,
              child: Container(
                width: 10, height: 16,
                decoration: BoxDecoration(
                  color: border.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            // Twist droit (emballage).
            Positioned(
              right: -3, top: 28,
              child: Container(
                width: 10, height: 16,
                decoration: BoxDecoration(
                  color: border.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            // Corps du bonbon.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [bg, bg.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: border.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    // Reflet brillant.
                    Positioned(
                      top: 6, left: 10,
                      child: Transform.rotate(
                        angle: -15 * 3.14 / 180,
                        child: Container(
                          width: 20, height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    // Contenu.
                    if (veg != null)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(veg!.emoji, style: const TextStyle(fontSize: 26)),
                            const SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(veg!.name, style: const TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w700,
                                color: Color(0xFFC0A0B0)),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      )
                    else
                      const Center(
                        child: Text('🌱', style: TextStyle(fontSize: 20)),
                      ),
                    // Indicateur eau.
                    if (veg != null)
                      Positioned(
                        right: 4, bottom: 4,
                        child: Text(_waterEmoji(),
                            style: const TextStyle(fontSize: 9)),
                      ),
                  ],
                ),
              ),
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
class _CandyDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF8D0E0).withOpacity(0.13);
    const step = 18.0;
    for (double x = step / 2; x < size.width; x += step) {
      for (double y = step / 2; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
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
