/// Les textes des tutos, en anglais.
///
/// Clé = le texte **français** exact, espaces normalisés. Une clé
/// absente ou vide laisse la phrase en français : on traduit par
/// morceaux, sans jamais casser une page.
///
/// **Comment on le remplit.** Pas à la main, mais tuto par tuto :
///
/// ```bash
/// python3 tool/exporter_tutos.py --compte
/// python3 tool/exporter_tutos.py --squelette --langue=en --tuto=paillage
/// ```
///
/// ⚠️ **Les nombres ne se traduisent pas** : « 30 cm » reste « 30 cm »,
/// « 100 °C » reste « 100 °C ». Pas de pouces, pas de Fahrenheit.
/// `test/tutos_i18n_test.dart` le vérifie sur chaque chaîne, comme
/// pour les recettes.
///
/// **`conserver_legumes` est le modèle**, traduit en entier : c'est la
/// référence de ton pour les 32 autres tutos.
const Map<String, String> tutoTextsEn = <String, String>{
  // ─── conserver_legumes (36 textes, 300 mots) ───
  'Conserver ses légumes': 'Storing your harvest',
  'Récolte': 'Harvest',
  'Garder tes récoltes toute l\'année': 'Keeping your harvest all year',
  'L\'essentiel': 'The short version',
  'Il existe quatre grandes méthodes : la cave (frais), la congélation, '
      'le bocal (stérilisation ou lacto-fermentation) et le séchage.':
      'There are four main methods: the cellar (cool storage), freezing, '
          'jars (sterilising or lacto-fermenting) and drying.',
  'Les 4 méthodes': 'The 4 methods',
  'Cave (frais et sec)': 'Cellar (cool and dry)',
  'Idéal pour pommes de terre, carottes, betteraves, oignons. '
      'Température 8-12 °C, obscurité, bonne ventilation. Les racines '
      'se gardent plusieurs mois.':
      'Ideal for potatoes, carrots, beetroot and onions. Temperature '
          '8-12 °C, darkness, good airflow. Roots keep for several '
          'months.',
  'Congélation': 'Freezing',
  'Blanchis les légumes 2-3 min avant de congeler. Étale-les sur un '
      'plateau avant de les ensacher pour éviter les blocs. '
      'Conservation 6-12 mois.':
      'Blanch vegetables for 2-3 min before freezing. Spread them on a '
          'tray before bagging them so they do not set into a block. '
          'Keeps 6-12 months.',
  'Bocal (stérilisation / lacto-fermentation)':
      'Jars (sterilising / lacto-fermenting)',
  'Stérilise les bocaux à 100 °C. Pour la lacto-fermentation, il suffit '
      'd\'eau salée à 3 %. Les bocaux se conservent plus d\'un an.':
      'Sterilise jars at 100 °C. For lacto-fermenting, salted water at '
          '3 % is all you need. Jars keep for over a year.',
  'Séchage': 'Drying',
  'Au soleil, au four (60 °C) ou au déshydrateur. Parfait pour tomates, '
      'herbes, piments. Stocker dans des bocaux hermétiques à l\'abri '
      'de la lumière.':
      'In the sun, in the oven (60 °C) or in a dehydrator. Perfect for '
          'tomatoes, herbs and chillies. Store in airtight jars, away '
          'from light.',
  'Les règles d\'or': 'The golden rules',
  'Trie avant de stocker': 'Sort before you store',
  'Élimine les légumes abîmés ou tachés : un seul fruit pourri peut '
      'contaminer tout le lot.':
      'Throw out anything bruised or spotted: a single rotten fruit can '
          'spoil the whole batch.',
  'Ne lave pas avant stockage': 'Do not wash before storing',
  'L\'humidité résiduelle accélère la dégradation. Brosse simplement la '
      'terre si nécessaire.':
      'Leftover moisture speeds up rot. Just brush the soil off if you '
          'need to.',
  'Sépare l\'éthylène': 'Keep ethylene apart',
  'Certains fruits (pommes, tomates) émettent de l\'éthylène qui fait '
      'mûrir — et pourrir — les voisins plus vite.':
      'Some fruits (apples, tomatoes) give off ethylene, which ripens — '
          'and rots — their neighbours faster.',
  'Étiquette tout 🏷️': 'Label everything 🏷️',
  'Note le contenu et la date sur chaque bocal, sachet ou cagette. Tu '
      'éviteras les mauvaises surprises.':
      'Write the contents and the date on every jar, bag and crate. It '
          'saves you nasty surprises.',
  'Vérifie régulièrement': 'Check on them regularly',
  'Inspecte tes stocks toutes les 2 semaines et retire immédiatement ce '
      'qui commence à s\'abîmer.':
      'Look through your stores every 2 weeks and pull out anything '
          'starting to turn.',
  'Le conseil du jardinier': 'The gardener\'s tip',
  'La lacto-fermentation est la méthode la plus simple et nutritive.':
      'Lacto-fermenting is the simplest method, and the most '
          'nourishing.',
  'À éviter': 'What to avoid',
  'Pommes avec pommes de terre :': 'Apples with potatoes:',
  'l\'éthylène des pommes accélère la germination des tubercules.':
      'the ethylene from apples makes the tubers sprout sooner.',
  'Conserver humide :': 'Storing them damp:',
  'l\'excès d\'humidité provoque moisissures et pourriture en quelques '
      'jours.':
      'too much moisture brings mould and rot within days.',
  'Stocker à la lumière :': 'Storing them in the light:',
  'la lumière fait verdir les pommes de terre et dégrade les vitamines.':
      'light turns potatoes green and breaks down their vitamins.',
  'Négliger la stérilisation :': 'Skimping on sterilising:',
  'un bocal mal stérilisé peut développer des bactéries dangereuses.':
      'a badly sterilised jar can grow dangerous bacteria.',
};
