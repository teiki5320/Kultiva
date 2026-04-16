import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';

/// Poussidex — album de collection des légumes plantés.
///
/// Remplace l'ancienne grille 2D par une liste chronologique de
/// [Plantation]. Chunk 3a : squelette minimal fonctionnel (header + grille
/// de cartes simples + FAB + migration silencieuse). Les chunks suivants
/// enrichiront les cartes, la fiche détail, les badges et le tuto.
class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  State<MyGardenScreen> createState() => _MyGardenScreenState();
}

class _MyGardenScreenState extends State<MyGardenScreen> {
  List<Plantation> _plantations = <Plantation>[];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _maybeMigrate();
    _plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    if (mounted) setState(() => _loaded = true);
    _showTutorialIfNeeded();
  }

  /// Convertit l'ancienne grille 2D en plantations une seule fois,
  /// puis marque la migration comme faite pour ne plus la rejouer.
  Future<void> _maybeMigrate() async {
    if (PrefsService.instance.gridMigrated) return;
    final legacy = PrefsService.instance.gardenGrid;
    if (legacy == null || legacy.isEmpty) {
      await PrefsService.instance.setGridMigrated(true);
      return;
    }
    try {
      final data = jsonDecode(legacy) as Map<String, dynamic>;
      final rows = data['rows'] as int;
      final cols = data['cols'] as int;
      final cells = (data['cells'] as List).cast<String?>();
      final watered = (data['watered'] as Map?) ?? const <String, dynamic>{};
      final migrated = <Plantation>[];
      final now = DateTime.now();
      final rng = Random(42);
      int idx = 0;
      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          final vegId = cells[r * cols + c];
          if (vegId == null) continue;
          final wIso = watered['${r}_$c'] as String?;
          final wDates = <DateTime>[];
          if (wIso != null) {
            final w = DateTime.tryParse(wIso);
            if (w != null) wDates.add(w);
          }
          migrated.add(Plantation(
            id: '${now.millisecondsSinceEpoch}_${idx++}_${rng.nextInt(99999)}',
            vegetableId: vegId,
            plantedAt: now, // l'info de date plantation est perdue
            wateredAt: wDates,
          ));
        }
      }
      await PrefsService.instance
          .setPlantationsJson(Plantation.encodeAll(migrated));
    } catch (_) {
      // En cas d'échec de parsing, on abandonne silencieusement.
    }
    await PrefsService.instance.setGridMigrated(true);
  }

  void _showTutorialIfNeeded() {
    if (PrefsService.instance.gardenTutorialDone) return;
    if (_plantations.isEmpty) return; // tuto après la 1ère plantation
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

  Future<void> _save() async {
    await PrefsService.instance
        .setPlantationsJson(Plantation.encodeAll(_plantations));
  }

  String _genId() =>
      '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(100000)}';

  void _plant(String vegetableId) {
    setState(() {
      _plantations.add(Plantation(
        id: _genId(),
        vegetableId: vegetableId,
        plantedAt: DateTime.now(),
      ));
    });
    _save();
    AudioService.instance.play(Sfx.plant);
    _showTutorialIfNeeded();
  }

  void _openPicker() {
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _VegetablePickerSheet(),
    ).then((vegId) {
      if (vegId != null) _plant(vegId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            _Header(count: _plantations.length),
            Expanded(
              child: _plantations.isEmpty
                  ? _EmptyState(onPlant: _openPicker)
                  : _buildCardsGrid(),
            ),
          ],
        ),
      ),
      floatingActionButton: _plantations.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _openPicker,
              icon: const Icon(Icons.add),
              label: const Text('Planter',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              backgroundColor: KultivaColors.primaryGreen,
            ),
    );
  }

  Widget _buildCardsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 0.78,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _plantations.length,
      itemBuilder: (context, i) {
        final p = _plantations[i];
        final veg =
            vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
        if (veg == null) return const SizedBox.shrink();
        return _PlantationCard(plantation: p, vegetable: veg);
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Header
// ═══════════════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int count;
  const _Header({required this.count});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: SizedBox(
        height: 170,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/potager.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      KultivaColors.springA,
                      KultivaColors.springB,
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.35),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '🪴 Mon Poussidex',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      shadows: const <Shadow>[
                        Shadow(color: Colors.black45, blurRadius: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count == 0
                        ? 'Aucun légume collecté'
                        : '$count légume${count > 1 ? "s" : ""} collecté${count > 1 ? "s" : ""}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      shadows: const <Shadow>[
                        Shadow(color: Colors.black38, blurRadius: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Empty state
// ═══════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final VoidCallback onPlant;
  const _EmptyState({required this.onPlant});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('📖', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              'Ton Poussidex est vide',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Plante ton premier légume pour commencer ta collection !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onPlant,
              icon: const Text('🌱', style: TextStyle(fontSize: 16)),
              label: const Text('Planter mon 1er légume'),
              style: ElevatedButton.styleFrom(
                backgroundColor: KultivaColors.primaryGreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Carte d'une plantation — bordure famille, barre de progression, stats
// ═══════════════════════════════════════════════════════════════════════════

/// Couleur associée à la famille d'un légume.
Color _familyColor(VegetableCategory cat) {
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
    case VegetableCategory.accessories:
      return const Color(0xFF78909C);
  }
}

/// Estimation du nombre de jours jusqu'à récolte (borne haute).
/// Lit [Vegetable.harvestTimeBySeason] si rempli, sinon défaut par famille.
int _expectedHarvestDays(Vegetable v, DateTime plantedAt) {
  final times = v.harvestTimeBySeason;
  if (times != null) {
    final m = plantedAt.month;
    final seasonKey = m >= 3 && m <= 5
        ? 'spring'
        : m >= 6 && m <= 8
            ? 'summer'
            : m >= 9 && m <= 11
                ? 'autumn'
                : 'winter';
    final raw = times[seasonKey] ?? times.values.firstOrNull;
    if (raw != null) {
      // Extrait le dernier nombre entier de la chaîne ("70 à 90 jours" → 90).
      final matches = RegExp(r'\d+').allMatches(raw).toList();
      if (matches.isNotEmpty) {
        return int.tryParse(matches.last.group(0)!) ?? 70;
      }
    }
  }
  // Défauts par famille.
  switch (v.category) {
    case VegetableCategory.leaves:
      return 55;
    case VegetableCategory.roots:
      return 70;
    case VegetableCategory.fruits:
      return 80;
    case VegetableCategory.bulbs:
      return 90;
    case VegetableCategory.tubers:
      return 100;
    case VegetableCategory.aromatics:
      return 45;
    case VegetableCategory.flowers:
      return 60;
    case VegetableCategory.seeds:
      return 90;
    case VegetableCategory.stems:
      return 70;
    case VegetableCategory.accessories:
      return 1;
  }
}

class _PlantationCard extends StatelessWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  const _PlantationCard({required this.plantation, required this.vegetable});

  static const List<String> _shortMonths = <String>[
    'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
    'juil', 'août', 'sep', 'oct', 'nov', 'déc',
  ];

  @override
  Widget build(BuildContext context) {
    final cc = _familyColor(vegetable.category);
    final days = plantation.daysSincePlanted;
    final expected = _expectedHarvestDays(vegetable, plantation.plantedAt);
    final progress = (days / expected).clamp(0.0, 1.0);
    final mature = progress >= 1.0;
    final thirsty = plantation.isActive &&
        plantation.daysSinceWatered >= vegetable.effectiveWateringDays;
    final watered = plantation.wateredAt.length;
    final harvested = plantation.harvestCount;
    final plantedLabel =
        '${plantation.plantedAt.day} ${_shortMonths[plantation.plantedAt.month - 1]}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cc.withOpacity(0.7), width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cc.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Ligne haute : nom + indicateur soif / récolté.
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  vegetable.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!plantation.isActive)
                const Text('🧺', style: TextStyle(fontSize: 14))
              else if (thirsty)
                const Text('💧', style: TextStyle(fontSize: 14))
              else if (mature)
                const Text('✨', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 6),
          // Emoji central dans cercle coloré famille.
          Expanded(
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cc.withOpacity(0.15),
                  border: Border.all(color: cc.withOpacity(0.35), width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(vegetable.emoji,
                    style: const TextStyle(fontSize: 38)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Progression.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                plantation.isActive
                    ? 'Jour ${days + 1}${mature ? " ★" : "/$expected"}'
                    : 'Récolté',
                style: TextStyle(
                  color: KultivaColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                plantedLabel,
                style: TextStyle(
                  color: KultivaColors.textSecondary.withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: plantation.isActive ? progress : 1.0,
              minHeight: 5,
              backgroundColor: cc.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(cc),
            ),
          ),
          const SizedBox(height: 6),
          // Stats (💧 arrosages, 🧺 récoltes).
          Row(
            children: <Widget>[
              _StatChip(icon: '💧', count: watered),
              const SizedBox(width: 6),
              _StatChip(icon: '🧺', count: harvested),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final int count;
  const _StatChip({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            '×$count',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Picker légume (bottom sheet)
// ═══════════════════════════════════════════════════════════════════════════

class _VegetablePickerSheet extends StatefulWidget {
  const _VegetablePickerSheet();

  @override
  State<_VegetablePickerSheet> createState() => _VegetablePickerSheetState();
}

class _VegetablePickerSheetState extends State<_VegetablePickerSheet> {
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
            var list = vegetablesBase
                .where((v) => v.category != VegetableCategory.accessories)
                .toList();
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
            list.sort((a, b) {
              final aFav = favs.contains(a.id) ? 0 : 1;
              final bFav = favs.contains(b.id) ? 0 : 1;
              final cmp = aFav.compareTo(bFav);
              return cmp != 0 ? cmp : a.name.compareTo(b.name);
            });
            return Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => setState(() => _query = v.trim()),
                    decoration: const InputDecoration(
                      hintText: 'Rechercher un légume…',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
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
                                color: KultivaColors.textSecondary),
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
                              onTap: () =>
                                  Navigator.of(context).pop(v.id),
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
