import 'dart:convert';

import 'tutos_en.dart';

/// Traduire les 34 tutos HTML sans les toucher.
///
/// **Pourquoi pas une copie par langue.** Chaque tuto est une page
/// autonome, avec son CSS et parfois son JavaScript. Les dupliquer,
/// c'est 34 fichiers × n langues qui divergent à la première
/// correction — le raisonnement qui a déjà produit `zone_shift.dart`
/// plutôt que quatre calendriers recopiés.
///
/// **Pourquoi pas un gabarit non plus.** Transformer les 34 pages en
/// gabarits nourris par du JSON demandait de les réécrire une par une,
/// chacune ayant sa propre structure. Beaucoup de travail, et autant
/// d'occasions de casser une mise en page qui marche.
///
/// **Ce qu'on fait à la place** : on injecte un dictionnaire et une
/// dizaine de lignes de JavaScript avant `</body>`, et le navigateur
/// remplace les textes **dans le DOM**. Les 34 fichiers ne bougent
/// jamais. C'est la même idée que le champ `ui` du lecteur de
/// recettes : Dart injecte, le navigateur applique.
///
/// **La clé est le texte français lui-même.** Si une phrase française
/// est corrigée, sa clé ne correspond plus et la phrase reste en
/// français — pas de traduction fantôme qui survit à une correction.
/// Une clé vide retombe aussi sur le français : on traduit par
/// morceaux.
///
/// ⚠️ Comme le reste du contenu hors ligne, **aucun appel réseau** :
/// le dictionnaire voyage dans la page.
const Map<String, Map<String, String>> tutoTextsByLanguage =
    <String, Map<String, String>>{
  'en': tutoTextsEn,
};

/// Le JavaScript qui applique le dictionnaire, une fois la page lue.
///
/// Il ne touche ni aux `<script>` ni aux `<style>` : du code traduit
/// ne compilerait plus. Un `MutationObserver` reprend les textes
/// ajoutés après coup — le tuto du dashboard écrit ses légendes au fil
/// de l'animation, et sans lui elles resteraient françaises.
const String _walker = r'''
(function () {
  var D = window.__KULTIVA_TUTO_T__;
  if (!D) return;
  var MUET = { SCRIPT: 1, STYLE: 1, NOSCRIPT: 1 };
  var ATTRS = ['alt', 'title', 'aria-label', 'placeholder'];

  function trad(s) {
    if (!s) return null;
    var k = s.replace(/\s+/g, ' ').trim();
    if (!k) return null;
    var v = D[k];
    return (typeof v === 'string' && v) ? v : null;
  }

  function texte(n) {
    var v = trad(n.nodeValue);
    if (v === null) return;
    var m = /^(\s*)[\s\S]*?(\s*)$/.exec(n.nodeValue);
    n.nodeValue = (m ? m[1] : '') + v + (m ? m[2] : '');
  }

  function parcours(n) {
    if (!n) return;
    if (n.nodeType === 3) { texte(n); return; }
    if (n.nodeType !== 1 || MUET[n.tagName]) return;
    for (var i = 0; i < ATTRS.length; i++) {
      if (n.hasAttribute && n.hasAttribute(ATTRS[i])) {
        var a = trad(n.getAttribute(ATTRS[i]));
        if (a) n.setAttribute(ATTRS[i], a);
      }
    }
    for (var c = n.firstChild; c; c = c.nextSibling) parcours(c);
  }

  function tout() {
    parcours(document.body);
    var t = trad(document.title);
    if (t) document.title = t;
  }

  tout();
  document.documentElement.setAttribute('lang', window.__KULTIVA_LANG__);

  // Les textes écrits par l'animation d'un tuto arrivent après ce
  // premier passage : on les reprend au vol.
  if (window.MutationObserver) {
    var o = new MutationObserver(function (lots) {
      for (var i = 0; i < lots.length; i++) {
        var aj = lots[i].addedNodes;
        for (var j = 0; j < aj.length; j++) parcours(aj[j]);
        if (lots[i].type === 'characterData') texte(lots[i].target);
      }
    });
    o.observe(document.body, {
      childList: true, subtree: true, characterData: true,
    });
  }
})();
''';

/// Renvoie le tuto traduit dans la langue demandée.
///
/// En français, ou dans une langue sans dictionnaire, le HTML est rendu
/// **inchangé** : pas de script inutile dans la page.
String tutoTraduit(String html, String languageCode) {
  final dico = tutoTextsByLanguage[languageCode];
  if (dico == null || dico.isEmpty) return html;

  // On ne transporte que ce qui est réellement traduit : une clé vide
  // veut dire « pas encore fait », et la laisser passer ferait
  // disparaître la phrase française au lieu de la garder.
  final utiles = <String, String>{
    for (final e in dico.entries)
      if (e.value.isNotEmpty) e.key: e.value,
  };
  if (utiles.isEmpty) return html;

  final bloc = '<script>window.__KULTIVA_LANG__=' // ignore: prefer_adjacent_string_concatenation
      '${jsonEncode(languageCode)};'
      'window.__KULTIVA_TUTO_T__=${jsonEncode(utiles)};'
      '$_walker</script>';

  // Avant `</body>` : le DOM est lu, et les scripts propres au tuto
  // ont déjà posé leur contenu initial.
  final i = html.lastIndexOf('</body>');
  if (i < 0) return '$html$bloc';
  return html.substring(0, i) + bloc + html.substring(i);
}
