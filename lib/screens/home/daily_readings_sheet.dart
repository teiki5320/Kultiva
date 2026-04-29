import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/culture_reading.dart';
import '../../models/hydro_install.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/culture_reading_service.dart';
import '../../services/culture_service.dart';
import '../../services/hydro_install_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/hydro_advisor.dart';

/// Sheet « Mes mesures du jour ». Deux modes de fonctionnement :
///
///   - **Install** (refonte cohérence avril 2026, principal) : on saisit
///     pH, EC, T° eau et humidité **une seule fois pour toute
///     l'installation**, et on génère un conseil par plant qu'elle
///     contient. Constructeur [DailyReadingsSheet.forInstall].
///
///   - **Culture** (legacy, plus utilisé directement mais conservé pour
///     compat) : un sheet par plant. Constructeur principal.
///
/// Pas de jargon dans l'UI, chaque conseil aboutit à une action
/// concrète (« Ajoute 5 mL de partie A », « Pose un humidificateur »).
class DailyReadingsSheet extends StatefulWidget {
  /// Mode culture (legacy). Exactement un de [culture] ou [installId]
  /// est non-null.
  final CultureEntry? culture;

  /// Mode install. Toutes les cultures de l'install reçoivent leurs
  /// conseils.
  final String? installId;

  const DailyReadingsSheet({super.key, required CultureEntry this.culture})
      : installId = null;

  const DailyReadingsSheet.forInstall({super.key, required String this.installId})
      : culture = null;

  @override
  State<DailyReadingsSheet> createState() => _DailyReadingsSheetState();
}

class _DailyReadingsSheetState extends State<DailyReadingsSheet> {
  final _phCtrl = TextEditingController();
  final _ecCtrl = TextEditingController();
  final _waterTempCtrl = TextEditingController();
  final _humidityCtrl = TextEditingController();

