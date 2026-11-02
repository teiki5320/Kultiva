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
import '../data/recipes.dart';
import '../data/rotation.dart';
import '../data/ui_i18n.dart';
import '../data/vegetables_base.dart';
import '../models/country.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';
import '../services/pdf_service.dart';
import '../services/plantation_service.dart';
import '../services/prefs_service.dart';
import '../theme/app_theme.dart';
import '../widgets/readable_width.dart';
import '../utils/months.dart';
import 'root_tabs.dart';
import 'vegetable_detail/detail_calendar.dart';
import 'vegetable_detail/detail_culture.dart';
import 'vegetable_detail/detail_header.dart';
import 'vegetable_detail/detail_recettes.dart';
import 'vegetable_detail/detail_voisins.dart';

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
        content: Text(trUiArgs('{0} {1} est noté dans ton cahier',
            <Object?>[v.emoji, v.displayName])),
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
            title: Text(
                '${_currentVegetable.emoji}  ${_currentVegetable.displayName}'),
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
                            : trUiArgs(
                                'Je l\'ai planté ({0})', <Object?>[count]),
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
    final data = calendarEntryFor(currentCalendar(), vegetable.id);
    final lieu = placeLabelFor(region, PrefsService.instance.country.value);
    return ReadableWidth(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          HeaderCard(vegetable: vegetable),
          // Les 39 fiches d'accessoires n'avaient ni calendrier, ni
          // maladies, ni recettes : elles étaient les plus vides de
          // l'app. Un accessoire n'a pas de saison de semis, mais il a
          // un moment, un geste, une quantité et un entretien.
          if (accessoryGuideFor(vegetable.id) != null) ...<Widget>[
            const SizedBox(height: 12),
            AccessoryGuideCard(guide: accessoryGuideFor(vegetable.id)!),
          ],
          if (region == Region.westAfrica &&
              localNames[vegetable.id] != null) ...<Widget>[
            const SizedBox(height: 12),
            LocalNamesCard(names: localNames[vegetable.id]!),
          ],
          const SizedBox(height: 16),
          if (data != null && data.sowingMonths.isNotEmpty)
            MonthsCard(
              title: trUiArgs('Semis — {0}', <Object?>[lieu]),
              months: data.sowingMonths,
              color: KultivaColors.primaryGreen,
              shortMonths: monthNamesShortCap,
            ),
          if (data != null && data.harvestMonths.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            MonthsCard(
              title: trUiArgs('Récolte — {0}', <Object?>[lieu]),
              months: data.harvestMonths,
              color: KultivaColors.terracotta,
              shortMonths: monthNamesShortCap,
            ),
          ],
          if (data != null && data.regionalNote != null) ...<Widget>[
            const SizedBox(height: 12),
            RegionalNoteCard(
              region: region,
              note: data.regionalNote!,
            ),
          ],
          const SizedBox(height: 16),
          InfoSection(
            title: trUi('🌱  Semis'),
            rows: <InfoRow>[
              InfoRow(trUi('Technique'), vegetable.displaySowingTechnique),
              InfoRow(trUi('Profondeur'), vegetable.displaySowingDepth),
              InfoRow(trUi('Température'), vegetable.displayGerminationTemp),
              InfoRow(trUi('Levée'), vegetable.displayGerminationDays),
            ],
          ),
          InfoSection(
            title: trUi('🌿  Culture'),
            rows: <InfoRow>[
              InfoRow(trUi('Exposition'), vegetable.displayExposure),
              InfoRow(trUi('Espacement'), vegetable.displaySpacing),
              InfoRow(trUi('Arrosage'), vegetable.displayWatering),
              InfoRow(trUi('Sol'), vegetable.displaySoil),
            ],
          ),
          if (vegetable.harvestTimeBySeason != null &&
              vegetable.harvestTimeBySeason!.isNotEmpty)
            HarvestTimeSection(times: vegetable.displayHarvestTimeBySeason!),
          InfoSection(
            title: trUi('📦  Rendement'),
            rows: <InfoRow>[
              InfoRow(trUi('Estimation'), vegetable.displayYieldEstimate),
            ],
          ),
          if (companionMap.containsKey(vegetable.id))
            CompanionSection(
              title: trUi('🤝  Bons voisins'),
              ids: companionMap[vegetable.id]!,
              color: KultivaColors.primaryGreen,
            ),
          if (incompatibleMap.containsKey(vegetable.id))
            CompanionSection(
              title: trUi('⛔  À éviter à côté'),
              ids: incompatibleMap[vegetable.id]!,
              color: KultivaColors.terracotta,
            ),
          if (diseaseMap.containsKey(vegetable.id))
            DiseaseSection(diseases: diseaseMap[vegetable.id]!),
          if (rotationMap.containsKey(vegetable.id))
            RotationSection(data: rotationMap[vegetable.id]!),
          if (region == Region.westAfrica &&
              marketBuyingTips[vegetable.id] != null &&
              vegetable.category != VegetableCategory.accessories)
            BuyingTipsSection(tips: marketBuyingTips[vegetable.id]!),
          if (top3For(vegetable.id).isNotEmpty ||
              otherRecipesFor(vegetable.id).isNotEmpty)
            RecipesSection(vegetableId: vegetable.id),
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
