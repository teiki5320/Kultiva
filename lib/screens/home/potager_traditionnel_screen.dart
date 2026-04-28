import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/garden_plan.dart';
import '../../models/vegetable.dart';
import '../../services/culture_service.dart';
import '../../services/garden_plan_service.dart';
import '../../services/prefs_service.dart';
import '../../services/pdf_service.dart';
import '../../services/watering_advisor.dart';
import '../../services/weather_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/phenology.dart';
import '../../widgets/watering_bars.dart';
import 'culture_start_sheet.dart';
import 'garden_planner_screen.dart';
import 'monthly_calendar_screen.dart';
import 'vegetables_screen.dart';
import 'weather_screen.dart';

/// Cahier de culture pleine terre : suivi sérieux des cultures en cours
/// et passées, distinct du Poussidex (qui reste le mini-jeu kawaii).
class PotagerTraditionnelScreen extends StatefulWidget {
  const PotagerTraditionnelScreen({super.key});

  @override
  State<PotagerTraditionnelScreen> createState() =>
      _PotagerTraditionnelScreenState();
}

class _PotagerTraditionnelScreenState
    extends State<PotagerTraditionnelScreen>
    with SingleTickerProviderStateMixin {
  WeatherData? _weather;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // Force rebuild pour cacher/afficher le FAB selon l'onglet actif.
      if (mounted) setState(() {});
    });
    _loadWeather();
    GardenPlanService.instance.load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadWeather() async {
    final w = await WeatherService.getWeather();
    if (mounted) setState(() => _weather = w);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📔  Cahier pleine terre'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Tab>[
            Tab(icon: Icon(Icons.grid_view), text: 'Planification'),
            Tab(icon: Icon(Icons.eco), text: 'Croissance'),
            Tab(icon: Icon(Icons.notifications_outlined), text: 'Rappel'),
          ],
        ),
      ),
      floatingActionButton: _tabController.index == 1
          ? _StartFab(onStarted: () {})
          : (_tabController.index == 0 ? _PlanFab() : null),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildPlanificationTab(),
          _buildCroissanceTab(),
          _buildRappelTab(),
        ],
      ),
    );
  }

  Widget _buildPlanificationTab() {
    return ValueListenableBuilder<List<GardenPlan>>(
      valueListenable: GardenPlanService.instance.plans,
      builder: (ctx, plans, _) {
        if (plans.isEmpty) {
          return _EmptyState(
            emoji: '🗺️',
            message:
                "Aucun jardin planifié pour l'instant. Touche le bouton « + » pour créer ton premier potager carré.",
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          itemCount: plans.length,
          itemBuilder: (_, i) => _GardenPlanCard(plan: plans[i]),
        );
      },
    );
  }

  Widget _buildCroissanceTab() {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.culturesVersion,
      builder: (ctx, _, __) {
        final active = CultureService.instance
            .activeByMethod(CultivationMethod.soil);
        final ended = CultureService.instance
            .endedByMethod(CultivationMethod.soil);
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: <Widget>[
            const _PotagerHero(),
            const SizedBox(height: 16),
            _SectionHeader(
              emoji: '🌿',
              title: 'Cultures en cours',
              count: active.length,
            ),
            const SizedBox(height: 8),
            if (active.isEmpty)
              const _EmptyState(
                emoji: '🌱',
                message:
                    "Aucune culture en cours. Appuie sur « Démarrer une culture » pour créer ta première fiche.",
              )
            else
              ...active.map(
                (c) => _CultureCard(culture: c, weather: _weather),
              ),
            const SizedBox(height: 24),
            if (ended.isNotEmpty) ...<Widget>[
              _EndedSection(list: ended, weather: _weather),
              const SizedBox(height: 16),
              _SeasonRecapCta(),
              const SizedBox(height: 24),
            ],
            _InfoExpansion(),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _LinkCta(
                    emoji: '📅',
                    title: 'Calendrier',
                    subtitle: 'Mois par mois',
                    onTap: () => Navigator.of(ctx).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MonthlyCalendarScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LinkCta(
                    emoji: '🌦️',
                    title: 'Météo',
                    subtitle: 'Pluie à venir',
                    onTap: () => Navigator.of(ctx).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const WeatherScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _AccessoriesCta(
              onTap: () => Navigator.of(ctx).push(
                MaterialPageRoute<void>(
                  builder: (_) => const VegetablesScreen(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRappelTab() {
    return ValueListenableBuilder<int>(
      valueListenable: PrefsService.instance.culturesVersion,
      builder: (ctx, _, __) {
        final cultures = CultureService.instance
            .activeByMethod(CultivationMethod.soil);
        if (cultures.isEmpty) {
          return const _EmptyState(
            emoji: '🔔',
            message:
                "Aucun rappel pour l'instant. Démarre une culture dans l'onglet « Croissance » pour voir tes prochaines actions.",
          );
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: <Widget>[
            const Text(
              'Prochaines actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              'Basé sur tes cultures actives et la météo.',
              style: TextStyle(
                fontSize: 12,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ...cultures.map((c) => _ReminderCard(culture: c, weather: _weather)),
          ],
        );
      },
    );
  }
}

/// FAB de l'onglet Planification : crée un nouveau jardin.
class _PlanFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const GardenPlannerScreen(),
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Nouveau jardin'),
      backgroundColor: KultivaColors.primaryGreen,
      foregroundColor: Colors.white,
    );
  }
}

/// Card d'un jardin planifié dans l'onglet Planification.
class _GardenPlanCard extends StatelessWidget {
  final GardenPlan plan;
  const _GardenPlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final filledCells = plan.cells.length;
    final totalCells = plan.cols * plan.rows;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: KultivaColors.lightGreen.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.grid_view, size: 22),
        ),
        title: Text(
          plan.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${plan.cols} × ${plan.rows} cases · $filledCells/$totalCells occupées'
          '${plan.location != null ? ' · ${plan.location}' : ''}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => GardenPlannerScreen(initialPlan: plan),
          ),
        ),
      ),
    );
  }
}

/// Card de rappel d'une culture active dans l'onglet Rappel.
class _ReminderCard extends StatelessWidget {
  final CultureEntry culture;
  final WeatherData? weather;
  const _ReminderCard({required this.culture, required this.weather});

  @override
  Widget build(BuildContext context) {
    final veg = vegetablesBase.firstWhere(
      (v) => v.id == culture.vegetableId,
      orElse: () => vegetablesBase.first,
    );
    final advice = suggestWatering(culture, weather);
    final reminder = advice?.message ??
        'Pas de rappel particulier pour le moment. Continue ton suivi habituel.';
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Text(veg.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    veg.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reminder,
                    style: TextStyle(
                      fontSize: 12,
                      color: KultivaColors.textSecondary,
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

class _StartFab extends StatelessWidget {
  final VoidCallback onStarted;
  const _StartFab({required this.onStarted});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final created = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (_) =>
              const CultureStartSheet(method: CultivationMethod.soil),
        );
        if (created == true) onStarted();
      },
      icon: const Icon(Icons.add),
      label: const Text(
        'Démarrer une culture',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      backgroundColor: KultivaColors.primaryGreen,
      foregroundColor: Colors.white,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String emoji;
  final String title;
  final int count;

  const _SectionHeader({
    required this.emoji,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: KultivaColors.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }
}

class _CultureCard extends StatelessWidget {
  final CultureEntry culture;
  final WeatherData? weather;
  const _CultureCard({required this.culture, this.weather});

  Vegetable? _veg() {
    try {
      return vegetablesBase.firstWhere((v) => v.id == culture.vegetableId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final veg = _veg();
    final days = culture.daysSinceStarted;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _showActions(context),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: KultivaColors.springA.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: KultivaColors.primaryGreen.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: KultivaColors.primaryGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      veg?.emoji ?? '🌱',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          veg?.name ?? culture.vegetableId,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          days == 0
                              ? 'Démarrée aujourd\'hui'
                              : 'Démarrée il y a $days jour${days > 1 ? "s" : ""}',
                          style: TextStyle(
                            fontSize: 12,
                            color: KultivaColors.textSecondary,
                          ),
                        ),
                        if (culture.note != null &&
                            culture.note!.isNotEmpty) ...<Widget>[
                          const SizedBox(height: 4),
                          Text(
                            culture.note!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: KultivaColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              if (veg != null) ...<Widget>[
                if (expectedStage(veg, days) != null) ...<Widget>[
                  const SizedBox(height: 8),
                  _StageChip(hint: expectedStage(veg, days)!),
                ],
              ],
              const SizedBox(height: 10),
              _WateringTrack(culture: culture),
              if (suggestWatering(culture, weather) != null) ...<Widget>[
                const SizedBox(height: 10),
                _AdviceBanner(
                  advice: suggestWatering(culture, weather)!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Text('💧',
                  style: TextStyle(fontSize: 22)),
              title: const Text('Marquer arrosé aujourd\'hui'),
              subtitle: Text(
                culture.lastWatering == null
                    ? 'Pas encore arrosé'
                    : 'Dernier arrosage : il y a '
                        '${DateTime.now().difference(culture.lastWatering!).inDays}j',
              ),
              onTap: () async {
                Navigator.pop(ctx);
                await CultureService.instance.markWatered(culture.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Arrosage enregistré 💧'),
                    ),
                  );
                }
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Marquer terminée'),
              onTap: () async {
                Navigator.pop(ctx);
                await CultureService.instance.endCulture(culture.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(ctx).colorScheme.error,
              ),
              title: Text(
                'Supprimer',
                style: TextStyle(
                  color: Theme.of(ctx).colorScheme.error,
                ),
              ),
              onTap: () async {
                Navigator.pop(ctx);
                await CultureService.instance.remove(culture.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Chip décrivant l'étape phénologique attendue de la culture.
/// Tap = expand pour afficher le détail / conseil.
class _StageChip extends StatelessWidget {
  final PhenologyHint hint;
  const _StageChip({required this.hint});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetail(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: KultivaColors.primaryGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(hint.emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Étape : ${hint.label}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: KultivaColors.primaryGreen,
                ),
              ),
            ),
            const Icon(
              Icons.info_outline,
              size: 14,
              color: KultivaColors.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(hint.emoji,
                      style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hint.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                hint.detail,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mini-bandeau d'arrosage 14 jours sous la card de culture pleine
/// terre. Affiche un titre + des barres + le dernier arrosage.
class _WateringTrack extends StatelessWidget {
  final CultureEntry culture;
  const _WateringTrack({required this.culture});

  @override
  Widget build(BuildContext context) {
    final last = culture.lastWatering;
    final daysSince = last == null
        ? null
        : DateTime.now().difference(last).inDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text('💧', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              'Arrosages 14j',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: KultivaColors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              daysSince == null
                  ? 'Jamais arrosé'
                  : daysSince == 0
                      ? 'Arrosé aujourd\'hui'
                      : 'Il y a ${daysSince}j',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: daysSince != null && daysSince >= 5
                    ? const Color(0xFFE8A87C)
                    : KultivaColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        WateringBars(history: culture.wateringHistory()),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String emoji;
  final String message;
  const _EmptyState({required this.emoji, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: KultivaColors.springA.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: KultivaColors.textSecondary.withValues(alpha: 0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 42)),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: KultivaColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndedSection extends StatelessWidget {
  final List<CultureEntry> list;
  final WeatherData? weather;
  const _EndedSection({required this.list, this.weather});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: _SectionHeader(
          emoji: '✅',
          title: 'Cultures terminées',
          count: list.length,
        ),
        children: list
            .map((c) => _CultureCard(culture: c, weather: weather))
            .toList(),
      ),
    );
  }
}

/// CTA d'export PDF du récap de saison. Le bouton ouvre la feuille
/// d'aperçu / impression du PDF généré par PdfService.
class _SeasonRecapCta extends StatelessWidget {
  Future<void> _print(BuildContext context) async {
    final all = CultureService.instance.loadAll();
    await PdfService.printSeasonRecap(
      year: DateTime.now().year,
      cultures: all,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _print(context),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              KultivaColors.primaryGreen.withValues(alpha: 0.18),
              KultivaColors.springA.withValues(alpha: 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('📄', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Récap saison ${DateTime.now().year}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Génère un PDF avec stats, top légumes, '
                    'familles, détail des cultures.',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.picture_as_pdf,
                color: KultivaColors.primaryGreen),
          ],
        ),
      ),
    );
  }
}

/// Bandeau de conseil d'arrosage produit par WateringAdvisor.
class _AdviceBanner extends StatelessWidget {
  final WateringAdvice advice;
  const _AdviceBanner({required this.advice});

  Color get _color {
    switch (advice.urgency) {
      case WateringUrgency.skip:
        return const Color(0xFF4A9BBF);
      case WateringUrgency.ok:
        return KultivaColors.primaryGreen;
      case WateringUrgency.dueSoon:
        return const Color(0xFFE8A87C);
      case WateringUrgency.overdue:
      case WateringUrgency.heatwave:
        return const Color(0xFFD4564A);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(advice.emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              advice.message,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _color,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoExpansion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            'ℹ️  Découvrir la pleine terre',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          children: const <Widget>[
            _CycleDiagram(),
            SizedBox(height: 12),
            _BulletSection(
              emoji: '🌿',
              title: 'Pourquoi rester sur la terre ?',
              bullets: <String>[
                'Le sol vivant nourrit tes légumes avec ses vers, mycéliums et bactéries.',
                'La biodiversité protège naturellement contre les ravageurs.',
                'Respecter les saisons = légumes plus savoureux, moins d\'arrosage.',
                'Autonomie : peu de matériel, beaucoup de bon sens.',
              ],
            ),
            _BulletSection(
              emoji: '🛠️',
              title: 'Comment bien démarrer ?',
              bullets: <String>[
                'Prépare ton sol : compost, paillage, pas de retournement profond.',
                'Choisis la bonne saison pour chaque légume.',
                'Arrose au bon moment selon la météo.',
                'Alterne les familles (rotation) pour éviter l\'épuisement du sol.',
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PotagerHero extends StatelessWidget {
  const _PotagerHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KultivaColors.springA,
            KultivaColors.springB,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: <Widget>[
          const Text('🌻', style: TextStyle(fontSize: 44)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Mon cahier pleine terre',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: KultivaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Suivi sérieux de tes cultures en sol vivant.",
                  style: TextStyle(
                    fontSize: 13,
                    color: KultivaColors.textPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleDiagram extends StatelessWidget {
  const _CycleDiagram();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              _CycleNode(emoji: '🌱', label: 'Semis'),
              _CycleArrow(),
              _CycleNode(emoji: '🌿', label: 'Pousse'),
              _CycleArrow(),
              _CycleNode(emoji: '🧺', label: 'Récolte'),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '↓  rien ne se perd  ↓',
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: KultivaColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              _CycleNode(emoji: '🟫', label: 'Sol'),
              _CycleArrow(reverse: true),
              _CycleNode(emoji: '🍂', label: 'Paillage'),
              _CycleArrow(reverse: true),
              _CycleNode(emoji: '♻️', label: 'Compost'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CycleNode extends StatelessWidget {
  final String emoji;
  final String label;
  const _CycleNode({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: KultivaColors.springA.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _CycleArrow extends StatelessWidget {
  final bool reverse;
  const _CycleArrow({this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        reverse ? '←' : '→',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: KultivaColors.textSecondary,
        ),
      ),
    );
  }
}

class _BulletSection extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> bullets;

  const _BulletSection({
    required this.emoji,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$emoji  $title',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 5, right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkCta extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LinkCta({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: KultivaColors.springA.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccessoriesCta extends StatelessWidget {
  final VoidCallback onTap;
  const _AccessoriesCta({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KultivaColors.primaryGreen.withValues(alpha: 0.22),
              KultivaColors.springA.withValues(alpha: 0.45),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: KultivaColors.primaryGreen,
            width: 1.2,
          ),
        ),
        child: Row(
          children: <Widget>[
            const Text('🧰', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Accessoires pleine terre',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: KultivaColors.primaryGreen,
                    ),
                  ),
                  Text(
                    'Outils, terreau, paillage…',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: KultivaColors.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }
}
