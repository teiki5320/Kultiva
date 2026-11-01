import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/names_en.dart';
import '../../../models/culture_entry.dart';
import '../../../models/plant_advice.dart';
import '../../../models/plantation.dart';
import '../../../models/stage_hypothesis.dart';
import '../../../models/vegetable.dart';
import '../../../services/advice_service.dart';
import '../../../services/plant_vision_service.dart';
import '../../../services/plantation_service.dart';
import '../../../services/stage_vision.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';

/// La fiche conseil d'un plant, ouverte après une photo.
///
/// Elle répond à la question qu'on se pose en photographiant son
/// plant : « où il en est, et qu'est-ce que je fais maintenant ? »
///
/// Le stade part de la date de plantation, et la photo peut le
/// corriger : un étiqueteur embarqué ([PlantVisionService]) y cherche
/// une fleur, un fruit, du feuillage, et [StageVision] croise ce qu'il
/// a vu avec ce que la date annonçait.
///
/// ⚠️ **La lecture ne décide jamais à la place de l'utilisateur.** Elle
/// propose, avec un bouton pour accepter ; le stade retenu ne change
/// que si quelqu'un le touche. Le modèle est générique, il ne sait pas
/// reconnaître une espèce ni une maladie, et un conseil de culture
/// donné à tort est pire qu'un conseil absent.
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

  /// Ce que l'étiqueteur a lu sur la photo. Lu **une seule fois** : le
  /// fichier ne change pas, et l'appel natif n'est pas gratuit.
  StageHypothesis? _vu;
  bool _lectureEnCours = false;

  /// Le croisement photo ⇄ date, recalculé à chaque reconstruction.
  ///
  /// C'est une fonction pure et bon marché, donc on la rejoue plutôt
  /// que de la stocker : après une correction, la phrase doit suivre le
  /// nouveau stade au lieu de parler de l'ancien.
  VisionReading? get _lecture {
    final vu = _vu;
    final a = _advice;
    if (vu == null || a == null) return null;
    return StageVision.reconcile(hypothesis: vu, attendu: a.phase);
  }

  @override
  void initState() {
    super.initState();
    _build();
    _lirePhoto();
  }

  /// Lit la photo en arrière-plan.
  ///
  /// La fiche s'affiche sans attendre : une lecture qui échoue ou qui
  /// traîne ne doit jamais retenir les conseils, qui sont utiles sans
  /// elle.
  Future<void> _lirePhoto() async {
    final path = widget.photoPath;
    if (path == null) return;
    setState(() => _lectureEnCours = true);
    final vu = await PlantVisionService.instance.read(path);
    if (!mounted) return;
    setState(() {
      _vu = vu;
      _lectureEnCours = false;
    });
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
                  if (widget.photoPath != null) ...<Widget>[
                    const SizedBox(height: 16),
                    _LecturePhoto(
                      lecture: _lecture,
                      enCours: _lectureEnCours,
                      onAccepter: _corriger,
                    ),
                  ],
                  const SizedBox(height: 18),
                  _ChoixDuStade(
                    courant: a.phase,
                    observe: a.phaseObserved,
                    photoLue: _vu != null,
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

  /// Vrai quand l'étiqueteur a rendu une lecture de la photo : le
  /// sous-titre ne doit alors plus dire que l'app ne la lit pas.
  final bool photoLue;
  final ValueChanged<GrowthPhase> onChanged;

  const _ChoixDuStade({
    required this.courant,
    required this.observe,
    required this.onChanged,
    this.photoLue = false,
  });

  String get _sousTitre {
    if (observe) {
      return 'C\'est toi qui l\'as indiqué. Touche un autre stade pour '
          'corriger.';
    }
    if (photoLue) {
      return 'Estimé d\'après la date de plantation. La photo ne sert '
          'qu\'à proposer — c\'est toi qui tranches.';
    }
    return 'Estimé d\'après la date de plantation. Corrige si ce n\'est '
        'pas ça.';
  }

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
          _sousTitre,
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

/// Ce que l'étiqueteur a lu sur la photo, et le bouton pour l'accepter.
///
/// Trois comportements, selon ce que la lecture vaut :
///
/// - **accord** : une ligne discrète, sans bouton. Il n'y a rien à
///   décider, le dire suffit.
/// - **suggestion / désaccord** : la phrase et un bouton. Le stade ne
///   bouge que si l'utilisateur appuie.
/// - **rien vu / indécis** : la phrase, en gris, sans bouton. Un modèle
///   qui hésite doit se taire, pas deviner.
class _LecturePhoto extends StatelessWidget {
  final VisionReading? lecture;
  final bool enCours;
  final ValueChanged<GrowthPhase> onAccepter;

  const _LecturePhoto({
    required this.lecture,
    required this.enCours,
    required this.onAccepter,
  });

  @override
  Widget build(BuildContext context) {
    if (enCours) {
      return const Row(
        children: <Widget>[
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 9),
          Text(
            'Je regarde ta photo…',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: KultivaColors.textSecondary,
            ),
          ),
        ],
      );
    }

    final r = lecture;
    if (r == null) return const SizedBox.shrink();

    final muet = r.verdict == VisionVerdict.pasDePlante ||
        r.verdict == VisionVerdict.indecis;
    if (muet) {
      return Text(
        r.phrase,
        style: const TextStyle(
          fontSize: 12,
          height: 1.35,
          color: KultivaColors.textSecondary,
        ),
      );
    }

    final alerte = r.verdict == VisionVerdict.desaccord;
    final sombre = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: alerte
            ? KultivaColors.terracotta.withValues(alpha: 0.12)
            : (sombre
                ? KultivaColors.darkCard
                : KultivaColors.lightGreen.withValues(alpha: 0.22)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: alerte
              ? KultivaColors.terracotta.withValues(alpha: 0.5)
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(alerte ? '🤔' : '👀', style: const TextStyle(fontSize: 17)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  r.phrase,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: alerte ? KultivaColors.terracotta : null,
                  ),
                ),
              ),
            ],
          ),
          if (r.actionnable) ...<Widget>[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => onAccepter(r.suggere!),
                style: TextButton.styleFrom(
                  foregroundColor: KultivaColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Oui, c\'est « ${r.suggere!.label.toLowerCase()} »',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
