import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../data/ui_i18n.dart';
import '../../../services/plantation_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/petal_animation.dart';
import '../../../widgets/readable_width.dart';
import '../../../utils/text_scale.dart';
import '../../../widgets/season_header.dart';
import 'journal_view.dart';

/// Les derniers jours du journal, en bas du cahier.
///
/// Trois journées suffisent à donner le fil ; le reste est derrière
/// « Tout le journal ». L'écran complet existait déjà, mais il fallait
/// ouvrir le Poussidex puis choisir la bonne vue sur quatre.
class CahierJournalSection extends StatefulWidget {
  const CahierJournalSection({super.key});

  @override
  State<CahierJournalSection> createState() => _CahierJournalSectionState();
}

class _CahierJournalSectionState extends State<CahierJournalSection> {
  static const int _joursEnApercu = 3;

  /// Trois post-it : l'éventail de la maquette C4c.
  static const int _gestesEnEventail = 3;

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
    final plants = PlantationService.instance.all;
    if (plants.isEmpty) return const SizedBox.shrink();

    final derniers = journalEvents(plants).take(_gestesEnEventail).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                child: Text(
                  trUi('Journal'),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const JournalScreen()),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: KultivaColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 44),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(trUi('Tout le journal')),
              ),
            ],
          ),
        ),
        if (derniers.isEmpty)
          GardenJournalView(
            plantations: plants,
            maxDays: _joursEnApercu,
            shrinkWrap: true,
          )
        else
          _Eventail(gestes: derniers),
      ],
    );
  }
}

/// Les trois derniers gestes, en éventail de post-it.
///
/// Maquette « C4c · La pile du jour ». La liste datée reste entière
/// derrière « Tout le journal » : l'éventail dit ce qui vient d'être
/// fait, pas l'historique.
class _Eventail extends StatelessWidget {
  final List<JournalEvent> gestes;
  const _Eventail({required this.gestes});

  /// Le papier d'un geste : l'eau en bleu, la récolte en terracotta,
  /// la photo en jaune, le semis en vert.
  static Color _papier(JournalEvent e) {
    switch (e.icon) {
      case '💧':
        return const Color(0xFFD6ECF5);
      case '🏁':
        return const Color(0xFFFBE2CD);
      case '📷':
        return const Color(0xFFFFF3C4);
      default:
        return const Color(0xFFE3F1E0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Le plus ancien à gauche, le plus récent à droite et au-dessus :
    // on lit l'éventail comme une frise.
    final ordre = gestes.reversed.toList();
    final calme = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    // L'éventail s'ouvre depuis le bas des post-it, donc il lui faut
    // la place de la rotation : 140 de papier, 30 de débattement.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      // ⚠️ `width: double.infinity` n'est pas décoratif. La colonne du
      // cahier est en `CrossAxisAlignment.start`, donc une boîte sans
      // largeur se réduit à son contenu et se colle à gauche : les
      // post-it rotés sortaient alors de l'écran par la gauche. Vu à
      // l'écran le 07/11/2026, invisible pour `analyze` et pour les
      // tests, qui ne regardent pas **où** une boîte est dessinée.
      child: SizedBox(
        width: double.infinity,
        height: scaledHeight(context, 180),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            for (var i = 0; i < ordre.length; i++)
              _PostItJournal(
                geste: ordre[i],
                couleur: _papier(ordre[i]),
                // −14°, 0°, +14° quand il y en a trois ; les deux cas
                // plus courts se répartissent sur la même ouverture.
                angle: ordre.length == 1
                    ? 0
                    : (-14 + 28 * i / (ordre.length - 1)) * math.pi / 180,
                // Une rotation seule pivote les trois post-it autour du
                // même point : ils se recouvrent presque entièrement.
                // Le décalage ouvre l'éventail. ⚠️ Il vaut 46 et non
                // 34 parce qu'à 34 le post-it de devant coupait le
                // mot du dessous en deux (« Arrosé 🍅 Tom »). Un
                // éventail montre la tranche de ce qu'il cache, pas
                // la moitié d'un mot.
                decalage: ordre.length == 1
                    ? 0
                    : -46 + 92 * i / (ordre.length - 1),
                delai: Duration(milliseconds: calme ? 0 : 80 * i),
                anime: !calme,
              ),
          ],
        ),
      ),
    );
  }
}

class _PostItJournal extends StatelessWidget {
  final JournalEvent geste;
  final Color couleur;
  final double angle;
  final double decalage;
  final Duration delai;
  final bool anime;

  const _PostItJournal({
    required this.geste,
    required this.couleur,
    required this.angle,
    required this.decalage,
    required this.delai,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    final jour = journalDayLabel(geste.date);
    // ⚠️ Une boîte fixe redevient trop petite dès que l'utilisateur
    // agrandit le texte : la hauteur suit l'échelle, et le compte de
    // lignes se calcule sur ce qui reste sous la date.
    final hauteur = scaledHeight(context, 140);
    final papier = Semantics(
      label: '$jour · ${geste.action} ${geste.vegetableLabel}',
      excludeSemantics: true,
      child: Container(
        width: 130,
        height: hauteur,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: couleur,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
            bottomLeft: Radius.circular(18),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              jour,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: Color.lerp(geste.color, Colors.black, 0.35),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                '${geste.action}\n${geste.vegetableLabel}',
                // La boîte est fixe : le compte de lignes doit valoir
                // ce qu'elle peut montrer, échelle de police comprise.
                maxLines:
                    lignesQuiTiennent(context, hauteur - 46, 13,
                        interligne: 1.25),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                  color: KultivaColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget pose(double v) => Transform.translate(
          offset: Offset(decalage * v, 0),
          child: Transform.rotate(
            alignment: Alignment.bottomCenter,
            angle: angle * v,
            child: papier,
          ),
        );
    if (!anime) return pose(1);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Interval(
        delai.inMilliseconds / 500,
        1,
        curve: Curves.easeOutBack,
      ),
      builder: (_, v, __) => pose(v),
    );
  }
}

/// Le journal en entier, sur son propre écran.
class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mois = DateTime.now().month;
    return Scaffold(
      // ⚠️ Cet écran n'était pas borné, alors que le cahier d'où il
      // part l'est à 900. Sur un iPad 13″ la même ligne de journal
      // s'étirait sur 1 032 points et l'heure se retrouvait à l'autre
      // bout de l'écran, à treize centimètres de son libellé. C'est
      // le défaut que la fiche décrivait pour l'onglet Conservation,
      // resté sur un écran poussé qu'on avait oublié.
      body: ReadableWidth(
        maxWidth: 900,
        child: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SeasonHeader(
                  season: Season.current(mois),
                  month: mois,
                  height: kPageHeaderHeight,
                  hideLabel: true,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          trUi('📖  Journal du jardin'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 6, color: Colors.black38),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          trUi('Tout ce que tu as fait, jour par jour'),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 5, color: Colors.black38),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Semantics(
                    label: trUi('Retour'),
                    button: true,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: PlantationService.instance,
                builder: (context, _) => GardenJournalView(
                  plantations: PlantationService.instance.all,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