  /// Tant qu'on n'a pas appuyé sur « Voir les conseils », on est en
  /// mode saisie. Sinon on bascule sur la liste des panneaux de conseil.
  List<_PlantAdvicePanel>? _panels;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Pré-remplit les champs avec les dernières valeurs connues. En
    // mode install, on stocke les mesures sous l'id de l'install pour
    // que toutes les cultures s'y rattachent ; en mode culture, on
    // garde l'historique par plant.
    final scopeId = _scopeId();
    final svc = CultureReadingService.instance;
    _phCtrl.text = _initial(svc.latest(scopeId, ReadingType.ph));
    _ecCtrl.text = _initial(svc.latest(scopeId, ReadingType.ec));
    _waterTempCtrl.text = _initial(svc.latest(scopeId, ReadingType.waterTemp));
    _humidityCtrl.text =
        _initial(svc.latest(scopeId, ReadingType.airHumidity));
  }

  String _scopeId() {
    return widget.installId ?? widget.culture!.id;
  }

  String _initial(CultureReading? r) {
    if (r?.value == null) return '';
    final v = r!.value!;
    if (v == v.roundToDouble()) return v.toStringAsFixed(0);
    return v.toStringAsFixed(1);
  }

  @override
  void dispose() {
    _phCtrl.dispose();
    _ecCtrl.dispose();
    _waterTempCtrl.dispose();
    _humidityCtrl.dispose();
    super.dispose();
  }

  /// Liste des cultures pour lesquelles on doit générer des conseils.
  /// Mode install = toutes les cultures rattachées. Mode culture = la
  /// culture seule.
  List<CultureEntry> _targetCultures() {
    if (widget.culture != null) return <CultureEntry>[widget.culture!];
    final iid = widget.installId!;
    final install = HydroInstallService.instance.byId(iid);
    if (install == null) return const <CultureEntry>[];
    final all = CultureService.instance.loadAll();
    final byId = <String, CultureEntry>{
      for (final c in all) c.id: c,
    };
    return <CultureEntry>[
      for (final cid in install.slotCultureIds)
        if (cid != null && byId[cid] != null) byId[cid]!,
    ];
  }

  String _headerSubtitle() {
    final cultures = _targetCultures();
    if (cultures.isEmpty) {
      return 'Aucun plant — ajoute-en avant de mesurer';
    }
    if (cultures.length == 1) {
      final c = cultures.first;
      final v = _vegFor(c);
      return '${v?.emoji ?? "🌱"}  ${v?.name ?? c.vegetableId}  ·  '
          '${c.phase.label}';
    }
    return '${cultures.length} plants';
  }

  Vegetable? _vegFor(CultureEntry c) {
    try {
      return vegetablesBase.firstWhere((v) => v.id == c.vegetableId);
    } catch (_) {
      return null;
    }
  }

  double? _parse(TextEditingController c) {
    final s = c.text.trim().replaceAll(',', '.');
    if (s.isEmpty) return null;
    return double.tryParse(s);
  }

  Future<void> _showAdvice() async {
    final ph = _parse(_phCtrl);
    final ec = _parse(_ecCtrl);
    final waterTemp = _parse(_waterTempCtrl);
    final humidity = _parse(_humidityCtrl);

    setState(() => _saving = true);

    // Persiste chaque mesure non vide pour alimenter l'historique.
    final svc = CultureReadingService.instance;
    final scopeId = _scopeId();
    final tasks = <Future<void>>[];
    if (ph != null) {
      tasks.add(
          svc.add(cultureId: scopeId, type: ReadingType.ph, unit: 'pH', value: ph));
    }
    if (ec != null) {
      tasks.add(svc.add(
          cultureId: scopeId, type: ReadingType.ec, unit: 'mS/cm', value: ec));
    }
    if (waterTemp != null) {
      tasks.add(svc.add(
        cultureId: scopeId,
        type: ReadingType.waterTemp,
        unit: '°C',
        value: waterTemp,
      ));
    }
    if (humidity != null) {
      tasks.add(svc.add(
        cultureId: scopeId,
        type: ReadingType.airHumidity,
        unit: '%',
        value: humidity,
      ));
    }
    await Future.wait(tasks);

    // Génère un panneau de conseils par plant cible. En mode culture
    // (1 plant), il y aura juste 1 panneau ; en mode install, 1 par
    // plant placé.
    final cultures = _targetCultures();
    final panels = <_PlantAdvicePanel>[];
    for (final c in cultures) {
      final veg = _vegFor(c);
      if (veg == null) continue;
      final advices = generateHydroAdvice(
        veg: veg,
        phase: c.phase,
        ph: ph,
        ec: ec,
        waterTempC: waterTemp,
        airHumidityPct: humidity,
      );
      panels.add(_PlantAdvicePanel(
        culture: c,
        veg: veg,
        advices: advices,
      ));
    }

    if (!mounted) return;
    AudioService.instance.play(Sfx.tap);
    setState(() {
      _panels = panels;
      _saving = false;
    });
  }

  String _title() {
    if (_panels == null) return 'Mes mesures du jour';
    return widget.installId != null
        ? 'Conseils par plant'
        : 'Conseils du jour';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scroll) {
        return Container(
          decoration: const BoxDecoration(
            color: KultivaColors.lightBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _DragHandle(),
                const SizedBox(height: 6),
                Text(
                  _title(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _headerSubtitle(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 18),
                if (_panels == null) _buildInputs() else _buildResults(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _MeasureField(
          emoji: '🧪',
          label: 'pH',
          hint: 'Ex. 6.0',
          unit: '',
          controller: _phCtrl,
        ),
        const SizedBox(height: 12),
        _MeasureField(
          emoji: '⚡',
          label: 'Concentration des engrais',
          hint: 'Ex. 1.4',
          unit: 'mS/cm',
          controller: _ecCtrl,
        ),
        const SizedBox(height: 12),
        _MeasureField(
          emoji: '🌡️',
          label: 'Température du réservoir',
          hint: 'Ex. 20',
          unit: '°C',
          controller: _waterTempCtrl,
        ),
        const SizedBox(height: 12),
        _MeasureField(
          emoji: '💨',
          label: 'Humidité de la pièce',
          hint: 'Ex. 60',
          unit: '%',
          controller: _humidityCtrl,
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: _saving ? null : _showAdvice,
          icon: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.auto_awesome),
          label: Text(_saving ? 'Analyse...' : 'Voir les conseils'),
          style: FilledButton.styleFrom(
            backgroundColor: KultivaColors.primaryGreen,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tu peux laisser un champ vide si tu n\'as pas mesuré aujourd\'hui.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: KultivaColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildResults() {
    final panels = _panels!;
    if (panels.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
            const Text('🤔', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              'Aucun plant à conseiller. Ajoute des plants dans tes '
              'slots ou remplis au moins un champ de mesure.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: KultivaColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () => setState(() => _panels = null),
              child: const Text('Retour à la saisie'),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final p in panels) ...<Widget>[
          _PlantPanelView(panel: p, showHeader: panels.length > 1),
          const SizedBox(height: 14),
        ],
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _panels = null),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Modifier'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('C\'est noté'),
                style: FilledButton.styleFrom(
                  backgroundColor: KultivaColors.primaryGreen,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Bundle « conseils pour 1 plant » — sert à grouper l'affichage en
/// mode install (plusieurs plants → plusieurs panneaux).
class _PlantAdvicePanel {
  final CultureEntry culture;
  final Vegetable veg;
  final List<HydroAdvice> advices;
  const _PlantAdvicePanel({
    required this.culture,
    required this.veg,
    required this.advices,
  });
}

class _PlantPanelView extends StatelessWidget {
  final _PlantAdvicePanel panel;

  /// Si `true`, on affiche un en-tête « 🍅 Tomate » au-dessus des
  /// conseils — utile quand il y a plusieurs plants. Si `false`,
  /// l'en-tête est sous-titre du sheet.
  final bool showHeader;

  const _PlantPanelView({required this.panel, required this.showHeader});

  @override
  Widget build(BuildContext context) {
    final advices = panel.advices;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (showHeader)
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Row(
              children: <Widget>[
                Text(panel.veg.emoji,
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${panel.veg.name}  ·  ${panel.culture.phase.label}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        for (final a in advices) ...<Widget>[
          _AdviceCard(advice: a),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _MeasureField extends StatelessWidget {
  final String emoji;
  final String label;
  final String hint;
  final String unit;
  final TextEditingController controller;

  const _MeasureField({
    required this.emoji,
    required this.label,
    required this.hint,
    required this.unit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: KultivaColors.lightGreen.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 78,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 13),
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (unit.isNotEmpty) ...<Widget>[
            const SizedBox(width: 4),
            SizedBox(
              width: 44,
              child: Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  final HydroAdvice advice;
  const _AdviceCard({required this.advice});

  Color _border(AdviceLevel l) {
    switch (l) {
      case AdviceLevel.ok:
        return KultivaColors.primaryGreen;
      case AdviceLevel.warn:
        return const Color(0xFFE8A87C);
      case AdviceLevel.bad:
        return const Color(0xFFD4564A);
    }
  }

  Color _bg(AdviceLevel l) {
    return _border(l).withValues(alpha: 0.08);
  }

  @override
  Widget build(BuildContext context) {
    final color = _border(advice.level);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _bg(advice.level),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(advice.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  advice.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            advice.body,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          if (advice.action != null) ...<Widget>[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('👉', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      advice.action!,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: KultivaColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 38,
        height: 4,
        decoration: BoxDecoration(
          color: KultivaColors.textSecondary.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
