import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/regions/france.dart';
import '../data/regions/west_africa.dart';
import '../data/companions.dart';
import '../data/diseases.dart';
import '../data/rotation.dart';
import '../data/vegetables_base.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';
import '../services/pdf_service.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';

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

  static const List<String> _shortMonths = <String>[
    'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
    'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc',
  ];

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

  Future<void> _openAmazon(BuildContext context, Vegetable veg) async {
    final url = veg.amazonUrl;
    if (url == null) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Impossible d'ouvrir le lien Amazon."),
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
            shortMonths: _shortMonths,
          ),
        if (data != null && data.harvestMonths.isNotEmpty) ...<Widget>[
          const SizedBox(height: 12),
          _MonthsCard(
            title: 'Récolte — ${region.label}',
            months: data.harvestMonths,
            color: KultivaColors.terracotta,
            shortMonths: _shortMonths,
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
        const SizedBox(height: 16),
        if (vegetable.amazonUrl != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _openAmazon(context, vegetable),
              icon: const Text('🛒', style: TextStyle(fontSize: 18)),
              label: const Text('Acheter des graines'),
              style: ElevatedButton.styleFrom(
                backgroundColor: KultivaColors.terracotta,
              ),
            ),
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
        const SizedBox(height: 24),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Vegetable vegetable;
  const _HeaderCard({required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: KultivaColors.lightGreen.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    vegetable.emoji,
                    style: const TextStyle(fontSize: 42),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        vegetable.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        vegetable.category.label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: KultivaColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (vegetable.description != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
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
                                : color.withOpacity(0.12),
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
                      Text(
                        d.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: KultivaColors.terracotta,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
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
      color: KultivaColors.summerA.withOpacity(0.35),
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
