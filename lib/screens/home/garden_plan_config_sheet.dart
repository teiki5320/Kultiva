import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/garden_plan.dart';
import '../../services/garden_plan_service.dart';
import '../../theme/app_theme.dart';

/// Bottom sheet de configuration d'un jardin (création ou édition).
///
/// Contient trois sections : Lieu, Nom, Taille (cols × rows en cm ou pieds).
/// Inspiré de l'app référence — voir captures d'écran utilisateur.
class GardenPlanConfigSheet extends StatefulWidget {
  /// Plan existant à éditer, ou `null` pour créer un nouveau jardin.
  final GardenPlan? existing;

  const GardenPlanConfigSheet({super.key, this.existing});

  @override
  State<GardenPlanConfigSheet> createState() => _GardenPlanConfigSheetState();
}

class _GardenPlanConfigSheetState extends State<GardenPlanConfigSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _locationCtrl;
  late GardenUnit _unit;
  late int _widthCm;
  late int _heightCm;

  // Tailles disponibles en cm (multiples de 30 = 1 case = 1 pied carré).
  static const List<int> _sizesCm = <int>[60, 90, 120, 150, 180, 210, 240];

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _nameCtrl = TextEditingController(text: ex?.name ?? 'Jardin 1');
    _locationCtrl = TextEditingController(text: ex?.location ?? '');
    _unit = ex?.unit ?? GardenUnit.cm;
    _widthCm = ex != null ? (ex.cols * 30) : 120;
    _heightCm = ex != null ? (ex.rows * 30) : 120;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            // En-tête.
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Configuration du jardin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 22),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Section Lieu.
            _SectionCard(
              title: 'Lieu',
              icon: Icons.place,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _locationCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Ville, code postal, région…',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pour connaître ton climat et les dates de gel.',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Section Nom.
            _SectionCard(
              title: 'Nom',
              icon: Icons.fence,
              child: TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Section Taille.
            _SectionCard(
              title: 'Taille',
              icon: Icons.grid_view,
              child: Column(
                children: <Widget>[
                  // Toggle cm / pieds.
                  Center(
                    child: SegmentedButton<GardenUnit>(
                      segments: const <ButtonSegment<GardenUnit>>[
                        ButtonSegment<GardenUnit>(
                          value: GardenUnit.cm,
                          label: Text('cm'),
                        ),
                        ButtonSegment<GardenUnit>(
                          value: GardenUnit.ft,
                          label: Text('pieds'),
                        ),
                      ],
                      selected: <GardenUnit>{_unit},
                      onSelectionChanged: (Set<GardenUnit> set) {
                        setState(() => _unit = set.first);
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Pickers largeur × hauteur.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _SizePicker(
                        label: 'Largeur',
                        valueCm: _widthCm,
                        unit: _unit,
                        onChanged: (cm) => setState(() => _widthCm = cm),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '×',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _SizePicker(
                        label: 'Profondeur',
                        valueCm: _heightCm,
                        unit: _unit,
                        onChanged: (cm) => setState(() => _heightCm = cm),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_widthCm ~/ 30} × ${_heightCm ~/ 30} cases (1 case = 30×30 cm)',
                    style: TextStyle(
                      fontSize: 11,
                      color: KultivaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Bouton Terminé.
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: KultivaColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _save,
                child: const Text(
                  'Terminé',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim().isEmpty
        ? 'Jardin'
        : _nameCtrl.text.trim();
    final location = _locationCtrl.text.trim().isEmpty
        ? null
        : _locationCtrl.text.trim();
    final cols = _widthCm ~/ 30;
    final rows = _heightCm ~/ 30;

    if (widget.existing == null) {
      final plan = await GardenPlanService.instance.create(
        name: name,
        location: location,
        cols: cols,
        rows: rows,
        unit: _unit,
      );
      if (mounted) Navigator.of(context).pop(plan);
    } else {
      final updated = widget.existing!.copyWith(
        name: name,
        location: location,
        cols: cols,
        rows: rows,
        unit: _unit,
      );
      await GardenPlanService.instance.save(updated);
      if (mounted) Navigator.of(context).pop(updated);
    }
  }
}

/// Carte de section avec titre + icône verte.
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: KultivaColors.lightGreen.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: KultivaColors.primaryGreen),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// Picker de taille en cm avec conversion d'affichage cm <-> pieds.
class _SizePicker extends StatelessWidget {
  final String label;
  final int valueCm;
  final GardenUnit unit;
  final ValueChanged<int> onChanged;

  const _SizePicker({
    required this.label,
    required this.valueCm,
    required this.unit,
    required this.onChanged,
  });

  static const List<int> _sizesCm = <int>[60, 90, 120, 150, 180, 210, 240];

  String _displayValue(int cm) {
    if (unit == GardenUnit.cm) return '$cm';
    final ft = (cm / 30.48).round();
    return '$ft';
  }

  @override
  Widget build(BuildContext context) {
    final initialIndex = _sizesCm.indexOf(valueCm).clamp(0, _sizesCm.length - 1);
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: KultivaColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 100,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: KultivaColors.primaryGreen.withValues(alpha: 0.25),
            ),
          ),
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: initialIndex,
            ),
            itemExtent: 30,
            magnification: 1.15,
            squeeze: 1.1,
            onSelectedItemChanged: (i) => onChanged(_sizesCm[i]),
            children: _sizesCm
                .map((cm) => Center(
                      child: Text(
                        _displayValue(cm),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
