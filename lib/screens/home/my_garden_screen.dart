import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/badges.dart';
import '../../data/vegetables_base.dart';
import '../../models/plantation.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/prefs_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/garden_tutorial_sheet.dart';

/// Filtre actif dans le Poussidex.
enum _AlbumFilter { all, growing, harvested, badges }

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
  Set<String> _unlockedBadges = <String>{};
  _AlbumFilter _filter = _AlbumFilter.all;
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
    _unlockedBadges = PrefsService.instance.unlockedBadges;
    // Met à jour (au cas où des badges seraient débloqués par la simple
    // lecture de données déjà présentes, sans déclencher de snackbar
    // historique — on se contente d'aligner l'état).
    _unlockedBadges = computeUnlockedBadges(_plantations);
    await PrefsService.instance.setUnlockedBadges(_unlockedBadges);
    if (mounted) setState(() => _loaded = true);
    _showTutorialIfNeeded();
  }

  /// Appelée après chaque action qui modifie la collection — détecte les
  /// nouveaux badges débloqués et montre un snackbar kawaii pour chacun.
  void _refreshBadges() {
    final next = computeUnlockedBadges(_plantations);
    final newly = next.difference(_unlockedBadges);
    _unlockedBadges = next;
    PrefsService.instance.setUnlockedBadges(next);
    if (newly.isEmpty || !mounted) return;
    for (final id in newly) {
      final b = allBadges.firstWhere((x) => x.id == id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Badge débloqué : ${b.emoji} ${b.name}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: KultivaColors.primaryGreen,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  List<Plantation> get _filteredPlantations {
    switch (_filter) {
      case _AlbumFilter.all:
      case _AlbumFilter.badges: // ignoré, la vue badges ne passe pas par là
        return _plantations;
      case _AlbumFilter.growing:
        return _plantations.where((p) => p.isActive).toList();
      case _AlbumFilter.harvested:
        return _plantations
            .where((p) => !p.isActive || p.harvestCount > 0)
            .toList();
    }
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
    _refreshBadges();
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

  void _replace(Plantation updated) {
    setState(() {
      final i = _plantations.indexWhere((x) => x.id == updated.id);
      if (i >= 0) _plantations[i] = updated;
    });
    _save();
  }

  void _water(Plantation p) {
    _replace(p.copyWith(wateredAt: <DateTime>[...p.wateredAt, DateTime.now()]));
    AudioService.instance.play(Sfx.drop);
  }

  void _harvest(Plantation p) {
    _replace(p.copyWith(harvestCount: p.harvestCount + 1));
    AudioService.instance.play(Sfx.plant);
  }

  void _terminate(Plantation p) {
    _replace(p.copyWith(harvestedAt: DateTime.now()));
  }

  void _remove(Plantation p) {
    setState(() => _plantations.removeWhere((x) => x.id == p.id));
    _save();
  }

  void _setNote(Plantation p, String? note) {
    _replace(p.copyWith(note: note));
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

  Future<void> _showDetail(Plantation p, Vegetable v) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _PlantationDetailSheet(
        plantation: p,
        vegetable: v,
        onWater: () {
          _water(p);
          Navigator.pop(ctx);
        },
        onHarvest: () {
          _harvest(p);
          Navigator.pop(ctx);
        },
        onTerminate: () {
          _terminate(p);
          Navigator.pop(ctx);
        },
        onRemove: () {
          _remove(p);
          Navigator.pop(ctx);
        },
        onNoteChanged: (note) => _setNote(p, note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final showFab =
        _filter != _AlbumFilter.badges && _plantations.isNotEmpty;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            _Header(
              plantationsCount: _plantations.length,
              unlockedCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
            ),
            _FilterBar(
              filter: _filter,
              allCount: _plantations.length,
              growingCount:
                  _plantations.where((p) => p.isActive).length,
              harvestedCount: _plantations
                  .where((p) => !p.isActive || p.harvestCount > 0)
                  .length,
              badgesCount: _unlockedBadges.length,
              totalBadges: allBadges.length,
              onChanged: (f) => setState(() => _filter = f),
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
              onPressed: _openPicker,
              icon: const Icon(Icons.add),
              label: const Text('Planter',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              backgroundColor: KultivaColors.primaryGreen,
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_filter == _AlbumFilter.badges) {
      return _BadgesGrid(unlocked: _unlockedBadges);
    }
    if (_plantations.isEmpty) {
      return _EmptyState(onPlant: _openPicker);
    }
    final list = _filteredPlantations;
    if (list.isEmpty) {
      return _FilterEmptyState(filter: _filter);
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 0.78,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final p = list[i];
        final veg =
            vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
        if (veg == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () => _showDetail(p, veg),
          child: _PlantationCard(plantation: p, vegetable: veg),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Header
// ═══════════════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int plantationsCount;
  final int unlockedCount;
  final int totalBadges;
  const _Header({
    required this.plantationsCount,
    required this.unlockedCount,
    required this.totalBadges,
  });

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
                    plantationsCount == 0
                        ? '0 légume · $unlockedCount / $totalBadges badges'
                        : '$plantationsCount légume${plantationsCount > 1 ? "s" : ""} · $unlockedCount / $totalBadges badges',
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
// Barre de filtres (Tout / En cours / Récoltés / Badges)
// ═══════════════════════════════════════════════════════════════════════════

class _FilterBar extends StatelessWidget {
  final _AlbumFilter filter;
  final int allCount;
  final int growingCount;
  final int harvestedCount;
  final int badgesCount;
  final int totalBadges;
  final ValueChanged<_AlbumFilter> onChanged;

  const _FilterBar({
    required this.filter,
    required this.allCount,
    required this.growingCount,
    required this.harvestedCount,
    required this.badgesCount,
    required this.totalBadges,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: <Widget>[
          _FilterChip(
            label: '✨ Tout',
            count: allCount,
            selected: filter == _AlbumFilter.all,
            color: KultivaColors.primaryGreen,
            onTap: () => onChanged(_AlbumFilter.all),
          ),
          _FilterChip(
            label: '🌱 En cours',
            count: growingCount,
            selected: filter == _AlbumFilter.growing,
            color: KultivaColors.primaryGreen,
            onTap: () => onChanged(_AlbumFilter.growing),
          ),
          _FilterChip(
            label: '🧺 Récoltés',
            count: harvestedCount,
            selected: filter == _AlbumFilter.harvested,
            color: KultivaColors.terracotta,
            onTap: () => onChanged(_AlbumFilter.harvested),
          ),
          _FilterChip(
            label: '🏆 Badges',
            count: badgesCount,
            total: totalBadges,
            selected: filter == _AlbumFilter.badges,
            color: const Color(0xFFFFB74D),
            onTap: () => onChanged(_AlbumFilter.badges),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final int? total;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    this.total,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final suffix = total != null ? ' $count/$total' : ' ($count)';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color,
              width: selected ? 2.5 : 2,
            ),
          ),
          child: Text(
            '$label$suffix',
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Grille de badges (vue "Badges")
// ═══════════════════════════════════════════════════════════════════════════

class _BadgesGrid extends StatelessWidget {
  final Set<String> unlocked;
  const _BadgesGrid({required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 170,
        childAspectRatio: 0.95,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: allBadges.length,
      itemBuilder: (context, i) {
        final b = allBadges[i];
        final isUnlocked = unlocked.contains(b.id);
        return _BadgeTile(badge: b, unlocked: isUnlocked);
      },
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final PoussidexBadge badge;
  final bool unlocked;
  const _BadgeTile({required this.badge, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFB74D);
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? gold.withOpacity(0.12) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: unlocked ? gold : Colors.grey.shade300,
          width: unlocked ? 2.5 : 1.5,
        ),
        boxShadow: unlocked
            ? <BoxShadow>[
                BoxShadow(
                  color: gold.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : const <BoxShadow>[],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 4),
          Opacity(
            opacity: unlocked ? 1.0 : 0.3,
            child: Text(
              badge.emoji,
              style: const TextStyle(fontSize: 44),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badge.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: unlocked ? null : Colors.grey.shade500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              badge.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                height: 1.3,
                color: unlocked
                    ? KultivaColors.textSecondary
                    : Colors.grey.shade400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!unlocked)
            Icon(Icons.lock_outline,
                size: 14, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Empty states spécifiques à chaque filtre
// ═══════════════════════════════════════════════════════════════════════════

class _FilterEmptyState extends StatelessWidget {
  final _AlbumFilter filter;
  const _FilterEmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final message = switch (filter) {
      _AlbumFilter.growing =>
        '🌱\n\nAucun plant en cours pour le moment.\nPlante quelque chose avec le bouton +.',
      _AlbumFilter.harvested =>
        '🧺\n\nAucune récolte enregistrée.\nOuvre une fiche plant et appuie sur Récolter.',
      _ => 'Aucun légume à afficher.',
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: KultivaColors.textSecondary,
            fontSize: 13,
            height: 1.5,
          ),
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
// Fiche détail d'une carte (bottom sheet)
// ═══════════════════════════════════════════════════════════════════════════

class _PlantationDetailSheet extends StatefulWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final VoidCallback onWater;
  final VoidCallback onHarvest;
  final VoidCallback onTerminate;
  final VoidCallback onRemove;
  final ValueChanged<String?> onNoteChanged;

  const _PlantationDetailSheet({
    required this.plantation,
    required this.vegetable,
    required this.onWater,
    required this.onHarvest,
    required this.onTerminate,
    required this.onRemove,
    required this.onNoteChanged,
  });

  @override
  State<_PlantationDetailSheet> createState() =>
      _PlantationDetailSheetState();
}

class _PlantationDetailSheetState extends State<_PlantationDetailSheet> {
  static const List<String> _monthsLong = <String>[
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  String _fmtDate(DateTime d) {
    return '${d.day} ${_monthsLong[d.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.plantation;
    final v = widget.vegetable;
    final cc = _familyColor(v.category);
    final days = p.daysSincePlanted;
    final expected = _expectedHarvestDays(v, p.plantedAt);
    final remaining = (expected - days).clamp(0, expected);
    final progress = (days / expected).clamp(0.0, 1.0);
    final thirsty =
        p.isActive && p.daysSinceWatered >= v.effectiveWateringDays;

    // Timeline d'événements tri anti-chronologique.
    final events = <_TimelineEvent>[];
    events.add(_TimelineEvent(
        date: p.plantedAt, emoji: '🌱', label: 'Planté'));
    for (final w in p.wateredAt) {
      events.add(_TimelineEvent(date: w, emoji: '💧', label: 'Arrosé'));
    }
    if (p.harvestedAt != null) {
      events.add(_TimelineEvent(
          date: p.harvestedAt!, emoji: '🏁', label: 'Culture terminée'));
    }
    events.sort((a, b) => b.date.compareTo(a.date));

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return SingleChildScrollView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Poignée.
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // En-tête grande carte.
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: cc, width: 3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: cc.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cc.withOpacity(0.18),
                          border: Border.all(
                              color: cc.withOpacity(0.5), width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(v.emoji,
                            style: const TextStyle(fontSize: 52)),
                      ),
                      const SizedBox(height: 12),
                      Text(v.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22)),
                      Text(v.category.label,
                          style: TextStyle(
                              color: KultivaColors.textSecondary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Barre progression.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    p.isActive
                        ? 'Jour ${days + 1} / $expected'
                        : 'Culture terminée',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  if (p.isActive)
                    Text(
                      remaining == 0
                          ? '✨ Prêt à récolter'
                          : '⏳ $remaining j restants',
                      style: TextStyle(
                        color: KultivaColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: p.isActive ? progress : 1.0,
                  minHeight: 8,
                  backgroundColor: cc.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(cc),
                ),
              ),
              const SizedBox(height: 20),
              // Infos clés.
              _InfoRow(
                icon: '💧',
                label: p.lastWatered == null
                    ? 'Jamais arrosé'
                    : 'Dernier arrosage : ${_fmtDate(p.lastWatered!)} (${p.daysSinceWatered}j)',
                alert: thirsty,
              ),
              _InfoRow(
                icon: '🧺',
                label:
                    '${p.harvestCount} récolte${p.harvestCount > 1 ? "s" : ""} enregistrée${p.harvestCount > 1 ? "s" : ""}',
              ),
              _InfoRow(
                icon: '📅',
                label: 'Planté le ${_fmtDate(p.plantedAt)}',
              ),
              if (v.watering != null)
                _InfoRow(icon: '🌊', label: v.watering!),
              const SizedBox(height: 18),
              // Note.
              _NoteEditor(
                initial: p.note,
                onChanged: widget.onNoteChanged,
              ),
              const SizedBox(height: 20),
              // Actions principales.
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onWater : null,
                      icon: const Text('💧',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Arroser'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onHarvest : null,
                      icon: const Text('🧺',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Récolter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KultivaColors.terracotta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Actions secondaires.
              Row(
                children: <Widget>[
                  if (p.isActive)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onTerminate,
                        icon: const Text('🏁',
                            style: TextStyle(fontSize: 14)),
                        label: const Text('Terminer'),
                      ),
                    ),
                  if (p.isActive) const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmRemove(context),
                      icon: const Icon(Icons.delete_outline,
                          size: 18, color: Colors.red),
                      label: const Text('Retirer',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Timeline.
              const Text(
                '📜 Historique',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 8),
              for (final e in events) _TimelineTile(event: e, formatter: _fmtDate),
            ],
          ),
        );
      },
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Retirer ce plant ?'),
        content: Text(
            'Cette action supprime définitivement ${widget.vegetable.name} de ton Poussidex. Tes arrosages et récoltes liés seront perdus.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onRemove();
            },
            child: const Text('Retirer',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _TimelineEvent {
  final DateTime date;
  final String emoji;
  final String label;
  const _TimelineEvent({
    required this.date,
    required this.emoji,
    required this.label,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineEvent event;
  final String Function(DateTime) formatter;
  const _TimelineTile({required this.event, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(event.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(event.label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(
            formatter(event.date),
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final bool alert;
  const _InfoRow({required this.icon, required this.label, this.alert = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: alert ? KultivaColors.terracotta : null,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteEditor extends StatefulWidget {
  final String? initial;
  final ValueChanged<String?> onChanged;
  const _NoteEditor({required this.initial, required this.onChanged});

  @override
  State<_NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<_NoteEditor> {
  late TextEditingController _ctrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    final text = _ctrl.text.trim();
    widget.onChanged(text.isEmpty ? null : text);
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _ctrl,
            autofocus: true,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Ajoute une note sur ce plant…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _ctrl.text = widget.initial ?? '';
                  setState(() => _editing = false);
                },
                child: const Text('Annuler'),
              ),
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      );
    }
    final text = widget.initial;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _editing = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            const Text('📝', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text == null || text.isEmpty
                    ? 'Ajouter une note…'
                    : text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: text == null || text.isEmpty
                      ? KultivaColors.textSecondary
                      : null,
                ),
              ),
            ),
            Icon(Icons.edit_outlined,
                size: 16, color: KultivaColors.textSecondary),
          ],
        ),
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
