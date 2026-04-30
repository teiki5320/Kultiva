import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/culture_entry.dart';
import '../../models/garden_plan.dart';
import '../../services/audio_service.dart';
import '../../services/hydro_install_service.dart';
import '../../theme/app_theme.dart';

/// Sheet de création d'une nouvelle installation hydroponique. Tout
/// dans un seul scroll : système → nom → slots → réservoir → lampe →
/// bouton « Créer ». Pas de wizard multi-étapes pour rester simple.
class CreateHydroInstallSheet extends StatefulWidget {
  const CreateHydroInstallSheet({super.key});

  @override
  State<CreateHydroInstallSheet> createState() =>
      _CreateHydroInstallSheetState();
}

class _CreateHydroInstallSheetState extends State<CreateHydroInstallSheet> {
  HydroSystemType _systemType = HydroSystemType.dwc;
  final _nameCtrl = TextEditingController();
  int _slotCount = 4;
  double _reservoirL = 20;

  /// Espacement physique entre trous (cm). Valeurs par défaut sourcées
  /// audit web 2026 : DWC 25 cm pour laitues amateur, NFT 25 cm
  /// laitues / 50 cm tomates, Tour 30 cm, Kratky n/a (1 plant).
  int _holeSpacingCm = 25;

  // Lumière (commune à toute l'install). On ne stocke plus la durée
  // par défaut : elle est calculée dynamiquement dans le détail de
  // l'install selon la phase dominante des plants. À la création on
  // utilise une valeur par défaut neutre (16 h, qui couvre semis +
  // croissance).
  LightType _lightType = LightType.led;
  static const double _defaultHoursPerDay = 16;
  int _ledWatts = 100;
  int _lampCount = 1;
  LedColorTemp _ledColorTemp = LedColorTemp.fullSpectrum;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl.text = _defaultName(_systemType);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  String _defaultName(HydroSystemType t) {
    switch (t) {
      case HydroSystemType.dwc:
        return 'Mon DWC';
      case HydroSystemType.kratky:
        return 'Mon Kratky';
      case HydroSystemType.nft:
        return 'Mon NFT';
      case HydroSystemType.tower:
        return 'Ma tour verticale';
    }
  }

  void _onSystemChanged(HydroSystemType t) {
    setState(() {
      _systemType = t;
      // Si l'utilisateur n'a pas customisé le nom, on l'aligne sur le
      // nouveau système.
      final defaults = HydroSystemType.values.map(_defaultName).toSet();
      if (defaults.contains(_nameCtrl.text.trim())) {
        _nameCtrl.text = _defaultName(t);
      }
      // Aligne aussi le nb de slots sur le défaut du système.
      final layout = t.defaultLayout;
      _slotCount = (layout.cols * layout.rows).clamp(1, 12);
    });
  }

