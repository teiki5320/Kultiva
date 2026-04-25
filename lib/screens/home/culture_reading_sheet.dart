import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/culture_reading.dart';
import '../../services/culture_reading_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/reading_targets.dart';

/// Bottom sheet pour saisir une nouvelle mesure attachée à une culture.
/// Affiche la zone cible si disponible (couleur verte/orange/rouge en
/// temps réel pendant la saisie).
class CultureReadingSheet extends StatefulWidget {
  final String cultureId;
  final ReadingType type;

  const CultureReadingSheet({
    super.key,
    required this.cultureId,
    required this.type,
  });

  @override
  State<CultureReadingSheet> createState() => _CultureReadingSheetState();
}

class _CultureReadingSheetState extends State<CultureReadingSheet> {
  final TextEditingController _valueCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _valueCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  ReadingTarget? get _target => defaultHydroTarget(widget.type);

  double? get _parsedValue {
    final raw = _valueCtrl.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) return null;
    return double.tryParse(raw);
  }

  Color _statusColor(ReadingStatus s) {
    switch (s) {
      case ReadingStatus.ok:
        return KultivaColors.primaryGreen;
      case ReadingStatus.warn:
        return const Color(0xFFE8A87C);
      case ReadingStatus.bad:
        return const Color(0xFFD4564A);
      case ReadingStatus.unknown:
        return KultivaColors.textSecondary;
    }
  }

  String _statusLabel(ReadingStatus s) {
    switch (s) {
      case ReadingStatus.ok:
        return 'Dans la zone idéale';
      case ReadingStatus.warn:
        return 'Légèrement hors cible';
      case ReadingStatus.bad:
        return 'Critique';
      case ReadingStatus.unknown:
        return '';
    }
  }

  Future<void> _save() async {
    final v = _parsedValue;
    if (widget.type != ReadingType.observation && v == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saisis une valeur valide.')),
      );
      return;
    }
    setState(() => _saving = true);
    final note = _noteCtrl.text.trim();
    await CultureReadingService.instance.add(
      cultureId: widget.cultureId,
      type: widget.type,
      unit: widget.type.defaultUnit,
      value: v,
      note: note.isEmpty ? null : note,
    );
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.type;
    final tgt = _target;
    final status = tgt?.statusFor(_parsedValue) ?? ReadingStatus.unknown;
    final isObservation = t == ReadingType.observation;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(t.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Nouvelle mesure : ${t.label}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          if (tgt != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              'Zone idéale : ${tgt.rangeLabel} ${tgt.unit}',
              style: TextStyle(
                fontSize: 12,
                color: KultivaColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 14),
          if (!isObservation)
            TextField(
              controller: _valueCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Valeur (${t.defaultUnit})',
                border: const OutlineInputBorder(),
                suffixIcon: status == ReadingStatus.unknown
                    ? null
                    : Icon(
                        status == ReadingStatus.ok
                            ? Icons.check_circle
                            : Icons.warning_amber_rounded,
                        color: _statusColor(status),
                      ),
              ),
            ),
          if (!isObservation && status != ReadingStatus.unknown) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              _statusLabel(status),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _statusColor(status),
              ),
            ),
          ],
          const SizedBox(height: 12),
          TextField(
            controller: _noteCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Note (facultative)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: _saving
                      ? null
                      : () => Navigator.of(context).pop(false),
                  child: const Text('Annuler'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? '...' : 'Enregistrer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
