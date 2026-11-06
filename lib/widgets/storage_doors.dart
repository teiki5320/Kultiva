import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/recipes.dart';
import '../data/recipes_i18n.dart';
import '../data/ui_i18n.dart';
import '../theme/app_theme.dart';
import '../utils/storage_place.dart';

/// Les trois meubles de l'onglet Conservation : congélateur, placard,
/// réfrigérateur. Maquette « F · Les portes qui s'ouvrent », validée
/// par Jean le 06/11/2026.
///
/// Chaque meuble montre ce qu'on peut y ranger derrière sa porte. Les
/// portes s'entrouvrent à tour de rôle pour donner envie d'y regarder ;
/// celle qu'on touche s'ouvre en grand et le reste, et l'étagère de ce
/// meuble apparaît dessous (`StorageShelf`).
///
/// ⚠️ Le va-et-vient des portes s'arrête quand le système demande moins
/// d'animations (`MediaQuery.disableAnimations`) : seule la porte
/// choisie s'ouvre, sans rebond.
class StorageDoors extends StatelessWidget {
  final StoragePlace? selected;
  final ValueChanged<StoragePlace> onTap;

  /// Combien de conservations vont dans chaque meuble.
  final Map<StoragePlace, int> counts;

  /// Les images de légumes à montrer derrière chaque porte, jardin
  /// d'abord. Quatre au plus.
  final Map<StoragePlace, List<String>> images;

  const StorageDoors({
    super.key,
    required this.selected,
    required this.onTap,
    required this.counts,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final p in StoragePlace.values) ...<Widget>[
          if (p != StoragePlace.values.first) const SizedBox(width: 10),
          Expanded(
            child: _Meuble(
              place: p,
              selected: selected == p,
              count: counts[p] ?? 0,
              images: images[p] ?? const <String>[],
              // Les portes ne s'ouvrent pas toutes en même temps.
              phase: p.index / StoragePlace.values.length,
              onTap: () => onTap(p),
            ),
          ),
        ],
      ],
    );
  }
}

/// Les couleurs d'un meuble : l'intérieur, son bord, et la porte.
class _Teintes {
  final Color dedans;
  final Color bord;
  final Color porteHaut;
  final Color porteBas;
  const _Teintes(this.dedans, this.bord, this.porteHaut, this.porteBas);

  static _Teintes de(StoragePlace p) {
    switch (p) {
      case StoragePlace.freezer:
        return const _Teintes(KultivaColors.winterA, KultivaColors.winterB,
            Color(0xFFC6D8E3), Color(0xFF9FBDD0));
      case StoragePlace.cupboard:
        return const _Teintes(Color(0xFFF6E2C4), Color(0xFFC99B62),
            Color(0xFFD9AE78), Color(0xFFB98A52));
      case StoragePlace.fridge:
        return const _Teintes(Color(0xFFE9F5E6), KultivaColors.springB,
            Color(0xFFBCE5C1), Color(0xFF92D29A));
    }
  }
}

class _Meuble extends StatefulWidget {
  final StoragePlace place;
  final bool selected;
  final int count;
  final List<String> images;
  final double phase;
  final VoidCallback onTap;

  const _Meuble({
    required this.place,
    required this.selected,
    required this.count,
    required this.images,
    required this.phase,
    required this.onTap,
  });

  @override
  State<_Meuble> createState() => _MeubleState();
}

class _MeubleState extends State<_Meuble> with TickerProviderStateMixin {
  /// Le va-et-vient d'attente : six secondes par tour.
  late final AnimationController _attente = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );

  /// L'ouverture franche, quand on choisit ce meuble.
  late final AnimationController _ouverture = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    value: widget.selected ? 1 : 0,
  );

  bool _calme = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calme = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_calme) {
      _attente.stop();
    } else if (!_attente.isAnimating) {
      _attente.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _Meuble old) {
    super.didUpdateWidget(old);
    if (old.selected != widget.selected) {
      if (widget.selected) {
        _ouverture.forward();
      } else {
        _ouverture.reverse();
      }
    }
  }

  @override
  void dispose() {
    _attente.dispose();
    _ouverture.dispose();
    super.dispose();
  }

  /// L'angle d'attente, entre 0 (fermée) et 1 (entrouverte).
  double _entrouverte(double t) {
    final u = (t + widget.phase) % 1.0;
    if (u < 0.15) return 0;
    if (u < 0.35) return Curves.easeOut.transform((u - 0.15) / 0.2);
    if (u < 0.75) return 1;
    if (u < 0.95) return 1 - Curves.easeIn.transform((u - 0.75) / 0.2);
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final t = _Teintes.de(widget.place);
    final compte = widget.count > 1
        ? trUiArgs('{0} façons', <Object?>[widget.count])
        : trUiArgs('{0} façon', <Object?>[widget.count]);

    return Semantics(
      button: true,
      selected: widget.selected,
      label: '${widget.place.label}, $compte',
      hint: trUi('Touche un meuble pour l\'ouvrir'),
      excludeSemantics: true,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: widget.selected
                    ? const <BoxShadow>[
                        BoxShadow(
                          color: KultivaColors.primaryGreen,
                          spreadRadius: 3,
                        ),
                      ]
                    : const <BoxShadow>[],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _Interieur(teintes: t, images: widget.images),
                    AnimatedBuilder(
                      animation:
                          Listenable.merge(<Listenable>[_attente, _ouverture]),
                      builder: (_, __) {
                        final ouvert = Curves.easeOutBack
                            .transform(_ouverture.value)
                            .clamp(0.0, 1.1);
                        final attente =
                            _calme ? 0.0 : _entrouverte(_attente.value);
                        // 110° grande ouverte, 100° pour le va-et-vient.
                        final angle = math.max(
                          ouvert * 110 * math.pi / 180,
                          attente * 100 * math.pi / 180,
                        );
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0012)
                            ..rotateY(-angle),
                          child: _Porte(teintes: t, place: widget.place),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.place.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
            Text(
              compte,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF557562),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Interieur extends StatelessWidget {
  final _Teintes teintes;
  final List<String> images;
  const _Interieur({required this.teintes, required this.images});

  @override
  Widget build(BuildContext context) {
    Widget rangee(Iterable<String> assets) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (final a in assets)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Image.asset(a, width: 30, height: 30),
              ),
          ],
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: teintes.dedans,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: teintes.bord, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          rangee(images.take(2)),
          Container(height: 3, color: Colors.white.withValues(alpha: 0.9)),
          rangee(images.skip(2).take(2)),
        ],
      ),
    );
  }
}

