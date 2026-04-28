import 'package:flutter/material.dart';

import '../../models/garden_plan.dart';
import '../../services/garden_plan_service.dart';
import '../../theme/app_theme.dart';

/// Bottom sheet de création d'un plan hydroponique.
///
/// L'utilisateur :
/// 1. Choisit un type de système (DWC / Kratky / NFT / Tour)
/// 2. Donne un nom
/// 3. Le nombre de slots est déduit du système (mais ajustable plus tard)
///
/// Renvoie le plan créé via Navigator.pop.
class HydroSystemPickerSheet extends StatefulWidget {
  const HydroSystemPickerSheet({super.key});

  @override
  State<HydroSystemPickerSheet> createState() => _HydroSystemPickerSheetState();
}

class _HydroSystemPickerSheetState extends State<HydroSystemPickerSheet> {
  HydroSystemType _selected = HydroSystemType.dwc;
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: 'Hydro 1');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
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
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Nouveau plan hydroponique',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Choisis ton type de système',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ...HydroSystemType.values
                .map((t) => _SystemTile(
                      type: t,
                      selected: _selected == t,
                      onTap: () => setState(() => _selected = t),
                    )),
            const SizedBox(height: 14),
            const Text(
              'Nom de ton install',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 18),
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
                onPressed: _create,
                child: const Text(
                  'Créer',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _create() async {
    final layout = _selected.defaultLayout;
    final plan = await GardenPlanService.instance.create(
      name: _nameCtrl.text.trim().isEmpty
          ? _selected.label
          : _nameCtrl.text.trim(),
      cols: layout.cols,
      rows: layout.rows,
      hydroSystem: _selected,
    );
    if (mounted) Navigator.of(context).pop(plan);
  }
}

class _SystemTile extends StatelessWidget {
  final HydroSystemType type;
  final bool selected;
  final VoidCallback onTap;
  const _SystemTile({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final layout = type.defaultLayout;
    final slots = layout.cols * layout.rows;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected
                ? KultivaColors.primaryGreen.withValues(alpha: 0.12)
                : KultivaColors.lightGreen.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? KultivaColors.primaryGreen
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                _iconFor(type),
                color: KultivaColors.primaryGreen,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          type.fullLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: KultivaColors.primaryGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$slots slots',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type.description,
                      style: const TextStyle(fontSize: 11, height: 1.3),
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

  IconData _iconFor(HydroSystemType t) {
    switch (t) {
      case HydroSystemType.dwc:
        return Icons.water_drop;
      case HydroSystemType.kratky:
        return Icons.takeout_dining;
      case HydroSystemType.nft:
        return Icons.linear_scale;
      case HydroSystemType.tower:
        return Icons.view_column;
    }
  }
}
