/// L'interface de Kultiva, en anglais.
///
/// Clé = la phrase française exacte. Voir `ui_i18n.dart` pour le
/// mécanisme et pour la raison du dictionnaire plutôt que des ARB.
///
/// Les trous `{0}`, `{1}` se replacent librement dans la phrase : c'est
/// pour ça qu'ils sont numérotés plutôt que concaténés. Un trou oublié
/// fait disparaître une valeur calculée, et `test/ui_i18n_test.dart`
/// le refuse.
const Map<String, String> uiTextsEn = <String, String>{
  'toute l\'année':
      'all year round',
  'de {0} à {1}':
      'from {0} to {1}',
  '{0} et {1}':
      '{0} and {1}',
  'aujourd\'hui':
      'today',
  'hier':
      'yesterday',
  'Germination attendue':
      'Expected germination',
  'Levée prévue d\'ici {0} j (germe en moyenne en {1}).':
      'Emergence expected within {0} d (germinates in {1} on average).',
  '{0} j':
      '{0} d',
  'Plantule':
      'Seedling',
  'Premières vraies feuilles. Pince les plus faibles, surveille les limaces.':
      'First true leaves. Pinch out the weakest ones and watch for slugs.',
  'Croissance végétative':
      'Vegetative growth',
  'Le plant prend du volume. Apporte un peu de compost si le feuillage jaunit.':
      'The plant is bulking up. Add a little compost if the foliage turns yellow.',
  'Récolte attendue':
      'Harvest due',
  'Tu peux commencer à récolter. Goûte régulièrement pour repérer le pic de saveur.':
      'You can start harvesting. Taste regularly to catch the peak of flavor.',
  'Cycle terminé':
      'Cycle complete',
  'Pense à arracher et préparer le sol pour la rotation.':
      'Remember to pull it up and prepare the soil for crop rotation.',
  'Floraison / nouaison':
      'Flowering / fruit set',
  'Les premières fleurs annoncent la fructification. Tuteure si besoin et pince les gourmands (tomates).':
      'The first flowers signal fruiting is on its way. Stake if needed and pinch out the side shoots (tomatoes).',
  'Tubérisation':
      'Tuber formation',
  'Les tubercules se forment sous terre. Butte le pied pour les couvrir et arrose régulièrement.':
      'Tubers are forming underground. Earth up the plant to cover them and water regularly.',
  'Grossissement':
      'Bulking up',
  'Les racines s\'allongent. Éclaircis si tu ne l\'as pas encore fait pour laisser la place.':
      'The roots are lengthening. Thin them out, if you haven\'t yet, to make room.',
  'Bulbaison':
      'Bulbing',
  'Le bulbe se forme. Réduis l\'arrosage à l\'approche de la récolte.':
      'The bulb is forming. Ease off the watering as harvest approaches.',
  'Plein développement':
      'Full growth',
  'Surveille les pucerons, les limaces et la montée à graines.':
      'Watch for aphids, slugs and bolting.',
  'Pré-récolte':
      'Pre-harvest',
  'Les organes commencent à mûrir. Garde un œil sur la météo.':
      'The produce is starting to ripen. Keep an eye on the weather.',
  'le {0} {1}':
      'on {0} {1}',
  '{0} ans':
      '{0} years',
  '{0} an':
      '{0} year',
  'cette saison':
      'this season',
  'il y a {0}':
      '{0} ago',
  'Tu as déjà cultivé ce légume {0}. La rotation recommande {1} d\'attente.':
      'You already grew this vegetable {0}. Crop rotation recommends waiting {1}.',
  'Tu as déjà cultivé un {0} ici ({1}) {2}. Évite la même famille avant {3}.':
      'You already grew {0} here ({1}) {2}. Avoid the same family before {3}.',
  'Tempéré':
      'Temperate',
  'Sahel (plus sec)':
      'Sahel (drier)',
  'Soudanien (centre)':
      'Sudanian (central)',
  'Guinéen (plus humide)':
      'Guinean (wetter)',
  'Méditerranéen':
      'Mediterranean',
  'Continental':
      'Continental',
  'Subtropical humide':
      'Humid subtropical',
  'Tropical d\'altitude':
      'Highland tropical',
  'Quatre saisons européennes.':
      'Four European seasons.',
  'Saison des pluies courte (juin-sept), harmattan marqué.':
      'Short rainy season (June-Sept), pronounced harmattan.',
  'Saison des pluies de mai/juin à octobre.':
      'Rainy season from May/June to October.',
  'Climat humide, deux saisons des pluies.':
      'Humid climate, two rainy seasons.',
  'Été chaud et sec, hiver doux : on sème tôt, et aussi à l\'automne.':
      'Hot, dry summers and mild winters: sow early, and in autumn too.',
  'Hiver froid, saison de culture courte : on sème plus tard.':
      'Cold winters and a short growing season: sow later.',
  'Saison longue et humide, étés lourds.':
      'Long, humid season and sultry summers.',
  'Doux toute l\'année, rythmé par les pluies.':
      'Mild all year round, shaped by the rains.',
  'Outils':
      'Tools',
  'Bacs & Pots':
      'Planters & Pots',
  'Terreau & Engrais':
      'Potting Mix & Fertilizer',
  'Semences':
      'Seeds',
  'Arrosage':
      'Watering',
  'Protection':
      'Protection',
  'Structures':
      'Structures',
  'Fleurs':
      'Flowers',
  'Feuilles':
      'Leaves',
  'Fruits':
      'Fruits',
  'Bulbes':
      'Bulbs',
  'Tubercules':
      'Tubers',
  'Graines':
      'Seeds',
  'Racines':
      'Roots',
  'Tiges':
      'Stems',
  'Aromatiques':
      'Herbs',
  'Accessoires':
      'Accessories',
  'Bronze':
      'Bronze',
  'Argent':
      'Silver',
  'Or':
      'Gold',
  'Shiny':
      'Shiny',
  'Arrosage OK':
      'Watering OK',
  '{0} jours sans eau — pluie prévue ({1} mm)':
      '{0} days without water — rain expected ({1} mm)',
  '{0} jours sans eau — arrosage nécessaire !':
      '{0} days without water — time to water!',
  'Ciel dégagé':
      'Clear sky',
  'Peu nuageux':
      'Mostly clear',
  'Partiellement nuageux':
      'Partly cloudy',
  'Couvert':
      'Overcast',
  'Bruine':
      'Drizzle',
  'Pluie':
      'Rain',
  'Neige':
      'Snow',
  'Averses':
      'Showers',
  'Orage':
      'Thunderstorm',
  'Variable':
      'Changeable',
  'Bienvenue sur Kultiva':
      'Welcome to Kultiva',
  'Le potager kawaii dans ta poche. Calendrier de semis, suivi de tes plants, météo, conseils — tout au même endroit, en français.':
      'Your kawaii veggie patch, in your pocket. Sowing calendar, plant tracking, weather, tips — all in one place.',
  'Ton cahier de culture':
      'Your garden journal',
  'Crée ton potager pleine terre, place tes plants par glisser-déposer dans les cases et suis chaque phase de croissance.':
      'Create your in-ground garden, drag and drop your plants into the beds and follow every growth stage.',
  'Météo + alertes arrosage':
      'Weather + watering alerts',
  'L\'app suit la météo de ton jardin et te prévient quand il faut arroser, protéger d\'une canicule ou rentrer un plant.':
      'The app tracks your garden\'s weather and tells you when to water, shield plants from a heatwave or bring one indoors.',
  'Le journal de ton jardin':
      'Your garden diary',
  'Chaque semis, chaque arrosage, chaque récolte s\'inscrit à sa date. Relis ta saison jour par jour, décroche des médailles par légume et 50 défis photo.':
      'Every sowing, watering and harvest is logged on its date. Relive your season day by day, earn medals for each vegetable and take on 50 photo challenges.',
  'Apprends à ton rythme':
      'Learn at your own pace',
  'L\'onglet Tutos t\'accompagne pas à pas : réussir tes semis, bien arroser, lutter contre les nuisibles et apprendre les bons gestes au jardin.':
      'The Tutorials tab guides you step by step: nail your sowing, water well, fight pests and learn the right moves in the garden.',
  'Retour':
      'Back',
  'Suivant':
      'Next',
  'Commencer':
      'Get started',
  '{0} Tu jardines : {1} !':
      '{0} You garden in {1}!',
  'Impossible de détecter ton pays — choisis-le dans la liste.':
      'Couldn\'t detect your country — pick it from the list.',
  'Où jardines-tu ?':
      'Where do you garden?',
  'Calendrier de semis, saisons et conseils s\'adaptent à ton pays.':
      'The sowing calendar, seasons and tips adapt to your country.',
  'Cherche ton pays ou ta capitale…':
      'Search for your country or capital…',
  'Aucun pays ne porte « {0} ». Kultiva en couvre {1} — dis-nous si le tien manque.':
      'No country matches “{0}”. Kultiva covers {1} — tell us if yours is missing.',
  'Détection en cours…':
      'Detecting…',
  'Détecter mon pays':
      'Detect my country',
  '{0}, suggéré d\'après ton téléphone':
      '{0}, suggested from your phone',
  '📍 Suggéré':
      '📍 Suggested',
  '{0} {1} est noté dans ton cahier':
      '{0} {1} is noted in your journal',
  'Voir':
      'View',
  'Impossible d\'ouvrir le lien.':
      'Couldn\'t open the link.',
  'Exporter PDF':
      'Export PDF',
  'Retirer {0} des favoris':
      'Remove {0} from favorites',
  'Ajouter {0} aux favoris':
      'Add {0} to favorites',
  'Je l\'ai planté':
      'I planted it',
  'Je l\'ai planté ({0})':
      'I planted it ({0})',
  'Semis — {0}':
      'Sowing — {0}',
  'Récolte — {0}':
      'Harvest — {0}',
  '🌱  Semis':
      '🌱  Sowing',
  'Technique':
      'Method',
  'Profondeur':
      'Depth',
  'Température':
      'Temperature',
  'Levée':
      'Emergence',
  '🌿  Culture':
      '🌿  Growing',
  'Exposition':
      'Light',
  'Espacement':
      'Spacing',
  'Sol':
      'Soil',
  '📦  Rendement':
      '📦  Yield',
  'Estimation':
      'Estimate',
  '🤝  Bons voisins':
      '🤝  Good neighbors',
  '⛔  À éviter à côté':
      '⛔  Avoid nearby',
  '← Swipe pour naviguer →':
      '← Swipe to navigate →',
  'Acheter':
      'Buy',
  'Lien partenaire · Kultiva touche une petite commission si tu achètes.':
      'Affiliate link · Kultiva earns a small commission if you buy.',
  'Lien partenaire':
      'Affiliate link',
  'Lien partenaire Amazon — Kultiva touche une petite commission si tu achètes.':
      'Amazon affiliate link — Kultiva earns a small commission if you buy.',
  '⏱  Temps avant récolte':
      '⏱  Time to harvest',
  'Printemps':
      'Spring',
  'Été':
      'Summer',
  'Automne':
      'Autumn',
  'Hiver':
      'Winter',
  '🐛  Maladies & ravageurs':
      '🐛  Diseases & pests',
  '🔄  Rotation des cultures':
      '🔄  Crop rotation',
  'Famille : ':
      'Family: ',
  'Attendre : ':
      'Wait: ',
  '{0} ans avant de replanter au même endroit':
      '{0} years before replanting in the same spot',
  'Bons successeurs :':
      'Good next crops:',
  'Adaptation — {0}':
      'Adaptation — {0}',
  '🗣️  Noms locaux':
      '🗣️  Local names',
  '💰  Maraîchage':
      '💰  Market gardening',
  'Ordres de grandeur indicatifs (marchés urbains).':
      'Ballpark figures (urban markets).',
  'Rendement':
      'Yield',
  '~{0} par pied/cycle':
      '~{0} per plant/cycle',
  'Prix marché':
      'Market price',
  '~{0} FCFA / kg':
      '~{0} FCFA / kg',
  'Valeur estimée':
      'Estimated value',
  '~{0} FCFA par pied':
      '~{0} FCFA per plant',
  '🫙  Garder ta récolte':
      '🫙  Preserve your harvest',
  'Trois façons de la faire durer. Un jardinier n\'a pas un légume, il en a quinze d\'un coup.':
      'Three ways to make it last. A gardener doesn\'t have one vegetable, they have fifteen at once.',
  '{0} recettes à manger tout de suite':
      '{0} recipes to eat right away',
  '{0} recette à manger tout de suite':
      '{0} recipe to eat right away',
  '🛍️  Bien acheter au marché':
      '🛍️  Buying well at the market',
  'semis {0}':
      'sowing {0}',
  'récolte {0}':
      'harvest {0}',
  '{0} : aucune période connue':
      '{0}: no known period',
  'Aucun légume ne porte « {0} » dans son nom.':
      'No vegetable has “{0}” in its name.',
  'Aucun {0} à semer ni à récolter en {1} chez toi.':
      'No {0} to sow or harvest in {1} where you are.',
  'Aucun {0} au calendrier de ta région.':
      'No {0} in your region\'s calendar.',
  'Rien à semer ni à récolter en {0} dans ta région.':
      'Nothing to sow or harvest in {0} in your region.',
  'Le calendrier de ta région est vide.':
      'Your region\'s calendar is empty.',
  'Fermer le calendrier':
      'Close calendar',
  'Afficher tous les mois':
      'Show all months',
  'Semis':
      'Sowing',
  'Récolte':
      'Harvest',
  'Les deux':
      'Both',
  'Rechercher un légume':
      'Search for a vegetable',
  'Rechercher un légume…':
      'Search for a vegetable…',
  'Effacer la recherche':
      'Clear search',
  'Toutes':
      'All',
  'Filtre le calendrier sur ce mois':
      'Filters the calendar to this month',
  'Ouvre sa fiche':
      'Opens its page',
  'Tout afficher':
      'Show all',
  'Configuration du jardin':
      'Garden setup',
  'Fermer':
      'Close',
  'Lieu':
      'Location',
  'Ville, code postal, région…':
      'City, postal code, region…',
  'Détecter ma position':
      'Detect my location',
  'Pour connaître ton climat et les dates de gel.':
      'To find out your climate and frost dates.',
  'Nom':
      'Name',
  'Taille':
      'Size',
  'pieds':
      'feet',
  'Largeur':
      'Width',
  '{0} × {1} cases (1 case = 30×30 cm)':
      '{0} × {1} beds (1 bed = 30×30 cm)',
  'Terminé':
      'Done',
  'Localisation refusée. Tape ta ville à la main.':
      'Location access denied. Type your city in manually.',
  'Échec de la géoloc : {0}':
      'Location failed: {0}',
  'Mes jardins':
      'My gardens',
  '📔  Cahier de culture':
      '📔  Garden journal',
  'Ton premier jardin t\'attend':
      'Your first garden is waiting',
  '{0} jardins':
      '{0} gardens',
  '{0} jardin':
      '{0} garden',
  '{0} cases occupées':
      '{0} beds occupied',
  '{0} case occupée':
      '{0} bed occupied',
  '{0} plants suivis':
      '{0} plants tracked',
  '{0} plant suivi':
      '{0} plant tracked',
  'Aucun jardin pour l\'instant':
      'No gardens yet',
  'Crée ton premier jardin pleine terre avec le bouton en bas. Tu pourras ensuite y placer tes plants par glisser-déposer.':
      'Create your first in-ground garden with the button below. You can then drag and drop your plants into it.',
  'Jardin {0}, {1} cases occupées sur {2}':
      'Garden {0}, {1} of {2} beds occupied',
  'Ouvre le plan de ce jardin':
      'Opens this garden\'s plan',
  'Pleine terre  ·  {0}×{1}  ·  {2}/{3} occupées':
      'In-ground  ·  {0}×{1}  ·  {2}/{3} occupied',
  '+ Nouveau jardin':
      '+ New garden',
  'Fermer le calendrier du mois':
      'Close the month calendar',
  'À récolter en {0}':
      'To harvest in {0}',
  'À semer en {0}':
      'To sow in {0}',
  'Rien à semer ce mois-ci. Patience, jardinier !':
      'Nothing to sow this month. Patience, gardener!',
  'Pas encore la saison':
      'Not in season yet',
  'Paramètres':
      'Settings',
  '🌍  Pays':
      '🌍  Country',
  'Pays détecté : {0} {1}':
      'Detected country: {0} {1}',
  'Impossible de détecter ton pays. Vérifie tes permissions de localisation.':
      'Couldn\'t detect your country. Check your location permissions.',
  'Détecter mon pays automatiquement':
      'Detect my country automatically',
  '🌦️  Ma zone':
      '🌦️  My zone',
  '🔔  Notifications':
      '🔔  Notifications',
  'Rappel mensuel':
      'Monthly reminder',
  'Une notification le 1er de chaque mois':
      'A notification on the 1st of every month',
  'Musique de fond':
      'Background music',
  'Ambiance douce japonisante':
      'Soft, Japanese-inspired mood',
  'Volume':
      'Volume',
  'Celle du téléphone':
      'Follows your phone',
  '🌙  Apparence':
      '🌙  Appearance',
  'Mode sombre':
      'Dark mode',
  '🌱  Mon jardin':
      '🌱  My garden',
  'Revoir la présentation':
      'Replay the intro',
  'Réafficher les écrans de bienvenue':
      'Show the welcome screens again',
  'Redémarre l\'app pour revoir l\'onboarding':
      'Restart the app to see the onboarding again',
  'Effacer mon jardin':
      'Erase my garden',
  'Plants, badges, défis et jardins — définitif':
      'Plants, badges, challenges and gardens — permanent',
  'Politique de confidentialité':
      'Privacy policy',
  'Effacer ton jardin ?':
      'Erase your garden?',
  'Tes plants, tes photos, tes badges, tes défis, tes jardins seront effacés de ce téléphone.\n\nTes réglages (son, thème, région) sont conservés.':
      'Your plants, photos, badges, challenges and gardens will be erased from this phone.\n\nYour settings (sound, theme, region) are kept.',
  'Annuler':
      'Cancel',
  'Continuer':
      'Continue',
  'C\'est définitif':
      'This is permanent',
  'Kultiva n\'a pas de compte : rien n\'est sauvegardé ailleurs. Une fois effacé, ton jardin ne peut pas être récupéré.':
      'Kultiva has no accounts: nothing is saved anywhere else. Once erased, your garden can\'t be recovered.',
  'Garder mon jardin':
      'Keep my garden',
  'Tout effacer':
      'Erase everything',
  '🧹 Ton jardin a été effacé. À toi de rejouer !':
      '🧹 Your garden has been erased. Time to start over!',
  '{0} {1} adore pousser à côté de {2} {3} !':
      '{0} {1} loves growing next to {2} {3}!',
  '{0} {1} : attendre {2} ans avant de replanter au même endroit.':
      '{0} {1}: wait {2} years before replanting in the same spot.',
  '{0} {1} : attention au {2}. {3}.':
      '{0} {1}: watch out for {2}. {3}.',
  'Météo : {0} degrés, {1}':
      'Weather: {0} degrees, {1}',
  'Semer':
      'Sow',
  '{0} légumes':
      '{0} vegetables',
  'Récolter':
      'Harvest',
  'Calendrier':
      'Calendar',
  'Vue annuelle':
      'Year view',
  'Légume du jour':
      'Vegetable of the day',
  'Défis & badges':
      'Challenges & badges',
  '50 défis photo, 50 badges':
      '50 photo challenges, 50 badges',
  'Actualités':
      'News',
  'Suis-nous sur Instagram':
      'Follow us on Instagram',
  'Impossible d\'ouvrir Instagram pour le moment.':
      'Can\'t open Instagram right now.',
  '✨ Légume du jour':
      '✨ Vegetable of the day',
  '🌤 Météo du jour':
      '🌤 Today\'s weather',
  '{0} mm de pluie prévus sous 3 jours':
      '{0} mm of rain expected within 3 days',
  'Pas de pluie prévue sur 3 jours':
      'No rain expected in the next 3 days',
  'Chargement météo...':
      'Loading weather...',
  'Météo indisponible\nActive la localisation pour les prévisions':
      'Weather unavailable\nTurn on location for forecasts',
  'Conseil du jour':
      'Tip of the day',
  'En {0}':
      'In {0}',
  '🌱 {0} à semer  ·  🧺 {1} à récolter':
      '🌱 {0} to sow  ·  🧺 {1} to harvest',
  'Impossible de charger la fiche : {0}':
      'Couldn\'t load the guide: {0}',
  'Prise en main':
      'Getting started',
  'Découvrir l\'application':
      'Discover the app',
  'Astuces':
      'Tips',
  'Jardiner avec la lune':
      'Gardening by the moon',
  'Attirer les pollinisateurs':
      'Attracting pollinators',
  'Réutiliser ses déchets':
      'Reusing your waste',
  'Gain de temps au jardin':
      'Saving time in the garden',
  'Réussir ses semis':
      'Successful sowing',
  'Semis en intérieur':
      'Sowing indoors',
  'Quand semer ?':
      'When to sow?',
  'Température de germination':
      'Germination temperature',
  'Bien arroser':
      'Watering well',
  'Quand arroser ?':
      'When to water?',
  'Arrosage goutte à goutte':
      'Drip irrigation',
  'Récupérer l\'eau de pluie':
      'Collecting rainwater',
  'Quand récolter ?':
      'When to harvest?',
  'Conserver ses légumes':
      'Preserving your vegetables',
  'Récolter les aromatiques':
      'Harvesting herbs',
  'Récolter les racines':
      'Harvesting root vegetables',
  'Sol & Compost':
      'Soil & Compost',
  'Faire son compost':
      'Making compost',
  'Préparer le sol':
      'Preparing the soil',
  'Engrais naturels':
      'Natural fertilizers',
  'Paillage':
      'Mulching',
  'Maladies & Nuisibles':
      'Diseases & Pests',
  'Lutter contre les limaces':
      'Fighting slugs',
  'Mildiou':
      'Late blight / downy mildew',
  'Pucerons':
      'Aphids',
  'Traitements bio':
      'Organic treatments',
  'Aménagement':
      'Layout',
  'Potager surélevé':
      'Raised vegetable bed',
  'Potager en carrés':
      'Square-foot garden',
  'Associations de plantes':
      'Companion planting',
  'Potager en balcon':
      'Balcony garden',
  'Climat tropical':
      'Tropical climate',
  'Jardiner en saison sèche':
      'Gardening in the dry season',
  'Préparer l\'hivernage':
      'Getting ready for the rainy season',
  'Fabriquer une ombrière':
      'Building a shade structure',
  'Cultiver l\'igname':
      'Growing yams',
  '🎓 Tutos':
      '🎓 Tutorials',
  'Apprends à jardiner, fiche par fiche':
      'Learn gardening, one card at a time',
  'Ouvre la fiche':
      'Open the guide',
  'Le tour complet — dashboard, Cahier, Étal, Recettes':
      'The full tour — dashboard, Journal, Catalog, Recipes',
  'Étal':
      'Catalog',
  '{0} variétés':
      '{0} varieties',
  'Afficher en liste':
      'Show as list',
  'Afficher en grille':
      'Show as grid',
  'Alphabétique':
      'Alphabetical',
  'Par catégorie':
      'By category',
  'À semer ce mois':
      'To sow this month',
  'Favoris':
      'Favorites',
  'Aucun légume trouvé':
      'No vegetables found',
  '📍 {0} · localisation désactivée':
      '📍 {0} · location off',
  'Ma position':
      'My location',
  'Localisation désactivée':
      'Location off',
  'Pour te montrer la météo de ton jardin, Kultiva a besoin d\'accéder à ta position.\n\nEn attendant, on affiche la météo de Paris par défaut. Tu peux autoriser la localisation dans les réglages.':
      'To show you the weather in your garden, Kultiva needs access to your location.\n\nUntil then, we\'re showing the weather for Paris by default. You can allow location access in Settings.',
  'Plus tard':
      'Later',
  'Ouvrir les Réglages':
      'Open Settings',
  'Aujourd\'hui':
      'Today',
  'Hier':
      'Yesterday',
  'Demain':
      'Tomorrow',
  '🌧️ Pluie prévue — pas besoin d\'arroser !':
      '🌧️ Rain expected — no need to water!',
  '💧 Légère pluie — arrosage léger suffit':
      '💧 Light rain — a light watering is enough',
  '🌱 Température du jour indisponible':
      '🌱 Today\'s temperature unavailable',
  '☀️ Très chaud — arrose tôt le matin ou le soir':
      '☀️ Very hot — water early in the morning or in the evening',
  '❄️ Risque de gel — protège tes plants sensibles':
      '❄️ Frost risk — protect your tender plants',
  '🌡️ Grosse amplitude — surveille tes semis':
      '🌡️ Big temperature swing — keep an eye on your seedlings',
  '🌱 Belle journée pour jardiner !':
      '🌱 Great day for gardening!',
  'Rafraîchir la météo':
      'Refresh weather',
  '🌤 Météo':
      '🌤 Weather',
  'Météo indisponible':
      'Weather unavailable',
  'Jour précédent':
      'Previous day',
  'Jour suivant':
      'Next day',
  '{0}, {1} degrés, {2}':
      '{0}, {1} degrees, {2}',
  '{0}, max {1}':
      '{0}, max {1}',
  '{0} degrés':
      '{0} degrees',
  'température indisponible':
      'temperature unavailable',
  'Minimum {0} degrés, maximum {1} degrés':
      'Minimum {0} degrees, maximum {1} degrees',
  'Min {0}':
      'Min {0}',
  'Max {0}':
      'Max {0}',
  '{0} millimètres de pluie':
      '{0} millimeters of rain',
  '{0} mm de pluie':
      '{0} mm of rain',
  '💡 Conseil jardinage':
      '💡 Gardening tip',
  '{0} façons de garder {1} récoltes':
      '{0} ways to preserve {1} harvests',
  '{0} façons de garder {1} récolte':
      '{0} ways to preserve {1} harvest',
  '{0} façon de garder {1} récoltes':
      '{0} way to preserve {1} harvests',
  '{0} façon de garder {1} récolte':
      '{0} way to preserve {1} harvest',
  'Un légume, ou une conserve…':
      'A vegetable, or a preserve…',
  'Tout':
      'All',
  'C\'est la saison':
      'In season',
  'Mes favoris':
      'My favorites',
  'Dans ton jardin':
      'In your garden',
  'Tu n\'as encore mis aucune recette de côté.\nTouche le marque-page sur celles qui te tentent.':
      'You haven\'t saved any recipes yet.\nTap the bookmark on the ones that tempt you.',
  'qui parle de « {0} »':
      'mentioning “{0}”',
  'dans la famille « {0} »':
      'in the “{0}” family',
  'à récolter ce mois-ci':
      'to harvest this month',
  'parmi tes favoris':
      'among your favorites',
  'Aucune recette.':
      'No recipes.',
  'Aucune recette {0}.':
      'No recipes {0}.',
  'Cuisinée {0}':
      'Cooked {0}',
  'Je l\'ai cuisinée':
      'I cooked it',
  'Retirer des favoris':
      'Remove from favorites',
  'Mettre de côté':
      'Save for later',
  'Partager':
      'Share',
  'Impossible d\'ouvrir la recette.\n{0}':
      'Couldn\'t open the recipe.\n{0}',
  'Pour {0} personnes':
      'For {0} people',
  'Pour {0} personne':
      'For {0} person',
  'écrite pour {0}':
      'written for {0}',
  'Moins':
      'Less',
  'Plus':
      'More',
  'Planté':
      'Planted',
  'Arrosé':
      'Watered',
  'Culture terminée':
      'Crop finished',
  'Jour {0} / {1}':
      'Day {0} / {1}',
  '✨ Prêt à récolter':
      '✨ Ready to harvest',
  '⏳ {0} j restants':
      '⏳ {0} d left',
  'Jamais arrosé':
      'Never watered',
  'Dernier arrosage : {0} ({1}j)':
      'Last watered: {0} ({1}d)',
  '{0} récoltes enregistrées':
      '{0} harvests logged',
  '{0} récolte enregistrée':
      '{0} harvest logged',
  'Planté le {0}':
      'Planted on {0}',
  'Partager cette carte':
      'Share this card',
  'Arroser':
      'Water',
  'Terminer':
      'Finish',
  'Retirer':
      'Remove',
  '📜 Historique':
      '📜 History',
  'Retirer ce plant ?':
      'Remove this plant?',
  'Cette action supprime définitivement {0} de ton cahier de culture. Tes arrosages et récoltes liés seront perdus.':
      'This permanently deletes {0} from your garden journal. Your linked waterings and harvests will be lost.',
  'Prendre une photo':
      'Take a photo',
  'Choisir depuis la galerie':
      'Choose from gallery',
  'Photos':
      'Photos',
  'Photos ({0})':
      'Photos ({0})',
  'Ajouter une photo de ce plant':
      'Add a photo of this plant',
  'Ajouter':
      'Add',
  'Retirer cette photo':
      'Remove this photo',
  'Retirer la photo ?':
      'Remove the photo?',
  'Ajoute une note sur ce plant…':
      'Add a note about this plant…',
  'Enregistrer':
      'Save',
  'Ajouter une note':
      'Add a note',
  'Note : {0}':
      'Note: {0}',
  'Touche pour modifier':
      'Tap to edit',
  'Ajouter une note…':
      'Add a note…',
  'Retirer {0} ?':
      'Remove {0}?',
  'Le plant et ses photos seront supprimés de ta collection. Cette action est définitive.':
      'The plant and its photos will be deleted from your collection. This can\'t be undone.',
  '📷 Photo impossible — réessaie dans un instant':
      '📷 Couldn\'t take the photo — try again in a moment',
  'Toute l\'année':
      'All year',
  'Saison sèche':
      'Dry season',
  'Hivernage':
      'Rainy season',
  'Sauvegarder':
      'Save',
  'Configurer':
      'Configure',
  '🌱 {0} plants':
      '🌱 {0} plants',
  '🌱 {0} plant':
      '🌱 {0} plant',
  'Conseils':
      'Tips',
  'Quitter sans sauvegarder ?':
      'Leave without saving?',
  'Tes modifications seront perdues.':
      'Your changes will be lost.',
  'Continuer l\'édition':
      'Keep editing',
  'Quitter':
      'Leave',
  'Jardin sauvegardé 🌱':
      'Garden saved 🌱',
  'Conseil pour ce stade':
      'Tip for this stage',
  'À planter à côté':
      'Plant nearby',
  'À éviter à côté':
      'Avoid nearby',
  'Attention à la rotation. {0}':
      'Watch your crop rotation. {0}',
  'Attention à la rotation':
      'Watch your crop rotation',
  'Case vide':
      'Empty bed',
  'Case plantée : {0}':
      'Planted bed: {0}',
  'Poser un plant':
      'Place a plant',
  'Ouvrir la fiche du plant':
      'Open the plant\'s page',
  'Planté aujourd\'hui ({0})':
      'Planted today ({0})',
  'Planté hier ({0})':
      'Planted yesterday ({0})',
  'Planté il y a {0} jours ({1})':
      'Planted {0} days ago ({1})',
  'Pas encore arrosé':
      'Not watered yet',
  'Arrosé aujourd\'hui':
      'Watered today',
  'Arrosé hier':
      'Watered yesterday',
  'Arrosé il y a {0} jours':
      'Watered {0} days ago',
  'Date de plantation':
      'Planting date',
  '💧 Arrosage enregistré':
      '💧 Watering logged',
  'Choisir une autre date':
      'Pick another date',
  'Stade : {0} {1}':
      'Stage: {0} {1}',
  'Fréquence indicative : tous les {0} jours environ (selon météo).':
      'Suggested frequency: about every {0} days (depending on the weather).',
  'Combien de plants dans cette case ?':
      'How many plants in this bed?',
  'Maximum recommandé : {0} plants par case (30×30 cm)':
      'Recommended maximum: {0} plants per bed (30×30 cm)',
  'Vider':
      'Clear',
  'Valider':
      'Confirm',
  'Choisir les plantes':
      'Choose plants',
  'Filtrer par saison':
      'Filter by season',
  'Aucun favori. Ajoute des plantes en favori depuis l\'onglet Étal.':
      'No favorites yet. Add plants to your favorites from the Catalog tab.',
  'Aucune plante dans ce filtre.':
      'No plants match this filter.',
  'Aucun plant à arroser dans ce jardin':
      'No plants to water in this garden',
  '💧 {0} plant(s) arrosé(s)':
      '💧 {0} plant(s) watered',
  'Arroser tous les plants':
      'Water all plants',
  'Irrigation':
      'Irrigation',
  'Météo en cours de chargement…':
      'Loading weather…',
  'Pluie attendue':
      'Rain expected',
  'Pluie cumulée ~ {0} mm sur 3j. Pas besoin d\'arroser pour l\'instant.':
      'Total rain ~ {0} mm over 3 days. No need to water for now.',
  'Forte chaleur':
      'Intense heat',
  'Pic à {0} °C prévu. Arrose tôt le matin ou en fin de journée, pailler les pieds.':
      'Peak of {0} °C expected. Water early in the morning or late in the day, and mulch around the plants.',
  'Conditions normales':
      'Normal conditions',
  'Vérifie tes plants : un sol sec sur 3 cm = il faut arroser.':
      'Check your plants: soil that\'s dry 3 cm down means it\'s time to water.',
  'Comment utiliser le planificateur':
      'How to use the planner',
  'Glisse une plante depuis la barre du bas vers une case de la grille pour la planter.':
      'Drag a plant from the bottom bar onto a bed in the grid to plant it.',
  'Touche une case occupée pour voir les détails ou la vider.':
      'Tap an occupied bed to see its details or clear it.',
  'Le chiffre indique le nombre de plants qui tiennent dans une case (ex. 9 carottes par 30×30 cm).':
      'The number shows how many plants fit in a bed (e.g. 9 carrots per 30×30 cm).',
  'Anneau vert autour d\'une case = plantes compagnes voisines, anneau rouge = à séparer.':
      'Green ring around a bed = neighboring companion plants, red ring = keep apart.',
  'Chaque case mesure 1×1 pied (≈ 30×30 cm). Configure la taille de ton jardin via « Configurer ».':
      'Each bed measures 1×1 ft (≈ 30×30 cm). Set your garden\'s size with “Configure”.',
  'Journal':
      'Journal',
  'Tout le journal':
      'Full journal',
  '📖  Journal du jardin':
      '📖  Garden journal',
  'Tout ce que tu as fait, jour par jour':
      'Everything you\'ve done, day by day',
  'Au jardin en ce moment  ·  {0}':
      'In the garden now  ·  {0}',
  'Voir les {0} autres':
      'See the other {0}',
  'il y a {0} j':
      '{0} d ago',
  'planté {0}':
      'planted {0}',
  'jamais arrosé':
      'never watered',
  'arrosé {0}':
      'watered {0}',
  'Ouvre le dossier de ce plant':
      'Open this plant\'s file',
  '🧾 Export impossible pour le moment':
      '🧾 Export unavailable right now',
  'Préparation…':
      'Preparing…',
  'Récap de la saison {0}':
      '{0} season recap',
  'Arrosage noté 💧':
      'Watering noted 💧',
  '{0} plants arrosés 💧':
      '{0} plants watered 💧',
  'Arroser : {0}':
      'Water: {0}',
  'À récolter : {0}':
      'To harvest: {0}',
  '{0} °C aujourd\'hui. {1}':
      '{0} °C today. {1}',
  'Pense à pailler et ombrer.':
      'Remember to mulch and add shade.',
  'Lecture du jardin…':
      'Reading your garden…',
  'Rien d\'urgent aujourd\'hui. {0} plants en terre.':
      'Nothing urgent today. {0} plants in the ground.',
  'Rien d\'urgent aujourd\'hui. {0} plant en terre.':
      'Nothing urgent today. {0} plant in the ground.',
  'À faire aujourd\'hui':
      'To do today',
  '{0} et {1} autres':
      '{0} and {1} others',
  '{0} et {1} autre':
      '{0} and {1} other',
  'AUJOURD\'HUI':
      'TODAY',
  'HIER':
      'YESTERDAY',
  'Photo ajoutée':
      'Photo added',
  '📜\n\nTon journal se remplira au fil de tes actions.\nPlante, arrose, récolte !':
      '📜\n\nYour journal will fill up as you go.\nPlant, water, harvest!',
  '{0} {1} à {2}':
      '{0} {1} at {2}',
  'Badge {0}, débloqué':
      'Badge {0}, unlocked',
  'Badge {0}, verrouillé':
      'Badge {0}, locked',
  'Ouvre la carte du badge':
      'Open the badge card',
  '📸 {0} / {1} défis complétés':
      '📸 {0} / {1} challenges completed',
  'Défi {0}, réussi':
      'Challenge {0}, completed',
  'Défi {0}, à faire':
      'Challenge {0}, to do',
  'Revoir ta photo':
      'View your photo',
  'Prendre la photo':
      'Take the photo',
  '📷 Participer':
      '📷 Join in',
  '{0} défis sur {1}  ·  {2} badges sur {3}':
      '{0} of {1} challenges  ·  {2} of {3} badges',
  '{0} défis sur {1}  ·  {2} badge sur {3}':
      '{0} of {1} challenges  ·  {2} of {3} badges',
  '{0} défi sur {1}  ·  {2} badges sur {3}':
      '{0} of {1} challenges  ·  {2} of {3} badges',
  '{0} défi sur {1}  ·  {2} badge sur {3}':
      '{0} of {1} challenges  ·  {2} of {3} badges',
  '📸  Défis & badges':
      '📸  Challenges & badges',
  '📸  Défis':
      '📸  Challenges',
  '🏆  Badges':
      '🏆  Badges',
  'À faire maintenant':
      'To do now',
  'Eau':
      'Water',
  '{0} °C aujourd\'hui':
      '{0} °C today',
  'À surveiller':
      'Keep an eye on',
  'C\'est le moment':
      'It\'s time',
  'Bons voisins':
      'Good neighbours',
  'Garde le sol humide, protège des limaces et du froid avec un voile si besoin.':
      'Keep the soil moist and protect against slugs and cold with a fleece cover if needed.',
  'Tuteure le plant, pince les gourmands (tomates), apporte du compost si feuilles claires.':
      'Stake the plant, pinch out the side shoots (tomatoes) and add compost if the leaves look pale.',
  'Récolte au fur et à mesure pour stimuler la repousse, arrose au pied le matin.':
      'Harvest little and often to encourage regrowth, and water at the base in the morning.',
  'Le plant prend du volume — arrose régulièrement et bine le pied pour aérer le sol.':
      'The plant is filling out — water regularly and hoe around the base to loosen the soil.',
  'Floraison en cours : maintenir l\'arrosage régulier, apporter de la potasse (cendres de bois).':
      'In flower: keep watering regularly and add potash (wood ash).',
  'Récolte régulière pour stimuler la production. Surveille les nuisibles et l\'humidité.':
      'Harvest regularly to keep production going. Watch out for pests and keep an eye on moisture.',
  'Résumé mensuel : légumes à semer, à récolter, astuces.':
      'Monthly roundup: what to sow, what to harvest, plus tips.',
  '🌱 Un nouveau mois au potager':
      '🌱 A new month in the veg patch',
  'Découvre ce que tu peux semer et récolter ce mois-ci.':
      'See what you can sow and harvest this month.',
  '{0} jours sans eau. {1} et {2} autres ont besoin d\'eau !':
      '{0} days without water. {1} and {2} others need water!',
  '{0} jours sans eau. {1} ont besoin d\'eau !':
      '{0} days without water. {1} need water!',
  'Alertes arrosage':
      'Watering alerts',
  'Notifications quand tes légumes ont soif':
      'Notifications when your vegetables are thirsty',
  '💧 Tes légumes ont soif !':
      '💧 Your vegetables are thirsty!',
  'Arrose tôt le matin ou en soirée, paille tes plants et ombre les jeunes pousses.':
      'Water early in the morning or in the evening, mulch your plants and shade the young shoots.',
  'Alerte canicule':
      'Heatwave alert',
  'Avertissement quand une vague de chaleur est prévue.':
      'A heads-up when a heatwave is forecast.',
  '🥵 Canicule prévue ({0}°C)':
      '🥵 Heatwave forecast ({0}°C)',
  'Premières pluies':
      'First rains',
  'Signal de semis quand les premières pluies de l\'hivernage arrivent.':
      'A sowing signal when the first rains of the hivernage arrive.',
  '🌧️ Les premières pluies arrivent !':
      '🌧️ The first rains are here!',
  '{0} mm de pluie prévus ces prochains jours : c\'est le moment de semer niébé, maïs, gombo et arachide. Prépare tes billons !':
      '{0} mm of rain expected over the next few days: time to sow cowpea, maize, okra and groundnut. Get your ridges ready!',
  'Calendrier — {0}':
      'Calendar — {0}',
  'Techniques de culture':
      'Growing techniques',
  'Température germination':
      'Germination temperature',
  'Compagnonnage':
      'Companion planting',
  'À éviter':
      'Avoid',
  'Fiche générée par Kultiva':
      'Sheet generated by Kultiva',
  'Récap saison {0}':
      '{0} season recap',
  'Cahier de culture pleine terre':
      'Open-ground garden journal',
  'Cultures':
      'Crops',
  'Arrosages':
      'Waterings',
  'Durée moy.':
      'Avg. time',
  'Top 5 légumes':
      'Top 5 vegetables',
  'Aucune culture cette saison.':
      'No crops this season.',
  'Répartition par famille':
      'Breakdown by family',
  '{0} : {1} cultures':
      '{0}: {1} crops',
  '{0} : {1} culture':
      '{0}: {1} crop',
  'Détail des cultures':
      'Crop details',
  'en cours':
      'ongoing',
  '({0} arrosages)':
      '({0} waterings)',
  'Récap généré par Kultiva':
      'Recap generated by Kultiva',
  'Kultiva — Récap {0}':
      'Kultiva — {0} recap',
  'Pas besoin d\'arroser : {0} mm de pluie prévus dans 48 h.':
      'No need to water: {0} mm of rain expected within 48 h.',
  'Sol déjà bien humide après la pluie récente. Saute l\'arrosage aujourd\'hui.':
      'The soil is already nicely moist after the recent rain. Skip watering today.',
  'Canicule prévue ({0}°C). Arrose tôt le matin ou en soirée, et pense au paillage.':
      'Heatwave forecast ({0}°C). Water early in the morning or in the evening, and think about mulching.',
  'Sécheresse depuis {0} jours et pas d\'arrosage depuis {1} j. C\'est urgent.':
      'Dry spell for {0} days and no watering for {1} days. This is urgent.',
  'Pas d\'arrosage depuis {0} j et pas de pluie prévue. Pense à arroser ce soir.':
      'No watering for {0} days and no rain forecast. Remember to water this evening.',
  'Tout va bien : sol récemment arrosé ou pluie attendue.':
      'All good: the soil was watered recently or rain is on the way.',
  'Nouveau badge':
      'New badge',
  '✨ NOUVEAU BADGE ✨':
      '✨ NEW BADGE ✨',
  'Tape n\'importe où pour continuer':
      'Tap anywhere to continue',
  'Appareil photo bloqué':
      'Camera blocked',
  'Kultiva a besoin de l\'appareil photo pour les défis photo et les photos de plants.\n\nTu as refusé l\'autorisation. Tu peux la réactiver dans les réglages du téléphone.':
      'Kultiva needs the camera for photo challenges and plant photos.\n\nYou declined the permission. You can turn it back on in your phone settings.',
  'J\'ai complété le défi "{0}" sur Kultiva ! {1} 🌱':
      'I completed the "{0}" challenge on Kultiva! {1} 🌱',
  'Impossible de partager : {0}':
      'Unable to share: {0}',
  'Export…':
      'Exporting…',
  'DÉFI {0}':
      'CHALLENGE {0}',
  'Défi complété':
      'Challenge completed',
  'Crée autant de jardins pleine terre que tu veux, chacun avec sa grille de cases. En haut, « à faire aujourd\'hui » te dit qui a soif, qui est mûr et s\'il va faire trop chaud.':
      'Create as many open-ground gardens as you like, each with its own grid of beds. At the top, “to do today” tells you who is thirsty, who is ripe and whether it\'s going to be too hot.',
  'Place tes plants':
      'Place your plants',
  'Choisis un plant en bas, dépose-le sur une case. La case se remplit avec un emoji + le nombre de plants. Tap pour ouvrir la fiche détaillée.':
      'Pick a plant at the bottom and drop it on a bed. The bed fills up with an emoji + the number of plants. Tap to open the detail sheet.',
  'Suis tes plants au quotidien':
      'Follow your plants day to day',
  'Bouton « Arroser » dans chaque fiche, conseils d\'irrigation adaptés au légume, et un badge couleur pour savoir si tu as arrosé récemment ou pas.':
      'A “Water” button on every sheet, watering tips suited to each vegetable, and a colour badge to show whether you watered recently or not.',
  'Date de plantation = stade':
      'Planting date = stage',
  'Tu peux corriger la date de plantation à tout moment. L\'app calcule automatiquement le stade (semis / croissance / floraison / fructification) et adapte ses conseils.':
      'You can change the planting date at any time. The app works out the stage automatically (sowing / growth / flowering / fruiting) and adapts its advice.',
  'Bienvenue dans Mes jardins':
      'Welcome to My gardens',
  'Passer':
      'Skip',
  'C\'est parti !':
      'Let\'s go!',
  'Médaille {0}':
      '{0} medal',
  'Harmattan':
      'Harmattan',
  'déjà cuisiné {0}':
      'already cooked {0}',
  'Il te faut':
      'You\'ll need',
  'Le pas-à-pas animé de cette recette n\'est pas encore écrit — il arrive.':
      'The animated step-by-step for this recipe isn\'t written yet — it\'s on its way.',
  'Il te faut :':
      'You\'ll need:',
  'Une idée pour ta récolte de {0} — Kultiva 🌱':
      'An idea for your {0} harvest — Kultiva 🌱',
  'Janvier':
      'January',
  'Février':
      'February',
  'Mars':
      'March',
  'Avril':
      'April',
  'Mai':
      'May',
  'Juin':
      'June',
  'Juillet':
      'July',
  'Août':
      'August',
  'Septembre':
      'September',
  'Octobre':
      'October',
  'Novembre':
      'November',
  'Décembre':
      'December',
  'Regarde mon {0} dans mon jardin Kultiva ! 🌱':
      'Look at my {0} in my Kultiva garden! 🌱',
  'Jour':
      'Day',
  'Planté le {0}  •  Kultiva':
      'Planted on {0}  •  Kultiva',
  ', à semer ce mois':
      ', to sow this month',
  ', favori':
      ', favourite',
  'Abidjan':
      'Abidjan',
  'Abuja':
      'Abuja',
  'Accra':
      'Accra',
  'Addis-Abeba':
      'Addis Ababa',
  'Afrique de l\'Ouest':
      'West Africa',
  'Afrique du Sud':
      'South Africa',
  'Alger':
      'Algiers',
  'Algérie':
      'Algeria',
  'Allemagne':
      'Germany',
  'Amsterdam':
      'Amsterdam',
  'Ankara':
      'Ankara',
  'Antananarivo':
      'Antananarivo',
  'Argentine':
      'Argentina',
  'Athènes':
      'Athens',
  'Australie':
      'Australia',
  'Autriche':
      'Austria',
  'Bamako':
      'Bamako',
  'Bangkok':
      'Bangkok',
  'Basse-Terre':
      'Basse-Terre',
  'Belgique':
      'Belgium',
  'Berlin':
      'Berlin',
  'Berne':
      'Bern',
  'Beyrouth':
      'Beirut',
  'Bogota':
      'Bogotá',
  'Brasilia':
      'Brasília',
  'Brazzaville':
      'Brazzaville',
  'Bruxelles':
      'Brussels',
  'Brésil':
      'Brazil',
  'Bucarest':
      'Bucharest',
  'Buenos Aires':
      'Buenos Aires',
  'Burkina Faso':
      'Burkina Faso',
  'Bénin':
      'Benin',
  'Cameroun':
      'Cameroon',
  'Canada':
      'Canada',
  'Canberra':
      'Canberra',
  'Cayenne':
      'Cayenne',
  'Chili':
      'Chile',
  'Chine':
      'China',
  'Colombie':
      'Colombia',
  'Conakry':
      'Conakry',
  'Congo':
      'Congo',
  'Copenhague':
      'Copenhagen',
  'Cotonou':
      'Cotonou',
  'Croatie':
      'Croatia',
  'Côte d\'Ivoire':
      'Côte d\'Ivoire',
  'Dakar':
      'Dakar',
  'Danemark':
      'Denmark',
  'Dublin':
      'Dublin',
  'Espagne':
      'Spain',
  'Fort-de-France':
      'Fort-de-France',
  'France':
      'France',
  'Gabon':
      'Gabon',
  'Ghana':
      'Ghana',
  'Grèce':
      'Greece',
  'Guadeloupe':
      'Guadeloupe',
  'Guinée':
      'Guinea',
  'Guyane':
      'French Guiana',
  'Hanoï':
      'Hanoi',
  'Haïti':
      'Haiti',
  'Inde':
      'India',
  'Indonésie':
      'Indonesia',
  'Irlande':
      'Ireland',
  'Italie':
      'Italy',
  'Jakarta':
      'Jakarta',
  'Japon':
      'Japan',
  'Kenya':
      'Kenya',
  'Kigali':
      'Kigali',
  'Kinshasa':
      'Kinshasa',
  'La Réunion':
      'Réunion',
  'Le Caire':
      'Cairo',
  'Liban':
      'Lebanon',
  'Libreville':
      'Libreville',
  'Lima':
      'Lima',
  'Lisbonne':
      'Lisbon',
  'Lomé':
      'Lomé',
  'Londres':
      'London',
  'Luxembourg':
      'Luxembourg',
  'Madagascar':
      'Madagascar',
  'Madrid':
      'Madrid',
  'Mali':
      'Mali',
  'Mamoudzou':
      'Mamoudzou',
  'Manille':
      'Manila',
  'Maroc':
      'Morocco',
  'Martinique':
      'Martinique',
  'Mauritanie':
      'Mauritania',
  'Mayotte':
      'Mayotte',
  'Mexico':
      'Mexico City',
  'Mexique':
      'Mexico',
  'Montevideo':
      'Montevideo',
  'N\'Djaména':
      'N\'Djamena',
  'Nairobi':
      'Nairobi',
  'New Delhi':
      'New Delhi',
  'Niamey':
      'Niamey',
  'Niger':
      'Niger',
  'Nigéria':
      'Nigeria',
  'Norvège':
      'Norway',
  'Nouakchott':
      'Nouakchott',
  'Nouméa':
      'Nouméa',
  'Nouvelle-Calédonie':
      'New Caledonia',
  'Nouvelle-Zélande':
      'New Zealand',
  'Oslo':
      'Oslo',
  'Ottawa':
      'Ottawa',
  'Ouagadougou':
      'Ouagadougou',
  'Papeete':
      'Papeete',
  'Paris':
      'Paris',
  'Pays-Bas':
      'Netherlands',
  'Philippines':
      'Philippines',
  'Pologne':
      'Poland',
  'Polynésie française':
      'French Polynesia',
  'Port-au-Prince':
      'Port-au-Prince',
  'Portugal':
      'Portugal',
  'Prague':
      'Prague',
  'Pretoria':
      'Pretoria',
  'Pékin':
      'Beijing',
  'Pérou':
      'Peru',
  'Rabat':
      'Rabat',
  'Rome':
      'Rome',
  'Roumanie':
      'Romania',
  'Royaume-Uni':
      'United Kingdom',
  'Rwanda':
      'Rwanda',
  'République démocratique du Congo':
      'Democratic Republic of the Congo',
  'Saint-Denis':
      'Saint-Denis',
  'Santiago':
      'Santiago',
  'Stockholm':
      'Stockholm',
  'Suisse':
      'Switzerland',
  'Suède':
      'Sweden',
  'Sénégal':
      'Senegal',
  'Tchad':
      'Chad',
  'Tchéquie':
      'Czechia',
  'Thaïlande':
      'Thailand',
  'Togo':
      'Togo',
  'Tokyo':
      'Tokyo',
  'Tunis':
      'Tunis',
  'Tunisie':
      'Tunisia',
  'Turquie':
      'Türkiye',
  'Uruguay':
      'Uruguay',
  'Varsovie':
      'Warsaw',
  'Vienne':
      'Vienna',
  'Viêt Nam':
      'Vietnam',
  'Washington':
      'Washington, D.C.',
  'Wellington':
      'Wellington',
  'Yaoundé':
      'Yaoundé',
  'Zagreb':
      'Zagreb',
  'Zone tropicale':
      'Tropical zone',
  'Égypte':
      'Egypt',
  'États-Unis':
      'United States',
  'Éthiopie':
      'Ethiopia',
  'Jardin 1':
      'Garden 1',
  'COLLECTION':
      'COLLECTION',
  'Quand s\'en servir':
      'When to use it',
  'Comment l\'utiliser':
      'How to use it',
  'Combien il en faut':
      'How much you need',
  'Entretien':
      'Upkeep',
  'À faire soi-même':
      'Make it yourself',
  'Tropical à hiver frais':
      'Cool-winter tropics',
  'Mousson d\'été, hiver sec et frais : les légumes tempérés poussent de novembre à mars.':
      'Summer monsoon, dry cool winter: temperate vegetables grow from November to March.',
  'Saison fraîche':
      'Cool season',
  'Langue passée en {0}. Tu peux la changer juste en dessous.':
      'Language switched to {0}. You can change it just below.',
  'Le pays choisit le calendrier de semis, les saisons et la langue.':
      'The country sets the sowing calendar, the seasons and the language.',
};
