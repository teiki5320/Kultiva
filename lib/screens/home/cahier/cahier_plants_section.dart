import '../../../data/names_en.dart';
import 'package:flutter/material.dart';

import '../../../data/ui_i18n.dart';
import '../../../data/vegetables_base.dart';
import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/phenology.dart';
import '../plants/plantation_sheet.dart';

/// Les plants en terre, rangés en trois colonnes : levée, croissance,
/// récolte.
///
/// Le cahier ne listait que des jardins. Pour voir un plant il fallait
/// ouvrir un jardin, viser sa case sur la grille et la tapoter — et
/// les plants ajoutés depuis une fiche légume (« Je l'ai planté »)
/// n'apparaissaient nulle part dans le cahier. La liste du 31/10/2026
/// rassemblait les deux.
///
/// Le 06/11/2026 (maquette « C4c », validée par Jean), la liste
/// devient un tableau en colonnes : chaque plant est un post-it rangé
/// sous son étape, et l'on voit d'un coup d'œil ce qui lève, ce qui
/// pousse et ce qui est bon à cueillir. Un post-it ouvre le même
/// dossier qu'avant (`showPlantationSheet`).
///
/// L'étape vient de `expectedStage`, donc de la date : germination et
/// plantule vont en « levée », croissance et floraison en
/// « croissance », la fenêtre de récolte et sa fin en « récolte ».
class CahierPlantsSection extends StatefulWidget {
  const CahierPlantsSection({super.key});

  @override
  State<CahierPlantsSection> createState() => _CahierPlantsSectionState();
}

/// Les trois colonnes du tableau.
enum _Colonne { levee, croissance, recolte }

_Colonne _colonneDe(PhenologyHint? etape) {
  if (etape == null) return _Colonne.croissance;
  if (etape.harvestReady) return _Colonne.recolte;
  switch (etape.emoji) {
    case '🌰':
    case '🌱':
      return _Colonne.levee;
    case '🍂':
      // Fin de la fenêtre de récolte : le plant est encore à cueillir,
      // pas à faire pousser.
      return _Colonne.recolte;
    default:
      return _Colonne.croissance;
  }
}

class _CahierPlantsSectionState extends State<CahierPlantsSection> {
  /// Au-delà, une colonne pousse le reste du cahier hors de l'écran.
  static const int _parColonne = 4;

  bool _tout = false;

  @override
  void initState() {
    super.initState();
    PlantationService.instance.addListener(_onChanged);
  }

  @override
  void dispose() {
    PlantationService.instance.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final actifs = PlantationService.instance.active;
    if (actifs.isEmpty) return const SizedBox.shrink();

    final colonnes = <_Colonne, List<(Plantation, Vegetable, PhenologyHint?)>>{
      for (final c in _Colonne.values) c: <(Plantation, Vegetable, PhenologyHint?)>[],
    };
    for (final p in actifs) {
      final veg =
          vegetablesBase.where((v) => v.id == p.vegetableId).firstOrNull;
      // Un plant dont l'espèce a disparu du catalogue : on ne montre
      // pas une tomate à sa place.
      if (veg == null) continue;
      final jours = DateTime.now().difference(p.plantedAt).inDays;
      final etape = expectedStage(veg, jours);
      colonnes[_colonneDe(etape)]!.add((p, veg, etape));
    }
    final cache = _tout
        ? 0
        : colonnes.values
            .map((l) => l.length > _parColonne ? l.length - _parColonne : 0)
            .fold<int>(0, (a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
          child: Text(
            trUiArgs('Mes plants, étape par étape  ·  {0}',
                <Object?>[actifs.length]),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final c in _Colonne.values) ...<Widget>[
                if (c != _Colonne.levee) const SizedBox(width: 8),
                Expanded(
                  child: _ColonneEtape(
                    colonne: c,
                    plants: _tout
                        ? colonnes[c]!
                        : colonnes[c]!.take(_parColonne).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (cache > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              onPressed: () => setState(() => _tout = true),
              style: TextButton.styleFrom(
                foregroundColor: KultivaColors.primaryGreen,
              ),
              child: Text(trUiArgs('Voir les {0} autres', <Object?>[cache])),
            ),
          ),
      ],
    );
  }
}

class _ColonneEtape extends StatelessWidget {
  final _Colonne colonne;
  final List<(Plantation, Vegetable, PhenologyHint?)> plants;

  const _ColonneEtape({required this.colonne, required this.plants});

  String get _titre {
    switch (colonne) {
      case _Colonne.levee:
        return trUi('Levée');
      case _Colonne.croissance:
        return trUi('Croissance');
      case _Colonne.recolte:
        return trUi('Récolte');
    }
  }

  @override
  Widget build(BuildContext context) {
    final recolte = colonne == _Colonne.recolte;
    final sombre = Theme.of(context).brightness == Brightness.dark;
    return Container(
      constraints: const BoxConstraints(minHeight: 160),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: recolte
            ? (sombre ? const Color(0xFF3A3420) : const Color(0xFFFDF6E3))
            : (sombre ? KultivaColors.darkSurface : const Color(0xFFF1F7F0)),
        borderRadius: BorderRadius.circular(16),
        border: recolte
            ? Border.all(color: const Color(0xFFF2DC8A), width: 2)
            : null,
      ),
      child: Column(
        children: <Widget>[
          Text(
            _titre.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
              color: sombre
                  ? Colors.white70
                  : (recolte
                      ? const Color(0xFF6B5200)
                      : const Color(0xFF557562)),
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < plants.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _PostItPlant(
                plantation: plants[i].$1,
                vegetable: plants[i].$2,
                etape: plants[i].$3,
                // Un léger désordre, comme des post-it posés à la main.
                angle: (i.isEven ? -1.5 : 2) * 3.14159 / 180,
                delai: i * 80,
              ),
            ),
        ],
      ),
    );
  }
}

class _PostItPlant extends StatelessWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final PhenologyHint? etape;
  final double angle;
  final int delai;

