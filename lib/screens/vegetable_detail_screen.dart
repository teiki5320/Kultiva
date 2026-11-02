import '../data/content_i18n.dart';
import '../data/names_en.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/audio_service.dart';
import '../data/regions/regional_calendar.dart';
import '../data/accessory_guide.dart';
import '../data/companions.dart';
import '../data/diseases.dart';
import '../data/local_names.dart';
import '../data/market_buying_tips.dart';
import '../data/market_data.dart';
import '../data/recipes.dart';
import '../widgets/recipe_row.dart';
import '../data/rotation.dart';
import '../data/ui_i18n.dart';
import '../data/vegetables_base.dart';
import '../models/country.dart';
import '../models/plantation.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';
import '../models/vegetable_medal.dart';
import '../services/pdf_service.dart';
import '../services/plantation_service.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';
import '../widgets/readable_width.dart';
import '../utils/months.dart';
import '../widgets/lexicon_text.dart';
import '../widgets/medal_badge.dart';
import 'root_tabs.dart';

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

  /// Entrée unique de la collection : c'est d'ici qu'un plant naît.
  /// Sans ce bouton, le Poussidex restait vide à vie — aucun écran ne
  /// créait de `Plantation`, alors que la fiche App Store promet une
  /// collection de plants.
  Future<void> _recordPlanting() async {
    final v = _currentVegetable;
    AudioService.instance.play(Sfx.plant);
    await PlantationService.instance.add(v.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(trUiArgs(
            '{0} {1} est noté dans ton cahier', <Object?>[v.emoji, v.displayName])),
        action: SnackBarAction(
          label: trUi('Voir'),
          onPressed: () {
            // Onglet 1 = Cahier. Il pointait sur 2, c'est-à-dire
            // l'Étal : le bouton « Voir » renvoyait au catalogue
            // d'où l'on venait.
            RootTabs.tabIndex.value = 1;
            Navigator.of(context).popUntil((r) => r.isFirst);
          },
        ),
      ),
    );
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
          SnackBar(
            content: Text(trUi("Impossible d'ouvrir le lien.")),
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
            title:
                Text('${_currentVegetable.emoji}  ${_currentVegetable.displayName}'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                tooltip: trUi('Exporter PDF'),
                onPressed: () =>
                    PdfService.printVegetableSheet(_currentVegetable, region),
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
                    tooltip: isFav
                        ? trUiArgs('Retirer {0} des favoris',
                            <Object?>[_currentVegetable.displayName])
                        : trUiArgs('Ajouter {0} aux favoris',
                            <Object?>[_currentVegetable.displayName]),
                    onPressed: () => PrefsService.instance
                        .toggleFavorite(_currentVegetable.id),
                  );
                },
              ),
            ],
          ),
          // Les accessoires (outils, jardinières) ne se plantent pas :
          // pas de bouton sur leurs fiches.
          floatingActionButton: _currentVegetable.category ==
                  VegetableCategory.accessories
              ? null
              : ListenableBuilder(
                  listenable: PlantationService.instance,
                  builder: (context, _) {
                    final count = PlantationService.instance
                        .countFor(_currentVegetable.id);
                    return FloatingActionButton.extended(
                      onPressed: _recordPlanting,
                      backgroundColor: KultivaColors.primaryGreen,
                      foregroundColor: Colors.white,
                      icon: const Text('🌱', style: TextStyle(fontSize: 18)),
                      label: Text(
                        count == 0
                            ? trUi('Je l\'ai planté')
                            : trUiArgs('Je l\'ai planté ({0})', <Object?>[count]),
                      ),
                    );
                  },
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
    final data = _findRegionData(currentCalendar(), vegetable.id);
    final lieu = placeLabelFor(region, PrefsService.instance.country.value);
    return ReadableWidth(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          _HeaderCard(vegetable: vegetable),
          // Les 39 fiches d'accessoires n'avaient ni calendrier, ni
          // maladies, ni recettes : elles étaient les plus vides de
          // l'app. Un accessoire n'a pas de saison de semis, mais il a
          // un moment, un geste, une quantité et un entretien.
          if (accessoryGuideFor(vegetable.id) != null) ...<Widget>[
            const SizedBox(height: 12),
            _AccessoryGuideCard(guide: accessoryGuideFor(vegetable.id)!),
          ],
          if (region == Region.westAfrica &&
              localNames[vegetable.id] != null) ...<Widget>[
            const SizedBox(height: 12),
            _LocalNamesCard(names: localNames[vegetable.id]!),
          ],
          const SizedBox(height: 16),
          if (data != null && data.sowingMonths.isNotEmpty)
            _MonthsCard(
              title: trUiArgs('Semis — {0}', <Object?>[lieu]),
              months: data.sowingMonths,
              color: KultivaColors.primaryGreen,
              shortMonths: monthNamesShortCap,
            ),
          if (data != null && data.harvestMonths.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            _MonthsCard(
              title: trUiArgs('Récolte — {0}', <Object?>[lieu]),
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
            title: trUi('🌱  Semis'),
            rows: <_Row>[
              _Row(trUi('Technique'), vegetable.sowingTechnique),
              _Row(trUi('Profondeur'), vegetable.sowingDepth),
              _Row(trUi('Température'), vegetable.germinationTemp),
              _Row(trUi('Levée'), vegetable.germinationDays),
            ],
          ),
          _InfoSection(
            title: trUi('🌿  Culture'),
            rows: <_Row>[
              _Row(trUi('Exposition'), vegetable.exposure),
              _Row(trUi('Espacement'), vegetable.spacing),
              _Row(trUi('Arrosage'), vegetable.watering),
              _Row(trUi('Sol'), vegetable.soil),
            ],
          ),
          if (vegetable.harvestTimeBySeason != null &&
              vegetable.harvestTimeBySeason!.isNotEmpty)
            _HarvestTimeSection(times: vegetable.harvestTimeBySeason!),
          _InfoSection(
            title: trUi('📦  Rendement'),
            rows: <_Row>[
              _Row(trUi('Estimation'), vegetable.yieldEstimate),
            ],
          ),
          if (companionMap.containsKey(vegetable.id))
            _CompanionSection(
              title: trUi('🤝  Bons voisins'),
              ids: companionMap[vegetable.id]!,
              color: KultivaColors.primaryGreen,
            ),
          if (incompatibleMap.containsKey(vegetable.id))
            _CompanionSection(
              title: trUi('⛔  À éviter à côté'),
              ids: incompatibleMap[vegetable.id]!,
              color: KultivaColors.terracotta,
            ),
          if (diseaseMap.containsKey(vegetable.id))
            _DiseaseSection(diseases: diseaseMap[vegetable.id]!),
          if (rotationMap.containsKey(vegetable.id))
            _RotationSection(data: rotationMap[vegetable.id]!),
          if (region == Region.westAfrica &&
              marketBuyingTips[vegetable.id] != null &&
              vegetable.category != VegetableCategory.accessories)
            _BuyingTipsSection(tips: marketBuyingTips[vegetable.id]!),
          if (region == Region.westAfrica && marketData[vegetable.id] != null)
            _MarketSection(info: marketData[vegetable.id]!),
          if (top3For(vegetable.id).isNotEmpty ||
              otherRecipesFor(vegetable.id).isNotEmpty)
            _RecipesSection(vegetableId: vegetable.id),
          if (_list.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                trUi('← Swipe pour naviguer →'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: KultivaColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
          // Bouton Acheter en bas, sauf accessoires qui ont déjà le panier
          // dans le bandeau.
          //
          // ⚠️ `region == Region.france` ne suffit pas : voir
          // `amazonLinkVisible`.
          if (amazonLinkVisible(region, PrefsService.instance.country.value) &&
              vegetable.category != VegetableCategory.accessories &&
              amazonUrlFor(vegetable) != null) ...<Widget>[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openUrl(context, amazonUrlFor(vegetable)!),
                icon: const Text('🛒', style: TextStyle(fontSize: 24)),
                label: Text(trUi('Acheter'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
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
            Text(
              trUi(
                  'Lien partenaire · Kultiva touche une petite commission si tu achètes.'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8a8c80),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Vegetable vegetable;
  const _HeaderCard({required this.vegetable});

  MedalTier _loadTier() {
    final plantations =
        Plantation.decodeAll(PrefsService.instance.plantationsJson);
    return computeMedalTier(vegetable.id, plantations,
        region: PrefsService.instance.region.value);
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
              vegetable.displayName,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            Builder(
              builder: (context) {
                final badge = MedalBadge(
                  emoji: vegetable.emoji,
                  imageAsset: vegetable.imageAsset,
                  tier: tier,
                  familyColor: KultivaColors.primaryGreen,
                  size: 78,
                  showCornerMedal: tier != MedalTier.none,
                );
                // Le panier du bandeau est réservé aux accessoires : les
                // autres fiches ont le grand bouton en bas, et afficher
                // les deux faisait doublon.
                // ⚠️ Deuxième porte, oubliée le 02/11 quand la
                // première a été corrigée : le panier des accessoires
                // testait encore la région, donc s'affichait dans les
                // 36 pays de la base tempérée. Une règle à deux
                // endroits se corrige à deux endroits.
                final url =
                    vegetable.category == VegetableCategory.accessories &&
                            amazonLinkVisible(
                                PrefsService.instance.region.value,
                                PrefsService.instance.country.value)
                        ? amazonUrlFor(vegetable)
                        : null;
                // Sans panier, la pastille est centrée. Un `Row` à deux
                // extrémités dont un seul enfant la plaquait à gauche,
                // avec le vide à sa droite — invisible sur téléphone,
                // béant sur un iPad.
                if (url == null) return Center(child: badge);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    badge,
                    _MiniActionBlock(
                      emoji: '🛒',
                      label: trUi('Acheter'),
                      sublabel: trUi('Lien partenaire'),
                      gradientColors: <Color>[
                        KultivaColors.terracotta.withValues(alpha: 0.28),
                        KultivaColors.summerA.withValues(alpha: 0.4),
                      ],
                      foreground: KultivaColors.terracotta,
                      tooltip: trUi('Lien partenaire Amazon — Kultiva touche '
                          'une petite commission si tu achètes.'),
                      onTap: () {
                        AudioService.instance.play(Sfx.cart);
                        launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                );
              },
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
                            color:
                                active ? color : color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shortMonths[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                active ? FontWeight.w800 : FontWeight.w600,
                            color: active
                                ? color
                                : Theme.of(context).textTheme.bodySmall?.color,
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
                          style: const TextStyle(
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
    final entries =
        _order.entries.where((e) => times.containsKey(e.key)).toList();
    if (entries.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trUi('⏱  Temps avant récolte'),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          times[e.key]!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
        return trUi('Printemps');
      case 'summer':
        return trUi('Été');
      case 'autumn':
        return trUi('Automne');
      case 'winter':
        return trUi('Hiver');
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
              Text(
                trUi('🐛  Maladies & ravageurs'),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              for (final d in diseases)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LexiconText(
                        d.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: KultivaColors.terracotta,
                        ),
                      ),
                      const SizedBox(height: 2),
                      LexiconText(
                        d.displayRemedy,
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
              Text(
                trUi('🔄  Rotation des cultures'),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    trUi('Famille : '),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(tr(data.family),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    trUi('Attendre : '),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                  Text(
                    trUiArgs('{0} ans avant de replanter au même endroit',
                        <Object?>[data.waitYears]),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (successors.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  trUi('Bons successeurs :'),
                  style: const TextStyle(
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
            Text(placeEmojiFor(region, PrefsService.instance.country.value),
                style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trUiArgs('Adaptation — {0}', <Object?>[
                      placeLabelFor(
                          region, PrefsService.instance.country.value)
                    ]),
                    style: const TextStyle(
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
      child: Semantics(
        label: '$label, $sublabel',
        hint: tooltip,
        button: true,
        excludeSemantics: true,
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
      ),
    );
  }
}

/// Noms locaux de la culture (wolof, bambara, haoussa…), affichés en
/// Afrique de l'Ouest pour que le jardinier reconnaisse son légume.
class _LocalNamesCard extends StatelessWidget {
  final List<LocalName> names;
  const _LocalNamesCard({required this.names});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KultivaColors.lightGreen.withValues(alpha: 0.18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              trUi('🗣️  Noms locaux'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final n in names)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: KultivaColors.lightGreen,
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: '${n.name}  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: n.language,
                          style: const TextStyle(
                            fontSize: 11,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ]),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Estimation maraîchage (rendement + valeur marché en FCFA), affichée
/// en Afrique de l'Ouest pour les jardiniers qui cultivent pour vendre.
class _MarketSection extends StatelessWidget {
  final MarketInfo info;
  const _MarketSection({required this.info});

  @override
  Widget build(BuildContext context) {
    final yieldStr = info.yieldPerPlantKg >= 1
        ? '${info.yieldPerPlantKg.toStringAsFixed(info.yieldPerPlantKg % 1 == 0 ? 0 : 1)} kg'
        : '${(info.yieldPerPlantKg * 1000).round()} g';
    final value = (info.yieldPerPlantKg * info.priceFcfaPerKg).round();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                trUi('💰  Maraîchage'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                trUi('Ordres de grandeur indicatifs (marchés urbains).'),
                style: const TextStyle(
                  fontSize: 11,
                  color: KultivaColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              _MarketRow(trUi('Rendement'),
                  trUiArgs('~{0} par pied/cycle', <Object?>[yieldStr])),
              _MarketRow(
                  trUi('Prix marché'),
                  trUiArgs(
                      '~{0} FCFA / kg', <Object?>[info.priceFcfaPerKg])),
              _MarketRow(trUi('Valeur estimée'),
                  trUiArgs('~{0} FCFA par pied', <Object?>[value])),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketRow extends StatelessWidget {
  final String label;
  final String value;
  const _MarketRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: KultivaColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

/// Idées de plats liées à la récolte — boucle le jardin vers la cuisine.
/// La section « En cuisine » d'une fiche légume.
///
/// ⚠️ Elle affichait les recettes **sans pouvoir les ouvrir** : ni
/// lecteur animé, ni temps, ni favori. Le pas-à-pas n'était atteignable
/// que depuis l'onglet Recettes, alors que c'est ici qu'on se demande
/// quoi faire de sa récolte. Elle délègue maintenant à [RecipeRow],
/// comme l'onglet : une seule ligne de recette dans toute l'app.
/// La section « En cuisine » d'une fiche légume.
///
/// Le **top 3** d'abord — contrainte de Jean : trois recettes mises en
/// avant, jamais plus, parce que vingt idées de plat ne se choisissent
/// pas. En dessous, ce qui emploie ce légume sans être dans son top 3,
/// replié : une recette hors du top doit rester joignable.
///
/// ⚠️ Cette section affichait les recettes **sans pouvoir les ouvrir** :
/// le lecteur animé n'était atteignable que depuis l'onglet, alors que
/// c'est ici qu'on se demande quoi faire de sa récolte. Elle délègue
/// maintenant à [RecipeRow], comme l'onglet.
class _RecipesSection extends StatelessWidget {
  final String vegetableId;
  const _RecipesSection({required this.vegetableId});

  @override
  Widget build(BuildContext context) {
    final top = top3For(vegetableId);
    final autres = otherRecipesFor(vegetableId);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 2, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trUi('🫙  Garder ta récolte'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    if (top.any((r) => r.isPreservation))
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          trUi('Trois façons de la faire durer. Un jardinier '
                              'n\'a pas un légume, il en a quinze d\'un coup.'),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              for (final r in top)
                RecipeRow(vegetableId: vegetableId, recipe: r),
              if (autres.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 14, top: 4),
                  child: _AutresRecettes(
                      vegetableId: vegetableId, recipes: autres),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Les recettes hors du top 3, repliées derrière une ligne.
///
/// Repliées et pas absentes : le top 3 reste le propos, mais une
/// recette que rien n'atteint est un bug.
class _AutresRecettes extends StatefulWidget {
  final String vegetableId;
  final List<Recipe> recipes;

  const _AutresRecettes({required this.vegetableId, required this.recipes});

  @override
  State<_AutresRecettes> createState() => _AutresRecettesState();
}

class _AutresRecettesState extends State<_AutresRecettes> {
  bool _ouvert = false;

  @override
  Widget build(BuildContext context) {
    final n = widget.recipes.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _ouvert = !_ouvert),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  _ouvert ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: KultivaColors.primaryGreen,
                ),
                const SizedBox(width: 6),
                Text(
                  // Le top 3 garde la récolte ; le reste se mange le jour
                  // même. Dire lequel est lequel évite de chercher une
                  // conserve dans la liste des plats.
                  n > 1
                      ? trUiArgs('{0} recettes à manger tout de suite',
                          <Object?>[n])
                      : trUiArgs('{0} recette à manger tout de suite',
                          <Object?>[n]),
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: KultivaColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_ouvert)
          for (final r in widget.recipes)
            RecipeRow(
              vegetableId: ownerOf(r) ?? widget.vegetableId,
              recipe: r,
            ),
      ],
    );
  }
}

/// Conseils d'achat au marché (semences, semenceaux, boutures, rejets),
/// affichés en Afrique de l'Ouest à la place du lien Amazon indisponible.
class _BuyingTipsSection extends StatelessWidget {
  final List<BuyingTip> tips;
  const _BuyingTipsSection({required this.tips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        color: KultivaColors.terracotta.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                trUi('🛍️  Bien acheter au marché'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              for (final t in tips)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                              KultivaColors.terracotta.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          t.what,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: KultivaColors.terracotta,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr(t.advice),
                        style: const TextStyle(
                          fontSize: 13,
                          color: KultivaColors.textPrimary,
                          height: 1.35,
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

/// Le mode d'emploi d'un accessoire : quand, comment, combien,
/// l'entretien, et ce qu'on peut fabriquer à la place.
class _AccessoryGuideCard extends StatelessWidget {
  final AccessoryGuide guide;
  const _AccessoryGuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    final diy = guide.displayDiy;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _ligne('🗓️', trUi('Quand s\'en servir'), guide.displayWhen),
            _ligne('🤲', trUi('Comment l\'utiliser'), guide.displayHow),
            _ligne('📐', trUi('Combien il en faut'), guide.displayHowMuch),
            _ligne('🧽', trUi('Entretien'), guide.displayCare),
            // Tout n'a pas d'équivalent maison : on ne forge pas un
            // sécateur. Le champ est nul là où ce serait mentir.
            if (diy != null)
              _ligne('🔨', trUi('À faire soi-même'), diy, dernier: true)
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _ligne(String emoji, String titre, String texte,
      {bool dernier = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: dernier ? 0 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                LexiconText(
                  texte,
                  style: const TextStyle(fontWeight: FontWeight.w600,
                      height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
