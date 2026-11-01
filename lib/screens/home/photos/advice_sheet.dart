import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/names_en.dart';
import '../../../models/culture_entry.dart';
import '../../../models/plant_advice.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../services/advice_service.dart';
import '../../../services/plantation_service.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';

/// La fiche conseil d'un plant, ouverte après une photo.
///
/// Elle répond à la question qu'on se pose en photographiant son
/// plant : « où il en est, et qu'est-ce que je fais maintenant ? »
///
/// ⚠️ **L'app ne lit pas encore la photo.** Le stade est déduit de la
/// date de plantation, et l'utilisateur peut le corriger d'un geste.
/// La fiche le dit noir sur blanc plutôt que de laisser croire à une
/// reconnaissance qui n'existe pas — et chaque correction construit le
/// jeu d'exemples dont un futur modèle aura besoin.
Future<void> showAdviceSheet(
  BuildContext context, {
  required Plantation plantation,
  required Vegetable vegetable,
  String? photoPath,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AdviceSheet(
      plantationId: plantation.id,
      vegetable: vegetable,
      photoPath: photoPath,
    ),
  );
}

class AdviceSheet extends StatefulWidget {
  final String plantationId;
  final Vegetable vegetable;
  final String? photoPath;

  const AdviceSheet({
    super.key,
    required this.plantationId,
    required this.vegetable,
    this.photoPath,
  });

  @override
  State<AdviceSheet> createState() => _AdviceSheetState();
}

class _AdviceSheetState extends State<AdviceSheet> {
  PlantAdvice? _advice;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _build();
  }

  Future<void> _build() async {
    final p = PlantationService.instance.byId(widget.plantationId);
    if (p == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    // La météo est un bonus : hors ligne, la fiche se construit sans
    // sa section arrosage plutôt que de faire attendre.
    var advice = AdviceService.build(plantation: p, vegetable: widget.vegetable);
    if (mounted) setState(() => _advice = advice);
    try {
      final meteo = await WeatherService.getWeather();
      advice = AdviceService.build(
        plantation: p,
        vegetable: widget.vegetable,
        weather: meteo,
      );
    } catch (_) {
      // Tant pis pour l'arrosage du jour.
    }
    if (!mounted) return;
    setState(() {
      _advice = advice;
      _loading = false;
    });
  }

  Future<void> _corriger(GrowthPhase phase) async {
    await PlantationService.instance
        .setObservedPhase(widget.plantationId, phase);
    await _build();
  }

  @override
  Widget build(BuildContext context) {
    final sombre = Theme.of(context).brightness == Brightness.dark;
    final a = _advice;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: sombre ? KultivaColors.darkBackground : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: a == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: KultivaColors.lightGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  _Entete(
                    vegetable: widget.vegetable,
                    advice: a,
                    photoPath: widget.photoPath,
                  ),
                  const SizedBox(height: 18),
                  _ChoixDuStade(
                    courant: a.phase,
                    observe: a.phaseObserved,
                    onChanged: _corriger,
                  ),
                  const SizedBox(height: 18),
                  for (final s in a.sections) ...<Widget>[
                    _Section(section: s),
                    const SizedBox(height: 10),
                  ],
                  if (_loading)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'Lecture de la météo…',
                        style: TextStyle(
                          fontSize: 12,
                          color: KultivaColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class _Entete extends StatelessWidget {
  final Vegetable vegetable;
  final PlantAdvice advice;
  final String? photoPath;

  const _Entete({
    required this.vegetable,
    required this.advice,
    this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    final jours = advice.daysSincePlanted;
    return Row(
      children: <Widget>[
        if (photoPath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(photoPath!),
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              cacheWidth: 192,
              errorBuilder: (_, __, ___) =>
                  Text(vegetable.emoji, style: const TextStyle(fontSize: 40)),
            ),
          )
        else
          Text(vegetable.emoji, style: const TextStyle(fontSize: 40)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                vegetable.displayName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                jours <= 0
                    ? 'Planté aujourd\'hui'
                    : 'En terre depuis $jours jour${jours > 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Les quatre stades, celui retenu mis en avant.
///
/// C'est le cœur de la fiche : sans correction possible, l'app
/// affirmerait « floraison » à un plant qui n'a pas levé, et tous les
/// conseils en dessous seraient faux.
class _ChoixDuStade extends StatelessWidget {
  final GrowthPhase courant;
  final bool observe;
  final ValueChanged<GrowthPhase> onChanged;

  const _ChoixDuStade({
    required this.courant,
    required this.observe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Où en est ton plant ?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          observe
              ? 'C\'est toi qui l\'as indiqué. Touche un autre stade pour '
                  'corriger.'
              : 'Estimé d\'après la date de plantation — Kultiva ne lit '
                  'pas encore la photo. Corrige si ce n\'est pas ça.',
          style: const TextStyle(
            fontSize: 12,
            height: 1.35,
            color: KultivaColors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            for (final p in GrowthPhase.values)
              _StadeChip(
                phase: p,
                selected: p == courant,
                onTap: () => onChanged(p),
              ),
          ],
        ),
      ],
    );
  }
}

class _StadeChip extends StatelessWidget {
  final GrowthPhase phase;
  final bool selected;
  final VoidCallback onTap;

  const _StadeChip({
    required this.phase,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: phase.label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: selected
                ? KultivaColors.primaryGreen.withValues(alpha: 0.18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? KultivaColors.primaryGreen
                  : KultivaColors.lightGreen,
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Text(
            '${phase.emoji}  ${phase.label}',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? KultivaColors.primaryGreen : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final AdviceSection section;

  const _Section({required this.section});

  @override
  Widget build(BuildContext context) {
    final sombre = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
      decoration: BoxDecoration(
        color: section.urgent
            ? KultivaColors.terracotta.withValues(alpha: 0.12)
            : (sombre
                ? KultivaColors.darkCard
                : KultivaColors.lightGreen.withValues(alpha: 0.16)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: section.urgent
              ? KultivaColors.terracotta.withValues(alpha: 0.5)
              : Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(section.emoji, style: const TextStyle(fontSize: 17)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  section.title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: section.urgent ? KultivaColors.terracotta : null,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  section.body,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
