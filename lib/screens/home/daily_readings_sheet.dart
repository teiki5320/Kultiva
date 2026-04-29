import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/culture_reading.dart';
import '../../models/vegetable.dart';
import '../../services/audio_service.dart';
import '../../services/culture_reading_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/hydro_advisor.dart';

/// Sheet « Mes mesures du jour » — saisie de pH, EC, T° eau et
/// humidité ambiante en un seul écran, puis affichage de conseils
/// personnalisés selon le légume cultivé et la phase actuelle.
///
/// Design pensé pour un producteur amateur : pas de jargon dans l'UI,
/// chaque conseil aboutit à une action concrète.
class DailyReadingsSheet extends StatefulWidget {
  final CultureEntry culture;

  const DailyReadingsSheet({super.key, required this.culture});

  @override
  State<DailyReadingsSheet> createState() => _DailyReadingsSheetState();
}

class _DailyReadingsSheetState extends State<DailyReadingsSheet> {
  final _phCtrl = TextEditingController();
  final _ecCtrl = TextEditingController();
  final _waterTempCtrl = TextEditingController();
  final _humidityCtrl = TextEditingController();

  /// Tant qu'on n'a pas appuyé sur « Voir les conseils », on est en
  /// mode saisie. Sinon on bascule sur la liste des [HydroAdvice].
  List<HydroAdvice>? _advices;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Pré-remplit les champs avec les dernières valeurs connues, pour
    // que l'utilisateur n'ait qu'à modifier ce qui a changé.
    final svc = CultureReadingService.instance;
    final id = widget.culture.id;
    _phCtrl.text = _initial(svc.latest(id, ReadingType.ph));
    _ecCtrl.text = _initial(svc.latest(id, ReadingType.ec));
    _waterTempCtrl.text = _initial(svc.latest(id, ReadingType.waterTemp));
    _humidityCtrl.text = _initial(svc.latest(id, ReadingType.airHumidity));
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

  Vegetable _veg() {
    return vegetablesBase.firstWhere(
      (v) => v.id == widget.culture.vegetableId,
      orElse: () => vegetablesBase.first,
    );
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

    // Persiste chaque mesure non vide pour alimenter les sparklines /
    // l'historique. Si le champ est vide on ne crée pas d'entrée.
    final svc = CultureReadingService.instance;
    final cid = widget.culture.id;
    final tasks = <Future<void>>[];
    if (ph != null) {
      tasks.add(svc.add(cultureId: cid, type: ReadingType.ph, unit: 'pH', value: ph));
    }
    if (ec != null) {
      tasks.add(svc.add(cultureId: cid, type: ReadingType.ec, unit: 'mS/cm', value: ec));
    }
    if (waterTemp != null) {
      tasks.add(svc.add(
        cultureId: cid,
        type: ReadingType.waterTemp,
        unit: '°C',
        value: waterTemp,
      ));
    }
    if (humidity != null) {
      tasks.add(svc.add(
        cultureId: cid,
        type: ReadingType.airHumidity,
        unit: '%',
        value: humidity,
      ));
    }
    await Future.wait(tasks);

    final advices = generateHydroAdvice(
      veg: _veg(),
      phase: widget.culture.phase,
      ph: ph,
      ec: ec,
      waterTempC: waterTemp,
      airHumidityPct: humidity,
    );

    if (!mounted) return;
    AudioService.instance.play(Sfx.cart);
    setState(() {
      _advices = advices;
      _saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final veg = _veg();
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
                  _advices == null
                      ? 'Mes mesures du jour'
                      : 'Conseils pour ta ${veg.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${veg.emoji}  ${widget.culture.phase.label}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 18),
                if (_advices == null) _buildInputs() else _buildResults(),
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
    final advices = _advices!;
    if (advices.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
            const Text('🤔', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              'Aucune mesure saisie. Reviens en arrière et remplis '
              'au moins un champ.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: KultivaColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () => setState(() => _advices = null),
              child: const Text('Retour à la saisie'),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final a in advices) ...<Widget>[
          _AdviceCard(advice: a),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _advices = null),
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
