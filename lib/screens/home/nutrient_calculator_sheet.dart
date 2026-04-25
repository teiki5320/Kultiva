import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/culture_entry.dart';
import '../../theme/app_theme.dart';
import '../../utils/nutrient_calculator.dart';

/// Bottom sheet calcul de doses nutritives.
/// L'utilisateur saisit le volume du réservoir, on déduit les doses A/B/C
/// + Cal-Mag selon la phase de croissance de la culture.
class NutrientCalculatorSheet extends StatefulWidget {
  final CultureEntry culture;
  const NutrientCalculatorSheet({super.key, required this.culture});

  @override
  State<NutrientCalculatorSheet> createState() =>
      _NutrientCalculatorSheetState();
}

class _NutrientCalculatorSheetState extends State<NutrientCalculatorSheet> {
  final TextEditingController _volCtrl =
      TextEditingController(text: '20');
  bool _useThirdPart = true;
  bool _useCalMag = true;

  double get _volume {
    final raw = _volCtrl.text.trim().replaceAll(',', '.');
    return double.tryParse(raw) ?? 0.0;
  }

  @override
  void dispose() {
    _volCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phase = widget.culture.phase;
    final dose = computeNutrientDose(
      volumeLiters: _volume,
      phase: phase,
      useThirdPart: _useThirdPart,
      useCalMag: _useCalMag,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('🧪', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Calculateur nutriments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Phase actuelle : ${phase.emoji} ${phase.label}',
              style: TextStyle(
                fontSize: 12,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _volCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Volume du réservoir (L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Engrais 3 parts (A + B + C)'),
              subtitle: const Text(
                'Désactive si tu utilises un 2 parts (A + B uniquement).',
                style: TextStyle(fontSize: 11),
              ),
              value: _useThirdPart,
              onChanged: (v) => setState(() => _useThirdPart = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Ajouter Cal-Mag'),
              subtitle: const Text(
                'Recommandé en eau osmosée ou très douce.',
                style: TextStyle(fontSize: 11),
              ),
              value: _useCalMag,
              onChanged: (v) => setState(() => _useCalMag = v),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 4),
            const Text(
              'Doses estimées',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            _DoseRow(label: 'Partie A', mL: dose.partAmL),
            _DoseRow(label: 'Partie B', mL: dose.partBmL),
            if (_useThirdPart)
              _DoseRow(label: 'Partie C (Bloom)', mL: dose.partCmL),
            if (_useCalMag) _DoseRow(label: 'Cal-Mag', mL: dose.calMagmL),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: KultivaColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                dose.regimeNote,
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "ⓘ  Estimations indicatives basées sur des engrais 1–4 mL/L. "
              "Suis toujours la notice du fabricant et vérifie l'EC après "
              "préparation.",
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  final String label;
  final double mL;
  const _DoseRow({required this.label, required this.mL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Text(
            '${mL.toStringAsFixed(1)} mL',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
