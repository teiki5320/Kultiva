/// Noms locaux des cultures dans les principales langues d'Afrique de
/// l'Ouest. Affichés dans la fiche légume quand la région active est
/// l'Afrique de l'Ouest. N'inclure que des noms bien attestés.
///
/// Langues couvertes : wolof (Sénégal), bambara/dioula (Mali, Burkina,
/// Côte d'Ivoire), mooré (Burkina Faso), haoussa (Niger), peul (fulfulde),
/// fon (Bénin), éwé (Togo). Translittération francophone courante.
class LocalName {
  final String language;
  final String name;
  const LocalName(this.language, this.name);
}

const Map<String, List<LocalName>> localNames = <String, List<LocalName>>{
  // ── Cultures emblématiques d'Afrique de l'Ouest ──────────────────────
  'gombo': <LocalName>[
    LocalName('wolof', 'kandja'),
    LocalName('bambara', 'gan'),
    LocalName('haoussa', 'kubewa'),
    LocalName('éwé', 'fetri'),
  ],
  'bissap': <LocalName>[
    LocalName('wolof', 'bissap'),
    LocalName('bambara', 'da bilenni'),
    LocalName('haoussa', 'yakuwa'),
  ],
  'moringa': <LocalName>[
    LocalName('wolof', 'nébéday'),
    LocalName('mooré', 'arzan tiiga'),
    LocalName('haoussa', 'zogale'),
  ],
  'aubergine_africaine': <LocalName>[
    LocalName('wolof', 'djakhatou'),
    LocalName('bambara', "n'goyo"),
    LocalName('haoussa', 'gauta'),
    LocalName('éwé', 'gboma'),
  ],
  'corete': <LocalName>[
    LocalName('éwé', 'adémè'),
    LocalName('fon', 'crincrin'),
    LocalName('haoussa', 'lalo'),
  ],
  'celosie': <LocalName>[
    LocalName('fon', 'fotètè'),
  ],
  'amarante': <LocalName>[
    LocalName('fon', 'tètè'),
    LocalName('haoussa', 'alayyafo'),
  ],

  // ── Céréales ─────────────────────────────────────────────────────────
  'mil': <LocalName>[
    LocalName('wolof', 'dugub'),
    LocalName('bambara', 'sanyo'),
    LocalName('haoussa', 'gero'),
  ],
  'sorgho': <LocalName>[
    LocalName('haoussa', 'dawa'),
  ],
  'fonio': <LocalName>[
    LocalName('wolof', 'foño'),
    LocalName('bambara', 'findi'),
    LocalName('haoussa', 'acha'),
  ],
  'mais': <LocalName>[
    LocalName('wolof', 'mbokh'),
    LocalName('bambara', 'kaba'),
    LocalName('mooré', 'kamaana'),
    LocalName('haoussa', 'masara'),
  ],

  // ── Légumineuses et oléagineux ───────────────────────────────────────
  'niebe': <LocalName>[
    LocalName('wolof', 'ñebbe'),
    LocalName('bambara', 'sho'),
    LocalName('mooré', 'benga'),
    LocalName('haoussa', 'wake'),
  ],
  'arachide': <LocalName>[
    LocalName('wolof', 'gerte'),
    LocalName('bambara', 'tiga'),
    LocalName('haoussa', 'gyada'),
  ],
  'sesame': <LocalName>[
    LocalName('wolof', 'bène'),
    LocalName('bambara', 'bènè'),
    LocalName('haoussa', 'ridi'),
  ],

  // ── Tubercules et racines ────────────────────────────────────────────
  'manioc': <LocalName>[
    LocalName('wolof', 'gnambi'),
    LocalName('bambara', 'banankou'),
    LocalName('haoussa', 'rogo'),
    LocalName('éwé', 'agbeli'),
  ],
  'igname': <LocalName>[
    LocalName('bambara', 'kou'),
    LocalName('haoussa', 'doya'),
    LocalName('éwé', 'té'),
    LocalName('fon', 'té'),
  ],
  'taro': <LocalName>[
    LocalName('haoussa', 'gwaza'),
  ],
  'patate_douce': <LocalName>[
    LocalName('wolof', 'patas'),
    LocalName('bambara', 'woso'),
    LocalName('haoussa', 'dankali'),
  ],
  'pomme_de_terre': <LocalName>[
    LocalName('wolof', 'pombiteer'),
  ],

  // ── Légumes-fruits et condiments ─────────────────────────────────────
  'tomate': <LocalName>[
    LocalName('wolof', 'tamaate'),
    LocalName('bambara', 'tamati'),
    LocalName('haoussa', 'tumatir'),
  ],
  'oignon': <LocalName>[
    LocalName('wolof', 'soble'),
    LocalName('bambara', 'jaba'),
    LocalName('haoussa', 'albasa'),
  ],
  'ail': <LocalName>[
    LocalName('wolof', 'laaj'),
    LocalName('haoussa', 'tafarnuwa'),
  ],
  'piment': <LocalName>[
    LocalName('wolof', 'kaani'),
    LocalName('dioula', 'foronto'),
    LocalName('haoussa', 'barkono'),
  ],
  'gingembre': <LocalName>[
    LocalName('dioula', 'gnamakou'),
    LocalName('haoussa', 'citta'),
  ],
  'menthe': <LocalName>[
    LocalName('wolof', 'nana'),
  ],
  'chou_pomme': <LocalName>[
    LocalName('wolof', 'supome'),
  ],

  // ── Courges et fruits ────────────────────────────────────────────────
  'potiron': <LocalName>[
    LocalName('haoussa', 'kabewa'),
  ],
  'pasteque': <LocalName>[
    LocalName('wolof', 'khaal'),
    LocalName('haoussa', 'kankana'),
  ],
  'papayer': <LocalName>[
    LocalName('haoussa', 'gwanda'),
    LocalName('éwé', 'adiba'),
  ],
  'bananier_plantain': <LocalName>[
    LocalName('éwé', 'abladzo'),
  ],
};
