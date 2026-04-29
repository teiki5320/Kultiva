import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/audio_service.dart';
import '../data/regions/france.dart';
import '../data/regions/west_africa.dart';
import '../data/companions.dart';
import '../data/diseases.dart';
import '../data/rotation.dart';
import '../data/vegetables_base.dart';
import '../models/plantation.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';
import '../models/vegetable_medal.dart';
import '../services/pdf_service.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';
import '../utils/months.dart';
import '../widgets/lexicon_text.dart';
import '../widgets/medal_badge.dart';

/// Fiche détail d'un légume — s'adapte à la région active pour les mois
/// de semis / récolte. Supporte le swipe gauche/droite pour naviguer entre
/// les légumes quand une liste est fournie.
class VegetableDetailScreen extends StatefulWidget {
  final Vegetable vegetable;
  final List<Vegetable>? vegetables;
  final int? initialIndex;

  const VegetableDetailScreen({
    super.key,
    required this.vegetable,
    this.vegetables,
    this.initialIndex,
  });

  @override
  State<VegetableDetailScreen> createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  late final PageController _pageController;
  late int _currentIndex;
  late List<Vegetable> _list;


  @override
  void initState() {
    super.initState();
    _list = widget.vegetables ?? [widget.vegetable];
    _currentIndex = widget.initialIndex ?? 0;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Vegetable get _currentVegetable => _list[_currentIndex];

  List<RegionData> _dataFor(Region region) {
    switch (region) {
      case Region.france:
        return franceData;
      case Region.westAfrica:
        return westAfricaData;
    }
  }

  RegionData? _findRegionData(List<RegionData> list, String vegId) {
    for (final d in list) {
      if (d.vegetableId == vegId) return d;
    }
    return null;
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Impossible d'ouvrir le lien."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Region>(
      valueListenable: PrefsService.instance.region,
      builder: (context, region, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${_currentVegetable.emoji}  ${_currentVegetable.name}'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                tooltip: 'Exporter PDF',
                onPressed: () => PdfService.printVegetableSheet(
                    _currentVegetable, region),
              ),
              ValueListenableBuilder<Set<String>>(
                valueListenable: PrefsService.instance.favorites,
                builder: (context, favs, _) {
                  final isFav = favs.contains(_currentVegetable.id);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: KultivaColors.terracotta,
                    ),
                    onPressed: () => PrefsService.instance
                        .toggleFavorite(_currentVegetable.id),
                  );
                },
              ),
            ],
          ),
          body: _list.length == 1
              ? _buildPage(_list[0], region)
              : PageView.builder(
                  controller: _pageController,
                  itemCount: _list.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (context, index) {
                    return _buildPage(_list[index], region);
                  },
                ),
        );
      },
    );
  }

  Widget _buildPage(Vegetable vegetable, Region region) {
    final data = _findRegionData(_dataFor(region), vegetable.id);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        _HeaderCard(vegetable: vegetable),
        const SizedBox(height: 16),
        if (data != null && data.sowingMonths.isNotEmpty)
          _MonthsCard(
            title: 'Semis — ${region.label}',
            months: data.sowingMonths,
            color: KultivaColors.primaryGreen,
            shortMonths: monthNamesShortCap,
          ),
        if (data != null && data.harvestMonths.isNotEmpty) ...<Widget>[
          const SizedBox(height: 12),
          _MonthsCard(
            title: 'Récolte — ${region.label}',
            months: data.harvestMonths,
            color: KultivaColors.terracotta,
            shortMonths: monthNamesShortCap,
          ),
        ],
        if (data != null && data.regionalNote != null) ...<Widget>[
          const SizedBox(height: 12),
          _RegionalNoteCard(
            region: region,
            note: data.regionalNote!,
          ),
        ],
        const SizedBox(height: 16),
        _InfoSection(
          title: '🌱  Semis',
          rows: <_Row>[
            _Row('Technique', vegetable.sowingTechnique),
            _Row('Profondeur', vegetable.sowingDepth),
            _Row('Température', vegetable.germinationTemp),
            _Row('Levée', vegetable.germinationDays),
          ],
        ),
        _InfoSection(
          title: '🌿  Culture',
          rows: <_Row>[
            _Row('Exposition', vegetable.exposure),
            _Row('Espacement', vegetable.spacing),
            _Row('Arrosage', vegetable.watering),
            _Row('Sol', vegetable.soil),
          ],
        ),
        if (vegetable.harvestTimeBySeason != null &&
            vegetable.harvestTimeBySeason!.isNotEmpty)
          _HarvestTimeSection(times: vegetable.harvestTimeBySeason!),
        _InfoSection(
          title: '📦  Rendement',
          rows: <_Row>[
            _Row('Estimation', vegetable.yieldEstimate),
          ],
        ),
        if (companionMap.containsKey(vegetable.id))
          _CompanionSection(
            title: '🤝  Bons voisins',
            ids: companionMap[vegetable.id]!,
            color: KultivaColors.primaryGreen,
          ),
        if (incompatibleMap.containsKey(vegetable.id))
          _CompanionSection(
            title: '⛔  À éviter à côté',
            ids: incompatibleMap[vegetable.id]!,
            color: KultivaColors.terracotta,
          ),
        if (diseaseMap.containsKey(vegetable.id))
          _DiseaseSection(diseases: diseaseMap[vegetable.id]!),
        if (rotationMap.containsKey(vegetable.id))
          _RotationSection(data: rotationMap[vegetable.id]!),
        if (_list.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              '← Swipe pour naviguer →',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: KultivaColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
        // Bouton Acheter en bas (sauf accessoires qui ont déjà le panier en haut).
        if (vegetable.amazonUrl != null &&
            vegetable.category != VegetableCategory.accessories) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _openUrl(context, vegetable.amazonUrl!),
              icon: const Text('🛒', style: TextStyle(fontSize: 24)),
              label: const Text('Acheter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: KultivaColors.terracotta,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lien partenaire · Kultiva touche une petite commission si tu achètes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8a8c80),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Vegetable vegetable;
  const _HeaderCard({required this.vegetable});

  MedalTier _loadTier() {
    final plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    return computeMedalTier(vegetable.id, plantations);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.plantationsVersion,
      builder: (_, __, ___) {
        final tier = _loadTier();
        return _buildCard(context, tier);
      },
    );
  }

  Widget _buildCard(BuildContext context, MedalTier tier) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              vegetable.name,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              vegetable.category.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KultivaColors.textSecondary,
                  ),
            ),
            if (tier != MedalTier.none) ...<Widget>[
              const SizedBox(height: 6),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: tier.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: tier.color, width: 1.2),
                  ),
                  child: Text(
                    '${tier.emoji}  ${tier.label}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: tier.color,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MedalBadge(
                  emoji: vegetable.emoji,
                  imageAsset: vegetable.imageAsset,
                  tier: tier,
                  familyColor: KultivaColors.primaryGreen,
                  size: 78,
                  showCornerMedal: tier != MedalTier.none,
                ),
                if (vegetable.amazonUrl != null)
                  _MiniActionBlock(
                    emoji: '🛒',
                    label: 'Acheter',
                    sublabel: 'Lien partenaire',
                    gradientColors: [
                      KultivaColors.terracotta.withValues(alpha: 0.28),
                      KultivaColors.summerA.withValues(alpha: 0.4),
                    ],
                    foreground: KultivaColors.terracotta,
                    tooltip: 'Lien partenaire Amazon — Kultiva touche '
                        'une petite commission si tu achètes.',
                    onTap: () {
                      AudioService.instance.play(Sfx.cart);
                      launchUrl(
                        Uri.parse(vegetable.amazonUrl!),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
              ],
            ),
            if (vegetable.description != null) ...<Widget>[
              const SizedBox(height: 16),
              LexiconText(
                vegetable.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MonthsCard extends StatelessWidget {
  final String title;
  final List<int> months;
  final Color color;
  final List<String> shortMonths;

  const _MonthsCard({
    required this.title,
    required this.months,
    required this.color,
    required this.shortMonths,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List<Widget>.generate(12, (i) {
                final m = i + 1;
                final active = months.contains(m);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: active
                                ? color
                                : color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shortMonths[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: active
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: active
                                ? color
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row {
  final String label;
  final String? value;
  const _Row(this.label, this.value);
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<_Row> rows;
  const _InfoSection({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    final filled = rows.where((r) => r.value != null).toList();
    if (filled.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              for (final r in filled)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 110,
                        child: Text(
                          r.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r.value!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HarvestTimeSection extends StatelessWidget {
  final Map<String, String> times;
  const _HarvestTimeSection({required this.times});

  static const _order = <String, ({String emoji, Color color})>{
    'spring': (emoji: '🌸', color: Color(0xFFE8A87C)),
    'summer': (emoji: '☀️', color: Color(0xFFFFB74D)),
    'autumn': (emoji: '🍂', color: Color(0xFFD5A679)),
    'winter': (emoji: '❄️', color: Color(0xFF7BAFD4)),
  };

  @override
  Widget build(BuildContext context) {
    final entries = _order.entries
        .where((e) => times.containsKey(e.key))
        .toList();
    if (entries.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '⏱  Temps avant récolte',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              for (final e in entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: e.value.color.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(e.value.emoji,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 90,
                        child: Text(
                          _seasonLabel(e.key),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          times[e.key]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _seasonLabel(String key) {
    switch (key) {
      case 'spring':
        return 'Printemps';
      case 'summer':
        return 'Été';
      case 'autumn':
        return 'Automne';
      case 'winter':
        return 'Hiver';
    }
    return key;
  }
}

class _DiseaseSection extends StatelessWidget {
  final List<Disease> diseases;
  const _DiseaseSection({required this.diseases});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🐛  Maladies & ravageurs',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              for (final d in diseases)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LexiconText(
                        d.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: KultivaColors.terracotta,
                        ),
                      ),
                      const SizedBox(height: 2),
                      LexiconText(
                        d.remedy,
                        style: const TextStyle(fontSize: 13, height: 1.3),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RotationSection extends StatelessWidget {
  final RotationData data;
  const _RotationSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final successors = data.goodAfter
        .map((id) {
          try {
            return vegetablesBase.firstWhere((v) => v.id == id);
          } catch (_) {
            return null;
          }
        })
        .whereType<Vegetable>()
        .toList();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🔄  Rotation des cultures',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Famille : ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(data.family,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Attendre : ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${data.waitYears} ans avant de replanter au même endroit',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (successors.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Bons successeurs :',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: successors.map((v) {
                    return Chip(
                      avatar:
                          Text(v.emoji, style: const TextStyle(fontSize: 16)),
                      label: Text(v.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanionSection extends StatelessWidget {
  final String title;
  final List<String> ids;
  final Color color;
  const _CompanionSection({
    required this.title,
    required this.ids,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final vegs = ids
        .map((id) {
          try {
            return vegetablesBase.firstWhere((v) => v.id == id);
          } catch (_) {
            return null;
          }
        })
        .whereType<Vegetable>()
        .toList();
    if (vegs.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vegs.map((v) {
                  return Chip(
                    avatar: Text(v.emoji, style: const TextStyle(fontSize: 16)),
                    label: Text(
                      v.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionalNoteCard extends StatelessWidget {
  final Region region;
  final String note;
  const _RegionalNoteCard({required this.region, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KultivaColors.summerA.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(region.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Adaptation — ${region.label}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.35,
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

class _MiniActionBlock extends StatelessWidget {
  final String emoji;
  final String label;
  final String sublabel;
  final List<Color> gradientColors;
  final Color foreground;
  final String tooltip;
  final VoidCallback onTap;

  const _MiniActionBlock({
    required this.emoji,
    required this.label,
    required this.sublabel,
    required this.gradientColors,
    required this.foreground,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: foreground.withValues(alpha: 0.22),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: foreground,
                ),
              ),
              Text(
                sublabel,
                style: TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w500,
                  color: foreground.withValues(alpha: 0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
