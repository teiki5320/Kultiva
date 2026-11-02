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
  'Associations de plantes':
      'Companion planting',
  'Aménagement':
      'Layout',
  'Le compagnonnage au potager':
      'Companion planting in the veg patch',
  'Certaines plantes s\'entraident, d\'autres se gênent. En les associant bien, tu réduis les maladies, repousses les nuisibles et améliores les récoltes naturellement.':
      'Some plants help each other, others get in each other\'s way. Pair them well and you cut disease, keep pests away and get better harvests, all naturally.',
  'Les bonnes associations':
      'Good pairings',
  'Légume':
      'Vegetable',
  'Bons compagnons':
      'Good companions',
  '🍅 Tomate':
      '🍅 Tomato',
  'Basilic, carotte, persil':
      'Basil, carrot, parsley',
  '🥕 Carotte':
      '🥕 Carrot',
  'Poireau, oignon, tomate':
      'Leek, onion, tomato',
  '🥒 Courgette':
      '🥒 Courgette',
  'Maïs, haricot, capucine':
      'Sweetcorn, bean, nasturtium',
  '🥬 Salade':
      '🥬 Lettuce',
  'Radis, carotte, fraisier':
      'Radish, carrot, strawberry',
  '🫘 Haricot':
      '🫘 Bean',
  'Maïs, courgette, carotte':
      'Sweetcorn, courgette, carrot',
  '🧅 Oignon':
      '🧅 Onion',
  'Carotte, tomate, fraisier':
      'Carrot, tomato, strawberry',
  '🍓 Fraisier':
      '🍓 Strawberry',
  'Salade, oignon, ail':
      'Lettuce, onion, garlic',
  '🥦 Chou':
      '🥦 Cabbage',
  'Céleri, betterave, tomate':
      'Celery, beetroot, tomato',
  'Les associations à éviter':
      'Pairings to avoid',
  'Tomate + pomme de terre':
      'Tomato + potato',
  'Même famille (solanacées) : elles partagent les mêmes maladies, notamment le mildiou qui se propage de l\'une à l\'autre.':
      'Same family (nightshades): they share the same diseases, especially blight, which spreads from one to the other.',
  'Oignon + haricot':
      'Onion + bean',
  'Les alliacées (oignon, ail, poireau) freinent la croissance des légumineuses (haricot, pois, fève).':
      'Alliums (onion, garlic, leek) slow down the growth of legumes (bean, pea, broad bean).',
  'Concombre + tomate':
      'Cucumber + tomato',
  'Ces deux gourmands se font concurrence pour les nutriments et l\'eau. Ils sont aussi sensibles aux mêmes maladies.':
      'These two hungry plants compete for nutrients and water. They are also prone to the same diseases.',
  'Chou + fraisier':
      'Cabbage + strawberry',
  'Le chou étouffe le fraisier avec son feuillage imposant et lui vole la lumière nécessaire à la fructification.':
      'Cabbage smothers strawberries with its big leaves and steals the light they need to fruit.',
  'Les plantes alliées':
      'Helpful plants',
  'Œillet d\'Inde':
      'French marigold',
  'Repousse les pucerons, les aleurodes et les nématodes. Plante-le au pied des tomates et autour du potager.':
      'Keeps away aphids, whiteflies and nematodes. Plant it at the foot of your tomatoes and around the veg patch.',
  'Capucine':
      'Nasturtium',
  'Attire les pucerons loin des légumes : elle sert de plante piège. Ses fleurs sont comestibles en bonus.':
      'Draws aphids away from your vegetables, so it works as a trap plant. Its flowers are edible too, as a bonus.',
  'Bourrache':
      'Borage',
  'Attire les pollinisateurs et repousse les limaces. Ses fleurs bleues égayent le potager et se mangent en salade.':
      'Attracts pollinators and keeps slugs away. Its blue flowers brighten up the veg patch and can be eaten in salads.',
  'Basilic et aneth':
      'Basil and dill',
  'Le basilic protège les tomates des mouches blanches. L\'aneth attire les syrphes, prédateurs naturels des pucerons.':
      'Basil protects tomatoes from whiteflies. Dill attracts hoverflies, which are natural predators of aphids.',
  'La règle la plus simple : mélange les familles de légumes et ajoute des fleurs partout. La diversité est la meilleure protection naturelle.':
      'The simplest rule: mix up your vegetable families and add flowers everywhere. Variety is the best natural protection.',
  'Regrouper la même famille :':
      'Grouping the same family together:',
  'les maladies et parasites se propagent plus vite entre plantes apparentées.':
      'diseases and pests spread faster between related plants.',
  'Ignorer les incompatibilités :':
      'Ignoring bad pairings:',
  'certaines plantes sécrètent des substances qui inhibent la croissance de leurs voisines.':
      'some plants release substances that hold back the growth of their neighbours.',
  'Oublier les fleurs :':
      'Forgetting the flowers:',
  'un potager sans fleurs attire moins de pollinisateurs et plus de ravageurs.':
      'a veg patch without flowers attracts fewer pollinators and more pests.',
  'Planter trop serré :':
      'Planting too close:',
  'même les bonnes associations échouent si les plantes manquent d\'espace et de lumière.':
      'even good pairings fail if the plants lack space and light.',
  'Attirer les pollinisateurs':
      'Attracting pollinators',
  'Astuces':
      'Tips',
  'Sans eux, pas de récolte':
      'No pollinators, no harvest',
  'Abeilles, bourdons, papillons et syrphes pollinisent 80% des cultures du potager. Les attirer, c\'est assurer tes récoltes naturellement.':
      'Bees, bumblebees, butterflies and hoverflies pollinate 80% of the crops in your veg patch. Attracting them means securing your harvest, naturally.',
  'Les fleurs qui les attirent':
      'Flowers that attract them',
  'Lavande, sauge, thym 💜':
      'Lavender, sage, thyme 💜',
  'Les aromatiques méditerranéennes sont irrésistibles pour les abeilles. Plantées en bordure, elles protègent aussi du vent.':
      'Mediterranean herbs are irresistible to bees. Planted along the edge, they also shelter the patch from the wind.',
  'Tournesol, cosmos 🌻':
      'Sunflower, cosmos 🌻',
  'Grandes fleurs bien visibles qui attirent de loin. Semis facile et direct au printemps.':
      'Big, bold flowers that draw pollinators from far away. Easy to sow straight into the ground in spring.',
  'Bourrache, phacélie 🌼':
      'Borage, phacelia 🌼',
  'Les championnes de la pollinisation. La bourrache se ressème toute seule, la phacélie améliore le sol.':
      'The pollination champions. Borage seeds itself, and phacelia improves the soil.',
  'Œillet d\'Inde, souci 🌺':
      'French marigold, calendula 🌺',
  'Double emploi : attirent les pollinisateurs et repoussent les pucerons et nématodes du potager.':
      'Two jobs in one: they attract pollinators and keep aphids and nematodes away from your veg.',
  'Créer des refuges':
      'Make shelters',
  'Hôtel à insectes 🏨':
      'Bug hotel 🏨',
  'Un assemblage de bûches percées, tiges creuses et pommes de pin. Orienté sud-est, à l\'abri de la pluie.':
      'A bundle of drilled logs, hollow stems and pine cones. Face it south-east, sheltered from the rain.',
  'Tas de bois 🪵':
      'Log pile 🪵',
  'Empile quelques bûches dans un coin du jardin. Les insectes y hivernent et les hérissons aussi.':
      'Stack a few logs in a corner of the garden. Insects spend the winter there, and so do hedgehogs.',
  'Point d\'eau 💧':
      'Water point 💧',
  'Une coupelle avec des cailloux et de l\'eau permet aux abeilles de boire sans se noyer.':
      'A saucer filled with pebbles and water lets bees drink without drowning.',
  'Haies fleuries 🌿':
      'Flowering hedges 🌿',
  'Aubépine, sureau, cornouiller : des haies champêtres qui nourrissent les pollinisateurs toute l\'année.':
      'Hawthorn, elder, dogwood: country hedges that feed pollinators all year round.',
  'Les bonnes pratiques':
      'Good habits',
  'Floraison étalée 🗓️':
      'Staggered flowering 🗓️',
  'Choisis des plantes qui fleurissent à différentes saisons pour nourrir les pollinisateurs de mars à octobre.':
      'Choose plants that flower in different seasons so pollinators have food from March to October.',
  'Zéro pesticide 🚫':
      'Zero pesticides 🚫',
  'Même les produits « bio » peuvent tuer les insectes utiles. Privilégie les solutions mécaniques et préventives.':
      'Even "organic" products can kill helpful insects. Prefer mechanical and preventive solutions.',
  'Tonte raisonnée 🌱':
      'Mindful mowing 🌱',
  'Laisse des zones de pelouse haute avec trèfle et pâquerettes. Les abeilles adorent le trèfle blanc.':
      'Leave patches of long grass with clover and daisies. Bees love white clover.',
  'Variétés anciennes 🌻':
      'Old varieties 🌻',
  'Les fleurs doubles modernes sont souvent stériles : préfère les variétés simples et anciennes, riches en nectar.':
      'Modern double flowers are often sterile. Choose single, older varieties, which are rich in nectar.',
  'Une bordure de fleurs sauvages le long de ton potager suffit à doubler tes rendements. Sème un mélange « prairie fleurie » et laisse faire la nature.':
      'A strip of wildflowers along your veg patch is enough to double your yields. Sow a "wildflower meadow" mix and let nature do the rest.',
  'Utiliser des pesticides chimiques :':
      'Using chemical pesticides:',
  'ils tuent les pollinisateurs et appauvrissent la biodiversité de ton jardin.':
      'they kill pollinators and make your garden less diverse.',
  'Tout tondre ras :':
      'Mowing everything short:',
  'une pelouse tondue à ras est un désert pour les insectes.':
      'a closely mown lawn is a desert for insects.',
  'Ne planter que des fleurs doubles :':
      'Planting only double flowers:',
  'elles sont souvent stériles et sans nectar.':
      'they are often sterile and have no nectar.',
  'Nettoyer tout le jardin en automne :':
      'Tidying the whole garden in autumn:',
  'les tiges sèches et feuilles mortes abritent les insectes l\'hiver.':
      'dry stems and dead leaves shelter insects over winter.',
  'Bien arroser':
      'Watering well',
  'Arrosage':
      'Watering',
  'La juste quantité au bon moment':
      'The right amount at the right time',
  'Un bon arrosage, c\'est une eau qui descend en profondeur pour forcer les racines à plonger. Mieux vaut arroser beaucoup et moins souvent que peu et tous les jours.':
      'Good watering means water that sinks deep and makes roots grow down after it. It is better to water a lot, less often, than a little every day.',
  'Arrose le soir ou tôt le matin 🌙':
      'Water in the evening or early morning 🌙',
  'Évite le plein soleil : l\'eau s\'évapore et les gouttes peuvent brûler les feuilles par effet loupe.':
      'Avoid full sun: the water evaporates, and droplets can scorch leaves by acting like a magnifying glass.',
  'Vise le pied, pas les feuilles':
      'Aim at the base, not the leaves',
  'L\'eau sur les feuilles favorise les maladies comme le mildiou ou l\'oïdium, surtout le soir.':
      'Water on the leaves encourages diseases like blight and powdery mildew, especially in the evening.',
  'Arrose en profondeur 💦':
      'Water deeply 💦',
  'L\'eau doit atteindre 15-20 cm sous la surface. Un petit trou creusé avec le doigt te permet de vérifier.':
      'The water should reach 15-20 cm below the surface. Dig a small hole with your finger to check.',
  'Espace les arrosages':
      'Space out your watering',
  'Laisse la surface sécher entre deux arrosages. Les racines descendront chercher l\'eau plus en profondeur.':
      'Let the surface dry out between waterings. The roots will then go deeper to look for water.',
  'Paille autour des plants 🍂':
      'Straw around the plants 🍂',
  'Un paillage de 5-7 cm garde l\'humidité et divise les besoins en eau par deux.':
      'A 5-7 cm layer of mulch keeps moisture in and halves the water your plants need.',
  'Besoins par légume':
      'Needs by vegetable',
  'Fréquence':
      'Frequency',
  'Quantité':
      'Amount',
  '2x/sem':
      '2x/week',
  '2-3 L/pied':
      '2-3 L/plant',
  '3x/sem':
      '3x/week',
  '3-5 L/pied':
      '3-5 L/plant',
  '1-2x/sem':
      '1-2x/week',
  '10 L/m²':
      '10 L/m²',
  'Tous les 2j':
      'Every 2 days',
  '5 L/m²':
      '5 L/m²',
  '🌶️ Poivron':
      '🌶️ Pepper',
  '2 L/pied':
      '2 L/plant',
  'Enfonce ton doigt dans la terre sur 3 cm. Si c\'est sec, arrose. Si c\'est humide, attends. Cette méthode vaut mieux que n\'importe quelle règle de fréquence fixe.':
      'Push your finger 3 cm into the soil. If it is dry, water. If it is damp, wait. This works better than any fixed schedule.',
  'Arroser un peu tous les jours :':
      'Watering a little every day:',
  'les racines restent en surface et deviennent fragiles.':
      'the roots stay near the surface and become fragile.',
  'Arroser en plein soleil :':
      'Watering in full sun:',
  'choc thermique et brûlures sur les feuilles.':
      'it causes thermal shock and leaf scorch.',
  'Mouiller les feuilles le soir :':
      'Wetting the leaves in the evening:',
  'l\'humidité stagnante favorise les maladies.':
      'standing moisture encourages disease.',
  'Oublier de pailler :':
      'Forgetting to mulch:',
  'le sol sèche deux fois plus vite et tu arroses le double.':
      'the soil dries out twice as fast and you end up watering twice as much.',
  'Cultiver l\'igname':
      'Growing yams',
  'Climat tropical':
      'Tropical climate',
  'Le roi des tubercules, patience récompensée':
      'The king of tubers: patience pays off',
  'L\'igname est un tubercule star d\'Afrique de l\'Ouest, au cycle long de':
      'Yam is a star tuber of West Africa, with a long growing cycle of',
  '8 à 10 mois':
      '8 to 10 months',
  '. Sa recette : une grosse butte de terre meuble, un bon semenceau, un tuteur solide… et de la patience ! 🐢':
      '. The recipe: a big mound of loose soil, a good seed piece, a sturdy stake... and patience! 🐢',
  'De la butte à la récolte':
      'From mound to harvest',
  'Monte des buttes ou des billons ⛰️':
      'Build mounds or ridges ⛰️',
  'Des buttes de 50 cm à 1 m de haut, espacées d\'environ 1 m, en terre profonde et bien ameublie. Plus la terre est meuble, plus le tubercule descend droit et grossit.':
      'Mounds 50 cm to 1 m high, about 1 m apart, in deep, well-loosened soil. The looser the soil, the straighter the tuber grows down, and the bigger it gets.',
  'Choisis tes semenceaux 🍠':
      'Choose your seed pieces 🍠',
  'Des morceaux de tubercule sains de 200 à 400 g, sans taches ni pourriture. La tête du tubercule germe le mieux. Trempe la coupe dans la cendre et laisse cicatriser 2-3 jours à l\'ombre.':
      'Healthy pieces of tuber weighing 200 to 400 g, with no marks or rot. The head of the tuber sprouts best. Dip the cut side in ash and leave it to heal for 2-3 days in the shade.',
  'Plante en début de pluies 🌧️':
      'Plant at the start of the rains 🌧️',
  'Enterre chaque semenceau à 5-10 cm au sommet de la butte, bourgeon vers le haut. Une couche de paille par-dessus garde la butte fraîche.':
      'Bury each seed piece 5-10 cm deep at the top of the mound, bud facing up. A layer of straw on top keeps the mound cool.',
  'Tuteure les lianes 🎋':
      'Stake the vines 🎋',
  'L\'igname grimpe ! Plante un tuteur de 2 m (bambou, branche) près de chaque butte. Des lianes bien exposées à la lumière = un tubercule bien nourri.':
      'Yam climbs! Put a 2 m stake (bamboo, branch) next to each mound. Vines that get plenty of light mean a well-fed tuber.',
  'Entretiens sans stress 🍂':
      'Look after them without stress 🍂',
  'Désherbe autour des buttes, remonte la terre si la pluie la tasse, paille bien. Ensuite, l\'igname pousse presque toute seule pendant des mois.':
      'Weed around the mounds, pull the soil back up if rain flattens it, and mulch well. After that, yam almost grows by itself for months.',
  'Récolte au bon signal 🧺':
      'Harvest at the right signal 🧺',
  'Quand le feuillage jaunit et sèche (8-10 mois), c\'est l\'heure. Creuse doucement autour de la butte à la main ou au bâton, sans blesser le tubercule.':
      'When the leaves turn yellow and dry out (8-10 months), it is time. Dig gently around the mound by hand or with a stick, without hurting the tuber.',
  'Pour la conservation : ne lave pas tes ignames ! Laisse-les sécher quelques heures à l\'ombre, puis range-les dans un endroit sec, aéré et sombre, posées sur des claies ou de la paille. Elles se gardent plusieurs mois. Mets de côté les plus beaux tubercules : ce seront tes semenceaux de l\'an prochain.':
      'For storage: do not wash your yams! Let them dry for a few hours in the shade, then put them in a dry, airy, dark place, resting on racks or straw. They keep for several months. Set aside the finest tubers: they will be next year\'s seed pieces.',
  'Un sol caillouteux ou tassé :':
      'Stony or compacted soil:',
  'le tubercule se déforme, fourche ou reste petit. Ameublis en profondeur avant de butter.':
      'the tuber becomes misshapen, forked or stays small. Loosen the soil deeply before you build the mound.',
  'Blesser l\'igname à la récolte :':
      'Wounding the yam at harvest:',
  'chaque coupure est une porte ouverte à la pourriture. Creuse à la main plutôt qu\'à la machette près du tubercule.':
      'every cut is an open door for rot. Dig by hand rather than with a machete near the tuber.',
  'Planter des semenceaux malades :':
      'Planting diseased seed pieces:',
  'taches, moisissures ou ramollissement = poubelle. Un mauvais semenceau contamine toute la butte.':
      'spots, mould or softness means the bin. One bad seed piece infects the whole mound.',
  'Stocker au soleil ou dans l\'humidité :':
      'Storing in sun or damp:',
  'les tubercules verdissent, germent ou pourrissent. Ombre, air sec et surveillance régulière !':
      'the tubers turn green, sprout or rot. Shade, dry air and regular checks!',
  'Découvrir Kultiva':
      'Discover Kultiva',
  'Découvrir Kultiva 🌱':
      'Discover Kultiva 🌱',
  'Ton tableau de bord':
      'Your dashboard',
  'Tout ce qu’il y a à faire aujourd’hui, en un coup d’œil.':
      'Everything to do today, at a glance.',
  'Que semer ce mois-ci ?':
      'What to sow this month?',
  'La liste change avec ta région et la saison.':
      'The list changes with your region and the season.',
  'Et que récolter':
      'And what to harvest',
  'Ce qui est prêt, maintenant, chez toi.':
      'What is ready right now, where you are.',
  'Toute l’année d’un seul regard':
      'The whole year at a glance',
  'Une ligne par légume, douze mois, rien à faire défiler de côté.':
      'One row per vegetable, twelve months, no sideways scrolling.',
  'Ton cahier de culture':
      'Your growing notebook',
  'Qui a soif, qui est mûr, et s’il va faire trop chaud.':
      'Who is thirsty, who is ripe, and whether it is going to get too hot.',
  'Dessine tes carrés':
      'Draw your squares',
  'Place tes plants par glisser-déposer, chaque case se souvient.':
      'Place your plants by drag and drop, and every square remembers.',
  'Ta saison, jour par jour':
      'Your season, day by day',
  'Chaque semis, chaque arrosage, chaque récolte s’inscrit à sa date.':
      'Every sowing, watering and harvest is logged on its date.',
  'L’Étal, ton marché kawaii':
      'The Stall, your kawaii market',
  '130 cultures en fiches détaillées, plus les accessoires.':
      '130 crops in detailed sheets, plus accessories.',
  '50 défis photo, 50 badges':
      '50 photo challenges, 50 badges',
  'Les badges récompensent ce que tu fais vraiment au jardin.':
      'Badges reward what you really do in the garden.',
  '🎒 En résumé':
      '🎒 In short',
  'Semer, récolter, suivre et apprendre — tout tient dans ta poche.':
      'Sow, harvest, track and learn: it all fits in your pocket.',
  'Bonjour 👋':
      'Hello 👋',
  'Kultiva 🌱':
      'Kultiva 🌱',
  'Automne':
      'Autumn',
  'octobre':
      'October',
  '13°C':
      '13°C',
  'Semer':
      'Sow',
  '74 légumes':
      '74 vegetables',
  'Récolter':
      'Harvest',
  '39 légumes':
      '39 vegetables',
  'Calendrier':
      'Calendar',
  'Vue annuelle':
      'Year view',
  'Légume du jour':
      'Vegetable of the day',
  'Mâche':
      'Lamb\'s lettuce',
  'Défis & badges':
      'Challenges & badges',
  'Actualités':
      'News',
  'Suis-nous sur Instagram':
      'Follow us on Instagram',
  '‹ Home':
      '‹ Home',
  '📅 Calendrier annuel':
      '📅 Year calendar',
  'Semis':
      'Sowing',
  '📔 Cahier de culture':
      '📔 Growing notebook',
  '2 jardins · 6 cases occupées · 4 plants suivis':
      '2 gardens · 6 squares in use · 4 plants tracked',
  'À faire aujourd’hui':
      'To do today',
  'Arroser :':
      'Water:',
  'tomate, basilic':
      'tomato, basil',
  'Arroser':
      'Water',
  'À récolter :':
      'To harvest:',
  'laitue':
      'lettuce',
  'Mes jardins':
      'My gardens',
  'Potager du fond':
      'Back vegetable patch',
  '4 cases occupées':
      '4 squares in use',
  'Carré du balcon':
      'Balcony square',
  '2 cases occupées':
      '2 squares in use',
  'Au jardin en ce moment':
      'In the garden right now',
  'Tomate · 7 sem.':
      'Tomato · 7 wk',
  'arrosée hier':
      'watered yesterday',
  'Basilic · 4 sem.':
      'Basil · 4 wk',
  'arrosé hier':
      'watered yesterday',
  'Laitue · 8 sem.':
      'Lettuce · 8 wk',
  'arrosée ce matin':
      'watered this morning',
  'Courgette · 5 sem.':
      'Courgette · 5 wk',
  'Journal ›':
      'Journal ›',
  '‹ Cahier':
      '‹ Notebook',
  '📖 Journal':
      '📖 Journal',
  'AUJOURD’HUI':
      'TODAY',
  'Arrosé':
      'Watered',
  '· tomate':
      '· tomato',
  'HIER':
      'YESTERDAY',
  'Récolté':
      'Harvested',
  '· radis':
      '· radish',
  'Photo':
      'Photo',
  '· courgette':
      '· courgette',
  '12 MAI':
      '12 MAY',
  'Planté':
      'Planted',
  '· 3 tomates':
      '· 3 tomatoes',
  '🛒 L’Étal':
      '🛒 The Stall',
  '🔍 Chercher une culture…':
      '🔍 Search for a crop…',
  'Toutes':
      'All',
  'Fleurs':
      'Flowers',
  'Feuilles':
      'Leaves',
  'Fruits':
      'Fruits',
  'Bulbes':
      'Bulbs',
  'Racines':
      'Roots',
  'Tomate':
      'Tomato',
  'Carotte':
      'Carrot',
  'Laitue':
      'Lettuce',
  'Fraise':
      'Strawberry',
  'Oignon':
      'Onion',
  'Poivron':
      'Pepper',
  'Tournesol':
      'Sunflower',
  'Aubergine':
      'Aubergine',
  'Piment':
      'Chilli',
  'Brocoli':
      'Broccoli',
  'Maïs':
      'Sweetcorn',
  'Ail':
      'Garlic',
  '🏅 Défis & badges':
      '🏅 Challenges & badges',
  '📷 Défis photo':
      '📷 Photo challenges',
  '🏅 Badges':
      '🏅 Badges',
  'Ta première tomate rouge':
      'Your first red tomato',
  'Un semis qui lève':
      'A seedling that comes up',
  'Une coccinelle au potager':
      'A ladybird in the veg patch',
  'Ton panier de récolte':
      'Your harvest basket',
  'Une fleur de courgette':
      'A courgette flower',
  'Une abeille au travail':
      'A bee at work',
  'Premier semis':
      'First sowing',
  'Arroseur fidèle':
      'Faithful waterer',
  'Première récolte':
      'First harvest',
  'Cahier tenu':
      'Notebook keeper',
  'Photographe':
      'Photographer',
  'Roi de la tomate':
      'Tomato king',
  'Ami des abeilles':
      'Friend of bees',
  'Jardin fleuri':
      'Flower garden',
  'Main verte':
      'Green fingers',
  'Tout tient dans ta poche':
      'It all fits in your pocket',
  'Suivre':
      'Track',
  'Apprendre':
      'Learn',
  'Home':
      'Home',
  'Cahier':
      'Notebook',
  'Étal':
      'Stall',
  'Tutos':
      'Tutorials',
  'Mettre l’animation en pause':
      'Pause the animation',
  'Récupérer l\'eau de pluie':
      'Collecting rainwater',
  'Gratuite, douce et écologique':
      'Free, soft and eco-friendly',
  'L\'eau de pluie est idéale pour arroser : douce (sans calcaire), à température ambiante et gratuite. Un toit de 50 m² récupère environ 30 m³ d\'eau par an en France.':
      'Rainwater is ideal for watering: soft (no limescale), at room temperature and free. A 50 m² roof collects around 30 m³ of water a year in France.',
  'Installer un récupérateur':
      'Setting up a water butt',
  'Choisis le bon volume':
      'Choose the right size',
  'Pour un potager de 50 m², une cuve de 300 à 500 litres suffit. Au-delà, prévois 1000 litres ou plusieurs cuves en série.':
      'For a 50 m² veg patch, a 300 to 500 litre tank is enough. Beyond that, plan for 1000 litres or several tanks linked in series.',
  'Trouve le bon emplacement':
      'Find the right spot',
  'Place la cuve sous une descente de gouttière, sur un sol plat et stable. Le plus près possible du potager pour faciliter l\'arrosage.':
      'Put the tank under a downpipe, on flat, stable ground. Keep it as close as possible to the veg patch to make watering easier.',
  'Installe un collecteur':
      'Fit a collector',
  'Un collecteur filtrant se fixe sur la gouttière et redirige l\'eau vers la cuve. Il intègre un filtre à feuilles et un trop-plein automatique.':
      'A filtering collector clips onto the downpipe and sends the water into the tank. It includes a leaf filter and an automatic overflow.',
  'Surélève la cuve':
      'Raise the tank',
  'Place-la sur des parpaings ou un socle de 30-40 cm. La gravité te donne assez de pression pour remplir un arrosoir ou brancher un tuyau.':
      'Stand it on concrete blocks or a 30-40 cm base. Gravity gives you enough pressure to fill a watering can or connect a hose.',
  'Couvre et protège':
      'Cover and protect',
  'Un couvercle opaque empêche les algues de proliférer et les moustiques de pondre. Vérifie qu\'il est bien fermé en permanence.':
      'An opaque lid stops algae from growing and mosquitoes from laying eggs. Make sure it stays properly closed at all times.',
  'Entretien au fil des saisons':
      'Upkeep through the seasons',
  'Printemps':
      'Spring',
  'Nettoie la cuve et le filtre après l\'hiver. Vérifie les raccords et reconnecte le collecteur si tu l\'avais démonté.':
      'Clean the tank and filter after winter. Check the fittings and reconnect the collector if you had taken it off.',
  'Été':
      'Summer',
  'Surveille le niveau d\'eau et nettoie le filtre toutes les 2 semaines. Par canicule, l\'eau tiède de la cuve est parfaite pour les plants.':
      'Check the water level and clean the filter every 2 weeks. In a heatwave, the lukewarm water in the tank is perfect for your plants.',
  'Retire les feuilles mortes du filtre régulièrement. C\'est la saison où la cuve se remplit le plus vite grâce aux pluies abondantes.':
      'Remove dead leaves from the filter regularly. This is the season when the tank fills fastest, thanks to the heavy rains.',
  'Hiver':
      'Winter',
  'Vidange partiellement la cuve et ouvre le robinet pour éviter le gel. Déconnecte le collecteur si les températures descendent sous -5°C.':
      'Partly empty the tank and open the tap to prevent frost damage. Disconnect the collector if temperatures drop below -5°C.',
  'L\'eau de pluie est parfaite pour arroser les plantes qui détestent le calcaire : tomates, fraisiers, hortensias, rhododendrons.':
      'Rainwater is perfect for plants that hate limescale: tomatoes, strawberries, hydrangeas, rhododendrons.',
  'Laisser la cuve ouverte :':
      'Leaving the tank uncovered:',
  'les moustiques pondent dans l\'eau stagnante. Un couvercle ou une moustiquaire est indispensable.':
      'mosquitoes lay eggs in standing water. A lid or a mosquito net is essential.',
  'Arroser avec de l\'eau trop froide :':
      'Watering with water that is too cold:',
  'en hiver, l\'eau de pluie stockée peut être glaciale. Laisse-la se réchauffer avant d\'arroser.':
      'in winter, stored rainwater can be icy. Let it warm up before you water.',
  'Laisser la cuve pleine en hiver :':
      'Leaving the tank full in winter:',
  'le gel peut fissurer la cuve. Vidange-la aux deux tiers avant les premières gelées.':
      'frost can crack the tank. Empty it by two thirds before the first frosts.',
  'Négliger le filtre :':
      'Neglecting the filter:',
  'un filtre bouché déborde et l\'eau sale encrasse la cuve. Nettoie-le au moins une fois par mois.':
      'a blocked filter overflows and dirty water fouls the tank. Clean it at least once a month.',
  'Engrais naturels':
      'Natural fertilisers',
  'Sol & Compost':
      'Soil & Compost',
  'Nourrir ses plantes sans chimie':
      'Feeding your plants without chemicals',
  'Les engrais naturels apportent les trois éléments principaux : azote (N) pour les feuilles, phosphore (P) pour les racines, potassium (K) pour les fleurs et fruits.':
      'Natural fertilisers provide the three main nutrients: nitrogen (N) for leaves, phosphorus (P) for roots, potassium (K) for flowers and fruit.',
  'Les engrais selon le besoin':
      'Fertilisers by need',
  'N':
      'N',
  'Feuilles — Azote':
      'Leaves: Nitrogen',
  'Purin d\'ortie, sang séché, corne broyée, fumier composté. Stimule la croissance des tiges et feuilles.':
      'Nettle feed, dried blood, ground horn, composted manure. Boosts the growth of stems and leaves.',
  'P':
      'P',
  'Racines — Phosphore':
      'Roots: Phosphorus',
  'Poudre d\'os, farine de poisson, guano. Renforce l\'enracinement et la résistance des plants.':
      'Bone meal, fish meal, guano. Strengthens rooting and makes plants hardier.',
  'K':
      'K',
  'Fleurs et fruits — Potassium':
      'Flowers and fruit: Potassium',
  'Cendre de bois, purin de consoude, vinasse de betterave. Favorise la floraison et la fructification.':
      'Wood ash, comfrey feed, beet vinasse. Encourages flowering and fruiting.',
  'Oligo-éléments':
      'Trace elements',
  'Algues marines, lithothamne, basalte broyé. Apportent fer, magnésium, bore et autres micro-nutriments essentiels.':
      'Seaweed, lithothamnion, crushed basalt. They supply iron, magnesium, boron and other essential micronutrients.',
  'Fabriquer son purin d\'ortie':
      'Making nettle feed',
  'Récolte les orties':
      'Gather the nettles',
  'Cueille 1 kg d\'orties fraîches (avant floraison de préférence). Utilise des gants !':
      'Pick 1 kg of fresh nettles (ideally before they flower). Wear gloves!',
  'Hache grossièrement':
      'Chop roughly',
  'Coupe les orties en morceaux et place-les dans un seau ou un fût non métallique.':
      'Cut the nettles into pieces and put them in a bucket or a non-metal barrel.',
  'Ajoute l\'eau':
      'Add the water',
  'Couvre avec 10 litres d\'eau de pluie. L\'eau du robinet convient aussi en laissant déchlorer 24h.':
      'Cover with 10 litres of rainwater. Tap water works too if you leave it to stand for 24 hours so the chlorine goes.',
  'Remue chaque jour':
      'Stir every day',
  'Brasse le mélange quotidiennement pendant 10 à 15 jours. Quand il ne mousse plus, c\'est prêt.':
      'Stir the mixture daily for 10 to 15 days. When it stops foaming, it is ready.',
  'Filtre et dilue':
      'Strain and dilute',
  'Filtre avec un tissu. Dilue à 10% (1 L de purin pour 9 L d\'eau) avant d\'arroser au pied des plants.':
      'Strain through a cloth. Dilute to 10% (1 L of feed to 9 L of water) before watering at the base of your plants.',
  'Le compost reste l\'engrais universel le plus équilibré. Il nourrit le sol et les plantes en même temps, et améliore la structure de la terre.':
      'Compost is still the most balanced all-round fertiliser. It feeds the soil and the plants at the same time, and improves soil structure.',
  'Surdoser les engrais :':
      'Overdoing the fertiliser:',
  'même naturels, trop d\'engrais brûle les racines et déséquilibre le sol.':
      'even natural fertiliser burns roots and unbalances the soil if you use too much.',
  'Engrais sur sol sec :':
      'Fertiliser on dry soil:',
  'arrose toujours avant d\'appliquer un engrais liquide pour éviter les brûlures.':
      'always water before you apply liquid fertiliser, to avoid burning.',
  'Fertiliser en hiver :':
      'Feeding in winter:',
  'les plantes sont au repos, l\'engrais est lessivé par les pluies sans être absorbé.':
      'plants are resting, so rain washes the fertiliser away before they can take it up.',
  'Cendres en excès :':
      'Too much ash:',
  'rendent le sol trop alcalin. Maximum une poignée par m² et par an.':
      'it makes the soil too alkaline. One handful per m² per year at most.',
  'Fabriquer une ombrière':
      'Building a shade shelter',
  'Un coin de fraîcheur pour ton potager':
      'A cool corner for your veg patch',
  'Une ombrière filtre 30 à 50 % du soleil et fait baisser la température de plusieurs degrés. Sous son abri, laitues, choux et tomates continuent de pousser même en pleine saison chaude. 😎':
      'A shade shelter filters 30 to 50 % of the sun and lowers the temperature by several degrees. Underneath, lettuces, cabbages and tomatoes keep growing even in the hottest season. 😎',
  'Construis ta structure':
      'Build the frame',
  'Choisis l\'emplacement 🧭':
      'Choose the spot 🧭',
  'Repère la course du soleil : l\'ombrière doit surtout couvrir tes cultures aux heures les plus chaudes (11h-16h). Une orientation est-ouest donne une ombre régulière toute la journée.':
      'Follow the path of the sun: the shelter should mainly cover your crops during the hottest hours (11h-16h). An east-west orientation gives even shade all day.',
  'Plante les poteaux 🎋':
      'Plant the posts 🎋',
  '4 à 6 poteaux en bois ou en bambou, enterrés de 40-50 cm et bien tassés. Vise 1,8 à 2 m de hauteur : assez haut pour circuler et laisser l\'air passer.':
      '4 to 6 wooden or bamboo posts, buried 40-50 cm deep and firmly packed in. Aim for a height of 1.8 to 2 m: high enough to walk under and let air through.',
  'Relie et consolide 🪢':
      'Link and reinforce 🪢',
  'Fixe des traverses entre les poteaux (clous, fil de fer ou corde solide) et ajoute des diagonales dans les angles : c\'est ce qui résistera aux coups de vent.':
      'Fix crossbars between the posts (nails, wire or strong rope) and add diagonal braces in the corners. This is what will stand up to gusts of wind.',
  'Tends la couverture 🕸️':
      'Stretch the cover 🕸️',
  'Filet d\'ombrage 30-50 % bien tendu et attaché tous les 50 cm. Pas de filet ? Des palmes tressées, nattes ou seccos posés sur les traverses font très bien le travail.':
      'Use 30-50 % shade netting, pulled tight and tied every 50 cm. No netting? Woven palm leaves, mats or seccos laid over the crossbars do the job very well.',
  'Installe tes cultures 🌱':
      'Settle your crops in 🌱',
  'Place dessous les planches de légumes-feuilles et la pépinière. Laisse les côtés ouverts pour que la brise circule et que la pluie puisse entrer.':
      'Put your leafy vegetable beds and the nursery underneath. Leave the sides open so the breeze can flow and rain can get in.',
  'Qui en profite le plus ?':
      'Who benefits most?',
  'Laitue et salades':
      'Lettuce and salad leaves',
  'Sans ombre, elles montent en graines et deviennent amères dès qu\'il fait trop chaud.':
      'Without shade, they bolt and turn bitter as soon as it gets too hot.',
  'Chou':
      'Cabbage',
  'Il pomme beaucoup mieux au frais. L\'ombrière limite aussi le stress hydrique.':
      'It forms much better heads in the cool. The shelter also reduces water stress.',
  'Tomate en saison chaude':
      'Tomato in the hot season',
  'Au-delà de 35 °C, ses fleurs coulent sans donner de fruits. Un voile à 30 % la garde productive.':
      'Above 35 °C, its flowers drop without setting fruit. A 30 % shade cloth keeps it productive.',
  'Semis et jeunes plants':
      'Seedlings and young plants',
  'La pépinière entière adore l\'ombrière : levée plus régulière, arrosages moins fréquents.':
      'The whole nursery loves the shelter: more even germination and less frequent watering.',
  'Fixe ton filet avec des attaches faciles à défaire : en saison fraîche ou par temps couvert, retire-le pour redonner un maximum de lumière à tes plants. Une ombrière, ça se module !':
      'Fix your netting with fastenings that are easy to undo: in the cool season or in overcast weather, take it off to give your plants as much light as possible. A shade shelter is adjustable!',
  'Un ombrage trop dense (plus de 60 %) :':
      'Shade that is too dense (over 60 %):',
  'les plants filent, s\'affaiblissent et produisent peu. 30-50 %, c\'est l\'équilibre parfait.':
      'plants stretch, weaken and produce little. 30-50 % is the sweet spot.',
  'La bâche plastique pleine :':
      'A solid plastic sheet:',
  'elle bloque la pluie, garde la chaleur et transforme l\'abri en four. Il faut que l\'air et l\'eau passent.':
      'it blocks the rain, traps heat and turns the shelter into an oven. Air and water have to get through.',
  'Une structure trop basse :':
      'A structure that is too low:',
  'sous 1,5 m, la chaleur s\'accumule et tu te casses le dos pour jardiner.':
      'under 1.5 m, heat builds up and you wreck your back gardening.',
  'Négliger le vent :':
      'Ignoring the wind:',
  'un filet mal fixé devient une voile. Ancre bien les poteaux et vérifie les attaches après chaque tempête.':
      'a badly fixed net becomes a sail. Anchor the posts well and check the fastenings after every storm.',
  'Faire son compost':
      'Making compost',
  'L\'or noir du jardinier':
      'The gardener\'s black gold',
  'Le compost c\'est l\'équilibre entre déchets verts (humides, azote) et déchets bruns (secs, carbone). La règle d\'or : 1 volume vert pour 2 volumes bruns, et on aère régulièrement.':
      'Compost is a balance between green waste (wet, nitrogen) and brown waste (dry, carbon). The golden rule: 1 part green to 2 parts brown, and turn it regularly.',
  'Quelle méthode choisir ?':
      'Which method should you choose?',
  'En bac':
      'In a bin',
  'Jardin petit ou moyen, discret':
      'Small or medium garden, discreet',
  'En tas':
      'In a heap',
  'Grand jardin, gros volumes':
      'Large garden, big volumes',
  '📍 Emplacement au contact du sol':
      '📍 Place it in contact with the soil',
  '🍂 Couche brune au fond':
      '🍂 Brown layer at the bottom',
  '🔄 Alterne vert et brun':
      '🔄 Alternate green and brown',
  '💨 Aère tous les 15 jours':
      '💨 Turn it every 15 days',
  '💧 Humide comme une éponge pressée':
      '💧 Damp like a wrung-out sponge',
  'Ce qu\'on peut mettre':
      'What you can add',
  'Déchets verts':
      'Green waste',
  'Épluchures, marc de café, tontes fraîches, restes de légumes, mauvaises herbes non montées en graines.':
      'Peelings, coffee grounds, fresh grass clippings, vegetable scraps, weeds that have not gone to seed.',
  'Déchets bruns':
      'Brown waste',
  'Feuilles mortes, branchages broyés, carton brun non imprimé, paille, sciure de bois non traité.':
      'Dead leaves, shredded branches, plain brown cardboard, straw, untreated sawdust.',
  'Le compost est prêt quand il est brun foncé, friable et qu\'il sent bon la forêt.':
      'Compost is ready when it is dark brown, crumbly and smells like the forest.',
  'Viande et poisson :':
      'Meat and fish:',
  'attirent les nuisibles et provoquent des odeurs nauséabondes.':
      'they attract pests and cause foul smells.',
  'Plantes malades :':
      'Diseased plants:',
  'les pathogènes peuvent survivre et contaminer le compost.':
      'pathogens can survive and contaminate the compost.',
  'Trop d\'agrumes :':
      'Too many citrus fruits:',
  'acidifient le compost et ralentissent la décomposition.':
      'they make the compost acidic and slow down decomposition.',
  'Excréments animaux :':
      'Animal droppings:',
  'risques sanitaires importants (parasites, bactéries).':
      'significant health risks (parasites, bacteria).',
  'Gain de temps au jardin':
      'Saving time in the garden',
  'Plus de récolte, moins d\'effort':
      'More harvest, less effort',
  'Un potager qui demande peu de temps existe : il suffit de choisir les bonnes pratiques dès le départ. Organisation et choix malins valent mieux que des heures de travail.':
      'A veg patch that takes little time does exist: you just have to pick good habits from the start. Smart organisation and smart choices beat hours of work.',
  'Les automatismes à mettre en place':
      'Habits to set up',
  'Paillage permanent 🍂':
      'Permanent mulch 🍂',
  'Couvre toujours le sol : moins d\'arrosage, moins de désherbage, moins de travail. C\'est LE geste qui change tout.':
      'Always keep the soil covered: less watering, less weeding, less work. This is THE habit that changes everything.',
  'Goutte à goutte programmé 💧':
      'Timed drip watering 💧',
  'Un tuyau poreux avec un programmateur mécanique. 30 minutes le soir, et tu n\'y penses plus.':
      'A porous hose with a mechanical timer. 30 minutes in the evening and you can forget about it.',
  'Compost à proximité 🧱':
      'Compost close by 🧱',
  'Place ton composteur le plus près possible du potager. Moins de trajets = plus de régularité.':
      'Put your compost bin as close to the veg patch as possible. Shorter trips mean more regular use.',
  'Outils près du potager 🧰':
      'Tools near the patch 🧰',
  'Un petit rangement sur place avec les essentiels : sécateur, griffe, arrosoir. Tu gagnes 10 minutes à chaque passage.':
      'A small storage spot on site with the essentials: secateurs, hand cultivator, watering can. You save 10 minutes every visit.',
  'Choix des plantes':
      'Choosing your plants',
  'Vivaces en priorité 🌿':
      'Perennials first 🌿',
  'Rhubarbe, artichaut, oseille, ciboulette : on plante une fois, on récolte pendant des années.':
      'Rhubarb, artichoke, sorrel, chives: plant once, harvest for years.',
  'Variétés faciles 💪':
      'Easy varieties 💪',
  'Courgette, haricot, radis, tomate cerise : des valeurs sûres qui produisent sans souci.':
      'Courgette, bean, radish, cherry tomato: reliable choices that produce without fuss.',
  'Salades à couper ✂️':
      'Cut-and-come-again salads ✂️',
  'Mesclun, roquette, mâche : tu coupes les feuilles, elles repoussent. Jusqu\'à 4 récoltes par semis.':
      'Mixed leaves, rocket, lamb\'s lettuce: you cut the leaves and they grow back. Up to 4 harvests from one sowing.',
  'Engrais verts 🌾':
      'Green manures 🌾',
  'Trèfle, phacélie, moutarde : ils couvrent le sol, nourrissent la terre et empêchent les mauvaises herbes.':
      'Clover, phacelia, mustard: they cover the soil, feed the earth and keep weeds down.',
  'Routine efficace':
      'An efficient routine',
  '15 minutes par jour ⏱️':
      '15 minutes a day ⏱️',
  'Un quart d\'heure quotidien vaut mieux que 3 heures le dimanche. Tu repères vite les problèmes.':
      'A quarter of an hour every day beats 3 hours on Sunday. You spot problems quickly.',
  'Le matin tôt 🌅':
      'Early morning 🌅',
  'Le matin, les limaces sont visibles, la terre est fraîche, et toi tu es motivé. C\'est le meilleur créneau.':
      'In the morning, slugs are easy to see, the soil is cool and you are motivated. It is the best time slot.',
  'Outils ergonomiques 🛠️':
      'Ergonomic tools 🛠️',
  'Un bon outil à la bonne taille évite la fatigue. La grelinette remplace le motoculteur et le bêchage.':
      'A good tool of the right size prevents tiredness. A broadfork replaces the rotavator and digging.',
  'Planning saisonnier 📅':
      'Seasonal planning 📅',
  'Note quand semer et quand récolter. Kultiva t\'aide avec son calendrier, mais un tableau au mur marche aussi.':
      'Note when to sow and when to harvest. Kultiva helps you with its calendar, but a chart on the wall works too.',
  'Délègue à la nature 🌍':
      'Let nature do the work 🌍',
  'Laisse les coccinelles gérer les pucerons, les vers de terre aérer le sol. Moins tu interviens, mieux ça pousse.':
      'Let ladybirds deal with the aphids and earthworms loosen the soil. The less you step in, the better it grows.',
  'Le secret des jardiniers efficaces : ne pas chercher la perfection. Un potager un peu sauvage est souvent plus productif qu\'un jardin impeccable.':
      'The secret of efficient gardeners: do not chase perfection. A slightly wild veg patch is often more productive than a spotless garden.',
  'Voir trop grand au début :':
      'Thinking too big at the start:',
  '10 m² bien gérés produisent plus que 50 m² abandonnés en juillet.':
      '10 m² well looked after produces more than 50 m² abandoned by July.',
  'Retourner la terre chaque année :':
      'Digging over the soil every year:',
  'ça détruit la vie du sol. Préfère la grelinette ou le paillage permanent.':
      'it destroys soil life. Prefer a broadfork or permanent mulch.',
  'Courir après les problèmes :':
      'Chasing problems:',
  'la prévention (paillage, rotation, associations) évite 80% des soucis.':
      'prevention (mulch, rotation, companions) avoids 80% of troubles.',
  'Tout nettoyer en automne :':
      'Tidying everything in autumn:',
  'les résidus de culture protègent le sol et nourrissent les vers de terre.':
      'crop residues protect the soil and feed the earthworms.',
  'Arrosage goutte à goutte':
      'Drip irrigation',
  'Économe, automatique et efficace':
      'Economical, automatic and effective',
  'Le goutte à goutte délivre l\'eau directement au pied des plants, en petite quantité et lentement. Il économise 30 à 50% d\'eau et évite les maladies foliaires.':
      'Drip irrigation delivers water straight to the base of your plants, slowly and in small amounts. It saves 30 to 50% of water and prevents leaf diseases.',
  'Installer son système':
      'Setting up your system',
  'Choisis le bon kit':
      'Choose the right kit',
  'Un tuyau principal de 16 mm, des goutteurs réglables (2 à 8 L/h), des raccords en T et un filtre à tamis. Prévois un réducteur de pression si tu branches sur le réseau.':
      'A 16 mm main pipe, adjustable drippers (2 to 8 L/h), T-connectors and a mesh filter. Add a pressure reducer if you connect to the mains.',
  'Planifie ton circuit':
      'Plan your layout',
  'Dessine ton potager et le trajet du tuyau. Prévois un goutteur par plant pour les tomates et courgettes, et un tuyau poreux pour les lignes de salades.':
      'Draw your veg patch and the route of the pipe. Allow one dripper per plant for tomatoes and courgettes, and a porous hose for rows of lettuce.',
  'Connecte le réseau':
      'Connect the network',
  'Branche le filtre puis le réducteur de pression sur le robinet. Déroule le tuyau principal et perce-le aux emplacements des goutteurs.':
      'Connect the filter, then the pressure reducer, to the tap. Unroll the main pipe and punch holes where the drippers will go.',
  'Règle le débit':
      'Set the flow',
  'Ouvre le robinet et ajuste chaque goutteur. Vérifie que l\'eau perle lentement (une goutte par seconde environ) et que tous les goutteurs fonctionnent.':
      'Turn on the tap and adjust each dripper. Check that the water beads out slowly (about one drop per second) and that every dripper works.',
  'Programme un minuteur':
      'Set a timer',
  'Un programmateur à pile sur le robinet te permet d\'automatiser. Programme un arrosage tôt le matin ou en soirée, 30 à 60 minutes selon tes plants.':
      'A battery-powered timer on the tap lets you automate things. Set watering for early morning or evening, 30 to 60 minutes depending on your plants.',
  'Adapter à chaque légume':
      'Adapt to each vegetable',
  'Goutteurs':
      'Drippers',
  'Durée':
      'Duration',
  '1 × 4 L/h':
      '1 × 4 L/h',
  '45 min':
      '45 min',
  '1 × 8 L/h':
      '1 × 8 L/h',
  '30 min':
      '30 min',
  'Tuyau poreux':
      'Porous hose',
  '20 min':
      '20 min',
  '40 min':
      '40 min',
  '1 × 2 L/h':
      '1 × 2 L/h',
  'Combine goutte à goutte et paillage : tu peux descendre à 1 seul arrosage par semaine sur les tomates, même en plein été.':
      'Combine drip irrigation with mulch and you can get down to just 1 watering a week on tomatoes, even in midsummer.',
  'Oublier le filtre :':
      'Forgetting the filter:',
  'les goutteurs se bouchent très vite avec le calcaire et les impuretés de l\'eau.':
      'drippers clog up very quickly with limescale and impurities in the water.',
  'Négliger le réducteur de pression :':
      'Skipping the pressure reducer:',
  'la pression du réseau (3-5 bars) fait éclater les raccords. Le goutte à goutte fonctionne à 1-1,5 bar.':
      'mains pressure (3-5 bar) bursts the connectors. Drip irrigation works at 1-1.5 bar.',
  'Arroser trop peu de temps :':
      'Watering for too short a time:',
  '10 minutes ne suffisent pas, l\'eau reste en surface. Préfère 30-60 minutes à faible débit.':
      '10 minutes is not enough, the water stays at the surface. Prefer 30-60 minutes at a low flow.',
  'Oublier la purge hivernale :':
      'Forgetting the winter drain:',
  'vidange tout le circuit avant les gelées pour éviter que les tuyaux n\'éclatent.':
      'empty the whole system before the frosts so the pipes do not burst.',
  'Jardiner avec la lune':
      'Gardening by the moon',
  'Le':
      'The lunar',
  'calendrier':
      'calendar',
  'lunaire au potager':
      'in the veg patch',
  'Jardiner avec la lune, c\'est tenir compte de ses cycles pour optimiser semis, plantation, récolte et taille.':
      'Gardening by the moon means taking its cycles into account to get the best from sowing, planting, harvesting and pruning.',
  'Les deux cycles importants':
      'The two key cycles',
  'Lune montante / descendante 🌗':
      'Rising / falling moon 🌗',
  'Cycle de 27 jours lié à la position de la lune dans le ciel. Montante = la sève monte (semer, greffer). Descendante = la sève descend (planter, tailler, récolter).':
      'A 27-day cycle linked to the moon\'s position in the sky. Rising = sap rises (sow, graft). Falling = sap sinks (plant, prune, harvest).',
  'Lune croissante / décroissante 🌓':
      'Waxing / waning moon 🌓',
  'Cycle de 29,5 jours lié à la lumière visible. Croissante = de la nouvelle lune à la pleine lune (vitalité). Décroissante = de la pleine lune à la nouvelle lune (conservation).':
      'A 29.5-day cycle linked to the visible light. Waxing = new moon to full moon (vitality). Waning = full moon to new moon (keeping).',
  'Que faire à chaque phase':
      'What to do in each phase',
  'Lune montante 🌒':
      'Rising moon 🌒',
  'Semer, greffer, récolter les fruits et les légumes-feuilles. La sève monte dans les parties aériennes.':
      'Sow, graft, harvest fruit and leafy vegetables. The sap rises into the parts above ground.',
  'Lune descendante 🌘':
      'Falling moon 🌘',
  'Planter, bouturer, tailler, enrichir le sol. La sève redescend vers les racines.':
      'Plant, take cuttings, prune, enrich the soil. The sap goes back down to the roots.',
  'Lune croissante 🌓':
      'Waxing moon 🌓',
  'Les plantes sont plus résistantes. Bon moment pour récolter des fruits qui se conservent longtemps.':
      'Plants are hardier. A good time to harvest fruit that will keep for a long time.',
  'Lune décroissante 🌗':
      'Waning moon 🌗',
  'Les parfums et saveurs sont renforcés. Idéal pour récolter les aromatiques et faire des conserves.':
      'Scents and flavours are stronger. Ideal for harvesting herbs and for preserving.',
  'Selon la partie cultivée':
      'By the part you grow',
  'Partie':
      'Part',
  'Phase idéale':
      'Best phase',
  'Action':
      'Action',
  '🥕 Racines':
      '🥕 Roots',
  'Lune descendante':
      'Falling moon',
  'Planter, récolter':
      'Plant, harvest',
  '🥬 Feuilles':
      '🥬 Leaves',
  'Lune montante':
      'Rising moon',
  'Semer, récolter':
      'Sow, harvest',
  '🌸 Fleurs':
      '🌸 Flowers',
  'Semer, cueillir':
      'Sow, pick',
  '🍅 Fruits/graines':
      '🍅 Fruit/seeds',
  '✂️ Tailler':
      '✂️ Pruning',
  'Taille douce':
      'Light pruning',
  '🧱 Compost':
      '🧱 Compost',
  'Retourner, épandre':
      'Turn, spread',
  'Les jours à éviter':
      'Days to avoid',
  'Nœuds lunaires':
      'Lunar nodes',
  'Quand la lune croise le plan de l\'orbite terrestre. Évite de jardiner 5h avant et après.':
      'When the moon crosses the plane of the Earth\'s orbit. Avoid gardening for 5 hours before and after.',
  'Périgée et apogée':
      'Perigee and apogee',
  'Quand la lune est au plus près ou au plus loin de la Terre. Les plantes sont perturbées.':
      'When the moon is closest to or furthest from the Earth. Plants are unsettled.',
  '12h avant/après pleine ou nouvelle lune':
      '12 hours before/after a full or new moon',
  'Période de transition défavorable. Profites-en pour planifier, nettoyer tes outils ou préparer tes semences.':
      'An unfavourable transition period. Use it to plan, clean your tools or prepare your seeds.',
  'Ne te stresse pas avec les jours défavorables : si tu ne peux jardiner que le week-end, fais-le ! Mieux vaut jardiner au « mauvais » moment que pas du tout.':
      'Do not stress about unfavourable days: if you can only garden at weekends, go for it! Gardening at the "wrong" time beats not gardening at all.',
  'Suivre le calendrier lunaire à la lettre :':
      'Following the lunar calendar to the letter:',
  'c\'est un guide, pas une obligation. Adapte-le à ta réalité.':
      'it is a guide, not a duty. Adapt it to your real life.',
  'Confondre montante/croissante :':
      'Mixing up rising and waxing:',
  'ce sont deux cycles différents qui se superposent.':
      'they are two different cycles that overlap.',
  'Reporter indéfiniment un semis :':
      'Putting off a sowing indefinitely:',
  'la fenêtre saisonnière compte plus que la phase lunaire.':
      'the seasonal window matters more than the moon phase.',
  'Jardiner en saison sèche':
      'Gardening in the dry season',
  'Chaque goutte d\'eau compte':
      'Every drop of water counts',
  'En saison sèche, le soleil tape fort et l\'eau devient précieuse. Avec un paillage épais, un arrosage malin et un peu d\'ombre, ton potager peut rester vert même quand la pluie se fait attendre. 💪':
      'In the dry season, the sun beats down and water becomes precious. With a thick mulch, smart watering and a little shade, your veg patch can stay green even when the rain is slow to come. 💪',
  'Économiser chaque goutte':
      'Saving every drop',
  'Paille épais 🍂':
      'Thick mulch 🍂',
  'Couvre le sol de 10 à 15 cm d\'herbes sèches, feuilles mortes, tiges de mil ou de maïs. Le paillage garde la fraîcheur et divise les arrosages par deux.':
      'Cover the soil with 10 to 15 cm of dry grass, dead leaves, millet or maize stalks. Mulch keeps the soil cool and halves your watering.',
  'Arrose au pied, matin ou soir 🌅':
      'Water at the base, morning or evening 🌅',
  'Verse l\'eau directement au pied des plants, tôt le matin ou au coucher du soleil. En pleine journée, la moitié de l\'eau s\'évapore avant d\'atteindre les racines.':
      'Pour water straight at the base of the plants, early in the morning or at sunset. In the middle of the day, half the water evaporates before it reaches the roots.',
  'Enterre un canari (oya) 🏺':
      'Bury a clay pot (oya) 🏺',
  'Enterre un pot en terre cuite non vernissée jusqu\'au col, remplis-le d\'eau et pose un couvercle. L\'eau traverse doucement la paroi et abreuve les racines pendant plusieurs jours.':
      'Bury an unglazed terracotta pot up to its neck, fill it with water and put a lid on. The water seeps slowly through the wall and feeds the roots for several days.',
  'Creuse zaï et demi-lunes 🌙':
      'Dig zaï pits and half-moons 🌙',
  'De petites cuvettes (zaï) ou des demi-lunes de terre en aval de la pente captent l\'eau d\'arrosage et des rares pluies. Dépose du compost au fond : c\'est un garde-manger pour tes plants.':
      'Small pits (zaï) or half-moon banks of earth on the downhill side catch irrigation water and the rare rains. Put compost at the bottom: it is a pantry for your plants.',
  'Offre de l\'ombre ⛱️':
      'Offer some shade ⛱️',
  'Un filet d\'ombrage, des palmes tressées ou des cultures hautes (maïs, manioc) protègent les légumes fragiles du soleil de midi.':
      'Shade netting, woven palm leaves or tall crops (maize, cassava) protect delicate vegetables from the midday sun.',
  '« Un binage vaut deux arrosages » : gratte légèrement la surface du sol entre deux arrosages. Tu casses les petits canaux par lesquels l\'eau s\'évapore, et l\'humidité reste en profondeur.':
      '"One hoeing is worth two waterings": lightly scratch the soil surface between waterings. You break the tiny channels through which water evaporates, and moisture stays deep down.',
  'Arroser en pleine journée :':
      'Watering in the middle of the day:',
  'l\'eau s\'évapore avant de servir, et les gouttes sur les feuilles peuvent les brûler.':
      'the water evaporates before it does any good, and droplets on the leaves can scorch them.',
  'Les petits arrosages de surface :':
      'Light surface watering:',
  'ils rendent les racines paresseuses. Mieux vaut arroser copieusement 2-3 fois par semaine que un peu tous les jours.':
      'it makes roots lazy. It is better to water generously 2-3 times a week than a little every day.',
  'Laisser le sol nu :':
      'Leaving the soil bare:',
  'un sol à découvert sèche, durcit et se fissure. Couvre-le toujours, même d\'une fine couche.':
      'bare soil dries out, hardens and cracks. Always cover it, even with a thin layer.',
  'Forcer sur l\'engrais :':
      'Overdoing the fertiliser:',
  'en pleine chaleur, les plants stressés absorbent mal. Un sol paillé et un peu de compost suffisent.':
      'in full heat, stressed plants take it up poorly. Mulched soil and a little compost are enough.',
  'Lutter contre les limaces':
      'Fighting slugs',
  'Maladies & Nuisibles':
      'Diseases & Pests',
  'Protéger ses jeunes plants':
      'Protecting your young plants',
  'Les limaces sont actives la nuit par temps humide. Elles dévorent en priorité les jeunes plants et les salades.':
      'Slugs are active at night in damp weather. They go first for young plants and lettuces.',
  'Reconnaître les dégâts':
      'Spotting the damage',
  'Jeunes plants sectionnés':
      'Young plants cut off',
  'Les plantules sont coupées net au ras du sol, souvent en une seule nuit. Les semis disparaissent mystérieusement.':
      'Seedlings are cut cleanly at ground level, often in a single night. Your seedlings vanish mysteriously.',
  'Feuilles trouées irrégulièrement':
      'Leaves with ragged holes',
  'Les trous ont des bords arrondis et irréguliers, contrairement aux découpures nettes des chenilles.':
      'The holes have rounded, uneven edges, unlike the clean cuts made by caterpillars.',
  'Traces brillantes':
      'Shiny trails',
  'Des traînées de mucus argenté sur les feuilles et le sol trahissent le passage des limaces et escargots.':
      'Silvery streaks of slime on leaves and soil give away slugs and snails.',
  'Les méthodes efficaces':
      'Methods that work',
  'Ramassage nocturne 🔦':
      'Night patrols 🔦',
  'Sors avec une lampe frontale 1h après la tombée de la nuit. Ramasse les limaces à la main et éloigne-les du potager.':
      'Go out with a head torch 1 hour after dark. Pick up the slugs by hand and take them away from the veg patch.',
  'Barrières naturelles':
      'Natural barriers',
  'Entoure les plants de coquilles d\'œufs concassées, de cendres de bois ou de marc de café. Renouvelle après la pluie.':
      'Surround your plants with crushed eggshells, wood ash or coffee grounds. Renew them after rain.',
  'Pièges à bière 🍺':
      'Beer traps 🍺',
  'Enterre un récipient au ras du sol et remplis-le de bière. Les limaces y tombent attirées par la levure.':
      'Sink a container level with the ground and fill it with beer. Slugs fall in, drawn by the yeast.',
  'Favorise les prédateurs 🦔':
      'Encourage predators 🦔',
  'Accueille les hérissons, crapauds, carabes et orvets. Un tas de bois ou un point d\'eau les attirent au jardin.':
      'Welcome hedgehogs, toads, ground beetles and slow worms. A log pile or a water point will draw them to the garden.',
  'Ferramol':
      'Ferramol',
  'Ce produit à base de phosphate de fer est autorisé en bio. Les limaces cessent de s\'alimenter après ingestion.':
      'This iron phosphate product is allowed in organic gardening. Slugs stop feeding after eating it.',
  'Le ramassage nocturne à la frontale reste la méthode la plus efficace. Une sortie régulière les soirs humides réduit drastiquement la population.':
      'Night patrols with a head torch remain the most effective method. A regular outing on damp evenings cuts the population drastically.',
  'Paillage épais humide :':
      'Thick, damp mulch:',
  'un paillis trop épais et constamment humide offre un refuge idéal aux limaces.':
      'a mulch that is too thick and constantly wet is an ideal hideout for slugs.',
  'Anti-limaces chimiques :':
      'Chemical slug killers:',
  'le métaldéhyde empoisonne aussi les hérissons, les oiseaux et les animaux domestiques.':
      'metaldehyde also poisons hedgehogs, birds and pets.',
  'Sel :':
      'Salt:',
  'le sel tue les limaces mais saline le sol et détruit la vie microbienne. Toxique pour les plantes.':
      'salt kills slugs but makes the soil salty and destroys microbial life. It is toxic to plants.',
  'Repiquer en nuit humide :':
      'Transplanting on a damp night:',
  'les jeunes plants repiqués un soir de pluie sont un festin offert aux limaces.':
      'young plants set out on a rainy evening are a free feast for slugs.',
  'Mildiou':
      'Blight',
  'La maladie fongique du potager':
      'The fungal disease of the veg patch',
  'Le mildiou est un champignon qui prospère par temps chaud et humide. Il peut détruire une récolte de tomates en quelques jours si on ne réagit pas vite.':
      'Blight is a fungal disease that thrives in warm, damp weather. It can wipe out a tomato crop in a few days if you do not act fast.',
  'Reconnaître le mildiou':
      'Spotting blight',
  'Taches jaunes':
      'Yellow patches',
  'Des taches jaune pâle apparaissent sur le dessus des feuilles, souvent entre les nervures. Premier signe d\'alerte.':
      'Pale yellow patches appear on top of the leaves, often between the veins. This is the first warning sign.',
  'Duvet blanchâtre':
      'White fuzz',
  'Un feutrage blanc-grisâtre se développe sous les feuilles, face à la tache jaune. Ce sont les spores du champignon.':
      'A whitish-grey felt grows under the leaves, opposite the yellow patch. These are the fungus\'s spores.',
  'Taches brunes sur fruits':
      'Brown marks on fruit',
  'Les tomates présentent des marbrures brunes et bosselées. Les fruits deviennent impropres à la consommation.':
      'Tomatoes show brown, bumpy marbling. The fruit becomes unfit to eat.',
  'Tiges qui noircissent':
      'Blackening stems',
  'Les tiges prennent une couleur brun-noir et se dessèchent. La plante dépérit rapidement de haut en bas.':
      'Stems turn brown-black and dry out. The plant declines quickly from the top down.',
  'Prévenir avant tout':
      'Prevention comes first',
  'Espace les plants':
      'Space out your plants',
  'Laisse au moins 60 cm entre les pieds de tomates pour permettre une bonne circulation de l\'air.':
      'Leave at least 60 cm between tomato plants so air can circulate well.',
  'Arrose le pied':
      'Water at the base',
  'N\'arrose jamais le feuillage. L\'eau stagnante sur les feuilles est le déclencheur numéro un du mildiou.':
      'Never water the leaves. Standing water on leaves is the number one trigger for blight.',
  'Abrite les tomates':
      'Shelter your tomatoes',
  'Un toit ou un auvent protège les plants de la pluie tout en laissant l\'air circuler sur les côtés.':
      'A roof or canopy keeps the rain off the plants while letting air flow in from the sides.',
  'Paille le sol':
      'Mulch the soil',
  'Le paillage empêche les éclaboussures de terre contaminée sur les feuilles basses lors des arrosages.':
      'Mulch stops contaminated soil from splashing onto the lower leaves when you water.',
  'Pulvérise préventivement':
      'Spray as a precaution',
  'Applique de la bouillie bordelaise ou une décoction de prêle toutes les 2-3 semaines en prévention.':
      'Apply Bordeaux mixture or a horsetail decoction every 2-3 weeks as a preventive.',
  'En cas d\'attaque':
      'If blight strikes',
  'Supprime les feuilles atteintes':
      'Remove affected leaves',
  'Coupe immédiatement toutes les feuilles touchées. Ne les composte pas, brûle-les ou jette-les aux ordures.':
      'Cut off every affected leaf straight away. Do not compost them: burn them or put them in the bin.',
  'Bouillie bordelaise':
      'Bordeaux mixture',
  'Pulvérise un traitement cuivré sur les parties saines pour freiner la propagation. Respecte les dosages.':
      'Spray a copper treatment on the healthy parts to slow the spread. Follow the doses.',
  'Si tout est atteint : arrache':
      'If everything is affected: pull it up',
  'Quand la maladie a envahi tout le plant, arrache-le pour protéger les voisins. Récolte les fruits encore sains.':
      'When the disease has taken over the whole plant, pull it up to protect its neighbours. Pick the fruit that is still healthy.',
  'Choisis des variétés résistantes : Fantasio, Maestria, Crimson Crush. Elles ne sont pas immunisées mais résistent bien mieux aux attaques.':
      'Choose resistant varieties: Fantasio, Maestria, Crimson Crush. They are not immune, but they stand up to attacks much better.',
  'Arroser par aspersion :':
      'Overhead watering:',
  'l\'eau sur les feuilles crée les conditions idéales pour le mildiou.':
      'water on the leaves creates ideal conditions for blight.',
  'Laisser les feuilles malades :':
      'Leaving diseased leaves in place:',
  'chaque feuille atteinte produit des milliers de spores qui contaminent les voisins.':
      'each affected leaf produces thousands of spores that infect its neighbours.',
  'Composter les plants malades :':
      'Composting diseased plants:',
  'le mildiou survit dans le compost et recontaminera le jardin l\'année suivante.':
      'blight survives in compost and will infect the garden again next year.',
  'Serrer les plants :':
      'Crowding plants:',
  'le manque d\'aération entre les pieds favorise l\'humidité et la propagation rapide.':
      'poor airflow between plants encourages damp and rapid spread.',
  'Paillage':
      'Mulching',
  'Protéger et nourrir la terre':
      'Protect and feed the soil',
  'Le paillage, c\'est recouvrir le sol de matière organique. Il garde l\'humidité, limite les mauvaises herbes, nourrit le sol en se décomposant et protège la vie souterraine.':
      'Mulching means covering the soil with organic matter. It holds moisture, keeps weeds down, feeds the soil as it breaks down and protects life underground.',
  'Quels matériaux choisir':
      'Which materials to choose',
  'Feuilles mortes 🍂':
      'Dead leaves 🍂',
  'Gratuites et abondantes en automne. Se décomposent lentement et enrichissent le sol en humus. Idéal partout.':
      'Free and plentiful in autumn. They break down slowly and enrich the soil with humus. Ideal everywhere.',
  'Tonte de gazon 🌿':
      'Grass clippings 🌿',
  'Riche en azote, se décompose vite. À étaler en couche fine (2-3 cm) et séchée pour éviter la fermentation.':
      'Rich in nitrogen, they break down fast. Spread in a thin layer (2-3 cm) and dried first to avoid fermentation.',
  'BRF (Bois Raméal Fragmenté) 🌳':
      'Chipped branch wood (BRF) 🌳',
  'Branches broyées de moins de 7 cm de diamètre. Excellent pour les allées et les arbustes. Dure longtemps.':
      'Shredded branches under 7 cm in diameter. Excellent for paths and shrubs. Lasts a long time.',
  'Paille 🌾':
      'Straw 🌾',
  'Légère, aérée et facile à poser. Parfaite pour les fraisiers, tomates et courgettes. Attention aux graines de céréales.':
      'Light, airy and easy to lay. Perfect for strawberries, tomatoes and courgettes. Watch out for cereal seeds.',
  'Carton brun 📦':
      'Brown cardboard 📦',
  'Sans encre ni scotch. Excellent pour étouffer les herbes avant de créer une nouvelle parcelle. Recouvre de paillis.':
      'No ink or tape. Excellent for smothering weeds before you make a new bed. Cover it with mulch.',
  'Comment bien pailler':
      'How to mulch well',
  'Désherbe avant de pailler':
      'Weed before you mulch',
  'Retire les mauvaises herbes existantes. Le paillage empêche les nouvelles mais n\'élimine pas celles en place.':
      'Remove the weeds already there. Mulch stops new ones but does not get rid of those already in place.',
  'Arrose le sol':
      'Water the soil',
  'Paille toujours sur un sol humide. L\'eau pénètre moins bien à travers une couche de paillis sec.':
      'Always mulch on damp soil. Water gets through a layer of dry mulch less easily.',
  'Étale une couche de 5 à 10 cm':
      'Spread a layer of 5 to 10 cm',
  'Trop fin, le paillis est inefficace. Trop épais, il peut étouffer les jeunes plants et favoriser les limaces.':
      'Too thin, and mulch does not work. Too thick, and it can smother young plants and favour slugs.',
  'Dégage le collet des plants':
      'Keep the crown of the plants clear',
  'Laisse 2-3 cm d\'espace autour des tiges pour éviter la pourriture au contact du paillis humide.':
      'Leave 2-3 cm of space around the stems to avoid rot from contact with damp mulch.',
  'Renouvelle régulièrement':
      'Top it up regularly',
  'Le paillis se décompose et nourrit le sol. Rajoute une couche dès qu\'il s\'amincit sous les 3-4 cm.':
      'Mulch breaks down and feeds the soil. Add a new layer as soon as it thins below 3-4 cm.',
  'En hiver, pense au paillage épais (20-30 cm de feuilles). Il protège le sol du gel, abrite les auxiliaires et se transforme en humus pour le printemps.':
      'In winter, think of a thick mulch (20-30 cm of leaves). It protects the soil from frost, shelters helpful insects and turns into humus for spring.',
  'Limaces sous le paillis :':
      'Slugs under the mulch:',
  'en cas d\'invasion, écarte le paillis temporairement et pose des pièges à bière.':
      'if they invade, pull the mulch back for a while and set beer traps.',
  'Tonte fraîche en couche épaisse :':
      'Fresh clippings in a thick layer:',
  'elle fermente, chauffe et peut brûler les racines. Sèche-la d\'abord.':
      'they ferment, heat up and can burn the roots. Dry them first.',
  'Pailler sur des semis :':
      'Mulching over seedlings:',
  'les graines ont besoin de lumière et de chaleur pour germer. Attends que les plants aient 10 cm.':
      'seeds need light and warmth to germinate. Wait until the plants are 10 cm tall.',
  'Carton imprimé ou plastifié :':
      'Printed or plastic-coated cardboard:',
  'les encres et revêtements contiennent des substances nocives pour le sol.':
      'inks and coatings contain substances that harm the soil.',
  'Potager en balcon':
      'Balcony veg garden',
  'Jardiner sans jardin':
      'Gardening without a garden',
  'Un balcon bien exposé peut produire salades, tomates cerises, fraises, herbes aromatiques et bien plus. Il suffit de bons contenants, du soleil et un arrosage régulier.':
      'A well-placed balcony can produce salad leaves, cherry tomatoes, strawberries, herbs and much more. All you need are good containers, sun and regular watering.',
  'Évaluer son balcon':
      'Assess your balcony',
  'Plein sud (6h+ de soleil)':
      'Full south (6+ hours of sun)',
  'Idéal pour tomates, poivrons, courgettes, fraises et la plupart des légumes-fruits gourmands en lumière.':
      'Ideal for tomatoes, peppers, courgettes, strawberries and most light-hungry fruiting vegetables.',
  'Mi-ombre (3-5h de soleil)':
      'Partial shade (3-5 hours of sun)',
  'Parfait pour salades, épinards, radis, herbes aromatiques et légumes-feuilles qui tolèrent l\'ombre partielle.':
      'Perfect for lettuce, spinach, radishes, herbs and leafy vegetables that tolerate partial shade.',
  'Ombragé (moins de 3h)':
      'Shady (less than 3 hours)',
  'Limité aux herbes d\'ombre (menthe, ciboulette, persil) et à quelques salades résistantes.':
      'Limited to shade herbs (mint, chives, parsley) and a few hardy salad leaves.',
  'Les bases du succès':
      'The basics of success',
  'Bons contenants':
      'Good containers',
  'Minimum 20 cm de profondeur pour les salades, 40 cm pour les tomates. Choisis des pots en terre cuite, plastique épais ou tissu géotextile.':
      'At least 20 cm deep for lettuce, 40 cm for tomatoes. Choose terracotta, thick plastic or fabric grow bags.',
  'Drainage indispensable':
      'Drainage is essential',
  'Chaque pot doit avoir des trous de drainage. Place des billes d\'argile au fond sur 2-3 cm pour éviter que les racines ne baignent.':
      'Every pot needs drainage holes. Put a 2-3 cm layer of clay pebbles at the bottom so roots do not sit in water.',
  'Terreau enrichi':
      'Enriched potting compost',
  'Utilise un terreau de qualité mélangé à du compost. Les pots offrent peu de volume : la terre doit être riche dès le départ.':
      'Use good-quality potting compost mixed with garden compost. Pots hold little soil, so it has to be rich from the start.',
  'Arrosage régulier':
      'Regular watering',
  'En été, arrose tous les jours, voire matin et soir en canicule. Le terreau en pot sèche beaucoup plus vite qu\'en pleine terre.':
      'In summer, water every day, even morning and evening in a heatwave. Potting compost dries out much faster than soil in the ground.',
  'Fertilise toutes les 2 semaines':
      'Feed every 2 weeks',
  'L\'arrosage fréquent lessive les nutriments. Apporte un engrais organique liquide (purin d\'ortie, engrais bio) régulièrement.':
      'Frequent watering washes out nutrients. Add a liquid organic fertiliser (nettle feed, organic fertiliser) regularly.',
  'Top 8 pour petit balcon':
      'Top 8 for a small balcony',
  'Plante':
      'Plant',
  'Contenant':
      'Container',
  '🍅 Tomate cerise':
      '🍅 Cherry tomato',
  'Pot 30 cm, profond':
      '30 cm pot, deep',
  'Jardinière 20 cm':
      '20 cm window box',
  '🌿 Basilic':
      '🌿 Basil',
  'Pot 15 cm':
      '15 cm pot',
  'Pot suspendu 25 cm':
      '25 cm hanging pot',
  '🔴 Radis':
      '🔴 Radish',
  'Jardinière 15 cm':
      '15 cm window box',
  '🌶️ Piment':
      '🌶️ Chilli',
  'Pot 25 cm':
      '25 cm pot',
  '🌱 Ciboulette':
      '🌱 Chives',
  '🌿 Menthe':
      '🌿 Mint',
  'Pot isolé 20 cm':
      'Separate 20 cm pot',
  'Les tomates cerises comme \'Tumbling Tom\' sont spécialement adaptées aux pots. Elles retombent en cascade et produisent abondamment tout l\'été.':
      'Cherry tomatoes like \'Tumbling Tom\' are specially suited to pots. They trail down in cascades and crop heavily all summer.',
  'Ignorer le vent :':
      'Ignoring the wind:',
  'en étage, le vent dessèche les plants et casse les tiges. Installe un brise-vent ou protège les pots.':
      'on upper floors, wind dries plants out and snaps stems. Set up a windbreak or shelter the pots.',
  'Pots en métal noir :':
      'Black metal pots:',
  'ils surchauffent au soleil et brûlent les racines. Préfère la terre cuite ou le plastique clair.':
      'they overheat in the sun and burn the roots. Prefer terracotta or pale plastic.',
  'Oublier d\'arroser :':
      'Forgetting to water:',
  'un pot au soleil peut sécher en quelques heures. Un oubli d\'un jour suffit à perdre un plant.':
      'a pot in the sun can dry out within hours. Missing one day is enough to lose a plant.',
  'Pot trop petit :':
      'A pot that is too small:',
  'un volume insuffisant limite les racines, stresse la plante et réduit la récolte à presque rien.':
      'too little room limits the roots, stresses the plant and cuts the harvest to almost nothing.',
  'Potager en carrés':
      'Square-foot gardening',
  'Méthode simple et productive':
      'A simple, productive method',
  'Le potager en carrés divise l\'espace en carrés de 30 cm, chacun dédié à un légume. C\'est la méthode idéale pour produire beaucoup sur peu d\'espace.':
      'Square-foot gardening divides the space into 30 cm squares, each given over to one vegetable. It is the ideal method for growing a lot in a small space.',
  'Le principe':
      'The principle',
  'Un carré de 1,20 x 1,20 m':
      'A 1.20 x 1.20 m square',
  'Divisé en 16 cases de 30 x 30 cm. Cette taille permet d\'atteindre chaque case sans marcher sur la terre.':
      'Divided into 16 squares of 30 x 30 cm. This size lets you reach every square without stepping on the soil.',
  'Un légume par case':
      'One vegetable per square',
  'Chaque case accueille un seul type de légume, en respectant la densité adaptée à l\'espèce.':
      'Each square holds a single type of vegetable, planted at the right density for the species.',
  'Hauteur de 15 à 30 cm':
      '15 to 30 cm high',
  'Suffisant pour la plupart des légumes. Un cadre en bois maintient la terre et délimite clairement l\'espace.':
      'Enough for most vegetables. A wooden frame holds the soil in and marks out the space clearly.',
  'Rotation case par case':
      'Rotate square by square',
  'Quand une case est récoltée, replante un légume d\'une famille différente. Cela évite l\'épuisement du sol.':
      'When a square is harvested, replant it with a vegetable from a different family. This stops the soil from wearing out.',
  'Densité par case (30x30 cm)':
      'Density per square (30x30 cm)',
  '1 pied':
      '1 plant',
  '4 plants':
      '4 plants',
  '16 graines':
      '16 seeds',
  '🧄 Ail':
      '🧄 Garlic',
  '9 gousses':
      '9 cloves',
  '9 bulbes':
      '9 bulbs',
  '9 graines':
      '9 seeds',
  '🌿 Persil':
      '🌿 Parsley',
  'Mettre en place son carré':
      'Setting up your square',
  'Choisir un emplacement ensoleillé':
      'Choose a sunny spot',
  'Minimum 6 heures de soleil par jour. Place le carré sur une surface plane, de préférence orientée sud.':
      'At least 6 hours of sun a day. Put the bed on level ground, ideally facing south.',
  'Construire le cadre':
      'Build the frame',
  'Utilise des planches de bois non traité (15 à 30 cm de haut). Assemble-les en carré de 1,20 m de côté.':
      'Use untreated wooden boards (15 to 30 cm high). Join them into a square with 1.20 m sides.',
  'Diviser en 16 cases':
      'Divide it into 16 squares',
  'Utilise des tasseaux, de la ficelle ou des lattes pour marquer les 16 cases de 30 x 30 cm.':
      'Use battens, string or laths to mark the 16 squares of 30 x 30 cm.',
  'Remplir de bon terreau':
      'Fill with good soil',
  'Mélange terreau, compost et terre de jardin à parts égales pour un substrat riche et drainant.':
      'Mix potting compost, garden compost and garden soil in equal parts for a rich, free-draining growing medium.',
  'Planter selon la densité':
      'Plant to the right density',
  'Respecte le nombre de plants par case. Ne surcharge pas : chaque légume a besoin d\'espace pour se développer.':
      'Stick to the number of plants per square. Do not overcrowd: every vegetable needs room to grow.',
  'La méthode des carrés est parfaite pour débuter. Elle permet de produire une grande variété de légumes sur moins de 2 m² et de comprendre les bases du potager.':
      'The square method is perfect for beginners. It lets you grow a wide variety of vegetables in under 2 m² and learn the basics of the veg patch.',
  'Surcharger les cases :':
      'Overcrowding the squares:',
  'trop de plants se font concurrence et aucun ne se développe correctement.':
      'too many plants compete with each other and none of them grows properly.',
  'Replanter la même famille :':
      'Replanting the same family:',
  'sans rotation, le sol s\'épuise et les maladies s\'installent.':
      'without rotation, the soil wears out and disease sets in.',
  'Oublier l\'arrosage :':
      'Forgetting to water:',
  'les petits volumes de terre sèchent vite, surtout en été.':
      'small volumes of soil dry out fast, especially in summer.',
  'Négliger le remplissage :':
      'Skimping on the filling:',
  'un terreau pauvre donne des légumes chétifs. Enrichis avec du compost chaque saison.':
      'poor soil gives puny vegetables. Enrich it with compost every season.',
  'Potager surélevé':
      'Raised bed vegetable garden',
  'Cultiver sans se baisser':
      'Growing without bending down',
  'Le potager surélevé permet de jardiner debout, sans mal au dos. Il offre un contrôle total sur la qualité de la terre et réduit les adventices.':
      'A raised bed lets you garden standing up, without a sore back. It gives you full control over soil quality and cuts down on weeds.',
  'Les avantages':
      'The advantages',
  'Confort':
      'Comfort',
  'Jardiner debout ou assis, sans se pencher. Idéal pour les personnes à mobilité réduite ou souffrant du dos.':
      'Garden standing or sitting, without bending. Ideal for people with reduced mobility or back problems.',
  'Terre maîtrisée':
      'Soil you control',
  'Tu choisis ta terre : pas de sol pollué, pas d\'argile lourde. Un mélange parfait dès le départ.':
      'You choose your soil: no polluted ground, no heavy clay. A perfect mix from the start.',
  'Réchauffe vite':
      'Warms up fast',
  'La terre en hauteur se réchauffe plus vite au printemps, ce qui avance les semis de plusieurs semaines.':
      'Soil raised off the ground warms up faster in spring, which brings your sowings forward by several weeks.',
  'Moins de nuisibles':
      'Fewer pests',
  'En hauteur, les limaces et escargots ont plus de mal à atteindre tes cultures.':
      'Up high, slugs and snails have a harder time reaching your crops.',
  'Construire son bac':
      'Building your bed',
  'Dimensions idéales':
      'Ideal dimensions',
  'Largeur 1,20 m maximum pour atteindre le centre sans entrer dedans. Hauteur de 60 à 90 cm pour un confort optimal.':
      'Maximum width 1.20 m so you can reach the middle without stepping in. Height of 60 to 90 cm for the best comfort.',
  'Matériaux':
      'Materials',
  'Privilégie le bois non traité (mélèze, douglas, châtaignier) pour éviter les produits chimiques au contact de la terre.':
      'Prefer untreated wood (larch, Douglas fir, sweet chestnut) to avoid chemicals touching the soil.',
  'Drainage obligatoire':
      'Drainage is a must',
  'Place une couche de graviers ou de billes d\'argile au fond, puis un feutre géotextile pour éviter que la terre ne s\'écoule.':
      'Put a layer of gravel or clay pebbles at the bottom, then geotextile fabric so the soil does not wash out.',
  'Remplissage en lasagne':
      'Lasagne filling',
  'Alterne couches de matières brunes (bois, carton) et vertes (tonte, compost). Termine par 20 cm de terre végétale enrichie.':
      'Alternate layers of brown material (wood, cardboard) and green (clippings, compost). Finish with 20 cm of enriched topsoil.',
  'Laisser reposer':
      'Let it settle',
  'Attends 2 à 4 semaines avant de planter pour que les couches commencent à se décomposer et que la terre se tasse.':
      'Wait 2 to 4 weeks before planting so the layers start to break down and the soil settles.',
  'Le bac surélevé sèche plus vite qu\'un sol classique. Pense à pailler généreusement et à arroser régulièrement, surtout en été.':
      'A raised bed dries out faster than ordinary ground. Remember to mulch generously and water regularly, especially in summer.',
  'Bois traité :':
      'Treated wood:',
  'les produits chimiques migrent dans la terre et contaminent tes légumes.':
      'the chemicals leach into the soil and contaminate your vegetables.',
  'Profondeur insuffisante :':
      'Not deep enough:',
  'moins de 40 cm limite le développement des racines et assèche vite le substrat.':
      'less than 40 cm limits root growth and dries the growing medium out quickly.',
  'Pas de drainage :':
      'No drainage:',
  'sans évacuation d\'eau, les racines pourrissent et les plants meurent.':
      'without a way for water to escape, roots rot and plants die.',
  'Emplacement ombragé :':
      'A shady spot:',
  'les légumes ont besoin de 6 à 8 heures de soleil. Un bac à l\'ombre ne produira presque rien.':
      'vegetables need 6 to 8 hours of sun. A bed in the shade will produce almost nothing.',
  'Préparer l\'hivernage':
      'Getting ready for the rainy season',
  'Prêt avant les premières pluies':
      'Ready before the first rains',
  'L\'hivernage, c\'est la saison des pluies : la grande saison de culture ! Le secret, c\'est de tout préparer':
      'The rainy season is the main growing season! The secret is to prepare everything',
  'avant':
      'before',
  'les premières gouttes. Un jardin prêt à temps profite de chaque pluie dès le premier jour. 🌦️':
      'the first drops. A garden that is ready in time makes the most of every rain from day one. 🌦️',
  'Avant les premières pluies':
      'Before the first rains',
  'Nettoie la parcelle 🧹':
      'Clear the plot 🧹',
  'Désherbe, retire les vieux plants et les débris. Les mauvaises herbes profitent des pluies encore plus vite que tes légumes !':
      'Weed, remove old plants and debris. Weeds take advantage of the rains even faster than your vegetables do!',
  'Monte planches, buttes et billons ⛰️':
      'Build beds, mounds and ridges ⛰️',
  'Cultive surélevé : des billons ou des buttes de 20 à 40 cm gardent les racines hors de l\'eau quand les grosses averses arrivent.':
      'Grow on raised ground: ridges or mounds 20 to 40 cm high keep the roots out of the water when the heavy downpours arrive.',
  'Pense au drainage 🚿':
      'Think about drainage 🚿',
  'Creuse de petites rigoles entre les planches pour évacuer l\'excès d\'eau vers l\'extérieur du jardin. Un potager inondé, c\'est des racines qui étouffent.':
      'Dig small channels between the beds to carry excess water out of the garden. A flooded veg patch means roots that suffocate.',
  'Nourris le sol 🪱':
      'Feed the soil 🪱',
  'Incorpore du compost ou du fumier bien décomposé dans les buttes. Les pluies feront descendre les nutriments pile au niveau des racines.':
      'Work compost or well-rotted manure into the mounds. The rains will carry the nutrients down right to the roots.',
  'Prépare tes semences 🌰':
      'Prepare your seeds 🌰',
  'Trie tes graines, garde les plus belles et jette celles qui sont abîmées ou moisies. Tout doit être prêt pour semer dès que la pluie s\'installe.':
      'Sort your seeds, keep the best ones and throw out any that are damaged or mouldy. Everything must be ready to sow as soon as the rain sets in.',
  'À semer dès les premières pluies':
      'To sow from the first rains',
  'Niébé':
      'Cowpea',
  'Le haricot local, costaud et généreux. Il enrichit même le sol en azote pour les cultures suivantes.':
      'The local bean: tough and generous. It even enriches the soil with nitrogen for the next crops.',
  'Sème en poquets de 2-3 graines dès que la terre est bien humide sur 10 cm de profondeur.':
      'Sow 2-3 seeds per hole as soon as the soil is damp to 10 cm deep.',
  'Gombo':
      'Okra',
  'Fais tremper les graines une nuit avant de semer : elles germeront deux fois plus vite.':
      'Soak the seeds overnight before sowing: they will germinate twice as fast.',
  'Arachide':
      'Groundnut',
  'Sème en lignes sur les billons, dans un sol léger et bien drainé. Elle aussi nourrit le sol en azote.':
      'Sow in rows on the ridges, in light, well-drained soil. It also feeds the soil with nitrogen.',
  'Ne sème pas tout à la première averse ! Attends 2-3 bonnes pluies rapprochées : c\'est le signe que la saison est vraiment installée. Et échelonne tes semis sur plusieurs semaines pour étaler les récoltes.':
      'Do not sow everything at the first shower! Wait for 2-3 good rains close together: it is the sign that the season has really set in. And stagger your sowings over several weeks to spread out the harvests.',
  'Semer à plat en zone inondable :':
      'Sowing flat in a flood-prone area:',
  'sans buttes ni billons, une seule grosse averse peut noyer tous tes semis.':
      'without mounds or ridges, a single heavy downpour can drown all your seedlings.',
  'Ignorer les maladies fongiques :':
      'Ignoring fungal diseases:',
  'chaleur + humidité = paradis des champignons. Espace bien les plants, évite de mouiller le feuillage et retire vite les feuilles tachées.':
      'heat + damp = fungus paradise. Space plants well, avoid wetting the leaves and quickly remove spotted ones.',
  'Laisser les herbes gagner :':
      'Letting the weeds win:',
  'en hivernage, elles poussent à toute vitesse. Un petit désherbage chaque semaine vaut mieux qu\'un grand chantier chaque mois.':
      'in the rainy season they grow at full speed. A little weeding every week beats a big job every month.',
  'Oublier limaces et escargots :':
      'Forgetting slugs and snails:',
  'la pluie les réveille. Surveille les jeunes plants, surtout les premiers soirs humides.':
      'the rain wakes them up. Keep an eye on young plants, especially on the first damp evenings.',
  'Préparer le sol':
      'Preparing the soil',
  'La base de toute culture réussie':
      'The foundation of every good crop',
  'Un bon sol de potager est meuble, riche en matière organique, bien drainé et vivant.':
      'Good veg patch soil is loose, rich in organic matter, well drained and alive.',
  'Connaître son sol':
      'Know your soil',
  'Argileux':
      'Clay',
  'Terre collante et lourde. Retient bien l\'eau mais se compacte. Ajoute du sable et du compost pour l\'alléger.':
      'Sticky, heavy soil. Holds water well but compacts. Add sand and compost to lighten it.',
  'Sableux':
      'Sandy',
  'Terre légère qui filtre vite l\'eau. Sèche rapidement. Enrichis avec du compost et du paillage pour retenir l\'humidité.':
      'Light soil that drains fast. Dries out quickly. Enrich it with compost and mulch to hold moisture.',
  'Limoneux':
      'Silty',
  'Terre douce et fertile, idéale pour le potager. Attention à la croûte de battance en surface après la pluie.':
      'Soft, fertile soil, ideal for the veg patch. Watch for a hard surface crust after rain.',
  'Calcaire':
      'Chalky',
  'Terre claire et caillouteuse, pH élevé. Certains nutriments sont bloqués. Apporte du compost acide et du soufre.':
      'Pale, stony soil with a high pH. Some nutrients get locked up. Add acidic compost and sulphur.',
  'La préparation en 6 étapes':
      'Preparation in 6 steps',
  'Désherbe':
      'Weed',
  'Retire les mauvaises herbes à la main ou à la binette. Ne laisse pas les racines traînantes.':
      'Remove weeds by hand or with a hoe. Do not leave trailing roots behind.',
  'Décompacte sans retourner':
      'Loosen without turning',
  'Utilise une grelinette pour aérer en profondeur sans perturber la vie du sol.':
      'Use a broadfork to aerate deeply without disturbing soil life.',
  'Apporte du compost':
      'Add compost',
  'Étale 3 à 5 cm de compost mûr en surface. Les vers feront le travail d\'incorporation.':
      'Spread 3 to 5 cm of ripe compost over the surface. The worms will work it in for you.',
  'Ajuste le pH':
      'Adjust the pH',
  'Le potager aime un pH entre 6 et 7. Trop acide ? Ajoute de la chaux. Trop basique ? Du soufre ou du compost acide.':
      'The veg patch likes a pH between 6 and 7. Too acidic? Add lime. Too alkaline? Add sulphur or acidic compost.',
  'Affine en surface':
      'Fine-tune the surface',
  'Passe un râteau pour casser les mottes et obtenir une surface plane et fine, prête à recevoir les semis.':
      'Run a rake over it to break up clods and get a flat, fine surface, ready for sowing.',
  'Paille ou sème un engrais vert':
      'Mulch or sow a green manure',
  'Couvre le sol nu avec du paillage ou un engrais vert (moutarde, phacélie) pour le protéger et le nourrir.':
      'Cover bare soil with mulch or a green manure (mustard, phacelia) to protect and feed it.',
  'Pour connaître ton sol : fais un boudin avec de la terre humide dans ta main. S\'il tient, c\'est argileux. S\'il s\'effrite, c\'est sableux. S\'il est souple et doux, c\'est limoneux.':
      'To find out what your soil is: roll a sausage of damp soil in your hand. If it holds together, it is clay. If it crumbles, it is sandy. If it is supple and smooth, it is silty.',
  'Retourner la terre au motoculteur :':
      'Rotavating the soil:',
  'détruit la structure du sol et la vie microbienne.':
      'it destroys soil structure and microbial life.',
  'Travailler un sol détrempé :':
      'Working waterlogged soil:',
  'tu compactes la terre et crées des mottes impossibles à défaire.':
      'you compact the earth and create clods that are impossible to break up.',
  'il se dessèche, s\'érode et perd sa matière organique.':
      'it dries out, erodes and loses its organic matter.',
  'Abuser des amendements chimiques :':
      'Overusing chemical soil improvers:',
  'ils déséquilibrent la vie du sol à long terme.':
      'they unbalance soil life in the long run.',
  'Pucerons':
      'Aphids',
  'Les suceurs de sève':
      'The sap suckers',
  'Les pucerons sucent la sève des jeunes pousses et affaiblissent les plantes. Ils se reproduisent très vite mais ont beaucoup de prédateurs naturels.':
      'Aphids suck the sap from young shoots and weaken plants. They breed very fast, but they have plenty of natural predators.',
  'Identifier les pucerons':
      'Identifying aphids',
  'Colonies':
      'Colonies',
  'Des grappes de petits insectes verts, noirs ou roses s\'agglutinent sur les tiges tendres et sous les feuilles.':
      'Clusters of tiny green, black or pink insects crowd onto tender stems and under leaves.',
  'Miellat collant':
      'Sticky honeydew',
  'Les pucerons excrètent un liquide sucré et collant qui recouvre les feuilles et attire un champignon noir : la fumagine.':
      'Aphids excrete a sweet, sticky liquid that coats leaves and attracts a black fungus: sooty mould.',
  'Feuilles déformées':
      'Distorted leaves',
  'Les feuilles s\'enroulent, se crispent et se déforment. Les jeunes pousses sont rabougries et les bourgeons avortent.':
      'Leaves curl, crinkle and twist out of shape. Young shoots are stunted and buds fail.',
  'Fourmis':
      'Ants',
  'Les fourmis élèvent les pucerons pour récolter leur miellat. Leur va-et-vient sur les tiges est un signe révélateur.':
      'Ants farm aphids to collect their honeydew. Their comings and goings on the stems are a telltale sign.',
  'Solutions naturelles':
      'Natural solutions',
  'Jet d\'eau':
      'Jet of water',
  'Un simple jet d\'eau puissant décroche les pucerons des tiges. Répète tous les 2-3 jours sur les petites colonies.':
      'A simple strong jet of water knocks aphids off the stems. Repeat every 2-3 days on small colonies.',
  'Savon noir':
      'Black soap',
  'Dilue 3 cuillères à soupe de savon noir liquide dans 1 litre d\'eau tiède. Pulvérise sur et sous les feuilles.':
      'Dilute 3 tablespoons of liquid black soap in 1 litre of lukewarm water. Spray on and under the leaves.',
  'Purin d\'ortie':
      'Nettle feed',
  'Dilué à 5%, le purin d\'ortie renforce les plantes et repousse les pucerons. Pulvérise tous les 10 jours.':
      'Diluted to 5%, nettle feed strengthens plants and repels aphids. Spray every 10 days.',
  'Prédateurs 🐞':
      'Predators 🐞',
  'Attire les coccinelles, syrphes et chrysopes en laissant des zones fleuries. Une larve de coccinelle mange 150 pucerons par jour.':
      'Attract ladybirds, hoverflies and lacewings by leaving flowery areas. One ladybird larva eats 150 aphids a day.',
  'Associations répulsives':
      'Repellent companions',
  'Plante de la lavande, de la menthe, du basilic ou des capucines près des cultures sensibles. Les pucerons détestent leurs odeurs.':
      'Plant lavender, mint, basil or nasturtiums near sensitive crops. Aphids hate their smell.',
  'Les coccinelles et leurs larves mangent des centaines de pucerons par jour. Installe un hôtel à insectes et laisse quelques zones sauvages pour les accueillir.':
      'Ladybirds and their larvae eat hundreds of aphids a day. Put up a bug hotel and leave a few wild areas to welcome them.',
  'Insecticides chimiques :':
      'Chemical insecticides:',
  'ils tuent aussi les coccinelles et les syrphes, tes meilleurs alliés contre les pucerons.':
      'they also kill ladybirds and hoverflies, your best allies against aphids.',
  'Trop d\'azote :':
      'Too much nitrogen:',
  'un excès d\'engrais azoté produit des pousses tendres qui attirent massivement les pucerons.':
      'too much nitrogen fertiliser produces tender shoots that attract aphids in droves.',
  'Paniquer :':
      'Panicking:',
  'quelques pucerons ne sont pas graves. Laisse le temps aux prédateurs naturels d\'intervenir avant de traiter.':
      'a few aphids are no big deal. Give natural predators time to step in before you treat.',
  'Ignorer les fourmis :':
      'Ignoring ants:',
  'tant que les fourmis protègent les pucerons, les prédateurs ne pourront pas faire leur travail.':
      'as long as ants protect the aphids, predators cannot do their job.',
  'Quand arroser ?':
      'When to water?',
  'Choisir le bon moment de la journée':
      'Choosing the right time of day',
  'Le meilleur moment pour arroser, c\'est quand le sol est frais et que l\'eau ne s\'évaporera pas tout de suite. Le soir en été, le matin en mi-saison, et peu souvent en hiver.':
      'The best time to water is when the soil is cool and the water will not evaporate straight away. Evening in summer, morning in spring and autumn, and rarely in winter.',
  'Le bon créneau selon la saison':
      'The right slot for each season',
  'Arrose le matin. Les nuits sont encore fraîches et l\'humidité du soir favorise les maladies.':
      'Water in the morning. Nights are still cool, and evening damp encourages disease.',
  'Arrose le soir, après 19h. Le sol a le temps d\'absorber sans que l\'eau ne s\'évapore.':
      'Water in the evening, after 19h. The soil has time to absorb the water before it evaporates.',
  'Matin uniquement. Les nuits deviennent froides et l\'humidité stagnante fait pourrir les plants.':
      'Morning only. Nights turn cold and standing damp makes plants rot.',
  'Très rarement, en milieu de journée par temps doux. Jamais en période de gel.':
      'Very rarely, in the middle of the day in mild weather. Never during frost.',
  'Les signes que tes plants ont soif':
      'Signs your plants are thirsty',
  'Feuilles qui tombent en fin de journée':
      'Leaves drooping at the end of the day',
  'Les feuilles ramollissent et pendent vers le bas, surtout en fin d\'après-midi quand la chaleur est au maximum.':
      'Leaves go soft and hang down, especially late in the afternoon when the heat is at its peak.',
  'Terre craquelée en surface':
      'Cracked soil on the surface',
  'Le sol se fissure et devient dur. L\'eau aura du mal à pénétrer : arrose doucement pour réhumidifier progressivement.':
      'The soil splits and goes hard. Water will struggle to soak in: water gently to re-moisten it gradually.',
  'Feuilles qui jaunissent par le bas':
      'Leaves yellowing from the bottom',
  'La plante sacrifie ses feuilles basses pour économiser l\'eau. C\'est un signal de stress hydrique avancé.':
      'The plant sacrifices its lower leaves to save water. It is a sign of advanced water stress.',
  'Fruits qui s\'arrêtent de grossir':
      'Fruit that stops swelling',
  'Sans eau suffisante, la plante stoppe la production de fruits pour concentrer ses ressources sur sa survie.':
      'Without enough water, the plant stops producing fruit to concentrate its resources on survival.',
  'Par forte chaleur (+30°C), un arrosage de 20 mm vaut mieux que deux arrosages de 10 mm. L\'eau descend plus profond et résiste mieux à l\'évaporation.':
      'In strong heat (+30°C), one 20 mm watering is better than two 10 mm waterings. The water goes deeper and resists evaporation better.',
  'Arroser entre 11h et 17h l\'été :':
      'Watering between 11h and 17h in summer:',
  'l\'eau s\'évapore avant d\'atteindre les racines et le choc thermique abîme les plants.':
      'the water evaporates before it reaches the roots, and the thermal shock harms the plants.',
  'Arroser par temps de gel :':
      'Watering in frosty weather:',
  'l\'eau gèle au contact des racines et peut les détruire.':
      'the water freezes around the roots and can destroy them.',
  'Arroser juste avant la pluie :':
      'Watering just before rain:',
  'tu gaspilles de l\'eau et tu risques de noyer les plants avec un double apport.':
      'you waste water and risk drowning the plants with a double dose.',
  'Arroser à heure fixe sans regarder la terre :':
      'Watering at a fixed time without looking at the soil:',
  'chaque jour est différent, observe le sol avant de décider.':
      'every day is different, so check the soil before you decide.',
  'Quand récolter ?':
      'When to harvest?',
  'Reconnaître le bon moment':
      'Recognising the right moment',
  'Chaque légume a ses signes de maturité bien précis : couleur, taille, fermeté, odeur. Récolté au bon moment, il est plus savoureux et se conserve mieux.':
      'Every vegetable has its own clear signs of ripeness: colour, size, firmness, smell. Picked at the right time, it tastes better and keeps longer.',
  'Les signes à surveiller':
      'Signs to watch for',
  'Délai':
      'Time to harvest',
  'Signe de maturité':
      'Sign of ripeness',
  '2-3 mois':
      '2-3 months',
  'Couleur pleine, légère souplesse':
      'Full colour, slightly soft',
  '2 mois':
      '2 months',
  '15-20 cm, peau brillante':
      '15-20 cm, glossy skin',
  '3-4 mois':
      '3-4 months',
  'Collet visible, 2-3 cm diamètre':
      'Crown visible, 2-3 cm across',
  '6-8 sem':
      '6-8 wk',
  'Pomme bien formée, avant la montée':
      'Well-formed head, before bolting',
  'Gousse ferme, avant durcissement':
      'Firm pod, before it toughens',
  '3 mois':
      '3 months',
  'Couleur finale, chair ferme':
      'Final colour, firm flesh',
  '🌽 Maïs':
      '🌽 Sweetcorn',
  'Barbes brunes, jus laiteux au grain':
      'Brown silks, milky juice in the kernel',
  '5-6 mois':
      '5-6 months',
  'Feuillage tombé et sec':
      'Foliage fallen and dry',
  'Les bons gestes':
      'Good habits',
  'Récolte tôt le matin 🌅':
      'Harvest early in the morning 🌅',
  'Les légumes sont gorgés de fraîcheur après la nuit, avant que la chaleur ne les ramollisse.':
      'Vegetables are full of freshness after the night, before the heat softens them.',
  'Utilise un couteau propre 🔪':
      'Use a clean knife 🔪',
  'Une coupe nette évite de blesser la plante et limite les risques de maladie.':
      'A clean cut avoids wounding the plant and limits the risk of disease.',
  'Manipule avec douceur 🤲':
      'Handle gently 🤲',
  'Les chocs et les pressions abîment les fruits et accélèrent le pourrissement.':
      'Knocks and pressure bruise fruit and speed up rotting.',
  'Ramasse souvent 📅':
      'Pick often 📅',
  'Récolter régulièrement stimule la plante à produire davantage de fruits.':
      'Harvesting regularly encourages the plant to produce more fruit.',
  'Garde 2 cm de pédoncule 🌱':
      'Keep 2 cm of stalk 🌱',
  'Laisser un bout de tige protège le fruit et améliore sa conservation.':
      'Leaving a bit of stem protects the fruit and helps it keep.',
  'Goûte régulièrement une petite partie pour apprendre à reconnaître la maturité par le goût.':
      'Taste a small piece regularly to learn to recognise ripeness by flavour.',
  'Attendre trop longtemps :':
      'Waiting too long:',
  'les légumes deviennent fibreux, amers ou éclatent sur le plant.':
      'vegetables turn stringy, bitter or split on the plant.',
  'Récolter sous la pluie :':
      'Harvesting in the rain:',
  'l\'humidité favorise les moisissures et réduit la conservation.':
      'damp encourages mould and shortens storage life.',
  'Tirer sur le plant :':
      'Pulling on the plant:',
  'tu risques d\'arracher les racines ou de casser la tige principale.':
      'you risk tearing out the roots or snapping the main stem.',
  'Laver avant stockage :':
      'Washing before storing:',
  'l\'humidité accélère le pourrissement. Lave juste avant de consommer.':
      'damp speeds up rotting. Wash just before eating.',
  'Quand semer ?':
      'When to sow?',
  'des principaux légumes':
      'for the main vegetables',
  'Chaque légume a sa période idéale. Le bon timing dépend de la température du sol et du risque de gelées.':
      'Every vegetable has its ideal season. The right timing depends on soil temperature and the risk of frost.',
  'Calendrier des semis':
      'Sowing calendar',
  'J':
      'J',
  'F':
      'F',
  'M':
      'M',
  'A':
      'A',
  'S':
      'S',
  'O':
      'O',
  'D':
      'D',
  'Les grands repères':
      'Key milestones',
  'Février - Mars':
      'February - March',
  'Semis en intérieur des légumes du soleil (tomates, poivrons, aubergines). Patience, il fait encore froid dehors.':
      'Sow sun-loving vegetables (tomatoes, peppers, aubergines) indoors. Be patient, it is still cold outside.',
  'Avril':
      'April',
  'Les premiers semis en pleine terre : carottes, radis, salades. Le sol se réchauffe progressivement.':
      'The first sowings in open ground: carrots, radishes, lettuce. The soil warms up gradually.',
  'Mi-mai':
      'Mid-May',
  'Après les Saints de Glace, tout peut sortir ! Courgettes, haricots, courges rejoignent le potager.':
      'After the Ice Saints (the traditional last frosts in France), everything can go out! Courgettes, beans and squashes join the veg patch.',
  'Août - Septembre':
      'August - September',
  'Semis d\'automne : mâche, épinards, oignons, engrais verts. Le jardin ne s\'arrête jamais vraiment.':
      'Autumn sowings: lamb\'s lettuce, spinach, onions, green manures. The garden never really stops.',
  'Décale tes semis de 2-3 semaines pour les légumes à croissance rapide (radis, salade). Tu étaleras ainsi tes récoltes au lieu de tout avoir en même temps.':
      'Stagger your sowings by 2-3 weeks for fast-growing vegetables (radishes, lettuce). That way your harvests are spread out instead of all arriving at once.',
  'Semer avant les dernières gelées :':
      'Sowing before the last frosts:',
  'une nuit de gel suffit à détruire des semis fragiles en pleine terre.':
      'a single frosty night is enough to destroy fragile seedlings in open ground.',
  'Tout semer en même temps :':
      'Sowing everything at once:',
  'tu te retrouveras débordé au repiquage et à la récolte.':
      'you will be swamped at transplanting and harvest time.',
  'Ignorer sa zone climatique :':
      'Ignoring your climate zone:',
  'les dates varient selon ta région, adapte le calendrier à ton climat local.':
      'dates vary with your region, so adapt the calendar to your local climate.',
  'Ne pas noter les dates :':
      'Not noting the dates:',
  'sans suivi, impossible de savoir ce qui a marché ou quand replanter l\'an prochain.':
      'without records, you cannot tell what worked or when to replant next year.',
  'Récolter les aromatiques':
      'Harvesting herbs',
  'Pour un maximum de saveur':
      'For maximum flavour',
  'Les aromatiques se récoltent au moment où leurs huiles essentielles sont les plus concentrées.':
      'Herbs are harvested when their essential oils are at their most concentrated.',
  'Quand cueillir chaque plante':
      'When to pick each plant',
  'Quand':
      'When',
  'Avant floraison':
      'Before flowering',
  'Sommets des tiges':
      'Stem tips',
  'Toute saison':
      'Any season',
  'Tiges extérieures':
      'Outer stems',
  '🌿 Ciboulette':
      '🌿 Chives',
  'Dès 15 cm':
      'From 15 cm',
  'Tiges à la base':
      'Stems at the base',
  'Jeunes pousses':
      'Young shoots',
  '🌿 Thym':
      '🌿 Thyme',
  'Début floraison':
      'Start of flowering',
  'Rameaux feuillus':
      'Leafy sprigs',
  '🌿 Romarin':
      '🌿 Rosemary',
  'Toute l\'année':
      'All year round',
  'Extrémités de branches':
      'Branch tips',
  '💜 Lavande':
      '💜 Lavender',
  'Tiges florales':
      'Flower stems',
  'Récolte le matin après la rosée 🌅':
      'Harvest in the morning after the dew 🌅',
  'Les huiles essentielles sont au maximum en fin de matinée, quand la rosée a séché mais avant la grosse chaleur.':
      'Essential oils peak in late morning, once the dew has dried but before the heat of the day.',
  'Coupe au-dessus d\'un nœud ✂️':
      'Cut just above a node ✂️',
  'La plante repart plus facilement à partir d\'un nœud. Utilise des ciseaux propres et aiguisés.':
      'The plant regrows more easily from a node. Use clean, sharp scissors.',
  'Ne prélève jamais plus d\'un tiers':
      'Never take more than a third',
  'Laisser au moins deux tiers du feuillage permet à la plante de se régénérer rapidement.':
      'Leaving at least two thirds of the foliage lets the plant recover quickly.',
  'Supprime les fleurs régulièrement 🌸':
      'Remove flowers regularly 🌸',
  'Pincer les fleurs empêche la montée en graines et prolonge la production de feuilles aromatiques.':
      'Pinching out the flowers stops it going to seed and keeps the aromatic leaves coming for longer.',
  'Sèche ou congèle vite':
      'Dry or freeze quickly',
  'Les aromatiques perdent vite leur arôme. Fais sécher en bouquets suspendus ou congèle dans de l\'huile d\'olive.':
      'Herbs lose their aroma fast. Dry them in hanging bunches or freeze them in olive oil.',
  'Pour le basilic : pince régulièrement le sommet des tiges.':
      'For basil: pinch out the tops of the stems regularly.',
  'Récolter après la pluie :':
      'Harvesting after rain:',
  'les feuilles mouillées perdent leurs arômes et sèchent mal.':
      'wet leaves lose their aroma and dry badly.',
  'Laisser fleurir trop longtemps :':
      'Letting them flower too long:',
  'les feuilles deviennent amères et la plante s\'épuise.':
      'the leaves turn bitter and the plant wears itself out.',
  'Couper au ras du sol :':
      'Cutting right down to the ground:',
  'la plante ne peut plus repartir et meurt rapidement.':
      'the plant cannot regrow and soon dies.',
  'Stocker dans un sac fermé :':
      'Storing in a sealed bag:',
  'l\'humidité emprisonnée provoque moisissures et perte de saveur.':
      'trapped moisture causes mould and loss of flavour.',
  'Récolter les racines':
      'Harvesting root vegetables',
  'Sans les casser ni les abîmer':
      'Without breaking or bruising them',
  'Les légumes-racines se récoltent avec précaution pour éviter les blessures.':
      'Root vegetables need careful harvesting to avoid damage.',
  'La méthode étape par étape':
      'The step-by-step method',
  'Arrose la veille 💧':
      'Water the day before 💧',
  'Une terre humide est plus souple et libère les racines sans les casser.':
      'Damp soil is looser and lets the roots out without snapping them.',
  'Enfonce la fourche à 15 cm du plant':
      'Push the fork in 15 cm from the plant',
  'Garde de la distance pour ne pas transpercer la racine. Utilise une fourche-bêche, jamais une bêche plate.':
      'Keep your distance so you do not pierce the root. Use a digging fork, never a flat spade.',
  'Soulève en levier 💪':
      'Lever it up 💪',
  'Bascule la fourche doucement pour soulever la terre et la racine ensemble, sans forcer.':
      'Rock the fork gently to lift the soil and the root together, without forcing it.',
  'Tire délicatement par le feuillage':
      'Pull gently by the leaves',
  'Une fois la terre soulevée, saisis le collet et tire droit vers le haut sans tordre.':
      'Once the soil is lifted, grip the crown and pull straight up without twisting.',
  'Laisse sécher au sol 1-2 h ☀️':
      'Leave to dry on the ground for 1-2 h ☀️',
  'La terre restante sèche et se détache facilement. Ne lave pas les racines si tu veux les stocker longtemps.':
      'The remaining soil dries and falls off easily. Do not wash the roots if you want to store them for a long time.',
  'Spécificités par légume':
      'Tips for each vegetable',
  'Récolte quand le collet dépasse de 2-3 cm. Ameublis bien la terre avant pour les sortir entières. Coupe les fanes à 1 cm pour le stockage.':
      'Harvest when the crown sticks out by 2-3 cm. Loosen the soil well beforehand so they come out whole. Cut the tops to 1 cm for storage.',
  'Betterave':
      'Beetroot',
  'Taille idéale : 8-10 cm de diamètre. Ne coupe pas la racine pivotante, elle « saigne » et perd son jus. Tords les fanes plutôt que les couper.':
      'Ideal size: 8-10 cm across. Do not cut the taproot, it "bleeds" and loses its juice. Twist the tops off rather than cutting them.',
  'Pomme de terre':
      'Potato',
  'Attends que le feuillage ait jauni et séché. Fouille à la main après avoir soulevé la terre. Laisse sécher 2-3 h avant de stocker à l\'obscurité.':
      'Wait until the leaves have yellowed and dried. Feel through the soil by hand after lifting it. Leave to dry for 2-3 h before storing in the dark.',
  'Récolte quand les tiges sont tombées et sèches. Arrache à la main et laisse sécher au soleil 2-3 jours avant de tresser ou stocker en filet.':
      'Harvest when the stems have fallen over and dried. Pull by hand and leave to dry in the sun for 2-3 days before plaiting or storing in nets.',
  'Pour les carottes et panais, tu peux les laisser en terre tout l\'hiver.':
      'Carrots and parsnips can stay in the ground all winter.',
  'Bêcher trop près :':
      'Digging too close:',
  'tu risques de trancher la racine et de la rendre impropre au stockage.':
      'you risk slicing the root and making it unfit for storage.',
  'Tirer de force :':
      'Pulling by force:',
  'la racine casse net dans le sol et le bout perdu pourrit sur place.':
      'the root snaps off in the soil and the lost tip rots in place.',
  'l\'humidité provoque la pourriture. Brosse simplement la terre sèche.':
      'damp causes rot. Simply brush off the dry soil.',
  'Laisser au soleil trop longtemps :':
      'Leaving them in the sun too long:',
  'les pommes de terre verdissent et deviennent toxiques en quelques heures.':
      'potatoes turn green and become toxic within a few hours.',
  'Réussir ses semis':
      'Sowing successfully',
  'En godet ou en pleine terre ✨':
      'In pots or in open ground ✨',
  'Un bon semis, c\'est trois choses : la bonne période, un terreau léger et humide, et un peu de patience.':
      'A good sowing comes down to three things: the right time, a light, damp compost, and a little patience.',
  'En godet':
      'In pots',
  'Idéal pour démarrer tôt à l\'abri et contrôler les conditions':
      'Ideal for an early start under cover and for controlling conditions',
  'Pleine terre':
      'Open ground',
  'Direct au jardin, pour les semis robustes et les belles saisons':
      'Straight into the garden, for hardy seeds and the warmer seasons',
  'Semer en godet':
      'Sowing in pots',
  'Pour anticiper la saison en douceur':
      'To get ahead of the season gently',
  'Choisis ton contenant':
      'Choose your container',
  'Godets, pots de yaourt percés ou plaques alvéolées : l\'important, c\'est le trou de drainage.':
      'Small pots, yoghurt pots with holes punched in them, or cell trays: what matters is the drainage hole.',
  'Remplis de terreau':
      'Fill with compost',
  'Utilise un terreau spécial semis, léger et fin. Tasse légèrement sans compacter.':
      'Use a seed compost, light and fine. Firm it down lightly without compacting.',
  'Dépose les graines':
      'Place the seeds',
  '2 à 3 graines par godet, en surface ou enfoncées selon la taille (règle : 2 fois l\'épaisseur de la graine).':
      '2 to 3 seeds per pot, on the surface or pushed in depending on size (rule of thumb: 2 times the thickness of the seed).',
  'Vaporise puis couvre':
      'Mist, then cover',
  'Humidifie au brumisateur et couvre d\'un film ou d\'un couvercle transparent pour maintenir l\'humidité.':
      'Moisten with a mister and cover with film or a clear lid to keep the humidity in.',
  'Place au chaud et à la lumière':
      'Put somewhere warm and bright',
  'Près d\'une fenêtre ou sous une lampe. La chaleur accélère la germination, la lumière évite l\'étiolement.':
      'Near a window or under a lamp. Warmth speeds up germination, and light prevents legginess.',
  'Semer en pleine terre':
      'Sowing in open ground',
  'Direct au jardin, simple et efficace':
      'Straight into the garden, simple and effective',
  'Attends la bonne température':
      'Wait for the right temperature',
  'Le sol doit être assez chaud pour la graine choisie. En cas de doute, utilise un thermomètre de sol.':
      'The soil must be warm enough for the seed you chose. If in doubt, use a soil thermometer.',
  'Prépare ta terre':
      'Prepare your soil',
  'Ameublis la surface sur 5 cm, retire les cailloux et les mottes. Le lit de semences doit être fin et meuble.':
      'Loosen the top 5 cm, remove stones and clods. The seedbed should be fine and crumbly.',
  'Trace tes sillons':
      'Mark out your drills',
  'Avec le manche d\'un outil, trace des lignes à la profondeur adaptée. Respecte l\'espacement indiqué sur le sachet.':
      'Use the handle of a tool to draw lines at the right depth. Follow the spacing on the packet.',
  'Sème et recouvre':
      'Sow and cover',
  'Dépose les graines régulièrement, recouvre de terre fine et tasse légèrement avec le dos de la main.':
      'Drop the seeds evenly, cover with fine soil and firm gently with the back of your hand.',
  'Arrose en pluie fine':
      'Water with a fine spray',
  'Utilise un arrosoir à pomme fine pour ne pas déplacer les graines. Maintiens humide jusqu\'à la levée.':
      'Use a watering can with a fine rose so you do not wash the seeds away. Keep it damp until the seedlings come up.',
  'Note la date de semis sur une petite étiquette. Tu sauras exactement quand la levée est attendue et si tout se passe bien.':
      'Write the sowing date on a small label. You will know exactly when to expect seedlings and whether all is going well.',
  'Arroser trop fort :':
      'Watering too hard:',
  'un jet puissant déplace les graines et compacte la surface du terreau.':
      'a strong jet moves the seeds and compacts the surface of the compost.',
  'Semer trop serré :':
      'Sowing too close:',
  'les plantules se gênent et s\'étiolent en cherchant la lumière.':
      'seedlings crowd each other and get leggy as they reach for light.',
  'Semer trop tôt :':
      'Sowing too early:',
  'sans chaleur suffisante, les graines pourrissent au lieu de germer.':
      'without enough warmth, the seeds rot instead of germinating.',
  'Oublier d\'aérer le film :':
      'Forgetting to air the film:',
  'l\'excès d\'humidité provoque la fonte des semis (moisissure).':
      'too much moisture causes damping off (mould).',
  'Réutiliser ses déchets':
      'Reusing your waste',
  'Le potager zéro déchet':
      'The zero-waste veg patch',
  'Beaucoup de tes déchets de cuisine et de jardin sont de l\'or pour ton potager. Avant de jeter, demande-toi si ça peut nourrir ta terre.':
      'A lot of your kitchen and garden waste is gold for your veg patch. Before you throw something away, ask yourself whether it could feed your soil.',
  'Déchets de cuisine':
      'Kitchen waste',
  'Marc de café ☕':
      'Coffee grounds ☕',
  'Riche en azote, il enrichit le compost et repousse les limaces. Épands-le au pied des plants ou mélange-le à la terre.':
      'Rich in nitrogen, they enrich compost and keep slugs away. Spread them at the base of your plants or mix them into the soil.',
  'Coquilles d\'œufs 🥚':
      'Eggshells 🥚',
  'Broyées finement, elles apportent du calcium et freinent les limaces. Autour des salades, c\'est redoutable.':
      'Crushed finely, they add calcium and slow slugs down. Around lettuces, they are formidable.',
  'Peaux de banane 🍌':
      'Banana skins 🍌',
  'Riches en potassium, elles boostent la floraison. Coupe-les en morceaux et enterre-les au pied des tomates et rosiers.':
      'Rich in potassium, they boost flowering. Cut them into pieces and bury them at the base of tomatoes and roses.',
  'Eau de cuisson 🍲':
      'Cooking water 🍲',
  'L\'eau de cuisson des légumes (non salée !) est un engrais naturel riche en minéraux. Laisse-la refroidir et arrose.':
      'Vegetable cooking water (unsalted!) is a natural fertiliser rich in minerals. Let it cool, then water with it.',
  'Cendres de cheminée 🔥':
      'Fireplace ash 🔥',
  'Riches en potasse et calcium, elles corrigent l\'acidité du sol. Maximum 2 poignées par m² et par an.':
      'Rich in potash and calcium, it corrects soil acidity. A maximum of 2 handfuls per m² per year.',
  'Déchets de jardin':
      'Garden waste',
  'Tonte de gazon 🌱':
      'Grass clippings 🌱',
  'En fine couche (2-3 cm) autour des plants, c\'est un paillage gratuit. Laisse-la sécher avant pour éviter la fermentation.':
      'In a thin layer (2-3 cm) around your plants, they make a free mulch. Let them dry first to avoid fermentation.',
  'Le meilleur paillage d\'hiver. En couche épaisse sur les planches vides, elles protègent et nourrissent le sol.':
      'The best winter mulch. In a thick layer on empty beds, they protect and feed the soil.',
  'Petites branches 🪵':
      'Small branches 🪵',
  'Broyées en BRF (Bois Raméal Fragmenté), elles créent un humus forestier fantastique pour le sol.':
      'Chipped into BRF (chipped branch wood), they make a fantastic forest-style humus for the soil.',
  'Mauvaises herbes 🌾':
      'Weeds 🌾',
  'Avant la montée en graines, elles vont au compost. Le purin d\'ortie est un super engrais et insecticide naturel.':
      'Before they go to seed, they belong in the compost. Nettle feed is a great natural fertiliser and insecticide.',
  'Contenants à recycler':
      'Containers to recycle',
  'Boîtes d\'œufs 🥚':
      'Egg boxes 🥚',
  'Parfaites pour les semis : remplis chaque alvéole de terreau, sème une graine, et plante le tout en terre.':
      'Perfect for seedlings: fill each cup with compost, sow a seed, and plant the whole thing in the ground.',
  'Bouteilles plastique 🍶':
      'Plastic bottles 🍶',
  'Coupées en deux : la partie basse devient pot, la partie haute sert de cloche pour protéger les jeunes plants.':
      'Cut in two: the bottom becomes a pot, and the top acts as a cloche to protect young plants.',
  'Rouleaux de papier toilette 🧻':
      'Toilet roll tubes 🧻',
  'Godets biodégradables parfaits pour les semis de haricots ou tournesols. Tu plantes le rouleau entier en terre.':
      'Biodegradable pots, perfect for sowing beans or sunflowers. You plant the whole tube in the soil.',
  'Cartons bruns 📦':
      'Brown cardboard 📦',
  'Non imprimés, ils servent de paillage anti-mauvaises herbes. Mouille-les et couvre-les de paille ou de tonte.':
      'Unprinted, it works as a weed-suppressing mulch. Wet it and cover it with straw or clippings.',
  'Garde un seau dédié aux épluchures dans la cuisine. En quelques jours, tu as de quoi nourrir ton compost pour une semaine.':
      'Keep a dedicated bucket for peelings in the kitchen. In a few days you have enough to feed your compost for a week.',
  'Composter viande et poisson :':
      'Composting meat and fish:',
  'ça attire les nuisibles et ça sent mauvais. Réserve-les à la poubelle.':
      'it attracts pests and smells bad. Keep them for the bin.',
  'Trop d\'agrumes dans le compost :':
      'Too many citrus fruits in the compost:',
  'ils acidifient et ralentissent la décomposition. Maximum 10% du volume.':
      'they acidify it and slow down decomposition. 10% of the volume at most.',
  'Utiliser des cendres de bois traité :':
      'Using ash from treated wood:',
  'elles contiennent des produits chimiques nocifs pour le sol et les plantes.':
      'it contains chemicals that harm the soil and plants.',
  'Composter les plantes malades :':
      'Composting diseased plants:',
  'les spores survivent et contaminent le futur compost. Brûle-les ou jette-les.':
      'the spores survive and contaminate your future compost. Burn them or bin them.',
  'Semis en intérieur':
      'Sowing indoors',
  'Prendre de l\'avance sur la saison':
      'Getting ahead of the season',
  'Semer en intérieur permet d\'anticiper de 4 à 8 semaines sur la météo extérieure.':
      'Sowing indoors lets you get 4 to 8 weeks ahead of the weather outside.',
  'Les légumes à semer en intérieur':
      'Vegetables to sow indoors',
  'Légumes du soleil':
      'Sun-loving vegetables',
  'Tomates, poivrons, aubergines, piments. Ils ont besoin de chaleur pour germer et d\'un long temps de croissance.':
      'Tomatoes, peppers, aubergines, chillies. They need warmth to germinate and a long growing time.',
  'Cucurbitacées':
      'Cucurbits',
  'Courgettes, concombres, courges. Elles germent vite mais craignent le froid : un départ en intérieur les protège.':
      'Courgettes, cucumbers, squashes. They germinate quickly but fear the cold: starting them indoors protects them.',
  'Salades et choux':
      'Salad leaves and cabbages',
  'Laitues, choux, brocolis. Ils se repiquent facilement et apprécient un démarrage au frais en intérieur.':
      'Lettuces, cabbages, broccoli. They are easy to transplant and appreciate a cool start indoors.',
  'Comment faire':
      'How to do it',
  'Emplacement fenêtre sud':
      'South-facing window',
  'Choisis un rebord de fenêtre exposé plein sud pour un maximum de lumière naturelle (au moins 6h/jour).':
      'Choose a windowsill facing due south for the most natural light (at least 6 hours a day).',
  'Maintiens 18-22°C':
      'Keep it at 18-22°C',
  'La plupart des graines germent dans cette plage. Un tapis chauffant peut aider les espèces frileuses.':
      'Most seeds germinate in this range. A heated mat can help the more tender species.',
  'Surveille l\'humidité':
      'Watch the moisture',
  'Le terreau doit rester humide mais jamais détrempé. Vaporise régulièrement plutôt que d\'arroser abondamment.':
      'The compost should stay damp but never soaked. Mist regularly rather than watering heavily.',
  'Tourne les godets':
      'Turn the pots',
  'Fais un quart de tour chaque jour pour que les plantules poussent droites au lieu de se pencher vers la lumière.':
      'Give them a quarter turn every day so the seedlings grow straight instead of leaning towards the light.',
  'Endurcis avant de planter':
      'Harden off before planting',
  '2 semaines avant le repiquage, sors les plants quelques heures par jour pour les habituer au vent et au soleil direct.':
      '2 weeks before transplanting, take the plants outside for a few hours a day to get them used to wind and direct sun.',
  'Groupe les semis d\'une même famille sur un même plateau. Ils ont les mêmes besoins en température et en arrosage, ce qui simplifie l\'entretien.':
      'Group seedlings of the same family on one tray. They have the same temperature and watering needs, which makes care simpler.',
  'Manque de lumière :':
      'Not enough light:',
  'les plantules filent et s\'étiolent, devenant trop fragiles pour survivre au repiquage.':
      'seedlings stretch and go leggy, becoming too fragile to survive transplanting.',
  'Près d\'un radiateur :':
      'Next to a radiator:',
  'l\'air chaud et sec dessèche le terreau en quelques heures et grille les jeunes pousses.':
      'warm, dry air dries out the compost within hours and scorches young shoots.',
  'Repiquer sans endurcir :':
      'Transplanting without hardening off:',
  'le choc thermique et le vent peuvent tuer un plant habitué au confort intérieur.':
      'thermal shock and wind can kill a plant used to indoor comfort.',
  'les plants deviennent trop grands avant la date de repiquage et végètent dans leurs godets.':
      'plants grow too big before the transplanting date and stagnate in their pots.',
  'Température de germination':
      'Germination temperature',
  'Le thermomètre, le meilleur ami du semeur':
      'The thermometer, a sower\'s best friend',
  'Une graine ne germe que dans une plage de température bien précise. Trop froid, elle dort. Trop chaud, elle souffre.':
      'A seed only germinates within a very specific temperature range. Too cold, it sleeps. Too hot, it suffers.',
  'Les températures idéales':
      'Ideal temperatures',
  'Min. sol':
      'Min. soil',
  'Idéal':
      'Ideal',
  '7°C':
      '7°C',
  '15-20°C':
      '15-20°C',
  '5°C':
      '5°C',
  '15-18°C':
      '15-18°C',
  '🍃 Épinard':
      '🍃 Spinach',
  '4°C':
      '4°C',
  '10-18°C':
      '10-18°C',
  '12°C':
      '12°C',
  '22-26°C':
      '22-26°C',
  '15°C':
      '15°C',
  '24-28°C':
      '24-28°C',
  '🍆 Aubergine':
      '🍆 Aubergine',
  '18°C':
      '18°C',
  '20-25°C':
      '20-25°C',
  '10°C':
      '10°C',
  '18-25°C':
      '18-25°C',
  'Comment mesurer et maintenir':
      'How to measure and maintain it',
  'Utilise un thermomètre de sol':
      'Use a soil thermometer',
  'Enfonce-le à 5 cm de profondeur le matin. C\'est la température la plus basse de la journée, la plus fiable.':
      'Push it 5 cm deep in the morning. That is the lowest temperature of the day, and the most reliable.',
  'Réchauffe avec un voile':
      'Warm up with a fleece',
  'Un voile de forçage ou un tunnel plastique peut gagner 3 à 5°C au niveau du sol.':
      'A forcing fleece or a plastic tunnel can gain 3 to 5°C at ground level.',
  'Utilise un tapis chauffant':
      'Use a heated mat',
  'Pour les semis en intérieur, un tapis chauffant maintient une température constante sous les godets.':
      'For indoor sowings, a heated mat keeps a steady temperature under the pots.',
  'Paille pour réguler':
      'Straw to regulate',
  'En pleine terre, le paillage isole le sol : il garde la chaleur accumulée le jour et protège du froid nocturne.':
      'In open ground, mulch insulates the soil: it keeps the heat built up during the day and protects against the night cold.',
  'Les signes qui ne trompent pas':
      'The signs that do not lie',
  'Trop froid':
      'Too cold',
  'Les graines ne germent pas ou mettent un temps anormalement long. Risque de pourriture dans un sol froid et humide.':
      'Seeds do not germinate or take an unusually long time. Risk of rot in cold, damp soil.',
  'Trop chaud':
      'Too hot',
  'Les plantules filent, s\'affaiblissent et se dessèchent. La germination peut être inhibée au-delà de 35°C.':
      'Seedlings stretch, weaken and dry out. Germination can be inhibited above 35°C.',
  'Température idéale':
      'Ideal temperature',
  'Levée rapide et régulière, plantules trapues et vigoureuses avec de belles premières feuilles.':
      'Quick, even emergence, with sturdy, vigorous seedlings and healthy first leaves.',
  'La température nocturne est souvent plus basse que tu ne crois. Mesure-la pour éviter les mauvaises surprises, surtout au printemps.':
      'Night temperature is often lower than you think. Measure it to avoid nasty surprises, especially in spring.',
  'Se fier à la météo air :':
      'Relying on the air temperature forecast:',
  'la température du sol est souvent 5 à 10°C plus basse que celle de l\'air.':
      'soil temperature is often 5 to 10°C lower than the air.',
  'Surchauffer les semis :':
      'Overheating seedlings:',
  'au-delà de 30°C, beaucoup de graines entrent en dormance forcée.':
      'above 30°C, many seeds go into forced dormancy.',
  'Sol froid et détrempé :':
      'Cold, waterlogged soil:',
  'combinaison fatale qui fait pourrir les graines avant même la germination.':
      'a deadly combination that rots seeds before they even germinate.',
  'Semer au hasard :':
      'Sowing at random:',
  'chaque espèce a ses exigences, vérifier la température évite beaucoup d\'échecs.':
      'each species has its own needs, and checking the temperature avoids many failures.',
  'Traitements bio':
      'Organic treatments',
  'La pharmacie verte du jardinier':
      'The gardener\'s green pharmacy',
  'Les traitements bio s\'appuient sur des plantes, des minéraux ou des bactéries naturelles. Ils respectent la vie du sol et les auxiliaires du jardin.':
      'Organic treatments rely on plants, minerals or natural bacteria. They respect soil life and the helpful creatures in your garden.',
  'Les traitements essentiels':
      'The essential treatments',
  'À base de cuivre, elle prévient mildiou et cloque du pêcher. Applique en préventif, jamais sur des fruits proches de la récolte.':
      'Copper-based, it prevents blight and peach leaf curl. Apply it as a preventive, never on fruit close to harvest.',
  'Soufre':
      'Sulphur',
  'Le soufre mouillable combat l\'oïdium et la tavelure. Pulvérise dès les premiers signes, par temps sec et pas trop chaud.':
      'Wettable sulphur fights powdery mildew and scab. Spray at the first signs, in dry weather that is not too hot.',
  'Insecticide de contact contre pucerons, cochenilles et aleurodes. 3 cuillères à soupe par litre d\'eau tiède suffisent.':
      'A contact insecticide against aphids, scale insects and whiteflies. 3 tablespoons per litre of lukewarm water is enough.',
  'Bacille de Thuringe':
      'Bacillus thuringiensis',
  'Cette bactérie (Bt) est fatale aux chenilles sans nuire aux autres insectes. Idéal contre la piéride du chou.':
      'This bacterium (Bt) is fatal to caterpillars without harming other insects. Ideal against the cabbage white.',
  'Huile de neem':
      'Neem oil',
  'Extraite du margousier, elle agit comme répulsif et perturbateur de croissance sur de nombreux ravageurs.':
      'Extracted from the neem tree, it acts as a repellent and growth disruptor on many pests.',
  'Les purins et décoctions':
      'Feeds and decoctions',
  'Stimulant et répulsif. Dilué à 5% en pulvérisation foliaire, à 10% en arrosage au pied. Fermentation 10-15 jours.':
      'Stimulant and repellent. Diluted to 5% as a leaf spray, to 10% as a watering at the base. Ferment for 10-15 days.',
  'Décoction de prêle':
      'Horsetail decoction',
  'Riche en silice, elle renforce les parois cellulaires des plantes et les protège contre les maladies fongiques.':
      'Rich in silica, it strengthens plant cell walls and protects against fungal diseases.',
  'Purin de consoude':
      'Comfrey feed',
  'Riche en potasse, il booste la floraison et la fructification. Dilué à 10% en arrosage au pied des plants.':
      'Rich in potash, it boosts flowering and fruiting. Diluted to 10% and watered at the base of the plants.',
  'Infusion d\'ail':
      'Garlic infusion',
  'Fais bouillir 5 gousses écrasées dans 1 litre d\'eau. Filtre et pulvérise contre pucerons et maladies fongiques.':
      'Boil 5 crushed cloves in 1 litre of water. Strain and spray against aphids and fungal diseases.',
  'Les règles d\'application':
      'Rules for applying',
  'Toujours le soir':
      'Always in the evening',
  'Pulvérise en fin de journée pour éviter les brûlures au soleil et laisser le produit agir pendant la nuit.':
      'Spray at the end of the day to avoid sun scorch and give the product the night to work.',
  'Pas avant la pluie':
      'Not before rain',
  'Vérifie la météo avant de traiter. La pluie lessive les produits et rend le traitement inutile.':
      'Check the weather before treating. Rain washes products off and makes the treatment pointless.',
  'Respecte les doses':
      'Respect the doses',
  'Bio ne veut pas dire inoffensif. Un excès de cuivre pollue le sol. Suis toujours les dosages recommandés.':
      'Organic does not mean harmless. Too much copper pollutes the soil. Always follow the recommended doses.',
  'Pulvérise dessous ET dessus':
      'Spray under AND over',
  'Les ravageurs et les spores se cachent sous les feuilles. Traite les deux faces pour une efficacité maximale.':
      'Pests and spores hide under the leaves. Treat both sides for maximum effect.',
  'Le meilleur traitement, c\'est la prévention. Un sol vivant, des plantes bien espacées et des associations intelligentes évitent la plupart des problèmes.':
      'The best treatment is prevention. Living soil, well-spaced plants and smart pairings avoid most problems.',
  'Mélanger les produits :':
      'Mixing products:',
  'ne combine jamais bouillie bordelaise et soufre, ou deux traitements différents le même jour.':
      'never combine Bordeaux mixture and sulphur, or two different treatments on the same day.',
  'Traiter en plein soleil :':
      'Treating in full sun:',
  'les produits brûlent les feuilles sous l\'effet de la chaleur et des UV.':
      'products scorch leaves under the effect of heat and UV.',
  'Surdoser :':
      'Overdosing:',
  'doubler la dose ne double pas l\'efficacité. Le cuivre en excès stérilise le sol durablement.':
      'doubling the dose does not double the effect. Excess copper leaves the soil sterile for a long time.',
  'Traiter systématiquement :':
      'Treating as a matter of routine:',
  'ne traite que si nécessaire. Un jardin sain avec des auxiliaires se défend souvent seul.':
      'only treat when necessary. A healthy garden with helpful insects often defends itself.',
  // Le cinquième onglet, ajouté au tuto du dashboard le 02/11/2026.
  'Conservation':
      'Preserving',
};