  Future<void> _create() async {
    final name = _nameCtrl.text.trim().isEmpty
        ? _defaultName(_systemType)
        : _nameCtrl.text.trim();
    setState(() => _saving = true);
    // Crée _lampCount lampes identiques (puissance × type × couleur).
    // L'utilisateur pourra les positionner individuellement dans le
    // détail de l'install (heatmap PPFD).
    final lamps = <HydroLightConfig>[
      for (var i = 0; i < _lampCount; i++)
        _lightType == LightType.natural
            ? const HydroLightConfig(
                type: LightType.natural,
                hoursPerDay: _defaultHoursPerDay,
              )
            : HydroLightConfig(
                type: _lightType,
                hoursPerDay: _defaultHoursPerDay,
                ledWatts: _ledWatts,
                ledColorTemp: _ledColorTemp,
              ),
    ];
    await HydroInstallService.instance.create(
      name: name,
      systemType: _systemType,
      slotCount: _slotCount,
      reservoirL: _reservoirL,
      holeSpacingCm: _holeSpacingCm.toDouble(),
      lamps: lamps,
    );
    if (!mounted) return;
    AudioService.instance.play(Sfx.success);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.98,
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
                const Text(
                  'Créer une nouvelle installation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 22),

                // ─── Système ─────────────────────────────────────────
                _SectionTitle('Quel système ?'),
                const SizedBox(height: 8),
                _SystemPicker(
                  selected: _systemType,
                  onChanged: _onSystemChanged,
                ),
                const SizedBox(height: 22),

                // ─── Nom ─────────────────────────────────────────────
                _SectionTitle('Nom de ton install'),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ex. Mon DWC tomates',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: KultivaColors.lightGreen
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: KultivaColors.lightGreen
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                // ─── Slots ───────────────────────────────────────────
                _SectionTitle('Combien de plants peut-elle accueillir ?'),
                const SizedBox(height: 4),
                Text(
                  'Le nombre d\'emplacements (trous, paniers…) prévus '
                  'physiquement dans ton bac.',
                  style: TextStyle(
                    fontSize: 11,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                _NumberStepper(
                  value: _slotCount,
                  min: 1,
                  // Pas de cap arbitraire — un NFT semi-pro peut avoir
                  // 36+ plants (4 gouttières × 9 trous). Cap haut juste
                  // pour la safety du widget de saisie.
                  max: 200,
                  step: _slotCount < 12 ? 1 : 2,
                  unit: 'plants',
                  onChanged: (v) => setState(() => _slotCount = v),
                ),
                const SizedBox(height: 12),

                // ─── Espacement entre trous ──────────────────────────
                _NumberStepper(
                  value: _holeSpacingCm,
                  min: 5,
                  max: 100,
                  step: 5,
                  unit: 'cm',
                  label: 'Espacement entre 2 trous voisins',
                  onChanged: (v) => setState(() => _holeSpacingCm = v),
                ),
                const SizedBox(height: 4),
                Text(
                  'Distance physique entre 2 emplacements adjacents. '
                  'L\'app s\'en sert pour vérifier que tu ne plantes pas '
                  'trop serré (ex. tomate = 25-40 cm, laitue = 18-30 cm).',
                  style: TextStyle(
                    fontSize: 11,
                    color: KultivaColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 22),

                // ─── Réservoir ───────────────────────────────────────
                _SectionTitle('Volume du réservoir'),
                const SizedBox(height: 4),
                Text(
                  'Capacité totale de ton bac d\'eau, en litres.',
                  style: TextStyle(
                    fontSize: 11,
                    color: KultivaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                _NumberStepper(
                  value: _reservoirL.toInt(),
                  min: 5,
                  max: 200,
                  step: 5,
                  unit: 'L',
                  onChanged: (v) =>
                      setState(() => _reservoirL = v.toDouble()),
                ),
                const SizedBox(height: 22),

                // ─── Lumière ─────────────────────────────────────────
                _SectionTitle('Lumière'),
                const SizedBox(height: 8),
                _LightTypePicker(
                  selected: _lightType,
                  onChanged: (t) => setState(() => _lightType = t),
                ),
                if (_lightType != LightType.natural) ...<Widget>[
                  const SizedBox(height: 12),
                  _NumberStepper(
                    value: _lampCount,
                    min: 1,
                    max: 12,
                    step: 1,
                    unit: 'lampe(s)',
                    label: 'Combien de lampes ?',
                    onChanged: (v) => setState(() => _lampCount = v),
                  ),
                  const SizedBox(height: 12),
                  _NumberStepper(
                    value: _ledWatts,
                    min: 20,
                    max: 600,
                    step: 10,
                    unit: 'W',
                    label: _lampCount == 1
                        ? 'Puissance de la lampe (chiffre marqué dessus)'
                        : 'Puissance de chaque lampe (chiffre marqué dessus)',
                    onChanged: (v) => setState(() => _ledWatts = v),
                  ),
                  const SizedBox(height: 12),
                  _LedColorPicker(
                    selected: _ledColorTemp,
                    onChanged: (c) => setState(() => _ledColorTemp = c),
                  ),
                  const SizedBox(height: 14),
                  _LightCalcInfo(),
                ],

                const SizedBox(height: 28),

                // ─── Bouton créer ────────────────────────────────────
                FilledButton.icon(
                  onPressed: _saving ? null : _create,
                  icon: _saving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check),
                  label: Text(
                    _saving ? 'Création...' : 'Créer mon installation',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: KultivaColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
    );
  }
}

class _SystemPicker extends StatelessWidget {
  final HydroSystemType selected;
  final ValueChanged<HydroSystemType> onChanged;

  const _SystemPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final t in HydroSystemType.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: InkWell(
              onTap: () {
                AudioService.instance.play(Sfx.tap);
                onChanged(t);
              },
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: t == selected
                      ? KultivaColors.primaryGreen.withValues(alpha: 0.12)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: t == selected
                        ? KultivaColors.primaryGreen
                        : KultivaColors.lightGreen.withValues(alpha: 0.5),
                    width: t == selected ? 2 : 1.4,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A9BBF).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('💧',
                          style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            t.fullLabel,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.description,
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.35,
                              color: KultivaColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (t == selected)
                      const Icon(
                        Icons.check_circle,
                        color: KultivaColors.primaryGreen,
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _LightTypePicker extends StatelessWidget {
  final LightType selected;
  final ValueChanged<LightType> onChanged;

  const _LightTypePicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (final t in LightType.values) ...<Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                AudioService.instance.play(Sfx.tap);
                onChanged(t);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: t == selected
                      ? KultivaColors.primaryGreen.withValues(alpha: 0.18)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: t == selected
                        ? KultivaColors.primaryGreen
                        : KultivaColors.lightGreen.withValues(alpha: 0.5),
                    width: t == selected ? 2 : 1.4,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(t.emoji, style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(
                      _shortLabel(t),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: t == selected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: KultivaColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _shortLabel(LightType t) {
    switch (t) {
      case LightType.natural:
        return 'Naturelle';
      case LightType.led:
        return 'LED';
      case LightType.mixed:
        return 'Mixte';
    }
  }
}

class _LedColorPicker extends StatelessWidget {
  final LedColorTemp selected;
  final ValueChanged<LedColorTemp> onChanged;

  const _LedColorPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Couleur de la lampe',
          style: TextStyle(
            fontSize: 11,
            color: KultivaColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            for (final c in LedColorTemp.values)
              GestureDetector(
                onTap: () {
                  AudioService.instance.play(Sfx.tap);
                  onChanged(c);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: c == selected
                        ? KultivaColors.primaryGreen.withValues(alpha: 0.16)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: c == selected
                          ? KultivaColors.primaryGreen
                          : KultivaColors.lightGreen.withValues(alpha: 0.5),
                      width: c == selected ? 1.8 : 1.2,
                    ),
                  ),
                  child: Text(
                    c.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: c == selected
                          ? FontWeight.w800
                          : FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _NumberStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final int step;
  final String unit;
  final String? label;
  final ValueChanged<int> onChanged;

  const _NumberStepper({
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.unit,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: TextStyle(
              fontSize: 11,
              color: KultivaColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: KultivaColors.lightGreen.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: value > min
                    ? () {
                        HapticFeedback.selectionClick();
                        onChanged((value - step).clamp(min, max));
                      }
                    : null,
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$value $unit',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: value < max
                    ? () {
                        HapticFeedback.selectionClick();
                        onChanged((value + step).clamp(min, max));
                      }
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Petit encart explicatif sous la config lampe : on dit à
/// l'utilisateur qu'on calcule la durée et la hauteur pour lui une
/// fois que des plants seront ajoutés. Évite de demander des paramètres
/// que l'utilisateur ne connaît pas.
class _LightCalcInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D0).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8C96A).withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('💡', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'On calcule pour toi la hauteur de la lampe et le nombre '
              'd\'heures à allumer par jour, en fonction de la phase '
              'de tes plants. Pas besoin de chercher.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                fontWeight: FontWeight.w700,
                color: KultivaColors.textPrimary.withValues(alpha: 0.85),
              ),
            ),
          ),
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
