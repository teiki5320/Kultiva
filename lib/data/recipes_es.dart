import 'recipes_i18n.dart';

/// Les recettes du catalogue, en espagnol.
///
/// Clé = `légume/nom français`, celle de `recipeTextKey()` — le nom
/// **français** sert de clé même ici : il ne change pas quand on
/// traduit. Une clé absente retombe sur le français, et un champ vide
/// aussi.
///
/// Castillan d'Espagne, tutoiement, comme `names_es.dart`. Les noms de
/// plats ouest-africains (Mafé, Thiéboudienne, Kedjenou…) restent tels
/// quels : ils n'ont pas d'équivalent espagnol.
///
/// ⚠️ **Les nombres ne se traduisent pas** — voir `recipes_en.dart`.
/// `test/recipes_i18n_test.dart` le vérifie sur chaque langue.
///
/// **Lot 1 sur 7** (20 légumes, 120 recettes). Les six autres se
/// génèrent avec `dart run tool/exporter_recettes.dart --squelette
/// --langue=es --lot=N`.
const Map<String, RecipeText> recipeTextsEs = <String, RecipeText>{
  // ─────────── abricotier (6 recettes) ───────────
  'abricotier/Oreillons d\'abricots au sirop': RecipeText(
    // FR: Oreillons d'abricots au sirop
    name: 'Mitades de albaricoque en almíbar',
    // FR: Le classique des placards de grand-mère : une tarte aux abricots possible même en février.
    description: 'El clásico de la despensa de la abuela: una tarta de albaricoque posible incluso en febrero.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '2 kg de albaricoques maduros pero firmes', // FR: 2 kg d'abricots mûrs mais fermes
      '1 litro de agua', // FR: 1 litre d'eau
      '300 g de azúcar', // FR: 300 g de sucre
      '5 tarros de 50 cl con juntas nuevas', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les abricots et écarte ceux qui sont tachés ou trop mous.
      'Lava los albaricoques y aparta los que tengan manchas o estén demasiado blandos.',
      // FR: Ouvre-les en deux à la main en suivant le sillon et retire le noyau.
      'Ábrelos por la mitad con la mano siguiendo la hendidura y quita el hueso.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes pour faire le sirop.
      'Lleva el agua y el azúcar a ebullición durante 2 minutos para hacer el almíbar.',
      // FR: Range les oreillons **bombé vers le haut**, bien serrés, couvre de sirop chaud jusqu'à 2 cm du bord et ferme avec des joints neufs.
      'Coloca las mitades **con la parte abombada hacia arriba**, bien apretadas, cúbrelas con almíbar caliente hasta 2 cm del borde y cierra con juntas nuevas.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Esteriliza los tarros cubiertos de agua, 25 minutos desde que hierva.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange vite.
      'Deja enfriar en el agua y comprueba el vacío. Un tarro que no haya hecho vacío va a la nevera y se come pronto.',
    ],
  ),
  'abricotier/Abricots secs maison': RecipeText(
    // FR: Abricots secs maison
    name: 'Orejones caseros',
    // FR: Plus foncés que ceux du commerce car sans soufre, mais avec un vrai goût d'abricot.
    description: 'Más oscuros que los del súper porque no llevan azufre, pero con un auténtico sabor a albaricoque.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de albaricoques muy maduros', // FR: 2 kg d'abricots bien mûrs
      '1 litro de agua fría', // FR: 1 litre d'eau froide
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Ouvre les abricots en deux, retire le noyau, puis retourne chaque moitié comme un gant pour l'aplatir.
      'Abre los albaricoques por la mitad, quita el hueso y dale la vuelta a cada mitad como un guante para aplanarla.',
      // FR: Trempe-les 5 minutes dans l'eau citronnée : ils foncent moins au séchage.
      'Déjalos 5 minutos en el agua con limón: se oscurecen menos al secarse.',
      // FR: Égoutte-les et éponge-les sur un torchon.
      'Escúrrelos y sécalos con un paño.',
      // FR: Pose-les peau en dessous sur des grilles et sèche au four à **60 °C**, porte entrouverte.
      'Colócalos con la piel hacia abajo sobre rejillas y sécalos en el horno a **60 °C**, con la puerta entreabierta.',
      // FR: Teste : l'abricot est souple, un peu collant, et ne laisse aucun jus quand tu le plies.
      'Compruébalo: el albaricoque está blando, un poco pegajoso, y no suelta nada de jugo cuando lo doblas.',
      // FR: Laisse refroidir, mets en bocal et secoue chaque jour une semaine. De la buée, et c'est retour au four.
      'Deja enfriar, pásalos a un tarro y agítalo cada día durante una semana. Si ves vaho, vuelven al horno.',
    ],
  ),
  'abricotier/Oreillons d\'abricots congelés': RecipeText(
    // FR: Oreillons d'abricots congelés
    name: 'Mitades de albaricoque congeladas',
    // FR: Dix minutes pour ouvrir, dénoyauter, poser sur plaque : la récolte de trop est sauvée.
    description: 'Diez minutos para abrir, deshuesar y poner en la bandeja: la cosecha de más queda salvada.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de albaricoques maduros pero firmes', // FR: 2 kg d'abricots mûrs mais fermes
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les abricots et sèche-les bien sur un torchon.
      'Lava los albaricoques y sécalos bien con un paño.',
      // FR: Ouvre-les en deux en suivant le sillon et retire le noyau.
      'Ábrelos por la mitad siguiendo la hendidura y quita el hueso.',
      // FR: Pose les oreillons côté coupé vers le haut sur une plaque, **sans qu'ils se touchent**, et congèle 3 heures.
      'Coloca las mitades con el lado cortado hacia arriba sobre una bandeja, **sin que se toquen**, y congela 3 horas.',
      // FR: Verse-les en sac une fois durs. Ils vont encore congelés sur une pâte à tarte ou dans une compote.
      'Pásalas a una bolsa cuando estén duras. Van directamente congeladas sobre una masa de tarta o a una compota.',
    ],
  ),
  'abricotier/Confiture d\'abricots': RecipeText(
    // FR: Confiture d'abricots
    name: 'Mermelada de albaricoque',
    // FR: Quelques amandons cassés dedans : c'est ce qui fait la différence.
    description: 'Unas cuantas almendras de los huesos, partidas, dentro: eso marca la diferencia.',
  ),
  'abricotier/Tarte aux abricots': RecipeText(
    // FR: Tarte aux abricots
    name: 'Tarta de albaricoque',
    // FR: Leur acidité tient tête à la pâte sucrée.
    description: 'Su acidez le planta cara a la masa dulce.',
  ),
  'abricotier/Abricots rôtis au romarin': RecipeText(
    // FR: Abricots rôtis au romarin
    name: 'Albaricoques asados con romero',
    // FR: Salé-sucré, en accompagnement ou en dessert.
    description: 'Entre dulce y salado, de guarnición o de postre.',
  ),

  // ─────────── ail (6 recettes) ───────────
  'ail/Tresses d\'ail séchées': RecipeText(
    // FR: Tresses d'ail séchées
    name: 'Trenzas de ajo secas',
    // FR: Bien séché après l'arrachage, l'ail se garde jusqu'au printemps suspendu dans un coin frais et sec.
    description: 'Bien seco tras la cosecha, el ajo aguanta hasta la primavera colgado en un rincón fresco y seco.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 meses en seco, protegido de la luz',
    ingredients: <String>[
      '30 cabezas de ajo recién arrancadas, con sus tallos', // FR: 30 têtes d'ail fraîchement arrachées, avec leurs fanes
      'cordel de cocina', // FR: de la ficelle de cuisine
    ],
    steps: <String>[
      // FR: Arrache l'ail par temps sec, quand les deux tiers des feuilles ont jauni. Brosse la terre à la main, **sans laver**.
      'Arranca el ajo en tiempo seco, cuando dos tercios de las hojas se han puesto amarillas. Quita la tierra con la mano, **sin lavar**.',
      // FR: Laisse-le sécher 2 à 3 semaines à l'ombre, dans un endroit aéré : un abri, un grenier, pas en plein soleil.
      'Déjalo secar 2 o 3 semanas a la sombra, en un lugar ventilado: un cobertizo, un desván, nunca a pleno sol.',
      // FR: Coupe les racines au ras du bulbe et retire la première peau terreuse.
      'Corta las raíces a ras del bulbo y quita la primera piel terrosa.',
      // FR: Tresse les fanes encore un peu souples par trois, en ajoutant une tête à chaque passage, et noue avec la ficelle.
      'Trenza los tallos, todavía algo flexibles, de tres en tres, añadiendo una cabeza en cada pasada, y ata con el cordel.',
      // FR: Suspends la tresse au frais et au sec, entre 10 et 15 °C idéalement. Écarte vite une tête molle ou qui germe.
      'Cuelga la trenza en un sitio fresco y seco, idealmente entre 10 y 15 °C. Aparta enseguida cualquier cabeza blanda o que brote.',
    ],
  ),
  'ail/Gousses d\'ail congelées': RecipeText(
    // FR: Gousses d'ail congelées
    name: 'Dientes de ajo congelados',
    // FR: Pour les têtes abîmées qui ne tiendront pas l'hiver : épluchées et congelées, elles se râpent encore gelées.
    description: 'Para las cabezas estropeadas que no aguantarían el invierno: pelados y congelados, se rallan aún helados.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '5 cabezas de ajo', // FR: 5 têtes d'ail
      'un tarro o un recipiente pequeño de congelación', // FR: un bocal ou une petite boîte de congélation
    ],
    steps: <String>[
      // FR: Sépare les gousses et écarte celles qui sont tachées ou molles.
      'Separa los dientes y aparta los que estén manchados o blandos.',
      // FR: Fais-les tremper 10 minutes dans l'eau tiède : la peau se décolle toute seule.
      'Déjalos en remojo 10 minutos en agua tibia: la piel se despega sola.',
      // FR: Épluche-les et coupe le petit talon dur. Sèche-les bien dans un torchon.
      'Pélalos y corta el piquito duro. Sécalos bien con un paño.',
      // FR: Mets-les entières dans un bocal bien fermé : l'odeur d'ail passe sinon à tout le congélateur.
      'Ponlos enteros en un tarro bien cerrado: si no, el olor a ajo se pasa a todo el congelador.',
      // FR: À l'usage, râpe-les ou hache-les **encore gelées**. Décongelées, elles deviennent molles et collent au couteau.
      'Al usarlos, rállalos o pícalos **todavía congelados**. Descongelados se ablandan y se pegan al cuchillo.',
    ],
  ),
  'ail/Gousses d\'ail au vinaigre': RecipeText(
    // FR: Gousses d'ail au vinaigre
    name: 'Dientes de ajo en vinagre',
    // FR: Adoucies par le vinaigre, elles se croquent à l'apéritif ou se hachent dans une vinaigrette.
    description: 'Suavizados por el vinagre, se comen crujientes en el aperitivo o se pican en una vinagreta.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '400 g de dientes de ajo pelados', // FR: 400 g de gousses d'ail épluchées
      '50 cl de vinagre blanco al 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '1 cucharada de azúcar', // FR: 1 cuillère à soupe de sucre
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Épluche les gousses (10 minutes de trempage à l'eau tiède aident beaucoup) et coupe les talons.
      'Pela los dientes (10 minutos en agua tibia ayudan mucho) y corta los piquitos.',
      // FR: Blanchis-les **1 minute** dans l'eau bouillante pour adoucir leur piquant.
      'Escáldalos **1 minuto** en agua hirviendo para suavizar su picor.',
      // FR: Égoutte-les et passe-les sous l'eau froide, puis tasse-les dans des bocaux propres avec le poivre.
      'Escúrrelos y pásalos por agua fría, luego apriétalos en tarros limpios con la pimienta.',
      // FR: Porte le vinaigre pur à ébullition avec le sucre et le sel.
      'Lleva a ebullición el vinagre puro con el azúcar y la sal.',
      // FR: Verse sur l'ail pour le **couvrir entièrement**, ferme et laisse refroidir, puis réfrigérateur.
      'Viértelo sobre el ajo hasta **cubrirlo del todo**, cierra, deja enfriar y a la nevera.',
      // FR: Attends 3 semaines avant de goûter. Si des gousses bleuissent, c'est une réaction naturelle de l'ail à l'acide, sans danger.
      'Espera 3 semanas antes de probarlo. Si algún diente se pone azul, es una reacción natural del ajo al ácido y no es peligroso.',
    ],
  ),
  'ail/Soupe à l\'ail': RecipeText(
    // FR: Soupe à l'ail
    name: 'Sopa de ajo',
    // FR: Douce et réconfortante — l'ail cuit perd toute sa morsure.
    description: 'Suave y reconfortante: el ajo cocido pierde todo su picante.',
    ingredients: <String>[
      '2 cabezas de ajo', // FR: 2 têtes d'ail
      '1 litro de caldo', // FR: 1 litre de bouillon
      '2 yemas de huevo', // FR: 2 jaunes d'oeufs
      '4 rebanadas de pan', // FR: 4 tranches de pain
      'aceite de oliva, tomillo, laurel, sal', // FR: huile d'olive, thym, laurier, sel
    ],
    steps: <String>[
      // FR: Pèle les gousses et écrase-les à peine sous la lame.
      'Pela los dientes y aplástalos apenas con la hoja del cuchillo.',
      // FR: Fais-les blondir doucement à l'huile, sans les brunir : brûlé, l'ail devient amer.
      'Dóralos despacio en el aceite, sin que se oscurezcan: quemado, el ajo amarga.',
      // FR: Ajoute le bouillon, thym, laurier, et laisse frémir 20 minutes.
      'Añade el caldo, el tomillo y el laurel, y deja que hierva suave 20 minutos.',
      // FR: Hors du feu, délaye les jaunes avec une louche de bouillon, puis reverse en fouettant.
      'Fuera del fuego, desliza las yemas con un cucharón de caldo y vuélcalo todo de nuevo removiendo con varillas.',
      // FR: Sers sur du pain grillé frotté d'ail.
      'Sirve sobre pan tostado frotado con ajo.',
    ],
  ),
  'ail/Aïoli': RecipeText(
    // FR: Aïoli
    name: 'Alioli',
    // FR: Ail pilé, jaune d'œuf, huile d'olive en filet. Du muscle.
    description: 'Ajo machacado, yema de huevo, aceite de oliva a hilo. Con carácter.',
    ingredients: <String>[
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '1 yema de huevo', // FR: 1 jaune d'oeuf
      '20 cl de aceite de oliva', // FR: 20 cl d'huile d'olive
      '1/2 limón, sal', // FR: 1/2 citron, sel
    ],
    steps: <String>[
      // FR: Pile l'ail avec du gros sel au mortier, jusqu'à une crème.
      'Machaca el ajo con sal gorda en el mortero hasta obtener una crema.',
      // FR: Ajoute le jaune, à température ambiante — froid, l'émulsion rate.
      'Añade la yema, a temperatura ambiente: fría, la emulsión se corta.',
      // FR: Verse l'huile **goutte à goutte** en tournant toujours dans le même sens.
      'Echa el aceite **gota a gota** removiendo siempre en el mismo sentido.',
      // FR: Quand ça monte, tu peux accélérer. Si ça tranche : repars d'un jaune neuf et reverse l'aïoli raté dessus.
      'Cuando empiece a espesar, puedes ir más deprisa. Si se corta: empieza con una yema nueva y vierte encima el alioli cortado.',
      // FR: Citron et sel pour finir.
      'Para terminar, limón y sal.',
    ],
  ),
  'ail/Ail confit à l\'huile': RecipeText(
    // FR: Ail confit à l'huile
    name: 'Ajo confitado en aceite',
    // FR: Des gousses entières fondues à feu très doux, à tartiner.
    description: 'Dientes enteros derretidos a fuego muy suave, para untar.',
    ingredients: <String>[
      '4 cabezas de ajo', // FR: 4 têtes d'ail
      '25 cl de aceite de oliva', // FR: 25 cl d'huile d'olive
      'tomillo, laurel', // FR: thym, laurier
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Sépare les gousses, pèle-les sans les abîmer.
      'Separa los dientes y pélalos sin estropearlos.',
      // FR: Couvre-les d'huile dans une petite casserole, avec les herbes.
      'Cúbrelos con aceite en un cazo pequeño, con las hierbas.',
      // FR: Feu **très** doux 40 minutes : l'huile doit à peine frémir. Si elle bout, l'ail frit au lieu de confire.
      'Fuego **muy** suave 40 minutos: el aceite debe apenas temblar. Si hierve, el ajo se fríe en vez de confitarse.',
      // FR: En bocal avec son huile, au frais, deux semaines. L'huile parfumée se garde pour les salades.
      'En un tarro con su aceite, en la nevera, dos semanas. El aceite aromatizado se guarda para las ensaladas.',
    ],
  ),

  // ─────────── amarante (6 recettes) ───────────
  'amarante/Amarante blanchie au congélateur': RecipeText(
    // FR: Amarante blanchie au congélateur
    name: 'Amaranto escaldado para congelar',
    // FR: Une minute de blanchiment, et les feuilles tendres d'amarante passent l'hiver bien vertes.
    description: 'Un minuto de escaldado y las hojas tiernas de amaranto pasan el invierno bien verdes.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas de amaranto', // FR: 1 kg de feuilles d'amarante
      'sal gorda', // FR: gros sel
      '1 ensaladera grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et garde les pointes tendres avec les feuilles.
      'Deshoja los tallos y guarda las puntas tiernas junto con las hojas.',
      // FR: Lave dans plusieurs eaux, la terre colle sous les feuilles.
      'Lava en varias aguas: la tierra se pega bajo las hojas.',
      // FR: Plonge dans une grande eau bouillante salée, à gros bouillons.
      'Sumérgelas en una olla grande de agua salada hirviendo a borbotones.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée : le choc fixe le vert.
      'Escúrrelas y mételas enseguida en agua helada: el choque fija el verde.',
      // FR: Presse en boule entre tes mains pour chasser toute l'eau.
      'Aprieta en bola entre las manos para sacar toda el agua.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque puis mets-les en sac.
      'Forma bolitas del tamaño de una ración, congélalas 2 horas en una bandeja y pásalas a una bolsa.',
    ],
  ),
  'amarante/Pesto d\'amarante en glaçons': RecipeText(
    // FR: Pesto d'amarante en glaçons
    name: 'Pesto de amaranto en cubitos',
    // FR: Un quart d'heure et des cubes verts à jeter dans les pâtes ou le riz tout l'hiver.
    description: 'Un cuarto de hora y tendrás cubos verdes para echar a la pasta o al arroz todo el invierno.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '300 g de hojas de amaranto', // FR: 300 g de feuilles d'amarante
      '60 g de cacahuetes tostados', // FR: 60 g d'arachides grillées
      '1 diente de ajo', // FR: 1 gousse d'ail
      '15 cl de aceite', // FR: 15 cl d'huile
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles et **sèche-les bien** : de l'eau dans le pesto le fait tourner.
      'Lava las hojas y **sécalas bien**: el agua en el pesto hace que se corte.',
      // FR: Mixe les feuilles, l'ail et les arachides par à-coups, pour ne pas chauffer les feuilles.
      'Tritura las hojas, el ajo y los cacahuetes a golpes cortos, para que las hojas no se calienten.',
      // FR: Verse l'huile en filet en mixant, puis sale.
      'Añade el aceite a hilo mientras trituras y salpimienta con la sal.',
      // FR: Remplis un bac à glaçons, un cube par portion, et couvre chaque cube d'un filet d'huile.
      'Llena una cubitera, un cubito por ración, y cubre cada cubito con un chorrito de aceite.',
      // FR: Démoule une fois durs et garde-les en sac. Un cube fond directement dans un plat chaud.
      'Desmolda cuando estén duros y guárdalos en una bolsa. Un cubito se derrite directamente en un plato caliente.',
    ],
  ),
  'amarante/Graines d\'amarante battues': RecipeText(
    // FR: Graines d'amarante battues
    name: 'Semillas de amaranto trilladas',
    // FR: Laisse quelques pieds monter en graines : battues et séchées, elles se gardent un an et se cuisent comme une céréale.
    description: 'Deja que algunas plantas suban a semilla: trilladas y secas, duran un año y se cocinan como un cereal.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, protegidas de los insectos',
    ingredients: <String>[
      'las panículas de amaranto maduras', // FR: les panicules d'amarante mûres
      'una sábana o una bolsa de papel grande', // FR: un drap ou un grand sac en papier
      'un tamiz fino', // FR: un tamis fin
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les panicules quand les graines tombent si tu secoues la tige au-dessus de ta main.
      'Corta las panículas cuando las semillas caigan al sacudir el tallo sobre tu mano.',
      // FR: Suspends-les tête en bas dans un grand sac en papier, dans un endroit sec et aéré, une semaine.
      'Cuélgalas boca abajo dentro de una bolsa de papel grande, en un lugar seco y ventilado, durante una semana.',
      // FR: Frotte les panicules entre tes mains au-dessus du drap pour faire tomber les graines.
      'Frota las panículas entre las manos sobre la sábana para que caigan las semillas.',
      // FR: Passe au tamis puis souffle doucement par-dessus pour enlever les débris légers.
      'Pásalas por el tamiz y sopla suavemente por encima para quitar los restos ligeros.',
      // FR: Étale les graines et finis de les sécher 1 heure au four à 40 °C, porte entrouverte.
      'Extiende las semillas y termina de secarlas 1 hora en el horno a 40 °C, con la puerta entreabierta.',
      // FR: Mets-les en bocaux hermétiques au frais et au sec. Elles se cuisent toujours avant de se manger, 20 minutes dans l'eau.
      'Guárdalas en tarros herméticos, en un sitio fresco y seco. Se cocinan siempre antes de comerlas, 20 minutos en agua.',
    ],
  ),
  'amarante/Amarante sautée à l\'ail': RecipeText(
    // FR: Amarante sautée à l'ail
    name: 'Amaranto salteado con ajo',
    // FR: Comme des épinards, mais avec plus de tenue.
    description: 'Como las espinacas, pero con más cuerpo.',
  ),
  'amarante/Efo riro': RecipeText(
    // FR: Efo riro
    name: 'Efo riro',
    // FR: Le ragoût de feuilles yoruba, riche et parfumé, où l'amarante fait merveille.
    description: 'El guiso de hojas yoruba, rico y aromático, donde el amaranto se luce.',
  ),
  'amarante/Sauce feuilles d\'amarante': RecipeText(
    // FR: Sauce feuilles d'amarante
    name: 'Salsa de hojas de amaranto',
    // FR: Une sauce verte toute simple qui sublime le riz ou le tô du jour.
    description: 'Una salsa verde muy sencilla que realza el arroz o el tô del día.',
  ),

  // ─────────── aneth (6 recettes) ───────────
  'aneth/Brins d\'aneth au congélateur': RecipeText(
    // FR: Brins d'aneth au congélateur
    name: 'Ramitas de eneldo en el congelador',
    // FR: Congelé en brins, l'aneth garde tout son parfum anisé, bien mieux que séché.
    description: 'Congelado en ramitas, el eneldo conserva todo su aroma anisado, mucho mejor que seco.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '3 manojos de eneldo', // FR: 3 bouquets d'aneth
      'bolsas de congelación con cierre zip', // FR: des sacs de congélation à zip
    ],
    steps: <String>[
      // FR: Rince l'aneth à l'eau froide, sans le laisser tremper.
      'Enjuaga el eneldo con agua fría, sin dejarlo en remojo.',
      // FR: Étale-le sur un torchon et tamponne : il doit être **parfaitement sec**.
      'Extiéndelo sobre un paño y sécalo a toquecitos: tiene que quedar **perfectamente seco**.',
      // FR: Détache les plumets fins des grosses tiges, qui restent dures. Garde les tiges pour un court-bouillon.
      'Separa las hojitas finas de los tallos gruesos, que quedan duros. Guarda los tallos para un caldo corto.',
      // FR: Mets les plumets à plat dans un sac, chasse l'air et ferme. Pose le sac à plat dans le congélateur.
      'Pon las hojitas en una bolsa, planas, saca el aire y cierra. Deja la bolsa plana en el congelador.',
      // FR: Une fois gelé, émiette directement à travers le sac : l'aneth se casse en miettes prêtes à l'emploi.
      'Una vez congelado, desmenúzalo directamente a través de la bolsa: el eneldo se rompe en migas listas para usar.',
    ],
  ),
  'aneth/Concombres lacto-fermentés à l\'aneth': RecipeText(
    // FR: Concombres lacto-fermentés à l'aneth
    name: 'Pepinillos lactofermentados con eneldo',
    // FR: La saumure à l'aneth et à l'ail, et tes petits concombres deviennent des malossols acidulés.
    description: 'Salmuera con eneldo y ajo, y tus pepinillos se convierten en encurtidos ácidos, tipo malosol.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '1 kg de pepinillos pequeños y firmes', // FR: 1 kg de petits concombres fermes
      '1 litro de agua sin cloro y 30 g de sal', // FR: 1 litre d'eau non chlorée et 30 g de sel
      '4 umbelas de eneldo con algunas ramitas', // FR: 4 ombelles d'aneth avec quelques plumets
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '3 hojas de parra o de roble', // FR: 3 feuilles de vigne ou de chêne
      'dos tarros de 1 litro y un peso', // FR: deux bocaux de 1 litre et un poids
    ],
    steps: <String>[
      // FR: Lave les concombres en frottant et coupe le bout de la fleur : il contient une enzyme qui les ramollit.
      'Lava los pepinillos frotándolos y corta el extremo de la flor: contiene una enzima que los ablanda.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau**, sans chauffer.
      'Disuelve **30 g de sal en 1 litro de agua**, sin calentar.',
      // FR: Mets au fond des bocaux l'aneth, l'ail écrasé et les feuilles de vigne : leur tanin garde le croquant.
      'Pon en el fondo de los tarros el eneldo, el ajo aplastado y las hojas de parra: su tanino conserva lo crujiente.',
      // FR: Range les concombres debout, bien serrés, jusqu'à 3 cm du bord.
      'Coloca los pepinillos de pie, bien apretados, hasta 3 cm del borde.',
      // FR: Verse la saumure et pose un poids : tout doit rester **sous le liquide**, sinon ça moisit.
      'Vierte la salmuera y pon un peso: todo debe quedar **bajo el líquido**, si no, se enmohece.',
      // FR: Laisse fermenter à 18–22 °C, couvercle posé sans serrer. Une semaine à dix jours, la saumure se trouble et pétille : c'est normal.
      'Deja fermentar a 18–22 °C, con la tapa puesta sin apretar. De una semana a diez días la salmuera se enturbia y burbujea: es normal.',
      // FR: Goûte : dès qu'ils sont acidulés à cœur, ferme et range-les au réfrigérateur pour arrêter la fermentation.
      'Prueba: en cuanto estén ácidos por dentro, cierra y guárdalos en la nevera para detener la fermentación.',
    ],
  ),
  'aneth/Ombelles d\'aneth séchées': RecipeText(
    // FR: Ombelles d'aneth séchées
    name: 'Umbelas de eneldo secas',
    // FR: Les fleurs et les graines sèchent très bien et parfument les saumures et le pain toute l'année.
    description: 'Las flores y las semillas se secan muy bien y perfuman las salmueras y el pan todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      'unas quince umbelas de eneldo con semillas', // FR: une quinzaine d'ombelles d'aneth en graines
      'una bolsa de papel grande', // FR: un grand sac en papier
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les ombelles avec 20 cm de tige quand les graines sont formées et commencent à brunir.
      'Corta las umbelas con 20 cm de tallo cuando las semillas ya están formadas y empiezan a dorarse.',
      // FR: Suspends-les tête en bas dans un sac en papier, à l'abri et au sec, deux semaines.
      'Cuélgalas boca abajo dentro de una bolsa de papel, al abrigo y en seco, dos semanas.',
      // FR: Elles sont prêtes quand les graines se détachent d'une pichenette.
      'Están listas cuando las semillas se sueltan de un capirotazo.',
      // FR: Garde quelques ombelles entières pour tes bocaux de cornichons, égrène les autres.
      'Guarda algunas umbelas enteras para tus tarros de pepinillos y desgrana el resto.',
      // FR: Passe les graines au tamis pour ôter les bouts de tige, puis mets-les en bocal **bien sec**.
      'Pasa las semillas por el tamiz para quitar los trozos de tallo y ponlas en un tarro **bien seco**.',
    ],
  ),
  'aneth/Saumon gravlax': RecipeText(
    // FR: Saumon gravlax
    name: 'Salmón gravlax',
    // FR: Sel, sucre, beaucoup d'aneth, deux jours au frais.
    description: 'Sal, azúcar, mucho eneldo, dos días en frío.',
  ),
  'aneth/Sauce yaourt-aneth': RecipeText(
    // FR: Sauce yaourt-aneth
    name: 'Salsa de yogur y eneldo',
    // FR: Avec du concombre râpé, pour un tzatziki du Nord.
    description: 'Con pepino rallado, para un tzatziki del norte.',
  ),
  'aneth/Pommes de terre à l\'aneth': RecipeText(
    // FR: Pommes de terre à l'aneth
    name: 'Patatas con eneldo',
    // FR: Nouvelles, à l'eau, beurre et aneth haché.
    description: 'Nuevas, cocidas en agua, con mantequilla y eneldo picado.',
  ),

  // ─────────── arachide (6 recettes) ───────────
  'arachide/Arachides séchées en coque': RecipeText(
    // FR: Arachides séchées en coque
    name: 'Cacahuetes secos con cáscara',
    // FR: Bien séchées et gardées dans leur coque, elles se conservent jusqu'à la prochaine récolte.
    description: 'Bien secos y guardados en su cáscara, se conservan hasta la próxima cosecha.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, protegidos de los insectos',
    ingredients: <String>[
      'las plantas de cacahuete arrancadas en tiempo seco', // FR: les plants d'arachide arrachés par temps sec
      'rejillas o una sábana limpia', // FR: des claies ou un drap propre
      'sacos de tela o de yute', // FR: des sacs en toile ou en jute
    ],
    steps: <String>[
      // FR: Arrache les pieds quand le feuillage jaunit et que l'intérieur des coques a des veines brunes. Secoue la terre.
      'Arranca las plantas cuando el follaje amarillea y el interior de las vainas tiene vetas marrones. Sacude la tierra.',
      // FR: Laisse les plants **retournés**, gousses vers le ciel, 3 à 4 jours au soleil sur le champ ou sur un drap.
      'Deja las plantas **boca abajo**, con las vainas hacia el cielo, de 3 a 4 días al sol en el campo o sobre una sábana.',
      // FR: Détache les gousses et étale-les en couche mince sur des claies, à l'ombre et dans un endroit aéré.
      'Separa las vainas y extiéndelas en una capa fina sobre rejillas, a la sombra y en un lugar ventilado.',
      // FR: Laisse sécher 1 à 2 semaines en remuant tous les deux jours. Rentre-les dès qu'il pleut.
      'Déjalas secar de 1 a 2 semanas, removiéndolas cada dos días. Recógelas en cuanto llueva.',
      // FR: Teste : la coque est cassante, la graine croque et sa peau rouge s'enlève toute seule.
      'Prueba: la cáscara es quebradiza, la semilla cruje y su piel roja se quita sola.',
      // FR: Trie une à une. **Jette toute graine moisie, noircie ou amère** : ces moisissures ne se rattrapent pas.
      'Revisa una por una. **Tira toda semilla mohosa, ennegrecida o amarga**: ese moho no tiene arreglo.',
      // FR: Garde-les en coque dans des sacs en toile suspendus, au sec et au frais. Décortique au fur et à mesure.
      'Guárdalos con cáscara en sacos de tela colgados, en un lugar seco y fresco. Pélalos a medida que los uses.',
    ],
  ),
  'arachide/Arachides fraîches bouillies au sel': RecipeText(
    // FR: Arachides fraîches bouillies au sel
    name: 'Cacahuetes frescos hervidos con sal',
    // FR: Le goût du bord de route : les arachides fraîches cuites dans leur coque, à sortir du congélateur pour le goûter.
    description: 'El sabor de los puestos de carretera: cacahuetes frescos cocidos en su cáscara, para sacar del congelador a la hora de la merienda.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de cacahuetes frescos con cáscara, recién arrancados', // FR: 1 kg d'arachides fraîches en coque, juste arrachées
      '3 litros de agua', // FR: 3 litres d'eau
      '60 g de sal gorda', // FR: 60 g de gros sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les coques dans plusieurs eaux en les frottant : la terre reste coincée dans les creux.
      'Lava las vainas en varias aguas, frotándolas: la tierra se queda atrapada en los huecos.',
      // FR: Mets-les dans une grande marmite avec l'eau et le sel, en les tenant sous l'eau avec une assiette.
      'Ponlas en una olla grande con el agua y la sal, manteniéndolas sumergidas con un plato.',
      // FR: Fais bouillir à couvert jusqu'à ce que la graine soit tendre comme un haricot cuit.
      'Hierve con tapa hasta que la semilla esté tierna como una alubia cocida.',
      // FR: Coupe le feu et laisse-les tremper dans l'eau salée : c'est là que le sel entre dans la coque.
      'Apaga el fuego y déjalas en remojo en el agua salada: ahí es donde la sal entra en la cáscara.',
      // FR: Égoutte et laisse refroidir complètement, étalées sur un plateau.
      'Escurre y deja enfriar del todo, extendidas sobre una bandeja.',
      // FR: Mets en sacs, chasse l'air, note la date. Réchauffe 5 minutes dans l'eau bouillante au moment de servir.
      'Pásalas a bolsas, saca el aire y anota la fecha. Calienta 5 minutos en agua hirviendo justo antes de servir.',
    ],
  ),
  'arachide/Arachides décortiquées au congélateur': RecipeText(
    // FR: Arachides décortiquées au congélateur
    name: 'Cacahuetes pelados en el congelador',
    // FR: Au froid, elles ne rancissent pas et les charançons n'ont aucune chance : tes cacahuètes restent comme au premier jour.
    description: 'Con el frío no se ponen rancios y los gorgojos no tienen ninguna oportunidad: tus cacahuetes quedan como el primer día.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'cacahuetes muy secos, pelados', // FR: des arachides bien sèches, décortiquées
      'bolsas o tarros de congelación', // FR: des sacs ou bocaux de congélation
    ],
    steps: <String>[
      // FR: Décortique les arachides sèches et retire les graines ridées, tachées ou percées.
      'Pela los cacahuetes secos y aparta las semillas arrugadas, manchadas o picadas.',
      // FR: Trie encore à la lumière : **une graine moisie suffit à gâcher un sac**, jette-la sans hésiter.
      'Revísalos otra vez a la luz: **una sola semilla mohosa basta para estropear una bolsa**, tírala sin dudar.',
      // FR: Remplis des sacs en chassant l'air ou des bocaux bien fermés, par portions d'un mafé ou d'une grillade.
      'Llena bolsas sacando el aire, o tarros bien cerrados, en raciones para un mafé o una parrillada.',
      // FR: Congèle à plat. Pas besoin de décongeler : elles se grillent ou se pilent directement.
      'Congela en plano. No hace falta descongelar: se tuestan o se machacan directamente.',
    ],
  ),
  'arachide/Beurre de cacahuète maison': RecipeText(
    // FR: Beurre de cacahuète maison
    name: 'Mantequilla de cacahuete casera',
    // FR: Grillées puis mixées longtemps : elles rendent leur huile seules.
    description: 'Tostados y triturados mucho rato: sueltan su aceite solos.',
  ),
  'arachide/Mafé': RecipeText(
    // FR: Mafé
    name: 'Mafé',
    // FR: Le ragoût à la pâte d'arachide, doux et généreux, servi sur du riz bien chaud.
    description: 'El guiso con pasta de cacahuete, suave y generoso, servido sobre arroz bien caliente.',
  ),
  'arachide/Kulikuli': RecipeText(
    // FR: Kulikuli
    name: 'Kulikuli',
    // FR: Les croquettes d'arachide frites et croustillantes, parfaites pour grignoter.
    description: 'Las croquetas de cacahuete fritas y crujientes, perfectas para picar.',
  ),

  // ─────────── artichaut (6 recettes) ───────────
  'artichaut/Fonds d\'artichauts congelés': RecipeText(
    // FR: Fonds d'artichauts congelés
    name: 'Fondos de alcachofa congelados',
    // FR: Tournés, citronnés et blanchis, les fonds sont prêts pour une poêlée ou une salade quand la récolte est passée.
    description: 'Torneados, con limón y escaldados, los fondos están listos para un salteado o una ensalada cuando ya pasó la cosecha.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '10 alcachofas grandes', // FR: 10 gros artichauts
      '2 limones', // FR: 2 citrons
      'sal gorda', // FR: gros sel
      'un bol grande con agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Remplis un saladier d'eau avec le jus d'un citron : chaque fond y plonge dès qu'il est taillé, sinon il noircit.
      'Llena un bol de agua con el zumo de un limón: cada fondo se sumerge ahí en cuanto lo has tallado, si no, se pone negro.',
      // FR: Casse la queue, retire les feuilles et taille le fond au couteau. Frotte-le aussitôt avec le citron.
      'Parte el rabo, quita las hojas y talla el fondo con el cuchillo. Frótalo enseguida con el limón.',
      // FR: Blanchis les fonds **7 minutes** dans une grande eau salée et citronnée à gros bouillons.
      'Escalda los fondos **7 minutos** en abundante agua salada con limón, a borbotones.',
      // FR: Plonge-les dans l'eau glacée, puis retire le foin à la petite cuillère, il part facilement maintenant.
      'Sumérgelos en agua helada y luego quita la pelusilla con una cucharilla; ahora sale con facilidad.',
      // FR: Égoutte-les à l'envers sur un torchon et sèche-les bien.
      'Escúrrelos boca abajo sobre un paño y sécalos bien.',
      // FR: Congèle-les sur une plaque sans qu'ils se touchent, puis passe-les en sac.
      'Congélalos sobre una bandeja sin que se toquen y luego pásalos a una bolsa.',
    ],
  ),
  'artichaut/Petits violets à l\'huile d\'olive': RecipeText(
    // FR: Petits violets à l'huile d'olive
    name: 'Alcachofas moradas pequeñas en aceite de oliva',
    // FR: Cuits dans un bain vinaigré puis couverts d'huile : l'antipasto italien, à garder au frais.
    description: 'Cocidas en un baño de vinagre y cubiertas de aceite: el antipasto italiano, para guardar en frío.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 semanas en la nevera',
    ingredients: <String>[
      '12 alcachofas moradas pequeñas', // FR: 12 petits artichauts violets
      '50 cl de vinagre blanco al 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '1 cucharada de sal', // FR: 1 cuillère à soupe de sel
      '40 cl de aceite de oliva', // FR: 40 cl d'huile d'olive
      '1 hoja de laurel seca', // FR: 1 feuille de laurier séchée
    ],
    steps: <String>[
      // FR: Retire les feuilles dures jusqu'au cœur tendre, coupe le haut et pèle la tige. Coupe en quatre et retire le foin s'il y en a.
      'Quita las hojas duras hasta llegar al corazón tierno, corta la parte de arriba y pela el tallo. Corta en cuatro y quita la pelusilla si la hay.',
      // FR: Porte l'eau, le vinaigre et le sel à ébullition et cuis les quartiers dedans : c'est ce bain qui **les acidifie**.
      'Lleva a ebullición el agua, el vinagre y la sal y cuece dentro los cuartos: ese baño es lo que **los acidifica**.',
      // FR: Égoutte-les et laisse-les sécher à plat sur un torchon propre, une bonne heure, jusqu'à ce qu'ils ne soient plus humides.
      'Escúrrelos y déjalos secar extendidos sobre un paño limpio, una buena hora, hasta que ya no estén húmedos.',
      // FR: Range-les dans un bocal ébouillanté avec le laurier sec. Pas d'ail cru, pas d'herbes fraîches.
      'Colócalos en un tarro escaldado con el laurel seco. Nada de ajo crudo ni hierbas frescas.',
      // FR: Couvre entièrement d'huile, tapote pour chasser les bulles et ferme.
      'Cúbrelos del todo con aceite, golpea suavemente para sacar las burbujas y cierra.',
      // FR: Range **tout de suite au réfrigérateur**. Sors le bocal une demi-heure avant de servir, l'huile figée redevient liquide.
      'Guárdalo **enseguida en la nevera**. Saca el tarro media hora antes de servir: el aceite solidificado vuelve a ser líquido.',
    ],
  ),
  'artichaut/Cœurs d\'artichauts au vinaigre': RecipeText(
    // FR: Cœurs d'artichauts au vinaigre
    name: 'Corazones de alcachofa en vinagre',
    // FR: Quelques petits artichauts tournés et plongés dans un vinaigre aux aromates : un bocal vite fait pour l'apéritif.
    description: 'Unas cuantas alcachofas pequeñas torneadas y sumergidas en un vinagre aromático: un tarro rápido para el aperitivo.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '6 alcachofas moradas pequeñas', // FR: 6 petits artichauts violets
      '1 limón', // FR: 1 citron
      '25 cl de vinagre de vino blanco al 6 %', // FR: 25 cl de vinaigre de vin blanc à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Taille les petits artichauts jusqu'au cœur tendre, coupe-les en deux et frotte-les au citron.
      'Talla las alcachofas pequeñas hasta el corazón tierno, pártelas por la mitad y frótalas con limón.',
      // FR: Porte l'eau, le vinaigre et le sel à ébullition, plonge les cœurs et laisse cuire.
      'Lleva a ebullición el agua, el vinagre y la sal, echa los corazones y déjalos cocer.',
      // FR: Sors-les à l'écumoire et tasse-les dans un bocal ébouillanté avec le poivre.
      'Sácalos con una espumadera y apriétalos en un tarro escaldado con la pimienta.',
      // FR: Verse le liquide bouillant par-dessus pour **les couvrir entièrement**, ferme et laisse refroidir.
      'Vierte por encima el líquido hirviendo para **cubrirlos del todo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends une semaine que le goût se fasse.
      'Guarda en la nevera y espera una semana a que el sabor se asiente.',
    ],
  ),
  'artichaut/Artichauts à la vinaigrette': RecipeText(
    // FR: Artichauts à la vinaigrette
    name: 'Alcachofas con vinagreta',
    // FR: Feuille à feuille, trempée, raclée entre les dents. Le fond pour la fin.
    description: 'Hoja a hoja, mojada y rascada con los dientes. El fondo, para el final.',
  ),
  'artichaut/Artichauts à la barigoule': RecipeText(
    // FR: Artichauts à la barigoule
    name: 'Alcachofas a la barigoule',
    // FR: Petits violets mijotés au vin blanc avec carotte et lard.
    description: 'Alcachofas moradas pequeñas estofadas con vino blanco, zanahoria y panceta.',
  ),
  'artichaut/Fonds d\'artichauts farcis': RecipeText(
    // FR: Fonds d'artichauts farcis
    name: 'Fondos de alcachofa rellenos',
    // FR: Garnis de brousse et d'herbes, passés au four.
    description: 'Rellenos de brousse (queso fresco) y hierbas, pasados por el horno.',
  ),

  // ─────────── asperge (6 recettes) ───────────
  'asperge/Asperges blanchies au congélateur': RecipeText(
    // FR: Asperges blanchies au congélateur
    name: 'Espárragos escaldados para congelar',
    // FR: Quand la planche donne plus que tu ne manges, deux à trois minutes d'eau bouillante sauvent la récolte.
    description: 'Cuando el bancal da más de lo que comes, dos o tres minutos en agua hirviendo salvan la cosecha.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de espárragos verdes o blancos', // FR: 1,5 kg d'asperges vertes ou blanches
      'sal gorda', // FR: gros sel
      'un bol grande con agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Casse le bas des asperges là où il cède tout seul. Pèle les blanches depuis la pointe, les vertes seulement en bas si elles sont grosses.
      'Parte la base de los espárragos por donde ceda sola. Pela los blancos desde la punta; los verdes, solo abajo si son gruesos.',
      // FR: Rince-les et trie-les par grosseur : elles ne blanchissent pas toutes au même rythme.
      'Enjuágalos y sepáralos por grosor: no todos se escaldan al mismo ritmo.',
      // FR: Plonge-les dans une grande eau salée bouillante : **2 minutes** pour les fines vertes, 3 pour les grosses et les blanches.
      'Échalos en una olla grande de agua salada hirviendo: **2 minutos** los verdes finos, 3 los gruesos y los blancos.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le temps qu'elles soient froides.
      'Pásalos enseguida a agua helada, el tiempo justo hasta que estén fríos.',
      // FR: Égoutte et sèche-les dans un torchon, une par une si besoin.
      'Escurre y sécalos con un paño, uno por uno si hace falta.',
      // FR: Congèle à plat sur une plaque, puis mets en sacs. Fais-les cuire **sans décongeler**, sinon elles ramollissent.
      'Congela en plano sobre una bandeja y luego pásalos a bolsas. Cuécelos **sin descongelar**, si no, se ablandan.',
    ],
  ),
  'asperge/Pickles d\'asperges vertes': RecipeText(
    // FR: Pickles d'asperges vertes
    name: 'Encurtido de espárragos verdes',
    // FR: Debout dans leur bocal, croquantes et acidulées : un apéritif de printemps qui dure jusqu'à l'été.
    description: 'De pie en su tarro, crujientes y ácidos: un aperitivo de primavera que dura hasta el verano.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de espárragos verdes', // FR: 1 kg d'asperges vertes
      '40 cl de vinagre blanco al 6 %', // FR: 40 cl de vinaigre blanc à 6 %
      '40 cl de agua', // FR: 40 cl d'eau
      '1 cucharada de sal', // FR: 1 cuillère à soupe de sel
      '1 cucharada de azúcar', // FR: 1 cuillère à soupe de sucre
      'unas ramitas de eneldo', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Casse le bas dur des asperges et coupe-les à la hauteur de tes bocaux, moins 2 cm.
      'Parte la base dura de los espárragos y córtalos a la altura de tus tarros, menos 2 cm.',
      // FR: Blanchis-les **1 minute** dans l'eau bouillante, juste pour qu'elles restent bien vertes.
      'Escáldalos **1 minuto** en agua hirviendo, solo para que se mantengan bien verdes.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte-les.
      'Refréscalos en agua helada y escúrrelos.',
      // FR: Range-les debout, pointes en haut, bien serrées, avec l'aneth.
      'Colócalos de pie, con las puntas hacia arriba, bien apretados, con el eneldo.',
      // FR: Porte le vinaigre, l'eau, le sel et le sucre à ébullition.
      'Lleva a ebullición el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant jusqu'à **couvrir les pointes**, ferme, laisse refroidir et range au réfrigérateur.
      'Vierte hirviendo hasta **cubrir las puntas**, cierra, deja enfriar y guarda en la nevera.',
    ],
  ),
  'asperge/Bouillon d\'épluchures d\'asperges': RecipeText(
    // FR: Bouillon d'épluchures d'asperges
    name: 'Caldo de peladuras de espárrago',
    // FR: Les pelures et les talons font un bouillon parfumé à congeler, la base d'un risotto ou d'une soupe hors saison.
    description: 'Las peladuras y los extremos dan un caldo aromático para congelar, la base de un risotto o de una sopa fuera de temporada.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      'las peladuras y los extremos de 2 kg de espárragos', // FR: les épluchures et talons de 2 kg d'asperges
      '1 cebolla', // FR: 1 oignon
      '1,5 litros de agua', // FR: 1,5 litre d'eau
      '1 hoja de laurel', // FR: 1 feuille de laurier
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Rince les épluchures et les talons, coupe les talons en morceaux.
      'Enjuaga las peladuras y los extremos, y corta los extremos en trozos.',
      // FR: Coupe l'oignon en quatre, sans l'éplucher : la peau donne une jolie couleur dorée.
      'Corta la cebolla en cuatro, sin pelarla: la piel da un bonito color dorado.',
      // FR: Mets tout dans l'eau froide avec le laurier, porte à ébullition puis laisse frémir.
      'Pon todo en agua fría con el laurel, lleva a ebullición y deja que hierva suave.',
      // FR: Filtre dans une passoire fine en pressant bien, puis sale légèrement.
      'Cuela por un colador fino presionando bien y sala ligeramente.',
      // FR: Refroidis vite la casserole dans l'eau froide.
      'Enfría rápido la olla metiéndola en agua fría.',
      // FR: Répartis en boîtes ou en sacs à plat, à 2 cm du bord, et note la date.
      'Reparte en recipientes o en bolsas planas, a 2 cm del borde, y anota la fecha.',
    ],
  ),
  'asperge/Asperges sauce mousseline': RecipeText(
    // FR: Asperges sauce mousseline
    name: 'Espárragos con salsa muselina',
    // FR: Tièdes, une hollandaise allégée de crème fouettée.
    description: 'Tibios, con una holandesa aligerada con nata montada.',
  ),
  'asperge/Asperges vertes rôties': RecipeText(
    // FR: Asperges vertes rôties
    name: 'Espárragos verdes asados',
    // FR: Huile d'olive, four très chaud, dix minutes. Zeste de citron à la sortie.
    description: 'Aceite de oliva, horno muy caliente, diez minutos. Ralladura de limón al sacarlos.',
  ),
  'asperge/Risotto aux asperges': RecipeText(
    // FR: Risotto aux asperges
    name: 'Risotto de espárragos',
    // FR: Les pointes réservées pour la fin, les queues dans le bouillon.
    description: 'Las puntas se reservan para el final y los tallos van al caldo.',
  ),

  // ─────────── aubergine (6 recettes) ───────────
  'aubergine/Aubergines grillées à l\'huile d\'olive': RecipeText(
    // FR: Aubergines grillées à l'huile d'olive
    name: 'Berenjenas a la parrilla en aceite de oliva',
    // FR: Grillées, arrosées de vinaigre et noyées d'huile : l'antipasto italien qui attend au frais.
    description: 'A la parrilla, regadas con vinagre y bañadas en aceite: el antipasto italiano que espera en frío.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 semanas en la nevera',
    ingredients: <String>[
      '2 kg de berenjenas', // FR: 2 kg d'aubergines
      '2 cucharadas de sal gorda', // FR: 2 cuillères à soupe de gros sel
      '10 cl de vinagre de vino', // FR: 10 cl de vinaigre de vin
      '50 cl de aceite de oliva', // FR: 50 cl d'huile d'olive
      '1 cucharadita de orégano seco', // FR: 1 cuillère à café d'origan séché
    ],
    steps: <String>[
      // FR: Lave les aubergines, coupe le pédoncule, essuie-les bien.
      'Lava las berenjenas, corta el pedúnculo y sécalas bien.',
      // FR: Coupe-les en tranches de 1 cm dans la longueur, pas plus fines : elles se déchireraient au gril.
      'Córtalas en láminas de 1 cm a lo largo, no más finas: se romperían en la parrilla.',
      // FR: Sale les tranches et laisse-les dégorger dans une passoire. Elles rendent une eau amère.
      'Sala las láminas y déjalas sudar en un colador. Sueltan un agua amarga.',
      // FR: Éponge-les, puis grille-les à sec sur une poêle-gril bien chaude, 3 à 4 minutes par face.
      'Sécalas con papel y ásalas sin aceite en una plancha bien caliente, de 3 a 4 minutos por cada lado.',
      // FR: Arrose chaque tranche encore chaude d'un peu de vinaigre : il **acidifie** la chair et la protège.
      'Riega cada lámina, todavía caliente, con un poco de vinagre: **acidifica** la carne y la protege.',
      // FR: Range-les en couches dans des bocaux propres, une pincée d'origan **séché** entre chaque couche. Pas d'ail cru.
      'Colócalas en capas en tarros limpios, con una pizca de orégano **seco** entre capa y capa. Nada de ajo crudo.',
      // FR: Couvre d'huile jusqu'à **1 cm au-dessus** des tranches, tasse pour chasser les bulles, ferme et file au réfrigérateur.
      'Cubre con aceite hasta **1 cm por encima** de las láminas, aprieta para sacar las burbujas, cierra y directo a la nevera.',
      // FR: Sors le bocal 20 minutes avant de servir : l'huile fige au froid, c'est normal. Reprends-en toujours avec une cuillère propre.
      'Saca el tarro 20 minutos antes de servir: el aceite se solidifica con el frío, es normal. Coge siempre con una cuchara limpia.',
    ],
  ),
  'aubergine/Rondelles d\'aubergine blanchies au citron': RecipeText(
    // FR: Rondelles d'aubergine blanchies au citron
    name: 'Rodajas de berenjena escaldadas con limón',
    // FR: Crue, l'aubergine devient spongieuse au congélateur ; quatre minutes à l'eau citronnée, et elle tient l'hiver.
    description: 'Cruda, la berenjena se vuelve esponjosa en el congelador; cuatro minutos en agua con limón y aguanta todo el invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de berenjenas', // FR: 1,5 kg d'aubergines
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'un bol grande con agua helada', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les aubergines en rondelles de 1 cm, sans les éplucher. Fais-le au dernier moment, elles noircissent vite.
      'Corta las berenjenas en rodajas de 1 cm, sin pelarlas. Hazlo en el último momento: se oscurecen enseguida.',
      // FR: Porte une grande casserole d'eau à gros bouillons avec le jus des citrons : c'est lui qui **garde la chair claire**.
      'Lleva a ebullición fuerte una olla grande de agua con el zumo de los limones: es lo que **mantiene la carne clara**.',
      // FR: Plonge les rondelles par petites fournées et compte 4 minutes à partir de la reprise de l'ébullition.
      'Echa las rodajas en tandas pequeñas y cuenta 4 minutos desde que el agua vuelva a hervir.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le temps qu'elles soient froides à cœur.
      'Pásalas enseguida al agua helada, hasta que estén frías por dentro.',
      // FR: Égoutte et sèche-les sur un torchon propre, en appuyant doucement : l'eau qui reste devient du givre.
      'Escurre y sécalas sobre un paño limpio, presionando suavemente: el agua que queda se convierte en escarcha.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent, congèle 2 heures, puis mets-les en sac. Pour moussaka, curry et ratatouille.
      'Extiéndelas sobre una bandeja sin que se toquen, congela 2 horas y luego pásalas a una bolsa. Para moussaka, curry y pisto.',
    ],
  ),
  'aubergine/Bâtonnets d\'aubergine au vinaigre': RecipeText(
    // FR: Bâtonnets d'aubergine au vinaigre
    name: 'Bastones de berenjena en vinagre',
    // FR: Un pickle méconnu : la chair fondante s'imbibe de vinaigre et d'ail, parfait avec du pain et du fromage.
    description: 'Un encurtido poco conocido: la carne tierna se empapa de vinagre y ajo, perfecto con pan y queso.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de berenjenas', // FR: 1 kg d'aubergines
      '30 g de sal', // FR: 30 g de sel
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 cucharadita de guindilla en copos', // FR: 1 cuillère à café de piment en flocons
    ],
    steps: <String>[
      // FR: Épluche les aubergines une bande sur deux et coupe-les en bâtonnets de la taille d'un doigt.
      'Pela las berenjenas dejando una tira sí y otra no y córtalas en bastones del grosor de un dedo.',
      // FR: Mélange-les au sel et laisse-les dégorger une heure dans une passoire.
      'Mézclalas con la sal y déjalas sudar una hora en un colador.',
      // FR: Rince-les à l'eau froide et presse-les à pleines mains pour chasser le jus amer.
      'Enjuágalas con agua fría y estrújalas con las manos para sacar el jugo amargo.',
      // FR: Porte le vinaigre et l'eau à ébullition, plonge les bâtonnets 2 minutes : ils deviennent translucides.
      'Lleva el vinagre y el agua a ebullición y echa los bastones 2 minutos: se vuelven translúcidos.',
      // FR: Tasse-les dans des bocaux propres avec l'ail en lamelles et le piment.
      'Apriétalos en tarros limpios con el ajo en láminas y la guindilla.',
      // FR: Verse le vinaigre bouillant par-dessus : les bâtonnets doivent être **entièrement couverts**. Ferme et laisse refroidir.
      'Vierte el vinagre hirviendo por encima: los bastones deben quedar **totalmente cubiertos**. Cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'ouvrir : le vinaigre a besoin de ce temps pour entrer au cœur.
      'Guarda en la nevera y espera 3 días antes de abrir: el vinagre necesita ese tiempo para llegar al centro.',
    ],
  ),
  'aubergine/Parmigiana d\'aubergines': RecipeText(
    // FR: Parmigiana d'aubergines
    name: 'Parmigiana de berenjena',
    // FR: Des couches d'aubergine, de tomate et de parmesan, longuement gratinées.
    description: 'Capas de berenjena, tomate y parmesano, gratinadas largo rato.',
    ingredients: <String>[
      '3 berenjenas grandes', // FR: 3 grosses aubergines
      '800 g de tomate triturado', // FR: 800 g de coulis de tomate
      '200 g de mozzarella', // FR: 200 g de mozzarella
      '120 g de parmesano', // FR: 120 g de parmesan
      'albahaca, aceite de oliva, sal', // FR: basilic, huile d'olive, sel
    ],
    steps: <String>[
      // FR: Coupe les aubergines en tranches de 1 cm.
      'Corta las berenjenas en láminas de 1 cm.',
      // FR: Sale-les et laisse-les dégorger 30 minutes : moins d'amertume, moins d'huile absorbée.
      'Sálalas y déjalas sudar 30 minutos: menos amargor y menos aceite absorbido.',
      // FR: Essuie-les et fais-les griller au four, 15 minutes à 220 °C, plutôt qu'à la poêle — elles boivent moins d'huile.
      'Sécalas y ásalas al horno, 15 minutos a 220 °C, mejor que en sartén: absorben menos aceite.',
      // FR: Fais réduire le coulis 15 minutes avec du basilic et du sel.
      'Reduce el tomate triturado 15 minutos con albahaca y sal.',
      // FR: Monte en couches : sauce, aubergines, mozzarella, parmesan, et recommence.
      'Monta por capas: salsa, berenjenas, mozzarella, parmesano, y vuelta a empezar.',
      // FR: Four à 180 °C, 35 minutes.
      'Horno a 180 °C, 35 minutos.',
      // FR: Attends 15 minutes avant de couper : elle se tient beaucoup mieux.
      'Espera 15 minutos antes de cortar: se sostiene mucho mejor.',
    ],
  ),
  'aubergine/Ratatouille': RecipeText(
    // FR: Ratatouille
    name: 'Pisto (ratatouille)',
    // FR: Chaque légume saisi à part, réunis à la fin : c'est le secret.
    description: 'Cada verdura se sofríe por separado y se juntan al final: ese es el secreto.',
    ingredients: <String>[
      '2 berenjenas', // FR: 2 aubergines
      '3 calabacines', // FR: 3 courgettes
      '2 pimientos', // FR: 2 poivrons
      '4 tomates', // FR: 4 tomates
      '2 cebollas, 3 dientes de ajo', // FR: 2 oignons, 3 gousses d'ail
      'tomillo, laurel, aceite de oliva, sal', // FR: thym, laurier, huile d'olive, sel
    ],
    steps: <String>[
      // FR: Coupe tous les légumes en cubes de même taille.
      'Corta todas las verduras en dados del mismo tamaño.',
      // FR: Fais revenir les aubergines seules, à feu vif, puis réserve.
      'Sofríe las berenjenas solas, a fuego vivo, y resérvalas.',
      // FR: Pareil pour les courgettes, puis les poivrons, puis les oignons. Chacun son tour, chacun son goût.
      'Igual con los calabacines, luego los pimientos y luego las cebollas. Cada uno a su turno, cada uno con su sabor.',
      // FR: Dans la cocotte, fais fondre tomates et ail avec thym et laurier, 15 minutes.
      'En la cazuela, deshaz los tomates y el ajo con el tomillo y el laurel, 15 minutos.',
      // FR: Réunis tout, sale, et laisse mijoter à découvert 30 minutes.
      'Junta todo, sala y deja cocer a fuego lento sin tapar 30 minutos.',
      // FR: Meilleure réchauffée le lendemain — vraiment.
      'Mejor recalentado al día siguiente: de verdad.',
    ],
  ),
  'aubergine/Caviar d\'aubergine': RecipeText(
    // FR: Caviar d'aubergine
    name: 'Caviar de berenjena',
    // FR: Les aubergines brûlées au four, puis écrasées à l'huile et au citron.
    description: 'Berenjenas quemadas al horno y luego machacadas con aceite y limón.',
    ingredients: <String>[
      '3 berenjenas', // FR: 3 aubergines
      '1 diente de ajo', // FR: 1 gousse d'ail
      '1 limón', // FR: 1 citron
      '3 cucharadas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      '1 cucharada de tahini (opcional), sal, comino', // FR: 1 cuillère à soupe de tahin (facultatif), sel, cumin
    ],
    steps: <String>[
      // FR: Pique les aubergines entières et enfourne-les à 220 °C, 45 minutes, jusqu'à ce que la peau cloque et noircisse.
      'Pincha las berenjenas enteras y mételas al horno a 220 °C, 45 minutos, hasta que la piel se ampolle y se ennegrezca.',
      // FR: Coupe-les en deux et récupère la chair à la cuillère.
      'Pártelas por la mitad y saca la carne con una cuchara.',
      // FR: Laisse-la égoutter 10 minutes dans une passoire.
      'Déjala escurrir 10 minutos en un colador.',
      // FR: Écrase à la fourchette avec ail, citron, huile, cumin, sel. Pas au mixeur : on veut de la texture.
      'Machaca con un tenedor con el ajo, el limón, el aceite, el comino y la sal. Nada de batidora: queremos textura.',
      // FR: Un filet d'huile dessus, avec du pain grillé.
      'Un chorrito de aceite por encima, con pan tostado.',
    ],
  ),

  // ─────────── aubergine_africaine (6 recettes) ───────────
  'aubergine_africaine/Djakhatou blanchis au congélateur': RecipeText(
    // FR: Djakhatou blanchis au congélateur
    name: 'Djakhatou escaldados para congelar',
    // FR: Blanchis quatre minutes et congelés, ils se jettent directement dans le thiéboudienne ou la sauce.
    description: 'Escaldados cuatro minutos y congelados, se echan directamente al thiéboudienne o a la salsa.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de berenjenas africanas', // FR: 1,5 kg d'aubergines africaines
      'el zumo de un limón', // FR: le jus d'un citron
      'sal gorda', // FR: gros sel
      '1 bol grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les aubergines et retire le calice vert.
      'Lava las berenjenas y quita el cáliz verde.',
      // FR: Coupe les petites en deux, les grosses en quatre.
      'Corta las pequeñas por la mitad y las grandes en cuatro.',
      // FR: Ajoute le jus de citron à une grande eau bouillante salée : il empêche la chair de noircir.
      'Añade el zumo de limón a una olla grande de agua salada hirviendo: evita que la carne se oscurezca.',
      // FR: Plonge les morceaux à gros bouillons.
      'Echa los trozos con el agua a borbotones.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée, le même temps.
      'Escurre y mételos enseguida en agua helada, el mismo tiempo.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Escurre y sécalos bien con un paño.',
      // FR: Étale sur une plaque, congèle 2 heures, puis mets en sacs.
      'Extiéndelos sobre una bandeja, congela 2 horas y luego pásalos a bolsas.',
    ],
  ),
  'aubergine_africaine/Rondelles d\'aubergine africaine séchées': RecipeText(
    // FR: Rondelles d'aubergine africaine séchées
    name: 'Rodajas de berenjena africana secas',
    // FR: Séchées en rondelles, elles se gardent des mois et se réhydratent dans les sauces mijotées.
    description: 'Secas en rodajas, duran meses y se rehidratan en los guisos de cocción lenta.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 meses en seco, protegidas de la luz',
    ingredients: <String>[
      '1 kg de berenjenas africanas', // FR: 1 kg d'aubergines africaines
      'el zumo de un limón', // FR: le jus d'un citron
      '1 bol de agua', // FR: 1 saladier d'eau
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Lave les aubergines et retire le calice.
      'Lava las berenjenas y quita el cáliz.',
      // FR: Coupe-les en rondelles de 5 mm, toutes de la même épaisseur.
      'Córtalas en rodajas de 5 mm, todas del mismo grosor.',
      // FR: Plonge-les 5 minutes dans l'eau citronnée pour qu'elles ne noircissent pas, puis égoutte.
      'Déjalas 5 minutos en agua con limón para que no se oscurezcan y escúrrelas.',
      // FR: Étale en une couche et sèche à **60 °C**, porte entrouverte. Au soleil, compte 2 à 3 jours.
      'Extiéndelas en una sola capa y sécalas a **60 °C**, con la puerta entreabierta. Al sol, cuenta de 2 a 3 días.',
      // FR: Elles sont prêtes quand elles sont cassantes et sans aucun cœur mou.
      'Están listas cuando quiebran y no queda ningún centro blando.',
      // FR: Mets en bocal hermétique. Fais-les tremper 20 minutes avant de les ajouter à la sauce.
      'Guárdalas en un tarro hermético. Déjalas 20 minutos en remojo antes de añadirlas a la salsa.',
    ],
  ),
  'aubergine_africaine/Djakhatou grillés à l\'huile': RecipeText(
    // FR: Djakhatou grillés à l'huile
    name: 'Djakhatou a la parrilla en aceite',
    // FR: Grillés et couverts d'huile, ils font un antipasto fondant et légèrement amer à garder au frais.
    description: 'A la parrilla y cubiertos de aceite, dan un antipasto tierno y ligeramente amargo para guardar en frío.',
    // FR: 2 semaines au réfrigérateur
    keeps: '2 semanas en la nevera',
    ingredients: <String>[
      '1 kg de berenjenas africanas', // FR: 1 kg d'aubergines africaines
      '25 cl de aceite de oliva', // FR: 25 cl d'huile d'olive
      '1 cucharadita de tomillo seco', // FR: 1 cuillère à café de thym séché
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les aubergines, retire le calice et coupe-les en tranches de 1 cm.
      'Lava las berenjenas, quita el cáliz y córtalas en láminas de 1 cm.',
      // FR: Sale-les légèrement et laisse dégorger, puis éponge-les.
      'Sálalas ligeramente y déjalas sudar, luego sécalas.',
      // FR: Fais-les griller à la poêle ou sous le gril, jusqu'à ce qu'elles soient **tendres à cœur** et marquées.
      'Ásalas en sartén o bajo el grill hasta que estén **tiernas por dentro** y marcadas.',
      // FR: Laisse-les refroidir complètement sur une grille.
      'Déjalas enfriar del todo sobre una rejilla.',
      // FR: Range-les dans un bocal propre en saupoudrant de thym **séché**, jamais d'ail ni d'herbes crus.
      'Colócalas en un tarro limpio espolvoreando tomillo **seco**, nunca ajo ni hierbas crudos.',
      // FR: Couvre entièrement d'huile, tasse pour chasser les bulles, et ferme.
      'Cúbrelas del todo con aceite, aprieta para sacar las burbujas y cierra.',
      // FR: Toujours au réfrigérateur. Sors le bocal 20 minutes avant de servir, l'huile fige au froid.
      'Siempre en la nevera. Saca el tarro 20 minutos antes de servir: el aceite se solidifica con el frío.',
    ],
  ),
  'aubergine_africaine/Djakhatou en sauce': RecipeText(
    // FR: Djakhatou en sauce
    name: 'Djakhatou en salsa',
    // FR: Amers et fermes, ils tiennent la cuisson longue.
    description: 'Amargos y firmes, aguantan la cocción larga.',
  ),
  'aubergine_africaine/Kedjenou de poulet': RecipeText(
    // FR: Kedjenou de poulet
    name: 'Kedjenou de pollo',
    // FR: Le mijoté ivoirien à l'étouffée, où l'aubergine africaine fond dans la sauce.
    description: 'El guiso marfileño a fuego lento y sin agua, donde la berenjena africana se funde en la salsa.',
  ),
  'aubergine_africaine/Sauce djakhatou': RecipeText(
    // FR: Sauce djakhatou
    name: 'Salsa de djakhatou',
    // FR: L'aubergine amère mijotée à la sénégalaise, pour les amateurs de vrais goûts.
    description: 'La berenjena amarga guisada a la senegalesa, para los amantes de los sabores de verdad.',
  ),

  // ─────────── bananier_plantain (6 recettes) ───────────
  'bananier_plantain/Plantains mûrs en tronçons congelés': RecipeText(
    // FR: Plantains mûrs en tronçons congelés
    name: 'Plátanos machos maduros en trozos congelados',
    // FR: Quand tout le régime mûrit d'un coup, un quart d'heure et tes plantains attendent la poêle au congélateur.
    description: 'Cuando todo el racimo madura de golpe, un cuarto de hora y tus plátanos esperan la sartén en el congelador.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      'plátanos machos maduros, de piel amarilla manchada de negro', // FR: des plantains mûrs, peau jaune tachée de noir
      'papel de horno', // FR: du papier cuisson
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les deux bouts, incise la peau sur toute la longueur et retire-la d'un bloc.
      'Corta las dos puntas, haz un corte en la piel a lo largo y quítala de una pieza.',
      // FR: Coupe en tronçons de 4 cm, ou directement en biais comme pour les frire.
      'Corta en trozos de 4 cm, o directamente en diagonal como para freírlos.',
      // FR: Étale-les sur une plaque recouverte de papier cuisson, **sans qu'ils se touchent**, et congèle 2 heures.
      'Extiéndelos sobre una bandeja cubierta con papel de horno, **sin que se toquen**, y congela 2 horas.',
      // FR: Verse-les en sac une fois durs, chasse l'air et note la date.
      'Pásalos a una bolsa cuando estén duros, saca el aire y anota la fecha.',
      // FR: À l'usage, fais-les frire encore à moitié gelés, à feu moyen : décongelés, ils boivent l'huile.
      'Al usarlos, fríelos todavía a medio congelar, a fuego medio: descongelados, absorben el aceite.',
    ],
  ),
  'bananier_plantain/Farine de plantain vert': RecipeText(
    // FR: Farine de plantain vert
    name: 'Harina de plátano macho verde',
    // FR: Séché et moulu, le plantain vert devient une farine qui se garde un an et se cuit en pâte ou en bouillie.
    description: 'Seco y molido, el plátano macho verde se convierte en una harina que dura un año y se cocina en masa o en papilla.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegida de la luz',
    ingredients: <String>[
      '2 kg de plátanos machos bien verdes', // FR: 2 kg de plantains bien verts
      'el zumo de un limón', // FR: le jus d'un citron
      '1 bol de agua fría', // FR: 1 saladier d'eau froide
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Huile-toi les mains ou mets des gants : la sève du plantain vert tache. Coupe les bouts et fends la peau le long des arêtes pour l'enlever.
      'Úntate las manos con aceite o ponte guantes: la savia del plátano macho verde mancha. Corta las puntas y abre la piel a lo largo de las aristas para quitarla.',
      // FR: Coupe la chair en rondelles fines de 3 mm, au couteau ou à la mandoline.
      'Corta la pulpa en rodajas finas de 3 mm, con cuchillo o mandolina.',
      // FR: Plonge-les au fur et à mesure dans l'eau citronnée : sans ça, elles noircissent en dix minutes.
      'Échalas al agua con limón a medida que las cortas: si no, se oscurecen en diez minutos.',
      // FR: Égoutte, étale en une couche et sèche à **60 °C**, porte entrouverte, jusqu'à ce qu'elles cassent net. Au soleil, 3 à 4 jours.
      'Escurre, extiende en una sola capa y seca a **60 °C**, con la puerta entreabierta, hasta que se partan limpiamente. Al sol, de 3 a 4 días.',
      // FR: Mixe les rondelles refroidies en poudre fine, puis passe-la au tamis et remixe ce qui reste.
      'Tritura las rodajas ya frías hasta obtener un polvo fino, pásalo por el tamiz y vuelve a triturar lo que quede.',
      // FR: Mets en bocal hermétique bien sec. Pour l'utiliser, verse-la en pluie dans l'eau bouillante en remuant.
      'Guárdala en un tarro hermético bien seco. Para usarla, échala en lluvia en agua hirviendo, removiendo.',
    ],
  ),
  'bananier_plantain/Plantains semi-frits à congeler': RecipeText(
    // FR: Plantains semi-frits à congeler
    name: 'Plátanos machos semifritos para congelar',
    // FR: Frits une fois, aplatis, congelés : il ne reste qu'une deuxième friture de trois minutes pour des tostones croustillants.
    description: 'Fritos una vez, aplastados y congelados: solo queda una segunda fritura de tres minutos para unos tostones crujientes.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      '4 plátanos machos verdes o apenas amarillos', // FR: 4 plantains verts ou juste jaunes
      'aceite de fritura', // FR: huile de friture
      'papel de horno', // FR: du papier cuisson
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les plantains et coupe-les en tronçons épais de 3 cm.
      'Pela los plátanos y córtalos en trozos gruesos de 3 cm.',
      // FR: Fais-les frire dans l'huile à 160 °C jusqu'à ce qu'ils soient tendres mais **encore pâles**.
      'Fríelos en aceite a 160 °C hasta que estén tiernos pero **todavía pálidos**.',
      // FR: Égoutte-les et écrase chaque tronçon avec le fond d'un verre, à 1 cm d'épaisseur.
      'Escúrrelos y aplasta cada trozo con el fondo de un vaso, hasta 1 cm de grosor.',
      // FR: Laisse refroidir complètement sur du papier absorbant.
      'Deja enfriar del todo sobre papel absorbente.',
      // FR: Pose-les sur une plaque garnie de papier cuisson et congèle 2 heures, puis mets-les en sac.
      'Colócalos sobre una bandeja con papel de horno y congela 2 horas, luego pásalos a una bolsa.',
      // FR: Le jour J, plonge-les encore gelés dans l'huile à 180 °C, 3 minutes. Sale à la sortie.
      'El día D, échalos todavía congelados al aceite a 180 °C, 3 minutos. Sala al sacarlos.',
    ],
  ),
  'bananier_plantain/Alloco': RecipeText(
    // FR: Alloco
    name: 'Alloco',
    // FR: Les plantains bien mûrs frits à l'ivoirienne, dorés et fondants à souhait.
    description: 'Plátanos machos bien maduros fritos a la marfileña, dorados y tiernos como deben ser.',
  ),
  'bananier_plantain/Kelewele': RecipeText(
    // FR: Kelewele
    name: 'Kelewele',
    // FR: Le plantain frit du Ghana, mariné au gingembre et au piment, sucré-épicé.
    description: 'El plátano macho frito de Ghana, marinado con jengibre y guindilla, entre dulce y picante.',
  ),
  'bananier_plantain/Foutou banane': RecipeText(
    // FR: Foutou banane
    name: 'Foutou de plátano',
    // FR: La boule de plantain pilé de Côte d'Ivoire, à tremper dans une bonne sauce.
    description: 'La bola de plátano macho machacado de Costa de Marfil, para mojar en una buena salsa.',
  ),

  // ─────────── baselle (6 recettes) ───────────
  'baselle/Baselle blanchie au congélateur': RecipeText(
    // FR: Baselle blanchie au congélateur
    name: 'Espinaca de Malabar (baselle) escaldada para congelar',
    // FR: Feuilles charnues et tiges tendres, blanchies puis congelées : elles retrouvent leur fondant dans la sauce.
    description: 'Hojas carnosas y tallos tiernos, escaldados y congelados: recuperan su suavidad en la salsa.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de espinaca de Malabar, hojas y tallos tiernos', // FR: 1 kg de baselle, feuilles et tiges tendres
      'sal gorda', // FR: gros sel
      '1 bol grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Sépare les feuilles des tiges et coupe les tiges tendres en tronçons de 3 cm.
      'Separa las hojas de los tallos y corta los tallos tiernos en trozos de 3 cm.',
      // FR: Lave le tout dans plusieurs eaux.
      'Lava todo en varias aguas.',
      // FR: Plonge d'abord les tiges dans l'eau bouillante salée 1 minute, puis ajoute les feuilles pour une minute de plus.
      'Echa primero los tallos en agua salada hirviendo 1 minuto y luego añade las hojas durante un minuto más.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée.
      'Escurre y mételo enseguida en agua helada.',
      // FR: Égoutte bien et presse doucement : la baselle est gluante, inutile de l'essorer à fond.
      'Escurre bien y aprieta suavemente: la espinaca de Malabar es viscosa, no hace falta escurrirla a fondo.',
      // FR: Répartis à plat en sacs, une portion par sac, et congèle.
      'Reparte en bolsas, planas, una ración por bolsa, y congela.',
    ],
  ),
  'baselle/Velouté de baselle à congeler': RecipeText(
    // FR: Velouté de baselle à congeler
    name: 'Crema de espinaca de Malabar para congelar',
    // FR: La baselle épaissit d'elle-même : un velouté onctueux sans crème, parfait pour le congélateur.
    description: 'La espinaca de Malabar espesa sola: una crema untuosa sin nata, perfecta para el congelador.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '600 g de espinaca de Malabar', // FR: 600 g de baselle
      '3 patatas', // FR: 3 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '1,2 litros de caldo', // FR: 1,2 litre de bouillon
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave la baselle et hache grossièrement feuilles et tiges tendres.
      'Lava la espinaca de Malabar y pica en trozos grandes las hojas y los tallos tiernos.',
      // FR: Épluche et coupe en dés les pommes de terre et l'oignon.
      'Pela y corta en dados las patatas y la cebolla.',
      // FR: Cuis pommes de terre et oignon dans le bouillon.
      'Cuece las patatas y la cebolla en el caldo.',
      // FR: Ajoute la baselle et cuis quelques minutes, juste qu'elle fonde.
      'Añade la espinaca de Malabar y cuece unos minutos, justo hasta que se deshaga.',
      // FR: Mixe hors du feu. **Sans crème** : elle tranche à la décongélation, tu l'ajouteras dans l'assiette.
      'Tritura fuera del fuego. **Sin nata**: se corta al descongelar, ya la añadirás en el plato.',
      // FR: Refroidis vite, casserole dans l'eau froide.
      'Enfría rápido, con la olla metida en agua fría.',
      // FR: Répartis en portions en laissant 2 cm de vide, et note la date.
      'Reparte en raciones dejando 2 cm de hueco y anota la fecha.',
    ],
  ),
  'baselle/Feuilles de baselle congelées crues': RecipeText(
    // FR: Feuilles de baselle congelées crues
    name: 'Hojas de espinaca de Malabar congeladas en crudo',
    // FR: Un quart d'heure quand la liane déborde : crues et congelées, elles finissent dans les sauces mijotées.
    description: 'Un cuarto de hora cuando la enredadera se desborda: crudas y congeladas, acaban en los guisos.',
    // FR: 3 mois au congélateur
    keeps: '3 meses en el congelador',
    ingredients: <String>[
      'hojas de espinaca de Malabar frescas', // FR: des feuilles de baselle fraîches
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Cueille les feuilles et les pointes tendres, retire les tiges dures.
      'Recoge las hojas y las puntas tiernas, quita los tallos duros.',
      // FR: Lave et **sèche à fond** dans un torchon : l'eau restante fait du givre.
      'Lava y **seca a fondo** con un paño: el agua que queda se convierte en escarcha.',
      // FR: Mets en sacs par portions, à plat, en chassant l'air.
      'Pon en bolsas por raciones, planas, sacando el aire.',
      // FR: Jette-les encore gelées dans la sauce en fin de cuisson. Crues, elles se gardent moins longtemps que blanchies.
      'Échalas todavía congeladas a la salsa al final de la cocción. Crudas, duran menos que escaldadas.',
    ],
  ),
  'baselle/Baselle à la sauce tomate': RecipeText(
    // FR: Baselle à la sauce tomate
    name: 'Espinaca de Malabar en salsa de tomate',
    // FR: Ses feuilles charnues épaississent la sauce d'elles-mêmes.
    description: 'Sus hojas carnosas espesan la salsa por sí solas.',
  ),
  'baselle/Baselle vapeur au sésame': RecipeText(
    // FR: Baselle vapeur au sésame
    name: 'Espinaca de Malabar al vapor con sésamo',
    // FR: Cinq minutes de vapeur, huile de sésame et soja.
    description: 'Cinco minutos al vapor, aceite de sésamo y soja.',
  ),
  'baselle/Sauce feuilles de baselle': RecipeText(
    // FR: Sauce feuilles de baselle
    name: 'Salsa de hojas de espinaca de Malabar',
    // FR: L'épinard de Ceylan mijoté en sauce onctueuse, douce et légèrement mucilagineuse.
    description: 'La espinaca de Ceilán guisada en una salsa untuosa, suave y ligeramente mucilaginosa.',
  ),

  // ─────────── basilic (6 recettes) ───────────
  'basilic/Pâte de basilic sans fromage': RecipeText(
    // FR: Pâte de basilic sans fromage
    name: 'Pasta de albahaca sin queso',
    // FR: Le basilic à l'huile, mixé sans parmesan ni pignons : la base qui se congèle le mieux, tu finis le pesto au moment de servir.
    description: 'Albahaca con aceite, triturada sin parmesano ni piñones: la base que mejor se congela; el pesto lo terminas al servir.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '200 g de hojas de albahaca', // FR: 200 g de feuilles de basilic
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      '1 pizca de sal', // FR: 1 pincée de sel
      'tarritos o una cubitera', // FR: des petits pots ou un bac à glaçons
    ],
    steps: <String>[
      // FR: Effeuille le basilic et jette les tiges dures et les fleurs.
      'Deshoja la albahaca y tira los tallos duros y las flores.',
      // FR: Rince rapidement et **sèche très bien** les feuilles dans un torchon, sans les froisser : meurtries, elles noircissent.
      'Enjuaga rápido y **seca muy bien** las hojas con un paño, sin arrugarlas: magulladas, se ennegrecen.',
      // FR: Mixe par à-coups avec l'huile et le sel, sans laisser chauffer la lame, jusqu'à une pâte grossière.
      'Tritura a golpes cortos con el aceite y la sal, sin dejar que se caliente la cuchilla, hasta obtener una pasta gruesa.',
      // FR: Répartis en petits pots ou en bac à glaçons et couvre d'un filet d'huile : c'est ce qui **garde le vert**.
      'Reparte en tarritos o en una cubitera y cubre con un chorrito de aceite: es lo que **conserva el verde**.',
      // FR: Congèle aussitôt. À l'usage, ajoute parmesan, pignons et ail à la pâte décongelée.
      'Congela enseguida. Al usarla, añade parmesano, piñones y ajo a la pasta descongelada.',
    ],
  ),
  'basilic/Glaçons de basilic à l\'huile d\'olive': RecipeText(
    // FR: Glaçons de basilic à l'huile d'olive
    name: 'Cubitos de albahaca en aceite de oliva',
    // FR: Des feuilles hachées prises dans l'huile, à faire fondre dans une sauce tomate ou sur un gratin.
    description: 'Hojas picadas atrapadas en aceite, para derretir en una salsa de tomate o sobre un gratinado.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '3 buenos puñados de albahaca', // FR: 3 grosses poignées de basilic
      '10 cl de aceite de oliva', // FR: 10 cl d'huile d'olive
      'cubiteras', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Effeuille, rince et sèche bien les feuilles.
      'Deshoja, enjuaga y seca bien las hojas.',
      // FR: Hache-les grossièrement avec un couteau bien aiguisé, qui coupe sans écraser.
      'Pícalas en trozos grandes con un cuchillo bien afilado, que corte sin aplastar.',
      // FR: Remplis les bacs aux trois quarts de basilic haché.
      'Llena las cubiteras hasta tres cuartos con albahaca picada.',
      // FR: Couvre d'huile d'olive jusqu'à ce que les feuilles soient **entièrement noyées**.
      'Cubre con aceite de oliva hasta que las hojas queden **totalmente sumergidas**.',
      // FR: Congèle jusqu'à ce qu'ils soient durs, puis démoule et garde en sac. Toujours au congélateur, jamais à température ambiante.
      'Congela hasta que estén duros, desmolda y guarda en una bolsa. Siempre en el congelador, nunca a temperatura ambiente.',
    ],
  ),
  'basilic/Vinaigre de basilic': RecipeText(
    // FR: Vinaigre de basilic
    name: 'Vinagre de albahaca',
    // FR: Les dernières tiges, avant les premières gelées, infusées dans du vinaigre : l'été dans chaque vinaigrette.
    description: 'Los últimos tallos, antes de las primeras heladas, infusionados en vinagre: el verano en cada vinagreta.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '2 buenos puñados de albahaca', // FR: 2 grosses poignées de basilic
      '75 cl de vinagre de vino blanco al 6 %', // FR: 75 cl de vinaigre de vin blanc à 6 %
      '1 botella de cristal limpia', // FR: 1 bouteille en verre propre
    ],
    steps: <String>[
      // FR: Rince les tiges et **sèche-les à fond** : une goutte d'eau suffit à troubler le vinaigre.
      'Enjuaga los tallos y **sécalos a fondo**: una gota de agua basta para enturbiar el vinagre.',
      // FR: Froisse légèrement les feuilles entre tes mains pour libérer l'arôme.
      'Arruga ligeramente las hojas entre las manos para liberar el aroma.',
      // FR: Tasse le basilic dans un bocal propre et couvre-le entièrement de vinaigre.
      'Aprieta la albahaca en un tarro limpio y cúbrela del todo con el vinagre.',
      // FR: Ferme et laisse infuser 2 semaines à l'abri de la lumière, en secouant de temps en temps.
      'Cierra y deja infusionar 2 semanas protegido de la luz, agitando de vez en cuando.',
      // FR: Filtre dans une bouteille propre et jette les feuilles : sorties du vinaigre, elles ne se gardent pas.
      'Filtra a una botella limpia y tira las hojas: fuera del vinagre, no se conservan.',
    ],
  ),
  'basilic/Pistou': RecipeText(
    // FR: Pistou
    name: 'Pistou',
    // FR: Basilic, ail et huile, sans pignons : la version provençale.
    description: 'Albahaca, ajo y aceite, sin piñones: la versión provenzal.',
    ingredients: <String>[
      '2 manojos grandes de albahaca', // FR: 2 gros bouquets de basilic
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      '60 g de parmesano (opcional)', // FR: 60 g de parmesan (facultatif)
      'sal gorda', // FR: gros sel
    ],
    steps: <String>[
      // FR: Effeuille le basilic. Les tiges amères ne vont pas au mortier.
      'Deshoja la albahaca. Los tallos amargos no van al mortero.',
      // FR: Pile l'ail au gros sel, puis ajoute les feuilles.
      'Machaca el ajo con la sal gorda y luego añade las hojas.',
      // FR: Écrase en tournant, par petites poignées : au mortier le basilic rend son parfum, au mixeur il chauffe et noircit.
      'Aplasta dando vueltas, en puñados pequeños: en el mortero la albahaca suelta su aroma; en la batidora se calienta y se ennegrece.',
      // FR: Monte à l'huile en filet jusqu'à une pommade.
      'Incorpora el aceite a hilo hasta lograr una pomada.',
    ],
  ),
  'basilic/Soupe au pistou': RecipeText(
    // FR: Soupe au pistou
    name: 'Sopa de pistou',
    // FR: Tous les légumes d'été, et une cuillère de pistou au dernier moment.
    description: 'Todas las verduras de verano y una cucharada de pistou en el último momento.',
    ingredients: <String>[
      '300 g de judías blancas frescas', // FR: 300 g de haricots blancs frais
      '2 calabacines, 2 zanahorias, 2 patatas', // FR: 2 courgettes, 2 carottes, 2 pommes de terre
      '200 g de judías verdes', // FR: 200 g de haricots verts
      '3 tomates', // FR: 3 tomates
      '100 g de pasta corta, pistou, sal', // FR: 100 g de pâtes courtes, pistou, sel
    ],
    steps: <String>[
      // FR: Fais cuire les haricots blancs 30 minutes dans de l'eau non salée.
      'Cuece las judías blancas 30 minutos en agua sin sal.',
      // FR: Ajoute les légumes en dés, du plus dur au plus tendre, et sale.
      'Añade las verduras en dados, de la más dura a la más tierna, y sala.',
      // FR: Cuis 20 minutes.
      'Cuece 20 minutos.',
      // FR: Ajoute les pâtes les 10 dernières minutes.
      'Añade la pasta durante los últimos 10 minutos.',
      // FR: Le pistou se met **hors du feu**, dans la soupière ou dans l'assiette. Cuit, il perd tout.
      'El pistou se pone **fuera del fuego**, en la sopera o en el plato. Cocido, lo pierde todo.',
    ],
  ),
  'basilic/Pesto maison': RecipeText(
    // FR: Pesto maison
    name: 'Pesto casero',
    // FR: Avec pignons et parmesan, la version génoise, pour les pâtes.
    description: 'Con piñones y parmesano, la versión genovesa, para la pasta.',
    ingredients: <String>[
      '80 g de hojas de albahaca', // FR: 80 g de feuilles de basilic
      '40 g de piñones', // FR: 40 g de pignons
      '60 g de parmesano', // FR: 60 g de parmesan
      '1 diente de ajo', // FR: 1 gousse d'ail
      '12 cl de aceite de oliva, sal', // FR: 12 cl d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Torréfie les pignons 2 minutes à sec.
      'Tuesta los piñones 2 minutos en seco.',
      // FR: Mixe basilic, ail, pignons par à-coups pour ne pas chauffer.
      'Tritura la albahaca, el ajo y los piñones a golpes cortos para que no se calienten.',
      // FR: Ajoute le parmesan, puis l'huile en filet.
      'Añade el parmesano y luego el aceite a hilo.',
      // FR: Pour les pâtes : détends-le avec une cuillère d'eau de cuisson, jamais sur le feu.
      'Para la pasta: aflójalo con una cucharada del agua de cocción, nunca sobre el fuego.',
    ],
  ),

  // ─────────── betterave (6 recettes) ───────────
  'betterave/Betteraves en tranches au vinaigre': RecipeText(
    // FR: Betteraves en tranches au vinaigre
    name: 'Remolacha en rodajas en vinagre',
    // FR: Cuites, tranchées et noyées de vinaigre épicé : le pickle rubis des grands-mères, prêt pour toutes les salades.
    description: 'Cocida, en rodajas y bañada en vinagre especiado: el encurtido rubí de las abuelas, listo para todas las ensaladas.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '2 kg de remolachas', // FR: 2 kg de betteraves
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '100 g de azúcar', // FR: 100 g de sucre
      '1 cucharada de sal', // FR: 1 cuillère à soupe de sel
      '1 cebolla, 4 clavos de olor', // FR: 1 oignon, 4 clous de girofle
    ],
    steps: <String>[
      // FR: Brosse les betteraves sans les éplucher et laisse 3 cm de tige : entières, elles ne saignent pas.
      'Cepilla las remolachas sin pelarlas y deja 3 cm de tallo: enteras, no sangran.',
      // FR: Cuis-les à l'eau frémissante jusqu'à ce qu'un couteau entre facilement.
      'Cuécelas en agua a fuego suave hasta que un cuchillo entre con facilidad.',
      // FR: Passe-les sous l'eau froide : la peau glisse alors toute seule sous les doigts.
      'Pásalas por agua fría: la piel se desliza sola con los dedos.',
      // FR: Coupe-les en tranches de 5 mm et l'oignon en fines rondelles.
      'Córtalas en rodajas de 5 mm y la cebolla en aros finos.',
      // FR: Porte à ébullition vinaigre, eau, sucre, sel et girofle.
      'Lleva a ebullición el vinagre, el agua, el azúcar, la sal y los clavos.',
      // FR: Range betteraves et oignon en couches dans des bocaux propres, jusqu'à 2 cm du bord.
      'Coloca remolacha y cebolla en capas en tarros limpios, hasta 2 cm del borde.',
      // FR: Verse le vinaigre bouillant pour **tout recouvrir**, ferme, laisse refroidir et range au réfrigérateur. Prêtes en 3 jours.
      'Vierte el vinagre hirviendo para **cubrirlo todo**, cierra, deja enfriar y guarda en la nevera. Listas en 3 días.',
    ],
  ),
  'betterave/Betterave crue râpée en portions': RecipeText(
    // FR: Betterave crue râpée en portions
    name: 'Remolacha cruda rallada en raciones',
    // FR: Un quart d'heure à la râpe, et tu as de quoi faire soupes, gâteaux et poêlées tout l'hiver.
    description: 'Un cuarto de hora con el rallador y tienes para sopas, bizcochos y salteados todo el invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de remolachas crudas', // FR: 1,5 kg de betteraves crues
      'guantes', // FR: des gants
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les betteraves à la brosse et coupe les deux bouts.
      'Lava las remolachas con un cepillo y corta las dos puntas.',
      // FR: Épluche-les avec des gants : le jus rouge **tache les doigts** pour la journée.
      'Pélalas con guantes: el jugo rojo **te tiñe los dedos** todo el día.',
      // FR: Râpe-les gros, à la main ou au robot. Crue, la betterave garde tout son sucre.
      'Rállalas gruesas, a mano o con el robot. Cruda, la remolacha conserva todo su azúcar.',
      // FR: Répartis en sachets de 200 g, aplatis-les et chasse l'air. Utilise-la **cuite** : décongelée crue, elle devient molle.
      'Reparte en bolsitas de 200 g, aplánalas y saca el aire. Úsala **cocida**: descongelada en crudo, se ablanda.',
    ],
  ),
  'betterave/Betterave râpée lacto-fermentée': RecipeText(
    // FR: Betterave râpée lacto-fermentée
    name: 'Remolacha rallada lactofermentada',
    // FR: Crue, râpée et salée, elle fermente en un condiment acidulé et croquant qui se garde des mois.
    description: 'Cruda, rallada y salada, fermenta hasta ser un condimento ácido y crujiente que dura meses.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '1 kg de remolachas crudas peladas', // FR: 1 kg de betteraves crues épluchées
      '20 g de sal sin yodo', // FR: 20 g de sel non iodé
      '1 cucharadita de semillas de alcaravea', // FR: 1 cuillère à café de graines de carvi
      '1 trocito pequeño de jengibre', // FR: 1 petit morceau de gingembre
    ],
    steps: <String>[
      // FR: Épluche les betteraves avec des gants et râpe-les côté gros trous. Pèse : il faut **20 g de sel par kilo**.
      'Pela las remolachas con guantes y ralla por el lado de los agujeros grandes. Pesa: necesitas **20 g de sal por kilo**.',
      // FR: Mélange la râpée avec le sel, le carvi et le gingembre râpé, et masse quelques minutes jusqu'à ce que le jus sorte.
      'Mezcla lo rallado con la sal, la alcaravea y el jengibre rallado, y masajea unos minutos hasta que suelte el jugo.',
      // FR: Tasse très fort par couches dans un bocal propre, avec le poing, jusqu'à ce que le jus **remonte au-dessus**.
      'Aprieta muy fuerte por capas en un tarro limpio, con el puño, hasta que el jugo **suba por encima**.',
      // FR: Pose un poids, laisse 3 cm de vide, et laisse fermenter 1 à 2 semaines vers 20 °C. Appuie chaque jour pour chasser les bulles.
      'Pon un peso, deja 3 cm de hueco y deja fermentar de 1 a 2 semanas hacia los 20 °C. Presiona cada día para sacar las burbujas.',
      // FR: Quand c'est acidulé à ton goût, ferme et range au réfrigérateur. Toujours une cuillère propre.
      'Cuando esté ácida a tu gusto, cierra y guarda en la nevera. Siempre con una cuchara limpia.',
    ],
  ),
  'betterave/Betteraves rôties au four': RecipeText(
    // FR: Betteraves rôties au four
    name: 'Remolachas asadas al horno',
    // FR: Cuites en robe, elles concentrent leur sucre au lieu de le perdre dans l'eau.
    description: 'Cocidas con su piel, concentran su azúcar en vez de perderlo en el agua.',
    ingredients: <String>[
      '6 remolachas medianas', // FR: 6 betteraves moyennes
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      'sal gorda, tomillo', // FR: gros sel, thym
      '1 cucharada de vinagre balsámico', // FR: 1 cuillère à soupe de vinaigre balsamique
    ],
    steps: <String>[
      // FR: Brosse les betteraves sans les peler, coupe les fanes à 2 cm.
      'Cepilla las remolachas sin pelarlas y corta los tallos a 2 cm.',
      // FR: Enrobe d'huile, roule dans le gros sel, pose sur une plaque.
      'Úntalas de aceite, rebózalas en la sal gorda y colócalas en una bandeja.',
      // FR: Four à 200 °C, 60 minutes. Un couteau doit entrer sans résistance.
      'Horno a 200 °C, 60 minutos. Un cuchillo debe entrar sin resistencia.',
      // FR: Tiédies, la peau se retire au doigt — et ne tache pas les mains comme à cru.
      'Tibias, la piel se quita con el dedo, y no te mancha las manos como en crudo.',
      // FR: Coupe en quartiers, un trait de balsamique.
      'Corta en gajos y un chorrito de balsámico.',
    ],
  ),
  'betterave/Betterave chèvre et noix': RecipeText(
    // FR: Betterave chèvre et noix
    name: 'Remolacha, queso de cabra y nueces',
    // FR: Le trio qui ne rate jamais : le sucré, l'acide et le croquant.
    description: 'El trío que nunca falla: lo dulce, lo ácido y lo crujiente.',
    ingredients: <String>[
      '4 remolachas cocidas', // FR: 4 betteraves cuites
      '150 g de queso de cabra fresco', // FR: 150 g de fromage de chèvre frais
      '60 g de nueces peladas', // FR: 60 g de cerneaux de noix
      '1 cucharada de miel', // FR: 1 cuillère à soupe de miel
      'aceite, vinagre, sal, pimienta, cebollino', // FR: huile, vinaigre, sel, poivre, ciboulette
    ],
    steps: <String>[
      // FR: Coupe les betteraves en dés réguliers.
      'Corta las remolachas en dados regulares.',
      // FR: Mélange huile, vinaigre, miel, sel, poivre.
      'Mezcla aceite, vinagre, miel, sal y pimienta.',
      // FR: Dresse les dés, émiette le chèvre dessus, parsème les noix.
      'Dispón los dados, desmenuza el queso de cabra por encima y esparce las nueces.',
      // FR: Verse la sauce au dernier moment, ciboulette, et sers frais.
      'Echa la salsa en el último momento, cebollino, y sirve fresco.',
    ],
  ),
  'betterave/Soupe de betterave à l\'aneth': RecipeText(
    // FR: Soupe de betterave à l'aneth
    name: 'Sopa de remolacha con eneldo',
    // FR: Une couleur impossible, et un goût de terre douce que l'aneth éclaire.
    description: 'Un color imposible y un sabor a tierra dulce que el eneldo ilumina.',
    ingredients: <String>[
      '600 g de remolachas', // FR: 600 g de betteraves
      '1 patata', // FR: 1 pomme de terre
      '1 cebolla', // FR: 1 oignon
      '80 cl de caldo', // FR: 80 cl de bouillon
      '10 cl de nata, eneldo, sal, pimienta', // FR: 10 cl de crème, aneth, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé.
      'Rehoga la cebolla en juliana hasta que se ablande.',
      // FR: Ajoute betteraves et pomme de terre en dés, puis le bouillon.
      'Añade las remolachas y la patata en dados, y luego el caldo.',
      // FR: Cuis 30 minutes à couvert.
      'Cuece 30 minutos con tapa.',
      // FR: Mixe longuement : la betterave demande à être lisse.
      'Tritura bastante rato: la remolacha pide quedar bien fina.',
      // FR: Crème hors du feu, beaucoup d'aneth ciselé. Bon chaud comme glacé.
      'La nata, fuera del fuego, y mucho eneldo picado. Buena caliente o fría.',
    ],
  ),

  // ─────────── bissap (6 recettes) ───────────
  'bissap/Calices de bissap séchés': RecipeText(
    // FR: Calices de bissap séchés
    name: 'Cálices de bissap secos',
    // FR: Séchés à l'ombre, les calices gardent leur rouge profond et font du bissap toute l'année.
    description: 'Secados a la sombra, los cálices conservan su rojo intenso y dan bissap (hibisco) todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidos de la luz',
    ingredients: <String>[
      'cálices frescos de bissap', // FR: les calices frais de bissap
      'un tubo o una pajita rígida', // FR: un tube ou un petit tuyau rigide
      'rejillas o una sábana limpia', // FR: des claies ou un drap propre
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe la base du calice et pousse la capsule verte avec un tube : elle sort d'un coup, le calice reste entier.
      'Corta la base del cáliz y empuja la cápsula verde con un tubo: sale de golpe y el cáliz queda entero.',
      // FR: Rince rapidement les calices et égoutte-les bien.
      'Enjuaga rápido los cálices y escúrrelos bien.',
      // FR: Étale-les en couche mince à l'ombre, dans un endroit aéré, 4 à 5 jours en les retournant chaque jour. Le soleil direct les ternit.
      'Extiéndelos en una capa fina a la sombra, en un lugar ventilado, de 4 a 5 días, dándoles la vuelta cada día. El sol directo los deslustra.',
      // FR: Teste : ils doivent être craquants comme du papier. Mous, ils moisiront dans le bocal.
      'Prueba: deben crujir como papel. Si están blandos, se enmohecerán en el tarro.',
      // FR: Mets-les en bocaux hermétiques, à l'abri de la lumière. Garde les capsules pour ressemer.
      'Guárdalos en tarros herméticos, protegidos de la luz. Conserva las cápsulas para resembrar.',
    ],
  ),
  'bissap/Gelée de bissap': RecipeText(
    // FR: Gelée de bissap
    name: 'Gelatina de bissap',
    // FR: Le bissap est plein de pectine : il fait une gelée qui prend toute seule, acidulée et rouge rubis.
    description: 'El bissap está lleno de pectina: da una gelatina que cuaja sola, ácida y de un rojo rubí.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '500 g de cálices de bissap frescos', // FR: 500 g de calices de bissap frais
      '1 litro de agua', // FR: 1 litre d'eau
      '800 g de azúcar', // FR: 800 g de sucre
      'el zumo de un limón', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Sépare les calices des capsules et rince-les.
      'Separa los cálices de las cápsulas y enjuágalos.',
      // FR: Fais-les cuire dans l'eau à petits bouillons, à couvert, jusqu'à ce qu'ils soient tout mous.
      'Cuécelos en el agua a fuego suave, con tapa, hasta que estén blandísimos.',
      // FR: Verse dans un torchon propre au-dessus d'un saladier et laisse couler sans presser trop fort.
      'Viértelo en un paño limpio sobre un bol y deja que gotee sin apretar demasiado fuerte.',
      // FR: Mesure 1 litre de jus, ajoute le sucre et le citron, et porte à ébullition en remuant.
      'Mide 1 litro de jugo, añade el azúcar y el limón, y lleva a ebullición removiendo.',
      // FR: Cuis à feu vif en écumant.
      'Cuece a fuego vivo, retirando la espuma.',
      // FR: Teste sur une assiette froide : une goutte qui se ride quand tu la pousses du doigt, c'est prêt.
      'Prueba en un plato frío: si una gota se arruga al empujarla con el dedo, está lista.',
      // FR: Verse dans des pots ébouillantés jusqu'à 1 cm du bord, ferme et retourne jusqu'à refroidissement.
      'Vierte en tarros escaldados hasta 1 cm del borde, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'bissap/Calices frais congelés': RecipeText(
    // FR: Calices frais congelés
    name: 'Cálices frescos congelados',
    // FR: Un quart d'heure, et tes calices frais attendent l'envie d'une gelée ou d'un bissap bien rouge.
    description: 'Un cuarto de hora, y tus cálices frescos esperan a que te apetezca una gelatina o un bissap bien rojo.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'cálices de bissap frescos', // FR: des calices de bissap frais
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les capsules en les poussant avec un tube par la base du calice.
      'Quita las cápsulas empujándolas con un tubo por la base del cáliz.',
      // FR: Rince et **sèche bien** les calices sur un torchon.
      'Enjuaga y **seca bien** los cálices sobre un paño.',
      // FR: Étale-les sur une plaque et congèle 1 heure, puis mets-les en sac.
      'Extiéndelos sobre una bandeja y congela 1 hora, luego pásalos a una bolsa.',
      // FR: Utilise-les encore gelés, directement dans l'eau chaude ou la casserole de confiture.
      'Úsalos todavía congelados, directamente en el agua caliente o en la olla de mermelada.',
    ],
  ),
  'bissap/Sorbet au bissap': RecipeText(
    // FR: Sorbet au bissap
    name: 'Sorbete de bissap',
    // FR: L'infusion sucrée prise en sorbet, acidulée et profonde.
    description: 'La infusión azucarada convertida en sorbete, ácida y profunda.',
  ),
  'bissap/Jus de bissap': RecipeText(
    // FR: Jus de bissap
    name: 'Zumo de bissap',
    // FR: L'infusion glacée d'hibiscus, rouge rubis, sucrée et follement rafraîchissante.
    description: 'La infusión fría de hibisco, rojo rubí, dulce y tremendamente refrescante.',
  ),
  'bissap/Sirop de bissap': RecipeText(
    // FR: Sirop de bissap
    name: 'Sirope de bissap',
    // FR: Un sirop maison concentré, à garder au frais pour tes boissons de saison chaude.
    description: 'Un sirope casero concentrado, para guardar en frío y tener en tus bebidas de calor.',
  ),

  // ─────────── blette (6 recettes) ───────────
  'blette/Vert de blettes en boulettes': RecipeText(
    // FR: Vert de blettes en boulettes
    name: 'Hojas de acelga en bolitas',
    // FR: Une minute dans l'eau bouillante, pressé en boules : du vert prêt pour les omelettes et les farces tout l'hiver.
    description: 'Un minuto en agua hirviendo, apretadas en bolas: verde listo para tortillas y rellenos todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de acelgas (la parte verde)', // FR: 2 kg de blettes (le vert)
      'sal gorda', // FR: gros sel
      'un bol grande con agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Sépare le vert des côtes en coupant de part et d'autre de la nervure. Garde les côtes pour les pickles.
      'Separa la hoja de las pencas cortando a ambos lados del nervio. Guarda las pencas para encurtidos.',
      // FR: Lave les feuilles dans plusieurs eaux et coupe-les grossièrement.
      'Lava las hojas en varias aguas y córtalas en trozos grandes.',
      // FR: Plonge-les dans une grande eau salée bouillante, **1 minute**, juste le temps qu'elles s'affaissent.
      'Échalas en una olla grande de agua salada hirviendo, **1 minuto**, justo el tiempo de que se ablanden.',
      // FR: Fais-les tomber dans l'eau glacée pour fixer le vert.
      'Pásalas al agua helada para fijar el verde.',
      // FR: Presse-les très fort entre tes mains pour chasser l'eau, et forme des boulettes d'une portion.
      'Aprieta muy fuerte entre las manos para sacar el agua y forma bolitas del tamaño de una ración.',
      // FR: Congèle-les 2 heures sur une plaque, puis passe-les en sac.
      'Congélalas 2 horas sobre una bandeja y pásalas luego a una bolsa.',
    ],
  ),
  'blette/Côtes de blettes au vinaigre': RecipeText(
    // FR: Côtes de blettes au vinaigre
    name: 'Pencas de acelga en vinagre',
    // FR: Les côtes rouges et jaunes deviennent des pickles croquants qui font de l'effet dans un bocal.
    description: 'Las pencas rojas y amarillas se convierten en encurtidos crujientes que lucen mucho en un tarro.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '800 g de pencas de acelga', // FR: 800 g de côtes de blettes
      '40 cl de vinagre de sidra al 6 %', // FR: 40 cl de vinaigre de cidre à 6 %
      '40 cl de agua', // FR: 40 cl d'eau
      '2 cucharadas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 cucharada de sal fina', // FR: 1 cuillère à soupe de sel fin
      '1 cucharadita de semillas de cilantro', // FR: 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Rince les côtes et retire les fils des plus larges en tirant avec un couteau, comme pour la rhubarbe.
      'Enjuaga las pencas y quita los hilos de las más anchas tirando con un cuchillo, como con el ruibarbo.',
      // FR: Coupe-les en bâtonnets de la hauteur de tes bocaux, moins 2 cm.
      'Córtalas en bastones de la altura de tus tarros, menos 2 cm.',
      // FR: Range-les debout, bien serrés, avec les graines de coriandre.
      'Colócalas de pie, bien apretadas, con las semillas de cilantro.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement** les côtes, ferme et laisse refroidir.
      'Vierte hirviendo hasta **cubrir del todo** las pencas, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 3 jours. Les côtes colorées teintent le liquide, c'est joli et normal.
      'Guarda en la nevera y espera 3 días. Las pencas de colores tiñen el líquido: es bonito y normal.',
    ],
  ),
  'blette/Hachis de blettes à l\'oignon': RecipeText(
    // FR: Hachis de blettes à l'oignon
    name: 'Picadillo de acelgas con cebolla',
    // FR: Côtes et vert fondus ensemble, congelés en portions : une base prête pour une quiche, des pâtes ou des raviolis.
    description: 'Pencas y hojas fundidas juntas y congeladas en raciones: una base lista para una quiche, pasta o raviolis.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de acelgas enteras', // FR: 1,5 kg de blettes entières
      '2 cebollas', // FR: 2 oignons
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave les blettes, sépare côtes et vert, et retire les fils des grosses côtes.
      'Lava las acelgas, separa pencas y hojas, y quita los hilos de las pencas grandes.',
      // FR: Coupe les côtes en petits dés et hache grossièrement le vert. Émince les oignons.
      'Corta las pencas en dados pequeños y pica las hojas en trozos grandes. Corta las cebollas en juliana.',
      // FR: Fais revenir oignons et côtes dans l'huile à couvert, jusqu'à ce qu'ils soient tendres.
      'Rehoga las cebollas y las pencas en el aceite con tapa, hasta que estén tiernas.',
      // FR: Ajoute le vert et laisse cuire à découvert pour évaporer l'eau, en remuant.
      'Añade las hojas y deja cocer sin tapar para evaporar el agua, removiendo.',
      // FR: Sale, poivre, râpe un peu de muscade. Goûte : c'est plus facile d'assaisonner maintenant qu'après.
      'Sala, echa pimienta y ralla un poco de nuez moscada. Prueba: es más fácil sazonar ahora que después.',
      // FR: Refroidis vite en étalant sur une plaque, puis répartis en boîtes d'une portion, à 2 cm du bord, et congèle.
      'Enfría rápido extendiendo en una bandeja, luego reparte en recipientes de una ración, a 2 cm del borde, y congela.',
    ],
  ),
  'blette/Blettes à la crème': RecipeText(
    // FR: Blettes à la crème
    name: 'Acelgas a la crema',
    // FR: Vert et côtes cuits séparément, réunis dans une crème au citron.
    description: 'Hojas y pencas cocidas por separado y reunidas en una crema con limón.',
    ingredients: <String>[
      '1 manojo de acelgas', // FR: 1 botte de blettes
      '20 cl de nata', // FR: 20 cl de crème
      '20 g de mantequilla', // FR: 20 g de beurre
      '1/2 limón', // FR: 1/2 citron
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Sépare le vert des côtes : ils ne cuisent pas en même temps.
      'Separa las hojas de las pencas: no se cuecen al mismo tiempo.',
      // FR: Cuis les côtes 15 minutes à l'eau citronnée — le citron les empêche de noircir.
      'Cuece las pencas 15 minutos en agua con limón: el limón evita que se ennegrezcan.',
      // FR: Fais tomber le vert 5 minutes à la poêle beurrée.
      'Ablanda las hojas 5 minutos en una sartén con mantequilla.',
      // FR: Égoutte tout soigneusement.
      'Escurre todo con cuidado.',
      // FR: Réunis avec la crème, laisse épaissir 5 minutes, muscade.
      'Júntalo con la nata, deja espesar 5 minutos y añade nuez moscada.',
    ],
  ),
  'blette/Tourte de blettes niçoise': RecipeText(
    // FR: Tourte de blettes niçoise
    name: 'Tarta de acelgas a la niçoise',
    // FR: La tourte sucrée du pays niçois : blettes, raisins secs, pignons.
    description: 'La tarta dulce de la región de Niza: acelgas, pasas y piñones.',
    ingredients: <String>[
      '2 masas quebradas', // FR: 2 pâtes brisées
      'la parte verde de un manojo de acelgas', // FR: le vert d'une botte de blettes
      '2 manzanas', // FR: 2 pommes
      '60 g de pasas, 40 g de piñones', // FR: 60 g de raisins secs, 40 g de pignons
      '80 g de azúcar, 1 huevo, 1 limón', // FR: 80 g de sucre, 1 oeuf, 1 citron
    ],
    steps: <String>[
      // FR: Hache finement le vert des blettes, cru — il ne se cuit pas avant.
      'Pica fina la parte verde de las acelgas, cruda: no se cuece antes.',
      // FR: Mélange-le aux pommes râpées, raisins, pignons, sucre, zeste de citron.
      'Mézclala con las manzanas ralladas, las pasas, los piñones, el azúcar y la ralladura de limón.',
      // FR: Garnis la première pâte, couvre de la seconde, soude les bords.
      'Rellena la primera masa, cubre con la segunda y sella los bordes.',
      // FR: Dore à l'oeuf battu et pique le dessus.
      'Pinta con huevo batido y pincha la superficie.',
      // FR: Four à 180 °C, 45 minutes.
      'Horno a 180 °C, 45 minutos.',
      // FR: Sucre glace à froid. Surprenant, et très bon.
      'Azúcar glas por encima una vez fría. Sorprendente, y muy buena.',
    ],
  ),
  'blette/Gratin de côtes de blettes': RecipeText(
    // FR: Gratin de côtes de blettes
    name: 'Gratinado de pencas de acelga',
    // FR: Les côtes, qu'on jette trop souvent, sous une béchamel légère.
    description: 'Las pencas, que tantas veces se tiran, bajo una bechamel ligera.',
    ingredients: <String>[
      'las pencas de 2 manojos de acelgas', // FR: les côtes de 2 bottes de blettes
      '40 g de mantequilla, 40 g de harina', // FR: 40 g de beurre, 40 g de farine
      '50 cl de leche', // FR: 50 cl de lait
      '100 g de gruyer', // FR: 100 g de gruyère
      'sal, pimienta, nuez moscada, 1/2 limón', // FR: sel, poivre, muscade, 1/2 citron
    ],
    steps: <String>[
      // FR: Pèle les fils des côtes à l'économe et coupe-les en tronçons.
      'Quita los hilos de las pencas con el pelador y córtalas en trozos.',
      // FR: Cuis-les 20 minutes à l'eau citronnée salée.
      'Cuécelas 20 minutos en agua salada con limón.',
      // FR: Béchamel : beurre fondu, farine 2 minutes, lait chaud en fouettant.
      'Bechamel: mantequilla derretida, harina 2 minutos, leche caliente sin dejar de batir.',
      // FR: Mélange les côtes égouttées à la béchamel, verse dans le plat, fromage dessus.
      'Mezcla las pencas escurridas con la bechamel, vierte en la fuente y pon el queso por encima.',
      // FR: Four à 190 °C, 25 minutes.
      'Horno a 190 °C, 25 minutos.',
    ],
  ),

  // ─────────── bleuet (6 recettes) ───────────
  'bleuet/Pétales de bleuet séchés': RecipeText(
    // FR: Pétales de bleuet séchés
    name: 'Pétalos de aciano secos',
    // FR: Séchés à l'ombre, ils gardent leur bleu intense pour décorer gâteaux et salades toute l'année.
    description: 'Secados a la sombra, conservan su azul intenso para decorar tartas y ensaladas todo el año.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 año en tarro, protegidos de la luz',
    ingredients: <String>[
      'unas cincuenta flores de aciano bien abiertas', // FR: une cinquantaine de fleurs de bleuet bien ouvertes
      'papel de periódico o una rejilla', // FR: du papier journal ou une claie
      'un tarro opaco', // FR: un bocal opaque
    ],
    steps: <String>[
      // FR: Cueille les fleurs en fin de matinée, quand la rosée est partie, le jour où elles viennent de s'ouvrir.
      'Recoge las flores a media mañana, cuando se ha ido el rocío, el día en que acaban de abrirse.',
      // FR: Pince la base de chaque fleur et tire les petits pétales bleus : la partie verte ne se garde pas.
      'Pellizca la base de cada flor y tira de los pétalos azules pequeños: la parte verde no se conserva.',
      // FR: Étale-les en une couche fine sur du papier, **à l'ombre**, dans une pièce sèche et aérée, pendant 3 jours.
      'Extiéndelos en una capa fina sobre papel, **a la sombra**, en una habitación seca y ventilada, durante 3 días.',
      // FR: Teste : un pétale sec est cassant comme du papier. S'il est encore mou, laisse-le un jour de plus.
      'Prueba: un pétalo seco se quiebra como el papel. Si aún está blando, déjalo un día más.',
      // FR: Range-les en bocal opaque : à la lumière, le bleu passe au gris en quelques semaines.
      'Guárdalos en un tarro opaco: con la luz, el azul pasa a gris en pocas semanas.',
    ],
  ),
  'bleuet/Glaçons fleuris au bleuet': RecipeText(
    // FR: Glaçons fleuris au bleuet
    name: 'Cubitos de hielo con flores de aciano',
    // FR: Un quart d'heure pour des glaçons qui transforment un verre d'eau en jolie boisson d'été.
    description: 'Un cuarto de hora para unos cubitos que convierten un vaso de agua en una bonita bebida de verano.',
    // FR: 3 mois au congélateur
    keeps: '3 meses en el congelador',
    ingredients: <String>[
      'una veintena de flores de aciano', // FR: une vingtaine de fleurs de bleuet
      '50 cl de agua hervida y enfriada', // FR: 50 cl d'eau bouillie refroidie
      'una cubitera', // FR: un bac à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Détache les pétales ou garde de petites fleurs entières, sans la partie verte.
      'Separa los pétalos o deja flores pequeñas enteras, sin la parte verde.',
      // FR: Remplis le bac à moitié avec l'eau bouillie refroidie : elle donne des glaçons **bien transparents**.
      'Llena la cubitera hasta la mitad con el agua hervida y enfriada: da cubitos **bien transparentes**.',
      // FR: Pose les pétales dans chaque case et congèle une heure : ils restent ainsi au milieu du glaçon.
      'Pon los pétalos en cada hueco y congela una hora: así quedan en medio del cubito.',
      // FR: Complète avec le reste de l'eau froide et remets au congélateur jusqu'à ce que ce soit dur.
      'Completa con el resto del agua fría y vuelve a poner en el congelador hasta que esté duro.',
      // FR: Démoule les glaçons et garde-les en sac, à l'écart des aliments qui sentent fort.
      'Desmolda los cubitos y guárdalos en una bolsa, lejos de los alimentos que huelen fuerte.',
    ],
  ),
  'bleuet/Vinaigre rose au bleuet': RecipeText(
    // FR: Vinaigre rose au bleuet
    name: 'Vinagre rosa de aciano',
    // FR: Au contact du vinaigre, le bleu vire au rose : un condiment tout doux et très joli sur une salade.
    description: 'Al contacto con el vinagre, el azul vira a rosa: un condimento suave y muy bonito en una ensalada.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '2 buenos puñados de pétalos de aciano', // FR: 2 grosses poignées de pétales de bleuet
      '50 cl de vinagre de sidra o de vino blanco al 6 % mínimo', // FR: 50 cl de vinaigre de cidre ou de vin blanc à 6 % minimum
      '1 tarro limpio', // FR: 1 bocal propre
      '2 botellas de 25 cl', // FR: 2 bouteilles de 25 cl
    ],
    steps: <String>[
      // FR: Détache les pétales des fleurs cueillies le matin, sans la partie verte qui donnerait de l'amertume.
      'Separa los pétalos de las flores recogidas por la mañana, sin la parte verde, que daría amargor.',
      // FR: Mets les pétales dans le bocal en les tassant légèrement.
      'Pon los pétalos en el tarro apretándolos ligeramente.',
      // FR: Verse le vinaigre : les pétales doivent être **entièrement couverts**. Regarde la couleur virer en quelques minutes.
      'Vierte el vinagre: los pétalos deben quedar **totalmente cubiertos**. Mira cómo cambia el color en pocos minutos.',
      // FR: Ferme et laisse infuser 2 semaines à l'abri de la lumière, en secouant de temps en temps.
      'Cierra y deja infusionar 2 semanas protegido de la luz, agitando de vez en cuando.',
      // FR: Filtre à travers un linge fin et mets en bouteilles propres. Garde à l'ombre pour ne pas perdre la couleur.
      'Filtra con un paño fino y pasa a botellas limpias. Guárdalo a la sombra para no perder el color.',
    ],
  ),
  'bleuet/Fleurs de bleuet en décoration': RecipeText(
    // FR: Fleurs de bleuet en décoration
    name: 'Flores de aciano para decorar',
    // FR: Les pétales, crus, posés sur une salade ou un gâteau.
    description: 'Los pétalos, crudos, sobre una ensalada o una tarta.',
  ),
  'bleuet/Infusion de bleuet': RecipeText(
    // FR: Infusion de bleuet
    name: 'Infusión de aciano',
    // FR: Fleurs séchées, douces, légèrement amères.
    description: 'Flores secas, suaves, ligeramente amargas.',
  ),
  'bleuet/Sel aux fleurs': RecipeText(
    // FR: Sel aux fleurs
    name: 'Sal con flores',
    // FR: Pétales séchés mélangés au gros sel.
    description: 'Pétalos secos mezclados con sal gorda.',
  ),

  // ─────────── bourrache (6 recettes) ───────────
  'bourrache/Jeunes feuilles de bourrache blanchies': RecipeText(
    // FR: Jeunes feuilles de bourrache blanchies
    name: 'Hojas tiernas de borraja escaldadas',
    // FR: Blanchies comme des épinards, elles farcissent raviolis et tourtes à la mode ligure tout l'hiver.
    description: 'Escaldadas como las espinacas, rellenan raviolis y empanadas al estilo ligur todo el invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas tiernas de borraja', // FR: 1 kg de jeunes feuilles de bourrache
      'sal gorda', // FR: gros sel
      'un bol grande con agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Prends seulement les **jeunes feuilles** du cœur, et mets des gants : elles piquent. Coupe les pétioles.
      'Coge solo las **hojas tiernas** del centro y ponte guantes: pinchan. Corta los pecíolos.',
      // FR: Lave-les dans plusieurs eaux froides.
      'Lávalas en varias aguas frías.',
      // FR: Plonge-les dans une grande eau salée à gros bouillons, 1 minute. Les poils piquants disparaissent à la cuisson.
      'Échalas en una olla grande de agua salada a borbotones, 1 minuto. Los pelos punzantes desaparecen al cocer.',
      // FR: Égoutte et plonge-les aussitôt dans l'eau glacée pour fixer le vert.
      'Escúrrelas y pásalas enseguida al agua helada para fijar el verde.',
      // FR: Presse-les en boule entre tes mains, **vraiment fort** : l'eau qui reste devient du givre.
      'Aprieta en bola entre las manos, **de verdad fuerte**: el agua que queda se convierte en escarcha.',
      // FR: Forme des boulettes d'une portion, congèle-les sur plaque, puis mets-les en sac.
      'Forma bolitas del tamaño de una ración, congélalas en bandeja y luego pásalas a una bolsa.',
    ],
  ),
  'bourrache/Gelée de fleurs de bourrache': RecipeText(
    // FR: Gelée de fleurs de bourrache
    name: 'Gelatina de flores de borraja',
    // FR: Les étoiles bleues donnent une gelée rose tendre au goût léger de concombre : la surprise du petit-déjeuner.
    description: 'Las estrellas azules dan una gelatina rosa tierno con un ligero sabor a pepino: la sorpresa del desayuno.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierto en la nevera',
    ingredients: <String>[
      '3 puñados de flores de borraja (unos 60 g)', // FR: 3 poignées de fleurs de bourrache (environ 60 g)
      '75 cl de agua', // FR: 75 cl d'eau
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '750 g de azúcar', // FR: 750 g de sucre
      '1 sobre de pectina por cada 1 kg de fruta', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Tire chaque fleur hors de son calice velu : ne garde que l'étoile bleue.
      'Saca cada flor de su cáliz peludo: quédate solo con la estrella azul.',
      // FR: Porte l'eau à ébullition, verse-la sur les fleurs, couvre et coupe le feu.
      'Lleva el agua a ebullición, viértela sobre las flores, tapa y apaga el fuego.',
      // FR: Laisse infuser une heure, puis filtre en pressant les fleurs.
      'Deja infusionar una hora y luego filtra presionando las flores.',
      // FR: Ajoute le jus de citron : l'infusion vire du bleu au rose.
      'Añade el zumo de limón: la infusión cambia de azul a rosa.',
      // FR: Mélange la pectine à un peu du sucre, verse-la dans l'infusion, porte à ébullition puis ajoute le reste du sucre.
      'Mezcla la pectina con un poco del azúcar, échala a la infusión, lleva a ebullición y añade el resto del azúcar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Hierve a borbotones removiendo, según indique el sobre de pectina.',
      // FR: Verse en pots chauds ébouillantés, ferme aussitôt et retourne jusqu'à refroidissement.
      'Vierte en tarros calientes y escaldados, cierra enseguida y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'bourrache/Fleurs de bourrache séchées pour le décor': RecipeText(
    // FR: Fleurs de bourrache séchées pour le décor
    name: 'Flores de borraja secas para decorar',
    // FR: Séchées vite et à l'ombre, elles gardent une partie de leur bleu pour décorer biscuits et infusions.
    description: 'Secadas rápido y a la sombra, conservan parte de su azul para decorar galletas e infusiones.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      '2 puñados de flores de borraja', // FR: 2 poignées de fleurs de bourrache
      'una rejilla, un tamiz o una parrilla', // FR: une claie, un tamis ou une grille
      'una cajita hermética', // FR: une petite boîte hermétique
    ],
    steps: <String>[
      // FR: Cueille les fleurs fraîchement ouvertes, rosée évaporée, et détache-les de leur calice.
      'Recoge las flores recién abiertas, con el rocío ya evaporado, y sepáralas de su cáliz.',
      // FR: Ne les lave pas : étale-les une par une sur la claie, sans qu'elles se touchent.
      'No las laves: extiéndelas una a una sobre la rejilla, sin que se toquen.',
      // FR: Fais-les sécher à l'ombre dans une pièce chaude et aérée, ou au déshydrateur à 35 °C. **Plus c'est rapide, plus le bleu tient.**
      'Sécalas a la sombra en una habitación cálida y ventilada, o en el deshidratador a 35 °C. **Cuanto más rápido, más azul conservan.**',
      // FR: Elles sont prêtes quand elles sont fines comme du papier et se brisent au toucher.
      'Están listas cuando son finas como el papel y se rompen al tocarlas.',
      // FR: Range-les dans une boîte hermétique, dans le noir : la lumière les décolore en quelques semaines.
      'Guárdalas en una caja hermética, a oscuras: la luz las decolora en pocas semanas.',
    ],
  ),
  'bourrache/Fleurs de bourrache glacées': RecipeText(
    // FR: Fleurs de bourrache glacées
    name: 'Flores de borraja heladas',
    // FR: Prises dans des glaçons, bleues dans le verre.
    description: 'Atrapadas en cubitos, azules dentro del vaso.',
  ),
  'bourrache/Bourrache en beignets': RecipeText(
    // FR: Bourrache en beignets
    name: 'Borraja en buñuelos',
    // FR: Les feuilles, en pâte à beignets légère.
    description: 'Las hojas, en una masa de buñuelo ligera.',
  ),
  'bourrache/Soupe de bourrache': RecipeText(
    // FR: Soupe de bourrache
    name: 'Sopa de borraja',
    // FR: Les jeunes feuilles ont un goût de concombre.
    description: 'Las hojas tiernas tienen sabor a pepino.',
  ),

  // ─────────── brocoli (6 recettes) ───────────
  'brocoli/Fleurettes de brocoli blanchies au congélateur': RecipeText(
    // FR: Fleurettes de brocoli blanchies au congélateur
    name: 'Ramilletes de brócoli escaldados para congelar',
    // FR: Trois minutes dans l'eau bouillante, et tes brocolis restent verts et fermes jusqu'au printemps.
    description: 'Tres minutos en agua hirviendo y tu brócoli se mantiene verde y firme hasta la primavera.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de brócoli', // FR: 2 kg de brocolis
      'sal gorda', // FR: gros sel
      '1 bol grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Fais tremper les têtes 10 minutes dans l'eau froide salée, tête en bas : les petites chenilles sortent toutes seules.
      'Deja las cabezas 10 minutos en agua fría con sal, boca abajo: las orugitas salen solas.',
      // FR: Détaille en fleurettes de taille égale, et pèle la tige avant de la couper en rondelles : elle se congèle aussi.
      'Separa en ramilletes de tamaño parecido y pela el tallo antes de cortarlo en rodajas: también se congela.',
      // FR: Plonge-les par petites quantités dans une grande eau bouillante, **3 minutes** chrono à la reprise de l'ébullition.
      'Échalos en tandas pequeñas en una olla grande de agua hirviendo, **3 minutos** exactos desde que vuelva a hervir.',
      // FR: Transfère aussitôt dans l'eau glacée, autant de temps que la cuisson : c'est ce qui **fixe le vert**.
      'Pásalos enseguida al agua helada, el mismo tiempo que la cocción: es lo que **fija el verde**.',
      // FR: Égoutte puis sèche sur un torchon propre. Chaque goutte restée devient du givre.
      'Escurre y seca sobre un paño limpio. Cada gota que quede se convierte en escarcha.',
      // FR: Étale sur une plaque sans qu'elles se touchent, congèle 2 heures, puis verse en sacs datés.
      'Extiende sobre una bandeja sin que se toquen, congela 2 horas y luego pásalos a bolsas con fecha.',
    ],
  ),
  'brocoli/Pesto de brocoli en glaçons': RecipeText(
    // FR: Pesto de brocoli en glaçons
    name: 'Pesto de brócoli en cubitos',
    // FR: Le brocoli un peu trop monté devient un pesto doux, à jeter en cube dans des pâtes chaudes.
    description: 'El brócoli que se ha espigado un poco se convierte en un pesto suave, para echar en cubitos a la pasta caliente.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '500 g de brócoli (ramilletes y tallos pelados)', // FR: 500 g de brocoli (fleurettes et tiges pelées)
      '50 g de almendras', // FR: 50 g d'amandes
      '1 diente de ajo', // FR: 1 gousse d'ail
      '12 cl de aceite de oliva', // FR: 12 cl d'huile d'olive
      'el zumo de medio limón', // FR: le jus d'un demi-citron
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Cuis les fleurettes et les tiges en morceaux 3 minutes à l'eau bouillante salée.
      'Cuece los ramilletes y los tallos en trozos 3 minutos en agua salada hirviendo.',
      // FR: Refroidis-les dans l'eau glacée, puis égoutte et presse-les bien dans un torchon.
      'Enfríalos en agua helada, escúrrelos y exprímelos bien con un paño.',
      // FR: Mixe brocoli, amandes, ail et citron par à-coups, en versant l'huile en filet. **Pas de parmesan** : tu le râperas au moment de servir.
      'Tritura el brócoli, las almendras, el ajo y el limón a golpes cortos, echando el aceite a hilo. **Sin parmesano**: lo rallarás al servir.',
      // FR: Sale légèrement et goûte : le froid estompe un peu le sel.
      'Sala ligeramente y prueba: el frío atenúa un poco la sal.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile pour éviter qu'il noircisse.
      'Llena una cubitera y cubre cada hueco con un chorrito de aceite para que no se ennegrezca.',
      // FR: Démoule les cubes une fois durs, au bout de 4 heures, et garde-les en sac daté.
      'Desmolda los cubos cuando estén duros, a las 4 horas, y guárdalos en una bolsa con fecha.',
    ],
  ),
  'brocoli/Pickles de tiges de brocoli': RecipeText(
    // FR: Pickles de tiges de brocoli
    name: 'Encurtido de tallos de brócoli',
    // FR: Les grosses tiges qu'on jette souvent deviennent des bâtonnets croquants pour l'apéro.
    description: 'Los tallos gruesos que tantas veces se tiran se convierten en bastones crujientes para el aperitivo.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '500 g de tallos de brócoli', // FR: 500 g de tiges de brocoli
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 20 g de azúcar', // FR: 10 g de sel, 20 g de sucre
      '1 diente de ajo, 1 cucharadita de semillas de mostaza', // FR: 1 gousse d'ail, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Pèle les tiges à l'économe jusqu'à la chair vert pâle, puis coupe-les en bâtonnets de la taille d'un doigt.
      'Pela los tallos con el pelador hasta llegar a la carne verde pálido y córtalos en bastones del grosor de un dedo.',
      // FR: Range-les debout et serrés dans deux bocaux ébouillantés, avec l'ail coupé en deux et la moutarde.
      'Colócalos de pie y apretados en dos tarros escaldados, con el ajo partido por la mitad y la mostaza.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre, et remue jusqu'à ce qu'ils fondent.
      'Lleva a ebullición el vinagre, el agua, la sal y el azúcar, y remueve hasta que se disuelvan.',
      // FR: Verse le liquide bouillant jusqu'à **recouvrir entièrement** les bâtonnets, à 1 cm du bord, et ferme.
      'Vierte el líquido hirviendo hasta **cubrir por completo** los bastones, a 1 cm del borde, y cierra.',
      // FR: Laisse refroidir puis mets au réfrigérateur. Attends **3 jours** avant d'ouvrir : le vinaigre doit pénétrer jusqu'au cœur.
      'Deja enfriar y pasa a la nevera. Espera **3 días** antes de abrir: el vinagre tiene que penetrar hasta el centro.',
    ],
  ),
  'brocoli/Brocolis sautés à l\'ail': RecipeText(
    // FR: Brocolis sautés à l'ail
    name: 'Brócoli salteado con ajo',
    // FR: Blanchis puis saisis, piment et sésame.
    description: 'Escaldado y luego salteado, con guindilla y sésamo.',
  ),
  'brocoli/Velouté de brocoli': RecipeText(
    // FR: Velouté de brocoli
    name: 'Crema de brócoli',
    // FR: Vert franc si tu le mixes à peine cuit.
    description: 'De un verde intenso si lo trituras apenas cocido.',
  ),
  'brocoli/Brocolis au four, parmesan et citron': RecipeText(
    // FR: Brocolis au four, parmesan et citron
    name: 'Brócoli al horno con parmesano y limón',
    // FR: Les pointes qui grillent sont les meilleures.
    description: 'Las puntas que se tuestan son las mejores.',
  ),

  // ─────────── camomille (6 recettes) ───────────
  'camomille/Capitules de camomille séchés à l\'ombre': RecipeText(
    // FR: Capitules de camomille séchés à l'ombre
    name: 'Flores de manzanilla secadas a la sombra',
    // FR: Les petites fleurs sèchent en une semaine et te donnent des infusions pour toute l'année.
    description: 'Las florecillas se secan en una semana y te dan infusiones para todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      'flores de manzanilla romana bien abiertas', // FR: des capitules de camomille romaine bien ouverts
      'una rejilla, un tamiz o un paño', // FR: une claie, un tamis ou un torchon
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille les fleurs par temps sec, en fin de matinée, quand elles sont **juste épanouies**. Coupe sous la tête, sans tige.
      'Recoge las flores en tiempo seco, a media mañana, cuando estén **recién abiertas**. Corta bajo la cabezuela, sin tallo.',
      // FR: Ne les lave pas. Étale-les en une seule couche sur la claie.
      'No las laves. Extiéndelas en una sola capa sobre la rejilla.',
      // FR: Laisse-les une semaine à l'ombre, dans une pièce sèche et aérée, en les retournant chaque jour.
      'Déjalas una semana a la sombra, en una habitación seca y ventilada, dándoles la vuelta cada día.',
      // FR: Elles sont prêtes quand le cœur jaune s'effrite entre tes doigts.
      'Están listas cuando el centro amarillo se desmenuza entre los dedos.',
      // FR: Mets-les en bocal bien fermé. La romaine est amère : trois ou quatre capitules suffisent pour une tasse.
      'Guárdalas en un tarro bien cerrado. La romana es amarga: con tres o cuatro flores basta para una taza.',
    ],
  ),
  'camomille/Gelée de camomille à la pomme': RecipeText(
    // FR: Gelée de camomille à la pomme
    name: 'Gelatina de manzanilla y manzana',
    // FR: Le jus de pomme fait la gelée, la camomille lui donne un parfum de miel et de foin.
    description: 'El zumo de manzana hace la gelatina; la manzanilla le da un aroma a miel y a heno.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '1 litro de zumo de manzana puro', // FR: 1 litre de pur jus de pomme
      '2 puñados de flores de manzanilla (o 15 g secas)', // FR: 2 poignées de capitules de camomille (ou 15 g séchés)
      'el zumo de un limón', // FR: le jus d'un citron
      '800 g de azúcar', // FR: 800 g de sucre
      '1 sobre de pectina por cada 1 kg de fruta', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Fais chauffer le jus de pomme jusqu'aux premiers frémissements, puis coupe le feu.
      'Calienta el zumo de manzana hasta los primeros hervores y apaga el fuego.',
      // FR: Jette les capitules dedans, couvre et laisse infuser **10 minutes seulement** : plus longtemps, la romaine devient amère.
      'Echa las flores dentro, tapa y deja infusionar **solo 10 minutos**: más tiempo, y la romana amarga.',
      // FR: Filtre dans une passoire fine et presse les fleurs.
      'Filtra con un colador fino y presiona las flores.',
      // FR: Ajoute le citron et la pectine mélangée à un peu de sucre, porte à ébullition, puis verse le reste du sucre.
      'Añade el limón y la pectina mezclada con un poco de azúcar, lleva a ebullición y luego echa el resto del azúcar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Hierve a borbotones removiendo, según indique el sobre de pectina.',
      // FR: Mets en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pasa a tarros calientes y escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'camomille/Glaçons d\'infusion de camomille': RecipeText(
    // FR: Glaçons d'infusion de camomille
    name: 'Cubitos de infusión de manzanilla',
    // FR: Avec les fleurs fraîches du jour : des cubes à jeter dans une citronnade ou une infusion glacée.
    description: 'Con las flores frescas del día: cubos para echar en una limonada o en una infusión fría.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      'un puñadito de flores frescas', // FR: une petite poignée de capitules frais
      '50 cl de agua', // FR: 50 cl d'eau
      'dos cubiteras', // FR: deux bacs à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Porte l'eau à frémissement, verse-la sur les fleurs et couvre.
      'Lleva el agua a un hervor suave, viértela sobre las flores y tapa.',
      // FR: Laisse infuser 5 minutes, pas plus : c'est déjà bien parfumé, et bien amer au-delà.
      'Deja infusionar 5 minutos, no más: ya queda bien aromática, y muy amarga si te pasas.',
      // FR: Filtre et garde deux ou trois fleurs pour les mettre dans les cubes.
      'Filtra y guarda dos o tres flores para ponerlas en los cubitos.',
      // FR: Refroidis l'infusion vite, casserole posée dans l'eau froide.
      'Enfría la infusión rápido, con la olla metida en agua fría.',
      // FR: Remplis les bacs, pose une fleur dans quelques cases et congèle. Démoule ensuite en sac fermé.
      'Llena las cubiteras, pon una flor en algunos huecos y congela. Desmolda después en una bolsa cerrada.',
    ],
  ),
  'camomille/Infusion de camomille': RecipeText(
    // FR: Infusion de camomille
    name: 'Infusión de manzanilla',
    // FR: Les capitules séchés à l'ombre, une cuillère par tasse.
    description: 'Las flores secadas a la sombra, una cucharada por taza.',
  ),
  'camomille/Sirop de camomille': RecipeText(
    // FR: Sirop de camomille
    name: 'Sirope de manzanilla',
    // FR: Infusé fort puis sucré, sur une salade de fruits.
    description: 'Infusionado fuerte y luego azucarado, sobre una macedonia.',
  ),
  'camomille/Crème brûlée à la camomille': RecipeText(
    // FR: Crème brûlée à la camomille
    name: 'Crema quemada de manzanilla',
    // FR: Infusée dans la crème chaude, filtrée avant de cuire.
    description: 'Infusionada en la nata caliente y filtrada antes de hornear.',
  ),

  // ─────────── capucine (6 recettes) ───────────
  'capucine/Pickles de graines vertes de capucine': RecipeText(
    // FR: Pickles de graines vertes de capucine
    name: 'Encurtido de semillas verdes de capuchina',
    // FR: Les graines encore vertes deviennent de petites billes piquantes à la façon des câpres.
    description: 'Las semillas todavía verdes se convierten en bolitas picantes, al estilo de las alcaparras.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '200 g de semillas verdes de capuchina', // FR: 200 g de graines vertes de capucine
      '1 litro de agua y 50 g de sal', // FR: 1 litre d'eau et 50 g de sel
      '25 cl de vinagre blanco o de sidra al 6 % mínimo', // FR: 25 cl de vinaigre blanc ou de cidre à 6 % minimum
      '1 hoja de laurel, unos granos de pimienta', // FR: 1 feuille de laurier, quelques grains de poivre
      '3 tarritos limpios', // FR: 3 petits pots propres
    ],
    steps: <String>[
      // FR: Cueille les graines quand elles sont **vertes et tendres** : un ongle doit s'y enfoncer. Sépare les trios.
      'Recoge las semillas cuando estén **verdes y tiernas**: una uña debe poder hundirse en ellas. Separa los grupos de tres.',
      // FR: Rince-les à l'eau froide et égoutte.
      'Enjuágalas con agua fría y escúrrelas.',
      // FR: Fais-les tremper 24 heures dans l'eau salée : le sel adoucit leur piquant et les raffermit.
      'Déjalas en remojo 24 horas en agua salada: la sal suaviza su picor y las reafirma.',
      // FR: Égoutte, rince et répartis-les dans les pots avec le poivre et un morceau de laurier.
      'Escurre, enjuaga y reparte en los tarros con la pimienta y un trozo de laurel.',
      // FR: Porte le vinaigre pur à ébullition.
      'Lleva el vinagre puro a ebullición.',
      // FR: Verse-le bouillant sur les graines pour les **couvrir entièrement**, ferme aussitôt.
      'Viértelo hirviendo sobre las semillas para **cubrirlas del todo** y cierra enseguida.',
      // FR: Une fois froids, range les pots au réfrigérateur et attends un mois avant d'y goûter.
      'Cuando estén fríos, guarda los tarros en la nevera y espera un mes antes de probarlas.',
    ],
  ),
  'capucine/Pesto de feuilles de capucine': RecipeText(
    // FR: Pesto de feuilles de capucine
    name: 'Pesto de hojas de capuchina',
    // FR: Les feuilles ont un piquant de cresson : en pesto congelé, elles relèvent des pâtes en plein hiver.
    description: 'Las hojas tienen un picante de berro: en pesto congelado, alegran la pasta en pleno invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '150 g de hojas tiernas de capuchina', // FR: 150 g de jeunes feuilles de capucine
      '50 g de nueces peladas', // FR: 50 g de cerneaux de noix
      '1 diente de ajo', // FR: 1 gousse d'ail
      '12 cl de aceite de oliva', // FR: 12 cl d'huile d'olive
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles, retire les tiges et **sèche-les bien** : de l'eau ferait tourner le pesto.
      'Lava las hojas, quita los tallos y **sécalas bien**: el agua haría que el pesto se cortara.',
      // FR: Mixe les feuilles, les noix et l'ail par à-coups pour ne pas chauffer la verdure.
      'Tritura las hojas, las nueces y el ajo a golpes cortos para que no se caliente lo verde.',
      // FR: Verse l'huile en filet en mixant, puis sale. Garde le fromage pour le moment de servir.
      'Echa el aceite a hilo mientras trituras y luego sala. Guarda el queso para el momento de servir.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile.
      'Llena una cubitera y cubre cada hueco con un chorrito de aceite.',
      // FR: Démoule les cubes une fois durs et garde-les en sac fermé. Un cube par assiette de pâtes.
      'Desmolda los cubos cuando estén duros y guárdalos en una bolsa cerrada. Un cubo por plato de pasta.',
    ],
  ),
  'capucine/Vinaigre rouge aux fleurs de capucine': RecipeText(
    // FR: Vinaigre rouge aux fleurs de capucine
    name: 'Vinagre rojo con flores de capuchina',
    // FR: Les fleurs orange donnent un vinaigre poivré et cuivré, superbe sur une salade de tomates.
    description: 'Las flores naranjas dan un vinagre picante y cobrizo, estupendo en una ensalada de tomate.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '40 flores de capuchina', // FR: 40 fleurs de capucine
      '1 diente de ajo pelado', // FR: 1 gousse d'ail pelée
      '50 cl de vinagre de vino tinto al 6 % mínimo', // FR: 50 cl de vinaigre de vin rouge à 6 % minimum
      'un tarro limpio', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Cueille les fleurs bien ouvertes, le matin, sans traitement. Regarde dans l'éperon : il abrite parfois un insecte.
      'Recoge las flores bien abiertas, por la mañana y sin tratar. Mira dentro del espolón: a veces hay un insecto.',
      // FR: Mets-les dans le bocal avec l'ail coupé en deux.
      'Ponlas en el tarro con el ajo partido por la mitad.',
      // FR: Couvre de vinaigre pur jusqu'en haut : tout doit être **sous le liquide**.
      'Cubre con vinagre puro hasta arriba: todo debe quedar **bajo el líquido**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps.
      'Cierra y deja infusionar dos semanas a la sombra, agitando de vez en cuando.',
      // FR: Filtre dans une bouteille propre et jette fleurs et ail : on ne les laisse pas indéfiniment.
      'Filtra a una botella limpia y tira las flores y el ajo: no se dejan indefinidamente.',
    ],
  ),
  'capucine/Salade aux fleurs de capucine': RecipeText(
    // FR: Salade aux fleurs de capucine
    name: 'Ensalada con flores de capuchina',
    // FR: Poivrées comme du cresson, et très belles dans l'assiette.
    description: 'Picantes como el berro, y muy bonitas en el plato.',
  ),
  'capucine/Câpres de capucine': RecipeText(
    // FR: Câpres de capucine
    name: 'Alcaparras de capuchina',
    // FR: Les boutons floraux au vinaigre remplacent les vraies câpres.
    description: 'Los botones florales en vinagre sustituyen a las alcaparras de verdad.',
  ),
  'capucine/Beurre de capucine': RecipeText(
    // FR: Beurre de capucine
    name: 'Mantequilla de capuchina',
    // FR: Pétales hachés dans du beurre pommade.
    description: 'Pétalos picados en mantequilla blanda, en punto pomada.',
  ),
};
