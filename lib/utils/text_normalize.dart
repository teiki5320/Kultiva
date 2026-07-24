// Utilitaires de normalisation de texte pour une app francophone.
//
// Le tri par `String.compareTo` compare les code units UTF-16 : « É »
// (U+00C9) est supérieur à « Z », donc Échalote / Épinard se retrouvent
// après le Z de l'alphabet. Et une recherche « echalote » ne trouve pas
// « Échalote ». On replie donc les diacritiques avant de comparer.

const Map<String, String> _foldMap = <String, String>{
  'à': 'a',
  'â': 'a',
  'ä': 'a',
  'á': 'a',
  'ã': 'a',
  'å': 'a',
  'ç': 'c',
  'è': 'e',
  'é': 'e',
  'ê': 'e',
  'ë': 'e',
  'ì': 'i',
  'í': 'i',
  'î': 'i',
  'ï': 'i',
  'ñ': 'n',
  'ò': 'o',
  'ó': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ù': 'u',
  'ú': 'u',
  'û': 'u',
  'ü': 'u',
  'ý': 'y',
  'ÿ': 'y',
  'œ': 'oe',
  'æ': 'ae',
};

/// Replie les accents et met en minuscules : « Échalote » → « echalote ».
/// Sert de clé de tri et de recherche insensibles aux diacritiques.
String foldAccents(String input) {
  final lower = input.toLowerCase();
  final buffer = StringBuffer();
  for (final ch in lower.split('')) {
    buffer.write(_foldMap[ch] ?? ch);
  }
  return buffer.toString();
}

/// Comparaison de chaînes insensible aux accents et à la casse, pour
/// trier une liste francophone dans le bon ordre alphabétique.
int compareFolded(String a, String b) =>
    foldAccents(a).compareTo(foldAccents(b));
