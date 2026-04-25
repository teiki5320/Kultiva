import 'package:flutter/material.dart';

import '../../data/vegetables_base.dart';
import '../../models/culture_entry.dart';
import '../../models/vegetable.dart';
import '../../services/culture_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/rotation_advisor.dart';
import 'poussidex/vegetable_picker_sheet.dart';

/// Bottom sheet pour démarrer une nouvelle culture dans le cahier.
/// Si [method] == hydroponic, demande aussi la configuration lumière.
class CultureStartSheet extends StatefulWidget {
  final CultivationMethod method;

  const CultureStartSheet({super.key, required this.method});

  @override
  State<CultureStartSheet> createState() => _CultureStartSheetState();
}

class _CultureStartSheetState extends State<CultureStartSheet> {
  String? _vegetableId;
  DateTime _startedAt = DateTime.now();
  final TextEditingController _noteCtrl = TextEditingController();

  // Champs hydroponie
  LightType _lightType = LightType.natural;
  double _hoursPerDay = 12.0;
  final TextEditingController _ledDistanceCtrl = TextEditingController();
  final TextEditingController _ledWattsCtrl = TextEditingController();
  LedColorTemp _ledColorTemp = LedColorTemp.fullSpectrum;

  bool _saving = false;

  @override
  void dispose() {
    _noteCtrl.dispose();
    _ledDistanceCtrl.dispose();
    _ledWattsCtrl.dispose();
    super.dispose();
  }

  Vegetable? get _selectedVegetable {
    if (_vegetableId == null) return null;
    try {
      return vegetablesBase.firstWhere((v) => v.id == _vegetableId);
    } catch (_) {
      return null;
    }
  }

  bool get _isHydro => widget.method == CultivationMethod.hydroponic;
  bool get _needsLedDetails =>
      _isHydro &&
      (_lightType == LightType.led || _lightType == LightType.mixed);
  bool get _canSubmit => _vegetableId != null && !_saving;

  Future<void> _pickVegetable() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (_) => const VegetablePickerSheet(),
    );
    if (picked != null) {
      setState(() => _vegetableId = picked);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startedAt,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      helpText: 'Date de démarrage',
    );
    if (picked != null) {
      setState(() => _startedAt = picked);
    }
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _saving = true);

    HydroLightConfig? lightConfig;
    if (_isHydro) {
      lightConfig = HydroLightConfig(
        type: _lightType,
        hoursPerDay: _hoursPerDay,
        ledDistanceCm: _needsLedDetails
            ? double.tryParse(_ledDistanceCtrl.text.trim())
            : null,
        ledWatts: _needsLedDetails
            ? int.tryParse(_ledWattsCtrl.text.trim())
            : null,
        ledColorTemp: _needsLedDetails ? _ledColorTemp : null,
      );
    }

    await CultureService.instance.add(
      method: widget.method,
      vegetableId: _vegetableId!,
      startedAt: _startedAt,
      note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      light: lightConfig,
    );

    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: ListView(
            controller: scrollCtrl,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            children: <Widget>[
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: KultivaColors.textSecondary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.method.emoji}  Démarrer une culture',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(
                'Cahier ${widget.method.label.toLowerCase()}',
                style: TextStyle(
                  fontSize: 13,
                  color: KultivaColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // --- Légume ---
              _FieldLabel(text: 'Légume'),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickVegetable,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: KultivaColors.springA.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: KultivaColors.primaryGreen.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _selectedVegetable?.emoji ?? '🌱',
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedVegetable?.name ?? 'Choisir un légume',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _selectedVegetable == null
                                ? KultivaColors.textSecondary
                                : KultivaColors.textPrimary,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),

              if (widget.method == CultivationMethod.soil &&
                  _vegetableId != null) ...<Widget>[
                const SizedBox(height: 12),
                _RotationWarningBanner(vegetableId: _vegetableId!),
              ],

              const SizedBox(height: 16),

              // --- Date ---
              _FieldLabel(text: 'Date de démarrage'),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: KultivaColors.springA.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: KultivaColors.primaryGreen.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        _formatDate(_startedAt),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- Note ---
              _FieldLabel(text: 'Note (optionnelle)'),
              const SizedBox(height: 6),
              TextField(
                controller: _noteCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Variété, origine des graines, intention…',
                  filled: true,
                  fillColor: KultivaColors.springA.withOpacity(0.15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // --- Config hydroponie ---
              if (_isHydro) ...<Widget>[
                const SizedBox(height: 24),
                Divider(color: KultivaColors.textSecondary.withOpacity(0.2)),
                const SizedBox(height: 12),
                Text(
                  '💡  Configuration lumière',
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 12),

                _FieldLabel(text: 'Type de lumière'),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: LightType.values.map((type) {
                    final selected = type == _lightType;
                    return ChoiceChip(
                      label: Text('${type.emoji} ${type.label}'),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => _lightType = type);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                _FieldLabel(
                  text:
                      "Durée d'éclairage : ${_hoursPerDay.toStringAsFixed(0)} h/jour",
                ),
                Slider(
                  value: _hoursPerDay,
                  min: 0,
                  max: 24,
                  divisions: 24,
                  label: '${_hoursPerDay.toStringAsFixed(0)} h',
                  onChanged: (v) => setState(() => _hoursPerDay = v),
                ),

                if (_needsLedDetails) ...<Widget>[
                  const SizedBox(height: 8),
                  _FieldLabel(text: 'Détails LED (optionnel)'),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _ledDistanceCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Distance (cm)',
                            filled: true,
                            fillColor: KultivaColors.springA.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _ledWattsCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Watts',
                            filled: true,
                            fillColor: KultivaColors.springA.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _FieldLabel(text: 'Température de couleur'),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: LedColorTemp.values.map((temp) {
                      final selected = temp == _ledColorTemp;
                      return ChoiceChip(
                        label: Text(temp.label),
                        selected: selected,
                        onSelected: (_) {
                          setState(() => _ledColorTemp = temp);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ],

              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _canSubmit ? _submit : null,
                  icon: const Text('📔', style: TextStyle(fontSize: 22)),
                  label: Text(
                    _saving ? 'Enregistrement…' : 'Démarrer la culture',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KultivaColors.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    const months = <String>[
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: KultivaColors.textPrimary,
      ),
    );
  }
}

class _RotationWarningBanner extends StatelessWidget {
  final String vegetableId;
  const _RotationWarningBanner({required this.vegetableId});

  @override
  Widget build(BuildContext context) {
    final all = CultureService.instance.loadAll();
    final warning = checkRotation(
      vegetableId: vegetableId,
      previousCultures: all,
    );
    if (warning == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8A87C).withOpacity(0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8A87C)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('🔄', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Rotation : attention',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB36A3D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  warning.message,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