  const _PostItPlant({
    required this.plantation,
    required this.vegetable,
    required this.etape,
    required this.angle,
    required this.delai,
  });

  /// « il y a 3 jours », « aujourd'hui », « hier ».
  static String _ilYA(int jours) {
    if (jours <= 0) return trUi("aujourd'hui");
    if (jours == 1) return trUi('hier');
    return trUiArgs('il y a {0} j', <Object?>[jours]);
  }

  @override
  Widget build(BuildContext context) {
    final jours = DateTime.now().difference(plantation.plantedAt).inDays;
    final dernierArrosage = plantation.wateredAt.isEmpty
        ? null
        : DateTime.now().difference(plantation.wateredAt.last).inDays;
    // Ce que VoiceOver lit : le dessin du post-it ne dit ni l'âge ni
    // la soif.
    final details = <String>[
      trUiArgs('planté {0}', <Object?>[_ilYA(jours)]),
      if (etape != null) etape!.label.toLowerCase(),
      dernierArrosage == null
          ? trUi('jamais arrosé')
          : trUiArgs('arrosé {0}', <Object?>[_ilYA(dernierArrosage)]),
    ].join('  ·  ');
    final couleurs = <Color>[
      const Color(0xFFFFF0F3),
      const Color(0xFFE3F1E0),
      const Color(0xFFFBE2CD),
      const Color(0xFFD6ECF5),
      const Color(0xFFFFF3C4),
    ];
    // La couleur suit l'espèce, et reste la même d'un lancement à
    // l'autre : `hashCode` n'en promet pas tant.
    final couleur = couleurs[
        vegetable.id.codeUnits.fold<int>(0, (a, b) => a + b) % couleurs.length];

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + delai),
      curve: Curves.easeOutBack,
      builder: (_, t, child) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 16 * (1 - t)),
          child: child,
        ),
      ),
      child: Transform.rotate(
        angle: angle,
        child: Semantics(
          label: '${vegetable.displayName}, $details',
          hint: trUi('Ouvre le dossier de ce plant'),
          button: true,
          excludeSemantics: true,
          child: Material(
            color: couleur,
            elevation: 2,
            shadowColor: Colors.black26,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(14),
            ),
            child: InkWell(
              onTap: () => showPlantationSheet(context, plantation, vegetable),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: vegetable.imageAsset == null
                          ? Center(
                              child: Text(vegetable.emoji,
                                  style: const TextStyle(fontSize: 26)),
                            )
                          : Image.asset(vegetable.imageAsset!,
                              width: 40, height: 40, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vegetable.displayName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: KultivaColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