class _Porte extends StatelessWidget {
  final _Teintes teintes;
  final StoragePlace place;
  const _Porte({required this.teintes, required this.place});

  @override
  Widget build(BuildContext context) {
    final bois = place == StoragePlace.cupboard;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[teintes.porteHaut, teintes.porteBas],
        ),
        border: Border.all(color: teintes.porteBas, width: 3),
      ),
      child: Stack(
        children: <Widget>[
          if (bois)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25), width: 2),
                ),
              ),
            ),
          // La poignée, côté opposé aux charnières.
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 6,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// L'étagère du meuble ouvert : trois bocaux qui glissent en place,
/// chacun avec son étiquette de durée qui se balance.
class StorageShelf extends StatefulWidget {
  final StoragePlace place;

  /// Les recettes à poser sur l'étagère, avec l'id de leur légume.
  final List<(String, Recipe)> items;
  final void Function(String vegetableId, Recipe recipe) onOpen;

  const StorageShelf({
    super.key,
    required this.place,
    required this.items,
    required this.onOpen,
  });

  @override
  State<StorageShelf> createState() => _StorageShelfState();
}

class _StorageShelfState extends State<StorageShelf>
    with SingleTickerProviderStateMixin {
  late final AnimationController _balance = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final calme = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (calme) {
      _balance.stop();
    } else if (!_balance.isAnimating) {
      _balance.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _balance.dispose();
    super.dispose();
  }

  static Color _contenu(PreservationMethod? m) {
    switch (m) {
      case PreservationMethod.congelation:
      case PreservationMethod.blanchiCongele:
        return const Color(0xFF9FC9E3);
      case PreservationMethod.transformeCongele:
        return const Color(0xFFF2A65A);
      case PreservationMethod.bocalSterilise:
        return const Color(0xFFD64B3B);
      case PreservationMethod.lactoFermentation:
        return const Color(0xFFF6B6C6);
      case PreservationMethod.sechage:
        return const Color(0xFFD9C27A);
      case PreservationMethod.confiture:
        return const Color(0xFFE2405A);
      case PreservationMethod.dansHuile:
        return const Color(0xFFC9D98A);
      case PreservationMethod.auVinaigre:
        return const Color(0xFFB39DDB);
      case null:
        return KultivaColors.lightGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = _Teintes.de(widget.place);
    final bocaux = widget.items.take(3).toList();
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
      decoration: BoxDecoration(
        color: t.dedans,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: t.bord, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.place.insideLabel,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: KultivaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              for (var i = 0; i < bocaux.length; i++)
                Expanded(child: _bocal(i, bocaux[i].$1, bocaux[i].$2, t)),
            ],
          ),
          // La planche.
          Container(
            height: 12,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFC99B62), Color(0xFFA87842)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bocal(int i, String vegId, Recipe r, _Teintes t) {
    final total = 600 + 150 * i;
    final keeps = r.displayKeeps ?? r.keeps;
    return TweenAnimationBuilder<double>(
      // Une clé par recette : changer de meuble refait glisser les bocaux.
      key: ValueKey<String>('${widget.place.name}-$vegId-${r.name}'),
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(150 * i / total, 1, curve: Curves.easeOutBack),
      builder: (_, v, child) => Opacity(
        opacity: v.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(-60 * (1 - v), 0),
          child: Transform.rotate(angle: -0.14 * (1 - v), child: child),
        ),
      ),
      child: Semantics(
        button: true,
        label: keeps == null ? r.displayName : '${r.displayName}, $keeps',
        excludeSemantics: true,
        child: InkWell(
          onTap: () => widget.onOpen(vegId, r),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 74,
                  height: 92,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 14,
                        right: 14,
                        top: 0,
                        height: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            color: t.porteBas,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 4,
                        right: 4,
                        top: 12,
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: 0.7,
                            widthFactor: 1,
                            child: ColoredBox(color: _contenu(r.method)),
                          ),
                        ),
                      ),
                      if (r.keeps != null)
                        Positioned(
                          left: 12,
                          right: 12,
                          top: 42,
                          height: 22,
                          child: AnimatedBuilder(
                            animation: _balance,
                            builder: (_, child) => Transform.rotate(
                              alignment: Alignment.topCenter,
                              angle: (_balance.value - 0.5) *
                                  0.1 *
                                  (i.isEven ? 1 : -1),
                              child: child,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFAF0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: FittedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text(
                                    shortKeeps(keeps ?? r.keeps!),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: KultivaColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  r.displayName,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: KultivaColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
