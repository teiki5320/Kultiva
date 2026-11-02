/// Les textes des tutos, en espagnol.
///
/// Clé = le texte **français** exact, espaces normalisés — comme pour
/// l'anglais, et pour la même raison : les 34 fichiers HTML ne sont
/// jamais modifiés, c'est leur texte qui est remplacé au chargement.
/// Voir `tutos_i18n.dart`.
///
/// Castillan d'Espagne, tutoiement, comme `recipes_es.dart`.
///
/// ⚠️ **Les nombres ne se traduisent pas** : « 30 cm » reste
/// « 30 cm », « 100 °C » reste « 100 °C ».
/// `test/tutos_i18n_test.dart` le vérifie sur chaque chaîne.
///
/// ⚠️ **Une limite connue** : les en-têtes de mois du tuto
/// `quand_semer` sont des lettres isolées. La clé « J » sert à la
/// fois à janvier, juin et juillet ; en espagnol janvier est « E ».
/// La colonne de janvier affiche donc un J. Pour corriger il
/// faudrait rendre ces clés uniques côté extracteur.
const Map<String, String> tutoTextsEs = <String, String>{
  'Associations de plantes':
      'Asociaciones de plantas',
  'Aménagement':
      'Distribución',
  'Le compagnonnage au potager':
      'Asociación de cultivos en el huerto',
  'L\'essentiel':
      'Lo esencial',
  'Certaines plantes s\'entraident, d\'autres se gênent. En les associant bien, tu réduis les maladies, repousses les nuisibles et améliores les récoltes naturellement.':
      'Algunas plantas se ayudan entre sí y otras se estorban. Si las asocias bien, reduces las enfermedades, ahuyentas las plagas y mejoras las cosechas de forma natural.',
  'Les bonnes associations':
      'Las buenas asociaciones',
  'Légume':
      'Hortaliza',
  'Bons compagnons':
      'Buenas compañeras',
  '🍅 Tomate':
      '🍅 Tomate',
  'Basilic, carotte, persil':
      'Albahaca, zanahoria, perejil',
  '🥕 Carotte':
      '🥕 Zanahoria',
  'Poireau, oignon, tomate':
      'Puerro, cebolla, tomate',
  '🥒 Courgette':
      '🥒 Calabacín',
  'Maïs, haricot, capucine':
      'Maíz, judía, capuchina',
  '🥬 Salade':
      '🥬 Lechuga',
  'Radis, carotte, fraisier':
      'Rábano, zanahoria, fresera',
  '🫘 Haricot':
      '🫘 Judía',
  'Maïs, courgette, carotte':
      'Maíz, calabacín, zanahoria',
  '🧅 Oignon':
      '🧅 Cebolla',
  'Carotte, tomate, fraisier':
      'Zanahoria, tomate, fresera',
  '🍓 Fraisier':
      '🍓 Fresera',
  'Salade, oignon, ail':
      'Lechuga, cebolla, ajo',
  '🥦 Chou':
      '🥦 Col',
  'Céleri, betterave, tomate':
      'Apio, remolacha, tomate',
  'Les associations à éviter':
      'Las asociaciones que hay que evitar',
  'Tomate + pomme de terre':
      'Tomate + patata',
  'Même famille (solanacées) : elles partagent les mêmes maladies, notamment le mildiou qui se propage de l\'une à l\'autre.':
      'Misma familia (solanáceas): comparten las mismas enfermedades, sobre todo el mildiu, que pasa de una a otra.',
  'Oignon + haricot':
      'Cebolla + judía',
  'Les alliacées (oignon, ail, poireau) freinent la croissance des légumineuses (haricot, pois, fève).':
      'Las aliáceas (cebolla, ajo, puerro) frenan el crecimiento de las leguminosas (judía, guisante, haba).',
  'Concombre + tomate':
      'Pepino + tomate',
  'Ces deux gourmands se font concurrence pour les nutriments et l\'eau. Ils sont aussi sensibles aux mêmes maladies.':
      'Estos dos golosos compiten por los nutrientes y el agua. Además, son sensibles a las mismas enfermedades.',
  'Chou + fraisier':
      'Col + fresera',
  'Le chou étouffe le fraisier avec son feuillage imposant et lui vole la lumière nécessaire à la fructification.':
      'La col ahoga a la fresera con su follaje imponente y le quita la luz que necesita para fructificar.',
  'Les plantes alliées':
      'Las plantas aliadas',
  'Œillet d\'Inde':
      'Clavelón',
  'Repousse les pucerons, les aleurodes et les nématodes. Plante-le au pied des tomates et autour du potager.':
      'Ahuyenta pulgones, moscas blancas y nematodos. Plántalo al pie de los tomates y alrededor del huerto.',
  'Capucine':
      'Capuchina',
  'Attire les pucerons loin des légumes : elle sert de plante piège. Ses fleurs sont comestibles en bonus.':
      'Atrae a los pulgones lejos de las hortalizas: funciona como planta trampa. Sus flores son comestibles, de regalo.',
  'Bourrache':
      'Borraja',
  'Attire les pollinisateurs et repousse les limaces. Ses fleurs bleues égayent le potager et se mangent en salade.':
      'Atrae a los polinizadores y ahuyenta a las babosas. Sus flores azules alegran el huerto y se comen en ensalada.',
  'Basilic et aneth':
      'Albahaca y eneldo',
  'Le basilic protège les tomates des mouches blanches. L\'aneth attire les syrphes, prédateurs naturels des pucerons.':
      'La albahaca protege a los tomates de las moscas blancas. El eneldo atrae a los sírfidos, depredadores naturales de los pulgones.',
  'Le conseil du jardinier':
      'El consejo del hortelano',
  'La règle la plus simple : mélange les familles de légumes et ajoute des fleurs partout. La diversité est la meilleure protection naturelle.':
      'La regla más sencilla: mezcla las familias de hortalizas y pon flores por todas partes. La diversidad es la mejor protección natural.',
  'À éviter':
      'Lo que hay que evitar',
  'Regrouper la même famille :':
      'Agrupar la misma familia:',
  'les maladies et parasites se propagent plus vite entre plantes apparentées.':
      'las enfermedades y los parásitos se propagan más deprisa entre plantas emparentadas.',
  'Ignorer les incompatibilités :':
      'Ignorar las incompatibilidades:',
  'certaines plantes sécrètent des substances qui inhibent la croissance de leurs voisines.':
      'algunas plantas segregan sustancias que inhiben el crecimiento de sus vecinas.',
  'Oublier les fleurs :':
      'Olvidar las flores:',
  'un potager sans fleurs attire moins de pollinisateurs et plus de ravageurs.':
      'un huerto sin flores atrae a menos polinizadores y a más plagas.',
  'Planter trop serré :':
      'Plantar demasiado apretado:',
  'même les bonnes associations échouent si les plantes manquent d\'espace et de lumière.':
      'hasta las buenas asociaciones fracasan si a las plantas les falta espacio y luz.',

  // ─── attirer_pollinisateurs (40 textes, 356 mots) ───
  'Attirer les pollinisateurs':
      'Atraer a los polinizadores',
  'Astuces':
      'Trucos',
  'Sans eux, pas de récolte':
      'Sin ellos, no hay cosecha',
  'Abeilles, bourdons, papillons et syrphes pollinisent 80% des cultures du potager. Les attirer, c\'est assurer tes récoltes naturellement.':
      'Abejas, abejorros, mariposas y sírfidos polinizan el 80% de los cultivos del huerto. Atraerlos es asegurar tus cosechas de forma natural.',
  'Les fleurs qui les attirent':
      'Las flores que los atraen',
  'Lavande, sauge, thym 💜':
      'Lavanda, salvia, tomillo 💜',
  'Les aromatiques méditerranéennes sont irrésistibles pour les abeilles. Plantées en bordure, elles protègent aussi du vent.':
      'Las aromáticas mediterráneas son irresistibles para las abejas. Plantadas en el borde, también protegen del viento.',
  'Tournesol, cosmos 🌻':
      'Girasol, cosmos 🌻',
  'Grandes fleurs bien visibles qui attirent de loin. Semis facile et direct au printemps.':
      'Flores grandes y muy visibles que atraen desde lejos. Siembra fácil y directa en primavera.',
  'Bourrache, phacélie 🌼':
      'Borraja, facelia 🌼',
  'Les championnes de la pollinisation. La bourrache se ressème toute seule, la phacélie améliore le sol.':
      'Las campeonas de la polinización. La borraja se resiembra sola y la facelia mejora el suelo.',
  'Œillet d\'Inde, souci 🌺':
      'Clavelón, caléndula 🌺',
  'Double emploi : attirent les pollinisateurs et repoussent les pucerons et nématodes du potager.':
      'Doble función: atraen a los polinizadores y ahuyentan a los pulgones y los nematodos del huerto.',
  'Créer des refuges':
      'Crear refugios',
  'Hôtel à insectes 🏨':
      'Hotel de insectos 🏨',
  'Un assemblage de bûches percées, tiges creuses et pommes de pin. Orienté sud-est, à l\'abri de la pluie.':
      'Un montaje de troncos perforados, tallos huecos y piñas. Orientado al sureste y a resguardo de la lluvia.',
  'Tas de bois 🪵':
      'Montón de leña 🪵',
  'Empile quelques bûches dans un coin du jardin. Les insectes y hivernent et les hérissons aussi.':
      'Apila unos cuantos troncos en un rincón del jardín. Los insectos invernan ahí, y los erizos también.',
  'Point d\'eau 💧':
      'Punto de agua 💧',
  'Une coupelle avec des cailloux et de l\'eau permet aux abeilles de boire sans se noyer.':
      'Un platillo con piedrecitas y agua permite que las abejas beban sin ahogarse.',
  'Haies fleuries 🌿':
      'Setos con flores 🌿',
  'Aubépine, sureau, cornouiller : des haies champêtres qui nourrissent les pollinisateurs toute l\'année.':
      'Espino, saúco, cornejo: setos campestres que alimentan a los polinizadores durante todo el año.',
  'Les bonnes pratiques':
      'Las buenas prácticas',
  'Floraison étalée 🗓️':
      'Floración escalonada 🗓️',
  'Choisis des plantes qui fleurissent à différentes saisons pour nourrir les pollinisateurs de mars à octobre.':
      'Elige plantas que florezcan en distintas estaciones para alimentar a los polinizadores de marzo a octubre.',
  'Zéro pesticide 🚫':
      'Cero pesticidas 🚫',
  'Même les produits « bio » peuvent tuer les insectes utiles. Privilégie les solutions mécaniques et préventives.':
      'Incluso los productos «ecológicos» pueden matar a los insectos útiles. Da preferencia a las soluciones mecánicas y preventivas.',
  'Tonte raisonnée 🌱':
      'Siega con cabeza 🌱',
  'Laisse des zones de pelouse haute avec trèfle et pâquerettes. Les abeilles adorent le trèfle blanc.':
      'Deja zonas de césped alto con trébol y margaritas. A las abejas les encanta el trébol blanco.',
  'Variétés anciennes 🌻':
      'Variedades antiguas 🌻',
  'Les fleurs doubles modernes sont souvent stériles : préfère les variétés simples et anciennes, riches en nectar.':
      'Las flores dobles modernas suelen ser estériles: prefiere las variedades sencillas y antiguas, ricas en néctar.',
  'Une bordure de fleurs sauvages le long de ton potager suffit à doubler tes rendements. Sème un mélange « prairie fleurie » et laisse faire la nature.':
      'Un borde de flores silvestres a lo largo de tu huerto basta para duplicar tus rendimientos. Siembra una mezcla de «pradera florida» y deja que la naturaleza haga su trabajo.',
  'Utiliser des pesticides chimiques :':
      'Usar pesticidas químicos:',
  'ils tuent les pollinisateurs et appauvrissent la biodiversité de ton jardin.':
      'matan a los polinizadores y empobrecen la biodiversidad de tu jardín.',
  'Tout tondre ras :':
      'Cortarlo todo al ras:',
  'une pelouse tondue à ras est un désert pour les insectes.':
      'un césped cortado al ras es un desierto para los insectos.',
  'Ne planter que des fleurs doubles :':
      'Plantar solo flores dobles:',
  'elles sont souvent stériles et sans nectar.':
      'suelen ser estériles y no tienen néctar.',
  'Nettoyer tout le jardin en automne :':
      'Limpiar todo el jardín en otoño:',
  'les tiges sèches et feuilles mortes abritent les insectes l\'hiver.':
      'los tallos secos y las hojas muertas dan cobijo a los insectos en invierno.',

  // ─── bien_arroser (37 textes, 253 mots) ───
  'Bien arroser':
      'Regar bien',
  'Arrosage':
      'Riego',
  'La juste quantité au bon moment':
      'La cantidad justa en el momento justo',
  'Un bon arrosage, c\'est une eau qui descend en profondeur pour forcer les racines à plonger. Mieux vaut arroser beaucoup et moins souvent que peu et tous les jours.':
      'Un buen riego es agua que baja en profundidad para obligar a las raíces a hundirse. Más vale regar mucho y con menos frecuencia que poco y todos los días.',
  'Les règles d\'or':
      'Las reglas de oro',
  'Arrose le soir ou tôt le matin 🌙':
      'Riega al atardecer o a primera hora de la mañana 🌙',
  'Évite le plein soleil : l\'eau s\'évapore et les gouttes peuvent brûler les feuilles par effet loupe.':
      'Evita el sol directo: el agua se evapora y las gotas pueden quemar las hojas por efecto lupa.',
  'Vise le pied, pas les feuilles':
      'Apunta al pie, no a las hojas',
  'L\'eau sur les feuilles favorise les maladies comme le mildiou ou l\'oïdium, surtout le soir.':
      'El agua sobre las hojas favorece enfermedades como el mildiu o el oídio, sobre todo por la noche.',
  'Arrose en profondeur 💦':
      'Riega en profundidad 💦',
  'L\'eau doit atteindre 15-20 cm sous la surface. Un petit trou creusé avec le doigt te permet de vérifier.':
      'El agua debe llegar a 15-20 cm bajo la superficie. Un pequeño hoyo hecho con el dedo te permite comprobarlo.',
  'Espace les arrosages':
      'Espacia los riegos',
  'Laisse la surface sécher entre deux arrosages. Les racines descendront chercher l\'eau plus en profondeur.':
      'Deja que la superficie se seque entre dos riegos. Las raíces bajarán a buscar el agua más en profundidad.',
  'Paille autour des plants 🍂':
      'Pon paja alrededor de las plantas 🍂',
  'Un paillage de 5-7 cm garde l\'humidité et divise les besoins en eau par deux.':
      'Un acolchado de 5-7 cm conserva la humedad y reduce a la mitad las necesidades de agua.',
  'Besoins par légume':
      'Necesidades por hortaliza',
  'Fréquence':
      'Frecuencia',
  'Quantité':
      'Cantidad',
  '2x/sem':
      '2x/sem',
  '2-3 L/pied':
      '2-3 L/planta',
  '3x/sem':
      '3x/sem',
  '3-5 L/pied':
      '3-5 L/planta',
  '1-2x/sem':
      '1-2x/sem',
  '10 L/m²':
      '10 L/m²',
  'Tous les 2j':
      'Cada 2 días',
  '5 L/m²':
      '5 L/m²',
  '🌶️ Poivron':
      '🌶️ Pimiento',
  '2 L/pied':
      '2 L/planta',
  'Enfonce ton doigt dans la terre sur 3 cm. Si c\'est sec, arrose. Si c\'est humide, attends. Cette méthode vaut mieux que n\'importe quelle règle de fréquence fixe.':
      'Hunde el dedo 3 cm en la tierra. Si está seca, riega. Si está húmeda, espera. Este método vale más que cualquier regla de frecuencia fija.',
  'Arroser un peu tous les jours :':
      'Regar un poco todos los días:',
  'les racines restent en surface et deviennent fragiles.':
      'las raíces se quedan en la superficie y se vuelven frágiles.',
  'Arroser en plein soleil :':
      'Regar a pleno sol:',
  'choc thermique et brûlures sur les feuilles.':
      'choque térmico y quemaduras en las hojas.',
  'Mouiller les feuilles le soir :':
      'Mojar las hojas por la noche:',
  'l\'humidité stagnante favorise les maladies.':
      'la humedad estancada favorece las enfermedades.',
  'Oublier de pailler :':
      'Olvidarse de acolchar:',
  'le sol sèche deux fois plus vite et tu arroses le double.':
      'el suelo se seca el doble de rápido y acabas regando el doble.',

  // ─── conserver_legumes (32 textes, 290 mots) ───
  'Conserver ses légumes':
      'Conservar tus hortalizas',
  'Récolte':
      'Cosecha',
  'Garder tes récoltes toute l\'année':
      'Guardar tus cosechas todo el año',
  'Il existe quatre grandes méthodes : la cave (frais), la congélation, le bocal (stérilisation ou lacto-fermentation) et le séchage.':
      'Hay cuatro grandes métodos: la bodega (en fresco), la congelación, el tarro (esterilización o lactofermentación) y el secado.',
  'Les 4 méthodes':
      'Los 4 métodos',
  'Cave (frais et sec)':
      'Bodega (fresca y seca)',
  'Idéal pour pommes de terre, carottes, betteraves, oignons. Température 8-12 °C, obscurité, bonne ventilation. Les racines se gardent plusieurs mois.':
      'Ideal para patatas, zanahorias, remolachas y cebollas. Temperatura de 8-12 °C, oscuridad y buena ventilación. Las raíces se conservan varios meses.',
  'Congélation':
      'Congelación',
  'Blanchis les légumes 2-3 min avant de congeler. Étale-les sur un plateau avant de les ensacher pour éviter les blocs. Conservation 6-12 mois.':
      'Escalda las hortalizas 2-3 min antes de congelarlas. Extiéndelas sobre una bandeja antes de embolsarlas para que no se hagan bloques. Se conservan 6-12 meses.',
  'Bocal (stérilisation / lacto-fermentation)':
      'Tarro (esterilización / lactofermentación)',
  'Stérilise les bocaux à 100 °C. Pour la lacto-fermentation, il suffit d\'eau salée à 3 %. Les bocaux se conservent plus d\'un an.':
      'Esteriliza los tarros a 100 °C. Para la lactofermentación basta con agua salada al 3 %. Los tarros se conservan más de un año.',
  'Séchage':
      'Secado',
  'Au soleil, au four (60 °C) ou au déshydrateur. Parfait pour tomates, herbes, piments. Stocker dans des bocaux hermétiques à l\'abri de la lumière.':
      'Al sol, en el horno (60 °C) o en el deshidratador. Perfecto para tomates, hierbas y guindillas. Guárdalos en tarros herméticos, al abrigo de la luz.',
  'Trie avant de stocker':
      'Selecciona antes de guardar',
  'Élimine les légumes abîmés ou tachés : un seul fruit pourri peut contaminer tout le lot.':
      'Elimina las hortalizas estropeadas o con manchas: un solo fruto podrido puede contaminar todo el lote.',
  'Ne lave pas avant stockage':
      'No laves antes de guardar',
  'L\'humidité résiduelle accélère la dégradation. Brosse simplement la terre si nécessaire.':
      'La humedad residual acelera el deterioro. Basta con cepillar la tierra si hace falta.',
  'Sépare l\'éthylène':
      'Separa el etileno',
  'Certains fruits (pommes, tomates) émettent de l\'éthylène qui fait mûrir — et pourrir — les voisins plus vite.':
      'Algunas frutas (manzanas, tomates) emiten etileno, que hace madurar —y pudrirse— a sus vecinas más rápido.',
  'Étiquette tout 🏷️':
      'Etiqueta todo 🏷️',
  'Note le contenu et la date sur chaque bocal, sachet ou cagette. Tu éviteras les mauvaises surprises.':
      'Anota el contenido y la fecha en cada tarro, bolsa o caja. Te ahorrarás malas sorpresas.',
  'Vérifie régulièrement':
      'Revisa con regularidad',
  'Inspecte tes stocks toutes les 2 semaines et retire immédiatement ce qui commence à s\'abîmer.':
      'Inspecciona tus reservas cada 2 semanas y retira enseguida lo que empiece a estropearse.',
  'La lacto-fermentation est la méthode la plus simple et nutritive.':
      'La lactofermentación es el método más sencillo y nutritivo.',
  'Pommes avec pommes de terre :':
      'Manzanas con patatas:',
  'l\'éthylène des pommes accélère la germination des tubercules.':
      'el etileno de las manzanas acelera la germinación de los tubérculos.',
  'Conserver humide :':
      'Guardarlas húmedas:',
  'l\'excès d\'humidité provoque moisissures et pourriture en quelques jours.':
      'el exceso de humedad provoca moho y podredumbre en pocos días.',
  'Stocker à la lumière :':
      'Guardarlas a la luz:',
  'la lumière fait verdir les pommes de terre et dégrade les vitamines.':
      'la luz hace que las patatas se pongan verdes y degrada las vitaminas.',
  'Négliger la stérilisation :':
      'Descuidar la esterilización:',
  'un bocal mal stérilisé peut développer des bactéries dangereuses.':
      'un tarro mal esterilizado puede desarrollar bacterias peligrosas.',

  // ─── cultiver_igname (28 textes, 387 mots) ───
  'Cultiver l\'igname':
      'Cultivar el ñame',
  'Climat tropical':
      'Clima tropical',
  'Le roi des tubercules, patience récompensée':
      'El rey de los tubérculos: la paciencia tiene premio',
  'L\'igname est un tubercule star d\'Afrique de l\'Ouest, au cycle long de':
      'El ñame es un tubérculo estrella de África Occidental, con un ciclo largo de',
  '8 à 10 mois':
      '8 a 10 meses',
  '. Sa recette : une grosse butte de terre meuble, un bon semenceau, un tuteur solide… et de la patience ! 🐢':
      '. Su receta: un buen montón de tierra suelta, una buena semilla, un tutor resistente… ¡y paciencia! 🐢',
  'De la butte à la récolte':
      'De los montones a la cosecha',
  'Monte des buttes ou des billons ⛰️':
      'Haz montones o caballones ⛰️',
  'Des buttes de 50 cm à 1 m de haut, espacées d\'environ 1 m, en terre profonde et bien ameublie. Plus la terre est meuble, plus le tubercule descend droit et grossit.':
      'Montones de 50 cm a 1 m de altura, separados unos 1 m, en tierra profunda y bien mullida. Cuanto más suelta está la tierra, más recto baja el tubérculo y más engorda.',
  'Choisis tes semenceaux 🍠':
      'Elige tus trozos de siembra 🍠',
  'Des morceaux de tubercule sains de 200 à 400 g, sans taches ni pourriture. La tête du tubercule germe le mieux. Trempe la coupe dans la cendre et laisse cicatriser 2-3 jours à l\'ombre.':
      'Trozos de tubérculo sanos de 200 a 400 g, sin manchas ni podredumbre. La cabeza del tubérculo es la que mejor brota. Pasa el corte por ceniza y déjalo cicatrizar 2-3 días a la sombra.',
  'Plante en début de pluies 🌧️':
      'Planta al inicio de las lluvias 🌧️',
  'Enterre chaque semenceau à 5-10 cm au sommet de la butte, bourgeon vers le haut. Une couche de paille par-dessus garde la butte fraîche.':
      'Entierra cada trozo a 5-10 cm en lo alto del montón, con la yema hacia arriba. Una capa de paja por encima mantiene fresco el montón.',
  'Tuteure les lianes 🎋':
      'Pon tutores a las lianas 🎋',
  'L\'igname grimpe ! Plante un tuteur de 2 m (bambou, branche) près de chaque butte. Des lianes bien exposées à la lumière = un tubercule bien nourri.':
      '¡El ñame trepa! Clava un tutor de 2 m (bambú, rama) junto a cada montón. Lianas bien expuestas a la luz = un tubérculo bien alimentado.',
  'Entretiens sans stress 🍂':
      'Mantenimiento sin estrés 🍂',
  'Désherbe autour des buttes, remonte la terre si la pluie la tasse, paille bien. Ensuite, l\'igname pousse presque toute seule pendant des mois.':
      'Quita las malas hierbas alrededor de los montones, vuelve a subir la tierra si la lluvia la apelmaza y acolcha bien. Después, el ñame crece casi solo durante meses.',
  'Récolte au bon signal 🧺':
      'Cosecha cuando toque 🧺',
  'Quand le feuillage jaunit et sèche (8-10 mois), c\'est l\'heure. Creuse doucement autour de la butte à la main ou au bâton, sans blesser le tubercule.':
      'Cuando el follaje se pone amarillo y se seca (8-10 meses), es la hora. Cava con cuidado alrededor del montón, a mano o con un palo, sin herir el tubérculo.',
  'Pour la conservation : ne lave pas tes ignames ! Laisse-les sécher quelques heures à l\'ombre, puis range-les dans un endroit sec, aéré et sombre, posées sur des claies ou de la paille. Elles se gardent plusieurs mois. Mets de côté les plus beaux tubercules : ce seront tes semenceaux de l\'an prochain.':
      'Para conservarlos: ¡no laves los ñames! Déjalos secar unas horas a la sombra y luego guárdalos en un lugar seco, aireado y oscuro, sobre rejillas o paja. Se conservan varios meses. Aparta los tubérculos más bonitos: serán tus semillas del año que viene.',
  'Un sol caillouteux ou tassé :':
      'Un suelo pedregoso o compactado:',
  'le tubercule se déforme, fourche ou reste petit. Ameublis en profondeur avant de butter.':
      'el tubérculo se deforma, se bifurca o se queda pequeño. Afloja en profundidad antes de hacer los montones.',
  'Blesser l\'igname à la récolte :':
      'Herir el ñame al cosecharlo:',
  'chaque coupure est une porte ouverte à la pourriture. Creuse à la main plutôt qu\'à la machette près du tubercule.':
      'cada corte es una puerta abierta a la podredumbre. Cava a mano mejor que con machete cerca del tubérculo.',
  'Planter des semenceaux malades :':
      'Plantar trozos enfermos:',
  'taches, moisissures ou ramollissement = poubelle. Un mauvais semenceau contamine toute la butte.':
      'manchas, moho o blandura = a la basura. Un mal trozo contamina todo el montón.',
  'Stocker au soleil ou dans l\'humidité :':
      'Guardarlos al sol o con humedad:',
  'les tubercules verdissent, germent ou pourrissent. Ombre, air sec et surveillance régulière !':
      'los tubérculos se ponen verdes, brotan o se pudren. ¡Sombra, aire seco y revisión regular!',

  // ─── decouvrir_dashboard (122 textes, 362 mots) ───
  'Découvrir Kultiva':
      'Descubrir Kultiva',
  'Découvrir Kultiva 🌱':
      'Descubrir Kultiva 🌱',
  'Ton tableau de bord':
      'Tu panel de inicio',
  'Tout ce qu’il y a à faire aujourd’hui, en un coup d’œil.':
      'Todo lo que hay que hacer hoy, de un vistazo.',
  'Que semer ce mois-ci ?':
      '¿Qué sembrar este mes?',
  'La liste change avec ta région et la saison.':
      'La lista cambia con tu región y la estación.',
  'Et que récolter':
      'Y qué cosechar',
  'Ce qui est prêt, maintenant, chez toi.':
      'Lo que está listo ahora mismo en tu zona.',
  'Toute l’année d’un seul regard':
      'Todo el año de un solo vistazo',
  'Une ligne par légume, douze mois, rien à faire défiler de côté.':
      'Una línea por hortaliza, doce meses, sin desplazarte hacia los lados.',
  'Ton cahier de culture':
      'Tu cuaderno de cultivo',
  'Qui a soif, qui est mûr, et s’il va faire trop chaud.':
      'Quién tiene sed, quién está maduro y si va a hacer demasiado calor.',
  'Dessine tes carrés':
      'Dibuja tus cuadros',
  'Place tes plants par glisser-déposer, chaque case se souvient.':
      'Coloca tus plantas arrastrando y soltando; cada casilla lo recuerda todo.',
  'Ta saison, jour par jour':
      'Tu temporada, día a día',
  'Chaque semis, chaque arrosage, chaque récolte s’inscrit à sa date.':
      'Cada siembra, cada riego y cada cosecha se anota en su fecha.',
  'L’Étal, ton marché kawaii':
      'El Catálogo, tu mercado kawaii',
  '130 cultures en fiches détaillées, plus les accessoires.':
      '130 cultivos en fichas detalladas, además de los accesorios.',
  '50 défis photo, 50 badges':
      '50 retos fotográficos, 50 insignias',
  'Les badges récompensent ce que tu fais vraiment au jardin.':
      'Las insignias premian lo que haces de verdad en el huerto.',
  '🎒 En résumé':
      '🎒 En resumen',
  'Semer, récolter, suivre et apprendre — tout tient dans ta poche.':
      'Sembrar, cosechar, hacer seguimiento y aprender: todo cabe en tu bolsillo.',
  'Bonjour 👋':
      'Hola 👋',
  'Kultiva 🌱':
      'Kultiva 🌱',
  'Automne':
      'Otoño',
  'octobre':
      'octubre',
  '13°C':
      '13°C',
  'Semer':
      'Sembrar',
  '74 légumes':
      '74 hortalizas',
  'Récolter':
      'Cosechar',
  '39 légumes':
      '39 hortalizas',
  'Calendrier':
      'Calendario',
  'Vue annuelle':
      'Vista anual',
  'Légume du jour':
      'Hortaliza del día',
  'Mâche':
      'Canónigos',
  'Défis & badges':
      'Retos e insignias',
  'Actualités':
      'Novedades',
  'Suis-nous sur Instagram':
      'Síguenos en Instagram',
  '‹ Home':
      '‹ Inicio',
  '📅 Calendrier annuel':
      '📅 Calendario anual',
  'Semis':
      'Siembra',
  '📔 Cahier de culture':
      '📔 Cuaderno de cultivo',
  '2 jardins · 6 cases occupées · 4 plants suivis':
      '2 huertos · 6 casillas ocupadas · 4 plantas en seguimiento',
  'À faire aujourd’hui':
      'Para hacer hoy',
  'Arroser :':
      'Regar:',
  'tomate, basilic':
      'tomate, albahaca',
  'Arroser':
      'Regar',
  'À récolter :':
      'Para cosechar:',
  'laitue':
      'lechuga',
  'Mes jardins':
      'Mis huertos',
  'Potager du fond':
      'Huerto del fondo',
  '4 cases occupées':
      '4 casillas ocupadas',
  'Carré du balcon':
      'Cuadro del balcón',
  '2 cases occupées':
      '2 casillas ocupadas',
  'Au jardin en ce moment':
      'En el huerto ahora mismo',
  'Tomate · 7 sem.':
      'Tomate · 7 sem.',
  'arrosée hier':
      'regado ayer',
  'Basilic · 4 sem.':
      'Albahaca · 4 sem.',
  'arrosé hier':
      'regada ayer',
  'Laitue · 8 sem.':
      'Lechuga · 8 sem.',
  'arrosée ce matin':
      'regada esta mañana',
  'Courgette · 5 sem.':
      'Calabacín · 5 sem.',
  'Journal ›':
      'Registro ›',
  '‹ Cahier':
      '‹ Diario',
  '📖 Journal':
      '📖 Registro',
  'AUJOURD’HUI':
      'HOY',
  'Arrosé':
      'Regado',
  '· tomate':
      '· tomate',
  'HIER':
      'AYER',
  'Récolté':
      'Cosechado',
  '· radis':
      '· rábano',
  'Photo':
      'Foto',
  '· courgette':
      '· calabacín',
  '12 MAI':
      '12 MAYO',
  'Planté':
      'Plantado',
  '· 3 tomates':
      '· 3 tomates',
  '🛒 L’Étal':
      '🛒 El Catálogo',
  '🔍 Chercher une culture…':
      '🔍 Buscar un cultivo…',
  'Toutes':
      'Todos',
  'Fleurs':
      'Flores',
  'Feuilles':
      'Hojas',
  'Fruits':
      'Frutos',
  'Bulbes':
      'Bulbos',
  'Racines':
      'Raíces',
  'Tomate':
      'Tomate',
  'Carotte':
      'Zanahoria',
  'Laitue':
      'Lechuga',
  'Fraise':
      'Fresa',
  'Oignon':
      'Cebolla',
  'Poivron':
      'Pimiento',
  'Tournesol':
      'Girasol',
  'Aubergine':
      'Berenjena',
  'Piment':
      'Guindilla',
  'Brocoli':
      'Brócoli',
  'Maïs':
      'Maíz',
  'Ail':
      'Ajo',
  '🏅 Défis & badges':
      '🏅 Retos e insignias',
  '📷 Défis photo':
      '📷 Retos fotográficos',
  '🏅 Badges':
      '🏅 Insignias',
  'Ta première tomate rouge':
      'Tu primer tomate rojo',
  'Un semis qui lève':
      'Una siembra que brota',
  'Une coccinelle au potager':
      'Una mariquita en el huerto',
  'Ton panier de récolte':
      'Tu cesta de cosecha',
  'Une fleur de courgette':
      'Una flor de calabacín',
  'Une abeille au travail':
      'Una abeja trabajando',
  'Premier semis':
      'Primera siembra',
  'Arroseur fidèle':
      'Regador fiel',
  'Première récolte':
      'Primera cosecha',
  'Cahier tenu':
      'Cuaderno al día',
  'Photographe':
      'Fotógrafo',
  'Roi de la tomate':
      'Rey del tomate',
  'Ami des abeilles':
      'Amigo de las abejas',
  'Jardin fleuri':
      'Jardín en flor',
  'Main verte':
      'Mano verde',
  'Tout tient dans ta poche':
      'Todo cabe en tu bolsillo',
  'Suivre':
      'Seguir',
  'Apprendre':
      'Aprender',
  'Home':
      'Inicio',
  'Cahier':
      'Diario',
  'Étal':
      'Catálogo',
  'Tutos':
      'Guías',
  'Mettre l’animation en pause':
      'Pausar la animación',

  // ─── eau_de_pluie (31 textes, 366 mots) ───
  'Récupérer l\'eau de pluie':
      'Recoger el agua de lluvia',
  'Gratuite, douce et écologique':
      'Gratuita, blanda y ecológica',
  'L\'eau de pluie est idéale pour arroser : douce (sans calcaire), à température ambiante et gratuite. Un toit de 50 m² récupère environ 30 m³ d\'eau par an en France.':
      'El agua de lluvia es ideal para regar: blanda (sin cal), a temperatura ambiente y gratuita. Un tejado de 50 m² recoge unos 30 m³ de agua al año en Francia.',
  'Installer un récupérateur':
      'Instalar un depósito',
  'Choisis le bon volume':
      'Elige el volumen adecuado',
  'Pour un potager de 50 m², une cuve de 300 à 500 litres suffit. Au-delà, prévois 1000 litres ou plusieurs cuves en série.':
      'Para un huerto de 50 m², basta con un depósito de 300 a 500 litros. Si necesitas más, prevé 1000 litros o varios depósitos en serie.',
  'Trouve le bon emplacement':
      'Busca la ubicación adecuada',
  'Place la cuve sous une descente de gouttière, sur un sol plat et stable. Le plus près possible du potager pour faciliter l\'arrosage.':
      'Coloca el depósito bajo un bajante del canalón, sobre suelo plano y estable. Lo más cerca posible del huerto para facilitar el riego.',
  'Installe un collecteur':
      'Instala un colector',
  'Un collecteur filtrant se fixe sur la gouttière et redirige l\'eau vers la cuve. Il intègre un filtre à feuilles et un trop-plein automatique.':
      'Un colector con filtro se fija al canalón y desvía el agua hacia el depósito. Incluye un filtro para hojas y un rebosadero automático.',
  'Surélève la cuve':
      'Eleva el depósito',
  'Place-la sur des parpaings ou un socle de 30-40 cm. La gravité te donne assez de pression pour remplir un arrosoir ou brancher un tuyau.':
      'Ponlo sobre bloques de hormigón o un pedestal de 30-40 cm. La gravedad te da presión suficiente para llenar una regadera o conectar una manguera.',
  'Couvre et protège':
      'Tapa y protege',
  'Un couvercle opaque empêche les algues de proliférer et les moustiques de pondre. Vérifie qu\'il est bien fermé en permanence.':
      'Una tapa opaca impide que proliferen las algas y que los mosquitos pongan huevos. Comprueba que esté siempre bien cerrada.',
  'Entretien au fil des saisons':
      'Mantenimiento a lo largo de las estaciones',
  'Printemps':
      'Primavera',
  'Nettoie la cuve et le filtre après l\'hiver. Vérifie les raccords et reconnecte le collecteur si tu l\'avais démonté.':
      'Limpia el depósito y el filtro después del invierno. Revisa las conexiones y vuelve a conectar el colector si lo habías desmontado.',
  'Été':
      'Verano',
  'Surveille le niveau d\'eau et nettoie le filtre toutes les 2 semaines. Par canicule, l\'eau tiède de la cuve est parfaite pour les plants.':
      'Vigila el nivel de agua y limpia el filtro cada 2 semanas. En una ola de calor, el agua tibia del depósito es perfecta para las plantas.',
  'Retire les feuilles mortes du filtre régulièrement. C\'est la saison où la cuve se remplit le plus vite grâce aux pluies abondantes.':
      'Quita con regularidad las hojas muertas del filtro. Es la estación en que el depósito se llena más rápido gracias a las lluvias abundantes.',
  'Hiver':
      'Invierno',
  'Vidange partiellement la cuve et ouvre le robinet pour éviter le gel. Déconnecte le collecteur si les températures descendent sous -5°C.':
      'Vacía parcialmente el depósito y abre el grifo para evitar las heladas. Desconecta el colector si las temperaturas bajan de -5°C.',
  'L\'eau de pluie est parfaite pour arroser les plantes qui détestent le calcaire : tomates, fraisiers, hortensias, rhododendrons.':
      'El agua de lluvia es perfecta para regar las plantas que detestan la cal: tomates, fresas, hortensias, rododendros.',
  'Laisser la cuve ouverte :':
      'Dejar el depósito abierto:',
  'les moustiques pondent dans l\'eau stagnante. Un couvercle ou une moustiquaire est indispensable.':
      'los mosquitos ponen huevos en el agua estancada. Es indispensable una tapa o una mosquitera.',
  'Arroser avec de l\'eau trop froide :':
      'Regar con agua demasiado fría:',
  'en hiver, l\'eau de pluie stockée peut être glaciale. Laisse-la se réchauffer avant d\'arroser.':
      'en invierno, el agua de lluvia almacenada puede estar helada. Deja que se temple antes de regar.',
  'Laisser la cuve pleine en hiver :':
      'Dejar el depósito lleno en invierno:',
  'le gel peut fissurer la cuve. Vidange-la aux deux tiers avant les premières gelées.':
      'la helada puede agrietarlo. Vacíalo hasta dos tercios antes de las primeras heladas.',
  'Négliger le filtre :':
      'Descuidar el filtro:',
  'un filtre bouché déborde et l\'eau sale encrasse la cuve. Nettoie-le au moins une fois par mois.':
      'un filtro atascado se desborda y el agua sucia ensucia el depósito. Límpialo al menos una vez al mes.',

  // ─── engrais_naturels (36 textes, 301 mots) ───
  'Engrais naturels':
      'Abonos naturales',
  'Sol & Compost':
      'Suelo y compost',
  'Nourrir ses plantes sans chimie':
      'Alimentar a tus plantas sin química',
  'Les engrais naturels apportent les trois éléments principaux : azote (N) pour les feuilles, phosphore (P) pour les racines, potassium (K) pour les fleurs et fruits.':
      'Los abonos naturales aportan los tres elementos principales: nitrógeno (N) para las hojas, fósforo (P) para las raíces y potasio (K) para las flores y los frutos.',
  'Les engrais selon le besoin':
      'Los abonos según la necesidad',
  'N':
      'N',
  'Feuilles — Azote':
      'Hojas — Nitrógeno',
  'Purin d\'ortie, sang séché, corne broyée, fumier composté. Stimule la croissance des tiges et feuilles.':
      'Purín de ortiga, sangre seca, cuerno triturado, estiércol compostado. Estimula el crecimiento de tallos y hojas.',
  'P':
      'P',
  'Racines — Phosphore':
      'Raíces — Fósforo',
  'Poudre d\'os, farine de poisson, guano. Renforce l\'enracinement et la résistance des plants.':
      'Harina de huesos, harina de pescado, guano. Refuerza el enraizamiento y la resistencia de las plantas.',
  'K':
      'K',
  'Fleurs et fruits — Potassium':
      'Flores y frutos — Potasio',
  'Cendre de bois, purin de consoude, vinasse de betterave. Favorise la floraison et la fructification.':
      'Ceniza de madera, purín de consuelda, vinaza de remolacha. Favorece la floración y la fructificación.',
  'Oligo-éléments':
      'Oligoelementos',
  'Algues marines, lithothamne, basalte broyé. Apportent fer, magnésium, bore et autres micro-nutriments essentiels.':
      'Algas marinas, litotamnio, basalto triturado. Aportan hierro, magnesio, boro y otros micronutrientes esenciales.',
  'Fabriquer son purin d\'ortie':
      'Preparar tu propio purín de ortiga',
  'Récolte les orties':
      'Recoge las ortigas',
  'Cueille 1 kg d\'orties fraîches (avant floraison de préférence). Utilise des gants !':
      'Corta 1 kg de ortigas frescas (mejor antes de la floración). ¡Usa guantes!',
  'Hache grossièrement':
      'Pícalas a lo grueso',
  'Coupe les orties en morceaux et place-les dans un seau ou un fût non métallique.':
      'Corta las ortigas en trozos y colócalas en un cubo o un barril que no sea metálico.',
  'Ajoute l\'eau':
      'Añade el agua',
  'Couvre avec 10 litres d\'eau de pluie. L\'eau du robinet convient aussi en laissant déchlorer 24h.':
      'Cubre con 10 litros de agua de lluvia. El agua del grifo también vale si la dejas reposar 24 h para que pierda el cloro.',
  'Remue chaque jour':
      'Remueve cada día',
  'Brasse le mélange quotidiennement pendant 10 à 15 jours. Quand il ne mousse plus, c\'est prêt.':
      'Remueve la mezcla a diario durante 10 a 15 días. Cuando deje de hacer espuma, está listo.',
  'Filtre et dilue':
      'Filtra y diluye',
  'Filtre avec un tissu. Dilue à 10% (1 L de purin pour 9 L d\'eau) avant d\'arroser au pied des plants.':
      'Filtra con una tela. Diluye al 10% (1 L de purín por 9 L de agua) antes de regar al pie de las plantas.',
  'Le compost reste l\'engrais universel le plus équilibré. Il nourrit le sol et les plantes en même temps, et améliore la structure de la terre.':
      'El compost sigue siendo el abono universal más equilibrado. Alimenta el suelo y las plantas a la vez, y mejora la estructura de la tierra.',
  'Surdoser les engrais :':
      'Pasarse con la dosis:',
  'même naturels, trop d\'engrais brûle les racines et déséquilibre le sol.':
      'incluso los naturales, demasiado abono quema las raíces y desequilibra el suelo.',
  'Engrais sur sol sec :':
      'Abonar en suelo seco:',
  'arrose toujours avant d\'appliquer un engrais liquide pour éviter les brûlures.':
      'riega siempre antes de aplicar un abono líquido para evitar quemaduras.',
  'Fertiliser en hiver :':
      'Abonar en invierno:',
  'les plantes sont au repos, l\'engrais est lessivé par les pluies sans être absorbé.':
      'las plantas están en reposo y las lluvias arrastran el abono sin que se absorba.',
  'Cendres en excès :':
      'Exceso de ceniza:',
  'rendent le sol trop alcalin. Maximum une poignée par m² et par an.':
      'vuelve el suelo demasiado alcalino. Máximo un puñado por m² y por año.',

  // ─── fabriquer_ombriere (32 textes, 403 mots) ───
  'Fabriquer une ombrière':
      'Fabricar una sombra',
  'Un coin de fraîcheur pour ton potager':
      'Un rincón fresco para tu huerto',
  'Une ombrière filtre 30 à 50 % du soleil et fait baisser la température de plusieurs degrés. Sous son abri, laitues, choux et tomates continuent de pousser même en pleine saison chaude. 😎':
      'Una sombra filtra del 30 al 50 % del sol y baja la temperatura varios grados. Bajo su abrigo, lechugas, coles y tomates siguen creciendo incluso en plena época de calor. 😎',
  'Construis ta structure':
      'Construye tu estructura',
  'Choisis l\'emplacement 🧭':
      'Elige el emplazamiento 🧭',
  'Repère la course du soleil : l\'ombrière doit surtout couvrir tes cultures aux heures les plus chaudes (11h-16h). Une orientation est-ouest donne une ombre régulière toute la journée.':
      'Observa el recorrido del sol: la sombra debe cubrir sobre todo tus cultivos en las horas más calurosas (11 h-16 h). Una orientación este-oeste da una sombra regular durante todo el día.',
  'Plante les poteaux 🎋':
      'Planta los postes 🎋',
  '4 à 6 poteaux en bois ou en bambou, enterrés de 40-50 cm et bien tassés. Vise 1,8 à 2 m de hauteur : assez haut pour circuler et laisser l\'air passer.':
      'De 4 a 6 postes de madera o de bambú, enterrados de 40-50 cm y bien apisonados. Apunta a 1,8 o 2 m de altura: lo bastante alto para circular y dejar pasar el aire.',
  'Relie et consolide 🪢':
      'Une y refuerza 🪢',
  'Fixe des traverses entre les poteaux (clous, fil de fer ou corde solide) et ajoute des diagonales dans les angles : c\'est ce qui résistera aux coups de vent.':
      'Fija travesaños entre los postes (clavos, alambre o cuerda resistente) y añade diagonales en las esquinas: es lo que aguantará las rachas de viento.',
  'Tends la couverture 🕸️':
      'Tensa la cubierta 🕸️',
  'Filet d\'ombrage 30-50 % bien tendu et attaché tous les 50 cm. Pas de filet ? Des palmes tressées, nattes ou seccos posés sur les traverses font très bien le travail.':
      'Malla de sombreo del 30-50 % bien tensada y atada cada 50 cm. ¿No tienes malla? Palmas trenzadas, esteras o cañizos colocados sobre los travesaños hacen muy bien el trabajo.',
  'Installe tes cultures 🌱':
      'Instala tus cultivos 🌱',
  'Place dessous les planches de légumes-feuilles et la pépinière. Laisse les côtés ouverts pour que la brise circule et que la pluie puisse entrer.':
      'Coloca debajo los bancales de hortalizas de hoja y el semillero. Deja los lados abiertos para que circule la brisa y pueda entrar la lluvia.',
  'Qui en profite le plus ?':
      '¿Quién se beneficia más?',
  'Laitue et salades':
      'Lechuga y ensaladas',
  'Sans ombre, elles montent en graines et deviennent amères dès qu\'il fait trop chaud.':
      'Sin sombra, se espigan y se vuelven amargas en cuanto hace demasiado calor.',
  'Chou':
      'Col',
  'Il pomme beaucoup mieux au frais. L\'ombrière limite aussi le stress hydrique.':
      'Cierra mucho mejor en fresco. La sombra también limita el estrés hídrico.',
  'Tomate en saison chaude':
      'Tomate en época de calor',
  'Au-delà de 35 °C, ses fleurs coulent sans donner de fruits. Un voile à 30 % la garde productive.':
      'Por encima de 35 °C, sus flores se caen sin dar fruto. Una malla del 30 % lo mantiene productivo.',
  'Semis et jeunes plants':
      'Siembras y plantas jóvenes',
  'La pépinière entière adore l\'ombrière : levée plus régulière, arrosages moins fréquents.':
      'Todo el semillero adora la sombra: germinación más regular y riegos menos frecuentes.',
  'Fixe ton filet avec des attaches faciles à défaire : en saison fraîche ou par temps couvert, retire-le pour redonner un maximum de lumière à tes plants. Une ombrière, ça se module !':
      'Fija la malla con sujeciones fáciles de deshacer: en época fresca o con tiempo nublado, quítala para dar a tus plantas el máximo de luz. ¡Una sombra se puede ajustar!',
  'Un ombrage trop dense (plus de 60 %) :':
      'Un sombreado demasiado denso (más del 60 %):',
  'les plants filent, s\'affaiblissent et produisent peu. 30-50 %, c\'est l\'équilibre parfait.':
      'las plantas se estiran, se debilitan y producen poco. Del 30 al 50 % es el equilibrio perfecto.',
  'La bâche plastique pleine :':
      'La lona de plástico opaca:',
  'elle bloque la pluie, garde la chaleur et transforme l\'abri en four. Il faut que l\'air et l\'eau passent.':
      'bloquea la lluvia, retiene el calor y convierte el refugio en un horno. Tienen que pasar el aire y el agua.',
  'Une structure trop basse :':
      'Una estructura demasiado baja:',
  'sous 1,5 m, la chaleur s\'accumule et tu te casses le dos pour jardiner.':
      'por debajo de 1,5 m, el calor se acumula y te destrozas la espalda para trabajar.',
  'Négliger le vent :':
      'Descuidar el viento:',
  'un filet mal fixé devient une voile. Ancre bien les poteaux et vérifie les attaches après chaque tempête.':
      'una malla mal sujeta se convierte en una vela. Ancla bien los postes y revisa las sujeciones después de cada tormenta.',

  // ─── faire_compost (27 textes, 175 mots) ───
  'Faire son compost':
      'Hacer tu compost',
  'L\'or noir du jardinier':
      'El oro negro del hortelano',
  'Le compost c\'est l\'équilibre entre déchets verts (humides, azote) et déchets bruns (secs, carbone). La règle d\'or : 1 volume vert pour 2 volumes bruns, et on aère régulièrement.':
      'El compost es el equilibrio entre residuos verdes (húmedos, con nitrógeno) y residuos marrones (secos, con carbono). La regla de oro: 1 volumen de verde por 2 de marrón, y airear con regularidad.',
  'Quelle méthode choisir ?':
      '¿Qué método elegir?',
  'En bac':
      'En compostador',
  'Jardin petit ou moyen, discret':
      'Jardín pequeño o mediano, discreto',
  'En tas':
      'En montón',
  'Grand jardin, gros volumes':
      'Jardín grande, grandes volúmenes',
  '📍 Emplacement au contact du sol':
      '📍 Ubicación en contacto con el suelo',
  '🍂 Couche brune au fond':
      '🍂 Capa marrón en el fondo',
  '🔄 Alterne vert et brun':
      '🔄 Alterna verde y marrón',
  '💨 Aère tous les 15 jours':
      '💨 Airea cada 15 días',
  '💧 Humide comme une éponge pressée':
      '💧 Húmedo como una esponja escurrida',
  'Ce qu\'on peut mettre':
      'Lo que se puede echar',
  'Déchets verts':
      'Residuos verdes',
  'Épluchures, marc de café, tontes fraîches, restes de légumes, mauvaises herbes non montées en graines.':
      'Peladuras, posos de café, césped recién cortado, restos de hortalizas, malas hierbas sin semillas.',
  'Déchets bruns':
      'Residuos marrones',
  'Feuilles mortes, branchages broyés, carton brun non imprimé, paille, sciure de bois non traité.':
      'Hojas muertas, ramas trituradas, cartón marrón sin imprimir, paja, serrín de madera sin tratar.',
  'Le compost est prêt quand il est brun foncé, friable et qu\'il sent bon la forêt.':
      'El compost está listo cuando es de color marrón oscuro, desmenuzable y huele bien a bosque.',
  'Viande et poisson :':
      'Carne y pescado:',
  'attirent les nuisibles et provoquent des odeurs nauséabondes.':
      'atraen plagas y provocan olores nauseabundos.',
  'Plantes malades :':
      'Plantas enfermas:',
  'les pathogènes peuvent survivre et contaminer le compost.':
      'los patógenos pueden sobrevivir y contaminar el compost.',
  'Trop d\'agrumes :':
      'Demasiados cítricos:',
  'acidifient le compost et ralentissent la décomposition.':
      'acidifican el compost y ralentizan la descomposición.',
  'Excréments animaux :':
      'Excrementos de animales:',
  'risques sanitaires importants (parasites, bactéries).':
      'riesgos sanitarios importantes (parásitos, bacterias).',

  // ─── gain_temps_jardin (41 textes, 412 mots) ───
  'Gain de temps au jardin':
      'Ahorrar tiempo en el huerto',
  'Plus de récolte, moins d\'effort':
      'Más cosecha, menos esfuerzo',
  'Un potager qui demande peu de temps existe : il suffit de choisir les bonnes pratiques dès le départ. Organisation et choix malins valent mieux que des heures de travail.':
      'Un huerto que requiere poco tiempo existe: basta con elegir las buenas prácticas desde el principio. La organización y las decisiones inteligentes valen más que horas de trabajo.',
  'Les automatismes à mettre en place':
      'Los automatismos que conviene montar',
  'Paillage permanent 🍂':
      'Acolchado permanente 🍂',
  'Couvre toujours le sol : moins d\'arrosage, moins de désherbage, moins de travail. C\'est LE geste qui change tout.':
      'Cubre siempre el suelo: menos riego, menos escarda, menos trabajo. Es EL gesto que lo cambia todo.',
  'Goutte à goutte programmé 💧':
      'Goteo programado 💧',
  'Un tuyau poreux avec un programmateur mécanique. 30 minutes le soir, et tu n\'y penses plus.':
      'Una manguera porosa con un programador mecánico. 30 minutos por la tarde y te olvidas.',
  'Compost à proximité 🧱':
      'Compost cerca 🧱',
  'Place ton composteur le plus près possible du potager. Moins de trajets = plus de régularité.':
      'Pon el compostador lo más cerca posible del huerto. Menos trayectos = más constancia.',
  'Outils près du potager 🧰':
      'Herramientas junto al huerto 🧰',
  'Un petit rangement sur place avec les essentiels : sécateur, griffe, arrosoir. Tu gagnes 10 minutes à chaque passage.':
      'Un pequeño almacén en el lugar con lo esencial: tijeras de podar, garra, regadera. Ganas 10 minutos en cada visita.',
  'Choix des plantes':
      'Elección de las plantas',
  'Vivaces en priorité 🌿':
      'Primero las perennes 🌿',
  'Rhubarbe, artichaut, oseille, ciboulette : on plante une fois, on récolte pendant des années.':
      'Ruibarbo, alcachofa, acedera, cebollino: se planta una vez y se cosecha durante años.',
  'Variétés faciles 💪':
      'Variedades fáciles 💪',
  'Courgette, haricot, radis, tomate cerise : des valeurs sûres qui produisent sans souci.':
      'Calabacín, judía, rábano, tomate cherry: valores seguros que producen sin problemas.',
  'Salades à couper ✂️':
      'Ensaladas de corte ✂️',
  'Mesclun, roquette, mâche : tu coupes les feuilles, elles repoussent. Jusqu\'à 4 récoltes par semis.':
      'Mezclum, rúcula, canónigos: cortas las hojas y vuelven a crecer. Hasta 4 cosechas por siembra.',
  'Engrais verts 🌾':
      'Abonos verdes 🌾',
  'Trèfle, phacélie, moutarde : ils couvrent le sol, nourrissent la terre et empêchent les mauvaises herbes.':
      'Trébol, facelia, mostaza: cubren el suelo, alimentan la tierra e impiden las malas hierbas.',
  'Routine efficace':
      'Rutina eficaz',
  '15 minutes par jour ⏱️':
      '15 minutos al día ⏱️',
  'Un quart d\'heure quotidien vaut mieux que 3 heures le dimanche. Tu repères vite les problèmes.':
      'Un cuarto de hora diario vale más que 3 horas el domingo. Detectas enseguida los problemas.',
  'Le matin tôt 🌅':
      'A primera hora de la mañana 🌅',
  'Le matin, les limaces sont visibles, la terre est fraîche, et toi tu es motivé. C\'est le meilleur créneau.':
      'Por la mañana se ven las babosas, la tierra está fresca y tú estás motivado. Es la mejor franja.',
  'Outils ergonomiques 🛠️':
      'Herramientas ergonómicas 🛠️',
  'Un bon outil à la bonne taille évite la fatigue. La grelinette remplace le motoculteur et le bêchage.':
      'Una buena herramienta del tamaño adecuado evita el cansancio. La horca de doble mango sustituye al motocultor y al cavado.',
  'Planning saisonnier 📅':
      'Planificación estacional 📅',
  'Note quand semer et quand récolter. Kultiva t\'aide avec son calendrier, mais un tableau au mur marche aussi.':
      'Anota cuándo sembrar y cuándo cosechar. Kultiva te ayuda con su calendario, pero una tabla en la pared también sirve.',
  'Délègue à la nature 🌍':
      'Delega en la naturaleza 🌍',
  'Laisse les coccinelles gérer les pucerons, les vers de terre aérer le sol. Moins tu interviens, mieux ça pousse.':
      'Deja que las mariquitas se ocupen de los pulgones y las lombrices de tierra aireen el suelo. Cuanto menos intervienes, mejor crece.',
  'Le secret des jardiniers efficaces : ne pas chercher la perfection. Un potager un peu sauvage est souvent plus productif qu\'un jardin impeccable.':
      'El secreto de los hortelanos eficaces: no buscar la perfección. Un huerto algo silvestre suele ser más productivo que un jardín impecable.',
  'Voir trop grand au début :':
      'Pensar demasiado a lo grande al principio:',
  '10 m² bien gérés produisent plus que 50 m² abandonnés en juillet.':
      '10 m² bien llevados producen más que 50 m² abandonados en julio.',
  'Retourner la terre chaque année :':
      'Dar la vuelta a la tierra cada año:',
  'ça détruit la vie du sol. Préfère la grelinette ou le paillage permanent.':
      'destruye la vida del suelo. Prefiere la horca de doble mango o el acolchado permanente.',
  'Courir après les problèmes :':
      'Correr detrás de los problemas:',
  'la prévention (paillage, rotation, associations) évite 80% des soucis.':
      'la prevención (acolchado, rotación, asociaciones) evita el 80% de los quebraderos de cabeza.',
  'Tout nettoyer en automne :':
      'Limpiarlo todo en otoño:',
  'les résidus de culture protègent le sol et nourrissent les vers de terre.':
      'los residuos de cultivo protegen el suelo y alimentan a las lombrices de tierra.',

  // ─── goutte_a_goutte (34 textes, 316 mots) ───
  'Arrosage goutte à goutte':
      'Riego por goteo',
  'Économe, automatique et efficace':
      'Económico, automático y eficaz',
  'Le goutte à goutte délivre l\'eau directement au pied des plants, en petite quantité et lentement. Il économise 30 à 50% d\'eau et évite les maladies foliaires.':
      'El goteo entrega el agua directamente al pie de las plantas, en pequeña cantidad y despacio. Ahorra del 30 al 50% de agua y evita las enfermedades de las hojas.',
  'Installer son système':
      'Instalar tu sistema',
  'Choisis le bon kit':
      'Elige el kit adecuado',
  'Un tuyau principal de 16 mm, des goutteurs réglables (2 à 8 L/h), des raccords en T et un filtre à tamis. Prévois un réducteur de pression si tu branches sur le réseau.':
      'Una tubería principal de 16 mm, goteros regulables (2 a 8 L/h), conexiones en T y un filtro de malla. Prevé un reductor de presión si te conectas a la red.',
  'Planifie ton circuit':
      'Planifica tu circuito',
  'Dessine ton potager et le trajet du tuyau. Prévois un goutteur par plant pour les tomates et courgettes, et un tuyau poreux pour les lignes de salades.':
      'Dibuja tu huerto y el recorrido de la tubería. Prevé un gotero por planta para los tomates y los calabacines, y una manguera porosa para las líneas de lechugas.',
  'Connecte le réseau':
      'Conecta la red',
  'Branche le filtre puis le réducteur de pression sur le robinet. Déroule le tuyau principal et perce-le aux emplacements des goutteurs.':
      'Conecta el filtro y después el reductor de presión al grifo. Extiende la tubería principal y perfórala en los puntos donde van los goteros.',
  'Règle le débit':
      'Regula el caudal',
  'Ouvre le robinet et ajuste chaque goutteur. Vérifie que l\'eau perle lentement (une goutte par seconde environ) et que tous les goutteurs fonctionnent.':
      'Abre el grifo y ajusta cada gotero. Comprueba que el agua perla despacio (más o menos una gota por segundo) y que todos los goteros funcionan.',
  'Programme un minuteur':
      'Programa un temporizador',
  'Un programmateur à pile sur le robinet te permet d\'automatiser. Programme un arrosage tôt le matin ou en soirée, 30 à 60 minutes selon tes plants.':
      'Un programador de pilas en el grifo te permite automatizar. Programa un riego a primera hora de la mañana o al anochecer, de 30 a 60 minutos según tus plantas.',
  'Adapter à chaque légume':
      'Adaptarlo a cada hortaliza',
  'Goutteurs':
      'Goteros',
  'Durée':
      'Duración',
  '1 × 4 L/h':
      '1 × 4 L/h',
  '45 min':
      '45 min',
  '1 × 8 L/h':
      '1 × 8 L/h',
  '30 min':
      '30 min',
  'Tuyau poreux':
      'Manguera porosa',
  '20 min':
      '20 min',
  '40 min':
      '40 min',
  '1 × 2 L/h':
      '1 × 2 L/h',
  'Combine goutte à goutte et paillage : tu peux descendre à 1 seul arrosage par semaine sur les tomates, même en plein été.':
      'Combina goteo y acolchado: puedes bajar a 1 solo riego por semana en los tomates, incluso en pleno verano.',
  'Oublier le filtre :':
      'Olvidar el filtro:',
  'les goutteurs se bouchent très vite avec le calcaire et les impuretés de l\'eau.':
      'los goteros se obstruyen muy rápido con la cal y las impurezas del agua.',
  'Négliger le réducteur de pression :':
      'Descuidar el reductor de presión:',
  'la pression du réseau (3-5 bars) fait éclater les raccords. Le goutte à goutte fonctionne à 1-1,5 bar.':
      'la presión de la red (3-5 bares) hace reventar las conexiones. El goteo funciona a 1-1,5 bar.',
  'Arroser trop peu de temps :':
      'Regar durante muy poco tiempo:',
  '10 minutes ne suffisent pas, l\'eau reste en surface. Préfère 30-60 minutes à faible débit.':
      '10 minutos no bastan, el agua se queda en la superficie. Prefiere 30-60 minutos con poco caudal.',
  'Oublier la purge hivernale :':
      'Olvidar el vaciado de invierno:',
  'vidange tout le circuit avant les gelées pour éviter que les tuyaux n\'éclatent.':
      'vacía todo el circuito antes de las heladas para que las tuberías no revienten.',

  // ─── jardiner_avec_lune (50 textes, 345 mots) ───
  'Jardiner avec la lune':
      'Cultivar con la luna',
  'Le':
      'El',
  'calendrier':
      'calendario',
  'lunaire au potager':
      'lunar del huerto',
  'Jardiner avec la lune, c\'est tenir compte de ses cycles pour optimiser semis, plantation, récolte et taille.':
      'Cultivar con la luna es tener en cuenta sus ciclos para optimizar la siembra, la plantación, la cosecha y la poda.',
  'Les deux cycles importants':
      'Los dos ciclos importantes',
  'Lune montante / descendante 🌗':
      'Luna ascendente / descendente 🌗',
  'Cycle de 27 jours lié à la position de la lune dans le ciel. Montante = la sève monte (semer, greffer). Descendante = la sève descend (planter, tailler, récolter).':
      'Ciclo de 27 días ligado a la posición de la luna en el cielo. Ascendente = la savia sube (sembrar, injertar). Descendente = la savia baja (plantar, podar, cosechar).',
  'Lune croissante / décroissante 🌓':
      'Luna creciente / menguante 🌓',
  'Cycle de 29,5 jours lié à la lumière visible. Croissante = de la nouvelle lune à la pleine lune (vitalité). Décroissante = de la pleine lune à la nouvelle lune (conservation).':
      'Ciclo de 29,5 días ligado a la luz visible. Creciente = de la luna nueva a la luna llena (vitalidad). Menguante = de la luna llena a la luna nueva (conservación).',
  'Que faire à chaque phase':
      'Qué hacer en cada fase',
  'Lune montante 🌒':
      'Luna ascendente 🌒',
  'Semer, greffer, récolter les fruits et les légumes-feuilles. La sève monte dans les parties aériennes.':
      'Sembrar, injertar, cosechar los frutos y las hortalizas de hoja. La savia sube por las partes aéreas.',
  'Lune descendante 🌘':
      'Luna descendente 🌘',
  'Planter, bouturer, tailler, enrichir le sol. La sève redescend vers les racines.':
      'Plantar, hacer esquejes, podar, enriquecer el suelo. La savia vuelve a bajar hacia las raíces.',
  'Lune croissante 🌓':
      'Luna creciente 🌓',
  'Les plantes sont plus résistantes. Bon moment pour récolter des fruits qui se conservent longtemps.':
      'Las plantas son más resistentes. Buen momento para cosechar frutos que se conservan mucho tiempo.',
  'Lune décroissante 🌗':
      'Luna menguante 🌗',
  'Les parfums et saveurs sont renforcés. Idéal pour récolter les aromatiques et faire des conserves.':
      'Los aromas y los sabores se intensifican. Ideal para cosechar las aromáticas y hacer conservas.',
  'Selon la partie cultivée':
      'Según la parte cultivada',
  'Partie':
      'Parte',
  'Phase idéale':
      'Fase ideal',
  'Action':
      'Acción',
  '🥕 Racines':
      '🥕 Raíces',
  'Lune descendante':
      'Luna descendente',
  'Planter, récolter':
      'Plantar, cosechar',
  '🥬 Feuilles':
      '🥬 Hojas',
  'Lune montante':
      'Luna ascendente',
  'Semer, récolter':
      'Sembrar, cosechar',
  '🌸 Fleurs':
      '🌸 Flores',
  'Semer, cueillir':
      'Sembrar, cortar',
  '🍅 Fruits/graines':
      '🍅 Frutos/semillas',
  '✂️ Tailler':
      '✂️ Podar',
  'Taille douce':
      'Poda suave',
  '🧱 Compost':
      '🧱 Compost',
  'Retourner, épandre':
      'Voltear, esparcir',
  'Les jours à éviter':
      'Los días que hay que evitar',
  'Nœuds lunaires':
      'Nodos lunares',
  'Quand la lune croise le plan de l\'orbite terrestre. Évite de jardiner 5h avant et après.':
      'Cuando la luna cruza el plano de la órbita terrestre. Evita trabajar en el huerto 5 h antes y después.',
  'Périgée et apogée':
      'Perigeo y apogeo',
  'Quand la lune est au plus près ou au plus loin de la Terre. Les plantes sont perturbées.':
      'Cuando la luna está más cerca o más lejos de la Tierra. Las plantas se alteran.',
  '12h avant/après pleine ou nouvelle lune':
      '12 h antes/después de la luna llena o nueva',
  'Période de transition défavorable. Profites-en pour planifier, nettoyer tes outils ou préparer tes semences.':
      'Periodo de transición desfavorable. Aprovéchalo para planificar, limpiar tus herramientas o preparar tus semillas.',
  'Ne te stresse pas avec les jours défavorables : si tu ne peux jardiner que le week-end, fais-le ! Mieux vaut jardiner au « mauvais » moment que pas du tout.':
      'No te agobies con los días desfavorables: si solo puedes trabajar en el huerto el fin de semana, ¡hazlo! Más vale cultivar en el momento «malo» que no cultivar nada.',
  'Suivre le calendrier lunaire à la lettre :':
      'Seguir el calendario lunar al pie de la letra:',
  'c\'est un guide, pas une obligation. Adapte-le à ta réalité.':
      'es una guía, no una obligación. Adáptalo a tu realidad.',
  'Confondre montante/croissante :':
      'Confundir ascendente con creciente:',
  'ce sont deux cycles différents qui se superposent.':
      'son dos ciclos distintos que se superponen.',
  'Reporter indéfiniment un semis :':
      'Aplazar una siembra indefinidamente:',
  'la fenêtre saisonnière compte plus que la phase lunaire.':
      'la ventana estacional cuenta más que la fase lunar.',

  // ─── jardiner_saison_seche (23 textes, 323 mots) ───
  'Jardiner en saison sèche':
      'Cultivar en la estación seca',
  'Chaque goutte d\'eau compte':
      'Cada gota de agua cuenta',
  'En saison sèche, le soleil tape fort et l\'eau devient précieuse. Avec un paillage épais, un arrosage malin et un peu d\'ombre, ton potager peut rester vert même quand la pluie se fait attendre. 💪':
      'En la estación seca el sol pega fuerte y el agua se vuelve preciosa. Con un acolchado grueso, un riego inteligente y algo de sombra, tu huerto puede seguir verde aunque la lluvia se haga esperar. 💪',
  'Économiser chaque goutte':
      'Ahorrar cada gota',
  'Paille épais 🍂':
      'Mucha paja 🍂',
  'Couvre le sol de 10 à 15 cm d\'herbes sèches, feuilles mortes, tiges de mil ou de maïs. Le paillage garde la fraîcheur et divise les arrosages par deux.':
      'Cubre el suelo con 10 a 15 cm de hierbas secas, hojas muertas, tallos de mijo o de maíz. El acolchado conserva la frescura y reduce los riegos a la mitad.',
  'Arrose au pied, matin ou soir 🌅':
      'Riega al pie, por la mañana o al atardecer 🌅',
  'Verse l\'eau directement au pied des plants, tôt le matin ou au coucher du soleil. En pleine journée, la moitié de l\'eau s\'évapore avant d\'atteindre les racines.':
      'Echa el agua directamente al pie de las plantas, a primera hora de la mañana o a la puesta del sol. En pleno día, la mitad del agua se evapora antes de llegar a las raíces.',
  'Enterre un canari (oya) 🏺':
      'Entierra un cántaro (oya) 🏺',
  'Enterre un pot en terre cuite non vernissée jusqu\'au col, remplis-le d\'eau et pose un couvercle. L\'eau traverse doucement la paroi et abreuve les racines pendant plusieurs jours.':
      'Entierra una vasija de barro sin esmaltar hasta el cuello, llénala de agua y ponle una tapa. El agua atraviesa despacio la pared y abastece las raíces durante varios días.',
  'Creuse zaï et demi-lunes 🌙':
      'Cava zaï y medias lunas 🌙',
  'De petites cuvettes (zaï) ou des demi-lunes de terre en aval de la pente captent l\'eau d\'arrosage et des rares pluies. Dépose du compost au fond : c\'est un garde-manger pour tes plants.':
      'Pequeñas cubetas (zaï) o medias lunas de tierra en la parte baja de la pendiente recogen el agua de riego y de las escasas lluvias. Pon compost en el fondo: es una despensa para tus plantas.',
  'Offre de l\'ombre ⛱️':
      'Ofrece sombra ⛱️',
  'Un filet d\'ombrage, des palmes tressées ou des cultures hautes (maïs, manioc) protègent les légumes fragiles du soleil de midi.':
      'Una malla de sombreo, palmas trenzadas o cultivos altos (maíz, yuca) protegen las hortalizas frágiles del sol del mediodía.',
  '« Un binage vaut deux arrosages » : gratte légèrement la surface du sol entre deux arrosages. Tu casses les petits canaux par lesquels l\'eau s\'évapore, et l\'humidité reste en profondeur.':
      '«Una escarda vale por dos riegos»: rasca ligeramente la superficie del suelo entre dos riegos. Rompes los pequeños canales por los que se evapora el agua, y la humedad se queda en profundidad.',
  'Arroser en pleine journée :':
      'Regar en pleno día:',
  'l\'eau s\'évapore avant de servir, et les gouttes sur les feuilles peuvent les brûler.':
      'el agua se evapora antes de servir, y las gotas sobre las hojas pueden quemarlas.',
  'Les petits arrosages de surface :':
      'Los riegos superficiales y cortos:',
  'ils rendent les racines paresseuses. Mieux vaut arroser copieusement 2-3 fois par semaine que un peu tous les jours.':
      'vuelven perezosas a las raíces. Mejor regar abundantemente 2-3 veces por semana que un poco todos los días.',
  'Laisser le sol nu :':
      'Dejar el suelo desnudo:',
  'un sol à découvert sèche, durcit et se fissure. Couvre-le toujours, même d\'une fine couche.':
      'un suelo al descubierto se seca, se endurece y se agrieta. Cúbrelo siempre, aunque sea con una capa fina.',
  'Forcer sur l\'engrais :':
      'Pasarse con el abono:',
  'en pleine chaleur, les plants stressés absorbent mal. Un sol paillé et un peu de compost suffisent.':
      'con el calor fuerte, las plantas estresadas absorben mal. Un suelo acolchado y un poco de compost bastan.',

  // ─── lutter_limaces (31 textes, 300 mots) ───
  'Lutter contre les limaces':
      'Combatir las babosas',
  'Maladies & Nuisibles':
      'Enfermedades y plagas',
  'Protéger ses jeunes plants':
      'Proteger tus plantas jóvenes',
  'Les limaces sont actives la nuit par temps humide. Elles dévorent en priorité les jeunes plants et les salades.':
      'Las babosas están activas por la noche, cuando hace humedad. Devoran sobre todo las plantas jóvenes y las lechugas.',
  'Reconnaître les dégâts':
      'Reconocer los daños',
  'Jeunes plants sectionnés':
      'Plantas jóvenes cortadas',
  'Les plantules sont coupées net au ras du sol, souvent en une seule nuit. Les semis disparaissent mystérieusement.':
      'Las plántulas aparecen cortadas limpiamente a ras de suelo, a menudo en una sola noche. Las siembras desaparecen misteriosamente.',
  'Feuilles trouées irrégulièrement':
      'Hojas con agujeros irregulares',
  'Les trous ont des bords arrondis et irréguliers, contrairement aux découpures nettes des chenilles.':
      'Los agujeros tienen bordes redondeados e irregulares, a diferencia de los cortes limpios de las orugas.',
  'Traces brillantes':
      'Rastros brillantes',
  'Des traînées de mucus argenté sur les feuilles et le sol trahissent le passage des limaces et escargots.':
      'Las estelas de mucosidad plateada sobre las hojas y el suelo delatan el paso de babosas y caracoles.',
  'Les méthodes efficaces':
      'Los métodos eficaces',
  'Ramassage nocturne 🔦':
      'Recogida nocturna 🔦',
  'Sors avec une lampe frontale 1h après la tombée de la nuit. Ramasse les limaces à la main et éloigne-les du potager.':
      'Sal con una linterna frontal 1 h después de anochecer. Recoge las babosas a mano y llévalas lejos del huerto.',
  'Barrières naturelles':
      'Barreras naturales',
  'Entoure les plants de coquilles d\'œufs concassées, de cendres de bois ou de marc de café. Renouvelle après la pluie.':
      'Rodea las plantas con cáscaras de huevo machacadas, ceniza de madera o posos de café. Renuévalas después de la lluvia.',
  'Pièges à bière 🍺':
      'Trampas de cerveza 🍺',
  'Enterre un récipient au ras du sol et remplis-le de bière. Les limaces y tombent attirées par la levure.':
      'Entierra un recipiente a ras de suelo y llénalo de cerveza. Las babosas caen atraídas por la levadura.',
  'Favorise les prédateurs 🦔':
      'Favorece a los depredadores 🦔',
  'Accueille les hérissons, crapauds, carabes et orvets. Un tas de bois ou un point d\'eau les attirent au jardin.':
      'Da la bienvenida a erizos, sapos, carábidos y luciones. Un montón de leña o un punto de agua los atraen al jardín.',
  'Ferramol':
      'Ferramol',
  'Ce produit à base de phosphate de fer est autorisé en bio. Les limaces cessent de s\'alimenter après ingestion.':
      'Este producto a base de fosfato de hierro está autorizado en ecológico. Las babosas dejan de alimentarse tras ingerirlo.',
  'Le ramassage nocturne à la frontale reste la méthode la plus efficace. Une sortie régulière les soirs humides réduit drastiquement la population.':
      'La recogida nocturna con frontal sigue siendo el método más eficaz. Una salida regular las noches húmedas reduce drásticamente la población.',
  'Paillage épais humide :':
      'Acolchado grueso y húmedo:',
  'un paillis trop épais et constamment humide offre un refuge idéal aux limaces.':
      'un acolchado demasiado grueso y constantemente húmedo ofrece un refugio ideal a las babosas.',
  'Anti-limaces chimiques :':
      'Antibabosas químicos:',
  'le métaldéhyde empoisonne aussi les hérissons, les oiseaux et les animaux domestiques.':
      'el metaldehído también envenena a erizos, aves y animales domésticos.',
  'Sel :':
      'Sal:',
  'le sel tue les limaces mais saline le sol et détruit la vie microbienne. Toxique pour les plantes.':
      'la sal mata a las babosas, pero saliniza el suelo y destruye la vida microbiana. Es tóxica para las plantas.',
  'Repiquer en nuit humide :':
      'Trasplantar en una noche húmeda:',
  'les jeunes plants repiqués un soir de pluie sont un festin offert aux limaces.':
      'las plantas jóvenes trasplantadas una noche de lluvia son un festín para las babosas.',

  // ─── mildiou (39 textes, 364 mots) ───
  'Mildiou':
      'Mildiu',
  'La maladie fongique du potager':
      'La enfermedad fúngica del huerto',
  'Le mildiou est un champignon qui prospère par temps chaud et humide. Il peut détruire une récolte de tomates en quelques jours si on ne réagit pas vite.':
      'El mildiu es un hongo que prospera con tiempo cálido y húmedo. Puede destruir una cosecha de tomates en pocos días si no se reacciona rápido.',
  'Reconnaître le mildiou':
      'Reconocer el mildiu',
  'Taches jaunes':
      'Manchas amarillas',
  'Des taches jaune pâle apparaissent sur le dessus des feuilles, souvent entre les nervures. Premier signe d\'alerte.':
      'Aparecen manchas amarillo pálido en el haz de las hojas, a menudo entre los nervios. Primera señal de alerta.',
  'Duvet blanchâtre':
      'Pelusa blanquecina',
  'Un feutrage blanc-grisâtre se développe sous les feuilles, face à la tache jaune. Ce sont les spores du champignon.':
      'Un fieltro blanco grisáceo se desarrolla en el envés de las hojas, justo bajo la mancha amarilla. Son las esporas del hongo.',
  'Taches brunes sur fruits':
      'Manchas pardas en los frutos',
  'Les tomates présentent des marbrures brunes et bosselées. Les fruits deviennent impropres à la consommation.':
      'Los tomates presentan manchas pardas abultadas. Los frutos dejan de ser aptos para el consumo.',
  'Tiges qui noircissent':
      'Tallos que se ennegrecen',
  'Les tiges prennent une couleur brun-noir et se dessèchent. La plante dépérit rapidement de haut en bas.':
      'Los tallos adquieren un color pardo negruzco y se secan. La planta se marchita rápidamente de arriba abajo.',
  'Prévenir avant tout':
      'Prevenir ante todo',
  'Espace les plants':
      'Separa las plantas',
  'Laisse au moins 60 cm entre les pieds de tomates pour permettre une bonne circulation de l\'air.':
      'Deja al menos 60 cm entre las matas de tomate para que circule bien el aire.',
  'Arrose le pied':
      'Riega al pie',
  'N\'arrose jamais le feuillage. L\'eau stagnante sur les feuilles est le déclencheur numéro un du mildiou.':
      'No riegues nunca el follaje. El agua estancada sobre las hojas es el desencadenante número uno del mildiu.',
  'Abrite les tomates':
      'Protege los tomates',
  'Un toit ou un auvent protège les plants de la pluie tout en laissant l\'air circuler sur les côtés.':
      'Un techo o un voladizo protege las plantas de la lluvia y deja circular el aire por los lados.',
  'Paille le sol':
      'Acolcha el suelo',
  'Le paillage empêche les éclaboussures de terre contaminée sur les feuilles basses lors des arrosages.':
      'El acolchado evita que la tierra contaminada salpique las hojas bajas al regar.',
  'Pulvérise préventivement':
      'Pulveriza de forma preventiva',
  'Applique de la bouillie bordelaise ou une décoction de prêle toutes les 2-3 semaines en prévention.':
      'Aplica caldo bordelés o una decocción de cola de caballo cada 2-3 semanas como prevención.',
  'En cas d\'attaque':
      'Si hay ataque',
  'Supprime les feuilles atteintes':
      'Quita las hojas afectadas',
  'Coupe immédiatement toutes les feuilles touchées. Ne les composte pas, brûle-les ou jette-les aux ordures.':
      'Corta de inmediato todas las hojas tocadas. No las eches al compost: quémalas o tíralas a la basura.',
  'Bouillie bordelaise':
      'Caldo bordelés',
  'Pulvérise un traitement cuivré sur les parties saines pour freiner la propagation. Respecte les dosages.':
      'Pulveriza un tratamiento cúprico sobre las partes sanas para frenar la propagación. Respeta las dosis.',
  'Si tout est atteint : arrache':
      'Si todo está afectado: arranca',
  'Quand la maladie a envahi tout le plant, arrache-le pour protéger les voisins. Récolte les fruits encore sains.':
      'Cuando la enfermedad ha invadido toda la planta, arráncala para proteger a las vecinas. Cosecha los frutos que sigan sanos.',
  'Choisis des variétés résistantes : Fantasio, Maestria, Crimson Crush. Elles ne sont pas immunisées mais résistent bien mieux aux attaques.':
      'Elige variedades resistentes: Fantasio, Maestria, Crimson Crush. No son inmunes, pero resisten mucho mejor los ataques.',
  'Arroser par aspersion :':
      'Regar por aspersión:',
  'l\'eau sur les feuilles crée les conditions idéales pour le mildiou.':
      'el agua sobre las hojas crea las condiciones ideales para el mildiu.',
  'Laisser les feuilles malades :':
      'Dejar las hojas enfermas:',
  'chaque feuille atteinte produit des milliers de spores qui contaminent les voisins.':
      'cada hoja afectada produce miles de esporas que contaminan a las vecinas.',
  'Composter les plants malades :':
      'Compostar las plantas enfermas:',
  'le mildiou survit dans le compost et recontaminera le jardin l\'année suivante.':
      'el mildiu sobrevive en el compost y volverá a contaminar el jardín al año siguiente.',
  'Serrer les plants :':
      'Plantar apretado:',
  'le manque d\'aération entre les pieds favorise l\'humidité et la propagation rapide.':
      'la falta de aireación entre las plantas favorece la humedad y la propagación rápida.',

  // ─── paillage (34 textes, 352 mots) ───
  'Paillage':
      'Acolchado',
  'Protéger et nourrir la terre':
      'Proteger y alimentar la tierra',
  'Le paillage, c\'est recouvrir le sol de matière organique. Il garde l\'humidité, limite les mauvaises herbes, nourrit le sol en se décomposant et protège la vie souterraine.':
      'Acolchar es cubrir el suelo con materia orgánica. Conserva la humedad, limita las malas hierbas, alimenta el suelo al descomponerse y protege la vida subterránea.',
  'Quels matériaux choisir':
      'Qué materiales elegir',
  'Feuilles mortes 🍂':
      'Hojas muertas 🍂',
  'Gratuites et abondantes en automne. Se décomposent lentement et enrichissent le sol en humus. Idéal partout.':
      'Gratuitas y abundantes en otoño. Se descomponen despacio y enriquecen el suelo con humus. Ideales en cualquier sitio.',
  'Tonte de gazon 🌿':
      'Siega de césped 🌿',
  'Riche en azote, se décompose vite. À étaler en couche fine (2-3 cm) et séchée pour éviter la fermentation.':
      'Rica en nitrógeno, se descompone rápido. Extiéndela en capa fina (2-3 cm) y seca para evitar la fermentación.',
  'BRF (Bois Raméal Fragmenté) 🌳':
      'BRF (Madera Rameal Fragmentada) 🌳',
  'Branches broyées de moins de 7 cm de diamètre. Excellent pour les allées et les arbustes. Dure longtemps.':
      'Ramas trituradas de menos de 7 cm de diámetro. Excelente para los caminos y los arbustos. Dura mucho tiempo.',
  'Paille 🌾':
      'Paja 🌾',
  'Légère, aérée et facile à poser. Parfaite pour les fraisiers, tomates et courgettes. Attention aux graines de céréales.':
      'Ligera, aireada y fácil de colocar. Perfecta para fresas, tomates y calabacines. Ojo con las semillas de cereales.',
  'Carton brun 📦':
      'Cartón marrón 📦',
  'Sans encre ni scotch. Excellent pour étouffer les herbes avant de créer une nouvelle parcelle. Recouvre de paillis.':
      'Sin tinta ni cinta adhesiva. Excelente para ahogar las hierbas antes de crear una parcela nueva. Cúbrelo con acolchado.',
  'Comment bien pailler':
      'Cómo acolchar bien',
  'Désherbe avant de pailler':
      'Quita las malas hierbas antes de acolchar',
  'Retire les mauvaises herbes existantes. Le paillage empêche les nouvelles mais n\'élimine pas celles en place.':
      'Retira las malas hierbas que haya. El acolchado impide que salgan otras nuevas, pero no elimina las que ya están.',
  'Arrose le sol':
      'Riega el suelo',
  'Paille toujours sur un sol humide. L\'eau pénètre moins bien à travers une couche de paillis sec.':
      'Acolcha siempre sobre suelo húmedo. El agua penetra peor a través de una capa de acolchado seco.',
  'Étale une couche de 5 à 10 cm':
      'Extiende una capa de 5 a 10 cm',
  'Trop fin, le paillis est inefficace. Trop épais, il peut étouffer les jeunes plants et favoriser les limaces.':
      'Si es muy fina, el acolchado no sirve. Si es muy gruesa, puede ahogar las plantas jóvenes y favorecer a las babosas.',
  'Dégage le collet des plants':
      'Despeja el cuello de las plantas',
  'Laisse 2-3 cm d\'espace autour des tiges pour éviter la pourriture au contact du paillis humide.':
      'Deja 2-3 cm de espacio alrededor de los tallos para evitar la podredumbre por el contacto con el acolchado húmedo.',
  'Renouvelle régulièrement':
      'Renuévalo con regularidad',
  'Le paillis se décompose et nourrit le sol. Rajoute une couche dès qu\'il s\'amincit sous les 3-4 cm.':
      'El acolchado se descompone y alimenta el suelo. Añade otra capa en cuanto se quede por debajo de 3-4 cm.',
  'En hiver, pense au paillage épais (20-30 cm de feuilles). Il protège le sol du gel, abrite les auxiliaires et se transforme en humus pour le printemps.':
      'En invierno, piensa en un acolchado grueso (20-30 cm de hojas). Protege el suelo de la helada, da cobijo a los auxiliares y se convierte en humus para la primavera.',
  'Limaces sous le paillis :':
      'Babosas bajo el acolchado:',
  'en cas d\'invasion, écarte le paillis temporairement et pose des pièges à bière.':
      'si hay invasión, aparta el acolchado un tiempo y pon trampas de cerveza.',
  'Tonte fraîche en couche épaisse :':
      'Césped recién cortado en capa gruesa:',
  'elle fermente, chauffe et peut brûler les racines. Sèche-la d\'abord.':
      'fermenta, se calienta y puede quemar las raíces. Sécalo primero.',
  'Pailler sur des semis :':
      'Acolchar sobre las siembras:',
  'les graines ont besoin de lumière et de chaleur pour germer. Attends que les plants aient 10 cm.':
      'las semillas necesitan luz y calor para germinar. Espera a que las plantas midan 10 cm.',
  'Carton imprimé ou plastifié :':
      'Cartón impreso o plastificado:',
  'les encres et revêtements contiennent des substances nocives pour le sol.':
      'las tintas y los recubrimientos contienen sustancias nocivas para el suelo.',

  // ─── potager_balcon (46 textes, 362 mots) ───
  'Potager en balcon':
      'Huerto en el balcón',
  'Jardiner sans jardin':
      'Cultivar sin jardín',
  'Un balcon bien exposé peut produire salades, tomates cerises, fraises, herbes aromatiques et bien plus. Il suffit de bons contenants, du soleil et un arrosage régulier.':
      'Un balcón bien orientado puede producir lechugas, tomates cherry, fresas, hierbas aromáticas y mucho más. Solo hacen falta buenos recipientes, sol y un riego regular.',
  'Évaluer son balcon':
      'Evaluar tu balcón',
  'Plein sud (6h+ de soleil)':
      'Orientación sur (más de 6 h de sol)',
  'Idéal pour tomates, poivrons, courgettes, fraises et la plupart des légumes-fruits gourmands en lumière.':
      'Ideal para tomates, pimientos, calabacines, fresas y la mayoría de las hortalizas de fruto que piden mucha luz.',
  'Mi-ombre (3-5h de soleil)':
      'Media sombra (3-5 h de sol)',
  'Parfait pour salades, épinards, radis, herbes aromatiques et légumes-feuilles qui tolèrent l\'ombre partielle.':
      'Perfecto para lechugas, espinacas, rábanos, hierbas aromáticas y hortalizas de hoja que toleran la sombra parcial.',
  'Ombragé (moins de 3h)':
      'En sombra (menos de 3 h)',
  'Limité aux herbes d\'ombre (menthe, ciboulette, persil) et à quelques salades résistantes.':
      'Limitado a las hierbas de sombra (menta, cebollino, perejil) y a algunas lechugas resistentes.',
  'Les bases du succès':
      'Las bases del éxito',
  'Bons contenants':
      'Buenos recipientes',
  'Minimum 20 cm de profondeur pour les salades, 40 cm pour les tomates. Choisis des pots en terre cuite, plastique épais ou tissu géotextile.':
      'Mínimo 20 cm de profundidad para las lechugas y 40 cm para los tomates. Elige macetas de barro, de plástico grueso o de tela geotextil.',
  'Drainage indispensable':
      'Drenaje indispensable',
  'Chaque pot doit avoir des trous de drainage. Place des billes d\'argile au fond sur 2-3 cm pour éviter que les racines ne baignent.':
      'Cada maceta debe tener agujeros de drenaje. Pon bolas de arcilla expandida en el fondo, en una capa de 2-3 cm, para que las raíces no queden encharcadas.',
  'Terreau enrichi':
      'Sustrato enriquecido',
  'Utilise un terreau de qualité mélangé à du compost. Les pots offrent peu de volume : la terre doit être riche dès le départ.':
      'Usa un sustrato de calidad mezclado con compost. Las macetas ofrecen poco volumen: la tierra tiene que ser rica desde el principio.',
  'Arrosage régulier':
      'Riego regular',
  'En été, arrose tous les jours, voire matin et soir en canicule. Le terreau en pot sèche beaucoup plus vite qu\'en pleine terre.':
      'En verano, riega todos los días, incluso por la mañana y por la tarde en una ola de calor. El sustrato en maceta se seca mucho más rápido que la tierra del suelo.',
  'Fertilise toutes les 2 semaines':
      'Abona cada 2 semanas',
  'L\'arrosage fréquent lessive les nutriments. Apporte un engrais organique liquide (purin d\'ortie, engrais bio) régulièrement.':
      'El riego frecuente lava los nutrientes. Aporta con regularidad un abono orgánico líquido (purín de ortiga, abono ecológico).',
  'Top 8 pour petit balcon':
      'Las 8 mejores para un balcón pequeño',
  'Plante':
      'Planta',
  'Contenant':
      'Recipiente',
  '🍅 Tomate cerise':
      '🍅 Tomate cherry',
  'Pot 30 cm, profond':
      'Maceta de 30 cm, profunda',
  'Jardinière 20 cm':
      'Jardinera de 20 cm',
  '🌿 Basilic':
      '🌿 Albahaca',
  'Pot 15 cm':
      'Maceta de 15 cm',
  'Pot suspendu 25 cm':
      'Maceta colgante de 25 cm',
  '🔴 Radis':
      '🔴 Rábano',
  'Jardinière 15 cm':
      'Jardinera de 15 cm',
  '🌶️ Piment':
      '🌶️ Guindilla',
  'Pot 25 cm':
      'Maceta de 25 cm',
  '🌱 Ciboulette':
      '🌱 Cebollino',
  '🌿 Menthe':
      '🌿 Menta',
  'Pot isolé 20 cm':
      'Maceta individual de 20 cm',
  'Les tomates cerises comme \'Tumbling Tom\' sont spécialement adaptées aux pots. Elles retombent en cascade et produisent abondamment tout l\'été.':
      'Los tomates cherry como \'Tumbling Tom\' están especialmente adaptados a las macetas. Caen en cascada y producen abundantemente todo el verano.',
  'Ignorer le vent :':
      'Ignorar el viento:',
  'en étage, le vent dessèche les plants et casse les tiges. Installe un brise-vent ou protège les pots.':
      'en una planta alta, el viento reseca las plantas y rompe los tallos. Pon un cortavientos o protege las macetas.',
  'Pots en métal noir :':
      'Macetas de metal negro:',
  'ils surchauffent au soleil et brûlent les racines. Préfère la terre cuite ou le plastique clair.':
      'se recalientan al sol y queman las raíces. Prefiere el barro o el plástico claro.',
  'Oublier d\'arroser :':
      'Olvidarte de regar:',
  'un pot au soleil peut sécher en quelques heures. Un oubli d\'un jour suffit à perdre un plant.':
      'una maceta al sol puede secarse en pocas horas. Un olvido de un día basta para perder una planta.',
  'Pot trop petit :':
      'Maceta demasiado pequeña:',
  'un volume insuffisant limite les racines, stresse la plante et réduit la récolte à presque rien.':
      'un volumen insuficiente limita las raíces, estresa a la planta y deja la cosecha casi en nada.',

  // ─── potager_carres (41 textes, 351 mots) ───
  'Potager en carrés':
      'Huerto en cuadros',
  'Méthode simple et productive':
      'Un método sencillo y productivo',
  'Le potager en carrés divise l\'espace en carrés de 30 cm, chacun dédié à un légume. C\'est la méthode idéale pour produire beaucoup sur peu d\'espace.':
      'El huerto en cuadros divide el espacio en cuadrados de 30 cm, cada uno dedicado a una hortaliza. Es el método ideal para producir mucho en poco espacio.',
  'Le principe':
      'El principio',
  'Un carré de 1,20 x 1,20 m':
      'Un cuadro de 1,20 x 1,20 m',
  'Divisé en 16 cases de 30 x 30 cm. Cette taille permet d\'atteindre chaque case sans marcher sur la terre.':
      'Dividido en 16 casillas de 30 x 30 cm. Con este tamaño llegas a cada casilla sin pisar la tierra.',
  'Un légume par case':
      'Una hortaliza por casilla',
  'Chaque case accueille un seul type de légume, en respectant la densité adaptée à l\'espèce.':
      'Cada casilla acoge un solo tipo de hortaliza, respetando la densidad adecuada a la especie.',
  'Hauteur de 15 à 30 cm':
      'Altura de 15 a 30 cm',
  'Suffisant pour la plupart des légumes. Un cadre en bois maintient la terre et délimite clairement l\'espace.':
      'Suficiente para la mayoría de las hortalizas. Un marco de madera sujeta la tierra y delimita claramente el espacio.',
  'Rotation case par case':
      'Rotación casilla a casilla',
  'Quand une case est récoltée, replante un légume d\'une famille différente. Cela évite l\'épuisement du sol.':
      'Cuando se cosecha una casilla, replanta una hortaliza de otra familia. Así se evita el agotamiento del suelo.',
  'Densité par case (30x30 cm)':
      'Densidad por casilla (30x30 cm)',
  '1 pied':
      '1 planta',
  '4 plants':
      '4 plantas',
  '16 graines':
      '16 semillas',
  '🧄 Ail':
      '🧄 Ajo',
  '9 gousses':
      '9 dientes',
  '9 bulbes':
      '9 bulbos',
  '9 graines':
      '9 semillas',
  '🌿 Persil':
      '🌿 Perejil',
  'Mettre en place son carré':
      'Montar tu cuadro',
  'Choisir un emplacement ensoleillé':
      'Elegir un lugar soleado',
  'Minimum 6 heures de soleil par jour. Place le carré sur une surface plane, de préférence orientée sud.':
      'Mínimo 6 horas de sol al día. Coloca el cuadro sobre una superficie plana, preferiblemente orientada al sur.',
  'Construire le cadre':
      'Construir el marco',
  'Utilise des planches de bois non traité (15 à 30 cm de haut). Assemble-les en carré de 1,20 m de côté.':
      'Usa tablas de madera sin tratar (de 15 a 30 cm de alto). Únelas formando un cuadrado de 1,20 m de lado.',
  'Diviser en 16 cases':
      'Dividir en 16 casillas',
  'Utilise des tasseaux, de la ficelle ou des lattes pour marquer les 16 cases de 30 x 30 cm.':
      'Usa listones, cuerda o varillas para marcar las 16 casillas de 30 x 30 cm.',
  'Remplir de bon terreau':
      'Rellenar con buen sustrato',
  'Mélange terreau, compost et terre de jardin à parts égales pour un substrat riche et drainant.':
      'Mezcla sustrato, compost y tierra de jardín a partes iguales para obtener un sustrato rico y drenante.',
  'Planter selon la densité':
      'Plantar según la densidad',
  'Respecte le nombre de plants par case. Ne surcharge pas : chaque légume a besoin d\'espace pour se développer.':
      'Respeta el número de plantas por casilla. No te pases: cada hortaliza necesita espacio para desarrollarse.',
  'La méthode des carrés est parfaite pour débuter. Elle permet de produire une grande variété de légumes sur moins de 2 m² et de comprendre les bases du potager.':
      'El método de los cuadros es perfecto para empezar. Permite producir una gran variedad de hortalizas en menos de 2 m² y entender las bases del huerto.',
  'Surcharger les cases :':
      'Sobrecargar las casillas:',
  'trop de plants se font concurrence et aucun ne se développe correctement.':
      'con demasiadas plantas compiten entre sí y ninguna se desarrolla bien.',
  'Replanter la même famille :':
      'Replantar la misma familia:',
  'sans rotation, le sol s\'épuise et les maladies s\'installent.':
      'sin rotación, el suelo se agota y se instalan las enfermedades.',
  'Oublier l\'arrosage :':
      'Olvidar el riego:',
  'les petits volumes de terre sèchent vite, surtout en été.':
      'los volúmenes pequeños de tierra se secan rápido, sobre todo en verano.',
  'Négliger le remplissage :':
      'Descuidar el relleno:',
  'un terreau pauvre donne des légumes chétifs. Enrichis avec du compost chaque saison.':
      'un sustrato pobre da hortalizas raquíticas. Enriquécelo con compost cada temporada.',

  // ─── potager_sureleve (32 textes, 312 mots) ───
  'Potager surélevé':
      'Huerto elevado',
  'Cultiver sans se baisser':
      'Cultivar sin agacharse',
  'Le potager surélevé permet de jardiner debout, sans mal au dos. Il offre un contrôle total sur la qualité de la terre et réduit les adventices.':
      'El huerto elevado permite cultivar de pie, sin dolor de espalda. Ofrece un control total sobre la calidad de la tierra y reduce las malas hierbas.',
  'Les avantages':
      'Las ventajas',
  'Confort':
      'Comodidad',
  'Jardiner debout ou assis, sans se pencher. Idéal pour les personnes à mobilité réduite ou souffrant du dos.':
      'Cultivar de pie o sentado, sin inclinarte. Ideal para personas con movilidad reducida o con problemas de espalda.',
  'Terre maîtrisée':
      'Tierra bajo control',
  'Tu choisis ta terre : pas de sol pollué, pas d\'argile lourde. Un mélange parfait dès le départ.':
      'Tú eliges tu tierra: sin suelo contaminado ni arcilla pesada. Una mezcla perfecta desde el principio.',
  'Réchauffe vite':
      'Se calienta rápido',
  'La terre en hauteur se réchauffe plus vite au printemps, ce qui avance les semis de plusieurs semaines.':
      'La tierra en altura se calienta antes en primavera, lo que adelanta las siembras varias semanas.',
  'Moins de nuisibles':
      'Menos plagas',
  'En hauteur, les limaces et escargots ont plus de mal à atteindre tes cultures.':
      'En altura, a las babosas y los caracoles les cuesta más llegar a tus cultivos.',
  'Construire son bac':
      'Construir tu jardinera',
  'Dimensions idéales':
      'Dimensiones ideales',
  'Largeur 1,20 m maximum pour atteindre le centre sans entrer dedans. Hauteur de 60 à 90 cm pour un confort optimal.':
      'Ancho de 1,20 m como máximo para llegar al centro sin entrar. Altura de 60 a 90 cm para una comodidad óptima.',
  'Matériaux':
      'Materiales',
  'Privilégie le bois non traité (mélèze, douglas, châtaignier) pour éviter les produits chimiques au contact de la terre.':
      'Da preferencia a la madera sin tratar (alerce, pino Oregón, castaño) para evitar productos químicos en contacto con la tierra.',
  'Drainage obligatoire':
      'Drenaje obligatorio',
  'Place une couche de graviers ou de billes d\'argile au fond, puis un feutre géotextile pour éviter que la terre ne s\'écoule.':
      'Pon una capa de grava o de bolas de arcilla expandida en el fondo y, encima, un geotextil para que la tierra no se escurra.',
  'Remplissage en lasagne':
      'Relleno en lasaña',
  'Alterne couches de matières brunes (bois, carton) et vertes (tonte, compost). Termine par 20 cm de terre végétale enrichie.':
      'Alterna capas de materia marrón (madera, cartón) y verde (siega, compost). Termina con 20 cm de tierra vegetal enriquecida.',
  'Laisser reposer':
      'Dejar reposar',
  'Attends 2 à 4 semaines avant de planter pour que les couches commencent à se décomposer et que la terre se tasse.':
      'Espera de 2 a 4 semanas antes de plantar para que las capas empiecen a descomponerse y la tierra se asiente.',
  'Le bac surélevé sèche plus vite qu\'un sol classique. Pense à pailler généreusement et à arroser régulièrement, surtout en été.':
      'La jardinera elevada se seca más rápido que un suelo normal. Acuérdate de acolchar generosamente y de regar con regularidad, sobre todo en verano.',
  'Bois traité :':
      'Madera tratada:',
  'les produits chimiques migrent dans la terre et contaminent tes légumes.':
      'los productos químicos pasan a la tierra y contaminan tus hortalizas.',
  'Profondeur insuffisante :':
      'Profundidad insuficiente:',
  'moins de 40 cm limite le développement des racines et assèche vite le substrat.':
      'menos de 40 cm limita el desarrollo de las raíces y seca rápido el sustrato.',
  'Pas de drainage :':
      'Sin drenaje:',
  'sans évacuation d\'eau, les racines pourrissent et les plants meurent.':
      'sin salida para el agua, las raíces se pudren y las plantas mueren.',
  'Emplacement ombragé :':
      'Lugar en sombra:',
  'les légumes ont besoin de 6 à 8 heures de soleil. Un bac à l\'ombre ne produira presque rien.':
      'las hortalizas necesitan de 6 a 8 horas de sol. Una jardinera a la sombra apenas producirá nada.',

  // ─── preparer_hivernage (33 textes, 390 mots) ───
  'Préparer l\'hivernage':
      'Preparar la estación de lluvias',
  'Prêt avant les premières pluies':
      'Listo antes de las primeras lluvias',
  'L\'hivernage, c\'est la saison des pluies : la grande saison de culture ! Le secret, c\'est de tout préparer':
      'En África Occidental, la estación de lluvias («hivernage») es la gran temporada de cultivo. El secreto es prepararlo todo',
  'avant':
      'antes',
  'les premières gouttes. Un jardin prêt à temps profite de chaque pluie dès le premier jour. 🌦️':
      'de las primeras gotas. ¡Un huerto preparado a tiempo aprovecha cada lluvia desde el primer día! 🌦️',
  'Avant les premières pluies':
      'Antes de las primeras lluvias',
  'Nettoie la parcelle 🧹':
      'Limpia la parcela 🧹',
  'Désherbe, retire les vieux plants et les débris. Les mauvaises herbes profitent des pluies encore plus vite que tes légumes !':
      'Quita las malas hierbas, retira las plantas viejas y los restos. ¡Las malas hierbas aprovechan las lluvias aún más rápido que tus hortalizas!',
  'Monte planches, buttes et billons ⛰️':
      'Monta bancales, montones y caballones ⛰️',
  'Cultive surélevé : des billons ou des buttes de 20 à 40 cm gardent les racines hors de l\'eau quand les grosses averses arrivent.':
      'Cultiva en alto: caballones o montones de 20 a 40 cm mantienen las raíces fuera del agua cuando llegan los grandes chaparrones.',
  'Pense au drainage 🚿':
      'Piensa en el drenaje 🚿',
  'Creuse de petites rigoles entre les planches pour évacuer l\'excès d\'eau vers l\'extérieur du jardin. Un potager inondé, c\'est des racines qui étouffent.':
      'Cava pequeñas zanjas entre los bancales para evacuar el exceso de agua hacia fuera del huerto. Un huerto inundado son raíces que se ahogan.',
  'Nourris le sol 🪱':
      'Alimenta el suelo 🪱',
  'Incorpore du compost ou du fumier bien décomposé dans les buttes. Les pluies feront descendre les nutriments pile au niveau des racines.':
      'Incorpora compost o estiércol bien descompuesto en los montones. Las lluvias harán bajar los nutrientes justo hasta las raíces.',
  'Prépare tes semences 🌰':
      'Prepara tus semillas 🌰',
  'Trie tes graines, garde les plus belles et jette celles qui sont abîmées ou moisies. Tout doit être prêt pour semer dès que la pluie s\'installe.':
      'Selecciona tus semillas, quédate con las más bonitas y tira las estropeadas o enmohecidas. Todo debe estar listo para sembrar en cuanto se asiente la lluvia.',
  'À semer dès les premières pluies':
      'Para sembrar desde las primeras lluvias',
  'Niébé':
      'Caupí',
  'Le haricot local, costaud et généreux. Il enrichit même le sol en azote pour les cultures suivantes.':
      'La judía local, robusta y generosa. Incluso enriquece el suelo con nitrógeno para los cultivos siguientes.',
  'Sème en poquets de 2-3 graines dès que la terre est bien humide sur 10 cm de profondeur.':
      'Siembra en golpes de 2-3 semillas en cuanto la tierra esté bien húmeda a 10 cm de profundidad.',
  'Gombo':
      'Okra',
  'Fais tremper les graines une nuit avant de semer : elles germeront deux fois plus vite.':
      'Deja las semillas en remojo una noche antes de sembrar: germinarán el doble de rápido.',
  'Arachide':
      'Cacahuete',
  'Sème en lignes sur les billons, dans un sol léger et bien drainé. Elle aussi nourrit le sol en azote.':
      'Siembra en líneas sobre los caballones, en un suelo ligero y bien drenado. También él alimenta el suelo con nitrógeno.',
  'Ne sème pas tout à la première averse ! Attends 2-3 bonnes pluies rapprochées : c\'est le signe que la saison est vraiment installée. Et échelonne tes semis sur plusieurs semaines pour étaler les récoltes.':
      '¡No siembres todo con el primer chaparrón! Espera 2-3 buenas lluvias seguidas: es la señal de que la estación se ha asentado de verdad. Y escalona tus siembras a lo largo de varias semanas para repartir las cosechas.',
  'Semer à plat en zone inondable :':
      'Sembrar en llano en zona inundable:',
  'sans buttes ni billons, une seule grosse averse peut noyer tous tes semis.':
      'sin montones ni caballones, un solo chaparrón fuerte puede ahogar todas tus siembras.',
  'Ignorer les maladies fongiques :':
      'Ignorar las enfermedades fúngicas:',
  'chaleur + humidité = paradis des champignons. Espace bien les plants, évite de mouiller le feuillage et retire vite les feuilles tachées.':
      'calor + humedad = paraíso de los hongos. Separa bien las plantas, evita mojar el follaje y retira rápido las hojas manchadas.',
  'Laisser les herbes gagner :':
      'Dejar que las malas hierbas ganen:',
  'en hivernage, elles poussent à toute vitesse. Un petit désherbage chaque semaine vaut mieux qu\'un grand chantier chaque mois.':
      'en la estación de lluvias crecen a toda velocidad. Una pequeña escarda cada semana vale más que una gran obra cada mes.',
  'Oublier limaces et escargots :':
      'Olvidar babosas y caracoles:',
  'la pluie les réveille. Surveille les jeunes plants, surtout les premiers soirs humides.':
      'la lluvia los despierta. Vigila las plantas jóvenes, sobre todo las primeras tardes húmedas.',

  // ─── preparer_sol (33 textes, 321 mots) ───
  'Préparer le sol':
      'Preparar el suelo',
  'La base de toute culture réussie':
      'La base de todo cultivo con éxito',
  'Un bon sol de potager est meuble, riche en matière organique, bien drainé et vivant.':
      'Un buen suelo de huerto es suelto, rico en materia orgánica, bien drenado y vivo.',
  'Connaître son sol':
      'Conocer tu suelo',
  'Argileux':
      'Arcilloso',
  'Terre collante et lourde. Retient bien l\'eau mais se compacte. Ajoute du sable et du compost pour l\'alléger.':
      'Tierra pegajosa y pesada. Retiene bien el agua pero se compacta. Añade arena y compost para aligerarla.',
  'Sableux':
      'Arenoso',
  'Terre légère qui filtre vite l\'eau. Sèche rapidement. Enrichis avec du compost et du paillage pour retenir l\'humidité.':
      'Tierra ligera que filtra el agua rápidamente. Se seca enseguida. Enriquécela con compost y acolchado para retener la humedad.',
  'Limoneux':
      'Limoso',
  'Terre douce et fertile, idéale pour le potager. Attention à la croûte de battance en surface après la pluie.':
      'Tierra suave y fértil, ideal para el huerto. Cuidado con la costra superficial que se forma tras la lluvia.',
  'Calcaire':
      'Calizo',
  'Terre claire et caillouteuse, pH élevé. Certains nutriments sont bloqués. Apporte du compost acide et du soufre.':
      'Tierra clara y pedregosa, con pH alto. Algunos nutrientes quedan bloqueados. Aporta compost ácido y azufre.',
  'La préparation en 6 étapes':
      'La preparación en 6 pasos',
  'Désherbe':
      'Quita las malas hierbas',
  'Retire les mauvaises herbes à la main ou à la binette. Ne laisse pas les racines traînantes.':
      'Arranca las malas hierbas a mano o con la azadilla. No dejes raíces sueltas.',
  'Décompacte sans retourner':
      'Descompacta sin dar la vuelta',
  'Utilise une grelinette pour aérer en profondeur sans perturber la vie du sol.':
      'Usa una horca de doble mango para airear en profundidad sin alterar la vida del suelo.',
  'Apporte du compost':
      'Aporta compost',
  'Étale 3 à 5 cm de compost mûr en surface. Les vers feront le travail d\'incorporation.':
      'Extiende de 3 a 5 cm de compost maduro en la superficie. Las lombrices harán el trabajo de incorporarlo.',
  'Ajuste le pH':
      'Ajusta el pH',
  'Le potager aime un pH entre 6 et 7. Trop acide ? Ajoute de la chaux. Trop basique ? Du soufre ou du compost acide.':
      'Al huerto le gusta un pH entre 6 y 7. ¿Demasiado ácido? Añade cal. ¿Demasiado básico? Azufre o compost ácido.',
  'Affine en surface':
      'Afina la superficie',
  'Passe un râteau pour casser les mottes et obtenir une surface plane et fine, prête à recevoir les semis.':
      'Pasa un rastrillo para romper los terrones y conseguir una superficie plana y fina, lista para recibir las siembras.',
  'Paille ou sème un engrais vert':
      'Acolcha o siembra un abono verde',
  'Couvre le sol nu avec du paillage ou un engrais vert (moutarde, phacélie) pour le protéger et le nourrir.':
      'Cubre el suelo desnudo con acolchado o con un abono verde (mostaza, facelia) para protegerlo y alimentarlo.',
  'Pour connaître ton sol : fais un boudin avec de la terre humide dans ta main. S\'il tient, c\'est argileux. S\'il s\'effrite, c\'est sableux. S\'il est souple et doux, c\'est limoneux.':
      'Para conocer tu suelo: haz un churro con tierra húmeda en la mano. Si aguanta, es arcilloso. Si se desmigaja, es arenoso. Si es flexible y suave, es limoso.',
  'Retourner la terre au motoculteur :':
      'Dar la vuelta a la tierra con motocultor:',
  'détruit la structure du sol et la vie microbienne.':
      'destruye la estructura del suelo y la vida microbiana.',
  'Travailler un sol détrempé :':
      'Trabajar un suelo empapado:',
  'tu compactes la terre et crées des mottes impossibles à défaire.':
      'compactas la tierra y creas terrones imposibles de deshacer.',
  'il se dessèche, s\'érode et perd sa matière organique.':
      'se seca, se erosiona y pierde su materia orgánica.',
  'Abuser des amendements chimiques :':
      'Abusar de las enmiendas químicas:',
  'ils déséquilibrent la vie du sol à long terme.':
      'desequilibran la vida del suelo a largo plazo.',

  // ─── pucerons (32 textes, 315 mots) ───
  'Pucerons':
      'Pulgones',
  'Les suceurs de sève':
      'Los chupadores de savia',
  'Les pucerons sucent la sève des jeunes pousses et affaiblissent les plantes. Ils se reproduisent très vite mais ont beaucoup de prédateurs naturels.':
      'Los pulgones chupan la savia de los brotes jóvenes y debilitan las plantas. Se reproducen muy rápido, pero tienen muchos depredadores naturales.',
  'Identifier les pucerons':
      'Identificar los pulgones',
  'Colonies':
      'Colonias',
  'Des grappes de petits insectes verts, noirs ou roses s\'agglutinent sur les tiges tendres et sous les feuilles.':
      'Racimos de pequeños insectos verdes, negros o rosas se agolpan en los tallos tiernos y bajo las hojas.',
  'Miellat collant':
      'Melaza pegajosa',
  'Les pucerons excrètent un liquide sucré et collant qui recouvre les feuilles et attire un champignon noir : la fumagine.':
      'Los pulgones excretan un líquido dulce y pegajoso que cubre las hojas y atrae a un hongo negro: la negrilla.',
  'Feuilles déformées':
      'Hojas deformadas',
  'Les feuilles s\'enroulent, se crispent et se déforment. Les jeunes pousses sont rabougries et les bourgeons avortent.':
      'Las hojas se enrollan, se arrugan y se deforman. Los brotes jóvenes quedan raquíticos y los capullos abortan.',
  'Fourmis':
      'Hormigas',
  'Les fourmis élèvent les pucerons pour récolter leur miellat. Leur va-et-vient sur les tiges est un signe révélateur.':
      'Las hormigas crían pulgones para recoger su melaza. Su ir y venir por los tallos es una señal reveladora.',
  'Solutions naturelles':
      'Soluciones naturales',
  'Jet d\'eau':
      'Chorro de agua',
  'Un simple jet d\'eau puissant décroche les pucerons des tiges. Répète tous les 2-3 jours sur les petites colonies.':
      'Un simple chorro de agua potente desprende los pulgones de los tallos. Repite cada 2-3 días en las colonias pequeñas.',
  'Savon noir':
      'Jabón potásico',
  'Dilue 3 cuillères à soupe de savon noir liquide dans 1 litre d\'eau tiède. Pulvérise sur et sous les feuilles.':
      'Diluye 3 cucharadas soperas de jabón potásico líquido en 1 litro de agua tibia. Pulveriza por encima y por debajo de las hojas.',
  'Purin d\'ortie':
      'Purín de ortiga',
  'Dilué à 5%, le purin d\'ortie renforce les plantes et repousse les pucerons. Pulvérise tous les 10 jours.':
      'Diluido al 5%, el purín de ortiga fortalece las plantas y ahuyenta los pulgones. Pulveriza cada 10 días.',
  'Prédateurs 🐞':
      'Depredadores 🐞',
  'Attire les coccinelles, syrphes et chrysopes en laissant des zones fleuries. Une larve de coccinelle mange 150 pucerons par jour.':
      'Atrae a mariquitas, sírfidos y crisopas dejando zonas con flores. Una larva de mariquita se come 150 pulgones al día.',
  'Associations répulsives':
      'Asociaciones repelentes',
  'Plante de la lavande, de la menthe, du basilic ou des capucines près des cultures sensibles. Les pucerons détestent leurs odeurs.':
      'Planta lavanda, menta, albahaca o capuchinas cerca de los cultivos sensibles. Los pulgones detestan su olor.',
  'Les coccinelles et leurs larves mangent des centaines de pucerons par jour. Installe un hôtel à insectes et laisse quelques zones sauvages pour les accueillir.':
      'Las mariquitas y sus larvas se comen cientos de pulgones al día. Instala un hotel de insectos y deja algunas zonas silvestres para acogerlas.',
  'Insecticides chimiques :':
      'Insecticidas químicos:',
  'ils tuent aussi les coccinelles et les syrphes, tes meilleurs alliés contre les pucerons.':
      'también matan a las mariquitas y a los sírfidos, tus mejores aliados contra los pulgones.',
  'Trop d\'azote :':
      'Demasiado nitrógeno:',
  'un excès d\'engrais azoté produit des pousses tendres qui attirent massivement les pucerons.':
      'un exceso de abono nitrogenado produce brotes tiernos que atraen masivamente a los pulgones.',
  'Paniquer :':
      'Entrar en pánico:',
  'quelques pucerons ne sont pas graves. Laisse le temps aux prédateurs naturels d\'intervenir avant de traiter.':
      'unos cuantos pulgones no son graves. Deja tiempo a los depredadores naturales para intervenir antes de tratar.',
  'Ignorer les fourmis :':
      'Ignorar las hormigas:',
  'tant que les fourmis protègent les pucerons, les prédateurs ne pourront pas faire leur travail.':
      'mientras las hormigas protejan a los pulgones, los depredadores no podrán hacer su trabajo.',

  // ─── quand_arroser (26 textes, 308 mots) ───
  'Quand arroser ?':
      '¿Cuándo regar?',
  'Choisir le bon moment de la journée':
      'Elegir el momento adecuado del día',
  'Le meilleur moment pour arroser, c\'est quand le sol est frais et que l\'eau ne s\'évaporera pas tout de suite. Le soir en été, le matin en mi-saison, et peu souvent en hiver.':
      'El mejor momento para regar es cuando el suelo está fresco y el agua no se evaporará enseguida. Por la tarde en verano, por la mañana en entretiempo y poco en invierno.',
  'Le bon créneau selon la saison':
      'La franja adecuada según la estación',
  'Arrose le matin. Les nuits sont encore fraîches et l\'humidité du soir favorise les maladies.':
      'Riega por la mañana. Las noches todavía son frescas y la humedad de la tarde favorece las enfermedades.',
  'Arrose le soir, après 19h. Le sol a le temps d\'absorber sans que l\'eau ne s\'évapore.':
      'Riega al atardecer, a partir de las 19 h. El suelo tiene tiempo de absorber sin que el agua se evapore.',
  'Matin uniquement. Les nuits deviennent froides et l\'humidité stagnante fait pourrir les plants.':
      'Solo por la mañana. Las noches se vuelven frías y la humedad estancada pudre las plantas.',
  'Très rarement, en milieu de journée par temps doux. Jamais en période de gel.':
      'Muy de vez en cuando, a mediodía y con tiempo suave. Nunca durante las heladas.',
  'Les signes que tes plants ont soif':
      'Las señales de que tus plantas tienen sed',
  'Feuilles qui tombent en fin de journée':
      'Hojas que caen al final del día',
  'Les feuilles ramollissent et pendent vers le bas, surtout en fin d\'après-midi quand la chaleur est au maximum.':
      'Las hojas se ablandan y cuelgan hacia abajo, sobre todo al final de la tarde, cuando el calor es máximo.',
  'Terre craquelée en surface':
      'Tierra agrietada en la superficie',
  'Le sol se fissure et devient dur. L\'eau aura du mal à pénétrer : arrose doucement pour réhumidifier progressivement.':
      'El suelo se resquebraja y se endurece. Al agua le costará penetrar: riega despacio para volver a humedecer poco a poco.',
  'Feuilles qui jaunissent par le bas':
      'Hojas que amarillean por abajo',
  'La plante sacrifie ses feuilles basses pour économiser l\'eau. C\'est un signal de stress hydrique avancé.':
      'La planta sacrifica sus hojas bajas para ahorrar agua. Es una señal de estrés hídrico avanzado.',
  'Fruits qui s\'arrêtent de grossir':
      'Frutos que dejan de crecer',
  'Sans eau suffisante, la plante stoppe la production de fruits pour concentrer ses ressources sur sa survie.':
      'Sin agua suficiente, la planta detiene la producción de frutos para concentrar sus recursos en sobrevivir.',
  'Par forte chaleur (+30°C), un arrosage de 20 mm vaut mieux que deux arrosages de 10 mm. L\'eau descend plus profond et résiste mieux à l\'évaporation.':
      'Con mucho calor (+30°C), un riego de 20 mm vale más que dos riegos de 10 mm. El agua baja más hondo y resiste mejor la evaporación.',
  'Arroser entre 11h et 17h l\'été :':
      'Regar entre las 11 h y las 17 h en verano:',
  'l\'eau s\'évapore avant d\'atteindre les racines et le choc thermique abîme les plants.':
      'el agua se evapora antes de llegar a las raíces y el choque térmico daña las plantas.',
  'Arroser par temps de gel :':
      'Regar con heladas:',
  'l\'eau gèle au contact des racines et peut les détruire.':
      'el agua se congela en contacto con las raíces y puede destruirlas.',
  'Arroser juste avant la pluie :':
      'Regar justo antes de la lluvia:',
  'tu gaspilles de l\'eau et tu risques de noyer les plants avec un double apport.':
      'malgastas agua y te arriesgas a ahogar las plantas con un doble aporte.',
  'Arroser à heure fixe sans regarder la terre :':
      'Regar a hora fija sin mirar la tierra:',
  'chaque jour est différent, observe le sol avant de décider.':
      'cada día es distinto; observa el suelo antes de decidir.',

  // ─── quand_recolter (41 textes, 252 mots) ───
  'Quand récolter ?':
      '¿Cuándo cosechar?',
  'Reconnaître le bon moment':
      'Reconocer el momento adecuado',
  'Chaque légume a ses signes de maturité bien précis : couleur, taille, fermeté, odeur. Récolté au bon moment, il est plus savoureux et se conserve mieux.':
      'Cada hortaliza tiene señales de madurez muy concretas: color, tamaño, firmeza, olor. Cosechada en su punto, es más sabrosa y se conserva mejor.',
  'Les signes à surveiller':
      'Las señales a vigilar',
  'Délai':
      'Plazo',
  'Signe de maturité':
      'Señal de madurez',
  '2-3 mois':
      '2-3 meses',
  'Couleur pleine, légère souplesse':
      'Color pleno, ligeramente blando',
  '2 mois':
      '2 meses',
  '15-20 cm, peau brillante':
      '15-20 cm, piel brillante',
  '3-4 mois':
      '3-4 meses',
  'Collet visible, 2-3 cm diamètre':
      'Cuello visible, 2-3 cm de diámetro',
  '6-8 sem':
      '6-8 sem',
  'Pomme bien formée, avant la montée':
      'Cogollo bien formado, antes de que espigue',
  'Gousse ferme, avant durcissement':
      'Vaina firme, antes de que se endurezca',
  '3 mois':
      '3 meses',
  'Couleur finale, chair ferme':
      'Color definitivo, pulpa firme',
  '🌽 Maïs':
      '🌽 Maíz',
  'Barbes brunes, jus laiteux au grain':
      'Barbas pardas, jugo lechoso en el grano',
  '5-6 mois':
      '5-6 meses',
  'Feuillage tombé et sec':
      'Follaje caído y seco',
  'Les bons gestes':
      'Los buenos gestos',
  'Récolte tôt le matin 🌅':
      'Cosecha a primera hora de la mañana 🌅',
  'Les légumes sont gorgés de fraîcheur après la nuit, avant que la chaleur ne les ramollisse.':
      'Las hortalizas están llenas de frescura después de la noche, antes de que el calor las ablande.',
  'Utilise un couteau propre 🔪':
      'Usa un cuchillo limpio 🔪',
  'Une coupe nette évite de blesser la plante et limite les risques de maladie.':
      'Un corte limpio evita herir la planta y limita los riesgos de enfermedad.',
  'Manipule avec douceur 🤲':
      'Manipula con suavidad 🤲',
  'Les chocs et les pressions abîment les fruits et accélèrent le pourrissement.':
      'Los golpes y las presiones estropean los frutos y aceleran la podredumbre.',
  'Ramasse souvent 📅':
      'Recolecta a menudo 📅',
  'Récolter régulièrement stimule la plante à produire davantage de fruits.':
      'Cosechar con regularidad estimula a la planta a producir más frutos.',
  'Garde 2 cm de pédoncule 🌱':
      'Deja 2 cm de pedúnculo 🌱',
  'Laisser un bout de tige protège le fruit et améliore sa conservation.':
      'Dejar un trozo de tallo protege el fruto y mejora su conservación.',
  'Goûte régulièrement une petite partie pour apprendre à reconnaître la maturité par le goût.':
      'Prueba con regularidad una pequeña parte para aprender a reconocer la madurez por el sabor.',
  'Attendre trop longtemps :':
      'Esperar demasiado:',
  'les légumes deviennent fibreux, amers ou éclatent sur le plant.':
      'las hortalizas se vuelven fibrosas, amargas o se abren en la planta.',
  'Récolter sous la pluie :':
      'Cosechar bajo la lluvia:',
  'l\'humidité favorise les moisissures et réduit la conservation.':
      'la humedad favorece el moho y reduce la conservación.',
  'Tirer sur le plant :':
      'Tirar de la planta:',
  'tu risques d\'arracher les racines ou de casser la tige principale.':
      'te arriesgas a arrancar las raíces o a romper el tallo principal.',
  'Laver avant stockage :':
      'Lavar antes de guardar:',
  'l\'humidité accélère le pourrissement. Lave juste avant de consommer.':
      'la humedad acelera la podredumbre. Lava justo antes de consumir.',

  // ─── quand_semer (29 textes, 207 mots) ───
  'Quand semer ?':
      '¿Cuándo sembrar?',
  'des principaux légumes':
      'de las principales hortalizas',
  'Chaque légume a sa période idéale. Le bon timing dépend de la température du sol et du risque de gelées.':
      'Cada hortaliza tiene su época ideal. El momento adecuado depende de la temperatura del suelo y del riesgo de heladas.',
  'Calendrier des semis':
      'Calendario de siembras',
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
      'Las grandes referencias',
  'Février - Mars':
      'Febrero - Marzo',
  'Semis en intérieur des légumes du soleil (tomates, poivrons, aubergines). Patience, il fait encore froid dehors.':
      'Siembra en interior de las hortalizas de sol (tomates, pimientos, berenjenas). Paciencia, fuera todavía hace frío.',
  'Avril':
      'Abril',
  'Les premiers semis en pleine terre : carottes, radis, salades. Le sol se réchauffe progressivement.':
      'Las primeras siembras en tierra: zanahorias, rábanos, lechugas. El suelo se va calentando poco a poco.',
  'Mi-mai':
      'Mediados de mayo',
  'Après les Saints de Glace, tout peut sortir ! Courgettes, haricots, courges rejoignent le potager.':
      'Pasados los Santos de Hielo, ¡todo puede salir! Calabacines, judías y calabazas se incorporan al huerto.',
  'Août - Septembre':
      'Agosto - Septiembre',
  'Semis d\'automne : mâche, épinards, oignons, engrais verts. Le jardin ne s\'arrête jamais vraiment.':
      'Siembras de otoño: canónigos, espinacas, cebollas, abonos verdes. El huerto nunca se detiene del todo.',
  'Décale tes semis de 2-3 semaines pour les légumes à croissance rapide (radis, salade). Tu étaleras ainsi tes récoltes au lieu de tout avoir en même temps.':
      'Escalona tus siembras de 2-3 semanas en las hortalizas de crecimiento rápido (rábanos, lechuga). Así repartirás las cosechas en lugar de tenerlo todo a la vez.',
  'Semer avant les dernières gelées :':
      'Sembrar antes de las últimas heladas:',
  'une nuit de gel suffit à détruire des semis fragiles en pleine terre.':
      'una noche de helada basta para destruir siembras frágiles en tierra.',
  'Tout semer en même temps :':
      'Sembrarlo todo a la vez:',
  'tu te retrouveras débordé au repiquage et à la récolte.':
      'te verás desbordado en el trasplante y en la cosecha.',
  'Ignorer sa zone climatique :':
      'Ignorar tu zona climática:',
  'les dates varient selon ta région, adapte le calendrier à ton climat local.':
      'las fechas varían según tu región; adapta el calendario a tu clima local.',
  'Ne pas noter les dates :':
      'No anotar las fechas:',
  'sans suivi, impossible de savoir ce qui a marché ou quand replanter l\'an prochain.':
      'sin seguimiento, es imposible saber qué funcionó o cuándo volver a plantar el año que viene.',

  // ─── recolter_aromatiques (40 textes, 239 mots) ───
  'Récolter les aromatiques':
      'Cosechar las aromáticas',
  'Pour un maximum de saveur':
      'Para sacarles el máximo sabor',
  'Les aromatiques se récoltent au moment où leurs huiles essentielles sont les plus concentrées.':
      'Las aromáticas se cosechan cuando sus aceites esenciales están más concentrados.',
  'Quand cueillir chaque plante':
      'Cuándo cortar cada planta',
  'Quand':
      'Cuándo',
  'Avant floraison':
      'Antes de la floración',
  'Sommets des tiges':
      'Puntas de los tallos',
  'Toute saison':
      'Todo el año',
  'Tiges extérieures':
      'Tallos exteriores',
  '🌿 Ciboulette':
      '🌿 Cebollino',
  'Dès 15 cm':
      'A partir de 15 cm',
  'Tiges à la base':
      'Tallos desde la base',
  'Jeunes pousses':
      'Brotes jóvenes',
  '🌿 Thym':
      '🌿 Tomillo',
  'Début floraison':
      'Inicio de la floración',
  'Rameaux feuillus':
      'Ramitas con hojas',
  '🌿 Romarin':
      '🌿 Romero',
  'Toute l\'année':
      'Todo el año',
  'Extrémités de branches':
      'Puntas de las ramas',
  '💜 Lavande':
      '💜 Lavanda',
  'Tiges florales':
      'Tallos florales',
  'Récolte le matin après la rosée 🌅':
      'Cosecha por la mañana, cuando se haya secado el rocío 🌅',
  'Les huiles essentielles sont au maximum en fin de matinée, quand la rosée a séché mais avant la grosse chaleur.':
      'Los aceites esenciales alcanzan su máximo a media mañana, cuando el rocío se ha secado pero antes del calor fuerte.',
  'Coupe au-dessus d\'un nœud ✂️':
      'Corta por encima de un nudo ✂️',
  'La plante repart plus facilement à partir d\'un nœud. Utilise des ciseaux propres et aiguisés.':
      'La planta rebrota con más facilidad desde un nudo. Usa tijeras limpias y afiladas.',
  'Ne prélève jamais plus d\'un tiers':
      'No quites nunca más de un tercio',
  'Laisser au moins deux tiers du feuillage permet à la plante de se régénérer rapidement.':
      'Dejar al menos dos tercios del follaje permite que la planta se regenere rápido.',
  'Supprime les fleurs régulièrement 🌸':
      'Quita las flores con regularidad 🌸',
  'Pincer les fleurs empêche la montée en graines et prolonge la production de feuilles aromatiques.':
      'Pinzar las flores impide que espigue y prolonga la producción de hojas aromáticas.',
  'Sèche ou congèle vite':
      'Seca o congela rápido',
  'Les aromatiques perdent vite leur arôme. Fais sécher en bouquets suspendus ou congèle dans de l\'huile d\'olive.':
      'Las aromáticas pierden pronto su aroma. Sécalas en ramilletes colgados o congélalas en aceite de oliva.',
  'Pour le basilic : pince régulièrement le sommet des tiges.':
      'Para la albahaca: pinza con regularidad la punta de los tallos.',
  'Récolter après la pluie :':
      'Cosechar después de la lluvia:',
  'les feuilles mouillées perdent leurs arômes et sèchent mal.':
      'las hojas mojadas pierden sus aromas y se secan mal.',
  'Laisser fleurir trop longtemps :':
      'Dejar florecer demasiado tiempo:',
  'les feuilles deviennent amères et la plante s\'épuise.':
      'las hojas se vuelven amargas y la planta se agota.',
  'Couper au ras du sol :':
      'Cortar a ras de suelo:',
  'la plante ne peut plus repartir et meurt rapidement.':
      'la planta ya no puede rebrotar y muere enseguida.',
  'Stocker dans un sac fermé :':
      'Guardarlas en una bolsa cerrada:',
  'l\'humidité emprisonnée provoque moisissures et perte de saveur.':
      'la humedad atrapada provoca moho y pérdida de sabor.',

  // ─── recolter_racines (29 textes, 318 mots) ───
  'Récolter les racines':
      'Cosechar las raíces',
  'Sans les casser ni les abîmer':
      'Sin romperlas ni estropearlas',
  'Les légumes-racines se récoltent avec précaution pour éviter les blessures.':
      'Las hortalizas de raíz se cosechan con cuidado para evitar heridas.',
  'La méthode étape par étape':
      'El método paso a paso',
  'Arrose la veille 💧':
      'Riega la víspera 💧',
  'Une terre humide est plus souple et libère les racines sans les casser.':
      'Una tierra húmeda es más blanda y libera las raíces sin romperlas.',
  'Enfonce la fourche à 15 cm du plant':
      'Clava la horca a 15 cm de la planta',
  'Garde de la distance pour ne pas transpercer la racine. Utilise une fourche-bêche, jamais une bêche plate.':
      'Mantén la distancia para no atravesar la raíz. Usa una horca de cavar, nunca una pala plana.',
  'Soulève en levier 💪':
      'Levanta haciendo palanca 💪',
  'Bascule la fourche doucement pour soulever la terre et la racine ensemble, sans forcer.':
      'Inclina la horca con suavidad para levantar la tierra y la raíz juntas, sin forzar.',
  'Tire délicatement par le feuillage':
      'Tira con delicadeza del follaje',
  'Une fois la terre soulevée, saisis le collet et tire droit vers le haut sans tordre.':
      'Una vez levantada la tierra, agarra el cuello y tira recto hacia arriba sin torcer.',
  'Laisse sécher au sol 1-2 h ☀️':
      'Déjalas secar en el suelo 1-2 h ☀️',
  'La terre restante sèche et se détache facilement. Ne lave pas les racines si tu veux les stocker longtemps.':
      'La tierra que queda se seca y se desprende fácilmente. No laves las raíces si quieres guardarlas mucho tiempo.',
  'Spécificités par légume':
      'Particularidades por hortaliza',
  'Récolte quand le collet dépasse de 2-3 cm. Ameublis bien la terre avant pour les sortir entières. Coupe les fanes à 1 cm pour le stockage.':
      'Cosecha cuando el cuello sobresalga 2-3 cm. Afloja bien la tierra antes para sacarlas enteras. Corta las hojas a 1 cm para guardarlas.',
  'Betterave':
      'Remolacha',
  'Taille idéale : 8-10 cm de diamètre. Ne coupe pas la racine pivotante, elle « saigne » et perd son jus. Tords les fanes plutôt que les couper.':
      'Tamaño ideal: 8-10 cm de diámetro. No cortes la raíz pivotante: «sangra» y pierde su jugo. Retuerce las hojas en vez de cortarlas.',
  'Pomme de terre':
      'Patata',
  'Attends que le feuillage ait jauni et séché. Fouille à la main après avoir soulevé la terre. Laisse sécher 2-3 h avant de stocker à l\'obscurité.':
      'Espera a que el follaje se haya puesto amarillo y seco. Busca a mano después de levantar la tierra. Déjalas secar 2-3 h antes de guardarlas en la oscuridad.',
  'Récolte quand les tiges sont tombées et sèches. Arrache à la main et laisse sécher au soleil 2-3 jours avant de tresser ou stocker en filet.':
      'Cosecha cuando los tallos se hayan caído y estén secos. Arranca a mano y deja secar al sol 2-3 días antes de trenzar o guardar en red.',
  'Pour les carottes et panais, tu peux les laisser en terre tout l\'hiver.':
      'Las zanahorias y las chirivías puedes dejarlas en la tierra todo el invierno.',
  'Bêcher trop près :':
      'Cavar demasiado cerca:',
  'tu risques de trancher la racine et de la rendre impropre au stockage.':
      'te arriesgas a cortar la raíz y a dejarla inservible para guardar.',
  'Tirer de force :':
      'Tirar a la fuerza:',
  'la racine casse net dans le sol et le bout perdu pourrit sur place.':
      'la raíz se parte en seco dentro del suelo y la punta que se queda se pudre allí mismo.',
  'l\'humidité provoque la pourriture. Brosse simplement la terre sèche.':
      'la humedad provoca podredumbre. Basta con cepillar la tierra seca.',
  'Laisser au soleil trop longtemps :':
      'Dejarlas al sol demasiado tiempo:',
  'les pommes de terre verdissent et deviennent toxiques en quelques heures.':
      'las patatas se ponen verdes y se vuelven tóxicas en pocas horas.',

  // ─── reussir_semis (40 textes, 360 mots) ───
  'Réussir ses semis':
      'Lograr buenas siembras',
  'En godet ou en pleine terre ✨':
      'En macetita o en tierra ✨',
  'Un bon semis, c\'est trois choses : la bonne période, un terreau léger et humide, et un peu de patience.':
      'Una buena siembra son tres cosas: la época adecuada, un sustrato ligero y húmedo, y un poco de paciencia.',
  'En godet':
      'En macetita',
  'Idéal pour démarrer tôt à l\'abri et contrôler les conditions':
      'Ideal para empezar pronto a cubierto y controlar las condiciones',
  'Pleine terre':
      'En tierra',
  'Direct au jardin, pour les semis robustes et les belles saisons':
      'Directamente en el huerto, para siembras robustas y estaciones buenas',
  'Semer en godet':
      'Sembrar en macetita',
  'Pour anticiper la saison en douceur':
      'Para adelantarte a la estación con suavidad',
  'Choisis ton contenant':
      'Elige tu recipiente',
  'Godets, pots de yaourt percés ou plaques alvéolées : l\'important, c\'est le trou de drainage.':
      'Macetitas, vasos de yogur agujereados o bandejas de alvéolos: lo importante es el agujero de drenaje.',
  'Remplis de terreau':
      'Rellena con sustrato',
  'Utilise un terreau spécial semis, léger et fin. Tasse légèrement sans compacter.':
      'Usa un sustrato especial para semilleros, ligero y fino. Aprieta ligeramente sin compactar.',
  'Dépose les graines':
      'Coloca las semillas',
  '2 à 3 graines par godet, en surface ou enfoncées selon la taille (règle : 2 fois l\'épaisseur de la graine).':
      '2 a 3 semillas por macetita, en la superficie o hundidas según el tamaño (regla: 2 veces el grosor de la semilla).',
  'Vaporise puis couvre':
      'Pulveriza y tapa',
  'Humidifie au brumisateur et couvre d\'un film ou d\'un couvercle transparent pour maintenir l\'humidité.':
      'Humedece con un pulverizador y tapa con un film o una tapa transparente para mantener la humedad.',
  'Place au chaud et à la lumière':
      'Pon en un lugar cálido y con luz',
  'Près d\'une fenêtre ou sous une lampe. La chaleur accélère la germination, la lumière évite l\'étiolement.':
      'Cerca de una ventana o bajo una lámpara. El calor acelera la germinación y la luz evita el ahilamiento.',
  'Semer en pleine terre':
      'Sembrar en tierra',
  'Direct au jardin, simple et efficace':
      'Directamente en el huerto, sencillo y eficaz',
  'Attends la bonne température':
      'Espera a la temperatura adecuada',
  'Le sol doit être assez chaud pour la graine choisie. En cas de doute, utilise un thermomètre de sol.':
      'El suelo debe estar lo bastante caliente para la semilla elegida. Si tienes dudas, usa un termómetro de suelo.',
  'Prépare ta terre':
      'Prepara tu tierra',
  'Ameublis la surface sur 5 cm, retire les cailloux et les mottes. Le lit de semences doit être fin et meuble.':
      'Afloja la superficie 5 cm, retira las piedras y los terrones. El lecho de siembra debe ser fino y suelto.',
  'Trace tes sillons':
      'Traza tus surcos',
  'Avec le manche d\'un outil, trace des lignes à la profondeur adaptée. Respecte l\'espacement indiqué sur le sachet.':
      'Con el mango de una herramienta, traza líneas a la profundidad adecuada. Respeta el espaciado indicado en el sobre.',
  'Sème et recouvre':
      'Siembra y cubre',
  'Dépose les graines régulièrement, recouvre de terre fine et tasse légèrement avec le dos de la main.':
      'Coloca las semillas de forma regular, cubre con tierra fina y aprieta ligeramente con el dorso de la mano.',
  'Arrose en pluie fine':
      'Riega en lluvia fina',
  'Utilise un arrosoir à pomme fine pour ne pas déplacer les graines. Maintiens humide jusqu\'à la levée.':
      'Usa una regadera de roseta fina para no desplazar las semillas. Mantén húmedo hasta que salgan las plántulas.',
  'Note la date de semis sur une petite étiquette. Tu sauras exactement quand la levée est attendue et si tout se passe bien.':
      'Anota la fecha de siembra en una etiqueta pequeña. Sabrás exactamente cuándo se espera la germinación y si todo va bien.',
  'Arroser trop fort :':
      'Regar demasiado fuerte:',
  'un jet puissant déplace les graines et compacte la surface du terreau.':
      'un chorro potente desplaza las semillas y compacta la superficie del sustrato.',
  'Semer trop serré :':
      'Sembrar demasiado apretado:',
  'les plantules se gênent et s\'étiolent en cherchant la lumière.':
      'las plántulas se estorban y se ahílan buscando la luz.',
  'Semer trop tôt :':
      'Sembrar demasiado pronto:',
  'sans chaleur suffisante, les graines pourrissent au lieu de germer.':
      'sin calor suficiente, las semillas se pudren en lugar de germinar.',
  'Oublier d\'aérer le film :':
      'Olvidar airear el film:',
  'l\'excès d\'humidité provoque la fonte des semis (moisissure).':
      'el exceso de humedad provoca el mal del talluelo (moho) en las plántulas.',

  // ─── reutiliser_dechets (40 textes, 407 mots) ───
  'Réutiliser ses déchets':
      'Reutilizar tus residuos',
  'Le potager zéro déchet':
      'El huerto residuo cero',
  'Beaucoup de tes déchets de cuisine et de jardin sont de l\'or pour ton potager. Avant de jeter, demande-toi si ça peut nourrir ta terre.':
      'Muchos de tus residuos de cocina y de jardín son oro para tu huerto. Antes de tirar, pregúntate si pueden alimentar tu tierra.',
  'Déchets de cuisine':
      'Residuos de cocina',
  'Marc de café ☕':
      'Posos de café ☕',
  'Riche en azote, il enrichit le compost et repousse les limaces. Épands-le au pied des plants ou mélange-le à la terre.':
      'Ricos en nitrógeno, enriquecen el compost y ahuyentan las babosas. Espárcelos al pie de las plantas o mézclalos con la tierra.',
  'Coquilles d\'œufs 🥚':
      'Cáscaras de huevo 🥚',
  'Broyées finement, elles apportent du calcium et freinent les limaces. Autour des salades, c\'est redoutable.':
      'Trituradas finamente, aportan calcio y frenan a las babosas. Alrededor de las lechugas, son temibles.',
  'Peaux de banane 🍌':
      'Cáscaras de plátano 🍌',
  'Riches en potassium, elles boostent la floraison. Coupe-les en morceaux et enterre-les au pied des tomates et rosiers.':
      'Ricas en potasio, impulsan la floración. Córtalas en trozos y entiérralas al pie de los tomates y los rosales.',
  'Eau de cuisson 🍲':
      'Agua de cocción 🍲',
  'L\'eau de cuisson des légumes (non salée !) est un engrais naturel riche en minéraux. Laisse-la refroidir et arrose.':
      'El agua de cocer hortalizas (¡sin sal!) es un abono natural rico en minerales. Déjala enfriar y riega.',
  'Cendres de cheminée 🔥':
      'Cenizas de chimenea 🔥',
  'Riches en potasse et calcium, elles corrigent l\'acidité du sol. Maximum 2 poignées par m² et par an.':
      'Ricas en potasa y calcio, corrigen la acidez del suelo. Máximo 2 puñados por m² y por año.',
  'Déchets de jardin':
      'Residuos de jardín',
  'Tonte de gazon 🌱':
      'Siega de césped 🌱',
  'En fine couche (2-3 cm) autour des plants, c\'est un paillage gratuit. Laisse-la sécher avant pour éviter la fermentation.':
      'En capa fina (2-3 cm) alrededor de las plantas, es un acolchado gratis. Déjala secar antes para evitar la fermentación.',
  'Le meilleur paillage d\'hiver. En couche épaisse sur les planches vides, elles protègent et nourrissent le sol.':
      'El mejor acolchado de invierno. En capa gruesa sobre los bancales vacíos, protegen y alimentan el suelo.',
  'Petites branches 🪵':
      'Ramitas 🪵',
  'Broyées en BRF (Bois Raméal Fragmenté), elles créent un humus forestier fantastique pour le sol.':
      'Trituradas como BRF (Madera Rameal Fragmentada), crean un humus de bosque fantástico para el suelo.',
  'Mauvaises herbes 🌾':
      'Malas hierbas 🌾',
  'Avant la montée en graines, elles vont au compost. Le purin d\'ortie est un super engrais et insecticide naturel.':
      'Antes de que echen semillas, van al compost. El purín de ortiga es un abono y un insecticida natural buenísimo.',
  'Contenants à recycler':
      'Recipientes para reciclar',
  'Boîtes d\'œufs 🥚':
      'Cartones de huevos 🥚',
  'Parfaites pour les semis : remplis chaque alvéole de terreau, sème une graine, et plante le tout en terre.':
      'Perfectos para las siembras: rellena cada hueco con sustrato, siembra una semilla y planta todo junto en la tierra.',
  'Bouteilles plastique 🍶':
      'Botellas de plástico 🍶',
  'Coupées en deux : la partie basse devient pot, la partie haute sert de cloche pour protéger les jeunes plants.':
      'Cortadas por la mitad: la parte baja se convierte en maceta y la parte alta sirve de campana para proteger las plantas jóvenes.',
  'Rouleaux de papier toilette 🧻':
      'Rollos de papel higiénico 🧻',
  'Godets biodégradables parfaits pour les semis de haricots ou tournesols. Tu plantes le rouleau entier en terre.':
      'Macetitas biodegradables perfectas para las siembras de judías o girasoles. Plantas el rollo entero en la tierra.',
  'Cartons bruns 📦':
      'Cartones marrones 📦',
  'Non imprimés, ils servent de paillage anti-mauvaises herbes. Mouille-les et couvre-les de paille ou de tonte.':
      'Sin imprimir, sirven de acolchado contra las malas hierbas. Mójalos y cúbrelos de paja o de siega.',
  'Garde un seau dédié aux épluchures dans la cuisine. En quelques jours, tu as de quoi nourrir ton compost pour une semaine.':
      'Ten un cubo dedicado a las peladuras en la cocina. En pocos días tienes con qué alimentar tu compost durante una semana.',
  'Composter viande et poisson :':
      'Compostar carne y pescado:',
  'ça attire les nuisibles et ça sent mauvais. Réserve-les à la poubelle.':
      'atrae plagas y huele mal. Resérvalos para la basura.',
  'Trop d\'agrumes dans le compost :':
      'Demasiados cítricos en el compost:',
  'ils acidifient et ralentissent la décomposition. Maximum 10% du volume.':
      'lo acidifican y ralentizan la descomposición. Máximo 10% del volumen.',
  'Utiliser des cendres de bois traité :':
      'Usar cenizas de madera tratada:',
  'elles contiennent des produits chimiques nocifs pour le sol et les plantes.':
      'contienen productos químicos nocivos para el suelo y las plantas.',
  'Composter les plantes malades :':
      'Compostar las plantas enfermas:',
  'les spores survivent et contaminent le futur compost. Brûle-les ou jette-les.':
      'las esporas sobreviven y contaminan el compost futuro. Quémalas o tíralas.',

  // ─── semis_interieur (29 textes, 282 mots) ───
  'Semis en intérieur':
      'Siembra en interior',
  'Prendre de l\'avance sur la saison':
      'Adelantarte a la estación',
  'Semer en intérieur permet d\'anticiper de 4 à 8 semaines sur la météo extérieure.':
      'Sembrar en interior permite adelantarse de 4 a 8 semanas al tiempo exterior.',
  'Les légumes à semer en intérieur':
      'Las hortalizas para sembrar en interior',
  'Légumes du soleil':
      'Hortalizas de sol',
  'Tomates, poivrons, aubergines, piments. Ils ont besoin de chaleur pour germer et d\'un long temps de croissance.':
      'Tomates, pimientos, berenjenas, guindillas. Necesitan calor para germinar y un largo tiempo de crecimiento.',
  'Cucurbitacées':
      'Cucurbitáceas',
  'Courgettes, concombres, courges. Elles germent vite mais craignent le froid : un départ en intérieur les protège.':
      'Calabacines, pepinos, calabazas. Germinan rápido pero temen el frío: empezar en interior las protege.',
  'Salades et choux':
      'Lechugas y coles',
  'Laitues, choux, brocolis. Ils se repiquent facilement et apprécient un démarrage au frais en intérieur.':
      'Lechugas, coles, brócolis. Se trasplantan con facilidad y agradecen empezar en fresco en interior.',
  'Comment faire':
      'Cómo hacerlo',
  'Emplacement fenêtre sud':
      'Lugar junto a la ventana orientada al sur',
  'Choisis un rebord de fenêtre exposé plein sud pour un maximum de lumière naturelle (au moins 6h/jour).':
      'Elige un alféizar orientado completamente al sur para tener el máximo de luz natural (al menos 6 h/día).',
  'Maintiens 18-22°C':
      'Mantén 18-22°C',
  'La plupart des graines germent dans cette plage. Un tapis chauffant peut aider les espèces frileuses.':
      'La mayoría de las semillas germinan en este rango. Una manta térmica puede ayudar a las especies frioleras.',
  'Surveille l\'humidité':
      'Vigila la humedad',
  'Le terreau doit rester humide mais jamais détrempé. Vaporise régulièrement plutôt que d\'arroser abondamment.':
      'El sustrato debe mantenerse húmedo, pero nunca empapado. Pulveriza con regularidad en vez de regar abundantemente.',
  'Tourne les godets':
      'Gira las macetitas',
  'Fais un quart de tour chaque jour pour que les plantules poussent droites au lieu de se pencher vers la lumière.':
      'Da un cuarto de vuelta cada día para que las plántulas crezcan rectas en vez de inclinarse hacia la luz.',
  'Endurcis avant de planter':
      'Endurece antes de plantar',
  '2 semaines avant le repiquage, sors les plants quelques heures par jour pour les habituer au vent et au soleil direct.':
      '2 semanas antes del trasplante, saca las plantas unas horas al día para acostumbrarlas al viento y al sol directo.',
  'Groupe les semis d\'une même famille sur un même plateau. Ils ont les mêmes besoins en température et en arrosage, ce qui simplifie l\'entretien.':
      'Agrupa las siembras de una misma familia en una misma bandeja. Tienen las mismas necesidades de temperatura y de riego, lo que simplifica el mantenimiento.',
  'Manque de lumière :':
      'Falta de luz:',
  'les plantules filent et s\'étiolent, devenant trop fragiles pour survivre au repiquage.':
      'las plántulas se estiran y se ahílan, y quedan demasiado frágiles para sobrevivir al trasplante.',
  'Près d\'un radiateur :':
      'Cerca de un radiador:',
  'l\'air chaud et sec dessèche le terreau en quelques heures et grille les jeunes pousses.':
      'el aire caliente y seco reseca el sustrato en pocas horas y abrasa los brotes jóvenes.',
  'Repiquer sans endurcir :':
      'Trasplantar sin endurecer:',
  'le choc thermique et le vent peuvent tuer un plant habitué au confort intérieur.':
      'el choque térmico y el viento pueden matar una planta acostumbrada a la comodidad del interior.',
  'les plants deviennent trop grands avant la date de repiquage et végètent dans leurs godets.':
      'las plantas se hacen demasiado grandes antes de la fecha de trasplante y languidecen en sus macetitas.',

  // ─── temperature_germination (47 textes, 294 mots) ───
  'Température de germination':
      'Temperatura de germinación',
  'Le thermomètre, le meilleur ami du semeur':
      'El termómetro, el mejor amigo de quien siembra',
  'Une graine ne germe que dans une plage de température bien précise. Trop froid, elle dort. Trop chaud, elle souffre.':
      'Una semilla solo germina dentro de un rango de temperatura muy preciso. Con demasiado frío, duerme. Con demasiado calor, sufre.',
  'Les températures idéales':
      'Las temperaturas ideales',
  'Min. sol':
      'Mín. suelo',
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
      '🍃 Espinaca',
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
      '🍆 Berenjena',
  '18°C':
      '18°C',
  '20-25°C':
      '20-25°C',
  '10°C':
      '10°C',
  '18-25°C':
      '18-25°C',
  'Comment mesurer et maintenir':
      'Cómo medir y mantener',
  'Utilise un thermomètre de sol':
      'Usa un termómetro de suelo',
  'Enfonce-le à 5 cm de profondeur le matin. C\'est la température la plus basse de la journée, la plus fiable.':
      'Introdúcelo a 5 cm de profundidad por la mañana. Es la temperatura más baja del día, la más fiable.',
  'Réchauffe avec un voile':
      'Caliéntalo con un velo',
  'Un voile de forçage ou un tunnel plastique peut gagner 3 à 5°C au niveau du sol.':
      'Un velo de forzado o un túnel de plástico puede ganar de 3 a 5°C a nivel del suelo.',
  'Utilise un tapis chauffant':
      'Usa una manta térmica',
  'Pour les semis en intérieur, un tapis chauffant maintient une température constante sous les godets.':
      'Para las siembras en interior, una manta térmica mantiene una temperatura constante bajo las macetitas.',
  'Paille pour réguler':
      'Paja para regular',
  'En pleine terre, le paillage isole le sol : il garde la chaleur accumulée le jour et protège du froid nocturne.':
      'En tierra, el acolchado aísla el suelo: conserva el calor acumulado durante el día y protege del frío nocturno.',
  'Les signes qui ne trompent pas':
      'Las señales que no engañan',
  'Trop froid':
      'Demasiado frío',
  'Les graines ne germent pas ou mettent un temps anormalement long. Risque de pourriture dans un sol froid et humide.':
      'Las semillas no germinan o tardan un tiempo anormalmente largo. Riesgo de podredumbre en un suelo frío y húmedo.',
  'Trop chaud':
      'Demasiado calor',
  'Les plantules filent, s\'affaiblissent et se dessèchent. La germination peut être inhibée au-delà de 35°C.':
      'Las plántulas se estiran, se debilitan y se secan. La germinación puede quedar inhibida por encima de 35°C.',
  'Température idéale':
      'Temperatura ideal',
  'Levée rapide et régulière, plantules trapues et vigoureuses avec de belles premières feuilles.':
      'Germinación rápida y regular, plántulas robustas y vigorosas con unas primeras hojas preciosas.',
  'La température nocturne est souvent plus basse que tu ne crois. Mesure-la pour éviter les mauvaises surprises, surtout au printemps.':
      'La temperatura nocturna suele ser más baja de lo que crees. Mídela para evitar malas sorpresas, sobre todo en primavera.',
  'Se fier à la météo air :':
      'Fiarte de la temperatura del aire:',
  'la température du sol est souvent 5 à 10°C plus basse que celle de l\'air.':
      'la temperatura del suelo suele ser de 5 a 10°C más baja que la del aire.',
  'Surchauffer les semis :':
      'Sobrecalentar las siembras:',
  'au-delà de 30°C, beaucoup de graines entrent en dormance forcée.':
      'por encima de 30°C, muchas semillas entran en una latencia forzada.',
  'Sol froid et détrempé :':
      'Suelo frío y empapado:',
  'combinaison fatale qui fait pourrir les graines avant même la germination.':
      'combinación fatal que pudre las semillas antes incluso de germinar.',
  'Semer au hasard :':
      'Sembrar al azar:',
  'chaque espèce a ses exigences, vérifier la température évite beaucoup d\'échecs.':
      'cada especie tiene sus exigencias; comprobar la temperatura evita muchos fracasos.',

  // ─── traitements_bio (38 textes, 397 mots) ───
  'Traitements bio':
      'Tratamientos ecológicos',
  'La pharmacie verte du jardinier':
      'El botiquín verde del hortelano',
  'Les traitements bio s\'appuient sur des plantes, des minéraux ou des bactéries naturelles. Ils respectent la vie du sol et les auxiliaires du jardin.':
      'Los tratamientos ecológicos se basan en plantas, minerales o bacterias naturales. Respetan la vida del suelo y a los auxiliares del jardín.',
  'Les traitements essentiels':
      'Los tratamientos esenciales',
  'À base de cuivre, elle prévient mildiou et cloque du pêcher. Applique en préventif, jamais sur des fruits proches de la récolte.':
      'A base de cobre, previene el mildiu y la abolladura del melocotonero. Aplícalo de forma preventiva, nunca sobre frutos cercanos a la cosecha.',
  'Soufre':
      'Azufre',
  'Le soufre mouillable combat l\'oïdium et la tavelure. Pulvérise dès les premiers signes, par temps sec et pas trop chaud.':
      'El azufre mojable combate el oídio y el moteado. Pulveriza desde las primeras señales, con tiempo seco y sin demasiado calor.',
  'Insecticide de contact contre pucerons, cochenilles et aleurodes. 3 cuillères à soupe par litre d\'eau tiède suffisent.':
      'Insecticida de contacto contra pulgones, cochinillas y moscas blancas. Bastan 3 cucharadas soperas por litro de agua tibia.',
  'Bacille de Thuringe':
      'Bacillus thuringiensis',
  'Cette bactérie (Bt) est fatale aux chenilles sans nuire aux autres insectes. Idéal contre la piéride du chou.':
      'Esta bacteria (Bt) es fatal para las orugas sin dañar a los demás insectos. Ideal contra la mariposa blanca de la col.',
  'Huile de neem':
      'Aceite de neem',
  'Extraite du margousier, elle agit comme répulsif et perturbateur de croissance sur de nombreux ravageurs.':
      'Extraído del nim, actúa como repelente y alterador del crecimiento en numerosas plagas.',
  'Les purins et décoctions':
      'Los purines y las decocciones',
  'Stimulant et répulsif. Dilué à 5% en pulvérisation foliaire, à 10% en arrosage au pied. Fermentation 10-15 jours.':
      'Estimulante y repelente. Diluido al 5% en pulverización foliar, al 10% en riego al pie. Fermentación de 10-15 días.',
  'Décoction de prêle':
      'Decocción de cola de caballo',
  'Riche en silice, elle renforce les parois cellulaires des plantes et les protège contre les maladies fongiques.':
      'Rica en sílice, refuerza las paredes celulares de las plantas y las protege contra las enfermedades fúngicas.',
  'Purin de consoude':
      'Purín de consuelda',
  'Riche en potasse, il booste la floraison et la fructification. Dilué à 10% en arrosage au pied des plants.':
      'Rico en potasa, impulsa la floración y la fructificación. Diluido al 10% en riego al pie de las plantas.',
  'Infusion d\'ail':
      'Infusión de ajo',
  'Fais bouillir 5 gousses écrasées dans 1 litre d\'eau. Filtre et pulvérise contre pucerons et maladies fongiques.':
      'Hierve 5 dientes machacados en 1 litro de agua. Filtra y pulveriza contra pulgones y enfermedades fúngicas.',
  'Les règles d\'application':
      'Las reglas de aplicación',
  'Toujours le soir':
      'Siempre por la tarde',
  'Pulvérise en fin de journée pour éviter les brûlures au soleil et laisser le produit agir pendant la nuit.':
      'Pulveriza al final del día para evitar quemaduras por el sol y dejar que el producto actúe durante la noche.',
  'Pas avant la pluie':
      'No antes de la lluvia',
  'Vérifie la météo avant de traiter. La pluie lessive les produits et rend le traitement inutile.':
      'Comprueba el tiempo antes de tratar. La lluvia lava los productos y deja el tratamiento inservible.',
  'Respecte les doses':
      'Respeta las dosis',
  'Bio ne veut pas dire inoffensif. Un excès de cuivre pollue le sol. Suis toujours les dosages recommandés.':
      'Ecológico no significa inofensivo. Un exceso de cobre contamina el suelo. Sigue siempre las dosis recomendadas.',
  'Pulvérise dessous ET dessus':
      'Pulveriza por debajo Y por encima',
  'Les ravageurs et les spores se cachent sous les feuilles. Traite les deux faces pour une efficacité maximale.':
      'Las plagas y las esporas se esconden bajo las hojas. Trata las dos caras para lograr la máxima eficacia.',
  'Le meilleur traitement, c\'est la prévention. Un sol vivant, des plantes bien espacées et des associations intelligentes évitent la plupart des problèmes.':
      'El mejor tratamiento es la prevención. Un suelo vivo, plantas bien separadas y asociaciones inteligentes evitan la mayoría de los problemas.',
  'Mélanger les produits :':
      'Mezclar productos:',
  'ne combine jamais bouillie bordelaise et soufre, ou deux traitements différents le même jour.':
      'no combines nunca caldo bordelés y azufre, ni dos tratamientos distintos el mismo día.',
  'Traiter en plein soleil :':
      'Tratar a pleno sol:',
  'les produits brûlent les feuilles sous l\'effet de la chaleur et des UV.':
      'los productos queman las hojas por efecto del calor y de los rayos UV.',
  'Surdoser :':
      'Pasarse con la dosis:',
  'doubler la dose ne double pas l\'efficacité. Le cuivre en excès stérilise le sol durablement.':
      'doblar la dosis no duplica la eficacia. El cobre en exceso esteriliza el suelo de forma duradera.',
  'Traiter systématiquement :':
      'Tratar sistemáticamente:',
  'ne traite que si nécessaire. Un jardin sain avec des auxiliaires se défend souvent seul.':
      'trata solo si es necesario. Un jardín sano con auxiliares suele defenderse solo.',
};
